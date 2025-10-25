from flask import Blueprint, redirect, session, flash, url_for, request
from database.connect import get_connect

delete_orderbp = Blueprint('delete_order', __name__)
@delete_orderbp.route('/order/delete/<int:MaDH>', methods=['POST'])
def delete_order(MaDH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    if request.method == 'POST':
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("DELETE FROM QLBanQuanAo.DonHang WHERE MaDH = %s", (MaDH,))
            conn.commit()
            flash('Đã xóa đơn hàng thành công!')
            cursor.close()
            conn.close()
        except Exception as e:
            print(f"Lỗi khi xóa đơn hàng: {e}")
            conn.rollback()
            flash('Xóa đơn hàng thất bại.')
        return redirect(url_for('show_orders'))
