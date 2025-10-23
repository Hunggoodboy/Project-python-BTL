import base64

from flask import Blueprint, render_template, request

from database.connect import get_connect

main_bp = Blueprint('menu', __name__, template_folder='templates')
@main_bp.route('/')
def main_menu():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT MaSP, TenSP, Gia, ChatLieu, HinhAnh FROM SanPham LIMIT 10")
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('mainMenu.html',products=products )

@main_bp.route('/search')
def search():
    word = request.args.get('word', '')   # lấy từ input
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    sql = ("""
            SELECT *
            FROM QLBanQuanAo.SanPham 
            WHERE ChatLieu LIKE %s 
                OR TenSP LIKE %s
                OR MauSac LIKE %s
                or MoTa LIKE %s
            ORDER BY
                CASE
                    WHEN TenSP LIKE %s THEN 1
                    WHEN ChatLieu LIKE %s THEN 2
                    ELSE 3
                END,
                TenSP;
            """)
    key = f"%{word}%"
    print(key)
    cursor.execute(sql, [key, key, key, key, key, key])
    products = cursor.fetchall()  # tất cả sản phẩm
    cursor.close()
    conn.close()
    if products:
        return render_template("search.html", word=word, products=products)
    else:
        return render_template("search.html", word=word, products='')