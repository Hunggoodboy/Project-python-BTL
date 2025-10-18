from flask import Blueprint, session, render_template

homebp = Blueprint('home', __name__)
@homebp.route('/home')
def home():
    hoten = session.get('hoten')
    return render_template('MenuBar.html', hoten=hoten)
