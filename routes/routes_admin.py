from flask import Blueprint, redirect, render_template, url_for, request, session, flash
from datetime import date
from database.connect import get_connect

from routes.routes_admin_product import admin_product_bp
from routes.routes_admin_user import admin_user_bp

admin_bp = Blueprint('admin', __name__)

admin_bp.register_blueprint(admin_product_bp)
admin_bp.register_blueprint(admin_user_bp)

@admin_bp.route('/admin')
def admin_page():
    if 'user_role' not in session or session['user_role'] != 'Admin':
        return redirect(url_for('menu.main_menu'))
    conn = get_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM qlbanquanao.sanpham")
    products = cursor.fetchall()
    cursor.execute("SELECT * FROM qlbanquanao.khachhang")
    users = cursor.fetchall()
    cursor.close()
    return render_template('admin.html', products=products, users=users)