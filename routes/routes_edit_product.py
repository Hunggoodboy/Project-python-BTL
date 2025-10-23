from flask import Blueprint, session, flash, redirect, request, url_for

edit_productbp = Blueprint('edit_productbp', __name__)
from database.connect import get_connect

def get_connect():
    pass


@edit_productbp.route('/product/edit/<string:MaSP>', methods=['GET', 'POST'])
def edit_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
    if request.method == 'POST':
        try:
            MaDM = request.form['MaDM']
            TenSP = request.form['TenSP']
            MoTa = request.form['MoTa']
            Gia = request.form['Gia']
            MauSac = request.form['MauSac']
            Size = request.form['Size']
            ChatLieu = request.form['ChatLieu']
            SoLuongCon = request.form['SoLuongCon']
            HinhAnh = request.form['HinhAnh']
            Season = request.form['Season']

            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("""UPDATE QLBanQuanAo.SanPham 
                  SET MaDM = %s, 
                      TenSP = %s, 
                      MoTa = %s, 
                      Gia = %s, 
                      MauSac = %s, 
                      Size = %s, 
                      ChatLieu = %s, 
                      SoLuongCon = %s, 
                      HinhAnh = %s, 
                      Season = %s
                  WHERE MaSP = %s""",
               (MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season, MaSP))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('show_product'))

        except Exception as e:
            print(f"Lỗi khi cập nhật sản phẩm: {e}")
            # (Tùy chọn) Gửi thông báo lỗi
            flash('Cập nhật thất bại, có lỗi xảy ra.')
            return redirect(url_for('show_product'))
    else:  # Tức là request.method == 'GET'
        try:
            conn = get_connect()
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM QLBanQuanAo.SanPham WHERE MaSP = %s", (MaSP,))
            product = cursor.fetchone()

            cursor.close()
            conn.close()

            if product:
                # Gửi dữ liệu sản phẩm này sang file
                return render_template('editProduct.html', product=product)
            else:
                # Nếu không tìm thấy sản phẩm
                return "Không tìm thấy sản phẩm."
        except Exception as e:
            print(f"Lỗi khi lấy thông tin sản phẩm: {e}")
            return "Đã xảy ra lỗi."
