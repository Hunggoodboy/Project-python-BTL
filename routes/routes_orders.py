from flask import Blueprint, render_template

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders')
def orders_page():
    all_orders = [
        {
            "id": 1,
            "MaSP": 1001,
            "TenSP": "Áo Thun Cotton Basic",
            "Gia": 199000,
            "SoLuong": 1,
            "TrangThai": "Chờ xác nhận đơn",
            "HinhAnh": "anh_quan_ao/ao/ao_thun_basic.png"
        },
        {
            "id": 2,
            "MaSP": 1015,
            "TenSP": "Sơ Mi Linen Tay Lửng",
            "Gia": 420000,
            "SoLuong": 1,
            "TrangThai": "Đang giao hàng",
            "HinhAnh": "anh_quan_ao/ao/so_mi_linen_tay_lung.jpg"
        },
        {
            "id": 3,
            "MaSP": 2001,
            "TenSP": "Quần Jeans Slim-fit",
            "Gia": 650000,
            "SoLuong": 1,
            "TrangThai": "Đã giao thành công",
            "HinhAnh": "anh_quan_ao/quan/quan_jean_slim_fit.jpg"
        },
        {
            "id": 4,
            "MaSP": 3006,
            "TenSP": "Túi Đeo Chéo Mini",
            "Gia": 220000,
            "SoLuong": 2,
            "TrangThai": "Đã hủy đơn",
            "HinhAnh": "anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg"
        },
        {
            "id": 5,
            "MaSP": 3013,
            "TenSP": "Mũ Snapback Thể Thao",
            "Gia": 150000,
            "SoLuong": 1,
            "TrangThai": "Chờ xác nhận đơn",
            "HinhAnh": "anh_quan_ao/phu_kien/mu_snapback_the_thao.jpg"
        }
    ]

    # Bỏ đã hủy đơn:
    valid_orders = [order for order in all_orders if order["TrangThai"] != "Đã hủy đơn"]

    return render_template('my_orders.html', orders=valid_orders)
