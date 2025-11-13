import chromadb
from flask import Blueprint, request, jsonify, render_template
import google.generativeai as genai
import os
import re

from google.ai.generativelanguage_v1 import Part
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
    client = chromadb.PersistentClient(path="../my_vector_db")
    collection = client.get_or_create_collection(name="products")
    print(">>> ĐÃ KẾT NỐI CHROMA DB THÀNH CÔNG! <<<")
except Exception as e:
    print(f"LỖI KẾT NỐI CHROMA DB: {e}")

# --- 3. SỬA LẠI HÀM PYTHON ĐỂ KHỚP VỚI TOOL ---
# Tên các tham số của hàm Python PHẢI TRÙNG KHỚP
# với tên bạn định nghĩa trong FunctionDeclaration (ở Bước 4)
def search_products(query_Sanpham: str, season: str = None, min_price: float = None, max_price: float = None,
                    category: str = None):
    print(
        f"[Tool Call] AI đang tìm kiếm: query='{query_Sanpham}', season='{season}', min={min_price}, max={max_price}, category='{category}'")
    print("số collection " + str(collection.count()))
    try:
        # 1. Embed câu truy vấn chính
        result = genai.embed_content(
            model='models/text-embedding-004',
            content=query_Sanpham,
            task_type="RETRIEVAL_QUERY"  # Quan trọng: nói cho AI biết đây là CÂU HỎI
        )
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
            filters["TenDM"] = {"$in": [category]}

        print(f"[Tool Call] Bộ lọc ChromaDB: {filters}")

        # 3. Truy vấn ChromaDB
        print(collection.count())
        results = collection.query(
            query_embeddings=query_vector,
            n_results=5,  # Lấy 5 kết quả gần nhất
            where=filters if filters else None
        )
        print(results)
        print(len(results['metadatas']))
        if not results['metadatas']:
            print("Không tìm thấy sản phẩm nào phù hợp với mô tả.")
            return "Không tìm thấy sản phẩm nào phù hợp với mô tả."
        else:
            print("co res")
            for res in results['metadatas'][0]:
                print("co res")
                print(res)
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


result = search_products("áo thun", None, None, None, "Áo Thun Cơ Bản")
print("Kết quả là :")
print(result)