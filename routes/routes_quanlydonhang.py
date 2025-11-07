import requests
from database.connect import get_connect
from flask import Blueprint, render_template, request

qldonhangbp = Blueprint('qldonhangbp', __name__)

qldonhangbp.route("/quanlydonhang", methods=["POST"])
def quanlydonhang():
    conn = get_connect()
    cursor = conn.cursor()
    sql = "select * from QLBanQuanAo.DonHang"
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adminorder.html', rows=rows)

qldonhangbp.route("/setTrangThai", methods=["POST"])
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
