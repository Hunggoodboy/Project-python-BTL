from flask import Blueprint, request, jsonify, render_template
import google.generativeai as genai
import os

# --- 1. IMPORT CÁCH KẾT NỐI CSDL CỦA BẠN ---
# Giả sử file connect.py nằm trong thư mục 'database'
# (Sửa lại đường dẫn nếu cần)
from database.connect import get_connect

# --- 2. CẤU HÌNH AI (GIỮ NGUYÊN) ---
YOUR_API_KEY = "AIzaSyCSuEwJLCPGYhpJC4pHrlqw-ylt3UUIio8"  # <-- Key của bạn
model = None
try:
    genai.configure(api_key=YOUR_API_KEY)
    # Đảm bảo dùng đúng tên model
    model = genai.GenerativeModel('models/gemini-2.5-flash')
    print(">>> ĐÃ CẤU HÌNH GOOGLE AI THÀNH CÔNG! <<<")
except Exception as e:
    print(f"LỖI CẤU HÌNH AI: {e}")

# --- 3. BLUEPRINT (GIỮ NGUYÊN) ---
AI_chatbp = Blueprint('AI_chatbp', __name__,)


# --- 4. ROUTE TRANG TEST (GIỮ NGUYÊN) ---
@AI_chatbp.route('/test-ai')
def test_ai_page():
    # 'test_ai.html' phải nằm trong thư mục 'templates'
    return render_template('test_ai.html')


# --- 5. ROUTE XỬ LÝ CHAT (ĐÃ SỬA DÙNG get_connect()) ---
@AI_chatbp.route('/api/chat-real', methods=['POST'])
def real_chat():
    global model
    if model is None:
        return jsonify({'reply': 'Lỗi: Mô hình AI chưa được cấu hình.'}), 500

    try:
        data = request.json
        user_message = data.get('message')
        user_message_lower = user_message.lower()

        if not user_message:
            return jsonify({'reply': 'Bạn chưa hỏi gì cả.'})

        context = "Bạn là trợ lý AI của 'Shop Nhóm 3'."

        conn = None
        cursor = None

        try:
            conn = get_connect()
            cursor = conn.cursor()
            if("bao nhiêu" in user_message_lower or "tổng" in user_message_lower):
                if ("quần" in user_message_lower):
                    # Dùng %s làm placeholder
                    sql = "SELECT COUNT(*) FROM QLBanQuanAo.SanPham WHERE MoTa LIKE %s"
                    search_term = "%quần%"

                    # Truyền tham số dưới dạng tuple
                    cursor.execute(sql, (search_term,))
                    product_count = cursor.fetchone()[0]

                    context += f" Thông tin từ CSDL: Shop hiện có {product_count} sản phẩm liên quan đến 'quần'."

                elif ("sản phẩm" in user_message_lower):
                    sql = "SELECT COUNT(*) FROM QLBanQuanAo.SanPham"
                    cursor.execute(sql)
                    product_count = cursor.fetchone()[0]

                    context += f" Thông tin từ CSDL: Shop hiện có tổng cộng {product_count} sản phẩm."
                elif("váy" in user_message_lower):
                    sql = "SELECT COUNT(*) FROM QLBanQuanAo.SanPham WHERE MoTa LIKE %s"
                    search_term = "%váy%"
                    cursor.execute(sql, (search_term,))
                    product_count = cursor.fetchone()[0]

                    context += f" Thông tin từ CSDL: Shop hiện có {product_count} sản phẩm liên quan đến 'váy'."
                elif ("áo" in user_message_lower):
                    sql = "SELECT COUNT(*) FROM QLBanQuanAo.SanPham WHERE MoTa LIKE %s"
                    search_term = "%áo%"
                    cursor.execute(sql, (search_term,))
                    product_count = cursor.fetchone()[0]

                    context += f" Thông tin từ CSDL: Shop hiện có {product_count} sản phẩm liên quan đến 'áo'."
                elif ("phụ kiện" in user_message_lower):
                    sql = "SELECT COUNT(*) FROM QLBanQuanAo.SanPham WHERE MoTa LIKE %s "
                    search_term = "%phụ kiện%"
                    cursor.execute(sql, (search_term,))
                    product_count = cursor.fetchone()[0]

                    context += f" Thông tin từ CSDL: Shop hiện có {product_count} sản phẩm liên quan đến 'phụ kiện'."
            # --- BLOCK 3 (GỢI Ý) ---
            elif "lạnh" in user_message_lower or "ấm" in user_message_lower or "đông" in user_message_lower:

                sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE Season Like %s"
                season = 'Winter'
                cursor.execute(sql, (season,))

                product_list = cursor.fetchall()
                if product_list:
                    context += f" Thông tin từ CSDL: Khi trời lạnh, shop có một số sản phẩm rất hợp như: "
                    product_names = [product[2] for product in product_list]
                    # product_link =
                    context += f" {', '.join(product_names)}. (LỆNH CHO AI: Trả lời khách, liệt kê CÁC SẢN PHẨM NÀY, mỗi sản phẩm 1 dòng, có gạch đầu dòng '*' ở trước.)"
                else:
                    context += " Thông tin từ CSDL: Shop tạm thời hết các mặt hàng giữ ấm."
            elif "nóng" in user_message_lower or "mát" in user_message_lower or "hè" in user_message_lower:

                sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE Season Like %s or Season is null"
                season = 'Summer'
                cursor.execute(sql, (season,))

                product_list = cursor.fetchall()
                if product_list:
                    context += f" Thông tin từ CSDL: Khi trời nóng, shop có một số sản phẩm rất hợp như: "
                    product_names = [product[2] for product in product_list]
                    # product_link =
                    context += f" {', '.join(product_names)}. (LỆNH CHO AI: Trả lời khách, liệt kê CÁC SẢN PHẨM NÀY, mỗi sản phẩm 1 dòng, có gạch đầu dòng '*' ở trước.)"
                else:
                    context += " Thông tin từ CSDL: Shop tạm thời hết các mặt hàng mát."
            elif "mới nhập" in user_message_lower or "thịnh hành" in user_message_lower or "new" in user_message_lower:
                sql = ("SELECT * FROM QLBanQuanAo.SanPham WHERE NgayNhap >= SUBDATE(CURDATE(), INTERVAL 30 DAY)")
                cursor.execute(sql)
                product_list = cursor.fetchall()

                if product_list:
                    context += f" Thông tin từ CSDL: Shop có một số sản phẩm mới về như: "
                    product_names = [product[2] for product in product_list]
                    # product_link =
                    context += f" {', '.join(product_names)}. (LỆNH CHO AI: Trả lời khách, liệt kê CÁC SẢN PHẨM NÀY, mỗi sản phẩm 1 dòng, có gạch đầu dòng '*' ở trước.)"
                else:
                    context += " Thông tin từ CSDL: Shop tạm thời hết các mặt hàng mát."
        except Exception as db_error:
            print(f"Lỗi truy vấn CSDL (Raw SQL): {db_error}")
            context += " (Đã xảy ra lỗi khi truy vấn CSDL.)"

        finally:
            # --- RẤT QUAN TRỌNG: LUÔN ĐÓNG KẾT NỐI ---
            if cursor:
                cursor.close()
            if conn:
                conn.close()

        # 6. Tạo câu lệnh cuối cùng cho AI (Prompt Engineering)
        final_prompt = f"""
        Nhiệm vụ: Bạn là trợ lý AI tên là 'Bot' của 'Shop Nhóm 3'. 
        Hãy trả lời câu hỏi của khách hàng một cách thân thiện, ngắn gọn và *CHỈ* dựa vào thông tin được cung cấp.

        --- BỐI CẢNH (DỮ LIỆU TỪ CSDL CỦA SHOP) ---
        {context}
        ---

        Câu hỏi của khách: "{user_message}"

        Trả lời:
        """

        # 7. Gửi câu lệnh ĐÃ CÓ BỐI CẢNH cho AI
        print(f"--- Đang gửi prompt tới AI: {final_prompt} ---")
        response = model.generate_content(final_prompt)

        return jsonify({'reply': response.text})

    except Exception as e:
        print(f"Lỗi khi gọi Google AI: {e}")
        return jsonify({'reply': 'Xin lỗi, AI đang bị lỗi. Vui lòng thử lại.'}), 500
