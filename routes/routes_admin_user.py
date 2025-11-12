from flask import Blueprint, redirect, render_template, url_for, request, flash, session, jsonify
from database.connect import get_connect

admin_user_bp=Blueprint('admin_user', __name__)


@admin_user_bp.route('/user/edit/<string:MaKH>', methods=['POST'])
def edit_user(MaKH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'Admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    conn = get_connect()
    cursor = conn.cursor()

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
                           Address = %s
                       WHERE MaKH = %s
                       """, (HoTen, UserName, MatKhau, SDT, Address, MaKH))
        conn.commit()
        flash('Cập nhật thông tin người dùng thành công!')

    except Exception as e:
        print(f"Lỗi khi cập nhật người dùng: {e}")
        flash('Cập nhật thất bại, có lỗi xảy ra.')

    cursor.close()
    conn.close()
    return redirect(url_for('admin.admin_page'))

@admin_user_bp.route('/user/delete/<string:MaKH>', methods=['POST'])
def delete_user():
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'Admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    try:
        MaKH = request.form['MaKH']
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