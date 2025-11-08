from database.connect import get_connect
from flask import Blueprint, render_template, request

revenuebp = Blueprint('revenuebp', __name__)


# route lấy doanh thu mỗi ngày
@revenuebp.route('/getRevenue_daily', methods=['POST'])
def getRevenue_daily():
    connect = get_connect()
    cursor = connect.cursor()
    sql = """
    Select
    DATE(`Time`) as ngaytao,
    Sum(TongGia) as doanhthu
    FROM QLBanQuanAo.DonHang
    Group by Date(`Time`)
    """
    sql = """
    SELECT * FROM QLBanQuanAo.doanhthu
    """
    cursor.execute(sql)
    row = cursor.fetchall()
    return render_template('adminrevenue.html', rows = row)


#route lấy doanh thu theo thời gian nhất định


@revenuebp.route('/getRevenue_DayOnRequest', methods=['GET', 'POST'])
def getRevenue_DayOnRequest():

    day = request.args.get('day')
    connect = get_connect()
    cursor = connect.cursor()
    sql = """
        SELECT
        DATE(`Time`) as ngaytao,
        SUM(TongGia) as doanhthu
        FROM QLBanQuanAo.DonHang
        WHERE DATE(`Time`) = %s
        GROUP BY DATE(`Time`)
    """
    cursor.execute(sql, [day])
    row = cursor.fetchall()
    return render_template('adminrevenue.html', rows = row)
