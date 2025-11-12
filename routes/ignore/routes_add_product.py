from flask import Blueprint, redirect, render_template, url_for, request
from database.connect import get_connect

addproduct_bp=Blueprint('addproductbp', __name__)

@addproduct_bp.route('/product/add', methods=['GET', 'POST'])
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
        SoLuongCon = request.form['SoLuongCon']
        HinhAnh = request.form['HinhAnh']
        Season = request.form['Season']

        conn = get_connect()
        cursor = conn.cursor()
        cursor.execute("""
                       INSERT INTO QLBanQuanAo.SanPham
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season)
                       VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                       """,
                       (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season))
        conn.commit()
        conn.close()
        return redirect(url_for('show_product'))
    return render_template('newProduct.html')
