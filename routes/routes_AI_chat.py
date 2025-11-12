import chromadb
from flask import Blueprint, request, jsonify, render_template
import google.generativeai as genai
import os
import re
# Giả sử file connect.py nằm trong thư mục 'database' (nếu có)
# from database.connect import get_connect

from google.generativeai.types import FunctionDeclaration, Tool

# --- 1. CẤU HÌNH AI ---
# (SỬA LẠI KEY CỦA BẠN NẾU CẦN)
YOUR_API_KEY = "AIzaSyCSuEwJLCPGYhpJC4pHrlqw-ylt3UUIio8"
try:
    genai.configure(api_key=YOUR_API_KEY)
except Exception as e:
    print(f"LỖI CẤU HÌNH API KEY: {e}")

# --- 2. KẾT NỐI VECTOR DB (CHROMA) ---
try:
    client = chromadb.PersistentClient(path="./my_vector_db")
    collection = client.get_or_create_collection(name="products")
    print(">>> ĐÃ KẾT NỐI CHROMA DB THÀNH CÔNG! <<<")
except Exception as e:
    print(f"LỖI KẾT NỐI CHROMA DB: {e}")


# --- 3. SỬA LẠI HÀM PYTHON ĐỂ KHỚP VỚI TOOL ---
# Tên các tham số của hàm Python PHẢI TRÙNG KHỚP
# với tên bạn định nghĩa trong FunctionDeclaration (ở Bước 4)
def search_products(query_sanpham: str, season: str = None, min_price: float = None, max_price: float = None,
                    category: str = None):
    print(
        f"[Tool Call] AI đang tìm kiếm: query='{query_sanpham}', season='{season}', min={min_price}, max={max_price}, category='{category}'")

    try:
        # 1. Embed câu truy vấn chính
        result = genai.embed_content(
            model='models/text-embedding-004',
            content=query_sanpham,
            task_type="RETRIEVAL_QUERY"  # Quan trọng: nói cho AI biết đây là CÂU HỎI
        )
        query_vector = result['embedding']

        # 2. Xây dựng bộ lọc 'where' cho ChromaDB
        filters = {}
        price_filter = {}

        if min_price:
            price_filter["$gte"] = min_price  # gte = greater than or equal
        if max_price:
            price_filter["$lte"] = max_price  # lte = less than or equal

        if price_filter:
            filters["Gia"] = price_filter

        if season:
            # Tool của bạn yêu cầu AI dịch sang tiếng Anh,
            # nên ta giả định cột 'Season' trong DB cũng lưu tiếng Anh
            filters["Season"] = season

        if category:
            # Dùng regex để tìm không phân biệt hoa thường
            filters["TenDM"] = {"$regex": category, "$options": "i"}

        print(f"[Tool Call] Bộ lọc ChromaDB: {filters}")

        # 3. Truy vấn ChromaDB
        results = collection.query(
            query_embeddings=query_vector,
            n_results=5,  # Lấy 5 kết quả gần nhất
            where=filters if filters else None
        )

        # 4. Trả về kết quả (chỉ metadata) cho AI
        # AI sẽ dùng danh sách này để trả lời người dùng
        if not results['metadatas']:
            return "Không tìm thấy sản phẩm nào phù hợp với mô tả."

        return results['metadatas']  # Trả về list[dict]

    except Exception as e:
        print(f"[Tool Call] Lỗi khi đang tìm kiếm: {e}")
        return {"error": f"Lỗi khi tìm kiếm: {e}"}


# --- 4. ĐỊNH NGHĨA TOOL CHO AI (SỬA LẠI CHO KHỚP) ---
search_products_tool = FunctionDeclaration(
    name="search_products",  # PHẢI TRÙNG TÊN HÀM PYTHON (def search_products)
    description="Tìm kiếm sản phẩm trong shop theo tên, mô tả, danh mục, mùa, và khoảng giá.",
    parameters={
        "type": "OBJECT",  # Phải là "OBJECT"
        "properties": {
            # Tên các thuộc tính này PHẢI TRÙNG TÊN THAM SỐ của hàm Python
            "query_sanpham": {
                "type": "STRING",
                "description": "Nội dung/mô tả sản phẩm người dùng muốn tìm. Ví dụ: 'Áo khoác nam màu đen', 'Quần jean rách gối'"
            },
            "season": {
                "type": "STRING",
                "description": "Tìm theo mùa. Phải dịch sang tiếng Anh. Ví dụ: 'mùa đông' -> 'Winter', 'mùa hè' -> 'Summer', 'mùa thu' -> 'Autumn', 'mùa xuân' -> 'Spring'"
            },
            "category": {
                "type": "STRING",
                "description": "Tìm theo danh mục. Ví dụ: 'Áo', 'Quần', 'Áo khoác'"
            },
            "min_price": {
                "type": "NUMBER",  # Phải là "NUMBER"
                "description": "Giá thấp nhất (số nguyên). Ví dụ: 150000"
            },
            "max_price": {
                "type": "NUMBER",
                "description": "Giá cao nhất (số nguyên). Ví dụ: 500000"
            }
        },
        "required": ["query_sanpham"]  # Báo cho AI biết query_sanpham là bắt buộc
    }
)

# --- 5. CẤU HÌNH MODEL VỚI TOOL ---
# Đưa tool vào model
# (Sửa tên model nếu bạn muốn dùng 'gemini-pro' hay 'gemini-1.5-pro-latest')
try:
    model = genai.GenerativeModel(
        model_name='models/gemini-2.5-flash',
        tools=Tool(function_declarations=[search_products_tool])
    )
    print(">>> ĐÃ NẠP TOOL 'search_products' VÀO MODEL <<<")
except Exception as e:
    print(f"LỖI KHI NẠP TOOL VÀO MODEL: {e}")

# --- 6. KHỞI TẠO BLUEPRINT VÀ QUẢN LÝ SESSION ---
AI_chatbp = Blueprint('AI_chatbp', __name__, )

# Tool Calling là một cuộc hội thoại (chat) nhiều lượt
# Chúng ta cần lưu trữ lịch sử chat cho mỗi người dùng
chat_sessions = {}  # Dùng dict đơn giản để lưu session


# --- 7. ROUTE TRANG TEST (GIỮ NGUYÊN) ---
@AI_chatbp.route('/test-ai')
def test_ai_page():
    return render_template('test_ai.html')


# --- 8. ROUTE XỬ LÝ CHAT (SỬA LẠI HOÀN TOÀN) ---
@AI_chatbp.route('/api/chat-real', methods=['POST'])
def real_chat():
    global model, chat_sessions
    if model is None:
        return jsonify({'reply': 'Lỗi: Mô hình AI chưa được cấu hình.'}), 500

    try:
        data = request.json
        user_message = data.get('message')
        # Bạn nên gửi 'session_id' từ client (JS) để phân biệt các user
        session_id = data.get('session_id', 'default_session')

        if not user_message:
            return jsonify({'reply': 'Bạn chưa hỏi gì cả.'})

        # Lấy hoặc tạo mới chat session cho user
        if session_id not in chat_sessions:
            print(f"Tạo session mới: {session_id}")
            # Bổ sung Hướng dẫn Hệ thống (System Instruction)
            system_instruction = """Bạn là 'Bot', trợ lý AI bán hàng của 'Shop Nhóm 3'. 
Nhiệm vụ của bạn là tư vấn sản phẩm cho khách.
- Hãy luôn thân thiện, chuyên nghiệp và nói tiếng Việt.
- Khi khách hỏi về sản phẩm (ví dụ: tìm áo, quần, giá cả, mùa...), hãy SỬ DỤNG tool 'search_products' để tìm kiếm trong cơ sở dữ liệu.
- Khi gọi tool, hãy dịch các mùa (xuân, hạ, thu, đông) sang tiếng Anh (Spring, Summer, Autumn, Winter) như tool yêu cầu.
- Dựa vào kết quả JSON từ tool, tư vấn cho khách. Nếu không tìm thấy, hãy nói thật là không tìm thấy.
- Nếu kết quxả là một danh sách sản phẩm, hãy tóm tắt chúng (Tên, Giá, Mô tả ngắn).
- Không bịa đặt thông tin sản phẩm.
- Nếu khách hỏi ngoài lề (ví dụ: 'thủ đô Việt Nam là gì?'), hãy từ chối lịch sự và nói rằng bạn chỉ là trợ lý của shop.
"""
            chat_sessions[session_id] = model.start_chat(
                history=[],
                system_instruction=system_instruction
            )

        chat = chat_sessions[session_id]

        # 1. Gửi tin nhắn của user cho AI
        response = chat.send_message(user_message)

        # 2. KIỂM TRA XEM AI CÓ MUỐN GỌI TOOL KHÔNG
        # Dùng vòng lặp 'while' phòng trường hợp AI muốn gọi tool nhiều lần
        while response.candidates[0].function_calls:
            function_calls = response.candidates[0].function_calls

            print(f"[Flask] AI muốn gọi {len(function_calls)} tool(s).")

            # (Chúng ta chỉ có 1 tool, nhưng code này hỗ trợ nhiều)
            function_responses = []

            for call in function_calls:
                if call.name == "search_products":
                    try:
                        # Lấy arguments mà AI gửi
                        args = call.args
                        print(f"[Flask] Đang gọi tool 'search_products' với args: {args}")

                        # Gọi hàm Python thật (Bước 3)
                        results = search_products(
                            query_sanpham=args.get("query_sanpham"),
                            season=args.get("season"),
                            min_price=args.get("min_price"),
                            max_price=args.get("max_price"),
                            category=args.get("category")
                        )

                        # Gói kết quả (list metadata hoặc lỗi) trả về cho AI
                        function_responses.append({
                            "name": "search_products",
                            "response": results
                        })
                    except Exception as e:
                        print(f"Lỗi khi thực thi tool: {e}")
                        function_responses.append({
                            "name": "search_products",
                            "response": {"error": f"Lỗi server khi gọi tool: {e}"}
                        })

            # 3. Gửi kết quả từ tool TRỞ LẠI cho AI
            # AI sẽ dùng thông tin này để tạo ra câu trả lời cuối cùng
            print("[Flask] Gửi kết quả tool ngược lại cho AI...")
            response = chat.send_message(
                function_responses,
                role="function"  # Quan trọng: Báo đây là kết quả của function
            )

        # 4. TRẢ VỀ CÂU TRẢ LỜI CUỐI CÙNG
        # Sau khi xử lý xong tool (hoặc nếu AI không cần tool),
        # response.text sẽ là câu trả lời bằng ngôn ngữ tự nhiên
        return jsonify({'reply': response.text})

    except Exception as e:
        print(f"Lỗi nghiêm trọng tại /api/chat-real: {e}")
        return jsonify({'reply': f'Xin lỗi, AI đang bị lỗi: {e}'}), 500