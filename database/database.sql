CREATE database IF NOT EXISTS QLBanQuanAo;

USE QLBanQuanAo;

CREATE TABLE IF NOT exists KhachHang(
	MaKH int auto_increment primary key,
    HoTen nvarchar(100) NOT NULL,
    UserName nvarchar(100) NOT NULL,
    MatKhau nvarchar(100) NOT NULL,
    SDT varchar(10) NOT NULL,
    Address nvarchar(100)
);

CREATE TABLE IF NOT EXISTS DanhMuc(
	MaDM int Primary KEY,
    TenDM nvarchar(100) NOT NULL,
    MoTa nvarchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS SanPham(
	MaSP int primary key,
    MaDM int,
    foreign key(MaDM) references DanhMuc(MaDM),
    TenSP nvarchar(100),
    MoTa nvarchar(100),
    Gia float,
    MauSac nvarchar(100),
    Size nvarchar(100),
    ChatLieu nvarchar(100),
    SoLuongcon int,
    HinhAnh LONGBLOB
);

CREATE TABLE IF NOT EXISTS DonHang(
	MaDH int primary key,
    MaSP int,
    MaKH int,
    foreign key(MaSP) references SanPham(MaSP),
    foreign key(MaKH) references KhachHang(MaKH),
    SoLuong int,
    DonGia int,
    TongGia int
);

