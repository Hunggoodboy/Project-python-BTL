import json

import chromadb
from flask import Blueprint, request, jsonify, render_template
import google.generativeai as genai

from google.generativeai.types import PartDict

from google.generativeai.types import Tool

from . import filters_tool_create

# --- 1. CẤU HÌNH AI ---
YOUR_API_KEY = "AIzaSyAvIRfabil8y_PsdzSGa9Kx2K2u0a-RtC4"

try:
    genai.configure(api_key=YOUR_API_KEY)
except Exception as e:
    print(f"LỖI CẤU HÌNH API KEY: {e}")

# --- 2. KẾT NỐI VECTOR DB (CHROMA) ---
client = chromadb.PersistentClient(path="./my_vector_db")
collection = client.get_or_create_collection(name="products")

print(">>> ĐÃ KẾT NỐI CHROMA DB THÀNH CÔNG! <<<")

system_instruction_ = """Bạn là 'Bot', trợ lý AI bán hàng của 'Shop Nhóm 3'. 
Nhiệm vụ của bạn là tư vấn sản phẩm cho khách.
- Hãy luôn thân thiện, chuyên nghiệp và nói tiếng Việt.
- Khi khách hỏi về sản phẩm (ví dụ: tìm áo, quần, giá cả, mùa...), hãy SỬ DỤNG tool 'search_products' để tìm kiếm trong cơ sở dữ liệu.
- Khi gọi tool, hãy dịch các mùa (xuân, hạ, thu, đông) sang tiếng Anh (Spring, Summer, Autumn, Winter) như tool yêu cầu.
- Dựa vào kết quả JSON từ tool, tư vấn cho khách. Nếu không tìm thấy, hãy nói thật là không tìm thấy.
- Nếu kết quả là một danh sách sản phẩm, hãy tóm tắt chúng (Tên, Giá, Mô tả ngắn).
- Nếu người dùng hỏi mà bạn đang hoang mang, cố gắng tìm từ đồng nghĩa và trả lời kết quả cho khách hàng.
- Không bịa đặt thông tin sản phẩm.
- Nếu khách hỏi ngoài lề (ví dụ: 'thủ đô Việt Nam là gì?'), hãy từ chối lịch sự và nói rằng bạn chỉ là trợ lý của shop.
"""

# --- 5. CẤU HÌNH MODEL VỚI TOOL ---
# Đưa tool vào model
try:
    model = genai.GenerativeModel(
        model_name='models/gemini-2.5-flash',
        tools=Tool(function_declarations=[filters_tool_create.search_products_tool]),
        system_instruction = system_instruction_
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


# --- 8. ROUTE XỬ LÝ CHAT ---
@AI_chatbp.route('/api/chat-real', methods=['POST'])
def real_chat():
    global model, chat_sessions
    if model is None:
        return jsonify({'reply': 'Lỗi: Mô hình AI chưa được cấu hình.'}), 500

    try:
        data = request.json
        user_message = data.get('message')
        session_id = data.get('session_id', 'default_session')

        if not user_message:
            return jsonify({'reply': 'Bạn chưa hỏi gì cả.'})

        if session_id not in chat_sessions:
            print(f"Tạo session mới: {session_id}")
            chat_sessions[session_id] = model.start_chat(history=[])
        chat = chat_sessions[session_id]

        # 1. Gửi tin nhắn của user cho AI
        print(f"[{session_id}] User: {user_message}")
        response = chat.send_message(content=user_message)

        # 2. KIỂM TRA XEM AI CÓ MUỐN GỌI TOOL KHÔNG
        while True:
            # Lấy các tool calls từ response
            tool_calls = []

            # response.parts là cách truy cập an toàn nhất
            if response.parts:
                #print("co response")
                for part in response.parts:
                    # Kiểm tra xem PartDict có function_call không
                    if hasattr(part, "function_call") and part.function_call:
                        tool_calls.append(part.function_call)
            # Nếu không có tool call, thoát vòng lặp, trả về text
            if not tool_calls:
                print("Khong co tool_calls")
                break

            # 3. THỰC THI TOOL CALLS
            print(f"[Flask] AI muốn gọi {len(tool_calls)} tool(s)." + "là" + str(tool_calls))

            function_responses = []  # (Tên biến này vẫn OK)
            for call in tool_calls:
                if call.name == "search_products":
                    try:
                        args = dict(call.args)  # Chuyển args sang dict
                        print(f"[Flask] Đang gọi tool 'search_products' với args: {args}")
                        print("qurry la")
                        print(args.get("query_sanpham"))
                        results = filters_tool_create.search_products(
                            query_Sanpham=args.get("query_sanpham"),
                            season=args.get("season"),
                            min_price=args.get("min_price"),
                            max_price=args.get("max_price"),
                            category=args.get("category")
                        )
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
                else:
                    # Xử lý trường hợp AI gọi tool lạ
                    print(f"Lỗi: AI gọi tool không xác định '{call.name}'")
                    function_responses.append({
                        "name": call.name,
                        "response": {"error": "Tool không tồn tại"}
                    })
            if function_responses :
                print("Co function_responses")
                print("function_responses la ")
                print(function_responses)
                print("het")
            else:
                print("none response")
            # 4. GỬI KẾT QUẢ TOOL TRỞ LẠI CHO AI
            print("[Flask] Gửi kết quả tool ngược lại cho AI...")
            tool_result_parts = []
            for r in function_responses:
                tool_result_parts.append({
                    "function_response": {
                        "name": r["name"],
                        "response": r["response"]
                    }
                })

            print("-----------------------")
            print(type(tool_result_parts))
            print(tool_result_parts)
            print(type(tool_result_parts[0]))
            print(tool_result_parts[0])
            if not tool_result_parts:
                print("[Flask] Lỗi: tool_result_parts bị rỗng, không gửi gì về AI.")
                response = chat.send_message(content="Lỗi hệ thống: Không thể xử lý kết quả tool.")

            else:
                # Nếu list KHÔNG rỗng, hãy gửi phần tử ĐẦU TIÊN
                response = chat.send_message(content=json.dumps(tool_result_parts[0], ensure_ascii=False))
            # Gửi list các PartDict này làm content

        # 5. TRẢ VỀ CÂU TRẢ LỜI CUỐI CÙNG
        if response.text:
            print(f"[{session_id}] AI: {response.text}")
            return jsonify({'reply': response.text})
        else:
            print(f"[{session_id}] Lỗi: AI không trả về text.")
            return jsonify({'reply': 'Xin lỗi, AI không thể xử lý yêu cầu này.'}), 500

    except Exception as e:
        print(f"Lỗi nghiêm trọng tại /api/chat-real: {e}")
        return jsonify({'reply': f'Xin lỗi, AI đang bị lỗi: {e}'}), 500