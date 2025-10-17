from flask import Blueprint, render_template, request, redirect
from database.connect import get_connect

# Tạo Blueprint, đặt template_folder ở đây
register_bp = Blueprint('register', __name__)

@register_bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form.get('HoTen')
        username = request.form.get('username')
        password = request.form.get('MatKhau')
        numberphone = request.form.get('numberPhone')
        address = request.form.get('address')

        print("DEBUG:", name, username, password, numberphone, address)
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
