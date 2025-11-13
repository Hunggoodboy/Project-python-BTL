import chromadb
import google.generativeai as genai


from google.generativeai.types import FunctionDeclaration, Tool
from sympy.strategies.branch import condition

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
def search_products(query_Sanpham: str, season: str = None, min_price: float = None, max_price: float = None, category: str = None,):
    print(
        f"[Tool Call] AI đang tìm kiếm: query='{query_Sanpham}', season='{season}', min={min_price}, max={max_price}, category='{category}'"
    )
    try:
        # 2. Xây dựng bộ lọc 'where' cho ChromaDB
        conditions = []
        price_filter = {}
        if min_price:
            price_filter["$gte"] = min_price  # gte = greater than or equal
        if max_price:
            price_filter["$lte"] = max_price  # lte = less than or equal

        if price_filter:
            conditions.append({"Gia" : price_filter})

        if season:
            conditions.append({"Season" : season})

        if category:
            conditions.append({"TenDM" : category})

        filters = {}
        print("Bắt đầu lọc filter")
        # 3. Truy vấn ChromaDB

        if len(conditions) > 1:
            filters["$and"] = conditions
        else :
            filters = conditions[0]

        result = genai.embed_content(
            model='models/text-embedding-004',
            content=query_Sanpham,
            task_type="RETRIEVAL_QUERY"
        )

        query_vector = result['embedding']

        results = collection.query(
            query_embeddings=query_vector,
            n_results=20,  # Lấy 5 kết quả gần nhất
            where=filters if filters else None
        )

        if not results['ids'] or not results['ids'][0]:
            return []
        if not results['metadatas']:
            print("Không tìm thấy sản phẩm nào phù hợp với mô tả.")
            return []
        else:
            for res in results['metadatas'][0]:
                print(res)
        return results['metadatas'][0]

    except Exception as e:
        print(f"[Tool Call] Lỗi khi đang tìm kiếm: {e}")
        return {"error": f"Lỗi khi tìm kiếm: {e}"}


# --- 4. ĐỊNH NGHĨA TOOL CHO AI (SỬA LẠI CHO KHỚP) ---
search_products_tool = FunctionDeclaration(
    name="search_products",  # TÊN HÀM PYTHON (def search_products)
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
                "description": (
                    "Tên danh mục CHÍNH XÁC trong cơ sở dữ liệu. "
                    "CHỈ được phép sử dụng MỘT trong các giá trị sau: "
                    "'Áo Thun Cơ Bản', 'Áo Sơ Mi', 'Áo Khoác', 'Áo Len', 'Áo Khoác Dày', "
                    "'Quần Jean', 'Quần Short', ... (thêm các danh mục của bạn từ CSDL vào đây)"
                    "\n--- QUY TẮC ÁNH XẠ ---"
                    "\n- Nếu người dùng hỏi 'áo thun', 'áo phông', 'áo T-shirt' hoặc các từ đồng nghĩa khác, BẮT BUỘC dùng: 'Áo Thun Cơ Bản'."
                    "\n- Nếu người dùng hỏi 'sơ mi' hoặc 'áo sơ mi', BẮT BUỘC dùng: 'Áo Sơ Mi'."
                    "\n- Nếu người dùng hỏi 'áo khoác' hoặc 'áo mùa đông' hoặc 'áo bomber', BẮT BUỘC dùng: 'Áo Khoác'."
                    "\n- Nếu người dùng hỏi 'áo len' hoặc 'áo khoác len', Bắt buộc dùng: 'Áo Len'."
                    "\n - Nếu người dùng hỏi 'phụ kiện' bắt buộc dùng: 'Túi & Ví'."
                    "\n- Nếu không rõ, hãy hỏi lại người dùng."
                    "\n- Nếu được hỏi về số lượng hàng, hãy lấy dữ liệu từ SoLuongCon"
                    "\n- Nếu được hỏi những sản phẩm tốt hoặc xịn hoặc giá cao, thì hãy lấy những sản phẩm có giá lớn hơn 500.000 vnd"
                )
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
