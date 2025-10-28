from flask import Blueprint, render_template, session
from database.connect import get_connect
orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders')
def show_orders():

    conn = get_connect()
    cursor = conn.cursor(dictionary=True)

    user_id = session.get('id')
    sql = """
    SELECT a.*, b.TenSP as TenSP, b.HinhAnh as HinhAnh
    FROM QLBanQuanAo.DonHang a
    JOIN QLBanQuanAo.SanPham b 
    ON a.MaSP = b.MaSP
    Where MaKH = %s
    """

    cursor.execute(sql, (user_id,))
    dics = cursor.fetchall()
    orders = []
    for dic in dics:
        product = {
            "id" : dic.get('MaDH'),
            "MaSP" : dic.get('MaSP'),
            "TenSP" : dic.get('TenSP'),
            "Gia" : dic.get('TongGiaDaGiam'),
            "SoLuong" : dic.get('SoLuong'),
            "TrangThai" : dic.get('TrangThai'),
            "HinhAnh" : dic.get('HinhAnh')
        }
        orders.append(product)

    return render_template('my_orders.html', orders=orders)
