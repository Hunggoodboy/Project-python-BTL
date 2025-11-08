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
SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE DanhMuc
ADD COLUMN MaDMCha INT NULL,
ADD CONSTRAINT fk_dm_cha FOREIGN KEY (MaDMCha) REFERENCES DanhMuc(MaDM);

SET FOREIGN_KEY_CHECKS = 1;

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
    HinhAnh varchar(100),
    Season nvarchar(10)
);

CREATE TABLE IF NOT EXISTS DonHang(
	MaDH INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    MaSP int,
    MaKH int,
    Mau VARCHAR(50) DEFAULT '',
    TrangThai VARCHAR(50) DEFAULT 'Chờ xác nhận đơn',
    foreign key(MaSP) references SanPham(MaSP),
    foreign key(MaKH) references KhachHang(MaKH),
    SoLuong int,
    DonGia int,
    TongGia int,
    'Time' datetime
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
    ChieuCao NVARCHAR(100),
    CanNang NVARCHAR(100)
);
ALTER TABLE SanPham
ADD COLUMN AnhPhu1 VARCHAR(255),
ADD COLUMN AnhPhu2 VARCHAR(255),
ADD COLUMN AnhPhu3 VARCHAR(255),
ADD COLUMN AnhPhu4 VARCHAR(255);
