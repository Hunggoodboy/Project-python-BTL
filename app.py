from flask import Flask, render_template, request, redirect, url_for
#from DB_connect import get_db_connection
import os

app = Flask(__name__)

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/')
def main_menu():
    return render_template('mainMenu.html')

@app.route('/help')
def size_help():
    return render_template('sizeManual.html')


@app.route("/product")
def product_detail():
    # Lấy dữ liệu theo pid từ DB
    # product = get_product_by_id(pid)
    return render_template("productDetail.html")

@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')

@app.route('/collections')
def collections():
    return render_template('collections.html')

@app.route('/catalog')
def catalog():
    return render_template('catalog.html')

if __name__ == '__main__':
    app.run(debug=True)