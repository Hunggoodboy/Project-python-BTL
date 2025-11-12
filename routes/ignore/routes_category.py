from unicodedata import category

from flask import render_template, Blueprint

from database.connect import get_connect
category_bp = Blueprint('category', __name__)

@category_bp.route('/collections/season/<season>', methods= ['GET', 'POST'])
def collection(season):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql_query = "SELECT * FROM QLBanQuanAo.SanPham WHERE Season LIKE %s OR Season IS NULL"
    cursor.execute(sql_query, [f"%{season}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("collections.html", products=products)


@category_bp.route('/collections/category/<category>', methods=['GET', 'POST'])
def collection_category(category):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("SELECT * FROM QLBanQuanAo.SanPham"
           " WHERE MoTa LIKE %s")
    cursor.execute(sql, [f"%{category}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("collections.html", products=products)

@category_bp.route('/collections/recent', methods=['GET', 'POST'])

def collection_date():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("SELECT * FROM QLBanQuanAo.SanPham WHERE NgayNhap >= SUBDATE(CURDATE(), INTERVAL 30 DAY)")
    cursor.execute(sql)
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("collections.html", products=products)


