from flask import Blueprint, render_template, session
from datetime import date, datetime
from database.connect import get_connect

revenue_bp = Blueprint("revenue_bp", __name__)

@revenue_bp.route("/admin/revenue")
def admin_revenue():
    conn = get_connect()
    cursor = conn.cursor()

    today = date.today()
    current_day = today.strftime("%Y-%m-%d")
    current_month = today.strftime("%Y-%m")
    current_year = today.strftime("%Y")

    # Kiểm tra nếu chưa có doanh thu hôm nay -> khởi tạo 0
    cursor.execute("SELECT COUNT(*) FROM DoanhThu WHERE Ngay=%s", (current_day,))
    if cursor.fetchone()[0] == 0:
        cursor.execute("""
            INSERT INTO DoanhThu (Ngay, DoanhThuHomNay, DoanhThuTheoThang, DoanhThuTheoNam, Thang, Nam)
            VALUES (%s, 0, 0, 0, %s, %s)
        """, (current_day, current_month, current_year))
        conn.commit()

    # Lấy dữ liệu doanh thu để render
    cursor.execute("SELECT * FROM DoanhThu WHERE Ngay=%s", (current_day,))
    revenue = cursor.fetchone()

    conn.close()
    return render_template("adminrevenue.html", revenue=revenue)
