import base64
from flask import Flask, render_template, request, redirect, url_for, session, flash
import os
from database.connect import get_connect

from routes.routes_main import main_bp

from routes.routes_register import register_bp
from routes.routes_login import login_bp
from routes.routes_logout import logout_bp

from routes.routes_navigation import navigation_bp
from routes.routes_size import size_bp
from routes.routes_search import search_bp

from routes.routes_product import product_bp

from routes.routes_admin import admin_bp
#from routes.routes_user import user_bp

from routes.routes_orders import orders_bp
from routes.routes_cart import cart_bp
from routes.routes_AI_chat import AI_chatbp
from routes.routes_quanlydonhang import qldonhangbp
from routes.routes_revenue import revenue_bp
import sys
import google.generativeai as genai

print("--- KIỂM TRA MÔI TRƯỜNG ---")
print(f"Đường dẫn Python đang chạy: {sys.executable}")
print(f"Phiên bản GenAI đang chạy: {genai.__version__}")
print("---------------------------")


app = Flask(__name__)
app.secret_key = '123456'

UPLOAD_FOLDER = os.path.join('static', 'images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

app.register_blueprint(main_bp)
app.register_blueprint(AI_chatbp)

app.register_blueprint(admin_bp)
#app.register_blueprint(user_bp)

app.register_blueprint(login_bp)
app.register_blueprint(logout_bp)
app.register_blueprint(register_bp)

app.register_blueprint(navigation_bp)
app.register_blueprint(size_bp)
app.register_blueprint(search_bp)
app.register_blueprint(product_bp)

app.register_blueprint(orders_bp)
app.register_blueprint(cart_bp)
app.register_blueprint(qldonhangbp)
app.register_blueprint(revenue_bp)

@app.template_filter('vnd')
def vnd_format(value):
    return "{:,}₫".format(int(value)).replace(",", ".")

if __name__ == '__main__':
    app.run(debug=True, port=5005)
