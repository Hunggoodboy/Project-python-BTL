from flask import Blueprint, render_template, request, redirect, session, flash, url_for, app
import mysql.connector
from database.connect import get_connect

login_bp = Blueprint('login_module', __name__)


@login_bp.route('/login', methods=['GET', 'POST'])

def login():
    if request.method == 'POST':
        print("ok")
        username = request.form.get('username')
        password = request.form.get('password')
        try:
            conn = get_connect()
            cursor = conn.cursor(dictionary=True)
            cursor.execute(
                "SELECT * FROM QLBanQuanAo.KhachHang WHERE UserName=%s AND MatKhau=%s",
                (username, password)
            )
            user = cursor.fetchone()
            print(user)
            cursor.close()
            conn.close()

            if user:
                print(user)
                session['logged_in'] = True
                session['id'] = user['MaKH']
                session['hoten'] = user['HoTen']
                session['username'] = user['UserName']
                session['password'] = user['MatKhau']
                session['numberphone'] = user['SDT']
                session['address'] = user['Address']
                if(session['username'] == "Admin_03" and session['password'] == "admin_nhom3"):
                    session['user_role'] = 'admin'
                else:
                    session['user_role'] = 'client'
                flash('Bạn đã đăng nhập thành công !')
                return redirect(url_for('menu.main_menu'))
            else:
                flash('Sai tên đăng nhập hoặc mật khẩu!')
                return render_template('login.html')
        except mysql.connector.Error as e:
            print("Lỗi kết nối MySQL:", e)
            error = "Không thể kết nối tới cơ sở dữ liệu!"
            flash(error)
            return render_template('login.html', error=error)

    return render_template('login.html')
