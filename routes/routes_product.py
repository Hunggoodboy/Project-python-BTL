import base64

from flask import Blueprint, render_template

from database.connect import get_connect

product_bp = Blueprint('product', __name__, url_prefix='/product')

@product_bp.route("/product/<int:pid>")
def product_detail(pid):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP=%s", (pid,))
    p = cursor.fetchone()
    if p and p['HinhAnh']:
        p['HinhAnh'] = base64.b64encode(p['HinhAnh']).decode('utf-8')
    cursor.close()
    conn.close()
    if p:
        return render_template('productDetail.html', product=p)
    return "Không tìm thấy sản phẩm"