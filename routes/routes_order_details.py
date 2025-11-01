from flask import Blueprint, redirect, session, flash, url_for, request, render_template
from database.connect import get_connect

order_detailsbp = Blueprint('order_details', __name__)

@order_detailsbp.route('/order/details/<int:MaDH>')
def order_details(MaDH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    try:
        conn = get_connect()
        cursor = conn.cursor(dictionary=True)

        # 1. Lấy thông tin chung của đơn hàng
        cursor.execute("""
                       SELECT dh.*, kh.HoTen, kh.UserName, kh.Address, kh.SDT
                       FROM QLBanQuanAo.DonHang AS dh
                                JOIN QLBanQuanAo.KhachHang AS kh ON dh.MaKH = kh.MaKH
                       WHERE dh.MaDH = %s
                       """, (MaDH,))
        order = cursor.fetchone()

        if not order:
            flash('Không tìm thấy đơn hàng.')
            return redirect(url_for('show_orders'))

        # 2. Lấy các sản phẩm trong đơn hàng (từ bảng ChiTietDonHang)
        cursor.execute("""
                       SELECT ct.SoLuong, ct.DonGia, (ct.SoLuong * ct.DonGia) AS ThanhTien, sp.TenSP, sp.HinhAnh
                       FROM QLBanQuanAo.ChiTietDonHang ct
                                JOIN QLBanQuanAo.SanPham sp ON ct.MaSP = sp.MaSP
                       WHERE ct.MaDH = %s
                       """, (MaDH,))
        items = cursor.fetchall()
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Lỗi khi lấy chi tiết đơn hàng: {e}")
        flash(f'Lỗi: {e}')
        return redirect(url_for('show_orders'))
    return render_template('OrderDetails.html', order=order, items=items)