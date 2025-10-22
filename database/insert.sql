USE QLBanQuanAo;

-- Size Phụ Nữ
INSERT IGNORE INTO SizePhuNu (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang) VALUES
(1, 'XXS', 34.3, 78.7, 57.8, 59.7, 83.8, 75.5, '135-150', '33-45'),
(2, 'XS', 34.9, 82.5, 58.1, 62.2, 90.2, 79.6, '150-165', '45-55'),
(3, 'S', 35.6, 86.4, 58.4, 66, 94, 84.6, '165-178', '57-70'),
(4, 'M', 36.2, 90.2, 58.4, 69.8, 97.8, 85.7, '165-178', '57-70'),
(5, 'L', 36.8, 94, 58.4, 73.7, 101.6, 87.4, '165-180', '63-92'),
(6, 'XL', 37.5, 99.1, 58.4, 78.7, 106.7, 89, '175-185', '63-92'),
(7, 'XXL', 38, 104.1, 58.4, 83.8, 114.3, 90, '175-180', '75-95');

-- Size Nam
INSERT IGNORE INTO SizeDanOng (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang) VALUES
(1, 'XS', 43.0, 88.0, 60.0, 72.0, 88.0, 98.0, '155-165cm', '45-55kg'),
(2, 'S', 44.5, 92.0, 61.0, 76.0, 92.0, 100.0, '160-170cm', '55-65kg'),
(3, 'M', 46.0, 96.0, 62.0, 80.0, 96.0, 102.0, '168-175cm', '65-75kg'),
(4, 'L', 47.5, 100.0, 63.0, 84.0, 100.0, 104.0, '170-180cm', '75-85kg'),
(5, 'XL', 49.0, 104.0, 64.0, 88.0, 104.0, 106.0, '175-185cm', '85-95kg'),
(6, 'XXL', 50.5, 108.0, 65.0, 92.0, 108.0, 108.0, '180-190cm', '95-105kg'),
(7, '3XL', 52.0, 112.0, 66.0, 96.0, 112.0, 110.0, '180-195cm', '105-115kg');

-- Danh mục cấp 1
INSERT IGNORE INTO DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
(100, 'Áo (Tất Cả)', 'Các loại áo mặc thân trên.', NULL),
(200, 'Quần & Váy (Tất Cả)', 'Các loại quần và váy.', NULL),
(300, 'Phụ Kiện (Tất Cả)', 'Các vật dụng đi kèm.', NULL);

-- Danh mục cấp 2
INSERT IGNORE INTO DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
(101, 'Áo Thun Cơ Bản', 'Áo phông cổ tròn, cổ tim, tối giản.', 100),
(102, 'Áo Sơ Mi', 'Sơ mi classic, linen, oxford.', 100),
(103, 'Áo Khoác', 'Hoodie, Sweater, Cardigan, Khoác Gió.', 100),
(201, 'Quần Dài', 'Jeans, Kaki, Jogger, Quần âu.', 200),
(202, 'Quần Ngắn', 'Short Kaki, Short Thun.', 200),
(203, 'Chân Váy', 'Chân váy chữ A, chân váy suông.', 200),
(301, 'Túi & Ví', 'Ví da, túi tote, túi đeo chéo.', 300),
(302, 'Mũ & Vớ', 'Các loại mũ, vớ cơ bản.', 300);

-- Sản phẩm
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
-- ÁO SPRING
(1012, 101, 'Áo Thun Oversize', 'Áo thun form rộng, chất liệu mềm, thoáng khí, màu sắc trẻ trung.', 250000, 'Trắng, Đen, Hồng', 'S, M, L, XL', 'Cotton 100%', 280, 'anh_quan_ao/ao/ao_thun_oversize.jpg', 'Spring'),
(1015, 102, 'Sơ Mi Linen Tay Lửng', 'Sơ mi tay lửng, chất liệu linen thoáng mát, phù hợp mùa xuân hè.', 420000, 'Be, Xanh Nhạt', 'S, M, L', 'Linen', 130, 'anh_quan_ao/ao/so_mi_linen_tay_lung.jpg', 'Spring'),
(1007, 103, 'Áo Len Cổ Tim', 'Áo len cổ tim, mỏng nhẹ, ấm áp khi mùa thu se lạnh.', 360000, 'Hồng, Be, Xám', 'S, M, L', 'Len Acrylic', 210, 'anh_quan_ao/ao/ao_len_co_tim.jpg', 'Spring');

-- ÁO SUMMER
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(1001, 101, 'Áo Thun Cotton Basic', 'Áo thun cổ tròn, form vừa, chất liệu thoáng mát, 100% Cotton.', 199000, 'Trắng, Đen, Xám', 'S, M, L, XL', 'Cotton 100%', 350, 'anh_quan_ao/ao/ao_thun_basic.png', 'Summer'),
(1002, 102, 'Sơ Mi Linen Cổ Điển', 'Sơ mi dài tay, chất liệu linen mát, phù hợp cho mùa hè.', 450000, 'Be, Xanh Navy', 'S, M, L', 'Linen Tự Nhiên', 120, 'anh_quan_ao/ao/so_mi_len_co_dien.jpg', 'Summer'),
(1003, 101, 'Áo Polo Cotton Pique', 'Áo polo phom cơ bản, cổ dệt kim, chất liệu Pique thoáng khí.', 290000, 'Đen, Trắng, Xanh rêu', 'S, M, L, XL', 'Cotton Pique', 250, 'anh_quan_ao/ao/ao_polo_cotton_pique.jpg', 'Summer'),
(1008, 101, 'Áo Thun Polo Ngắn Tay', 'Áo thun polo cổ bẻ, chất liệu cotton thoáng mát, form chuẩn.', 270000, 'Trắng, Xanh Dương, Đen', 'S, M, L, XL', 'Cotton 100%', 220, 'anh_quan_ao/ao/ao_thun_polo_ngan_tay.jpg', 'Summer'),
(1011, 102, 'Sơ Mi Cộc Tay Kẻ Sọc', 'Sơ mi ngắn tay, kẻ sọc thời trang, vải cotton thoáng mát.', 330000, 'Trắng, Xanh', 'S, M, L, XL', 'Cotton', 180, 'anh_quan_ao/ao/so_mi_coc_tay_ke_soc.jpeg', 'Summer');

-- ÁO AUTUMN
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(1006, 104, 'Áo Len Mỏng Cổ Tròn', 'Áo len mỏng, form vừa, mềm mại, thoáng khí, phù hợp mùa thu.', 320000, 'Be, Nâu, Xám', 'S, M, L', 'Acrylic và Len', 200, 'anh_quan_ao/ao/ao_len_mong_co_tron.jpg', 'Autumn'),
(1009, 103, 'Áo Khoác Cardigan Dài', 'Áo cardigan dệt kim dài, nhẹ nhàng, ấm áp, phong cách Hàn Quốc.', 490000, 'Xám, Đen, Be', 'S, M, L', 'Len tổng hợp', 300, 'anh_quan_ao/ao/ao_khoac_cardigan_dai.jpg', 'Autumn'),
(1013, 104, 'Áo Len Cổ Tim', 'Áo len cổ tim, mỏng nhẹ, ấm áp khi mùa thu se lạnh.', 360000, 'Hồng, Be, Xám', 'S, M, L', 'Len Acrylic', 210, 'anh_quan_ao/ao/ao_len_co_tim.jpg', 'Autumn'),
(1017, 103, 'Áo Hoodie Mỏng', 'Áo hoodie mỏng, form rộng, phù hợp mùa thu se lạnh.', 500000, 'Xám, Đen, Be', 'S, M, L, XL', 'Nỉ mỏng', 170, 'anh_quan_ao/ao/ao_hoodie_mong.jpg', 'Autumn');

-- ÁO WINTER
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(1004, 103, 'Áo Hoodie Nỉ Phom Rộng', 'Áo hoodie có mũ, phom rộng thoải mái, nỉ bông dày dặn.', 550000, 'Xám tro, Kem, Đen', 'M, L, XL', 'Nỉ Bông (Fleece)', 180, 'anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg', 'Winter'),
(1005, 103, 'Áo Khoác Gió Hai Lớp', 'Áo khoác ngoài nhẹ, chống nước nhẹ, có khóa kéo và mũ.', 690000, 'Xanh Navy, Be, Xám', 'S, M, L, XL', 'Polyester', 100, 'anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg', 'Winter'),
(1010, 105, 'Áo Khoác Phao Lông Vũ', 'Áo khoác phao dày, giữ nhiệt tốt, chống gió cho mùa đông.', 850000, 'Đen, Xanh Navy', 'M, L, XL', 'Lông Vũ + Polyester', 600, 'anh_quan_ao/ao/ao_khoac_phao_long_vu.jpg', 'Winter'),
(1014, 105, 'Áo Khoác Dạ Ngắn', 'Áo khoác dạ ngắn, giữ nhiệt tốt, kiểu dáng trẻ trung.', 780000, 'Đen, Xanh Navy', 'M, L, XL', 'Len + Polyester', 550, 'anh_quan_ao/ao/ao_khoac_da_ngan.jpg', 'Winter'),
(1018, 104, 'Áo Len Cổ Lọ', 'Áo len cổ lọ, giữ ấm nhẹ, phong cách thanh lịch cho mùa đông.', 400000, 'Đen, Xám, Nâu', 'S, M, L', 'Len Acrylic', 320, 'anh_quan_ao/ao/ao_len_co_lo.jpg', 'Winter');

-- QUẦN & VÁY
-- SPRING
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2001, 201, 'Quần Jeans Slim-fit', 'Quần jeans dáng đứng, tối giản, không rách.', 650000, 'Xanh Đậm, Đen', '29, 30, 31, 32', 'Denim Co Giãn', 200, 'anh_quan_ao/quan/quan_jean_slim_fit.jpg', 'Spring'),
(2006, 201, 'Quần Kaki Dài Mỏng', 'Quần kaki dài, mỏng nhẹ, thoáng khí, thích hợp mùa xuân/hè.', 320000, 'Be, Xanh Olive, Xám', '29, 30, 31, 32', 'Kaki Cotton', 180, 'anh_quan_ao/quan/quan_kaki_mong.jpg', 'Spring'),
(2004, 202, 'Quần Short Kaki Phẳng', 'Quần short đứng dáng, độ dài trên gối, cạp phẳng.', 280000, 'Trắng ngà, Xanh mint', '29, 30, 31, 32', 'Kaki', 140, 'anh_quan_ao/quan/quan_short_kaki.jpg', 'Spring'),
(2007, 202, 'Quần Short Thun Năng Động', 'Quần short thun, co giãn, form thoải mái, mùa hạ.', 250000, 'Xám, Đen, Xanh', 'S, M, L, XL', 'Cotton/Spandex', 130, 'anh_quan_ao/quan/quan_short_thun_nang_dong.jpg', 'Spring'),
(2008, 203, 'Chân Váy Suông Dài', 'Chân váy suông dài, thoáng mát, dễ phối đồ.', 320000, 'Xanh, Be, Nâu', 'S, M, L', 'Voan', 150, 'anh_quan_ao/quan/chan_vay_suong_dai.jpg', 'Spring'),
(2002, 203, 'Chân Váy Chữ A cơ bản', 'Chan vay chu A, tre trung, de phoi do.', 300000, 'Den, Be, Xanh', 'S, M, L', 'Cotton/Polyester', 150, 'static/anh_quan_ao/quan/chan_vay_chu_a.jpg', 'Spring');

-- AUTUMN
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2005, 201, 'Quần Jeans Ống Suông', 'Quần jeans ống suông, co giãn nhẹ, dáng rộng thoải mái.', 380000, 'Xanh Denim, Đen', '29, 30, 31, 32', 'Denim Cotton', 200, 'anh_quan_ao/quan/quan_jeans_ong_suong.jpg', 'Autumn'),
(2003, 201, 'Quần Jogger Thun Basic', 'Quần jogger bo gấu, lưng thun, có dây rút, thích hợp mặc nhà/tập luyện.', 350000, 'Đen, Xám Melange', 'S, M, L, XL', 'Cotton/Spandex', 160, 'anh_quan_ao/quan/quan_jogger_thun.jpg','Autumn'),
(2009, 201, 'Quần Jogger Nỉ Ấm', 'Quần jogger nỉ, giữ ấm, thích hợp mùa thu/đông.', 400000, 'Xám, Đen, Xanh Navy', 'S, M, L, XL', 'Nỉ Cotton', 200, 'anh_quan_ao/quan/quan_jogger_ni_am.jpg', 'Autumn'),
(2011, 201, 'Quần Legging Nỉ', 'Quần legging nỉ, giữ ấm, dáng ôm, thích hợp mùa đông.', 380000, 'Đen, Xám', 'S, M, L, XL', 'Nỉ Cotton', 180, 'anh_quan_ao/quan/quan_legging_ni.jpg', 'Autumn'),
(2013, 203, 'Chân Váy Dài Len', 'Chân váy len dài, giữ ấm, form suông thoải mái.', 350000, 'Be, Nâu, Xám', 'S, M, L', 'Len Acrylic', 180, 'anh_quan_ao/quan/chan_vay_dai_len.jpg', 'Autumn');

-- WINTER
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2010, 201, 'Quần Jeans Ống Côn', 'Quần jeans ống côn, dáng ôm vừa, tối giản.', 390000, 'Xanh Denim, Đen', '29, 30, 31, 32', 'Denim Cotton', 210, 'anh_quan_ao/quan/quan_jeans_ong_con.jpg', 'Winter'),
(2012, 201, 'Quần Dạ Ống Rộng', 'Quần dạ ống rộng, giữ ấm, phong cách thanh lịch.', 500000, 'Đen, Xám, Nâu', '29, 30, 31, 32', 'Dạ + Polyester', 250, 'anh_quan_ao/quan/quan_da_ong_rong.jpg', 'Winter');

-- PHỤ KIỆN
INSERT IGNORE INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(3001, 301, 'Ví Da Gấp Đôi Tối Giản', 'Ví da bò thật, thiết kế mỏng, chỉ có logo dập chìm.', 390000, 'Nâu Đậm, Đen', 'Free Size', 'Da Bò Thật', 80, 'anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg','Spring'),
(3006, 301, 'Túi Đeo Chéo Mini', 'Túi đeo chéo nhỏ gọn, phong cách casual, nhiều ngăn.', 220000, 'Đen, Xám, Nâu', 'Free Size', 'Canvas + Polyester', 250, 'anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg','Spring'),
(3002, 302, 'Thắt Lưng Da Khóa Cổ Điển', 'Dây nịt da trơn, khóa kim loại đơn giản.', 480000, 'Đen, Nâu', 'Free Size', 'Da Tổng Hợp', 65, 'anh_quan_ao/phukien/that_lung_da.jpg','Summer'),
(3003, 301, 'Túi Tote Vải Canvas Lớn', 'Túi vải canvas khổ lớn, quai đeo vai, in chữ tối giản.', 150000, 'Trắng, Đen', 'Free Size', 'Canvas dày', 300, 'anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg','Summer'),
(3004, 302, 'Mũ Lưỡi Trai Cotton Trơn', 'Mũ lưỡi trai trơn, không logo, có thể điều chỉnh phía sau.', 120000, 'Đen, Trắng, Nâu', 'Free Size', 'Cotton', 220, 'anh_quan_ao/phu_kien/mu_luoi_trai.jpg','Summer'),
(3007, 301, 'Túi Đeo Vai Da Tổng Hợp', 'Túi da tổng hợp, quai da dài, phong cách tối giản.', 350000, 'Đen, Nâu', 'Free Size', 'Da Tổng Hợp', 300, 'anh_quan_ao/phu_kien/tui_deo_vai_da.jpg','Autumn'),
(3008, 302, 'Mũ Beanie Len', 'Mũ beanie chất liệu len acrylic, giữ ấm mùa đông.', 180000, 'Đen, Xám, Nâu', 'Free Size', 'Len Acrylic', 120, 'anh_quan_ao/phu_kien/mu_beanie_len.jpg','Autumn'),
(3009, 302, 'Thắt Lưng Da Khóa Kim Loại', 'Dây nịt da thật, khóa kim loại sang trọng.', 520000, 'Đen, Nâu', 'Free Size', 'Da Bò Thật', 70, 'anh_quan_ao/phu_kien/that_lung_da_khoa_kim_loai.jpg','Autumn'),
(3010, 302, 'Vớ Ngắn Cotton Basic (Pack 5)', 'Bộ 5 đôi vớ ngắn, co giãn tốt, thấm hút mồ hôi.', 120000, 'Trắng, Xám, Đen', 'Free Size', 'Cotton + Spandex', 400, 'anh_quan_ao/phu_kien/vo_ngan_cotton_pack5.jpg','Autumn'),
(3011, 301, 'Túi Đeo Hông Thời Trang', 'Túi đeo hông nhỏ gọn, dây điều chỉnh, phong cách năng động.', 200000, 'Đen, Xanh Olive', 'Free Size', 'Polyester', 180, 'anh_quan_ao/phu_kien/tui_deo_hong_thoi_trang.jpg','Winter'),
(3012, 301, 'Túi Đeo Vai Mini', 'Túi mini, quai đeo vai, thích hợp đi chơi hoặc đi làm.', 190000, 'Đen, Be', 'Free Size', 'Canvas + Polyester', 160, 'anh_quan_ao/phu_kien/tui_deo_vai_mini.jpg','Winter'),
(3013, 302, 'Mũ Snapback Thể Thao', 'Mũ snapback, điều chỉnh size phía sau, phong cách năng động.', 150000, 'Đen, Xanh Navy, Trắng', 'Free Size', 'Cotton', 220, 'anh_quan_ao/phu_kien/mu_snapback_the_thao.jpg','Winter'),
(3014, 302, 'Vớ Cổ Cao Thời Trang (Pack 3)', 'Bộ 3 đôi vớ ngắn, chất liệu cotton co giãn, màu cơ bản.', 95000, 'Trắng, Xám, Đen', 'Free Size', 'Cotton + Spandex', 350, 'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg','Winter');

-- LỆNH UPDATE BỔ SUNG ĐỂ FIX LỖI ẢNH!
-- Lệnh này sẽ thêm 'static/' vào đầu tất cả các đường dẫn ảnh vừa được INSERT,
-- và cũng sẽ sửa các bản ghi cũ nếu chúng chưa có tiền tố này.

-- Cập nhật đường dẫn ảnh
SET SQL_SAFE_UPDATES = 0;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_thun_oversize.jpg' WHERE MaSP = 1012;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/so_mi_linen_tay_lung.jpg' WHERE MaSP = 1015;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_len_co_tim.jpg' WHERE MaSP = 1007;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_thun_basic.png' WHERE MaSP = 1001;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/so_mi_len_co_dien.jpg' WHERE MaSP = 1002;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_polo_cotton_pique.jpg' WHERE MaSP = 1003;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_thun_polo_ngan_tay.jpg' WHERE MaSP = 1008;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/so_mi_coc_tay_ke_soc.jpeg' WHERE MaSP = 1011;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_len_mong_co_tron.jpg' WHERE MaSP = 1006;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_khoac_cardigan_dai.jpg' WHERE MaSP = 1009;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_len_co_tim.jpg' WHERE MaSP = 1013;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_hoodie_mong.jpg' WHERE MaSP = 1017;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg' WHERE MaSP = 1004;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg' WHERE MaSP = 1005;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_khoac_phao_long_vu.jpg' WHERE MaSP = 1010;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_khoac_da_ngan.jpg' WHERE MaSP = 1014;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/ao/ao_len_co_lo.jpg' WHERE MaSP = 1018;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_jean_slim_fit.jpg' WHERE MaSP = 2001;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_kaki_mong.jpg' WHERE MaSP = 2006;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_short_kaki.jpg' WHERE MaSP = 2004;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_short_thun_nang_dong.jpg' WHERE MaSP = 2007;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/chan_vay_suong_dai.jpg' WHERE MaSP = 2008;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_jeans_ong_suong.jpg' WHERE MaSP = 2005;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_jogger_thun.jpg' WHERE MaSP = 2003;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_jogger_ni_am.jpg' WHERE MaSP = 2009;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_legging_ni.jpg' WHERE MaSP = 2011;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/chan_vay_dai_len.jpg' WHERE MaSP = 2013;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_jeans_ong_con.jpg' WHERE MaSP = 2010;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/quan/quan_da_ong_rong.jpg' WHERE MaSP = 2012;

UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg' WHERE MaSP = 3001;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg' WHERE MaSP = 3006;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/that_lung_da.jpg' WHERE MaSP = 3002;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg' WHERE MaSP = 3003;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/mu_luoi_trai.jpg' WHERE MaSP = 3004;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/tui_deo_vai_da.jpg' WHERE MaSP = 3007;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/mu_beanie_len.jpg' WHERE MaSP = 3008;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/that_lung_da_khoa_kim_loai.jpg' WHERE MaSP = 3009;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/vo_ngan_cotton_pack5.jpg' WHERE MaSP = 3010;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/tui_deo_hong_thoi_trang.jpg' WHERE MaSP = 3011;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/tui_deo_vai_mini.jpg' WHERE MaSP = 3012;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/mu_snapback_the_thao.jpg' WHERE MaSP = 3013;
UPDATE SanPham SET HinhAnh = 'static/anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg' WHERE MaSP = 3014;
UPDATE SanPham
SET HinhAnh = 'static/anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg'
WHERE MaSP = 3014;
UPDATE SanPham
SET HinhAnh = 'static/anh_quan_ao/quan/chan_vay_chu_a.jpg'
WHERE MaSP = 2002;

SET SQL_SAFE_UPDATES = 1;

-- Thêm cột NgayNhap
SELECT COUNT(*) INTO @col_exists
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='QLBanQuanAo'
  AND TABLE_NAME='SanPham'
  AND COLUMN_NAME='NgayNhap';

SET @sql_stmt = IF(@col_exists = 0,
                   'ALTER TABLE SanPham ADD NgayNhap DATE DEFAULT CURDATE()',
                   'SELECT "Column already exists"');

PREPARE stmt FROM @sql_stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Cập nhật NgayNhap theo mùa
SET SQL_SAFE_UPDATES = 0;
-- SPRING
UPDATE SanPham SET Season = 'Spring'
WHERE MaSP IN (1012, 1015, 1007, 2001, 2004, 2006, 2007, 2008);

-- SUMMER
UPDATE SanPham SET Season = 'Summer'
WHERE MaSP IN (1001, 1002, 1003, 1008, 1011);
-- (không có quần/váy Summer trong dữ liệu hiện tại)

-- AUTUMN
UPDATE SanPham SET Season = 'Autumn'
WHERE MaSP IN (1006, 1009, 1013, 1017, 2003, 2005, 2009, 2011, 2013);

-- WINTER
UPDATE SanPham SET Season = 'Winter'
WHERE MaSP IN (1004, 1005, 1010, 1014, 1018, 2010, 2012);

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE SanPham SET NgayNhap = '2025-03-01' WHERE Season = 'Spring';
UPDATE SanPham SET NgayNhap = '2025-06-01' WHERE Season = 'Summer';
UPDATE SanPham SET NgayNhap = '2025-09-01' WHERE Season = 'Autumn';
UPDATE SanPham SET NgayNhap = '2025-12-01' WHERE Season = 'Winter';
SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = 0;
UPDATE SanPham
SET Discount = FLOOR(RAND() * 51)   -- số ngẫu nhiên từ 0 đến 50
WHERE MaSP >= 1001;
SET SQL_SAFE_UPDATES = 1;
-- Kiểm tra kết quả
SELECT MaSP, TenSP, Season, NgayNhap
FROM SanPham
ORDER BY Season, MaSP;
