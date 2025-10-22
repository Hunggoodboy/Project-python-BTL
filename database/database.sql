
CREATE DATABASE IF NOT EXISTS QLBanQuanAo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE QLBanQuanAo;

-- Bảng 1: Khách hàng
CREATE TABLE IF NOT EXISTS KhachHang(
    MaKH INT AUTO_INCREMENT PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    UserName NVARCHAR(100) NOT NULL UNIQUE,
    MatKhau NVARCHAR(100) NOT NULL,
    SDT VARCHAR(10) NOT NULL,
    Address NVARCHAR(100)
);

-- Bảng 2: Danh Mục (Ban đầu)
CREATE TABLE IF NOT EXISTS DanhMuc(
    MaDM INT PRIMARY KEY,
    TenDM NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(100),
    MaDMCha INT NULL,
    CONSTRAINT fk_dm_cha FOREIGN KEY (MaDMCha) REFERENCES DanhMuc(MaDM)
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
    HinhAnh varchar(100),
    Season varchar(20)
);
ALTER TABLE SanPham
MODIFY COLUMN Season VARCHAR(50);
ALTER TABLE SanPham MODIFY HinhAnh VARCHAR(255);
ALTER TABLE SanPham
ADD COLUMN Sold INT DEFAULT 0,
ADD COLUMN Discount INT;

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
    NgangVai DECIMAL(10 , 1 ),
    VongNguc DECIMAL(10 , 1 ),
    TayAo DECIMAL(10 , 1 ),
    Eo DECIMAL(10 , 1 ),
    Hong DECIMAL(10 , 1 ),
    DaiQuan DECIMAL(10 , 1 ),
    ChieuCao NVARCHAR(100),
    CanNang NVARCHAR(100)
);
