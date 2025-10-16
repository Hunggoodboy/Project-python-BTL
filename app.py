from flask import Flask, render_template, request, redirect, url_for
from connect import get_db_connection
import mysql.connector
import base64
import os

app = Flask(__name__)

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def main_menu():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT MaSP, TenSP, Gia, HinhAnh FROM SanPham LIMIT 10")
    products = cursor.fetchall()
    for p in products:
        if p['HinhAnh']:
            p['HinhAnh'] = base64.b64encode(p['HinhAnh']).decode('utf-8')
    cursor.close()
    conn.close()
    return render_template('mainMenu.html',product=products )

@app.route('/help')
def size_help():
    return render_template('sizeManual.html')


@app.route("/product")
def product_detail():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP=%s", (pid,))
    p = cursor.fetchone()
    if p and p['HinhAnh']:
        p['HinhAnh'] = base64.b64encode(p['HinhAnh']).decode('utf-8')
    cursor.close()
    conn.close()
    if p:
        return render_template('productDetail.html', product=p)
    return "Không tìm thấy sản phẩm"
   
@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')

@app.route('/collections')
def collections():
    return render_template('collections.html')

@app.route('/catalog')
def catalog():
    conn = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="hung0335321015",
        database="QLBanQuanAo"
    )
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM DanhMuc")
    categories = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('catalog.html', categories=categories)

if __name__ == '__main__':

    app.run(debug=True)
