from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class DanhMuc(db.Model):
    __tablename__ = 'DanhMuc'
    MaDM = db.Column(db.Integer, primary_key=True)
    TenDM = db.Column(db.String(100), nullable=False)
    MoTa = db.Column(db.String(100), nullable=False)

class SanPham(db.Model):
    __tablename__ = 'SanPham'
    MaSP = db.Column(db.Integer, primary_key=True)
    MaDM = db.Column(db.Integer, db.ForeignKey('DanhMuc.MaDM'))
    TenSP = db.Column(db.String(255), nullable=False)
    MoTa = db.Column(db.Text, nullable=True)
    Gia = db.Column(db.Integer, nullable=False)
    MauSac = db.Column(db.String(255), nullable=True)
    Size = db.Column(db.String(100), nullable=True)
    ChatLieu = db.Column(db.String(255), nullable=True)
    SoLuongCon = db.Column(db.Integer, nullable=False, default=0)
    HinhAnh = db.Column(db.String(255), nullable=True)
    Season = db.Column(db.String(50), nullable=True)
    Sold = db.Column(db.Integer, nullable=False, default=0)
    Discount = db.Column(db.Integer, nullable=False, default=0)