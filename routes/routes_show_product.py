from flask import Blueprint, render_template
from database.connect import get_connect
show_productbp = Blueprint('show_product', __name__)



@show_productbp.route('/product')
def show_product():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM qlbanquanao.sanpham")
    products = cursor.fetchall()
    cursor.close()
    print("tat ca san pham", products)
    return render_template('ProductTable.html', products=products)