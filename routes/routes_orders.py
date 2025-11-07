from flask import Blueprint, render_template, session
from database.connect import get_connect
orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders')
def show_orders():

    conn = get_connect()
    cursor = conn.cursor(dictionary=True)

    user_id = session.get('id')

    sql = """
    SELECT a.*, b.TenSP, b.HinhAnh
    FROM QLBanQuanAo.DonHang a
    JOIN QLBanQuanAo.SanPham b 
    ON a.MaSP = b.MaSP
    WHERE a.MaKH = %s
    """

    cursor.execute(sql, (user_id,))
    dics = cursor.fetchall()

    orders = []
    for dic in dics:
        product = {
            "id": dic['MaDH'],
            "MaSP": dic['MaSP'],
            "TenSP": dic['TenSP'],
            "Gia": dic['TongGia'],        # ✅ sửa đúng tên cột
            "SoLuong": dic['SoLuong'],
            "TrangThai": dic['TrangThai'],
            "Mau": dic['Mau'],            # ✅ nên thêm nếu bạn có màu
            "HinhAnh": dic['HinhAnh']
        }
        orders.append(product)

    cursor.close()
    conn.close()

    return render_template('my_orders.html', orders=orders)

# Tạo đơn hàng khi khách nhấn đặt hàng
from flask import request, jsonify

@orders_bp.route('/create_order', methods=['POST'])
def create_order():
    try:
        if 'id' not in session:
            return jsonify({"success": False, "message": "Chưa đăng nhập"}), 401

        user_id = session['id']

        product_id = int(request.form.get('product_id'))
        quantity = int(request.form.get('quantity', 1))
        color = request.form.get('color', '')

        conn = get_connect()
        cursor = conn.cursor(dictionary=True)

        # Lấy thông tin sản phẩm
        cursor.execute("""
            SELECT TenSP, Gia, HinhAnh 
            FROM QLBanQuanAo.SanPham 
            WHERE MaSP = %s
        """, (product_id,))
        product = cursor.fetchone()

        if not product:
            return jsonify({"success": False, "message": "Sản phẩm không tồn tại"}), 404

        don_gia = product['Gia']
        tong_gia = don_gia * quantity

        # ✅ Insert đầy đủ trường đúng với bảng DonHang
        cursor.execute("""
            INSERT INTO QLBanQuanAo.DonHang (MaKH, MaSP, Mau, TrangThai, SoLuong, DonGia, TongGia)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (user_id, product_id, color, "Chờ xác nhận đơn", quantity, don_gia, tong_gia))

        conn.commit()

        order_id = cursor.lastrowid
        cursor.close()
        conn.close()

        # ✅ Trả về đúng chuẩn
        return jsonify({
            "success": True,
            "order": {
                "id": order_id,
                "MaSP": product_id,
                "TenSP": product['TenSP'],
                "Gia": don_gia,
                "TongGia": tong_gia,
                "SoLuong": quantity,
                "TrangThai": "Chờ xác nhận đơn",
                "HinhAnh": product['HinhAnh']
            }
        })

    except Exception as e:
        print("ERROR:", e)
        return jsonify({"success": False, "message": str(e)}), 500
