from flask import Blueprint, redirect, session, flash, url_for, request
from database.connect import get_connect

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders')
def show_orders():
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    try:
        conn = get_connect()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
                       SELECT dh.MaDH, kh.HoTen, dh.NgayDat, dh.TongTien, dh.TrangThai
                       FROM QLBanQuanAo.DonHang dh
                                JOIN QLBanQuanAo.KhachHang kh ON dh.MaKH = kh.MaKH
                       ORDER BY dh.NgayDat DESC
                       """)
        orders = cursor.fetchall()
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Lỗi khi lấy danh sách đơn hàng: {e}")
        flash(f'Lỗi: {e}')
    return render_template('my_orders.html', orders=orders)