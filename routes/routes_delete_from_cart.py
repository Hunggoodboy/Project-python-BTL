import flask
from flask import Blueprint, render_template, request, redirect, url_for, session, flash
@delete_from_cartbp.route('/delete_from_cart/<string:product_id>', methods=['GET', 'POST'])
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