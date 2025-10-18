from flask import Blueprint, render_template

productdetail_bp = Blueprint('productdetail', __name__)

products = [
    {
        "id": 1,
        "name": "Áo Cà Sa",
        "price": 2590000000,
        "discount": -15,
        "sold": 234,
        "images": [
            "https://cdn3.upanh.info/upload/server-sw3/product-acc/1816156/68cc2bb6c2a5d.webp",
            "https://vn-test-11.slatic.net/p/24a4ae0479b0d7d2659b4868fe76e881.jpg",
            "https://cf.shopee.vn/file/5386246b6a61702d6c35c7b558160291",
            "https://streetvibe.vn/wp-content/uploads/2022/03/2-4.jpg"
        ],
        "colors": [
            {"name": "Đen", "image": "https://vn-test-11.slatic.net/p/24a4ae0479b0d7d2659b4868fe76e881.jpg"},
            {"name": "Trắng", "image": "https://cf.shopee.vn/file/5386246b6a61702d6c35c7b558160291"}
        ],
        "stock": 5,
        "sizes": ["S", "M", "L", "XL"],
        "shipping_info": "Dự kiến giao hàng trong 365 năm.",
        "description": "NGON!!!",
        "rating": 200.0,
        "review_count": 124,
        "comments": [
            {"user": "Ngân 98", "text": "Húpppp!!"},
            {"user": "Ngân 89", "text": "Như CC!"}
        ]
    },
    {
        "id": 2,
        "name": "Áo Cà Sa",
        "price": 8087876000000,
        "discount": -95,
        "sold": 23989794,
        "images": [
            "https://cdn3.upanh.info/upload/server-sw3/product-acc/1816153/68cc2b653d313.webp",
            "https://vn-test-11.slatic.net/p/24a4ae0479b0d7d2659b4868fe76e881.jpg",
            "https://cf.shopee.vn/file/5386246b6a61702d6c35c7b558160291",
            "https://streetvibe.vn/wp-content/uploads/2022/03/2-4.jpg"
        ],
        "colors": [
            {"name": "Đen", "image": "https://vn-test-11.slatic.net/p/24a4ae0479b0d7d2659b4868fe76e881.jpg"},
            {"name": "Trắng", "image": "https://cf.shopee.vn/file/5386246b6a61702d6c35c7b558160291"}
        ],
        "stock": 7,
        "sizes": ["S", "M", "L", "XL"],
        "shipping_info": "Dự kiến giao hàng trong 2555 năm.",
        "description": "NGON!!!",
        "rating": 206.0,
        "review_count": 674,
        "comments": [
            {"user": "Ngân 99", "text": "Húpppp!!"},
            {"user": "Ngân 97", "text": "Như CC!"}
        ]
    }
]

@productdetail_bp.route('/shop')
def shop():
    return render_template('shop.html', products=products)
@productdetail_bp.route('/product/<int:id>')
def productdetail(id):
    product = next((p for p in products if p['id'] == id), None)
    if not product:
        return "Sản phẩm không tồn tại", 404
    return render_template('productdetail.html', product=product)

@productdetail_bp.route('/sizechart')
def sizechart():
    return render_template('sizechart.html')
