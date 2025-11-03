from flask import Blueprint, render_template, request, redirect, url_for, session
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

# Thêm sản phẩm vào giỏ
@cart_bp.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    product_id = request.form['id']
    name = request.form['name']
    price = float(request.form['price'])
    quantity = int(request.form.get('quantity', 1))

    carts = session.get('cart', [])
    for item in carts:
        if item['id'] == product_id:
            item['quantity'] += quantity
            break
    else:
        carts.append({'id': product_id, 'name': name, 'price': price, 'quantity': quantity})

    session['cart'] = carts
    return redirect(url_for('cart_bp.cart'))

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


