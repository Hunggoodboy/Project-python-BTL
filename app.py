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
from routes.routes_collections import collections_bp
"""
from routes.routes_edit_user import edit_userbp
from routes.routes_admin_product import addproduct_bp
from routes.routes_edit_product import edit_productbp
from routes.routes_delete_user import delete_userbp
from routes.routes_delete_product import delete_productbp
"""
from routes.routes_admin import admin_bp

from routes.routes_show_product import show_productbp
from routes.routes_orders import orders_bp
from routes.routes_cart import cart_bp
from routes.routes_AI_chat import AI_chatbp
from routes.routes_quanlydonhang import qldonhangbp
from routes.routes_revenue import revenue_bp
import chromadb
import google.generativeai as genai
from google.generativeai.types import FunctionDeclaration, Tool
from build_vector_db import get_all_products_as_text


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
app.register_blueprint(collections_bp)
"""
app.register_blueprint(edit_userbp)
app.register_blueprint(edit_productbp)
app.register_blueprint(addproduct_bp)
app.register_blueprint(delete_productbp)
app.register_blueprint(delete_userbp)
"""
app.register_blueprint(admin_bp)


app.register_blueprint(show_productbp)
app.register_blueprint(orders_bp)
app.register_blueprint(cart_bp)
app.register_blueprint(AI_chatbp)
app.register_blueprint(qldonhangbp)
app.register_blueprint(revenue_bp)

@app.template_filter('vnd')
def vnd_format(value):
    return "{:,}₫".format(int(value)).replace(",", ".")

@app.route('/new-product')
def new_product():
    return render_template('newProduct.html')


# client = chromadb.PersistentClient(path="./my_vector_db")
# collection = client.get_or_create_collection(name="products")
#
#
#
# def search_products(query_text,name_product = None, min_price = None, max_price=None,season = None, category=None):
#     #get_all_products_as_text()
#     result = genai.embed_content(
#         model='models/text-embedding-004',
#         content=query_text,
#         task_type="RETRIEVAL_QUERY" # Quan trọng: nói cho AI biết đây là CÂU HỎI
#     )
#     query_vector = result['embedding']
#     filters = {}
#     if name_product:
#         filters['TenSP'] = {"$regex": name_product, "$options": "i"}
#     if min_price and max_price:
#         filters["Gia"] = {"$lte": min_price, "$gte": max_price}
#     if max_price:
#         filters["Gia"] = {"$lte": max_price}  # lte = less than or equal
#     if min_price:
#         filters["Gia"] = {"$gte": min_price}  # gte = greater than or equal
#     if season:
#         filters["Season"] = {"$regex": season, "$options": "i"}
#     if category:
#         filters["TenDM"] = {"$regex" : category, "$options": "i"}
#
#
#     results = collection.query(
#         query_embeddings=query_vector,
#         n_results=5,  # Lấy 5 kết quả gần nhất
#         where=filters if filters else None
#     )
#
#     return results['metadatas']
#
#
# search_products_tool = FunctionDeclaration(
#     name = "search_products",
#     description= "Tìm kiếm sản phẩm trong shop theo tên mô tả, danh muc và theo gía tiền",
#     parameters = {
#         "type" : "Object",
#         "properties" : {
#             "query_sanpham" : {
#                 "type" : "String",
#                 "description" : "Nội dung/Sản phẩm mà người dùng muốn tìm kiếm. Ví dụ: Áo khóac nam, Quần jean "
#             },
#             "season" : {
#                 "type" : "String",
#                 "description" : "Tìm kiếm sản phẩm theo mùa mà người dùng yêu cầu. Phải dịch sang tiếng anh ví dụ như : 'mùa đông' -> 'Winter' , 'mùa hè' -> 'Summer', 'mùa thu' -> 'Autumn', 'mùa xuân' -> 'Spring'"
#             },
#             "min_price" : {
#                 "type" : "Number",
#                 "description" : "Tìm kiếm sản phẩm có giá tiền lớn hơn người dùng nhập . Ví dụ là 150000 đồng"
#             },
#             "max_price" : {
#                 "type" : "Number",
#                 "description" : "Tìm kiếm sản phẩm có giá tiền ít hơn số tiền người dùng nhập. Ví dụ là 200000 đồng"
#             }
#         }
#     }
# )
#
# API_KEY = "AIzaSyCSuEwJLCPGYhpJC4pHrlqw-ylt3UUIio8"
#
# genai.configure(api_key=API_KEY)
# my_tools = Tool(function_declarations=[search_products_tool])
#
# model = genai.GenerativeModel(
#     model_name='gemini-pro', # Hoặc model bạn đang dùng
#     tools=[my_tools]        # <-- Đưa công cụ vào đây
# )

if __name__ == '__main__':
    # test_query = "Tìm kiếm áo mùa đông"
    # max_query = "Tìm kiếm đồ có giá lớn hơn 300000 đồng"
    # result = search_products(max_query)
    # print(result)
    app.run(debug=True, port=5003)