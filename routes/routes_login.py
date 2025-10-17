import flask
from flask import Blueprint, render_template, request, redirect, session

from database.connect import get_connect

login_bp = Blueprint('login', __name__)

@login_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        conn = get_connect()
        cursor = conn.cursor()
        sql = """
              SELECT *
              FROM QLBanQuanAo.KhachHang
              WHERE UserName = %s \
                AND MatKhau = %s \
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