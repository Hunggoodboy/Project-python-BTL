
from flask import Blueprint, session, render_template

logout_bp = Blueprint('logout', __name__)

@logout_bp.route('/logout')
def logout():
    session['logged_in'] = False
    session.clear()
    return render_template('mainMenu.html')