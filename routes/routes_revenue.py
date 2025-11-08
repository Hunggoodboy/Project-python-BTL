from flask import Blueprint, render_template
from datetime import date
from database.connect import get_connect

revenue_bp = Blueprint("revenue_bp", __name__)



@revenue_bp.route("/admin/revenue")
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
