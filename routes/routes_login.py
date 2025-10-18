from flask import Blueprint, render_template, request, redirect, session, flash
from database.connect import get_connect
import mysql.connector

login_bp = Blueprint('login_module', __name__)

@login_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
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
            cursor.close()
            conn.close()

            if user:
                session['logged_in'] = True
                session['username'] = user['UserName']
                return render_template('collections.html')
            else:
                flash('Sai tên đăng nhập hoặc mật khẩu!')
                return render_template('login.html')
        except mysql.connector.Error as e:
            print("Lỗi kết nối MySQL:", e)
            error = "Không thể kết nối tới cơ sở dữ liệu!"
            flash(error)
            return render_template('login.html', error=error)

    return render_template('login.html')
