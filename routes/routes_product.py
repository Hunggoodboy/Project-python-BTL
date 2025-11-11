from flask import Blueprint, render_template, url_for
from database.connect import get_connect

product_bp = Blueprint('product', __name__, url_prefix='/product')

@product_bp.route("/<int:pid>")
def product_detail(pid):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    #Lấy sản phẩm theo MaSP
    cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (pid,))
    product = cursor.fetchone()

    if not product:
        return "Không tìm thấy sản phẩm", 404

    # Giá trị mặc định
    product['Sold'] = product.get('Sold') or 0
    product['Discount'] = product.get('Discount') or 0
    product['HinhAnh'] = product.get('HinhAnh', 'images/default.png')
    product['Season'] = product.get('Season', 'All')

    # Tính giá sau giảm
    product['GiaSauGiam'] = int(product['Gia'] * (100 - product['Discount']) / 100)

    # Tạo danh sách ảnh và chuyển sang URL
    image_fields = ['HinhAnh', 'AnhPhu1', 'AnhPhu2', 'AnhPhu3', 'AnhPhu4']
    images = []
    for f in image_fields:
        if product.get(f):
            # Thêm url_for nếu file KHÔNG chứa /static/
            path = product[f]
            if not path.startswith("static/") and not path.startswith("/static/"):
                path = url_for('static', filename=path)
            else:
                path = "/" + path.lstrip("/")
            images.append(path)
    product['images'] = images

    #Lấy dữ liệu màu từ bảng SanPhamMau
    cursor.execute("""
        select 
            tenmau,
            min(url_anh1) as url_anh1
        from SanPhamMau
        where id_sanpham = %s
        group by tenmau
    """, (pid,))
    color_rows = cursor.fetchall()

    product_colors = []

    for row in color_rows:
        # Lấy ảnh màu
        img_path = row['url_anh1']

        # Thêm vào danh sách
        product_colors.append({
            "name": row["tenmau"],
            "image": img_path
        })
    product['colors'] = product_colors

    #Lấy SIZE
    product['sizes'] = [s.strip() for s in product.get('Size', '').split(',') if s.strip()]

    cursor.close()
    conn.close()

    return render_template('productDetail.html', product=product)