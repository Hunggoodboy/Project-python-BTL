from flask import Blueprint, session, request, flash, redirect, url_for, jsonify
from database.connect import get_connect

add_to_cartbp = Blueprint('add_to_cart', __name__)

@add_to_cartbp.route('/add_to_cart', methods=['POST'])

def add_to_cart():
    try:
        ma_sp = request.args.get('ma_sp')
        so_luong = request.args.get('so_luong', 1)
        don_gia = request.args.get('don_gia', 1)
        discount = request.args.get('discount', 1)
        ma_kh = session.get('id', 1)
        if not ma_kh:
            flash("Vui Lòng Đăng Nhập Trước Khi Mua Hàng")
            return redirect(url_for('login_module.login'))
        conn = get_connect()
        cursor = conn.cursor()

        tong_gia_goc = int(don_gia * so_luong)
        tong_gia_da_giam = int(tong_gia_goc * (100 - discount) // 100)

        sqladd = """
            INSERT INTO QLBanQuanAo.DonHang (MaSP, MaKH, SoLuong, DonGia, TongGiaGoc,TrangThai, TongGiaDaGiam)
                VALUES (%s, %s, %s, %s, %s, %s , %s)
            """

        cursor.execute(sqladd, (
            ma_sp, ma_kh, so_luong, don_gia, tong_gia_goc,"Dang Xu Ly", tong_gia_da_giam
        ))
        conn.commit()
        cursor.close()
        conn.close()
        flash("Them Vao Gio Hang Thanh Cong")
    except:
        flash("Loi them don")
        return redirect(url_for('collections.collections'))
    return redirect(url_for('collections.collections'))