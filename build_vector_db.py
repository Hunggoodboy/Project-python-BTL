import google.generativeai as genai
import numpy as np
import faiss
import json
import os
import chromadb
import sys  # Thêm sys để in lỗi rõ hơn

# --- 1. KẾT NỐI DATABASE ---
from database.connect import get_connect

# --- 2. CẤU HÌNH AI (CHO VIỆC EMBEDDING) ---
API_KEY = "AIzaSyAvIRfabil8y_PsdzSGa9Kx2K2u0a-RtC4"
genai.configure(api_key=API_KEY)
embed_model = genai.GenerativeModel('models/text-embedding-004')

# --- SỬA LỖI: BẬT LẠI KHỐI DỌN DẸP ---
client = chromadb.PersistentClient(path="./my_vector_db")

try:
    print(">>> Đang dọn dẹp collection 'products' cũ (nếu có)...")
    collection = client.get_or_create_collection(name="products")
    print(">>> Đã dọn dẹp xong.")
except chromadb.errors.NotFoundError:  # <-- SỬA THÀNH 'NotFoundError'
    print(">>> Collection cũ không tồn tại, sẵn sàng tạo mới.")
except Exception as e:
    print(f"Lỗi lạ khi dọn dẹp: {e}")

print(">>> Đang tạo collection 'products' mới...")

print(">>> Đã cấu hình model embedding <<<")


# --- 3. HÀM LẤY DỮ LIỆU (ĐÃ SỬA SQL VÀ LOGIC) ---
def get_all_products_as_text():
    """
    Truy vấn TẤT CẢ sản phẩm (đã JOIN) và biến chúng thành các đoạn văn bản.
    """
    print(">>> Đang kết nối MySQL để lấy sản phẩm...")
    conn = None
    product_texts = []  # Danh sách các đoạn text
    product_ids = []  # Map tra cứu (index -> text)
    product_metadata = []
    try:
        conn = get_connect()
        # Dùng dictionary=True để lấy kết quả dạng {"TenCot": "GiaTri"}
        cursor = conn.cursor(dictionary=True)

        # --- CÂU SQL GROUP_CONCAT CHÍNH XÁC ---
        sql = """
              SELECT sp.*, -- Lấy tất cả cột từ SanPham  
                     dm.TenDM,
                     men_sizes.AllMenSizes,
                     women_sizes.AllWomenSizes
              FROM QLBanQuanAo.SanPham sp
                       LEFT JOIN
                   QLBanQuanAo.DanhMuc dm ON sp.MaDM = dm.MaDM
                       LEFT JOIN (SELECT sp_inner.MaSP,
                                         GROUP_CONCAT(DISTINCT sizeman.MaSize SEPARATOR ', ') AS AllMenSizes 
                                  FROM QLBanQuanAo.SanPham sp_inner 
                                           JOIN 
                                       QLBanQuanAo.SizeDanOng sizeman 
                                       ON CONCAT(' ', sp_inner.Size, ' ') LIKE CONCAT(' %', sizeman.MaSize, ' %') 
                                  GROUP BY sp_inner.MaSP) AS men_sizes ON sp.MaSP = men_sizes.MaSP
                       LEFT JOIN (SELECT sp_inner.MaSP, 
                                         GROUP_CONCAT(DISTINCT sizewoman.MaSize SEPARATOR ', ') AS AllWomenSizes 
                                  FROM QLBanQuanAo.SanPham sp_inner 
                                           JOIN 
                                       QLBanQuanAo.SizePhuNu sizewoman 
                                       ON CONCAT(' ', sp_inner.Size, ' ') LIKE CONCAT(' %', sizewoman.MaSize, ' %') 
                                  GROUP BY sp_inner.MaSP) AS women_sizes ON sp.MaSP = women_sizes.MaSP; 
              """

        cursor.execute(sql)
        products = cursor.fetchall()

        for idx, product in enumerate(products):
            text_parts = [
                f"Tên sản phẩm: {product.get('TenSP')}",
                f"Danh mục: {product.get('TenDM')}",
                f"Mô tả: {product.get('MoTa')}",
                f"Chất liệu: {product.get('ChatLieu')}",
                f"Những màu sắc: {product.get('MauSac')}",
                f"Các size: {product.get('Size')}",
                f"Số lượng còn lại : {product.get('SoLuongcon')}",
                f"Giá được giảm : {product.get('Discount')}",
                f"Ngày nhập hàng : {product.get('NgayNhap')}%",
            ]
            if product.get('Gia') is not None:
                text_parts.append(f"Giá bán: {product.get('Gia')}")
            if product.get('Season'):
                text_parts.append(f"Phù hợp cho mùa: {product.get('Season')}")
            else:
                text_parts.append("Phù hợp quanh năm")
            if product.get('AllMenSizes'):
                text_parts.append(f"Size của đàn ông hiện có : {product.get('AllMenSizes')}")
            if product.get('AllWomenSizes'):
                text_parts.append(f"Size của phụ nữ hiện có : {product.get('AllWomenSizes')}")
            text_document = "\n".join(text_parts)
            product_texts.append(text_document)

            gia_val = product.get('Gia')
            season_val = product.get('Season')
            discount_val = product.get('Discount')
            soluong_val = product.get('SoLuongcon')

            masp_val = product.get('MaSP')
            metadata = {
                "MaSP": str(masp_val or "0"),
                "TenSP": str(product.get('TenSP') or ""),
                "TenDM": str(product.get('TenDM') or ""),
                "MoTa": str(product.get('MoTa') or ""),
                "Gia": float(gia_val or 0.0),
                "Season": str(season_val or ""),
                "ChatLieu": str(product.get('ChatLieu') or ""),
                "Discount": int(discount_val or 0),
                "Size": str(product.get('Size') or ""),
                "SoLuongCon": int(soluong_val or 0),
            }
            product_metadata.append(metadata)

            product_ids.append(str(masp_val or idx))

        print("Đã tạo văn bản và metadata")

        print(">>> Đang gọi API Google để tạo embedding thật...")
        embeddings = []
        for text in product_texts:
            result = genai.embed_content(
                model='models/text-embedding-004',
                content=text,
                task_type="RETRIEVAL_DOCUMENT"
            )
            embeddings.append(result['embedding'])
        print("Đã thu thập embedding")
        # for embed in embeddings:
        #     print(embed)
        collection.add(
            embeddings=embeddings,
            metadatas=product_metadata,
            ids=product_ids,
            documents=product_texts
        )

        data_get = collection.get(include=["metadatas", "documents", "embeddings"])
        embed = data_get['embeddings']
        metadata = data_get['metadatas']
        product_text = data_get['documents']
        print("ĐÃ XÂY DỰNG VECTOR DB THÀNH CÔNG!")

    except chromadb.errors.DuplicateIDError as e:
        print("\n\n❌ LỖI NGHIÊM TRỌNG: TRÙNG LẶP ID (DuplicateIdError) ❌", file=sys.stderr)
        print(f"Chi tiết: {e}", file=sys.stderr)
        print("Vui lòng kiểm tra lại logic tạo 'product_ids'", file=sys.stderr)

    except Exception as e:
        print(f"\n\n❌ LỖI KHI TRUY VẤN SẢN PHẨM (BỊ CRASH): {e} ❌", file=sys.stderr)
        print("Script đã dừng lại TRƯỚC KHI collection.add() hoàn tất.", file=sys.stderr)

    finally:
        if conn:
            conn.close()
            print(">>> Đã đóng kết nối MySQL <<<")


if __name__ == "__main__":
    get_all_products_as_text()