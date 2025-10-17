import flask
from flask import Blueprint, render_template, request, redirect
from database.connect import get_connect

size_bp = Blueprint('size', __name__)

@size_bp.route('/size')
def size_help():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("USE QLBanQuanAo")
    cursor.execute("SELECT * from SizePhuNu")
    sizes = cursor.fetchall()
    conn.close()
    return render_template('sizeManual.html', sizes = sizes)