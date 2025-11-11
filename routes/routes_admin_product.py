from flask import Blueprint, redirect, render_template, url_for, request, session, flash, jsonify
from database.connect import get_connect

admin_product_bp=Blueprint('admin_product', __name__)

@admin_product_bp.route('/product/add', methods=['POST'])
def add_product():
    if 'user_role' not in session or session['user_role'] != 'Admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
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
    cursor.execute("SELECT * FROM QLBanQuanAo.SanPham where MaSP = %s", (MaSP,))
    product = cursor.fetchone()
    if product:
        cursor.close()
        conn.close()
        flash('Trùng mã sản phẩm, không thể thêm vào danh sách.')
        return redirect(url_for('admin.admin_page'))
    cursor.execute("""
                   INSERT INTO QLBanQuanAo.SanPham
                   (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongcon, HinhAnh, Season)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                   """,
                   (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongcon, HinhAnh, Season))
    conn.commit()
    conn.close()
    return redirect(url_for('admin.admin_page'))

@admin_product_bp.route('/product/edit/<string:MaSP>', methods=['POST'])
def edit_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'Admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))
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


@admin_product_bp.route('/product/delete/<string:MaSP>', methods=['POST'])
def delete_product(MaSP):
    if 'user_role' not in session or session['user_role'] != 'Admin':
        flash('Bạn không có quyền thực hiện hành động này!')
        return redirect(url_for('menu.main_menu'))

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
    return jsonify(success=True)
