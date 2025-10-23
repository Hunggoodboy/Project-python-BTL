from flask import Blueprint, session, render_template

home_bp = Blueprint('home_bp', __name__)
@home_bp.route('/home')
def home():
    hoten = session.get('hoten')
    return render_template('MenuBar.html', hoten=hoten)
