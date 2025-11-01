from flask import Blueprint, render_template
from database.connect import get_connect

product_bp = Blueprint('product', __name__, url_prefix='/product')

@product_bp.route("/product/<int:pid>")
def product_detail(pid):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (pid,))
    product = cursor.fetchone()
    cursor.close()
    conn.close()

    if product:
        product['Sold'] = product.get('Sold', 0)
        product['Discount'] = product.get('Discount', 0)
        product['HinhAnh'] = product.get('HinhAnh', '/static/images/default.png')
        product['Season'] = product.get('Season', 'All')

        # Tính giá sau giảm
        product['GiaSauGiam'] = int(product['Gia'] * (100 - product['Discount']) / 100)

        product['images'] = [product['HinhAnh']]

        print("\n==== PRODUCT DEBUG ====")
        print(product)
        print("product['MaSP'] =", product.get('MaSP'))
        print("product['id'] =", product.get('MaSP'))
        print("========================\n")

        return render_template('productDetail.html', product=product)

    return "Không tìm thấy sản phẩm"
