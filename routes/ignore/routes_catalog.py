from flask import Blueprint, render_template

from database.connect import get_connect

catalog_bp = Blueprint('catalog', __name__)

@catalog_bp.route('/catalog')
def catalog():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM DanhMuc")
    categories = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('catalog.html', categories=categories)