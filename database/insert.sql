USE QLBanQuanAo;

-- Size Phụ Nữ
INSERT INTO SizePhuNu (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang) VALUES
(1, 'XXS', 34.3, 78.7, 57.8, 59.7, 83.8, 75.5, '135-150', '33-45'),
(2, 'XS', 34.9, 82.5, 58.1, 62.2, 90.2, 79.6, '150-165', '45-55'),
(3, 'S', 35.6, 86.4, 58.4, 66, 94, 84.6, '165-178', '57-70'),
(4, 'M', 36.2, 90.2, 58.4, 69.8, 97.8, 85.7, '165-178', '57-70'),
(5, 'L', 36.8, 94, 58.4, 73.7, 101.6, 87.4, '165-180', '63-92'),
(6, 'XL', 37.5, 99.1, 58.4, 78.7, 106.7, 89, '175-185', '63-92'),
(7, 'XXL', 38, 104.1, 58.4, 83.8, 114.3, 90, '175-180', '75-95');

-- Size Nam
INSERT INTO SizeDanOng (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang) VALUES
(1, 'XS', 43.0, 88.0, 60.0, 72.0, 88.0, 98.0, N'155-165cm', N'45-55kg'),
(2, 'S', 44.5, 92.0, 61.0, 76.0, 92.0, 100.0, N'160-170cm', N'55-65kg'),
(3, 'M', 46.0, 96.0, 62.0, 80.0, 96.0, 102.0, N'168-175cm', N'65-75kg'),
(4, 'L', 47.5, 100.0, 63.0, 84.0, 100.0, 104.0, N'170-180cm', N'75-85kg'),
(5, 'XL', 49.0, 104.0, 64.0, 88.0, 104.0, 106.0, N'175-185cm', N'85-95kg'),
(6, 'XXL', 50.5, 108.0, 65.0, 92.0, 108.0, 108.0, N'180-190cm', N'95-105kg'),
(7, '3XL', 52.0, 112.0, 66.0, 96.0, 112.0, 110.0, N'180-195cm', N'105-115kg');

-- Danh mục cấp 1
INSERT INTO DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
(100, N'Áo (Tất Cả)', N'Các loại áo mặc thân trên.', NULL),
(200, N'Quần & Váy (Tất Cả)', N'Các loại quần và váy.', NULL),
(300, N'Phụ Kiện (Tất Cả)', N'Các vật dụng đi kèm.', NULL);

-- Danh mục cấp 2
INSERT INTO DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
(101, N'Áo Thun Cơ Bản', N'Áo phông cổ tròn, cổ tim, tối giản.', 100),
(102, N'Áo Sơ Mi', N'Sơ mi classic, linen, oxford.', 100),
(103, N'Áo Khoác', N'Hoodie, Sweater, Cardigan, Khoác Gió.', 100),
(201, N'Quần Dài', N'Jeans, Kaki, Jogger, Quần âu.', 200),
(202, N'Quần Ngắn', N'Short Kaki, Short Thun.', 200),
(203, N'Chân Váy', N'Chân váy chữ A, chân váy suông.', 200),
(301, N'Túi & Ví', N'Ví da, túi tote, túi đeo chéo.', 300),
(302, N'Mũ & Vớ', N'C ác loại mũ, vớ cơ bản.', 300);

-- Sản phẩm
INSERT INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
-- ÁO SPRING
(1012, 101, N'Áo Thun Oversize', N'Áo thun form rộng, chất liệu mềm, thoáng khí, màu sắc trẻ trung.', 250000, N'Trắng, Đen, Hồng', N'S, M, L, XL', N'Cotton 100%', 280, 'anh_quan_ao/ao/ao_thun_oversize.jpg', 'Spring'),
(1015, 102, N'Sơ Mi Linen Tay Lửng', N'Sơ mi tay lửng, chất liệu linen thoáng mát, phù hợp mùa xuân hè.', 420000, N'Be, Xanh Nhạt', N'S, M, L', N'Linen', 130, 'anh_quan_ao/ao/so_mi_linen_tay_lung.jpg', 'Spring'),
(1017, 104, N'Áo Len Cổ Tim', N'Áo len cổ tim, mỏng nhẹ, ấm áp khi mùa thu se lạnh.', 360000, N'Hồng, Be, Xám', N'Len Acrylic', N'S, M, L', 210, 'anh_quan_ao/ao/ao_len_co_tim.jpg', 'Spring'),



-- ÁO SUMMER
(1001, 101, N'Áo Thun Cotton Basic', N'Áo thun cổ tròn, form vừa, chất liệu thoáng mát, 100% Cotton.', 199000, N'Trắng, Đen, Xám', N'S, M, L, XL', N'Cotton 100%', 350, 'anh_quan_ao/ao/ao_thun_basic.png', 'Summer'),
(1002, 102, N'Sơ Mi Linen Cổ Điển', N'Sơ mi dài tay, chất liệu linen mát, phù hợp cho mùa hè.', 450000, N'Be, Xanh Navy', N'S, M, L', N'Linen Tự Nhiên', 120, 'anh_quan_ao/ao/so_mi_len_co_dien.jpg', 'Summer'),
(1003, 101, N'Áo Polo Cotton Pique', N'Áo polo phom cơ bản, cổ dệt kim, chất liệu Pique thoáng khí.', 290000, N'Đen, Trắng, Xanh rêu', N'S, M, L, XL', N'Cotton Pique', 250, 'anh_quan_ao/ao/ao_polo_cotton_pique.jpg', 'Summer'),
(1008, 101, N'Áo Thun Polo Ngắn Tay', N'Áo thun polo cổ bẻ, chất liệu cotton thoáng mát, form chuẩn.', 270000, N'Trắng, Xanh Dương, Đen', N'S, M, L, XL', N'Cotton 100%', 220, 'anh_quan_ao/ao/ao_thun_polo_ngan_tay.jpg', 'Summer'),
(1011, 102, N'Sơ Mi Cộc Tay Kẻ Sọc', N'Sơ mi ngắn tay, kẻ sọc thời trang, vải cotton thoáng mát.', 330000, N'Trắng, Xanh', N'S, M, L, XL', N'Cotton', 180, 'anh_quan_ao/ao/so_mi_coc_tay_ke_soc.jpeg', 'Summer'),

-- ÁO AUTUMN
(1006, 104, N'Áo Len Mỏng Cổ Tròn', N'Áo len mỏng, form vừa, mềm mại, thoáng khí, phù hợp mùa thu.', 320000, N'Be, Nâu, Xám', N'S, M, L', N'Acrylic và Len', 200, 'anh_quan_ao/ao/ao_len_mong_co_tron.jpg', 'Autumn'),
(1009, 103, N'Áo Khoác Cardigan Dài', N'Áo cardigan dệt kim dài, nhẹ nhàng, ấm áp, phong cách Hàn Quốc.', 490000, N'Xám, Đen, Be', N'S, M, L', N'Len tổng hợp', 300, 'anh_quan_ao/ao/ao_khoac_cardigan_dai.jpg', 'Autumn'),
(1013, 104, N'Áo Len Cổ Tim', N'Áo len cổ tim, mỏng nhẹ, ấm áp khi mùa thu se lạnh.', 360000, N'Hồng, Be, Xám', N'S, M, L', N'Len Acrylic', 210, 'anh_quan_ao/ao/ao_len_co_tim.jpg', 'Autumn'),
(1017, 103, N'Áo Hoodie Mỏng', N'Áo hoodie mỏng, form rộng, phù hợp mùa thu se lạnh.', 500000, N'Xám, Đen, Be', N'S, M, L, XL', N'Nỉ mỏng', 170, 'anh_quan_ao/ao/ao_hoodie_mong.jpg', 'Autumn'),

-- ÁO WINTER
(1004, 103, N'Áo Hoodie Nỉ Phom Rộng', N'Áo hoodie có mũ, phom rộng thoải mái, nỉ bông dày dặn.', 550000, N'Xám tro, Kem, Đen', N'M, L, XL', N'Nỉ Bông (Fleece)', 180, 'anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg', 'Winter'),
(1005, 103, N'Áo Khoác Gió Hai Lớp', N'Áo khoác ngoài nhẹ, chống nước nhẹ, có khóa kéo và mũ.', 690000, N'Xanh Navy, Be, Xám', N'S, M, L, XL', N'Polyester', 100, 'anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg', 'Winter'),
(1010, 105, N'Áo Khoác Phao Lông Vũ', N'Áo khoác phao dày, giữ nhiệt tốt, chống gió cho mùa đông.', 850000, N'Đen, Xanh Navy', N'M, L, XL', N'Lông Vũ + Polyester', 600, 'anh_quan_ao/ao/ao_khoac_phao_long_vu.jpg', 'Winter'),
(1014, 105, N'Áo Khoác Dạ Ngắn', N'Áo khoác dạ ngắn, giữ nhiệt tốt, kiểu dáng trẻ trung.', 780000, N'Đen, Xanh Navy', N'M, L, XL', N'Len + Polyester', 550, 'anh_quan_ao/ao/ao_khoac_da_ngan.jpg', 'Winter'),
(1018, 104, N'Áo Len Cổ Lọ', N'Áo len cổ lọ, giữ ấm nhẹ, phong cách thanh lịch cho mùa đông.', 400000, N'Đen, Xám, Nâu', N'S, M, L', N'Len Acrylic', 320, 'anh_quan_ao/ao/ao_len_co_lo.jpg', 'Winter');

-- QUẦN & VÁY
-- (Các sản phẩm Summer, Autumn, Winter tương tự, mình sẽ sắp xếp và gửi tiếp nếu bạn muốn)
-- SPRING
INSERT INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2001, 201, N'Quần Jeans Slim-fit', N'Quần jeans dáng đứng, tối giản, không rách.', 650000, N'Xanh Đậm, Đen', N'29, 30, 31, 32', N'Denim Co Giãn', 200, 'anh_quan_ao/quan/quan_jean_slim_fit.jpg', 'Spring'),
(2006, 201, N'Quần Kaki Dài Mỏng', N'Quần kaki dài, mỏng nhẹ, thoáng khí, thích hợp mùa xuân/hè.', 320000, N'Be, Xanh Olive, Xám', N'29, 30, 31, 32', N'Kaki Cotton', 180, 'anh_quan_ao/quan/quan_kaki_mong.jpg', 'Spring'),
(2004, 202, N'Quần Short Kaki Phẳng', N'Quần short đứng dáng, độ dài trên gối, cạp phẳng.', 280000, N'Trắng ngà, Xanh mint', N'29, 30, 31, 32', N'Kaki', 140, 'anh_quan_ao/quan/quan_short_kaki.jpg', 'Spring'),
(2007, 202, N'Quần Short Thun Năng Động', N'Quần short thun, co giãn, form thoải mái, mùa hạ.', 250000, N'Xám, Đen, Xanh', N'S, M, L, XL', N'Cotton/Spandex', 130, 'anh_quan_ao/quan/quan_short_thun_nang_dong.jpg', 'Spring'),
(2008, 203, N'Chân Váy Suông Dài', N'Chân váy suông dài, thoáng mát, dễ phối đồ.', 320000, N'Xanh, Be, Nâu', N'S, M, L', N'Voan', 150, 'anh_quan_ao/quan/chan_vay_suong_dai.jpg', 'Spring');

-- AUTUMN
INSERT INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2005, 201, N'Quần Jeans Ống Suông', N'Quần jeans ống suông, co giãn nhẹ, dáng rộng thoải mái.', 380000, N'Xanh Denim, Đen', N'29, 30, 31, 32', N'Denim Cotton', 200, 'anh_quan_ao/quan/quan_jeans_ong_suong.jpg', 'Autumn'),
(2003, 201, N'Quần Jogger Thun Basic', N'Quần jogger bo gấu, lưng thun, có dây rút, thích hợp mặc nhà/tập luyện.', 350000, N'Đen, Xám Melange', N'S, M, L, XL', N'Cotton/Spandex', 160, 'anh_quan_ao/quan/quan_jogger_thun.jpg','Autumn'),
(2009, 201, N'Quần Jogger Nỉ Ấm', N'Quần jogger nỉ, giữ ấm, thích hợp mùa thu/đông.', 400000, N'Xám, Đen, Xanh Navy', N'S, M, L, XL', N'Nỉ Cotton', 200, 'anh_quan_ao/quan/quan_jogger_ni_am.jpg', 'Autumn'),
(2011, 201, N'Quần Legging Nỉ', N'Quần legging nỉ, giữ ấm, dáng ôm, thích hợp mùa đông.', 380000, N'Đen, Xám', N'S, M, L, XL', N'Nỉ Cotton', 180, 'anh_quan_ao/quan/quan_legging_ni.jpg', 'Autumn'),
(2013, 203, N'Chân Váy Dài Len', N'Chân váy len dài, giữ ấm, form suông thoải mái.', 350000, N'Be, Nâu, Xám', N'S, M, L', N'Len Acrylic', 180, 'anh_quan_ao/quan/chan_vay_dai_len.jpg', 'Autumn');

-- WINTER
INSERT INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(2010, 201, N'Quần Jeans Ống Côn', N'Quần jeans ống côn, dáng ôm vừa, tối giản.', 390000, N'Xanh Denim, Đen', N'29, 30, 31, 32', N'Denim Cotton', 210, 'anh_quan_ao/quan/quan_jeans_ong_con.jpg', 'Winter'),
(2012, 201, N'Quần Dạ Ống Rộng', N'Quần dạ ống rộng, giữ ấm, phong cách thanh lịch.', 500000, N'Đen, Xám, Nâu', N'29, 30, 31, 32', N'Dạ + Polyester', 250, 'anh_quan_ao/quan/quan_da_ong_rong.jpg', 'Winter');

-- PHỤ KIỆN
INSERT INTO SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
(3001, 301, N'Ví Da Gấp Đôi Tối Giản', N'Ví da bò thật, thiết kế mỏng, chỉ có logo dập chìm.', 390000, N'Nâu Đậm, Đen', N'Free Size', N'Da Bò Thật', 80, 'anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg','Spring'),
(3006, 301, N'Túi Đeo Chéo Mini', N'Túi đeo chéo nhỏ gọn, phong cách casual, nhiều ngăn.', 220000, N'Đen, Xám, Nâu', N'Free Size', N'Canvas + Polyester', 250, 'anh_quan_ao/phu_kien/tui_deo_cheo_mini.jpg','Spring'),
(3002, 302, N'Thắt Lưng Da Khóa Cổ Điển', N'Dây nịt da trơn, khóa kim loại đơn giản.', 480000, N'Đen, Nâu', N'Free Size', N'Da Tổng Hợp', 65, 'anh_quan_ao/phukien/that_lung_da.jpg','Summer'),
(3003, 301, N'Túi Tote Vải Canvas Lớn', N'Túi vải canvas khổ lớn, quai đeo vai, in chữ tối giản.', 150000, N'Trắng, Đen', N'Free Size', N'Canvas dày', 300, 'anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg','Summer'),
(3004, 302, N'Mũ Lưỡi Trai Cotton Trơn', N'Mũ lưỡi trai trơn, không logo, có thể điều chỉnh phía sau.', 120000, N'Đen, Trắng, Nâu', N'Free Size', N'Cotton', 220, 'anh_quan_ao/phu_kien/mu_luoi_trai.jpg','Summer'),
(3007, 301, N'Túi Đeo Vai Da Tổng Hợp', N'Túi da tổng hợp, quai da dài, phong cách tối giản.', 350000, N'Đen, Nâu', N'Free Size', N'Da Tổng Hợp', 300, 'anh_quan_ao/phu_kien/tui_deo_vai_da.jpg','Autumn'),
(3008, 302, N'Mũ Beanie Len', N'Mũ beanie chất liệu len acrylic, giữ ấm mùa đông.', 180000, N'Đen, Xám, Nâu', N'Free Size', N'Len Acrylic', 120, 'anh_quan_ao/phu_kien/mu_beanie_len.jpg','Autumn'),
(3009, 302, N'Thắt Lưng Da Khóa Kim Loại', N'Dây nịt da thật, khóa kim loại sang trọng.', 520000, N'Đen, Nâu', N'Free Size', N'Da Bò Thật', 70, 'anh_quan_ao/phu_kien/that_lung_da_khoa_kim_loai.jpg','Autumn'),
(3010, 302, N'Vớ Ngắn Cotton Basic (Pack 5)', N'Bộ 5 đôi vớ ngắn, co giãn tốt, thấm hút mồ hôi.', 120000, N'Trắng, Xám, Đen', N'Free Size', N'Cotton + Spandex', 400, 'anh_quan_ao/phu_kien/vo_ngan_cotton_pack5.jpg','Autumn'),
(3011, 301, N'Túi Đeo Hông Thời Trang', N'Túi đeo hông nhỏ gọn, dây điều chỉnh, phong cách năng động.', 200000, N'Đen, Xanh Olive', N'Free Size', N'Polyester', 180, 'anh_quan_ao/phu_kien/tui_deo_hong_thoi_trang.jpg','Winter'),
(3012, 301, N'Túi Đeo Vai Mini', N'Túi mini, quai đeo vai, thích hợp đi chơi hoặc đi làm.', 190000, N'Đen, Be', N'Free Size', N'Canvas + Polyester', 160, 'anh_quan_ao/phu_kien/tui_deo_vai_mini.jpg','Winter'),
(3013, 302, N'Mũ Snapback Thể Thao', N'Mũ snapback, điều chỉnh size phía sau, phong cách năng động.', 150000, N'Đen, Xanh Navy, Trắng', N'Free Size', N'Cotton', 220, 'anh_quan_ao/phu_kien/mu_snapback_the_thao.jpg','Winter'),
(3014, 302, N'Vớ Cổ Cao Thời Trang (Pack 3)', N'Bộ 3 đôi vớ ngắn, chất liệu cotton co giãn, màu cơ bản.', 95000, N'Trắng, Xám, Đen', N'Free Size', N'Cotton + Spandex', 350, 'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg','Winter');

ALTER TABLE SanPham
ADD COLUMN Sold INT DEFAULT 0,
ADD COLUMN Discount INT;

UPDATE SanPham
SET Discount = FLOOR(RAND() * 51)   -- số ngẫu nhiên từ 0 đến 50
WHERE MaSP >= 1001;