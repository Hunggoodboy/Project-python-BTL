import chromadb

try:
    # Kết nối y hệt như file route của bạn
    client = chromadb.PersistentClient(path="../my_vector_db")
    collection = client.get_or_create_collection(name="products")
    print(">>> ĐÃ KẾT NỐI CHROMA DB THÀNH CÔNG! <<<\n")
except Exception as e:
    print(f"LỖI KẾT NỐI CHROMA DB: {e}")
    exit()  # Thoát nếu không kết nối được

print("--- KIỂM TRA DỮ LIỆU BÊN TRONG ---")

try:
    # Lấy TẤT CẢ dữ liệu
    # (Bạn đã sửa đúng chính tả 'metadatas')
    get_data = collection.get(include=["metadatas", "documents"])

    # Lấy danh sách metadata
    data_metadatas = get_data.get("metadatas")

    if not data_metadatas:
        print(">>> LỖI: Không tìm thấy dữ liệu (metadata) nào trong collection 'products'!")
    else:
        print(f"Tìm thấy tổng cộng {len(data_metadatas)} sản phẩm.")
        print("--- In ra metadata của từng sản phẩm: ---")

        # In ra từng metadata của sản phẩm
        for data_metada in data_metadatas:
            print(data_metada)

except Exception as e:
    print(f"LỖI KHI LẤY DỮ LIỆU: {e}")

print("\n--- KIỂM TRA XONG ---")