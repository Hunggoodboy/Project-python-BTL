import requests
from database.connect import get_connect
from flask import Blueprint, render_template, request

qldonhangbp = Blueprint('qldonhangbp', __name__)

qldonhangbp.route("/quanlydonhang_Choxacnhandon", methods=["POST"])
def quanlydonhang_Choxacnhandon():
    conn = get_connect()
    cursor = conn.cursor()
    sql = """
    SELECT *
    FROM QLBanQuanAo.DonHang
    Where TrangThai Like 'Chờ xác nhận đơn'
    """
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adminorder.html', rows=rows)


qldonhangbp.route("/quanlydonhang_Danggiaohang", methods=["POST"])
def quanlydonhang_Danggiaohang():
    conn = get_connect()
    cursor = conn.cursor()
    sql = """
    SELECT *
    FROM QLBanQuanAo.DonHang
    Where TrangThai Like 'Đang giao hàng'
    """
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adminorder.html', rows=rows)

qldonhangbp.route("/quanlydonhang_Chobanxacnhan", methods=["POST"])
def quanlydonhang_Chobanxacnhan():
    conn = get_connect()
    cursor = conn.cursor()
    sql = """
    SELECT *
    FROM QLBanQuanAo.DonHang
    Where TrangThai Like 'Chờ bạn xác nhận'
    """
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adminorder.html', rows=rows)

qldonhangbp.route("/quanlydonhang_Dagiaothanhcong", methods=["POST"])
def quanlydonhang_Dagiaothanhcong():
    conn = get_connect()
    cursor = conn.cursor()
    sql = """
    SELECT *
    FROM QLBanQuanAo.DonHang
    Where TrangThai Like 'Đã giao thành công'
    """
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adminorder.html', rows=rows)

qldonhangbp.route("/setTrangThai", methods=["POST", "GET"])

def setTrangThai():
    conn = get_connect()
    cursor = conn.cursor()
    TrangThai = requests.args.get('TrangThai')
    MaDH = request.args.get('MaDH')
    sql = """
    UPDATE `QLBanQuanAo`.`DonHang`
    Set TrangThai = %s
    Where MaDH = %s
    """
    cursor.execute(sql, (TrangThai, MaDH))
    conn.commit()
    cursor.close()
    conn.close()
