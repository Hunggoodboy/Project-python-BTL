from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class DanhMuc(db.Model):
    __tablename__ = 'DanhMuc'
    MaDM = db.Column(db.Integer, primary_key=True)
    TenDM = db.Column(db.String(100), nullable=False)
    MoTa = db.Column(db.String(100), nullable=False)
