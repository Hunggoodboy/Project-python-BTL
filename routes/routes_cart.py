from flask import Blueprint, render_template, request, redirect, url_for, session, jsonify
from database.connect import get_connect

cart_bp = Blueprint('cart_bp', __name__)

# Trang giỏ hàng
@cart_bp.route('/cart')
def cart():
    ma_kh = session.get('id')
    conn = get_connect()
    if not ma_kh:
        return redirect(url_for('login_module.login'))
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
                    SELECT * FROM DonHang
                    JOIN SanPham ON DonHang.MaSP = SanPham.MaSP
                    WHERE MaKH = %s
                   """, (ma_kh,))
    cart_items = cursor.fetchall()
    total_price = round(sum((item['Gia'] * (100 - item['Discount']) / 100) * item['SoLuong'] for item in cart_items))
    cursor.close()
    conn.close()
    return render_template('cart.html', cart_items= cart_items, total_price= total_price)

# Thêm sản phẩm từ trang details
@cart_bp.route('/add-no-reload', methods=['POST'])
def add_cart_no_reload():
    try:
        data = request.get_json()  # nhận dữ liệu JSON từ fetch
        ma_sp = int(data.get('ma_sp'))
        so_luong = int(data.get('so_luong', 1))
        mau = data.get('mau')  # thêm màu
        size = data.get('size')
        ma_kh = session.get('id')

        if not ma_kh:
            return jsonify({'error': 'not_logged_in'}), 401

        # Lấy ttin sp từ bảng Product
        conn = get_connect()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT Gia, Discount FROM QLBanQuanAo.SanPham WHERE MaSP = %s", (ma_sp,))
        product = cursor.fetchone()
        if not product:
            return jsonify({'error': 'invalid_product'}), 404

        cursor.execute("SELECT MaDH FROM QLBanQuanAo.DonHang ORDER BY MaDH DESC LIMIT 1")
        row = cursor.fetchone()
        if row:
            ma_dh = row['MaDH'] + 1  # tăng lên 1
        else:
            ma_dh = 1  # nếu chưa có đơn hàng nào

        # Thêm đơn hàng
        sqladd = """
            INSERT INTO QLBanQuanAo.DonHang
            (MaDH, MaSP, MaKH, SoLuong, MauSac)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(sqladd, (ma_dh, ma_sp, ma_kh, so_luong, mau))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'success': True})
    except Exception as e:
        print("Error adding to cart:", e)
        return jsonify({'error': 'server_error'}), 500

# Xóa sản phẩm khỏi giỏ
@cart_bp.route('/remove_from_cart/<product_id>')
def remove_from_cart(product_id):
    carts = session.get('cart', [])
    carts = [item for item in carts if item['id'] != product_id]
    session['cart'] = carts
    return redirect(url_for('cart_bp.cart'))

# Xóa toàn bộ giỏ hàng
@cart_bp.route('/clear_cart')
def clear_cart():
    session.pop('cart', None)
    return redirect(url_for('cart_bp.cart'))


