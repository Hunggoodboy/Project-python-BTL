import base64

import flask
from flask import Flask, render_template, request, redirect, url_for, session
#from DB_connect import get_db_connection
import os

from database.connect import get_connect

app = Flask(__name__)

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
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

@app.route('/help')
def size_help():
    return render_template('sizeManual.html')
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form.get('HoTen')
        username = request.form.get('username')
        password = request.form.get('MatKhau')
        numberphone = request.form.get('numberPhone')
        address = request.form.get('address')

        print("DEBUG:", name, username, password, numberphone, address)  # 👈 Kiểm tra ở terminal
        conn = get_connect()
        cursor = conn.cursor()
        sql = """
            INSERT INTO QLBanQuanAo.KhachHang (HoTen, username, MatKhau, SDT, Address)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(sql, [name, username, password, numberphone, address])
        conn.commit()
        cursor.close()
        conn.close()
        return redirect('/showTable')
    return render_template('register.html')

app.secret_key = '123456'
@app.route('/login', methods = ['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        conn = get_connect()
        cursor = conn.cursor()
        sql = """
        SELECT *
        FROM QLBanQuanAo.KhachHang
        WHERE UserName = %s AND MatKhau = %s
        """
        cursor.execute(sql, [username, password])
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        if result:
            session['logged_in'] = True
            session['username'] = result[0]
            session['password'] = result[1]
            return redirect('/')
        else:
            flask.flash('Sai tên đăng nhập hoặc mật khẩu!')
            return render_template('login.html')
    return render_template('login.html')
@app.route("/product/<int:pid>")
def product_detail(pid):
    conn = get_connect()
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
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM DanhMuc")
    categories = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('catalog.html', categories=categories)

if __name__ == '__main__':

    app.run(debug=True)

