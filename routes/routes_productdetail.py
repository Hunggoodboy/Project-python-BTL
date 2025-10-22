from flask import Blueprint, render_template
from database.connect import get_connect

productdetail_bp = Blueprint('productdetail', __name__)

def get_all_products():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT MaSP, TenSP, Gia, HinhAnh, MauSac, MoTa, Size, ChatLieu, SoLuongCon FROM SanPham")
    products = cursor.fetchall()
    conn.close()
    return products

def get_product_by_id(id):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (id,))
    product = cursor.fetchone()
    conn.close()
    return product

@productdetail_bp.route('/shop')
def shop():
    products = get_all_products()
    return render_template('shop.html', products=products)

@productdetail_bp.route('/product/<int:id>')
def productdetail(id):
    product = get_product_by_id(id)
    if not product:
        return "Sản phẩm không tồn tại", 404
    return render_template('productdetail.html', product=product)

@productdetail_bp.route('/sizechart')
def sizechart():
    return render_template('sizechart.html')
