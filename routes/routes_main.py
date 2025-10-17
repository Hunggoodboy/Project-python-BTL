import base64

from flask import Blueprint, render_template

from database.connect import get_connect

main_bp = Blueprint('menu', __name__, template_folder='templates')
@main_bp.route('/')
def main_menu():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT MaSP, TenSP, Gia, HinhAnh FROM SanPham LIMIT 10")
    products = cursor.fetchall()
    for p in products:
        if p['HinhAnh']:
            p['HinhAnh'] = base64.b64encode(p['HinhAnh']).decode('utf-8')
    cursor.close()
    conn.close()
    return render_template('mainMenu.html',product=products )
