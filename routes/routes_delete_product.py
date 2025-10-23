from flask import Blueprint, redirect, session, flash, url_for, request
from database.connect import get_connect

delete_productbp = Blueprint('delete_product', __name__)

@delete_productbp.route('/product/delete/<string:MaSP>', methods=['POST'])
def delete_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
    if request.method == 'POST':
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("DELETE FROM QLBanQuanAo.SanPham WHERE MaSP = %s" , (MaSP,))
            conn.commit()
            cursor.close()
            conn.close()
            # (Tùy chọn) Gửi thông báo thành công
            flash('Đã xóa sản phẩm thành công!')

        except Exception as e:
            print(f"Lỗi khi xóa sản phẩm: {e}")
            # (Tùy chọn) Gửi thông báo lỗi
            flash('Xóa sản phẩm thất bại, đã có lỗi xảy ra.')
        return redirect(url_for('show_product'))