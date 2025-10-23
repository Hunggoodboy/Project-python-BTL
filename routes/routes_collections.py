from flask import Blueprint, render_template
from database.connect import get_connect

collections_bp = Blueprint('collections', __name__)

@collections_bp.route('/collections')
def collections():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM QLBanQuanAo.SanPham')
    products = cursor.fetchall()
    cursor.close()
    return render_template('collections.html', products=products)