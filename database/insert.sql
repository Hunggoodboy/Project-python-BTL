INSERT INTO QLBanQuanAo.SizePhuNu (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang)
VALUES
(1, 'XXS', 34.3, 78.7, 57.8, 59.7, 83.8, 75.5, '135-150', '33-45'),
(2, 'XS', 34.9, 82.5, 58.1, 62.2, 90.2, 79.6, '150-165', '45-55'),
(3, 'S', 35.6, 86.4, 58.4, 66, 94, 84.6, '165-178', '57-70'),
(4, 'M', 36.2, 90.2, 58.4, 69.8, 97.8, 85.7, '165-178', '57-70'),
(5, 'L', 36.8, 94, 58.4, 73.7, 101.6, 87.4, '165-180', '63-92'),
(6, 'XL', 37.5, 99.1, 58.4, 78.7, 106.7, 89, '175-185', '63-92'),
(7, 'XXL', 38, 104.1, 58.4, 83.8, 114.3, 90, '175-180', '75-95');
INSERT INTO QLBanQuanAo.SizeDanOng (id, MaSize, NgangVai, VongNguc, TayAo, Eo, Hong, DaiQuan, ChieuCao, CanNang)
VALUES
(1, 'XS', 43.0, 88.0, 60.0, 72.0, 88.0, 98.0, N'155-165cm', N'45-55kg'),
(2, 'S', 44.5, 92.0, 61.0, 76.0, 92.0, 100.0, N'160-170cm', N'55-65kg'),
(3, 'M', 46.0, 96.0, 62.0, 80.0, 96.0, 102.0, N'168-175cm', N'65-75kg'),
(4, 'L', 47.5, 100.0, 63.0, 84.0, 100.0, 104.0, N'170-180cm', N'75-85kg'),
(5, 'XL', 49.0, 104.0, 64.0, 88.0, 104.0, 106.0, N'175-185cm', N'85-95kg'),
(6, 'XXL', 50.5, 108.0, 65.0, 92.0, 108.0, 108.0, N'180-190cm', N'95-105kg'),
(7, '3XL', 52.0, 112.0, 66.0, 96.0, 112.0, 110.0, N'180-195cm', N'105-115kg');
-- Thêm Danh Mục CHA (Cấp 1)
INSERT INTO QLBanQuanAo.DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
                                                                 (100, N'Áo (Tất Cả)', N'Các loại áo mặc thân trên.', NULL),
(200, N'Quần & Váy (Tất Cả)', N'Các loại quần và váy.', NULL),

(300, N'Phụ Kiện (Tất Cả)', N'Các vật dụng đi kèm.', NULL);

-- Thêm Danh Mục CON (Cấp 2)
INSERT INTO QLBanQuanAo.DanhMuc (MaDM, TenDM, MoTa, MaDMCha) VALUES
(101, N'Áo Thun Cơ Bản', N'Áo phông cổ tròn, cổ tim, tối giản.', 100),
(102, N'Áo Sơ Mi', N'Sơ mi classic, linen, oxford.', 100),
(103, N'Áo Khoác', N'Hoodie, Sweater, Cardigan, Khoác Gió.', 100),
(201, N'Quần Dài', N'Jeans, Kaki, Jogger, Quần âu.', 200),
(202, N'Quần Ngắn', N'Short Kaki, Short Thun.', 200),
(203, N'Chân Váy', N'Chân váy chữ A, chân váy suông (dành cho Nữ).', 200),
(301, N'Túi & Ví', N'Ví da, túi tote, túi đeo chéo thiết kế trung tính.', 300),
(302, N'Mũ & Vớ', N'Các loại mũ, vớ cơ bản.', 300);

INSERT INTO QLBanQuanAo.SanPham (MaSP, MaDM, TenSP, MoTa, Gia, MauSac, Size, ChatLieu, SoLuongCon, HinhAnh, Season) VALUES
-- Áo (MaDM 101, 102, 103)
(1001, 101, N'Áo Thun Cotton Basic', N'Áo thun cổ tròn, form vừa, chất liệu thoáng mát, 100% Cotton.', 199000, N'Trắng, Đen, Xám', N'S, M, L, XL', N'Cotton 100%', 350, 'anh_quan_ao/ao/ao_thun_basic.png', 'Summer'),
(1002, 102, N'Sơ Mi Linen Cổ Điển', N'Sơ mi dài tay, chất liệu linen mát, phù hợp cho mùa hè.', 450000, N'Be, Xanh Navy', N'S, M, L', N'Linen Tự Nhiên', 120, 'anh_quan_ao/ao/so_mi_len_co_dien.jpg', NULL),
(1003, 101, N'Áo Polo Cotton Pique', N'Áo polo phom cơ bản, cổ dệt kim, chất liệu Pique thoáng khí.', 290000, N'Đen, Trắng, Xanh rêu', N'S, M, L, XL', N'Cotton Pique', 250, 'anh_quan_ao/ao/ao_polo_cotton_pique.jpg', 'Summer'),
(1004, 103, N'Áo Hoodie Nỉ Phom Rộng', N'Áo hoodie có mũ, phom rộng thoải mái, nỉ bông dày dặn.', 550000, N'Xám tro, Kem, Đen', N'M, L, XL', N'Nỉ Bông (Fleece)', 180, 'anh_quan_ao/ao/ao_hoodie_ni_phom_rong.jpg', 'Winter'),
(1005, 103, N'Áo Khoác Gió Hai Lớp', N'Áo khoác ngoài nhẹ, chống nước nhẹ, có khóa kéo và mũ.', 690000, N'Xanh Navy, Be, Xám', N'S, M, L, XL', N'Polyester', 100, 'anh_quan_ao/ao/ao_khoac_gio_hai_lop.jpg', 'Winter'),

-- Quần & Váy (MaDM 201, 202, 203)
(2001, 201, N'Quần Jeans Slim-fit', N'Quần jeans dáng đứng, tối giản, không rách.', 650000, N'Xanh Đậm, Đen', N'29, 30, 31, 32', N'Denim Co Giãn', 200, 'anh_quan_ao/quan/quan_jean_slim_fit.jpg', NULL),
(2002, 203, N'Chân Váy Chữ A Cơ Bản', N'Chân váy ngắn chữ A, dễ phối đồ, cạp cao.', 320000, N'Đen, Trắng Ngà', N'S, M, L', N'Vải Tuyết Mưa', 150, 'anh_quan_ao/quan/chan_vay_chu_A.jpg', NULL),
(2003, 201, N'Quần Jogger Thun Basic', N'Quần jogger bo gấu, lưng thun, có dây rút, thích hợp mặc nhà/tập luyện.', 350000, N'Đen, Xám Melange', N'S, M, L, XL', N'Cotton/Spandex', 160, 'anh_quan_ao/quan/quan_jogger_thun.jpg',NULL),
(2004, 202, N'Quần Short Kaki Phẳng', N'Quần short đứng dáng, độ dài trên gối, cạp phẳng.', 280000, N'Trắng ngà, Xanh mint', N'29, 30, 31, 32', N'Kaki', 140, 'anh_quan_ao/quan/quan_short_kaki.jpg',NULL),

-- Phụ Kiện (MaDM 301, 302)
(3001, 301, N'Ví Da Gấp Đôi Tối Giản', N'Ví da bò thật, thiết kế mỏng, chỉ có logo dập chìm.', 390000, N'Nâu Đậm, Đen', N'Free Size', N'Da Bò Thật', 80, 'anh_quan_ao/phu_kien/vi_gap_doi_toi_gian.jpg',NULL),
(3002, 302, N'Thắt Lưng Da Khóa Cổ Điển', N'Dây nịt da trơn, khóa kim loại đơn giản.', 480000, N'Đen, Nâu', N'Free Size', N'Da Tổng Hợp', 65, 'anh_quan_ao/phukien/that_lung_da.jpg',NULL),
(3003, 301, N'Túi Tote Vải Canvas Lớn', N'Túi vải canvas khổ lớn, quai đeo vai, in chữ tối giản.', 150000, N'Trắng, Đen', N'Free Size', N'Canvas dày', 300, 'anh_quan_ao/phu_kien/tui_tote_vai_canvas.jpg',NULL),
(3004, 302, N'Mũ Lưỡi Trai Cotton Trơn', N'Mũ lưỡi trai trơn, không logo, có thể điều chỉnh phía sau.', 120000, N'Đen, Trắng, Nâu', N'Free Size', N'Cotton', 220, 'anh_quan_ao/phu_kien/mu_luoi_trai.jpg',NULL),
(3005, 302, N'Vớ Cổ Cao Basic (Pack 3)', N'Bộ 3 đôi vớ cổ cao, chất liệu co giãn, thấm hút mồ hôi.', 99000, N'Trắng, Xám, Đen', N'Free Size', N'Cotton, Spandex', 500, 'anh_quan_ao/phu_kien/vo_cao_co_pack3.jpg',NULL);
