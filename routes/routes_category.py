from unicodedata import category

from flask import render_template, Blueprint

from database.connect import get_connect
category_bp = Blueprint('category', __name__)

@category_bp.route('/category/<category>', methods=['GET', 'POST'])
def category(category):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE MoTa = %s"
    cursor.execute(sql, [f"%{category}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("Ao.html", products=products)
def category(category):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE MoTa = %s"
    cursor.execute(sql, [f"%{category}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("Quan.html", products=products)
def category(category):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE MoTa = %s"
    cursor.execute(sql, [f"%{category}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("PhuKien.html", products=products)



