# from flask import Blueprint, render_template
# from database.connect import get_connect

# productdetail_bp = Blueprint('productdetail', __name__)

# def get_all_products():
#     conn = get_connect()
#     cursor = conn.cursor(dictionary=True)
#     cursor.execute("SELECT * FROM SanPham")
#     products = cursor.fetchall()
#     conn.close()

#     for p in products:
#         p['id'] = p.get('MaSP')
#         p['TenSP'] = p.get('TenSP', 'Sản phẩm')
#         p['Gia'] = p.get('Gia', 0)
#         p['HinhAnh'] = p.get('HinhAnh', 'images/default.jpg')
#         p['MoTa'] = p.get('MoTa', 'Không có mô tả')
#     return products

# def get_product_by_id(id):
#     conn = get_connect()
#     cursor = conn.cursor(dictionary=True)
#     cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (id,))
#     product = cursor.fetchone()
#     conn.close()

#     if product:
#         product['id'] = product.get('MaSP',406)
#         product['TenSP'] = product.get('TenSP', 'Sản phẩm')
#         product['Gia'] = product.get('Gia', 0)
#         product['HinhAnh'] = product.get('HinhAnh', 'images/default.jpg')
#         product['MoTa'] = product.get('MoTa', 'Không có mô tả')

#     return product

# @productdetail_bp.route('/shop')
# def shop():
#     products = get_all_products()
#     return render_template('shop.html', products=products)

# @productdetail_bp.route('/<int:id>')
# def productdetail(id):
#     product = get_product_by_id(id)
#     if not product:
#         return "Sản phẩm không tồn tại", 404
#     return render_template('productDetail.html', product=product)

# @productdetail_bp.route('/sizechart')
# def sizechart():
#     return render_template('sizechart.html')
