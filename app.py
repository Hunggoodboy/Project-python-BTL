import base64
from database.connect import get_connect
import flask
from flask import Flask, render_template, request, redirect, url_for, session
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
from routes.routes_logout import logout_bp
from routes.routes_productdetail import productdetail_bp

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
app.register_blueprint(logout_bp)
app.register_blueprint(productdetail_bp)

@app.route('/help')
def size_help():
    return render_template('sizeManual.html')
@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')
@app.route('/collections')
def collections():
    return render_template('collections.html')

@app.route('/ShowUser')
def show_user():
    conn = get_connect()
    cursor = conn.cursor()
    cursor.execute("select * from QLBanQuanAo.KhachHang")
    users = cursor.fetchall()
    cursor.close()
    return render_template('ShowUser.html', users=users)

@app.route("/register")
def register():
    return render_template('register.html')

if __name__ == '__main__':
    app.run(debug=True, port=5001)