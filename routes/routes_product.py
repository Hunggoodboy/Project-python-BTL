from flask import Blueprint, render_template
from database.connect import get_connect

product_bp = Blueprint('product', __name__, url_prefix='/product')

@product_bp.route("/product/<int:pid>")
def product_detail(pid):
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM SanPham WHERE MaSP = %s", (pid,))
    product = cursor.fetchone()
    cursor.close()
    conn.close()

    if product:
        product['Sold'] = product.get('Sold', 0)
        product['Discount'] = product.get('Discount', 0)
        product['HinhAnh'] = product.get('HinhAnh', '/static/images/default.png')
        product['Season'] = product.get('Season', 'All')

        # Tính giá sau giảm
        product['GiaSauGiam'] = int(product['Gia'] * (100 - product['Discount']) / 100)

        # tách ảnh phụ
        path = product['HinhAnh'] #vd: anh_quan_ao/ao/ao_thun_basic.png
        if '/ao/' in path:
            subdir = 'anh_phu_ao'
        elif '/quan/' in path:
            subdir = 'anh_phu_quan'
        else:
            subdir = 'anh_phu_phu_kien'

        sep = path.split('/')
        newpath = '/'.join([sep[0], subdir, sep[-1]]) #vd: anh_quan_ao/anh_phu_ao/ao_thun_basic.png
        colors = [c.strip() for c in product['MauSac'].split(',')]
        product['colors'] = [
            {
                'name': color,
                'image': f"{newpath.rsplit('.', 1)[0]}_{i + 1}.jpg"
            }
            for i, color in enumerate(colors)
        ]

        # tách size sản phẩm
        product['sizes'] =  [s.strip() for s in product['Size'].split(',')]

        print("\n==== PRODUCT DEBUG ====")
        print(product)
        print("product['MaSP'] =", product.get('MaSP'))
        print("product['id'] =", product.get('MaSP'))
        print("product['colors'] =", product.get('colors'))
        print("========================\n")

        return render_template('productDetail.html', product=product)

    return "Không tìm thấy sản phẩm"
