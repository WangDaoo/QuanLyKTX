CREATE DATABASE QL_KTX;
GO
USE QL_KTX;
GO

CREATE TABLE "AuditLogs" (
    "MaLog" INT NOT NULL CONSTRAINT "PK_AuditLogs" PRIMARY KEY IDENTITY(1,1),
    "UserId" NVARCHAR(255) NOT NULL,
    "Action" NVARCHAR(255) NOT NULL,
    "TableName" NVARCHAR(255) NOT NULL,
    "RecordId" NVARCHAR(255) NOT NULL,
    "OldValues" ntext NULL,
    "NewValues" ntext NULL,
    "Timestamp" NVARCHAR(255) NOT NULL,
    "IpAddress" NVARCHAR(255) NULL,
    "UserAgent" NVARCHAR(255) NULL
);
GO

GO

CREATE TABLE "NguoiDungs" (
    "MaNguoiDung" INT NOT NULL CONSTRAINT "PK_NguoiDungs" PRIMARY KEY IDENTITY(1,1),
    "HoTen" NVARCHAR(255) NOT NULL,
    "NgaySinh" NVARCHAR(255) NULL,
    "GioiTinh" NVARCHAR(255) NULL,
    "DiaChi" NVARCHAR(255) NULL,
    "Email" NVARCHAR(255) NULL,
    "DienThoai" NVARCHAR(255) NULL,
    "AnhDaiDien" NVARCHAR(255) NULL,
    "TrangThai" INT NULL,
    "VaiTro" NVARCHAR(255) NOT NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL
);
GO

INSERT INTO NguoiDungs (MaNguoiDung, HoTen, NgaySinh, GioiTinh, DiaChi, Email, DienThoai, AnhDaiDien, TrangThai, VaiTro, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, N'Nguyễn Văn Admin', NULL, NULL, NULL, N'admin@kytucxa.edu.vn', NULL, NULL, 1, N'Admin', 0, N'2025-09-05 10:23:26.2097902', N'System', NULL, NULL);
INSERT INTO NguoiDungs (MaNguoiDung, HoTen, NgaySinh, GioiTinh, DiaChi, Email, DienThoai, AnhDaiDien, TrangThai, VaiTro, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, N'Trần Thị Cán bộ', NULL, NULL, NULL, N'canbo@kytucxa.edu.vn', NULL, NULL, 1, N'Cán bộ KTX', 0, N'2025-09-05 10:23:26.2099286', N'System', NULL, NULL);
GO

CREATE TABLE "Notifications" (
    "MaThongBao" INT NOT NULL CONSTRAINT "PK_Notifications" PRIMARY KEY IDENTITY(1,1),
    "TieuDe" NVARCHAR(255) NOT NULL,
    "NoiDung" NVARCHAR(255) NOT NULL,
    "LoaiThongBao" NVARCHAR(255) NOT NULL,
    "NguoiNhan" NVARCHAR(255) NULL,
    "DaGui" INT NOT NULL,
    "NgayGui" NVARCHAR(255) NULL,
    "NgayTao" NVARCHAR(255) NOT NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "IsDeleted" INT NULL
);
GO

GO

CREATE TABLE "TienIchs" (
    "MaTienIch" INT NOT NULL CONSTRAINT "PK_TienIchs" PRIMARY KEY IDENTITY(1,1),
    "TenTienIch" NVARCHAR(255) NOT NULL,
    "DonVi" NVARCHAR(255) NOT NULL,
    "Gia" decimal(18,2) NOT NULL,
    "MoTa" NVARCHAR(255) NULL,
    "TrangThai" INT NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL
);
GO

INSERT INTO TienIchs (MaTienIch, TenTienIch, DonVi, Gia, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, N'Điện', N'kWh', 3000, N'Tiền điện theo chỉ số', 1, 0, N'2025-09-05 10:23:26.1248319', N'System', NULL, NULL);
INSERT INTO TienIchs (MaTienIch, TenTienIch, DonVi, Gia, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, N'Nước', N'm3', 15000, N'Tiền nước theo chỉ số', 1, 0, N'2025-09-05 10:23:26.1249513', N'System', NULL, NULL);
INSERT INTO TienIchs (MaTienIch, TenTienIch, DonVi, Gia, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (3, N'Internet', N'tháng', 100000, N'Phí internet hàng tháng', 1, 0, N'2025-09-05 10:23:26.1249525', N'System', NULL, NULL);
GO

CREATE TABLE "ToaNhas" (
    "MaToaNha" INT NOT NULL CONSTRAINT "PK_ToaNhas" PRIMARY KEY IDENTITY(1,1),
    "TenToaNha" NVARCHAR(255) NOT NULL,
    "DiaChi" NVARCHAR(255) NULL,
    "SoTang" INT NULL,
    "MoTa" NVARCHAR(255) NULL,
    "TrangThai" INT NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL
);
GO

INSERT INTO ToaNhas (MaToaNha, TenToaNha, DiaChi, SoTang, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, N'Tòa A', N'Khu A, Trường Đại học ABC', 5, N'Tòa nhà dành cho sinh viên nam', 1, 0, N'2025-09-05 10:23:25.4583536', N'System', NULL, NULL);
INSERT INTO ToaNhas (MaToaNha, TenToaNha, DiaChi, SoTang, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, N'Tòa B', N'Khu B, Trường Đại học ABC', 4, N'Tòa nhà dành cho sinh viên nữ', 1, 0, N'2025-09-05 10:23:25.4584098', N'System', NULL, NULL);
GO

CREATE TABLE "TaiKhoans" (
    "MaTaiKhoan" INT NOT NULL CONSTRAINT "PK_TaiKhoans" PRIMARY KEY IDENTITY(1,1),
    "MaNguoiDung" INT NOT NULL,
    "TenDangNhap" NVARCHAR(255) NOT NULL,
    "MatKhau" NVARCHAR(255) NOT NULL,
    "TrangThai" INT NULL,
    "NgayBatDau" NVARCHAR(255) NULL,
    "NgayKetThuc" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_TaiKhoans_NguoiDungs_MaNguoiDung" FOREIGN KEY ("MaNguoiDung") REFERENCES "NguoiDungs" ("MaNguoiDung") ON DELETE CASCADE
);
GO

INSERT INTO TaiKhoans (MaTaiKhoan, MaNguoiDung, TenDangNhap, MatKhau, TrangThai, NgayBatDau, NgayKetThuc, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, 1, N'admin', N'$2a$11$nMwSXlmvdvWgfkCqxgK0Tu8qmrJIQ5W4elIxUnluseUu4QgtfyhFy', 1, NULL, NULL, 0, N'2025-09-05 10:23:26.8796564', N'System', NULL, NULL);
INSERT INTO TaiKhoans (MaTaiKhoan, MaNguoiDung, TenDangNhap, MatKhau, TrangThai, NgayBatDau, NgayKetThuc, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, 2, N'canbo', N'$2a$11$JzpJwtN54Z8fA4AW9yTeCeJ/pyFD22igt7ZxtTKziNjpAnu1vAgAa', 1, NULL, NULL, 0, N'2025-09-05 10:23:27.240951', N'System', NULL, NULL);
GO

CREATE TABLE "Phongs" (
    "MaPhong" INT NOT NULL CONSTRAINT "PK_Phongs" PRIMARY KEY IDENTITY(1,1),
    "MaToaNha" INT NOT NULL,
    "SoPhong" NVARCHAR(255) NOT NULL,
    "SoGiuong" INT NOT NULL,
    "LoaiPhong" NVARCHAR(255) NOT NULL,
    "GiaPhong" decimal(18,2) NOT NULL,
    "MoTa" NVARCHAR(255) NULL,
    "TrangThai" NVARCHAR(255) NOT NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_Phongs_ToaNhas_MaToaNha" FOREIGN KEY ("MaToaNha") REFERENCES "ToaNhas" ("MaToaNha") ON DELETE RESTRICT
);
GO

INSERT INTO Phongs (MaPhong, MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, 1, N'A101', 4, N'4 người', 800000, NULL, N'Trống', 0, N'2025-09-05 10:23:25.9058943', N'System', NULL, NULL);
INSERT INTO Phongs (MaPhong, MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, 1, N'A102', 4, N'4 người', 800000, NULL, N'Trống', 0, N'2025-09-05 10:23:25.9059634', N'System', NULL, NULL);
INSERT INTO Phongs (MaPhong, MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (3, 1, N'A201', 4, N'4 người', 800000, NULL, N'Trống', 0, N'2025-09-05 10:23:25.9059641', N'System', NULL, NULL);
INSERT INTO Phongs (MaPhong, MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (4, 2, N'B101', 2, N'2 người', 1200000, NULL, N'Trống', 0, N'2025-09-05 10:23:25.9059646', N'System', NULL, NULL);
INSERT INTO Phongs (MaPhong, MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (5, 2, N'B102', 2, N'2 người', 1200000, NULL, N'Trống', 0, N'2025-09-05 10:23:25.905965', N'System', NULL, NULL);
GO

CREATE TABLE "ChiSoTienIchs" (
    "MaChiSo" INT NOT NULL CONSTRAINT "PK_ChiSoTienIchs" PRIMARY KEY IDENTITY(1,1),
    "MaPhong" INT NOT NULL,
    "MaTienIch" INT NOT NULL,
    "ChiSoCu" decimal(18,2) NOT NULL,
    "ChiSoMoi" decimal(18,2) NOT NULL,
    "SoLuongTieuThu" decimal(18,2) NOT NULL,
    "Thang" INT NOT NULL,
    "Nam" INT NOT NULL,
    "NgayGhi" NVARCHAR(255) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_ChiSoTienIchs_Phongs_MaPhong" FOREIGN KEY ("MaPhong") REFERENCES "Phongs" ("MaPhong") ON DELETE RESTRICT,
    CONSTRAINT "FK_ChiSoTienIchs_TienIchs_MaTienIch" FOREIGN KEY ("MaTienIch") REFERENCES "TienIchs" ("MaTienIch") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "Giuongs" (
    "MaGiuong" INT NOT NULL CONSTRAINT "PK_Giuongs" PRIMARY KEY IDENTITY(1,1),
    "MaPhong" INT NOT NULL,
    "SoGiuong" NVARCHAR(255) NOT NULL,
    "TrangThai" NVARCHAR(255) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_Giuongs_Phongs_MaPhong" FOREIGN KEY ("MaPhong") REFERENCES "Phongs" ("MaPhong") ON DELETE RESTRICT
);
GO

INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, 1, N'1', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0505128', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, 1, N'2', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506193', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (3, 1, N'3', N'Trống', NULL, 0, N'2025-09-05 10:23:26.05062', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (4, 1, N'4', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506202', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (5, 2, N'1', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506211', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (6, 2, N'2', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506223', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (7, 2, N'3', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506226', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (8, 2, N'4', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506229', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (9, 3, N'1', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506233', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (10, 3, N'2', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506238', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (11, 3, N'3', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506241', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (12, 3, N'4', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506244', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (13, 4, N'1', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506248', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (14, 4, N'2', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506252', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (15, 5, N'1', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506256', N'System', NULL, NULL);
INSERT INTO Giuongs (MaGiuong, MaPhong, SoGiuong, TrangThai, GhiChu, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (16, 5, N'2', N'Trống', NULL, 0, N'2025-09-05 10:23:26.0506259', N'System', NULL, NULL);
GO

CREATE TABLE "SinhViens" (
    "MaSinhVien" INT NOT NULL CONSTRAINT "PK_SinhViens" PRIMARY KEY IDENTITY(1,1),
    "HoTen" NVARCHAR(255) NOT NULL,
    "MSSV" NVARCHAR(255) NOT NULL,
    "Lop" NVARCHAR(255) NOT NULL,
    "Khoa" NVARCHAR(255) NOT NULL,
    "NgaySinh" NVARCHAR(255) NULL,
    "GioiTinh" NVARCHAR(255) NULL,
    "SDT" NVARCHAR(255) NULL,
    "Email" NVARCHAR(255) NULL,
    "DiaChi" NVARCHAR(255) NULL,
    "AnhDaiDien" NVARCHAR(255) NULL,
    "TrangThai" INT NULL,
    "MaPhong" INT NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_SinhViens_Phongs_MaPhong" FOREIGN KEY ("MaPhong") REFERENCES "Phongs" ("MaPhong")
);
GO

INSERT INTO SinhViens (MaSinhVien, HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, AnhDaiDien, TrangThai, MaPhong, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (1, N'Nguyễn Văn An', N'SV001', N'CNTT01', N'Công nghệ thông tin', N'2000-01-15 00:00:00', N'Nam', N'0123456789', N'an.nguyen@student.edu.vn', N'Hà Nội', NULL, 1, NULL, 0, N'2025-09-05 10:23:27.3377368', N'System', NULL, NULL);
INSERT INTO SinhViens (MaSinhVien, HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, AnhDaiDien, TrangThai, MaPhong, IsDeleted, NgayTao, NguoiTao, NgayCapNhat, NguoiCapNhat) VALUES (2, N'Trần Thị Bình', N'SV002', N'KT01', N'Kế toán', N'2000-03-20 00:00:00', N'Nữ', N'0987654321', N'binh.tran@student.edu.vn', N'TP.HCM', NULL, 1, NULL, 0, N'2025-09-05 10:23:27.3378186', N'System', NULL, NULL);
GO

CREATE TABLE "HopDongs" (
    "MaHopDong" INT NOT NULL CONSTRAINT "PK_HopDongs" PRIMARY KEY IDENTITY(1,1),
    "MaSinhVien" INT NOT NULL,
    "MaGiuong" INT NOT NULL,
    "NgayBatDau" NVARCHAR(255) NOT NULL,
    "NgayKetThuc" NVARCHAR(255) NOT NULL,
    "GiaPhong" decimal(18,2) NOT NULL,
    "TrangThai" NVARCHAR(255) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    "PhongMaPhong" INT NULL,
    CONSTRAINT "FK_HopDongs_Giuongs_MaGiuong" FOREIGN KEY ("MaGiuong") REFERENCES "Giuongs" ("MaGiuong") ON DELETE RESTRICT,
    CONSTRAINT "FK_HopDongs_Phongs_PhongMaPhong" FOREIGN KEY ("PhongMaPhong") REFERENCES "Phongs" ("MaPhong"),
    CONSTRAINT "FK_HopDongs_SinhViens_MaSinhVien" FOREIGN KEY ("MaSinhVien") REFERENCES "SinhViens" ("MaSinhVien") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "KyLuats" (
    "MaKyLuat" INT NOT NULL CONSTRAINT "PK_KyLuats" PRIMARY KEY IDENTITY(1,1),
    "MaSinhVien" INT NOT NULL,
    "DiemRenLuyen" INT NOT NULL,
    "HocKy" INT NOT NULL,
    "NamHoc" INT NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_KyLuats_SinhViens_MaSinhVien" FOREIGN KEY ("MaSinhVien") REFERENCES "SinhViens" ("MaSinhVien") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "ViPhams" (
    "MaViPham" INT NOT NULL CONSTRAINT "PK_ViPhams" PRIMARY KEY IDENTITY(1,1),
    "MaSinhVien" INT NOT NULL,
    "LoaiViPham" NVARCHAR(255) NOT NULL,
    "MoTa" NVARCHAR(255) NOT NULL,
    "NgayViPham" NVARCHAR(255) NOT NULL,
    "MucPhat" decimal(18,2) NOT NULL,
    "TrangThai" NVARCHAR(255) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "NguoiGhiNhan" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_ViPhams_SinhViens_MaSinhVien" FOREIGN KEY ("MaSinhVien") REFERENCES "SinhViens" ("MaSinhVien") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "HoaDons" (
    "MaHoaDon" INT NOT NULL CONSTRAINT "PK_HoaDons" PRIMARY KEY IDENTITY(1,1),
    "MaSinhVien" INT NOT NULL,
    "MaPhong" INT NULL,
    "MaHopDong" INT NULL,
    "Thang" INT NOT NULL,
    "Nam" INT NOT NULL,
    "TongTien" decimal(18,2) NOT NULL,
    "TrangThai" NVARCHAR(255) NOT NULL,
    "NgayHetHan" NVARCHAR(255) NOT NULL,
    "NgayThanhToan" NVARCHAR(255) NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_HoaDons_HopDongs_MaHopDong" FOREIGN KEY ("MaHopDong") REFERENCES "HopDongs" ("MaHopDong") ON DELETE SET NULL,
    CONSTRAINT "FK_HoaDons_SinhViens_MaSinhVien" FOREIGN KEY ("MaSinhVien") REFERENCES "SinhViens" ("MaSinhVien") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "BienLais" (
    "MaBienLai" INT NOT NULL CONSTRAINT "PK_BienLais" PRIMARY KEY IDENTITY(1,1),
    "MaHoaDon" INT NOT NULL,
    "SoTien" decimal(18,2) NOT NULL,
    "NgayThanhToan" NVARCHAR(255) NOT NULL,
    "PhuongThuc" NVARCHAR(255) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    "NguoiThu" NVARCHAR(255) NULL,
    "IsDeleted" INT NOT NULL,
    "NgayTao" NVARCHAR(255) NULL,
    "NguoiTao" NVARCHAR(255) NULL,
    "NgayCapNhat" NVARCHAR(255) NULL,
    "NguoiCapNhat" NVARCHAR(255) NULL,
    CONSTRAINT "FK_BienLais_HoaDons_MaHoaDon" FOREIGN KEY ("MaHoaDon") REFERENCES "HoaDons" ("MaHoaDon") ON DELETE RESTRICT
);
GO

GO

CREATE TABLE "ChiTietHoaDons" (
    "MaChiTiet" INT NOT NULL CONSTRAINT "PK_ChiTietHoaDons" PRIMARY KEY IDENTITY(1,1),
    "MaHoaDon" INT NOT NULL,
    "MaTienIch" INT NOT NULL,
    "SoLuong" decimal(18,2) NOT NULL,
    "DonGia" decimal(18,2) NOT NULL,
    "ThanhTien" decimal(18,2) NOT NULL,
    "GhiChu" NVARCHAR(255) NULL,
    CONSTRAINT "FK_ChiTietHoaDons_HoaDons_MaHoaDon" FOREIGN KEY ("MaHoaDon") REFERENCES "HoaDons" ("MaHoaDon") ON DELETE CASCADE,
    CONSTRAINT "FK_ChiTietHoaDons_TienIchs_MaTienIch" FOREIGN KEY ("MaTienIch") REFERENCES "TienIchs" ("MaTienIch") ON DELETE RESTRICT
);
GO

GO

