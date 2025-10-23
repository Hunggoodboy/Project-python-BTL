import flask
from flask import Blueprint, render_template, request, redirect
from database.connect import get_connect

size_bp = Blueprint('size', __name__)

@size_bp.route('/size')
def size_help():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("USE QLBanQuanAo")
    #bảng size phụ nữ
    cursor.execute("SELECT * from SizePhuNu")
    sizes_pn = cursor.fetchall()
    #bảng size đàn ông
    cursor.execute("SELECT * from SizeDanOng")
    sizes_do = cursor.fetchall()
    conn.close()
    return render_template('sizeManual.html', sizes_pn = sizes_pn, sizes_do = sizes_do)