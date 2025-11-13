import flask
from flask import Blueprint, render_template, request, redirect, session, url_for, flash
from database.connect import get_connect

# Tạo Blueprint, đặt template_folder ở đây
register_bp = Blueprint('register', __name__)

@register_bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form.get('HoTen')
        username = request.form.get('username')
        password = request.form.get('MatKhau')
        numberphone = request.form.get('SDT')
        address = request.form.get('Address')

        print("Debug: ", name, username, password, numberphone, address)
        conn = get_connect()
        cursor = conn.cursor()
        sql_check1 = """
            SELECT * FROM QLBanQuanAo.KhachHang
            WHERE username = %s
        """
        cursor.execute(sql_check1, [username])
        check1 = cursor.fetchone()
        if check1 is not None:
            flash('Tên Đăng Nhập Đã Được Đăng Ký')
            return redirect(url_for('register.register'))
        sql_check2 = """
                     SELECT * \
                     FROM QLBanQuanAo.KhachHang
                     WHERE SDT = %s \
                     """
        cursor.execute(sql_check2, [numberphone])
        check2 = cursor.fetchone()
        if check2 is not None:
            flash('Số Điện Thoại Đã Được Đăng Ký')
            return redirect(url_for('register.register'))

        sql = """
            INSERT INTO QLBanQuanAo.KhachHang (HoTen, username, MatKhau, SDT, Address, Role)
            VALUES (%s, %s, %s, %s, %s, 'Client')
        """
        cursor.execute(sql, [name, username, password, numberphone, address])
        session['logged_in'] = True
        session['hoten'] = name
        session['username'] = username
        session['password'] = password
        session['numberphone'] = numberphone
        session['address'] = address
        conn.commit()
        cursor.close()
        conn.close()
        flask.flash("Bạn đã đăng ký tài khoản thành công", "success")
        return redirect(url_for('menu.main_menu'))

    return render_template('register.html')
