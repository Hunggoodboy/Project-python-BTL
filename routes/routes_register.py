import flask
from flask import Blueprint, render_template, request, redirect, session, url_for
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
