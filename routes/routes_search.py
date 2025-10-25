import base64

from flask import Blueprint, render_template, request

from database.connect import get_connect

search_bp = Blueprint('search', __name__, template_folder='templates')

@search_bp.route('/search')
def search():
    word = request.args.get('word', '')  # lấy từ input tìm kiếm
    categories = request.args.getlist('category')  # các checkbox
    price_from = request.args.get('price_from', type=float)
    price_to = request.args.get('price_to', type=float)
    order = request.args.get('order', type=str)

    conn = get_connect()
    cursor = conn.cursor(dictionary=True)

    # --- SQL cơ bản ---
    sql = """
        SELECT *
        FROM QLBanQuanAo.SanPham
        WHERE (TenSP LIKE %s OR ChatLieu LIKE %s OR MauSac LIKE %s)
    """
    params = [f"%{word}%", f"%{word}%", f"%{word}%"]

    # --- Lọc theo danh mục (nếu có) ---
    if categories:
        ma_dm = []
        if "Áo" in categories:
            ma_dm += [101, 102, 103]
        if "Quần" in categories:
            ma_dm += [201, 202]
        if "Váy" in categories:
            ma_dm += [203]
        if "Phụ Kiện" in categories:
            ma_dm += [301, 302]

        placeholders = ', '.join(['%s'] * len(ma_dm))
        sql += f" AND MaDM IN ({placeholders})"
        params.extend(ma_dm)

    # --- Lọc theo khoảng giá ---
    if price_from and price_to:
        sql += " AND Gia BETWEEN %s AND %s"
        params.extend([price_from, price_to])
    elif price_from:
        sql += " AND Gia >= %s"
        params.append(price_from)
    elif price_to:
        sql += " AND Gia <= %s"
        params.append(price_to)

    # --- Sắp xếp ---
    if order == 'Tên từ A-Z':
        sql += " ORDER BY TenSP ASC"
    elif order == 'Giá thấp đến cao':
        sql += " ORDER BY Gia ASC"
    elif order == 'Giá cao đến thấp':
        sql += " ORDER BY Gia DESC"
    else:
        # Mặc định: mức độ liên quan (ưu tiên tên chứa keyword)
        sql += """
            ORDER BY
                CASE
                    WHEN TenSP LIKE %s THEN 1
                    WHEN ChatLieu LIKE %s THEN 2
                    ELSE 3
                END,
                TenSP
        """
        params.extend([f"%{word}%", f"%{word}%"])

    # --- Thực thi ---
    cursor.execute(sql, params)
    products = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('search.html', word=word, products=products, categories=categories)
