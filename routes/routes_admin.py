from flask import Blueprint, redirect, render_template, url_for, request, session, flash
from datetime import date
from database.connect import get_connect

from routes.routes_admin_product import admin_product_bp
from routes.routes_admin_user import admin_user_bp

admin_bp = Blueprint('admin', __name__)

admin_bp.register_blueprint(admin_product_bp)
admin_bp.register_blueprint(admin_user_bp)

@admin_bp.route('/admin')
def admin_page():
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM qlbanquanao.sanpham")
    products = cursor.fetchall()
    cursor.execute("SELECT * FROM qlbanquanao.khachhang")
    users = cursor.fetchall()
    cursor.close()
    return render_template('admin.html', products=products, users=users)

@admin_bp.route("/admin/revenue")
def admin_revenue():
    conn = get_connect()
    cursor = conn.cursor()

    # Tạo doanh thu hôm nay nếu chưa có
    today = date.today().strftime("%Y-%m-%d")
    cursor.execute("SELECT Ngay FROM DoanhThu WHERE Ngay=%s", (today,))
    if cursor.fetchone() is None:
        cursor.execute("""
            INSERT INTO DoanhThu (Ngay, DoanhThuHomNay)
            VALUES (%s, 0)
        """, (today,))
        conn.commit()

    # Lấy toàn bộ doanh thu
    cursor.execute("""
        SELECT Ngay, DoanhThuHomNay
        FROM DoanhThu
        ORDER BY Ngay DESC
    """)
    doanhthu = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template("adminrevenue.html", doanhthu=doanhthu)

