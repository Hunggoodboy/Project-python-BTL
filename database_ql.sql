-- MySQL dump 10.13  Distrib 9.5.0, for macos15 (arm64)
--
-- Host: localhost    Database: QLBanQuanAo
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e90674b2-b037-11f0-98bc-1579213bc118:1-114';

--
-- Table structure for table `DanhMuc`
--

DROP TABLE IF EXISTS `DanhMuc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DanhMuc` (
  `MaDM` int NOT NULL,
  `TenDM` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MoTa` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NgayNhapHang` date DEFAULT NULL,
  `MaDMCha` int DEFAULT NULL,
  PRIMARY KEY (`MaDM`),
  KEY `fk_dm_cha` (`MaDMCha`),
  CONSTRAINT `fk_dm_cha` FOREIGN KEY (`MaDMCha`) REFERENCES `DanhMuc` (`MaDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DanhMuc`
--

LOCK TABLES `DanhMuc` WRITE;
/*!40000 ALTER TABLE `DanhMuc` DISABLE KEYS */;
INSERT INTO `DanhMuc` VALUES (100,'Áo (Tất Cả)','Các loại áo mặc thân trên.',NULL,NULL),(101,'Áo Thun Cơ Bản','Áo phông cổ tròn, cổ tim, tối giản.',NULL,100),(102,'Áo Sơ Mi','Sơ mi classic, linen, oxford.',NULL,100),(103,'Áo Khoác','Hoodie, Sweater, Cardigan, Khoác Gió.',NULL,100),(200,'Quần & Váy (Tất Cả)','Các loại quần và váy.',NULL,NULL),(201,'Quần Dài','Jeans, Kaki, Jogger, Quần âu.',NULL,200),(202,'Quần Ngắn','Short Kaki, Short Thun.',NULL,200),(203,'Chân Váy','Chân váy chữ A, chân váy suông (dành cho Nữ).',NULL,200),(300,'Phụ Kiện (Tất Cả)','Các vật dụng đi kèm.',NULL,NULL),(301,'Túi & Ví','Ví da, túi tote, túi đeo chéo thiết kế trung tính.',NULL,300),(302,'Mũ & Vớ','Các loại mũ, vớ cơ bản.',NULL,300);
/*!40000 ALTER TABLE `DanhMuc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DonHang`
--

DROP TABLE IF EXISTS `DonHang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DonHang` (
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
  PRIMARY KEY (`MaDH`),
  KEY `MaSP` (`MaSP`),
  KEY `MaKH` (`MaKH`),
  CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `SanPham` (`MaSP`),
  CONSTRAINT `donhang_ibfk_2` FOREIGN KEY (`MaKH`) REFERENCES `KhachHang` (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DonHang`
--

LOCK TABLES `DonHang` WRITE;
/*!40000 ALTER TABLE `DonHang` DISABLE KEYS */;
INSERT INTO `DonHang` VALUES (1,1012,6,1,NULL,NULL,'Đã giao thành công',250000,'',NULL),(2,1011,6,1,NULL,NULL,'Đang Xử Lý',330000,'',NULL),(3,1003,6,1,NULL,NULL,'Đang Xử Lý',290000,'',NULL);
/*!40000 ALTER TABLE `DonHang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GioHang`
--

DROP TABLE IF EXISTS `GioHang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GioHang` (
  `MaKH` int NOT NULL,
  `MaSP` int NOT NULL,
  `SoLuong` int DEFAULT NULL,
  `MauSac` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MaKH`,`MaSP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GioHang`
--

LOCK TABLES `GioHang` WRITE;
/*!40000 ALTER TABLE `GioHang` DISABLE KEYS */;
/*!40000 ALTER TABLE `GioHang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KhachHang`
--

DROP TABLE IF EXISTS `KhachHang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KhachHang` (
  `MaKH` int NOT NULL AUTO_INCREMENT,
  `HoTen` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `MatKhau` varchar(100) NOT NULL,
  `SDT` varchar(10) NOT NULL,
  `Address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KhachHang`
--

LOCK TABLES `KhachHang` WRITE;
/*!40000 ALTER TABLE `KhachHang` DISABLE KEYS */;
INSERT INTO `KhachHang` VALUES (1,'Hungg','Hung6903','123456','0966439277','Hà Nội'),(2,'Hungg','Hung6903','1234','0966439277','Hà Nội'),(3,'Hungg','Hung6903','123456','0966439277','Hà Nội'),(4,'123','q','q','123','123'),(5,'Nguyễn Xuân Hùng','Hung452005','123456789','0966439277','Hà Nội'),(6,'Nguyễn Xuân Hùng','Hung452005','123456','0966439277','Hà Nội'),(7,'Nguyễn Xuân','sdfsdf1','123','24352','0924241'),(8,'Nguyễn Hùng','hfdg','123123','0593224','Hà Nội '),(9,'hung','wsadas','2131232','123123','sfas'),(10,'qweqwe','aeqw','weqweqwe','qweqwe','qweqweq'),(11,'qewqeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe'),(12,'qewqeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe'),(13,'asd','asdasd','asdads','asdasd','asdads'),(14,'qưeqưeqưe','qưeqwe','qeqe','qưeqew','qưeqwe'),(15,'Nguyễn Xuân Hùng','Hungmk2005@gmail.com','123456789','0966439277','Hà Nội'),(16,'Hùng','hung@gmail.com','123456789','01239123','Triều Khúc, Hà Nội'),(17,'fhfghf','ưer','sdfsdf','32243','sdfsds');
/*!40000 ALTER TABLE `KhachHang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SanPham`
--

DROP TABLE IF EXISTS `SanPham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SanPham` (
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
  PRIMARY KEY (`MaSP`),
  KEY `MaDM` (`MaDM`),
  CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaDM`) REFERENCES `DanhMuc` (`MaDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SanPham`
--

LOCK TABLES `SanPham` WRITE;
/*!40000 ALTER TABLE `SanPham` DISABLE KEYS */;
INSERT INTO `SanPham` VALUES (1001,101,'Áo Thun Cotton Basic','Áo thun cổ tròn, form vừa, chất liệu thoáng mát, 100% Cotton.',199000,'Trắng, Đen, Xám','S, M, L, XL','Cotton 100%',350,'anh_quan_ao/ao/ao_thun_basic.png','Summer',0,17,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_thun_basic_1.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_2.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_3.jpg','anh_quan_ao/anh_phu_ao/ao_thun_basic_4.jpg'),(1002,102,'Sơ Mi Linen Cổ Điển','Áo Sơ mi dài tay, chất liệu linen mát, phù hợp cho mùa hè.',450000,'Be, Xanh Navy','S, M, L','Linen Tự Nhiên',120,'anh_quan_ao/ao/so_mi_len_co_dien.jpg','Summer',0,29,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_1.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_2.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_3.jpg','anh_quan_ao/anh_phu_ao/so_mi_len_co_dien_4.jpg'),(1003,101,'Áo Polo Cotton Pique','Áo polo phom cơ bản, cổ dệt kim, chất liệu Pique thoáng khí.',290000,'Đen, Trắng, Xanh rêu','S, M, L, XL','Cotton Pique',250,'anh_quan_ao/ao/ao_polo_cotton_pique.jpg','Summer',0,41,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_1.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_2.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_3.jpg','anh_quan_ao/anh_phu_ao/ao_polo_cotton_pique_4.jpg'),(1004,103,'Áo Hoodie Nỉ Phom Rộng','Áo hoodie có mũ, phom rộng thoải mái, nỉ bông dày dặn.',550000,'Xám tro, Kem, Đen','M, L, XL','Nỉ Bông (Fleece)',180,'anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg','Winter',0,19,'2025-12-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_1.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_2.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_3.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_ni_phom_rong_4.jpg'),(1005,103,'Áo Khoác Gió Hai Lớp','Áo khoác ngoài nhẹ, chống nước nhẹ, có khóa kéo và mũ.',690000,'Xanh Navy, Be, Xám','S, M, L, XL','Polyester',100,'anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg','Winter',0,23,'2025-12-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_1.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_2.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_3.jpg','anh_quan_ao/anh_phu_ao/ao_khoac_gio_hai_lop_4.jpg'),(1008,101,'Áo Thun Polo Ngắn Tay','Áo thun polo cổ bẻ, chất liệu cotton thoáng mát, form chuẩn.',270000,'Trắng, Xanh Dương, Đen','S, M, L, XL','Cotton 100%',220,'anh_quan_ao/ao/ao_thun_polo_ngan_tay.jpg','Summer',0,7,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_1.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_2.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_3.jpg','anh_quan_ao/anh_phu_ao/ao_thun_polo_ngan_tay_4.jpg'),(1009,103,'Áo Khoác Cardigan Dài','Áo cardigan dệt kim dài, nhẹ nhàng, ấm áp, phong cách Hàn Quốc.',490000,'Xám, Đen, Be','S, M, L','Len tổng hợp',300,'anh_quan_ao/ao/ao_len_cardigan.jpg','Autumn',0,19,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_len_cardigan_1.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_2.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_3.jpg','anh_quan_ao/anh_phu_ao/ao_len_cardigan_4.jpg'),(1011,102,'Sơ Mi Cộc Tay Kẻ Sọc','Áo Sơ mi ngắn tay, kẻ sọc thời trang, vải cotton thoáng mát.',330000,'Trắng, Xanh','S, M, L, XL','Cotton',180,'anh_quan_ao/ao/so_mi_coc_tay_ke_soc.jpeg','Summer',0,24,'2025-06-01 00:00:00','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_1.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_2.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_3.jpeg','anh_quan_ao/anh_phu_ao/so_mi_coc_tay_ke_soc_4.jpeg'),(1012,101,'Áo Thun Oversize','Áo thun form rộng, chất liệu mềm, thoáng khí, màu sắc trẻ trung.',250000,'Trắng, Đen, Hồng','S, M, L, XL','Cotton 100%',280,'anh_quan_ao/ao/ao_thun_oversize.jpg','Spring',0,9,'2025-03-01 00:00:00',NULL,NULL,NULL,NULL),(1015,102,'Sơ Mi Linen Tay Lửng','Áo Sơ mi tay lửng, chất liệu linen thoáng mát, phù hợp mùa xuân hè.',420000,'Be, Xanh Nhạt','S, M, L','Linen',130,'anh_quan_ao/ao/so_mi_linen_tay_lung.jpg','Spring',0,28,'2025-03-01 00:00:00',NULL,NULL,NULL,NULL),(1017,103,'Áo Hoodie Mỏng','Áo hoodie mỏng, form rộng, phù hợp mùa thu se lạnh.',500000,'Xám, Đen, Be','S, M, L, XL','Nỉ mỏng',170,'anh_quan_ao/ao/ao_hoodie_mong.jpg','Autumn',0,11,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_1.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_2.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_3.jpg','anh_quan_ao/anh_phu_ao/ao_hoodie_mong_4.jpg'),(2001,201,'Quần Jeans Slim-fit','Quần jeans dáng đứng, tối giản, không rách.',650000,'Xanh Đậm, Đen','29, 30, 31, 32','Denim Co Giãn',200,'anh_quan_ao/quan/quan_jean_slim_fit.jpg','Spring',0,23,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_1.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_2.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_3.jpg','anh_quan_ao/anh_phu_quan/quan_jean_slim_fit_4.jpg'),(2002,203,'Chân Váy Chữ A Cơ Bản','Chân váy ngắn chữ A, dễ phối đồ, cạp cao.',320000,'Đen, Trắng Ngà','S, M, L','Vải Tuyết Mưa',150,'anh_quan_ao/quan/chan_vay_chu_a.jpg','Spring',0,29,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_chu_a_4.jpg'),(2003,201,'Quần Jogger Thun Basic','Quần jogger bo gấu, lưng thun, có dây rút, thích hợp mặc nhà/tập luyện.',350000,'Đen, Xám Melange','S, M, L, XL','Cotton/Spandex',160,'anh_quan_ao/quan/quan_jogger_thun.jpg','Autumn',0,26,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jogger_thun_1.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_2.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_3.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_thun_4.jpg'),(2004,202,'Quần Short Kaki Phẳng','Quần short đứng dáng, độ dài trên gối, cạp phẳng.',280000,'Trắng ngà, Xanh mint','29, 30, 31, 32','Kaki',140,'anh_quan_ao/quan/quan_short_kaki.jpg','Spring',0,46,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_short_kaki_1.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_2.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_3.jpg','anh_quan_ao/anh_phu_quan/quan_short_kaki_4.jpg'),(2005,201,'Quần Jeans Ống Suông','Quần jeans ống suông, co giãn nhẹ, dáng rộng thoải mái.',380000,'Xanh Denim, Đen','29, 30, 31, 32','Denim Cotton',200,'anh_quan_ao/quan/quan_jeans_ong_suong.jpg','Autumn',0,48,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_1.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_2.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_3.jpg','anh_quan_ao/anh_phu_quan/quan_jeans_ong_suong_4.jpg'),(2006,201,'Quần Kaki Dài Mỏng','Quần kaki dài, mỏng nhẹ, thoáng khí, thích hợp mùa xuân/hè.',320000,'Be, Xanh Olive, Xám','29, 30, 31, 32','Kaki Cotton',180,'anh_quan_ao/quan/quan_kaki_mong.jpg','Spring',0,0,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_kaki_mong_1.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_2.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_3.jpg','anh_quan_ao/anh_phu_quan/quan_kaki_mong_4.jpg'),(2007,202,'Quần Short Thun Năng Động','Quần short thun, co giãn, form thoải mái, mùa hạ.',250000,'Xám, Đen, Xanh','S, M, L, XL','Cotton/Spandex',130,'anh_quan_ao/quan/quan_short_thun_nang_dong.jpg','Spring',0,12,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_1.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_2.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_3.jpg','anh_quan_ao/anh_phu_quan/quan_short_thun_nang_dong_4.jpg'),(2008,203,'Chân Váy Suông Dài','Chân váy suông dài, thoáng mát, dễ phối đồ.',320000,'Xanh, Be, Nâu','S, M, L','Voan',150,'anh_quan_ao/quan/chan_vay_suong_dai.jpg','Spring',0,8,'2025-03-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_suong_dai_4.jpg'),(2009,201,'Quần Jogger Nỉ Ấm','Quần jogger nỉ, giữ ấm, thích hợp mùa thu/đông.',400000,'Xám, Đen, Xanh Navy','S, M, L, XL','Nỉ Cotton',200,'anh_quan_ao/quan/quan_jogger_ni_am.jpg','Autumn',0,3,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_1.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_2.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_3.jpg','anh_quan_ao/anh_phu_quan/quan_jogger_ni_am_4.jpg'),(2011,201,'Quần Legging Nỉ','Quần legging nỉ, giữ ấm, dáng ôm, thích hợp mùa đông.',380000,'Đen, Xám','S, M, L, XL','Nỉ Cotton',180,'anh_quan_ao/quan/quan_legging_ni.jpg','Autumn',0,43,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/quan_legging_ni_1.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_2.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_3.jpg','anh_quan_ao/anh_phu_quan/quan_legging_ni_4.jpg'),(2013,203,'Chân Váy Dài Len','Chân váy len dài, giữ ấm, form suông thoải mái.',350000,'Be, Nâu, Xám','S, M, L','Len Acrylic',180,'anh_quan_ao/quan/chan_vay_dai_len.jpg','Autumn',0,5,'2025-09-01 00:00:00','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_1.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_2.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_3.jpg','anh_quan_ao/anh_phu_quan/chan_vay_dai_len_4.jpg'),(3001,301,'Ví Da Gấp Đôi Tối Giản','Phụ Kiện Ví da bò thật, thiết kế mỏng, chỉ có logo dập chìm.',390000,'Nâu Đậm, Đen','Free Size','Da Bò Thật',80,'anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg',NULL,0,49,'2025-08-30 14:38:27','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_1.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_2.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_3.jpg','anh_quan_ao/anh_phu_phu_kien/vi_gap_doi_toi_gian_4.jpg'),(3002,302,'Thắt Lưng Da Khóa Cổ Điển','Phụ Kiện Dây nịt da trơn, khóa kim loại đơn giản.',480000,'Đen, Nâu','Free Size','Da Tổng Hợp',65,'anh_quan_ao/phu_kien/that_lung_da.jpg',NULL,0,24,'2025-07-30 14:38:27','anh_quan_ao/anh_phu_phu_kien/that_lung_da_1.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_2.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_3.jpg','anh_quan_ao/anh_phu_phu_kien/that_lung_da_4.jpg'),(3003,301,'Túi Tote Vải Canvas Lớn','Phụ Kiện Túi vải canvas khổ lớn, quai đeo vai, in chữ tối giản.',150000,'Trắng, Đen','Free Size','Canvas dày',300,'anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg',NULL,0,25,'2025-08-02 14:38:27','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_1.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_2.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_3.jpg','anh_quan_ao/anh_phu_phu_kien/tui_tote_vai_canvas_4.jpg'),(3004,302,'Mũ Lưỡi Trai Cotton Trơn','Phụ Kiện Mũ lưỡi trai trơn, không logo, có thể điều chỉnh phía sau.',120000,'Đen, Trắng, Nâu','Free Size','Cotton',220,'anh_quan_ao/phu_kien/mu_luoi_trai.jpg',NULL,0,3,'2025-08-15 14:38:27','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_1.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_2.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_3.jpg','anh_quan_ao/anh_phu_phu_kien/mu_luoi_trai_4.jpg'),(3005,302,'Vớ Cổ Cao Basic (Pack 3)','Phụ Kiện Bộ 3 đôi vớ, chất liệu co giãn, thấm hút mồ hôi.',99000,'Trắng, Xám, Đen','Free Size','Cotton, Spandex',500,'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg',NULL,0,43,'2025-10-14 14:38:27',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `SanPham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SizeDanOng`
--

DROP TABLE IF EXISTS `SizeDanOng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SizeDanOng` (
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
-- Dumping data for table `SizeDanOng`
--

LOCK TABLES `SizeDanOng` WRITE;
/*!40000 ALTER TABLE `SizeDanOng` DISABLE KEYS */;
INSERT INTO `SizeDanOng` VALUES (1,'XS',43.0,88.0,60.0,72.0,88.0,98.0,'155-165cm','45-55kg'),(2,'S',44.5,92.0,61.0,76.0,92.0,100.0,'160-170cm','55-65kg'),(3,'M',46.0,96.0,62.0,80.0,96.0,102.0,'168-175cm','65-75kg'),(4,'L',47.5,100.0,63.0,84.0,100.0,104.0,'170-180cm','75-85kg'),(5,'XL',49.0,104.0,64.0,88.0,104.0,106.0,'175-185cm','85-95kg'),(6,'XXL',50.5,108.0,65.0,92.0,108.0,108.0,'180-190cm','95-105kg'),(7,'3XL',52.0,112.0,66.0,96.0,112.0,110.0,'180-195cm','105-115kg');
/*!40000 ALTER TABLE `SizeDanOng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SizePhuNu`
--

DROP TABLE IF EXISTS `SizePhuNu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SizePhuNu` (
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
-- Dumping data for table `SizePhuNu`
--

LOCK TABLES `SizePhuNu` WRITE;
/*!40000 ALTER TABLE `SizePhuNu` DISABLE KEYS */;
INSERT INTO `SizePhuNu` VALUES (1,'XXS',34.3,78.7,57.8,59.7,83.8,75.5,'135-150','33-45'),(2,'XS',34.9,82.5,58.1,62.2,90.2,79.6,'150-165','45-55'),(3,'S',35.6,86.4,58.4,66.0,94.0,84.6,'165-178','57-70'),(4,'M',36.2,90.2,58.4,69.8,97.8,85.7,'165-178','57-70'),(5,'L',36.8,94.0,58.4,73.7,101.6,87.4,'165-180','63-92'),(6,'XL',37.5,99.1,58.4,78.7,106.7,89.0,'175-185','63-92'),(7,'XXL',38.0,104.1,58.4,83.8,114.3,90.0,'175-180','75-95');
/*!40000 ALTER TABLE `SizePhuNu` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-05 16:12:34
