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
    sql = ("""
        SELECT COALESCE(Season, 'Quanh năm') AS Season, 
            COUNT(*) AS SoLuong,
            (
                SELECT sp2.HinhAnh 
                FROM SanPham sp2 
                WHERE (sp2.Season = sp.Season OR (sp2.Season IS NULL AND sp.Season IS NULL))
                LIMIT 1 OFFSET 1
            ) AS HinhAnh
        FROM SanPham sp GROUP BY Season
        """)
    cursor.execute(sql)
    seasons = cursor.fetchall()
    for season in seasons:
        print(season['HinhAnh'])
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
@navigation_bp.route('/category')
def categories():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = """
        SELECT dm.MaDM, dm.TenDM, dm.MaDMCha,
        IF(dm.MaDMCha IS NULL,
           -- danh mục cha: lấy sản phẩm thứ 2 trong danh mục con
           (SELECT sp.HinhAnh
            FROM SanPham sp
            JOIN DanhMuc dm2 ON sp.MaDM = dm2.MaDM
            WHERE dm2.MaDMCha = dm.MaDM
            LIMIT 1 OFFSET 1),
            
           -- danh mục con: lấy sản phẩm đầu
           (SELECT sp2.HinhAnh
            FROM SanPham sp2
            WHERE sp2.MaDM = dm.MaDM
            LIMIT 1)
        ) AS HinhAnh
        FROM DanhMuc dm
        """
    cursor.execute(sql)
    categories = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('catalog.html', categories=categories)

# Sản phẩm theo danh mục
@navigation_bp.route('/category/<int:maDM>')
def p_category(maDM):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)

    # Kiểm tra cha hay con
    cursor.execute("SELECT TenDM, MaDMCha FROM DanhMuc WHERE MaDM = %s", (maDM,))
    row = cursor.fetchone()

    if not row:
        cursor.close()
        conn.close()
        return "Danh mục không tồn tại", 404

    if row["MaDMCha"] is None:  # Danh mục cha
        sql = """
                SELECT sp.*
                FROM QLBanQuanAo.SanPham sp
                JOIN DanhMuc dm ON sp.MaDM = dm.MaDM
                WHERE (dm.MaDM = %s OR dm.MaDMCha = %s)
            """
        params = [maDM, maDM]
    else:  # Danh mục con
        sql = "SELECT * FROM QLBanQuanAo.SanPham WHERE MaDM = %s"
        params = [maDM]

    cursor.execute(sql, params)
    products = cursor.fetchall()
    category = row['TenDM']

    cursor.close()
    conn.close()
    return render_template("catalog.html", category = category, products=products)




