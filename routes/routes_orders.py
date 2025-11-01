from flask import Blueprint, render_template, session
from database.connect import get_connect
orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders')

def show_orders():

    conn = get_connect()
    cursor = conn.cursor(dictionary=True)

    user_id = session.get('id')
    sql = """
    SELECT a.*, b.TenSP as TenSP, b.HinhAnh as HinhAnh
    FROM QLBanQuanAo.DonHang a
    JOIN QLBanQuanAo.SanPham b 
    ON a.MaSP = b.MaSP
    Where MaKH = %s
    """

    cursor.execute(sql, (user_id,))
    dics = cursor.fetchall()
    orders = []
    for dic in dics:
        product = {
            "id" : dic.get('MaDH'),
            "MaSP" : dic.get('MaSP'),
            "TenSP" : dic.get('TenSP'),
            "Gia" : dic.get('TongGiaDaGiam'),
            "SoLuong" : dic.get('SoLuong'),
            "TrangThai" : dic.get('TrangThai'),
            "HinhAnh" : dic.get('HinhAnh')
        }
        orders.append(product)

    print("User ID:", user_id)
    print("Orders count:", len(orders))
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
        cursor.execute("SELECT TenSP, Gia, HinhAnh FROM QLBanQuanAo.SanPham WHERE MaSP=%s", (product_id,))
        product = cursor.fetchone()

        if not product:
            return jsonify({"success": False, "message": "Sản phẩm không tồn tại"}), 404

        total_price = product['Gia'] * quantity
        cursor.execute("""
            INSERT INTO QLBanQuanAo.DonHang (MaKH, MaSP, SoLuong, TongGiaDaGiam, TrangThai, Mau)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (user_id, product_id, quantity, total_price, "Đã giao thành công", color))
        conn.commit()
        order_id = cursor.lastrowid
        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "order": {
                "id": order_id,
                "MaSP": product_id,
                "TenSP": product['TenSP'],
                "Gia": total_price,
                "SoLuong": quantity,
                "TrangThai": "Chờ xác nhận đơn",
                "HinhAnh": product['HinhAnh']
            }
        })
    except Exception as e:
        print("ERROR:", e)
        return jsonify({"success": False, "message": str(e)}), 500
