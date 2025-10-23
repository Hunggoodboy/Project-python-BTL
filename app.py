import base64
from database.connect import get_connect
import flask
from flask import Flask, render_template, request, redirect, url_for, session, flash
#from DB_connect import get_db_connection
import os
from database.connect import get_connect
from routes.routes_catalog import catalog_bp
from routes.routes_register import register_bp
from routes.routes_login import login_bp
from routes.routes_category import category_bp
from routes.routes_product import product_bp
from routes.routes_main import main_bp
from routes.routes_category import category_bp
from routes.routes_size import size_bp
from routes.routes_logout import logout_bp
from routes.routes_productdetail import productdetail_bp
from routes.routes_home import home_bp
from routes.routes_order import order_bp
app = Flask(__name__)
app.secret_key = '123456'

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.register_blueprint(main_bp)
app.register_blueprint(login_bp)
app.register_blueprint(register_bp)
app.register_blueprint(category_bp)
app.register_blueprint(product_bp)
app.register_blueprint(catalog_bp)
app.register_blueprint(size_bp)
app.register_blueprint(logout_bp)
app.register_blueprint(productdetail_bp)
app.register_blueprint(home_bp)
app.register_blueprint(order_bp)

@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')
@app.route('/collections')
def collections():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM QLBanQuanAo.SanPham')
    products = cursor.fetchall()
    cursor.close()
    return render_template('collections.html', products=products)

@app.route('/ShowUser')
def show_user():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("select * from QLBanQuanAo.KhachHang")
    users = cursor.fetchall()
    cursor.close()
    return render_template('ShowUser.html', users=users)

@app.route("/register")
def register():
    return render_template('register.html')

@app.route('/product')
def show_product():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM qlbanquanao.sanpham")
    products = cursor.fetchall()
    cursor.close()
    print("tat ca san pham", products)
    return render_template('ProductTable.html', products=products)

@app.route('/product/add', methods=['GET', 'POST'])
def add_product():
    if request.method == 'POST':
        MaSP = request.form['MaSP']
        MaDM = request.form['MaDM']
        TenSP = request.form['TenSP']
        MoTa = request.form['MoTa']
        Gia = request.form['Gia']
        MauSac = request.form['MauSac']
        Size = request.form['Size']
        ChatLieu = request.form['ChatLieu']
        SoLuongCon = request.form['SoLuongCon']
        HinhAnh = request.form['HinhAnh']
        Season = request.form['Season']

        conn = get_connect()
        cursor = conn.cursor()
        cursor.execute("""
                       INSERT INTO QLBanQuanAo.SanPham
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season)
                       VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                       """,
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season))
        conn.commit()
        conn.close()
        return redirect(url_for('show_product'))
    return render_template('newProduct.html')

@app.route('/product/delete/<string:MaSP>', methods=['POST'])
def delete_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
    if request.method == 'POST':
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("DELETE FROM QLBanQuanAo.SanPham WHERE MaSP = %s" , (MaSP,))
            conn.commit()
            cursor.close()
            conn.close()
            # (Tùy chọn) Gửi thông báo thành công
            flash('Đã xóa sản phẩm thành công!')

        except Exception as e:
            print(f"Lỗi khi xóa sản phẩm: {e}")
            # (Tùy chọn) Gửi thông báo lỗi
            flash('Xóa sản phẩm thất bại, đã có lỗi xảy ra.')
        return redirect(url_for('show_product'))

@app.route('/product/edit/<string:MaSP>', methods=['GET', 'POST'])
def edit_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
    if request.method == 'POST':
        try:
            MaDM = request.form['MaDM']
            TenSP = request.form['TenSP']
            MoTa = request.form['MoTa']
            Gia = request.form['Gia']
            MauSac = request.form['MauSac']
            Size = request.form['Size']
            ChatLieu = request.form['ChatLieu']
            SoLuongCon = request.form['SoLuongCon']
            HinhAnh = request.form['HinhAnh']
            Season = request.form['Season']

            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("""UPDATE QLBanQuanAo.SanPham 
                  SET MaDM = %s, 
                      TenSP = %s, 
                      MoTa = %s, 
                      Gia = %s, 
                      MauSac = %s, 
                      Size = %s, 
                      ChatLieu = %s, 
                      SoLuongCon = %s, 
                      HinhAnh = %s, 
                      Season = %s
                  WHERE MaSP = %s""",
               (MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season, MaSP))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('show_product'))

        except Exception as e:
            print(f"Lỗi khi cập nhật sản phẩm: {e}")
            # (Tùy chọn) Gửi thông báo lỗi
            flash('Cập nhật thất bại, có lỗi xảy ra.')
            return redirect(url_for('show_product'))
    else:  # Tức là request.method == 'GET'
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM QLBanQuanAo.SanPham WHERE MaSP = %s", (MaSP,))
            product = cursor.fetchone()

            cursor.close()
            conn.close()

            if product:
                # Gửi dữ liệu sản phẩm này sang file
                return render_template('editProduct.html', product=product)
            else:
                # Nếu không tìm thấy sản phẩm
                return "Không tìm thấy sản phẩm."
        except Exception as e:
            print(f"Lỗi khi lấy thông tin sản phẩm: {e}")
            return "Đã xảy ra lỗi."


@app.route('/user/edit/<string:MaKH>', methods=['GET', 'POST'])
def edit_user(MaKH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    conn = get_connect()
    cursor = conn.cursor()

    if request.method == 'POST':
        try:
            HoTen = request.form['HoTen']
            UserName = request.form['UserName']
            MatKhau = request.form['MatKhau']
            SDT= request.form['SDT']
            Address = request.form['Address']


            cursor.execute("""
                           UPDATE QLBanQuanAo.KhachHang
                           SET HoTen = %s,
                               UserName = %s,
                               MatKhau = %s,
                               SDT = %s,
                               Address = %s,
                           WHERE MaKH = %s
                           """, (HoTen, UserName, MatKhau, SDT, MaKH))
            conn.commit()
            flash('Cập nhật thông tin người dùng thành công!')
        except Exception as e:
            print(f"Lỗi khi cập nhật người dùng: {e}")
            flash('Cập nhật thất bại, có lỗi xảy ra.')
            cursor.close()
            conn.close()
        return redirect(url_for('show_user'))

    else:  # (request.method == 'GET')
        try:

            cursor.execute("SELECT * FROM QLBanQuanAo.KhachHang WHERE MaKH = %s", (MaKH,))
            user = cursor.fetchone()
            cursor.close()
            conn.close()
            if user:
                return render_template('editUser.html', user=user)
            else:
                return "Không tìm thấy người dùng."
        except Exception as e:
            print(f"Lỗi khi lấy thông tin người dùng: {e}")
            return "Đã xảy ra lỗi."


@app.route('/user/delete/<string:MaKH>', methods=['POST'])
def delete_user(MaKH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    if request.method == 'POST':
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("DELETE FROM QLBanQuanAo.KhachHang WHERE MaKH = %s", (MaKH,))
            conn.commit()
            cursor.close()
            conn.close()
            flash('Đã xóa người dùng thành công!')
        except Exception as e:
            print(f"Lỗi khi xóa người dùng: {e}")
            flash('Xóa người dùng thất bại.')
        return redirect(url_for('show_user'))

if __name__ == '__main__':
    app.run(debug=True, port=5003)