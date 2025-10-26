import flask
from flask import Blueprint, render_template, request, redirect, url_for, session, flash

update_cartbp = Blueprint('update_cart', __name__)
@update_cart.route('/update_cart/<string:product_id>', methods=['POST'])
def update_cart(product_id):
    #Cập nhật số lượng cho một sản phẩm trong giỏ hàng.
    try:
        new_quantity = int(request.form['quantity'])
        cart = session.get('cart', {})

        if product_id in cart:
            if new_quantity > 0:
                # Cập nhật số lượng mới
                cart[product_id]['quantity'] = new_quantity
                flash('Cập nhật số lượng thành công!')
            else:
                # Nếu số lượng <= 0, coi như xóa
                cart.pop(product_id)
                flash('Đã xóa sản phẩm khỏi giỏ hàng.')

            session['cart'] = cart
            session.modified = True
        else:
            flash('Không tìm thấy sản phẩm trong giỏ hàng.')

    except ValueError:
        flash('Số lượng không hợp lệ.', 'danger')
    except Exception as e:
        print(f"Lỗi khi cập nhật giỏ hàng: {e}")
        flash('Có lỗi xảy ra, không thể cập nhật giỏ hàng.')

    return redirect(url_for('cart.cart'))


# Route để XÓA một sản phẩm khỏi giỏ hàng
@cart_bp.route('/delete_from_cart/<string:product_id>', methods=['GET', 'POST'])
def delete_from_cart(product_id):
    #Xóa một sản phẩm khỏi giỏ hàng
    try:
        cart = session.get('cart', {})
        if cart.pop(product_id, None):
            flash('Đã xóa sản phẩm khỏi giỏ hàng!')
        else:
            flash('Không tìm thấy sản phẩm để xóa.')

        session['cart'] = cart
        session.modified = True

    except Exception as e:
        print(f"Lỗi khi xóa khỏi giỏ hàng: {e}")
        flash('Có lỗi xảy ra, không thể xóa sản phẩm')

    return redirect(url_for('cart.cart'))