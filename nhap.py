import google.generativeai as genai
from google.generativeai.types import Tool
from flask import Blueprint, request, jsonify

# --- 1. ĐỊNH NGHĨA TOOLS (NẾU CẦN) ---
# (Giả sử search_products_tool đã được định nghĩa ở đây)
# ...

# --- 2. CẤU HÌNH MODEL (CHẠY 1 LẦN KHI START SERVER) ---
system_instruction_ = """Bạn là 'Bot', trợ lý AI bán hàng của 'Shop Nhóm 3'. 
Nhiệm vụ của bạn là tư vấn sản phẩm cho khách.
... (toàn bộ hướng dẫn của bạn) ...
"""

try:
    model = genai.GenerativeModel(
        model_name='models/gemini-2.5-flash',
        tools=Tool(function_declarations=[search_products_tool]),
        system_instruction=system_instruction_
    )
    print(">>> ĐÃ NẠP TOOL VÀ MODEL THÀNH CÔNG <<<")
except Exception as e:
    print(f"LỖI KHI NẠP TOOL VÀO MODEL: {e}")
    model = None  # Rất quan trọng: Báo hiệu model bị lỗi

# --- 3. KHỞI TẠO BỘ NHỚ CHAT (CHẠY 1 LẦN KHI START SERVER) ---
chat_sessions = {}  # Đây là dictionary để lưu các phiên chat

# --- 4. ĐỊNH NGHĨA BLUEPRINT/ROUTES ---
AI_chatbp = Blueprint('AI_chatbp', __name__)


@AI_chatbp.route('/api/chat-real', methods=['POST'])
def real_chat():
    # --- 5. LOGIC XỬ LÝ (CHẠY MỖI KHI CÓ REQUEST) ---

    # Kiểm tra xem model đã khởi tạo thành công ở bước 2 chưa
    if model is None:
        return jsonify({"error": "Lỗi máy chủ: Model AI chưa sẵn sàng."}), 500

    # Lấy dữ liệu từ client
    data = request.json
    session_id = data.get('session_id')
    user_message = data.get('message')

    if not session_id or not user_message:
        return jsonify({"error": "Thiếu session_id hoặc message"}), 400

    # Lấy hoặc tạo mới chat session (như đã bàn ở trước)
    if session_id not in chat_sessions:
        print(f"Tạo session mới: {session_id}")
        # Quan trọng: Dùng model toàn cục để bắt đầu chat
        chat_sessions[session_id] = model.start_chat(history=[])

    chat = chat_sessions[session_id]

    try:
        # Gửi tin nhắn và xử lý tool (bạn cần thêm logic xử lý tool ở đây)
        response = chat.send_message(user_message)

        # ... (thêm logic kiểm tra function call và gọi tool nếu cần) ...

        return jsonify({"reply": response.text})

    except Exception as e:
        print(f"Lỗi khi chat: {e}")
        return jsonify({"error": str(e)}), 500