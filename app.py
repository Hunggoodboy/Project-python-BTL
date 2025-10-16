from flask import Flask, render_template, request, redirect, url_for
#from DB_connect import get_db_connection
import os

from database.connect import get_connect

app = Flask(__name__)

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def main_menu():
    return render_template('mainMenu.html')

@app.route('/help')
def size_help():
    return render_template('sizeManual.html')
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        name = request.form.get('HoTen')
        username = request.form.get('username')
        password = request.form.get('password')
        numberphone = request.form.get('numberPhone')
        address = request.form.get('address')

        print("DEBUG:", name, username, password, numberphone, address)  # 👈 Kiểm tra ở terminal

        if not name:
            return "❌ Bạn chưa nhập họ tên!"

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
    return render_template('login.html')

# @app.route('/showTable', methods=['GET', 'POST'])
# def show_table():
#     conn = get_connect()
#     cursor = conn.cursor()
#     sql = """
#     SELECT * FROM QLBanQuanAo.KhachHang
#     """
#     cursor.execute(sql)
#     rows = cursor.fetchall()
#     cursor.close()
#     conn.close()
#     html = "<h2>Danh sách khách hàng</h2><table border='1' cellpadding='5'><tr><th>ID</th><th>Họ Tên</th><th>Tên đăng nhập</th><th>Mật khẩu</th><th>SĐT</th><th>Địa chỉ</th></tr>"
#     for r in rows:
#         html += f"<tr><td>{r[0]}</td><td>{r[1]}</td><td>{r[2]}</td><td>{r[3]}</td><td>{r[4]}</td><td>{r[5]}</td></tr>"
#     html += "</table>"
#     return html

@app.route("/product")
def product_detail():
    # Lấy dữ liệu theo pid từ DB
    # product = get_product_by_id(pid)
    return render_template("productDetail.html")

@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')

@app.route('/collections')
def collections():
    return render_template('collections.html')

@app.route('/catalog')
def catalog():
    return render_template('catalog.html')

if __name__ == '__main__':
    app.run(debug=True, port = '5003')