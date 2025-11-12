from flask import Blueprint, render_template

from database.connect import get_connect

navigation_bp = Blueprint('navigation', __name__, template_folder='templates')

# Hàng mới về
@navigation_bp.route('/recent')
def newest_products():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("SELECT * FROM QLBanQuanAo.SanPham WHERE NgayNhap >= SUBDATE(CURDATE(), INTERVAL 30 DAY)")
    cursor.execute(sql)
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("collections.html", products=products)

#Tổng hợp bộ sưu tập
@navigation_bp.route('/collections')
def collections():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("SELECT COALESCE(Season, 'Quanh năm') AS Season, COUNT(*) AS SoLuong FROM SanPham GROUP BY Season")
    cursor.execute(sql)
    seasons = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("collections.html", seasons=seasons)

# Sản phẩm theo mùa
@navigation_bp.route('/collections/season/<season>')
def p_collection(season):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql_query = "SELECT * FROM QLBanQuanAo.SanPham WHERE Season LIKE %s OR Season IS NULL"
    cursor.execute(sql_query, [f"%{season}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("collections.html", season = season, products=products)

#Danh mục hàng
@navigation_bp.route('/catalog')
def categories():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM DanhMuc")
    categories = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('catalog.html', categories=categories)

# Sản phẩm theo danh mục
@navigation_bp.route('/collections/category/<category>')
def p_category(category):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("SELECT * FROM QLBanQuanAo.SanPham"
           " WHERE MoTa LIKE %s")
    cursor.execute(sql, [f"%{category}%"])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    return render_template("catalog.html", category = category, products=products)




