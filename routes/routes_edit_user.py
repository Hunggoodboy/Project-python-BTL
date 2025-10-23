from flask import Blueprint, flash, redirect, url_for, request, render_template
from flask_sqlalchemy import session
from database.connect import get_connect

edit_userbp = Blueprint('edit_userbp', __name__)


@edit_userbp.route('/user/edit/<string:MaKH>', methods=['GET', 'POST'])
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