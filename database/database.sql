CREATE database IF NOT EXISTS QLBanQuanAo;

USE QLBanQuanAo;

CREATE TABLE IF NOT exists KhachHang(
	MaKH int primary key,
    HoTen nvarchar(100) NOT NULL,
    Email varchar(100) NOT NULL,
    MatKhau varchar(100) NOT NULL,
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

CREATE TABLE IF NOT EXISTS SizePhuNu (
	id INT PRIMARY KEY,
    MaSize VARCHAR(5) NOT NULL,
    NgangVai DECIMAL(10,1),
    VongNguc DECIMAL(10,1),
    TayAo DECIMAL(10,1),
    Eo  DECIMAL(10,1),
    Hong DECIMAL(10,1),
    DaiQuan DECIMAL(10,1),
    ChieuCao VARCHAR(100) CHARACTER SET utf8mb4,
    CanNang VARCHAR(100) CHARACTER SET utf8mb4
);

CREATE TABLE IF NOT EXISTS SizeDanOng (
	id INT PRIMARY KEY,
    MaSize VARCHAR(5) NOT NULL,
    NgangVai DECIMAL(10,1),
    VongNguc DECIMAL(10,1),
    TayAo DECIMAL(10,1),
    Eo  DECIMAL(10,1),
    Hong DECIMAL(10,1),
    DaiQuan DECIMAL(10,1),
    ChieuCao VARCHAR(100) CHARACTER SET utf8mb4,
    CanNang VARCHAR(100) CHARACTER SET utf8mb4
);