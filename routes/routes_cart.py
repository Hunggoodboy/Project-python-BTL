from flask import Blueprint, render_template, request, redirect, url_for, session

cart_bp = Blueprint('cart_bp', __name__)

# Trang giỏ hàng
@cart_bp.route('/cart')
def cart():
    cart_items = session.get('cart', [])
    total = sum(item['price'] * item['quantity'] for item in cart_items)
    return render_template('cart.html', cart_items=cart_items, total=total)

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
