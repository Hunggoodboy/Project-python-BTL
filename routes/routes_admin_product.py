from flask import Blueprint, redirect, render_template, url_for, request, session, flash
from database.connect import get_connect

admin_product_bp=Blueprint('admin_product', __name__)

@admin_product_bp.route('/product/add', methods=['GET', 'POST'])
def add_product():
    if request.method == 'POST':
        MaSP = request.form['MaSP']
        MaDM = request.form['MaDM']
        TenSP = request.form['TenSP']
        MoTa = request.form['MoTa']
        Gia = request.form['Gia']
        MauSac = request.form['MauSac']
        Size = request.form['Size']
        ChatLieu = request.form['ChatLieu']
        SoLuongcon = request.form['SoLuongcon']
        HinhAnh = request.form['HinhAnh']
        Season = request.form['Season']

        conn = get_connect()
        cursor = conn.cursor()
        cursor.execute("""
                       INSERT INTO QLBanQuanAo.SanPham
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongcon, HinhAnh, Season)
                       VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                       """,
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongcon, HinhAnh, Season))
        conn.commit()
        conn.close()
        return redirect(url_for('admin.admin_page'))
    return render_template('newProduct.html')

@admin_product_bp.route('/product/edit/<string:MaSP>', methods=['GET', 'POST'])
def edit_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
    if request.method == 'POST':
        try:
            conn = get_connect()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM QLBanQuanAo.SanPham WHERE MaSP = %s", (MaSP,))
            product = cursor.fetchone()

            MaDM = request.form['MaDM'] or product.get('MaDM')
            TenSP = request.form['TenSP'] or product.get('TenSP')
            MoTa = request.form['MoTa'] or product.get('MoTa')
            Gia = request.form['Gia'] or product.get('Gia')
            MauSac = request.form['MauSac'] or product.get('MauSac')
            Size = request.form['Size'] or product.get('Size')
            ChatLieu = request.form['ChatLieu'] or product.get('ChatLieu')
            SoLuongcon = request.form['SoLuongcon'] or product.get('SoLuongcon')
            HinhAnh = request.form['HinhAnh'] or product.get('HinhAnh')
            Season = request.form['Season'] or product.get('Season')


            cursor.execute("""UPDATE QLBanQuanAo.SanPham 
                  SET MaDM = %s, 
                      TenSP = %s, 
                      MoTa = %s, 
                      Gia = %s, 
                      MauSac = %s, 
                      Size = %s, 
                      ChatLieu = %s, 
                      SoLuongcon = %s, 
                      HinhAnh = %s, 
                      Season = %s
                  WHERE MaSP = %s""",
               (MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongcon, HinhAnh, Season, MaSP))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('admin.admin_page'))

        except Exception as e:
            print(f"Lỗi khi cập nhật sản phẩm: {e}")
            # (Tùy chọn) Gửi thông báo lỗi
            flash('Cập nhật thất bại, có lỗi xảy ra.')
            return redirect(url_for('admin.admin_page'))
    else:  # Tức là request.method == 'GET'
        try:
            conn = get_connect()
            cursor = conn.cursor(dictionary=True)
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


@admin_product_bp.route('/product/delete/<string:MaSP>', methods=['POST'])
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
        return redirect(url_for('admin.admin_page'))
