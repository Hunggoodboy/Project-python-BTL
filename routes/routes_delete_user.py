from flask import Blueprint, session, redirect, flash, url_for, request
from database.connect import get_connect

delete_userbp = Blueprint('delete_user', __name__)

@delete_userbp.route('/user/delete/<string:MaKH>', methods=['POST'])
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