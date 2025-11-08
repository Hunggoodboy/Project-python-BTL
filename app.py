import base64
from database.connect import get_connect
import flask
from flask import Flask, render_template, request, redirect, url_for, session, flash
#from DB_connect import get_db_connection
import os
from database.connect import get_connect
from routes.routes_catalog import catalog_bp
from routes.routes_register import register_bp
from routes.routes_login import login_bp
from routes.routes_category import category_bp
from routes.routes_product import product_bp
from routes.routes_main import main_bp
from routes.routes_category import category_bp
from routes.routes_size import size_bp
from routes.routes_search import search_bp
from routes.routes_logout import logout_bp
from routes.routes_productdetail import productdetail_bp
from routes.routes_home import home_bp
from routes.routes_collections import collections_bp
from routes.routes_edit_user import edit_userbp
from routes.routes_add_product import addproduct_bp
from routes.routes_edit_product import edit_productbp
from routes.routes_delete_user import delete_userbp
from routes.routes_delete_product import delete_productbp
from routes.routes_show_product import show_productbp
from routes.routes_orders import orders_bp
from routes.routes_cart import cart_bp
from routes.routes_AI_chat import AI_chatbp
from routes.routes_quanlydonhang import qldonhangbp

app = Flask(__name__)
app.secret_key = '123456'

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.register_blueprint(main_bp)
app.register_blueprint(login_bp)
app.register_blueprint(register_bp)
app.register_blueprint(category_bp)
app.register_blueprint(product_bp)
app.register_blueprint(catalog_bp)
app.register_blueprint(size_bp)
app.register_blueprint(search_bp)
app.register_blueprint(logout_bp)
app.register_blueprint(productdetail_bp, url_prefix='/product')
app.register_blueprint(home_bp)
app.register_blueprint(collections_bp)
app.register_blueprint(edit_userbp)
app.register_blueprint(edit_productbp)
app.register_blueprint(addproduct_bp)
app.register_blueprint(delete_productbp)
app.register_blueprint(delete_userbp)
app.register_blueprint(show_productbp)
app.register_blueprint(orders_bp)
app.register_blueprint(cart_bp)
app.register_blueprint(AI_chatbp)
app.register_blueprint(qldonhangbp)

@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')

@app.route('/ShowUser')
def show_user():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("select * from QLBanQuanAo.KhachHang")
    users = cursor.fetchall()
    cursor.close()
    return render_template('ShowUser.html', users=users)


@app.route('/product')
def show_product():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM qlbanquanao.sanpham")
    products = cursor.fetchall()
    cursor.close()
    print("tat ca san pham", products)
    return render_template('ProductTable.html', products=products)




if __name__ == '__main__':
    app.run(debug=True, port=5006)