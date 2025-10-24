from flask import Blueprint

add_to_cartbp = Blueprint('add_to_cart', __name__)

@add_to_cartbp.route('/add_to_cart', methods=['POST'])

def add_to_cart():
