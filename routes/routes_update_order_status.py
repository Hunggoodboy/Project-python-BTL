from flask import Blueprint, redirect, session, flash, url_for, request
from database.connect import get_connect

update_order_statusbp = Blueprint('update_order_status', __name__)

@update_order_statusbp.route('/order/update_status/<int:MaDH>', methods=['POST'])
def update_order_status(MaDH):
    # Kiểm tra quyền admin
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

    if request.method == 'POST':
        try:
            new_status = request.form['TrangThai']
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("UPDATE QLBanQuanAo.DonHang SET TrangThai = %s WHERE MaDH = %s", (new_status, MaDH))
            cursor.execute("SELECT MaKH FROM QLBanQuanAo.DonHang WHERE MaDH = %s", (MaDH,))
            order = cursor.fetchone()

            if order:
                MaKH_cua_don_hang = order['MaKH']
                noi_dung_thong_bao = f"Đơn hàng #{MaDH} của bạn đã cập nhật trạng thái thành: {new_status}"
                link_don_hang = f"/order/details/{MaDH}"
                cursor.execute("""
                               INSERT INTO ThongBao (MaKH, NoiDung, LinkDonHang)
                               VALUES (%s, %s, %s)
                               """, (MaKH_cua_don_hang, noi_dung_thong_bao, link_don_hang))
            conn.commit()
            flash('Cập nhật trạng thái đơn hàng thành công!')
            cursor.close()
            conn.close()

        except Exception as e:
            print(f"Lỗi khi cập nhật trạng thái: {e}")
            conn.rollback()
            flash('Cập nhật trạng thái thất bại.')
        return redirect(url_for('order_details', MaDH=MaDH))