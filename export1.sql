-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: qlbanquanao
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `danhmuc`
--

DROP TABLE IF EXISTS `danhmuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danhmuc` (
  `MaDM` int NOT NULL,
  `TenDM` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MoTa` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NgayNhapHang` date DEFAULT NULL,
  `MaDMCha` int DEFAULT NULL,
  PRIMARY KEY (`MaDM`),
  KEY `fk_dm_cha` (`MaDMCha`),
  CONSTRAINT `fk_dm_cha` FOREIGN KEY (`MaDMCha`) REFERENCES `danhmuc` (`MaDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danhmuc`
--

LOCK TABLES `danhmuc` WRITE;
/*!40000 ALTER TABLE `danhmuc` DISABLE KEYS */;
INSERT INTO `danhmuc` VALUES (100,'Áo (Tất Cả)','Các loại áo mặc thân trên.',NULL,NULL),(101,'Áo Thun Cơ Bản','Áo phông cổ tròn, cổ tim, tối giản.',NULL,100),(102,'Áo Sơ Mi','Sơ mi classic, linen, oxford.',NULL,100),(103,'Áo Khoác','Hoodie, Sweater, Cardigan, Khoác Gió.',NULL,100),(104,'Áo Len','Các loại áo len.',NULL,100),(105,'Áo Khoác Dày','Áo khoác phao, dạ.',NULL,100),(200,'Quần & Váy (Tất Cả)','Các loại quần và váy.',NULL,NULL),(201,'Quần Dài','Jeans, Kaki, Jogger, Quần âu.',NULL,200),(202,'Quần Ngắn','Short Kaki, Short Thun.',NULL,200),(203,'Chân Váy','Chân váy chữ A, chân váy suông (dành cho Nữ).',NULL,200),(300,'Phụ Kiện (Tất Cả)','Các vật dụng đi kèm.',NULL,NULL),(301,'Túi & Ví','Ví da, túi tote, túi đeo chéo thiết kế trung tính.',NULL,300),(302,'Mũ & Vớ','Các loại mũ, vớ cơ bản.',NULL,300);
/*!40000 ALTER TABLE `danhmuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doanhthu`
--

DROP TABLE IF EXISTS `doanhthu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doanhthu` (
  `Ngay` date NOT NULL,
  `DoanhThuHomNay` int DEFAULT '0',
  `DoanhThuTheoThang` int DEFAULT '0',
  `DoanhThuTheoNam` int DEFAULT '0',
  `Thang` varchar(7) DEFAULT NULL,
  `Nam` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`Ngay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doanhthu`
--

LOCK TABLES `doanhthu` WRITE;
/*!40000 ALTER TABLE `doanhthu` DISABLE KEYS */;
INSERT INTO `doanhthu` VALUES ('2025-11-11',2680000,2680000,2680000,'2025-11','2025');
/*!40000 ALTER TABLE `doanhthu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `doanhthu_theongay`
--

DROP TABLE IF EXISTS `doanhthu_theongay`;
/*!50001 DROP VIEW IF EXISTS `doanhthu_theongay`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `doanhthu_theongay` AS SELECT 
 1 AS `ngaytao`,
 1 AS `doanhthu`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `donhang`
--

DROP TABLE IF EXISTS `donhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donhang` (
  `MaDH` int NOT NULL AUTO_INCREMENT,
  `MaSP` int DEFAULT NULL,
  `MaKH` int DEFAULT NULL,
  `SoLuong` int DEFAULT NULL,
  `DonGia` int DEFAULT NULL,
  `TongGia` int DEFAULT NULL,
  `TrangThai` varchar(45) DEFAULT NULL,
  `TongGiaDaGiam` int DEFAULT NULL,
  `Mau` varchar(45) DEFAULT NULL,
  `Size` varchar(45) DEFAULT NULL,
  `Time` datetime DEFAULT NULL,
  `DaTinhDoanhThu` tinyint DEFAULT '0',
  PRIMARY KEY (`MaDH`),
  KEY `MaSP` (`MaSP`),
  KEY `MaKH` (`MaKH`),
  CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`),
  CONSTRAINT `donhang_ibfk_2` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donhang`
--

LOCK TABLES `donhang` WRITE;
/*!40000 ALTER TABLE `donhang` DISABLE KEYS */;
INSERT INTO `donhang` VALUES (1,1012,6,1,NULL,NULL,'Đang Xử Lý',250000,'',NULL,NULL,0),(2,1011,6,1,NULL,NULL,'Đang Xử Lý',330000,'',NULL,NULL,0),(3,1003,6,1,NULL,NULL,'Đang Xử Lý',290000,'',NULL,NULL,0),(4,1004,6,1,NULL,NULL,'Đang Xử Lý',550000,'',NULL,NULL,0),(5,1004,6,1,NULL,NULL,'Đang Xử Lý',550000,'Kem',NULL,NULL,0),(6,1004,18,1,NULL,NULL,'Đã hủy',550000,'Xám tro',NULL,NULL,0),(7,1003,18,1,290000,290000,'Đã giao thành công',NULL,'',NULL,NULL,0),(8,1003,18,1,290000,290000,'Đã giao thành công',NULL,'Trắng',NULL,NULL,0),(9,1004,18,1,550000,550000,'Chờ bạn xác nhận',NULL,'',NULL,'2025-11-08 13:01:15',0),(10,1001,18,1,199000,199000,'Chờ bạn xác nhận',NULL,'Xám',NULL,'2025-11-08 13:01:22',0),(11,1012,18,1,250000,250000,'Chờ bạn xác nhận',NULL,'Đen',NULL,'2025-11-08 13:01:30',0),(16,2004,19,5,280000,1400000,'Đã giao thành công',NULL,'Xanh mint','30','2025-11-11 12:48:08',1),(17,2004,19,3,280000,840000,'Chờ bạn xác nhận',NULL,'Xanh mint','32','2025-11-11 12:48:03',0),(18,2008,19,4,320000,1280000,'Đã giao thành công',NULL,'Nâu','','2025-11-11 12:48:56',1),(19,1008,18,3,270000,810000,'Đã hủy',NULL,'Xanh Dương','XL','2025-11-11 12:58:01',0),(20,1002,19,3,450000,1350000,'Đã hủy',NULL,'Xanh Navy','L','2025-11-11 20:00:03',0);
/*!40000 ALTER TABLE `donhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giohang`
--

DROP TABLE IF EXISTS `giohang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giohang` (
  `MaKH` int NOT NULL,
  `MaSP` int NOT NULL,
  `SoLuong` int DEFAULT NULL,
  `MauSacDaChon` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `KichCoDaChon` varchar(10) NOT NULL,
  PRIMARY KEY (`MaKH`,`MaSP`,`MauSacDaChon`,`KichCoDaChon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giohang`
--

LOCK TABLES `giohang` WRITE;
/*!40000 ALTER TABLE `giohang` DISABLE KEYS */;
INSERT INTO `giohang` VALUES (19,1002,4,'Be','M'),(19,1008,8,'Trắng','S'),(19,1009,3,'Be','M'),(19,1009,2,'Đen','M');
/*!40000 ALTER TABLE `giohang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `MaKH` int NOT NULL AUTO_INCREMENT,
  `HoTen` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `MatKhau` varchar(100) NOT NULL,
  `SDT` varchar(10) NOT NULL,
  `Address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,'Hungg','Hung6903','123456','0966439277','Hà Nội','Client'),(2,'Hungg','Hung6903','1234','0966439277','Hà Nội','Client'),(3,'Hungg','Hung6903','123456','0966439277','Hà Nội','Client'),(4,'123','q','q','1234','123','Client'),(5,'Nguyễn Xuân Hùng','Hung452005','123456789','0966439277','Hà Nội','Client'),(6,'Nguyễn Xuân Hùng','Hung452005','123456','0966439277','Hà Nội','Client'),(7,'Nguyễn Xuân','sdfsdf1','123','24352','0924241','Client'),(8,'Nguyễn Hùng','hfdg','123123','0593224','Hà Nội ','Client'),(9,'hung','wsadas','2131232','123123','sfas','Client'),(10,'qweqwe','aeqw','weqweqwe','qweqwe','qweqweq','Client'),(11,'qewqeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe','Client'),(12,'qewqeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe','Client'),(13,'asd','asdasd','asdads','asdasd','asdads','Client'),(14,'qưeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe','Client'),(15,'Nguyễn Xuân Hùng','Hungmk2005@gmail.com','123456789','0966439277','Hà Nội','Client'),(16,'Hùng','hung@gmail.com','123456789','01239123','Triều Khúc, Hà Nội','Client'),(17,'fhfghf','ưer','sdfsdf','32243','sdfsds','Client'),(18,'Admin','Admin_03','admin_nhom3','0966439277','Hà Nội','Admin'),(19,'my','mail@mail.com','123456','08888','diachi1','Client');
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mau`
--

DROP TABLE IF EXISTS `mau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mau` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ten_mau` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tên màu chuẩn hóa',
  `ma_hex` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mã màu hex (tùy chọn)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ten_mau` (`ten_mau`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mau`
--

LOCK TABLES `mau` WRITE;
/*!40000 ALTER TABLE `mau` DISABLE KEYS */;
INSERT INTO `mau` VALUES (1,'Trắng','#FFFFFF'),(2,'Đen','#000000'),(3,'Xám','#808080'),(4,'Hồng','#FFC0CB'),(5,'Be','#F5F5DC'),(6,'Xanh Navy','#000080'),(7,'Xanh Dương','#0000FF'),(8,'Xanh Nhạt','#ADD8E6'),(9,'Xanh rêu','#6B8E23'),(10,'Xanh Olive','#556B2F'),(11,'Xanh mint','#98FF98'),(12,'Xanh Đậm','#00008B'),(13,'Xanh Denim','#1560BD'),(14,'Nâu','#A52A2A'),(15,'Nâu Đậm','#654321'),(16,'Xám tro','#C0C0C0'),(17,'Kem','#FFFDD0'),(18,'Xám Melange','#A9A9A9'),(19,'Trắng ngà','#FFFFF0');
/*!40000 ALTER TABLE `mau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `revenue`
--

DROP TABLE IF EXISTS `revenue`;
/*!50001 DROP VIEW IF EXISTS `revenue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `revenue` AS SELECT 
 1 AS `GiaNgayHomNay`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sanpham`
--

DROP TABLE IF EXISTS `sanpham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanpham` (
  `MaSP` int NOT NULL,
  `MaDM` int DEFAULT NULL,
  `TenSP` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `MoTa` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Gia` float DEFAULT NULL,
  `MauSac` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Size` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ChatLieu` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SoLuongcon` int DEFAULT NULL,
  `HinhAnh` varchar(500) DEFAULT NULL,
  `Season` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Sold` int DEFAULT '0',
  `Discount` int DEFAULT NULL,
  `NgayNhap` datetime DEFAULT NULL,
  `AnhPhu1` varchar(100) DEFAULT NULL,
  `AnhPhu2` varchar(100) DEFAULT NULL,
  `AnhPhu3` varchar(100) DEFAULT NULL,
  `AnhPhu4` varchar(100) DEFAULT NULL,
  `AnhPhu5` varchar(100) DEFAULT NULL,
  `AnhPhu6` varchar(100) DEFAULT NULL,
  `AnhPhu7` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaSP`),
  KEY `MaDM` (`MaDM`),
  CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaDM`) REFERENCES `danhmuc` (`MaDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanpham`
--

LOCK TABLES `sanpham` WRITE;
/*!40000 ALTER TABLE `sanpham` DISABLE KEYS */;
INSERT INTO `sanpham` VALUES (1001,101,'Áo Thun Cotton Basic','Áo thun cổ tròn, form vừa, chất liệu thoáng mát, 100% Cotton.',199000,'Trắng, Đen, Xám','S, M, L, XL','Cotton 100%',350,'anh_quan_ao/ao/ao_thun_basic.png','Summer',0,17,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_thun_basic_1.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_2.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_3.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_4.jpg',NULL,NULL,NULL),(1002,102,'Sơ Mi Linen Cổ Điển','Áo Sơ mi dài tay, chất liệu linen mát, phù hợp cho mùa hè.',450000,'Be, Xanh Navy','S, M, L','Linen Tự Nhiên',120,'anh_quan_ao/ao/so_mi_len_co_dien.jpg','Summer',0,29,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_1.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_2.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_3.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_4.jpg',NULL,NULL,NULL),(1003,101,'Áo Polo Cotton Pique','Áo polo phom cơ bản, cổ dệt kim, chất liệu Pique thoáng khí.',290000,'Đen, Trắng, Xanh rêu','S, M, L, XL','Cotton Pique',250,'anh_quan_ao/ao/ao_polo_cotton_pique.jpg','Summer',0,41,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_1.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_2.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_3.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_4.jpg',NULL,NULL,NULL),(1004,103,'Áo Hoodie Nỉ Phom Rộng','Áo hoodie có mũ, phom rộng thoải mái, nỉ bông dày dặn.',550000,'Xám tro, Kem, Đen','M, L, XL','Nỉ Bông (Fleece)',180,'anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg','Winter',0,19,'2025-12-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_1.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_2.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_3.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_4.jpg',NULL,NULL,NULL),(1005,103,'Áo Khoác Gió Hai Lớp','Áo khoác ngoài nhẹ, chống nước nhẹ, có khóa kéo và mũ.',690000,'Xanh Navy, Be, Xám','S, M, L, XL','Polyester',100,'anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg','Winter',0,23,'2025-12-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_1.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_2.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_3.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_4.jpg',NULL,NULL,NULL),(1006,103,'Áo Len Mỏng Cổ Tròn','Áo len mỏng, form vừa, mềm mại, thoáng khí, phù hợp mùa thu.',320000,'Be, Nâu, Xám','S, M, L','Acrylic và Len',200,'anh_quan_ao/ao/ao_len_co_tron.jpg','Autumn',0,52,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_ao/ao_len_co_tron_1.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tron_2.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tron_3.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tron_4.jpg','anh_quan_ao/anh_mau/ao_len_co_tron_mau_da.jpg','anh_quan_ao/anh_mau/ao_len_co_tron_mau_xanh.jpg','anh_quan_ao/anh_mau/ao_len_co_tron_mau_xanh_la.jpg'),(1007,104,'Áo Len Cổ Tim','Áo len cổ tim, mỏng nhẹ, ấm áp khi mùa thu se lạnh.',360000,'Hồng, Be, Xám','S, M, L','Len Acrylic',210,'anh_quan_ao/ao/ao_len_co_tim.jpg','Spring',0,NULL,NULL,'anh_quan_ao/anh_phu_ao/ao_len_co_tim_1.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tim_2.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tim_3.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_tim_4.jpg','anh_quan_ao/anh_mau/ao_len_co_tim_mau_do.jpg','anh_quan_ao/anh_mau/ao_len_co_tim_mau_xam.jpg','anh_quan_ao/anh_mau/ao_len_co_tim_mau_xanh.jpg'),(1008,101,'Áo Thun Polo Ngắn Tay','Áo thun polo cổ bẻ, chất liệu cotton thoáng mát, form chuẩn.',270000,'Trắng, Xanh Dương, Đen','S, M, L, XL','Cotton 100%',220,'anh_quan_ao/ao/ao_thun_polo_ngan_tay.jpg','Summer',0,7,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_1.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_2.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_3.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_4.jpg',NULL,NULL,NULL),(1009,103,'Áo Khoác Cardigan Dài','Áo cardigan dệt kim dài, nhẹ nhàng, ấm áp, phong cách Hàn Quốc.',490000,'Xám, Đen, Be','S, M, L','Len tổng hợp',300,'anh_quan_ao/ao/ao_len_cardigan.jpg','Autumn',0,19,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_len_cardigan_1.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_2.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_3.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_4.jpg',NULL,NULL,NULL),(1010,105,'Áo Khoác Phao Lông Vũ','Áo khoác phao dày, giữ nhiệt tốt, chống gió cho mùa đông.',850000,'Đen, Xanh Navy','M, L, XL','Lông Vũ + Polyester',600,'anh_quan_ao/ao/ao_khoac_phao_long_vu.jpg','Winter',0,25,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_khoac_phao_long_vu_1.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_phao_long_vu_2.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_phao_long_vu_3.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_phao_long_vu_4.jpg','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_mau_be.jpg','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_mau_den.jpg','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_mau_trang.jpg'),(1011,102,'Sơ Mi Cộc Tay Kẻ Sọc','Áo Sơ mi ngắn tay, kẻ sọc thời trang, vải cotton thoáng mát.',330000,'Trắng, Xanh','S, M, L, XL','Cotton',180,'anh_quan_ao/ao/so_mi_coc_tay_ke_soc.jpeg','Summer',0,24,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_1.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_2.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_3.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_4.jpeg',NULL,NULL,NULL),(1012,101,'Áo Thun Oversize','Áo thun form rộng, chất liệu mềm, thoáng khí, màu sắc trẻ trung.',250000,'Trắng, Đen, Hồng','S, M, L, XL','Cotton 100%',280,'anh_quan_ao/ao/ao_thun_oversize.jpg','Spring',0,9,'2025-03-01 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1015,102,'Sơ Mi Linen Tay Lửng','Áo Sơ mi tay lửng, chất liệu linen thoáng mát, phù hợp mùa xuân hè.',420000,'Be, Xanh Nhạt','S, M, L','Linen',130,'anh_quan_ao/ao/so_mi_linen_tay_lung.jpg','Spring',0,28,'2025-03-01 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1017,103,'Áo Hoodie Mỏng','Áo hoodie mỏng, form rộng, phù hợp mùa thu se lạnh.',500000,'Xám, Đen, Be','S, M, L, XL','Nỉ mỏng',170,'anh_quan_ao/ao/ao_hoodie_mong.jpg','Autumn',0,11,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_1.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_2.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_3.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_4.jpg',NULL,NULL,NULL),(1018,104,'Áo Len Cổ Lọ','Áo len cổ lọ, giữ ấm nhẹ, phong cách thanh lịch cho mùa đông.',400000,'Đen, Xám, Nâu','S, M, L','Len Acrylic',320,'anh_quan_ao/ao/ao_len_co_lo.jpg','Winter',0,NULL,NULL,'anh_quan_ao/anh_phu_ao/ao_len_co_lo_1.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_lo_2.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_lo_3.jpg','anh_quan_ao/anh_phu_ao/ao_len_co_lo_4.jpg','anh_quan_ao/anh_mau/ao_len_co_lo_mau_den.jpg','anh_quan_ao/anh_mau/ao_len_co_lo_mau_xam.jpg','anh_quan_ao/anh_mau/ao_len_co_lo_mau_xanh.jpg'),(2001,201,'Quần Jeans Slim-fit','Quần jeans dáng đứng, tối giản, không rách.',650000,'Xanh Đậm, Đen','29, 30, 31, 32','Denim Co Giãn',200,'anh_quan_ao/quan/quan_jean_slim_fit.jpg','Spring',0,23,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_1.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_2.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_3.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_4.jpg',NULL,NULL,NULL),(2002,203,'Chân Váy Chữ A Cơ Bản','Chân váy ngắn chữ A, dễ phối đồ, cạp cao.',320000,'Đen, Trắng Ngà','S, M, L','Vải Tuyết Mưa',150,'anh_quan_ao/quan/chan_vay_chu_a.jpg','Spring',0,29,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_4.jpg',NULL,NULL,NULL),(2003,201,'Quần Jogger Thun Basic','Quần jogger bo gấu, lưng thun, có dây rút, thích hợp mặc nhà/tập luyện.',350000,'Đen, Xám Melange','S, M, L, XL','Cotton/Spandex',160,'anh_quan_ao/quan/quan_jogger_thun.jpg','Autumn',0,26,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jogger_thun_1.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_2.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_3.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_4.jpg',NULL,NULL,NULL),(2004,202,'Quần Short Kaki Phẳng','Quần short đứng dáng, độ dài trên gối, cạp phẳng.',280000,'Trắng ngà, Xanh mint','29, 30, 31, 32','Kaki',140,'anh_quan_ao/quan/quan_short_kaki.jpg','Spring',0,46,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_short_kaki_1.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_2.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_3.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_4.jpg',NULL,NULL,NULL),(2005,201,'Quần Jeans Ống Suông','Quần jeans ống suông, co giãn nhẹ, dáng rộng thoải mái.',380000,'Xanh Denim, Đen','29, 30, 31, 32','Denim Cotton',200,'anh_quan_ao/quan/quan_jeans_ong_suong.jpg','Autumn',0,48,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_1.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_2.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_3.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_4.jpg',NULL,NULL,NULL),(2006,201,'Quần Kaki Dài Mỏng','Quần kaki dài, mỏng nhẹ, thoáng khí, thích hợp mùa xuân/hè.',320000,'Be, Xanh Olive, Xám','29, 30, 31, 32','Kaki Cotton',180,'anh_quan_ao/quan/quan_kaki_mong.jpg','Spring',0,0,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_kaki_mong_1.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_2.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_3.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_4.jpg',NULL,NULL,NULL),(2007,202,'Quần Short Thun Năng Động','Quần short thun, co giãn, form thoải mái, mùa hạ.',250000,'Xám, Đen, Xanh','S, M, L, XL','Cotton/Spandex',130,'anh_quan_ao/quan/quan_short_thun_nang_dong.jpg','Spring',0,12,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_1.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_2.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_3.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_4.jpg',NULL,NULL,NULL),(2008,203,'Chân Váy Suông Dài','Chân váy suông dài, thoáng mát, dễ phối đồ.',320000,'Xanh, Be, Nâu','S, M, L','Voan',150,'anh_quan_ao/quan/chan_vay_suong_dai.jpg','Spring',0,8,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_4.jpg',NULL,NULL,NULL),(2009,201,'Quần Jogger Nỉ Ấm','Quần jogger nỉ, giữ ấm, thích hợp mùa thu/đông.',400000,'Xám, Đen, Xanh Navy','S, M, L, XL','Nỉ Cotton',200,'anh_quan_ao/quan/quan_jogger_ni_am.jpg','Autumn',0,3,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_1.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_2.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_3.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_4.jpg',NULL,NULL,NULL),(2010,201,'Quần Jeans Ống Côn','Quần jeans ống côn, dáng ôm vừa, tối giản.',390000,'Xanh Denim, Đen','29, 30, 31, 32','Denim Cotton',210,'anh_quan_ao/quan/quan_jeans_ong_con.jpg','Winter',0,45,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_1.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_2.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_3.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_4.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_mau_xanh_nhat.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_6.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_con_7.jpg'),(2011,201,'Quần Legging Nỉ','Quần legging nỉ, giữ ấm, dáng ôm, thích hợp mùa đông.',380000,'Đen, Xám','S, M, L, XL','Nỉ Cotton',180,'anh_quan_ao/quan/quan_legging_ni.jpg','Autumn',0,43,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_legging_ni_1.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_2.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_3.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_4.jpg',NULL,NULL,NULL),(2012,201,'Quần Dạ Ống Rộng','Quần dạ ống rộng, giữ ấm, phong cách thanh lịch.',500000,'Đen, Xám, Nâu','29, 30, 31, 32','Dạ + Polyester',250,'anh_quan_ao/quan/quan_da_ong_rong.jpg','Winter',0,7,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_1.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_2.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_3.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_4.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_mau_xanh.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_6.jpg','anh_quan_ao/anh_phu_quan/quan_da_ong_rong_7.jpg'),(2013,203,'Chân Váy Dài Len','Chân váy len dài, giữ ấm, form suông thoải mái.',350000,'Be, Nâu, Xám','S, M, L','Len Acrylic',180,'anh_quan_ao/quan/chan_vay_dai_len.jpg','Autumn',0,5,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_4.jpg',NULL,NULL,NULL),(3001,301,'Ví Da Gấp Đôi Tối Giản','Phụ Kiện Ví da bò thật, thiết kế mỏng, chỉ có logo dập chìm.',390000,'Nâu Đậm, Đen','Free Size','Da Bò Thật',80,'anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg',NULL,0,49,'2025-08-30 14:38:27','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_1.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_2.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_3.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_4.jpg',NULL,NULL,NULL),(3002,302,'Thắt Lưng Da Khóa Cổ Điển','Phụ Kiện Dây nịt da trơn, khóa kim loại đơn giản.',480000,'Đen, Nâu','Free Size','Da Tổng Hợp',65,'anh_quan_ao/phu_kien/that_lung_da.jpg',NULL,0,24,'2025-07-30 14:38:27','anh_quan_ao/anh_phu_phu_kien/that_lung_da_1.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_2.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_3.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_4.jpg',NULL,NULL,NULL),(3003,301,'Túi Tote Vải Canvas Lớn','Phụ Kiện Túi vải canvas khổ lớn, quai đeo vai, in chữ tối giản.',150000,'Trắng, Đen','Free Size','Canvas dày',300,'anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg',NULL,0,25,'2025-08-02 14:38:27','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_4.jpg',NULL,NULL,NULL),(3004,302,'Mũ Lưỡi Trai Cotton Trơn','Phụ Kiện Mũ lưỡi trai trơn, không logo, có thể điều chỉnh phía sau.',120000,'Đen, Trắng, Nâu','Free Size','Cotton',220,'anh_quan_ao/phu_kien/mu_luoi_trai.jpg',NULL,0,3,'2025-08-15 14:38:27','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_1.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_2.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_3.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_4.jpg',NULL,NULL,NULL),(3005,302,'Vớ Cổ Cao Basic (Pack 3)','Phụ Kiện Bộ 3 đôi vớ, chất liệu co giãn, thấm hút mồ hôi.',99000,'Trắng, Xám, Đen','Free Size','Cotton, Spandex',500,'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg',NULL,0,43,'2025-10-14 14:38:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3006,301,'Túi Đeo Chéo Mini','Túi đeo chéo nhỏ gọn, phong cách casual, nhiều ngăn.',220000,'Đen, Xám, Nâu','Free Size','Canvas + Polyester',250,'anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg','Spring',0,22,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_4.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_mau_nau.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_6.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_cheo_mini_7.jpg'),(3007,301,'Túi Đeo Vai Da Tổng Hợp','Túi da tổng hợp, quai da dài, phong cách tối giản.',350000,'Đen, Nâu','Free Size','Da Tổng Hợp',300,'anh_quan_ao/phu_kien/tui_deo_vai_da.jpg','Autumn',0,28,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_4.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_mau_do.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_mau_trang.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_da_7.jpg'),(3008,302,'Mũ Beanie Len','Mũ beanie chất liệu len acrylic, giữ ấm mùa đông.',180000,'Đen, Xám, Nâu','Free Size','Len Acrylic',120,'anh_quan_ao/phu_kien/mu_beanie_len.jpg','Autumn',0,13,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_1.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_2.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_3.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_4.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_mau_den.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_mau_do.jpg','anh_quan_ao/anh_phu_phu_kien/mu_beanie_len_7.jpg'),(3009,302,'Thắt Lưng Da Khóa Kim Loại','Dây nịt da thật, khóa kim loại sang trọng.',520000,'Đen, Nâu','Free Size','Da Bò Thật',70,'anh_quan_ao/phu_kien/that_lung_da_khoa_kim_loai.jpg','Autumn',0,42,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_1.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_2.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_3.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_4.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_mau_den.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_6.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_khoa_kim_loai_7.jpg'),(3010,302,'Vớ Ngắn Cotton Basic (Pack 5)','Bộ 5 đôi vớ ngắn, co giãn tốt, thấm hút mồ hôi.',120000,'Trắng, Xám, Đen','Free Size','Cotton + Spandex',400,'anh_quan_ao/phu_kien/vo_ngan_cotton_pack5.jpg','Autumn',0,49,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_1.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_2.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_3.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_4.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_mau_xam.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_6.jpg','anh_quan_ao/anh_phu_phu_kien/vo_ngan_cotton_pack5_7.jpg'),(3011,301,'Túi Đeo Hông Thời Trang','Túi đeo hông nhỏ gọn, dây điều chỉnh, phong cách năng động.',200000,'Đen, Xanh Olive','Free Size','Polyester',180,'anh_quan_ao/phu_kien/tui_deo_hong_thoi_trang.jpg','Winter',0,59,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_4.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_mau_xanh.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_6.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_hong_thoi_trang_7.jpg'),(3012,301,'Túi Đeo Vai Mini','Túi mini, quai đeo vai, thích hợp đi chơi hoặc đi làm.',190000,'Đen, Be','Free Size','Canvas + Polyester',160,'anh_quan_ao/phu_kien/tui_deo_vai_mini.jpg','Winter',0,25,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_4.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_mau_den.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_6.jpg','anh_quan_ao/anh_phu_phu_kien/tui_deo_vai_mini_7.jpg'),(3013,302,'Mũ Snapback Thể Thao','Mũ snapback, điều chỉnh size phía sau, phong cách năng động.',150000,'Đen, Xanh Navy, Trắng','Free Size','Cotton',220,'anh_quan_ao/phu_kien/mu_snapback_the_thao.jpg','Winter',0,11,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_1.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_2.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_3.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_4.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_mau_do.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_mau_tim.jpg','anh_quan_ao/anh_phu_phu_kien/mu_snapback_the_thao_mau_xam.jpg'),(3014,302,'Vớ Cổ Cao Thời Trang (Pack 3)','Bộ 3 đôi vớ cổ cao, chất liệu co giãn, thấm hút mồ hôi.',95000,'Trắng, Xám, Đen','Free Size','Cotton + Spandex',350,'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg','Winter',0,37,'2025-11-04 22:54:49','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_1.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_2.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_3.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_4.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_mau_trang.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_6.jpg','anh_quan_ao/anh_phu_phu_kien/vo_cao_co_pack3_7.jpg');
/*!40000 ALTER TABLE `sanpham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanphammau`
--

DROP TABLE IF EXISTS `sanphammau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanphammau` (
  `id` bigint DEFAULT NULL,
  `id_sanpham` bigint DEFAULT NULL,
  `tenmau` text,
  `url_anh1` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanphammau`
--

LOCK TABLES `sanphammau` WRITE;
/*!40000 ALTER TABLE `sanphammau` DISABLE KEYS */;
INSERT INTO `sanphammau` VALUES (1,1012,'Trắng','anh_quan_ao/anh_mau/ao_thun_oversize_trang.jpg'),(2,1012,'Đen','anh_quan_ao/anh_mau/ao_thun_oversize_den.jpg'),(3,1012,'Hồng','anh_quan_ao/anh_mau/ao_thun_oversize_hong.jpg'),(4,1015,'Be','anh_quan_ao/anh_mau/so_mi_linen_tay_lung_be.jpg'),(5,1015,'Xanh Nhạt','anh_quan_ao/anh_mau/so_mi_linen_tay_lung_xanhnhat.jpg'),(6,1007,'Hồng','anh_quan_ao/anh_mau/ao_len_co_tim_hong.jpg'),(7,1007,'Be','anh_quan_ao/anh_mau/ao_len_co_tim_be.jpg'),(8,1007,'Xám','anh_quan_ao/anh_mau/ao_len_co_tim_xam.jpg'),(9,1001,'Trắng','anh_quan_ao/anh_mau/ao_thun_cotton_basic_trang.jpg'),(10,1001,'Đen','anh_quan_ao/anh_mau/ao_thun_cotton_basic_den.jpg'),(11,1001,'Xám','anh_quan_ao/anh_mau/ao_thun_cotton_basic_xam.jpg'),(12,1002,'Be','anh_quan_ao/anh_mau/so_mi_linen_co_dien_be.jpg'),(13,1002,'Xanh Navy','anh_quan_ao/anh_mau/so_mi_linen_co_dien_xanhnavy.jpg'),(27,1003,'Đen','anh_quan_ao/anh_mau/ao_polo_cotton_pique_den.jpg'),(28,1003,'Trắng','anh_quan_ao/anh_mau/ao_polo_cotton_pique_trang.jpg'),(29,1003,'Xanh rêu','anh_quan_ao/anh_mau/ao_polo_cotton_pique_xanhreu.jpg'),(30,1008,'Trắng','anh_quan_ao/anh_mau/ao_thun_polo_ngan_tay_trang.jpg'),(31,1008,'Xanh Dương','anh_quan_ao/anh_mau/ao_thun_polo_ngan_tay_xanhduong.jpg'),(32,1008,'Đen','anh_quan_ao/anh_mau/ao_thun_polo_ngan_tay_den.jpg'),(33,1011,'Trắng','anh_quan_ao/anh_mau/so_mi_coc_tay_ke_soc_trang.jpg'),(34,1011,'Xanh','anh_quan_ao/anh_mau/so_mi_coc_tay_ke_soc_xanh.jpg'),(35,1006,'Be','anh_quan_ao/anh_mau/ao_len_mong_co_tron_be.jpg'),(36,1006,'Nâu','anh_quan_ao/anh_mau/ao_len_mong_co_tron_nau.jpg'),(37,1006,'Xám','anh_quan_ao/anh_mau/ao_len_mong_co_tron_xam.jpg'),(38,1009,'Xám','anh_quan_ao/anh_mau/ao_khoac_cardigan_dai_xam.jpg'),(39,1009,'Đen','anh_quan_ao/anh_mau/ao_khoac_cardigan_dai_den.jpg'),(40,1009,'Be','anh_quan_ao/anh_mau/ao_khoac_cardigan_dai_be.jpg'),(74,1017,'Xám','anh_quan_ao/anh_mau/ao_hoodie_mong_xam.jpg'),(75,1017,'Đen','anh_quan_ao/anh_mau/ao_hoodie_mong_den.jpg'),(76,1017,'Be','anh_quan_ao/anh_mau/ao_hoodie_mong_be.jpg'),(77,1004,'Xám tro','anh_quan_ao/anh_mau/ao_hoodie_ni_phom_rong_xamtro.jpg'),(78,1004,'Kem','anh_quan_ao/anh_mau/ao_hoodie_ni_phom_rong_kem.jpg'),(79,1004,'Đen','anh_quan_ao/anh_mau/ao_hoodie_ni_phom_rong_den.jpg'),(80,1005,'Xanh Navy','anh_quan_ao/anh_mau/ao_khoac_gio_hai_lop_xanhnavy.jpg'),(81,1005,'Be','anh_quan_ao/anh_mau/ao_khoac_gio_hai_lop_be.jpg'),(82,1005,'Xám','anh_quan_ao/anh_mau/ao_khoac_gio_hai_lop_xam.jpg'),(83,1010,'Đen','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_den.jpg'),(84,1010,'Xanh Navy','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_xanhnavy.jpg'),(85,1014,'Đen','anh_quan_ao/anh_mau/ao_khoac_da_ngan_den.jpg'),(86,1014,'Xanh Navy','anh_quan_ao/anh_mau/ao_khoac_da_ngan_xanhnavy.jpg'),(87,1018,'Đen','anh_quan_ao/anh_mau/ao_len_co_lo_den.jpg'),(88,1018,'Xám','anh_quan_ao/anh_mau/ao_len_co_lo_xam.jpg'),(89,1018,'Nâu','anh_quan_ao/anh_mau/ao_len_co_lo_nau.jpg'),(90,2001,'Xanh Đậm','anh_quan_ao/anh_mau/quan_jeans_slim_fit_xanhdam.jpg'),(91,2001,'Đen','anh_quan_ao/anh_mau/quan_jeans_slim_fit_den.jpg'),(92,2006,'Be','anh_quan_ao/anh_mau/quan_kaki_dai_mong_be.jpg'),(93,2006,'Xanh Olive','anh_quan_ao/anh_mau/quan_kaki_dai_mong_xanholive.jpg'),(94,2006,'Xám','anh_quan_ao/anh_mau/quan_kaki_dai_mong_xam.jpg'),(95,2004,'Trắng ngà','anh_quan_ao/anh_mau/quan_short_kaki_phang_trangnga.jpg'),(96,2004,'Xanh mint','anh_quan_ao/anh_mau/quan_short_kaki_phang_xanhmint.jpg'),(97,2007,'Xám','anh_quan_ao/anh_mau/quan_short_thun_nang_dong_xam.jpg'),(98,2007,'Đen','anh_quan_ao/anh_mau/quan_short_thun_nang_dong_den.jpg'),(99,2007,'Xanh','anh_quan_ao/anh_mau/quan_short_thun_nang_dong_xanh.jpg'),(100,2008,'Xanh','anh_quan_ao/anh_mau/chan_vay_suong_dai_xanh.jpg'),(101,2008,'Be','anh_quan_ao/anh_mau/chan_vay_suong_dai_be.jpg'),(102,2008,'Nâu','anh_quan_ao/anh_mau/chan_vay_suong_dai_nau.jpg'),(103,2002,'Đen','anh_quan_ao/anh_mau/chan_vay_chu_a_co_ban_den.jpg'),(104,2002,'Be','anh_quan_ao/anh_mau/chan_vay_chu_a_co_ban_be.jpg'),(105,2002,'Xanh','anh_quan_ao/anh_mau/chan_vay_chu_a_co_ban_xanh.jpg'),(106,2005,'Xanh Denim','anh_quan_ao/anh_mau/quan_jeans_ong_suong_xanhdenim.jpg'),(107,2005,'Đen','anh_quan_ao/anh_mau/quan_jeans_ong_suong_den.jpg'),(108,2003,'Đen','anh_quan_ao/anh_mau/quan_jogger_thun_basic_den.jpg'),(109,2003,'Xám Melange','anh_quan_ao/anh_mau/quan_jogger_thun_basic_xammelange.jpg'),(110,2009,'Xám','anh_quan_ao/anh_mau/quan_jogger_ni_am_xam.jpg'),(111,2009,'Đen','anh_quan_ao/anh_mau/quan_jogger_ni_am_den.jpg'),(112,2009,'Xanh Navy','anh_quan_ao/anh_mau/quan_jogger_ni_am_xanhnavy.jpg'),(113,2011,'Đen','anh_quan_ao/anh_mau/quan_legging_ni_den.jpg'),(114,2011,'Xám','anh_quan_ao/anh_mau/quan_legging_ni_xam.jpg'),(115,2013,'Be','anh_quan_ao/anh_mau/chan_vay_dai_len_be.jpg'),(116,2013,'Nâu','anh_quan_ao/anh_mau/chan_vay_dai_len_nau.jpg'),(117,2013,'Xám','anh_quan_ao/anh_mau/chan_vay_dai_len_xam.jpg'),(118,2010,'Xanh Denim','anh_quan_ao/anh_mau/quan_jeans_ong_con_xanhdenim.jpg'),(119,2010,'Đen','anh_quan_ao/anh_mau/quan_jeans_ong_con_den.jpg'),(120,2012,'Đen','anh_quan_ao/anh_mau/quan_da_ong_rong_den.jpg'),(121,2012,'Xám','anh_quan_ao/anh_mau/quan_da_ong_rong_xam.jpg'),(122,2012,'Nâu','anh_quan_ao/anh_mau/quan_da_ong_rong_nau.jpg'),(123,3001,'Nâu Đậm','anh_quan_ao/anh_mau/vi_da_gap_doi_toi_gian_naudam.jpg'),(124,3001,'Đen','anh_quan_ao/anh_mau/vi_da_gap_doi_toi_gian_den.jpg'),(125,3006,'Đen','anh_quan_ao/anh_mau/tui_deo_cheo_mini_den.jpg'),(126,3006,'Xám','anh_quan_ao/anh_mau/tui_deo_cheo_mini_xam.jpg'),(127,3006,'Nâu','anh_quan_ao/anh_mau/tui_deo_cheo_mini_nau.jpg'),(128,3002,'Đen','anh_quan_ao/anh_mau/that_lung_da_khoa_co_dien_den.jpg'),(129,3002,'Nâu','anh_quan_ao/anh_mau/that_lung_da_khoa_co_dien_nau.jpg'),(130,3003,'Trắng','anh_quan_ao/anh_mau/tui_tote_vai_canvas_lon_trang.jpg'),(131,3003,'Đen','anh_quan_ao/anh_mau/tui_tote_vai_canvas_lon_den.jpg'),(132,3004,'Đen','anh_quan_ao/anh_mau/mu_luoi_trai_cotton_tron_den.jpg'),(133,3004,'Trắng','anh_quan_ao/anh_mau/mu_luoi_trai_cotton_tron_trang.jpg'),(134,3004,'Nâu','anh_quan_ao/anh_mau/mu_luoi_trai_cotton_tron_nau.jpg'),(135,3007,'Đen','anh_quan_ao/anh_mau/tui_deo_vai_da_tong_hop_den.jpg'),(136,3007,'Nâu','anh_quan_ao/anh_mau/tui_deo_vai_da_tong_hop_nau.jpg'),(137,3008,'Đen','anh_quan_ao/anh_mau/mu_beanie_len_den.jpg'),(138,3008,'Xám','anh_quan_ao/anh_mau/mu_beanie_len_xam.jpg'),(139,3008,'Nâu','anh_quan_ao/anh_mau/mu_beanie_len_nau.jpg'),(140,3009,'Đen','anh_quan_ao/anh_mau/that_lung_da_khoa_kim_loai_den.jpg'),(141,3009,'Nâu','anh_quan_ao/anh_mau/that_lung_da_khoa_kim_loai_nau.jpg'),(142,3010,'Trắng','anh_quan_ao/anh_mau/vo_ngan_cotton_basic_pack_5_trang.jpg'),(143,3010,'Xám','anh_quan_ao/anh_mau/vo_ngan_cotton_basic_pack_5_xam.jpg'),(144,3010,'Đen','anh_quan_ao/anh_mau/vo_ngan_cotton_basic_pack_5_den.jpg'),(145,3011,'Đen','anh_quan_ao/anh_mau/tui_deo_hong_thoi_trang_den.jpg'),(146,3011,'Xanh Olive','anh_quan_ao/anh_mau/tui_deo_hong_thoi_trang_xanholive.jpg'),(147,3012,'Đen','anh_quan_ao/anh_mau/tui_deo_vai_mini_den.jpg'),(148,3012,'Be','anh_quan_ao/anh_mau/tui_deo_vai_mini_be.jpg'),(149,3013,'Đen','anh_quan_ao/anh_mau/mu_snapback_the_thao_den.jpg'),(150,3013,'Xanh Navy','anh_quan_ao/anh_mau/mu_snapback_the_thao_xanhnavy.jpg'),(151,3013,'Trắng','anh_quan_ao/anh_mau/mu_snapback_the_thao_trang.jpg'),(152,3014,'Trắng','anh_quan_ao/anh_mau/vo_co_cao_thoi_trang_pack_3_trang.jpg'),(153,3014,'Xám','anh_quan_ao/anh_mau/vo_co_cao_thoi_trang_pack_3_xam.jpg'),(154,3014,'Đen','anh_quan_ao/anh_mau/vo_co_cao_thoi_trang_pack_3_den.jpg'),(378,1012,'Nâu','anh_quan_ao/anh_mau/ao_thun_oversize_mau_nau.jpg'),(380,1015,'Đen','anh_quan_ao/anh_mau/so_mi_linen_tay_lung_mau_den.jpg'),(382,1015,'Vàng','anh_quan_ao/anh_mau/so_mi_linen_tay_lung_mau_vang.jpg'),(383,1007,'Xanh','anh_quan_ao/anh_mau/ao_len_co_tim_mau_xanh.jpg'),(384,1007,'Đỏ','anh_quan_ao/anh_mau/ao_len_co_tim_mau_do.jpg'),(387,1001,'Đỏ','anh_quan_ao/anh_mau/ao_thun_cotton_basic_mau_do.jpg'),(388,1001,'Xanh','anh_quan_ao/anh_mau/ao_thun_cotton_basic_mau_xanh.jpg'),(389,1002,'Hồng','anh_quan_ao/anh_mau/so_mi_linen_co_dien_mau_hong.jpg'),(391,1002,'Vàng','anh_quan_ao/anh_mau/so_mi_linen_co_dien_mau_vang.jpg'),(392,1003,'Be','anh_quan_ao/anh_mau/ao_polo_cotton_pique_mau_be.jpg'),(393,1003,'Hồng','anh_quan_ao/anh_mau/ao_polo_cotton_pique_mau_hong.jpg'),(394,1003,'Xám','anh_quan_ao/anh_mau/ao_polo_cotton_pique_mau_xam.jpg'),(398,1011,'Đen','anh_quan_ao/anh_mau/so_mi_coc_tay_ke_soc_mau_den.jpg'),(400,1011,'Đỏ','anh_quan_ao/anh_mau/so_mi_coc_tay_ke_soc_mau_do.jpg'),(402,1006,'Xanh','anh_quan_ao/anh_mau/ao_len_mong_co_tron_mau_xanh.jpg'),(403,1006,'Xanh Lá','anh_quan_ao/anh_mau/ao_len_mong_co_tron_mau_xanh_la.jpg'),(404,1009,'Trắng','anh_quan_ao/anh_mau/ao_khoac_cardigan_dai_mau_trang.jpg'),(406,1009,'Đỏ','anh_quan_ao/anh_mau/ao_khoac_cardigan_dai_mau_do.jpg'),(410,1017,'Xanh Lá','anh_quan_ao/anh_mau/ao_hoodie_mong_mau_xanh_la.jpg'),(411,1017,'Đỏ','anh_quan_ao/anh_mau/ao_hoodie_mong_mau_do.jpg'),(412,1017,'Trắng','anh_quan_ao/anh_mau/ao_hoodie_mong_mau_trang.jpg'),(413,1004,'Hồng','anh_quan_ao/anh_mau/ao_hoodie_ni_phom_rong_mau_hong.jpg'),(414,1004,'Trắng','anh_quan_ao/anh_mau/ao_hoodie_ni_phom_rong_mau_trang.jpg'),(417,1005,'Đen','anh_quan_ao/anh_mau/ao_khoac_gio_hai_lop_mau_den.jpg'),(418,1005,'Rêu','anh_quan_ao/anh_mau/ao_khoac_gio_hai_lop_mau_reu.jpg'),(420,1010,'Trắng','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_mau_xanh.jpg'),(421,1010,'Be','anh_quan_ao/anh_mau/ao_khoac_phao_long_vu_mau_be.jpg'),(423,1014,'Xám','anh_quan_ao/anh_mau/ao_khoac_da_ngan_mau_xam.jpg'),(424,1014,'Nâu','anh_quan_ao/anh_mau/ao_khoac_da_ngan_mau_nau.jpg'),(427,1018,'Xanh','anh_quan_ao/anh_mau/ao_len_co_lo_mau_xanh.jpg'),(429,2006,'Đen','anh_quan_ao/anh_mau/quan_kaki_dai_mong_mau_den.jpg'),(431,2004,'Đen','anh_quan_ao/anh_mau/quan_short_kaki_phang_mau_den.jpg'),(432,2004,'Xanh','anh_quan_ao/anh_mau/quan_short_kaki_phang_mau_xanh.jpg'),(433,2007,'Nâu','anh_quan_ao/anh_mau/quan_short_thun_nang_dong_mau_nau.jpg'),(436,2008,'Trắng','anh_quan_ao/anh_mau/chan_vay_suong_dai_mau_trang.jpg'),(438,2002,'Tím','anh_quan_ao/anh_mau/chan_vay_chu_a_co_ban_mau_tim.jpg'),(441,2009,'Đỏ','anh_quan_ao/anh_mau/quan_jogger_ni_am_mau_do.jpg'),(444,2011,'Đỏ','anh_quan_ao/anh_mau/quan_legging_ni_mau_do.jpg'),(445,2011,'Nâu','anh_quan_ao/anh_mau/quan_legging_ni_mau_nau.jpg'),(447,2013,'Vàng','anh_quan_ao/anh_mau/chan_vay_dai_len_mau_vang.jpg'),(449,2012,'Xanh','anh_quan_ao/anh_mau/quan_da_ong_rong_mau_xanh.jpg'),(450,3001,'Hồng','anh_quan_ao/anh_mau/vi_da_gap_doi_toi_gian_mau_hong.jpg'),(451,3001,'Xanh','anh_quan_ao/anh_mau/vi_da_gap_doi_toi_gian_mau_xanh.jpg'),(454,3003,'Vàng','anh_quan_ao/anh_mau/tui_tote_vai_canvas_mau_vang.jpg'),(455,3004,'Đỏ','anh_quan_ao/anh_mau/mu_luoi_trai_mau_do.jpg'),(457,3004,'Xám','anh_quan_ao/anh_mau/mu_luoi_trai_mau_xam.jpg'),(460,3008,'Đỏ','anh_quan_ao/anh_mau/mu_beanie_len_mau_do.jpg'),(461,3008,'Vàng','anh_quan_ao/anh_mau/mu_beanie_len_mau_vang.jpg'),(464,3011,'Xanh','anh_quan_ao/anh_mau/tui_deo_hong_thoi_trang_mau_xanh.jpg'),(465,3012,'Nâu','anh_quan_ao/anh_mau/tui_deo_vai_mini_mau_nau.jpg'),(466,3013,'Đỏ','anh_quan_ao/anh_mau/mu_snapback_the_thao_mau_do.jpg'),(467,3013,'Tím','anh_quan_ao/anh_mau/mu_snapback_the_thao_mau_tim.jpg'),(468,3013,'Xám','anh_quan_ao/anh_mau/mu_snapback_the_thao_mau_xam.jpg');
/*!40000 ALTER TABLE `sanphammau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizedanong`
--

DROP TABLE IF EXISTS `sizedanong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizedanong` (
  `id` int NOT NULL,
  `MaSize` varchar(5) NOT NULL,
  `NgangVai` decimal(10,1) DEFAULT NULL,
  `VongNguc` decimal(10,1) DEFAULT NULL,
  `TayAo` decimal(10,1) DEFAULT NULL,
  `Eo` decimal(10,1) DEFAULT NULL,
  `Hong` decimal(10,1) DEFAULT NULL,
  `DaiQuan` decimal(10,1) DEFAULT NULL,
  `ChieuCao` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CanNang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizedanong`
--

LOCK TABLES `sizedanong` WRITE;
/*!40000 ALTER TABLE `sizedanong` DISABLE KEYS */;
INSERT INTO `sizedanong` VALUES (1,'XS',43.0,88.0,60.0,72.0,88.0,98.0,'155-165cm','45-55kg'),(2,'S',44.5,92.0,61.0,76.0,92.0,100.0,'160-170cm','55-65kg'),(3,'M',46.0,96.0,62.0,80.0,96.0,102.0,'168-175cm','65-75kg'),(4,'L',47.5,100.0,63.0,84.0,100.0,104.0,'170-180cm','75-85kg'),(5,'XL',49.0,104.0,64.0,88.0,104.0,106.0,'175-185cm','85-95kg'),(6,'XXL',50.5,108.0,65.0,92.0,108.0,108.0,'180-190cm','95-105kg'),(7,'3XL',52.0,112.0,66.0,96.0,112.0,110.0,'180-195cm','105-115kg');
/*!40000 ALTER TABLE `sizedanong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizephunu`
--

DROP TABLE IF EXISTS `sizephunu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizephunu` (
  `id` int NOT NULL,
  `MaSize` varchar(5) NOT NULL,
  `NgangVai` decimal(10,1) DEFAULT NULL,
  `VongNguc` decimal(10,1) DEFAULT NULL,
  `TayAo` decimal(10,1) DEFAULT NULL,
  `Eo` decimal(10,1) DEFAULT NULL,
  `Hong` decimal(10,1) DEFAULT NULL,
  `DaiQuan` decimal(10,1) DEFAULT NULL,
  `ChieuCao` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CanNang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizephunu`
--

LOCK TABLES `sizephunu` WRITE;
/*!40000 ALTER TABLE `sizephunu` DISABLE KEYS */;
INSERT INTO `sizephunu` VALUES (1,'XXS',34.3,78.7,57.8,59.7,83.8,75.5,'135-150','33-45'),(2,'XS',34.9,82.5,58.1,62.2,90.2,79.6,'150-165','45-55'),(3,'S',35.6,86.4,58.4,66.0,94.0,84.6,'165-178','57-70'),(4,'M',36.2,90.2,58.4,69.8,97.8,85.7,'165-178','57-70'),(5,'L',36.8,94.0,58.4,73.7,101.6,87.4,'165-180','63-92'),(6,'XL',37.5,99.1,58.4,78.7,106.7,89.0,'175-185','63-92'),(7,'XXL',38.0,104.1,58.4,83.8,114.3,90.0,'175-180','75-95');
/*!40000 ALTER TABLE `sizephunu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `doanhthu_theongay`
--

/*!50001 DROP VIEW IF EXISTS `doanhthu_theongay`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `doanhthu_theongay` AS select cast(`donhang`.`Time` as date) AS `ngaytao`,sum(`donhang`.`TongGia`) AS `doanhthu` from `donhang` where (cast(`donhang`.`Time` as date) = '2025-11-08') group by cast(`donhang`.`Time` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenue`
--

/*!50001 DROP VIEW IF EXISTS `revenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenue` AS select `donhang`.`TongGia` AS `GiaNgayHomNay` from `donhang` where ((to_days(`donhang`.`Time`) - to_days(now())) = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-13 19:41:49
