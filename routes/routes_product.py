from flask import Blueprint, render_template, url_for
from database.connect import get_connect

product_bp = Blueprint('product', __name__, url_prefix='/product')

@product_bp.route("/<int:pid>")
def product_detail(pid):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (pid,))
    product = cursor.fetchone()
    cursor.close()
    conn.close()

    if not product:
        return "Không tìm thấy sản phẩm", 404

    # Giá trị mặc định
    product['Sold'] = product.get('Sold') or 0
    product['Discount'] = product.get('Discount') or 0
    product['HinhAnh'] = product.get('HinhAnh', 'images/default.png')
    product['Season'] = product.get('Season', 'All')

    # Tính giá sau giảm
    product['GiaSauGiam'] = int(product['Gia'] * (100 - product['Discount']) / 100)

    # Tạo danh sách ảnh và chuyển sang URL
    image_fields = ['HinhAnh', 'AnhPhu1', 'AnhPhu2', 'AnhPhu3', 'AnhPhu4']
    images = []
    for f in image_fields:
        if product.get(f):
            # Thêm url_for nếu file KHÔNG chứa /static/
            path = product[f]
            if not path.startswith("static/") and not path.startswith("/static/"):
                path = url_for('static', filename=path)
            else:
                path = "/" + path.lstrip("/")
            images.append(path)
    product['images'] = images

    # Màu sắc
    colors = [c.strip() for c in product.get('MauSac', '').split(',') if c.strip()]
    product['colors'] = [{'name': c, 'image': images[0] if images else url_for('static', filename='images/default.png')} for c in colors]

    # Size
    product['sizes'] = [s.strip() for s in product.get('Size', '').split(',') if s.strip()]

    print("=== PRODUCT IMAGES ===")
    print(product['images'])

    return render_template('productDetail.html', product=product)
