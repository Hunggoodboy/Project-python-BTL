import base64

from flask import Blueprint, render_template, request

from database.connect import get_connect

main_bp = Blueprint('menu', __name__, template_folder='templates')
@main_bp.route('/')
def main_menu():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham")
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('mainMenu.html',products=products )
