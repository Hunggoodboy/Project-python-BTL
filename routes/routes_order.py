from flask import Blueprint, render_template

order_bp = Blueprint('order', __name__, url_prefix='/orders')

sample_orders = [
    {
        "HinhAnh": "anh_quan_ao/ao/ao_thun_oversize.jpg",
        "TenSP": "Áo Thun Oversize",
        "Gia": 250000,
        "SoLuong": 2,
        "TrangThai": "Chờ xác nhận đơn"
    },
    {
        "HinhAnh": "anh_quan_ao/ao/so_mi_linen_tay_lung.jpg",
        "TenSP": "Sơ Mi Linen Tay Lửng",
        "Gia": 420000,
        "SoLuong": 1,
        "TrangThai": "Chờ lấy hàng"
    },
    {
        "HinhAnh": "anh_quan_ao/quan/quan_jean_slim_fit.jpg",
        "TenSP": "Quần Jeans Slim-fit",
        "Gia": 650000,
        "SoLuong": 1,
        "TrangThai": "Đã giao thành công"
    },
    {
        "HinhAnh": "anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg",
        "TenSP": "Túi Đeo Chéo Mini",
        "Gia": 220000,
        "SoLuong": 3,
        "TrangThai": "Chờ giao hàng"
    }
]

@order_bp.route("/")
def my_orders():
    return render_template("my_orders.html", orders=sample_orders)
