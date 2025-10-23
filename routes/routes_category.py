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
    return render_template(f"{category}.html", products=products)

@category_bp.route('/collections/<season>')
def collection(season):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = """
          SELECT * 
          FROM QLBanQuanAo.SanPham 
          WHERE Season LIKE %s
          OR Season IS NULL
        """

    cursor.execute(sql, [f"%{season}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("collections.html", season = season, products=products)




