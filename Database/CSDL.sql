-- =============================================
-- Script Name: CSDL.sql
-- Description: Database hoàn chỉnh cho hệ thống Quản Lý Ký Túc Xá
-- Author: KTX System
-- Created: 2024
-- =============================================

USE master;
GO

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QuanLyKyTucXa')
BEGIN
    CREATE DATABASE QuanLyKyTucXa;
END
GO

USE QuanLyKyTucXa;
GO

-- =============================================
-- TẠO BẢNG
-- =============================================

-- Bảng ToaNha
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ToaNha' AND xtype='U')
BEGIN
    CREATE TABLE ToaNha (
        MaToaNha INT IDENTITY(1,1) PRIMARY KEY,
        TenToaNha NVARCHAR(200) NOT NULL,
        DiaChi NVARCHAR(500),
        SoTang INT,
        MoTa NVARCHAR(1000),
        TrangThai BIT DEFAULT 1,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100)
    );
END
GO

-- Bảng Phong
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Phong' AND xtype='U')
BEGIN
    CREATE TABLE Phong (
        MaPhong INT IDENTITY(1,1) PRIMARY KEY,
        MaToaNha INT NOT NULL,
        SoPhong NVARCHAR(20) NOT NULL,
        SoGiuong INT NOT NULL,
        LoaiPhong NVARCHAR(50) NOT NULL,
        GiaPhong DECIMAL(18,2) NOT NULL,
        MoTa NVARCHAR(500),
        TrangThai NVARCHAR(50) DEFAULT 'Trống',
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaToaNha) REFERENCES ToaNha(MaToaNha)
    );
END
GO

-- Bảng Giuong
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Giuong' AND xtype='U')
BEGIN
    CREATE TABLE Giuong (
        MaGiuong INT IDENTITY(1,1) PRIMARY KEY,
        MaPhong INT NOT NULL,
        SoGiuong NVARCHAR(10) NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Trống',
        MoTa NVARCHAR(500),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng SinhVien
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SinhVien' AND xtype='U')
BEGIN
    CREATE TABLE SinhVien (
        MaSinhVien INT IDENTITY(1,1) PRIMARY KEY,
        HoTen NVARCHAR(200) NOT NULL,
        MSSV NVARCHAR(20) NOT NULL UNIQUE,
        Lop NVARCHAR(50) NOT NULL,
        Khoa NVARCHAR(100) NOT NULL,
        NgaySinh DATETIME,
        GioiTinh NVARCHAR(10),
        SDT NVARCHAR(15),
        Email NVARCHAR(100),
        DiaChi NVARCHAR(500),
        AnhDaiDien NVARCHAR(500),
        TrangThai BIT DEFAULT 1,
        MaPhong INT,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng TaiKhoan
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TaiKhoan' AND xtype='U')
BEGIN
    CREATE TABLE TaiKhoan (
        MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
        TenDangNhap NVARCHAR(50) NOT NULL UNIQUE,
        MatKhau NVARCHAR(255) NOT NULL,
        HoTen NVARCHAR(200) NOT NULL,
        Email NVARCHAR(100),
        VaiTro NVARCHAR(20) DEFAULT 'User',
        TrangThai BIT DEFAULT 1,
        MaSinhVien INT,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        SoLanDangNhapSai INT DEFAULT 0,
        NgayKhoa DATETIME,
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien)
    );
END
GO

-- Bảng MucPhi
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MucPhi' AND xtype='U')
BEGIN
    CREATE TABLE MucPhi (
        MaMucPhi INT IDENTITY(1,1) PRIMARY KEY,
        TenMucPhi NVARCHAR(200) NOT NULL,
        LoaiPhi NVARCHAR(100) NOT NULL,
        GiaTien DECIMAL(18,2) NOT NULL,
        DonVi NVARCHAR(50),
        TrangThai BIT DEFAULT 1,
        GhiChu NVARCHAR(500),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100)
    );
END
GO

-- Bảng BacGia
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BacGia' AND xtype='U')
BEGIN
    CREATE TABLE BacGia (
        MaBac INT IDENTITY(1,1) PRIMARY KEY,
        Loai NVARCHAR(50) NOT NULL,
        ThuTu INT NOT NULL,
        TuSo INT,
        DenSo INT,
        DonGia DECIMAL(18,2) NOT NULL,
        TrangThai BIT DEFAULT 1,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100)
    );
END
GO

-- Bảng HopDong
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HopDong' AND xtype='U')
BEGIN
    CREATE TABLE HopDong (
        MaHopDong INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        MaGiuong INT NOT NULL,
        NgayBatDau DATE NOT NULL,
        NgayKetThuc DATE NOT NULL,
        GiaPhong DECIMAL(18,2) NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Chờ duyệt',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (MaGiuong) REFERENCES Giuong(MaGiuong)
    );
END
GO

-- Bảng HoaDon
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HoaDon' AND xtype='U')
BEGIN
    CREATE TABLE HoaDon (
        MaHoaDon INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT,
        MaPhong INT,
        MaHopDong INT,
        Thang INT NOT NULL,
        Nam INT NOT NULL,
        TongTien DECIMAL(18,2) NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Chưa thanh toán',
        HanThanhToan DATE,
        NgayThanhToan DATE,
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong),
        FOREIGN KEY (MaHopDong) REFERENCES HopDong(MaHopDong)
    );
END
GO

-- Bảng BienLaiThu
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BienLaiThu' AND xtype='U')
BEGIN
    CREATE TABLE BienLaiThu (
        MaBienLai INT IDENTITY(1,1) PRIMARY KEY,
        MaHoaDon INT NOT NULL,
        SoTienThu DECIMAL(18,2) NOT NULL,
        NgayThu DATE NOT NULL,
        PhuongThucThanhToan NVARCHAR(100) NOT NULL,
        NguoiThu NVARCHAR(100),
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon)
    );
END
GO

-- Bảng KyLuat
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='KyLuat' AND xtype='U')
BEGIN
    CREATE TABLE KyLuat (
        MaKyLuat INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        LoaiViPham NVARCHAR(100) NOT NULL,
        MoTa NVARCHAR(1000) NOT NULL,
        NgayViPham DATE NOT NULL,
        MucPhat DECIMAL(18,2) DEFAULT 0,
        TrangThai NVARCHAR(50) DEFAULT 'Chưa xử lý',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien)
    );
END
GO

-- Bảng DiemRenLuyen
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DiemRenLuyen' AND xtype='U')
BEGIN
    CREATE TABLE DiemRenLuyen (
        MaDiem INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        Thang INT NOT NULL,
        Nam INT NOT NULL,
        DiemSo DECIMAL(5,2) NOT NULL,
        XepLoai NVARCHAR(50) NOT NULL,
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien)
    );
END
GO

-- Bảng DonDangKy
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DonDangKy' AND xtype='U')
BEGIN
    CREATE TABLE DonDangKy (
        MaDon INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        MaPhongDeXuat INT,
        LyDo NVARCHAR(1000),
        NgayDangKy DATE NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Chờ duyệt',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (MaPhongDeXuat) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng YeuCauChuyenPhong
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='YeuCauChuyenPhong' AND xtype='U')
BEGIN
    CREATE TABLE YeuCauChuyenPhong (
        MaYeuCau INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        PhongHienTai INT NOT NULL,
        PhongMongMuon INT,
        LyDo NVARCHAR(1000) NOT NULL,
        NgayYeuCau DATE NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Chờ duyệt',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (PhongHienTai) REFERENCES Phong(MaPhong),
        FOREIGN KEY (PhongMongMuon) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng ChiSoDienNuoc
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ChiSoDienNuoc' AND xtype='U')
BEGIN
    CREATE TABLE ChiSoDienNuoc (
        MaChiSo INT IDENTITY(1,1) PRIMARY KEY,
        MaPhong INT NOT NULL,
        Thang INT NOT NULL,
        Nam INT NOT NULL,
        ChiSoDien INT NOT NULL,
        ChiSoNuoc INT NOT NULL,
        NguoiGhi NVARCHAR(100),
        TrangThai NVARCHAR(50) DEFAULT 'Đã ghi',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng ChiTietHoaDon
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ChiTietHoaDon' AND xtype='U')
BEGIN
    CREATE TABLE ChiTietHoaDon (
        MaChiTiet INT IDENTITY(1,1) PRIMARY KEY,
        MaHoaDon INT NOT NULL,
        LoaiChiPhi NVARCHAR(100) NOT NULL,
        SoLuong INT NOT NULL,
        DonGia DECIMAL(18,2) NOT NULL,
        ThanhTien DECIMAL(18,2) NOT NULL,
        GhiChu NVARCHAR(500),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon)
    );
END
GO

-- Bảng DichVu
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DichVu' AND xtype='U')
BEGIN
    CREATE TABLE DichVu (
        MaDichVu INT IDENTITY(1,1) PRIMARY KEY,
        TenDichVu NVARCHAR(200) NOT NULL,
        MoTa NVARCHAR(1000),
        GiaTien DECIMAL(18,2) DEFAULT 0,
        DonViTinh NVARCHAR(50),
        TrangThai BIT DEFAULT 1,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100)
    );
END
GO

-- Bảng DangKyDichVu
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DangKyDichVu' AND xtype='U')
BEGIN
    CREATE TABLE DangKyDichVu (
        MaDangKy INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        MaDichVu INT NOT NULL,
        NgayDangKy DATE NOT NULL,
        NgayBatDau DATE NOT NULL,
        NgayKetThuc DATE,
        TrangThai NVARCHAR(50) DEFAULT 'Hoạt động',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu)
    );
END
GO

-- Bảng ThietBi
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ThietBi' AND xtype='U')
BEGIN
    CREATE TABLE ThietBi (
        MaThietBi INT IDENTITY(1,1) PRIMARY KEY,
        MaPhong INT NOT NULL,
        TenThietBi NVARCHAR(200) NOT NULL,
        LoaiThietBi NVARCHAR(100),
        GiaTri DECIMAL(18,2) DEFAULT 0,
        TrangThai NVARCHAR(50) DEFAULT 'Hoạt động',
        NgayMua DATE,
        NgayBaoHanh DATE,
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
    );
END
GO

-- Bảng BaoTri
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BaoTri' AND xtype='U')
BEGIN
    CREATE TABLE BaoTri (
        MaBaoTri INT IDENTITY(1,1) PRIMARY KEY,
        MaThietBi INT NOT NULL,
        NgayBaoTri DATE NOT NULL,
        LoaiBaoTri NVARCHAR(100) NOT NULL,
        ChiPhi DECIMAL(18,2) DEFAULT 0,
        MoTa NVARCHAR(1000),
        TrangThai NVARCHAR(50) DEFAULT 'Hoàn thành',
        NguoiThucHien NVARCHAR(100),
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaThietBi) REFERENCES ThietBi(MaThietBi)
    );
END
GO

-- Bảng ThongBaoQuaHan
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ThongBaoQuaHan' AND xtype='U')
BEGIN
    CREATE TABLE ThongBaoQuaHan (
        MaThongBao INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        MaHoaDon INT NOT NULL,
        NgayThongBao DATE NOT NULL,
        NoiDung NVARCHAR(1000) NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Đã gửi',
        GhiChu NVARCHAR(1000),
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100),
        FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien),
        FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon)
    );
END
GO

-- =============================================
-- CONSTRAINTS
-- =============================================

-- Constraints cho ChiSoDienNuoc
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_ChiSoDienNuoc_Positive')
BEGIN
    ALTER TABLE ChiSoDienNuoc ADD CONSTRAINT CK_ChiSoDienNuoc_Positive 
        CHECK (ChiSoDien >= 0 AND ChiSoNuoc >= 0);
END
GO

-- Constraints cho HopDong
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_HopDong_DateRange')
BEGIN
    ALTER TABLE HopDong ADD CONSTRAINT CK_HopDong_DateRange 
        CHECK (NgayKetThuc > NgayBatDau);
END
GO

-- Constraints cho HoaDon
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_HoaDon_MonthYear')
BEGIN
    ALTER TABLE HoaDon ADD CONSTRAINT CK_HoaDon_MonthYear 
        CHECK (Thang >= 1 AND Thang <= 12 AND Nam >= 2020);
END
GO

-- =============================================
-- INDEXES
-- =============================================

-- Indexes cho performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_SinhVien_MSSV' AND object_id = OBJECT_ID('SinhVien'))
    CREATE INDEX IX_SinhVien_MSSV ON SinhVien(MSSV);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_TaiKhoan_TenDangNhap' AND object_id = OBJECT_ID('TaiKhoan'))
    CREATE INDEX IX_TaiKhoan_TenDangNhap ON TaiKhoan(TenDangNhap);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Phong_ToaNha' AND object_id = OBJECT_ID('Phong'))
    CREATE INDEX IX_Phong_ToaNha ON Phong(MaToaNha);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Giuong_Phong' AND object_id = OBJECT_ID('Giuong'))
    CREATE INDEX IX_Giuong_Phong ON Giuong(MaPhong);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HopDong_SinhVien' AND object_id = OBJECT_ID('HopDong'))
    CREATE INDEX IX_HopDong_SinhVien ON HopDong(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HopDong_Giuong' AND object_id = OBJECT_ID('HopDong'))
    CREATE INDEX IX_HopDong_Giuong ON HopDong(MaGiuong);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HoaDon_SinhVien' AND object_id = OBJECT_ID('HoaDon'))
    CREATE INDEX IX_HoaDon_SinhVien ON HoaDon(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_HoaDon_ThangNam' AND object_id = OBJECT_ID('HoaDon'))
    CREATE INDEX IX_HoaDon_ThangNam ON HoaDon(Thang, Nam);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BienLaiThu_HoaDon' AND object_id = OBJECT_ID('BienLaiThu'))
    CREATE INDEX IX_BienLaiThu_HoaDon ON BienLaiThu(MaHoaDon);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_KyLuat_SinhVien' AND object_id = OBJECT_ID('KyLuat'))
    CREATE INDEX IX_KyLuat_SinhVien ON KyLuat(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DonDangKy_SinhVien' AND object_id = OBJECT_ID('DonDangKy'))
    CREATE INDEX IX_DonDangKy_SinhVien ON DonDangKy(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_YeuCauChuyenPhong_SinhVien' AND object_id = OBJECT_ID('YeuCauChuyenPhong'))
    CREATE INDEX IX_YeuCauChuyenPhong_SinhVien ON YeuCauChuyenPhong(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ChiSoDienNuoc_Phong' AND object_id = OBJECT_ID('ChiSoDienNuoc'))
    CREATE INDEX IX_ChiSoDienNuoc_Phong ON ChiSoDienNuoc(MaPhong);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ChiSoDienNuoc_ThangNam' AND object_id = OBJECT_ID('ChiSoDienNuoc'))
    CREATE INDEX IX_ChiSoDienNuoc_ThangNam ON ChiSoDienNuoc(Thang, Nam);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DiemRenLuyen_SinhVien' AND object_id = OBJECT_ID('DiemRenLuyen'))
    CREATE INDEX IX_DiemRenLuyen_SinhVien ON DiemRenLuyen(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DiemRenLuyen_ThangNam' AND object_id = OBJECT_ID('DiemRenLuyen'))
    CREATE INDEX IX_DiemRenLuyen_ThangNam ON DiemRenLuyen(Thang, Nam);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ChiTietHoaDon_HoaDon' AND object_id = OBJECT_ID('ChiTietHoaDon'))
    CREATE INDEX IX_ChiTietHoaDon_HoaDon ON ChiTietHoaDon(MaHoaDon);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DangKyDichVu_SinhVien' AND object_id = OBJECT_ID('DangKyDichVu'))
    CREATE INDEX IX_DangKyDichVu_SinhVien ON DangKyDichVu(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ThietBi_Phong' AND object_id = OBJECT_ID('ThietBi'))
    CREATE INDEX IX_ThietBi_Phong ON ThietBi(MaPhong);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BaoTri_ThietBi' AND object_id = OBJECT_ID('BaoTri'))
    CREATE INDEX IX_BaoTri_ThietBi ON BaoTri(MaThietBi);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ThongBaoQuaHan_SinhVien' AND object_id = OBJECT_ID('ThongBaoQuaHan'))
    CREATE INDEX IX_ThongBaoQuaHan_SinhVien ON ThongBaoQuaHan(MaSinhVien);
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ThongBaoQuaHan_HoaDon' AND object_id = OBJECT_ID('ThongBaoQuaHan'))
    CREATE INDEX IX_ThongBaoQuaHan_HoaDon ON ThongBaoQuaHan(MaHoaDon);
GO

-- =============================================
-- SEED DATA
-- =============================================

-- Seed data cho ToaNha
IF NOT EXISTS (SELECT 1 FROM ToaNha)
BEGIN
    INSERT INTO ToaNha (TenToaNha, DiaChi, SoTang, MoTa, TrangThai, NguoiTao) VALUES
    ('Tòa A', '123 Đường ABC, Quận 1, TP.HCM', 5, 'Tòa nam', 1, 'System'),
    ('Tòa B', '456 Đường XYZ, Quận 2, TP.HCM', 4, 'Tòa nữ', 1, 'System');
END
GO

-- Seed data cho Phong
IF NOT EXISTS (SELECT 1 FROM Phong)
BEGIN
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, TrangThai, NguoiTao) VALUES
    (1, 'A101', 4, 'Phòng 4 người', 500000, 'Trống', 'System'),
    (1, 'A102', 4, 'Phòng 4 người', 500000, 'Trống', 'System'),
    (1, 'A103', 2, 'Phòng 2 người', 300000, 'Trống', 'System'),
    (2, 'B101', 4, 'Phòng 4 người', 500000, 'Trống', 'System'),
    (2, 'B102', 4, 'Phòng 4 người', 500000, 'Trống', 'System');
END
GO

-- Seed data cho Giuong
IF NOT EXISTS (SELECT 1 FROM Giuong)
BEGIN
    INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, NguoiTao) VALUES
    (1, '1', 'Trống', 'System'),
    (1, '2', 'Trống', 'System'),
    (1, '3', 'Trống', 'System'),
    (1, '4', 'Trống', 'System'),
    (2, '1', 'Trống', 'System'),
    (2, '2', 'Trống', 'System'),
    (2, '3', 'Trống', 'System'),
    (2, '4', 'Trống', 'System'),
    (3, '1', 'Trống', 'System'),
    (3, '2', 'Trống', 'System'),
    (4, '1', 'Trống', 'System'),
    (4, '2', 'Trống', 'System'),
    (4, '3', 'Trống', 'System'),
    (4, '4', 'Trống', 'System'),
    (5, '1', 'Trống', 'System'),
    (5, '2', 'Trống', 'System'),
    (5, '3', 'Trống', 'System'),
    (5, '4', 'Trống', 'System');
END
GO

-- Seed data cho SinhVien
IF NOT EXISTS (SELECT 1 FROM SinhVien)
BEGIN
    INSERT INTO SinhVien (HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, TrangThai, NguoiTao) VALUES
    ('Nguyễn Văn A', 'SV001', 'CNTT01', 'Công nghệ thông tin', '2000-01-01', 'Nam', '0123456789', 'nguyenvana@email.com', '123 Đường ABC', 1, 'System'),
    ('Trần Thị B', 'SV002', 'CNTT02', 'Công nghệ thông tin', '2000-02-02', 'Nữ', '0987654321', 'tranthib@email.com', '456 Đường XYZ', 1, 'System'),
    ('Lê Văn C', 'SV003', 'KT01', 'Kế toán', '2000-03-03', 'Nam', '0369258147', 'levanc@email.com', '789 Đường DEF', 1, 'System');
END
GO

-- Seed data cho TaiKhoan (với BCrypt hash)
IF NOT EXISTS (SELECT 1 FROM TaiKhoan)
BEGIN
    INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, Email, VaiTro, TrangThai, MaSinhVien, NguoiTao) VALUES
    ('admin', '$2a$11$rQZ8K9mN2pL3sT4uV5wX6yZ7aB8cD9eF0gH1iJ2kL3mN4oP5qR6sT7uV8wX9yZ', 'Administrator', 'admin@ktx.edu.vn', 'Admin', 1, NULL, 'System'),
    ('officer', '$2a$11$rQZ8K9mN2pL3sT4uV5wX6yZ7aB8cD9eF0gH1iJ2kL3mN4oP5qR6sT7uV8wX9yZ', 'Officer', 'officer@ktx.edu.vn', 'Officer', 1, NULL, 'System'),
    ('student', '$2a$11$rQZ8K9mN2pL3sT4uV5wX6yZ7aB8cD9eF0gH1iJ2kL3mN4oP5qR6sT7uV8wX9yZ', 'Student', 'student@ktx.edu.vn', 'Student', 1, 1, 'System');
END
GO

-- Seed data cho MucPhi
IF NOT EXISTS (SELECT 1 FROM MucPhi)
BEGIN
    INSERT INTO MucPhi (TenMucPhi, LoaiPhi, GiaTien, DonVi, TrangThai, GhiChu, NguoiTao) VALUES
    ('Phí phòng 4 người', 'Phí phòng', 500000, 'VND/tháng', 1, 'Phí cơ bản', 'System'),
    ('Phí phòng 2 người', 'Phí phòng', 300000, 'VND/tháng', 1, 'Phí cơ bản', 'System'),
    ('Phí điện', 'Phí điện', 3500, 'VND/kWh', 1, 'Theo bậc thang', 'System'),
    ('Phí nước', 'Phí nước', 15000, 'VND/m3', 1, 'Theo bậc thang', 'System'),
    ('Phí dịch vụ', 'Dịch vụ', 50000, 'VND/tháng', 1, 'Phí dịch vụ chung', 'System');
END
GO

-- Seed data cho BacGia
IF NOT EXISTS (SELECT 1 FROM BacGia)
BEGIN
    INSERT INTO BacGia (Loai, ThuTu, TuSo, DenSo, DonGia, TrangThai, NguoiTao) VALUES
    ('Điện', 1, 0, 50, 1800, 1, 'System'),
    ('Điện', 2, 51, 100, 2000, 1, 'System'),
    ('Điện', 3, 101, 200, 2500, 1, 'System'),
    ('Điện', 4, 201, 300, 3000, 1, 'System'),
    ('Điện', 5, 301, 999999, 3500, 1, 'System'),
    ('Nước', 1, 0, 10, 10000, 1, 'System'),
    ('Nước', 2, 11, 20, 12000, 1, 'System'),
    ('Nước', 3, 21, 30, 15000, 1, 'System'),
    ('Nước', 4, 31, 999999, 20000, 1, 'System');
END
GO

-- =============================================
-- STORED PROCEDURES - TOA NHA CRUD
-- =============================================

-- sp_ToaNha_GetAll
CREATE OR ALTER PROCEDURE sp_ToaNha_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaToaNha,
        TenToaNha,
        DiaChi,
        SoTang,
        MoTa,
        TrangThai,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM ToaNha
    WHERE IsDeleted = 0
    ORDER BY TenToaNha;
END;
GO

-- sp_ToaNha_GetById
CREATE OR ALTER PROCEDURE sp_ToaNha_GetById
    @MaToaNha INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaToaNha,
        TenToaNha,
        DiaChi,
        SoTang,
        MoTa,
        TrangThai,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM ToaNha
    WHERE MaToaNha = @MaToaNha AND IsDeleted = 0;
END;
GO

-- sp_ToaNha_Create
CREATE OR ALTER PROCEDURE sp_ToaNha_Create
    @TenToaNha NVARCHAR(200),
    @DiaChi NVARCHAR(500) = NULL,
    @SoTang INT = NULL,
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai BIT = 1,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ToaNha (TenToaNha, DiaChi, SoTang, MoTa, TrangThai, NguoiTao)
    VALUES (@TenToaNha, @DiaChi, @SoTang, @MoTa, @TrangThai, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaToaNha;
END;
GO

-- sp_ToaNha_Update
CREATE OR ALTER PROCEDURE sp_ToaNha_Update
    @MaToaNha INT,
    @TenToaNha NVARCHAR(200),
    @DiaChi NVARCHAR(500) = NULL,
    @SoTang INT = NULL,
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai BIT = 1,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ToaNha 
    SET TenToaNha = @TenToaNha,
        DiaChi = @DiaChi,
        SoTang = @SoTang,
        MoTa = @MoTa,
        TrangThai = @TrangThai,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaToaNha = @MaToaNha AND IsDeleted = 0;
END;
GO

-- sp_ToaNha_Delete
CREATE OR ALTER PROCEDURE sp_ToaNha_Delete
    @MaToaNha INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ToaNha 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaToaNha = @MaToaNha AND IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - PHONG CRUD
-- =============================================

-- sp_Phong_GetAll
CREATE OR ALTER PROCEDURE sp_Phong_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.MaPhong,
        p.MaToaNha,
        p.SoPhong,
        p.SoGiuong,
        p.LoaiPhong,
        p.GiaPhong,
        p.MoTa,
        p.TrangThai,
        p.IsDeleted,
        p.NgayTao,
        p.NguoiTao,
        p.NgayCapNhat,
        p.NguoiCapNhat,
        t.TenToaNha
    FROM Phong p
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE p.IsDeleted = 0
    ORDER BY t.TenToaNha, p.SoPhong;
END;
GO

-- sp_Phong_GetById
CREATE OR ALTER PROCEDURE sp_Phong_GetById
    @MaPhong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.MaPhong,
        p.MaToaNha,
        p.SoPhong,
        p.SoGiuong,
        p.LoaiPhong,
        p.GiaPhong,
        p.MoTa,
        p.TrangThai,
        p.IsDeleted,
        p.NgayTao,
        p.NguoiTao,
        p.NgayCapNhat,
        p.NguoiCapNhat,
        t.TenToaNha
    FROM Phong p
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE p.MaPhong = @MaPhong AND p.IsDeleted = 0;
END;
GO

-- sp_Phong_Create
CREATE OR ALTER PROCEDURE sp_Phong_Create
    @MaToaNha INT,
    @SoPhong NVARCHAR(20),
    @SoGiuong INT,
    @LoaiPhong NVARCHAR(50),
    @GiaPhong DECIMAL(18,2),
    @MoTa NVARCHAR(500) = NULL,
    @TrangThai NVARCHAR(50) = 'Trống',
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, NguoiTao)
    VALUES (@MaToaNha, @SoPhong, @SoGiuong, @LoaiPhong, @GiaPhong, @MoTa, @TrangThai, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaPhong;
END;
GO

-- sp_Phong_Update
CREATE OR ALTER PROCEDURE sp_Phong_Update
    @MaPhong INT,
    @MaToaNha INT,
    @SoPhong NVARCHAR(20),
    @SoGiuong INT,
    @LoaiPhong NVARCHAR(50),
    @GiaPhong DECIMAL(18,2),
    @MoTa NVARCHAR(500) = NULL,
    @TrangThai NVARCHAR(50) = 'Trống',
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Phong 
    SET MaToaNha = @MaToaNha,
        SoPhong = @SoPhong,
        SoGiuong = @SoGiuong,
        LoaiPhong = @LoaiPhong,
        GiaPhong = @GiaPhong,
        MoTa = @MoTa,
        TrangThai = @TrangThai,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaPhong = @MaPhong AND IsDeleted = 0;
END;
GO

-- sp_Phong_Delete
CREATE OR ALTER PROCEDURE sp_Phong_Delete
    @MaPhong INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Phong 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaPhong = @MaPhong AND IsDeleted = 0;
END;
GO

-- sp_Phong_GetAvailable
CREATE OR ALTER PROCEDURE sp_Phong_GetAvailable
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.MaPhong,
        p.MaToaNha,
        p.SoPhong,
        p.SoGiuong,
        p.LoaiPhong,
        p.GiaPhong,
        p.MoTa,
        p.TrangThai,
        t.TenToaNha
    FROM Phong p
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE p.IsDeleted = 0 AND p.TrangThai = 'Trống'
    ORDER BY t.TenToaNha, p.SoPhong;
END;
GO

-- sp_Phong_GetCurrentBySinhVien
CREATE OR ALTER PROCEDURE sp_Phong_GetCurrentBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.MaPhong,
        p.MaToaNha,
        p.SoPhong,
        p.SoGiuong,
        p.LoaiPhong,
        p.GiaPhong,
        p.MoTa,
        p.TrangThai,
        t.TenToaNha
    FROM Phong p
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    INNER JOIN SinhVien s ON p.MaPhong = s.MaPhong AND s.IsDeleted = 0
    WHERE s.MaSinhVien = @MaSinhVien AND p.IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - GIUONG CRUD
-- =============================================

-- sp_Giuong_GetAll
CREATE OR ALTER PROCEDURE sp_Giuong_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        g.MaGiuong,
        g.MaPhong,
        g.SoGiuong,
        g.TrangThai,
        g.MoTa,
        g.IsDeleted,
        g.NgayTao,
        g.NguoiTao,
        g.NgayCapNhat,
        g.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM Giuong g
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE g.IsDeleted = 0
    ORDER BY t.TenToaNha, p.SoPhong, g.SoGiuong;
END;
GO

-- sp_Giuong_GetById
CREATE OR ALTER PROCEDURE sp_Giuong_GetById
    @MaGiuong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        g.MaGiuong,
        g.MaPhong,
        g.SoGiuong,
        g.TrangThai,
        g.MoTa,
        g.IsDeleted,
        g.NgayTao,
        g.NguoiTao,
        g.NgayCapNhat,
        g.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM Giuong g
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE g.MaGiuong = @MaGiuong AND g.IsDeleted = 0;
END;
GO

-- sp_Giuong_Create
CREATE OR ALTER PROCEDURE sp_Giuong_Create
    @MaPhong INT,
    @SoGiuong NVARCHAR(10),
    @TrangThai NVARCHAR(50) = 'Trống',
    @MoTa NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, MoTa, NguoiTao)
    VALUES (@MaPhong, @SoGiuong, @TrangThai, @MoTa, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaGiuong;
END;
GO

-- sp_Giuong_Update
CREATE OR ALTER PROCEDURE sp_Giuong_Update
    @MaGiuong INT,
    @MaPhong INT,
    @SoGiuong NVARCHAR(10),
    @TrangThai NVARCHAR(50) = 'Trống',
    @MoTa NVARCHAR(500) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Giuong 
    SET MaPhong = @MaPhong,
        SoGiuong = @SoGiuong,
        TrangThai = @TrangThai,
        MoTa = @MoTa,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaGiuong = @MaGiuong AND IsDeleted = 0;
END;
GO

-- sp_Giuong_Delete
CREATE OR ALTER PROCEDURE sp_Giuong_Delete
    @MaGiuong INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Giuong 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaGiuong = @MaGiuong AND IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - SINH VIEN CRUD
-- =============================================

-- sp_SinhVien_GetAll
CREATE OR ALTER PROCEDURE sp_SinhVien_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        s.NgaySinh,
        s.GioiTinh,
        s.SDT,
        s.Email,
        s.DiaChi,
        s.AnhDaiDien,
        s.TrangThai,
        s.MaPhong,
        s.IsDeleted,
        s.NgayTao,
        s.NguoiTao,
        s.NgayCapNhat,
        s.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM SinhVien s
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE s.IsDeleted = 0
    ORDER BY s.HoTen;
END;
GO

-- sp_SinhVien_GetById
CREATE OR ALTER PROCEDURE sp_SinhVien_GetById
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        s.NgaySinh,
        s.GioiTinh,
        s.SDT,
        s.Email,
        s.DiaChi,
        s.AnhDaiDien,
        s.TrangThai,
        s.MaPhong,
        s.IsDeleted,
        s.NgayTao,
        s.NguoiTao,
        s.NgayCapNhat,
        s.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM SinhVien s
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE s.MaSinhVien = @MaSinhVien AND s.IsDeleted = 0;
END;
GO

-- sp_SinhVien_Create
CREATE OR ALTER PROCEDURE sp_SinhVien_Create
    @HoTen NVARCHAR(200),
    @MSSV NVARCHAR(20),
    @Lop NVARCHAR(50),
    @Khoa NVARCHAR(100),
    @NgaySinh DATETIME = NULL,
    @GioiTinh NVARCHAR(10) = NULL,
    @SDT NVARCHAR(15) = NULL,
    @Email NVARCHAR(100) = NULL,
    @DiaChi NVARCHAR(500) = NULL,
    @AnhDaiDien NVARCHAR(500) = NULL,
    @TrangThai BIT = 1,
    @MaPhong INT = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO SinhVien (HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, AnhDaiDien, TrangThai, MaPhong, NguoiTao)
    VALUES (@HoTen, @MSSV, @Lop, @Khoa, @NgaySinh, @GioiTinh, @SDT, @Email, @DiaChi, @AnhDaiDien, @TrangThai, @MaPhong, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaSinhVien;
END;
GO

-- sp_SinhVien_Update
CREATE OR ALTER PROCEDURE sp_SinhVien_Update
    @MaSinhVien INT,
    @HoTen NVARCHAR(200),
    @MSSV NVARCHAR(20),
    @Lop NVARCHAR(50),
    @Khoa NVARCHAR(100),
    @NgaySinh DATETIME = NULL,
    @GioiTinh NVARCHAR(10) = NULL,
    @SDT NVARCHAR(15) = NULL,
    @Email NVARCHAR(100) = NULL,
    @DiaChi NVARCHAR(500) = NULL,
    @AnhDaiDien NVARCHAR(500) = NULL,
    @TrangThai BIT = 1,
    @MaPhong INT = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SinhVien 
    SET HoTen = @HoTen,
        MSSV = @MSSV,
        Lop = @Lop,
        Khoa = @Khoa,
        NgaySinh = @NgaySinh,
        GioiTinh = @GioiTinh,
        SDT = @SDT,
        Email = @Email,
        DiaChi = @DiaChi,
        AnhDaiDien = @AnhDaiDien,
        TrangThai = @TrangThai,
        MaPhong = @MaPhong,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaSinhVien = @MaSinhVien AND IsDeleted = 0;
END;
GO

-- sp_SinhVien_Delete
CREATE OR ALTER PROCEDURE sp_SinhVien_Delete
    @MaSinhVien INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SinhVien 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaSinhVien = @MaSinhVien AND IsDeleted = 0;
END;
GO

-- sp_SinhVien_GetByTaiKhoan
CREATE OR ALTER PROCEDURE sp_SinhVien_GetByTaiKhoan
    @TenDangNhap NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        s.NgaySinh,
        s.GioiTinh,
        s.SDT,
        s.Email,
        s.DiaChi,
        s.AnhDaiDien,
        s.TrangThai,
        s.MaPhong,
        p.SoPhong,
        t.TenToaNha
    FROM SinhVien s
    INNER JOIN TaiKhoan tk ON s.MaSinhVien = tk.MaSinhVien AND tk.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tk.TenDangNhap = @TenDangNhap AND s.IsDeleted = 0;
END;
GO

-- sp_SinhVien_GetByPhong
CREATE OR ALTER PROCEDURE sp_SinhVien_GetByPhong
    @MaPhong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        s.NgaySinh,
        s.GioiTinh,
        s.SDT,
        s.Email,
        s.DiaChi,
        s.AnhDaiDien,
        s.TrangThai,
        s.MaPhong,
        s.IsDeleted,
        s.NgayTao,
        s.NguoiTao,
        s.NgayCapNhat,
        s.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM SinhVien s
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE s.MaPhong = @MaPhong AND s.IsDeleted = 0
    ORDER BY s.HoTen;
END;
GO

-- sp_SinhVien_UpdateProfile
CREATE OR ALTER PROCEDURE sp_SinhVien_UpdateProfile
    @MaSinhVien INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATETIME = NULL,
    @GioiTinh NVARCHAR(10) = NULL,
    @SDT NVARCHAR(15) = NULL,
    @Email NVARCHAR(100) = NULL,
    @DiaChi NVARCHAR(500) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SinhVien 
    SET HoTen = @HoTen,
        NgaySinh = @NgaySinh,
        GioiTinh = @GioiTinh,
        SDT = @SDT,
        Email = @Email,
        DiaChi = @DiaChi,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaSinhVien = @MaSinhVien AND IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - TAI KHOAN CRUD
-- =============================================

-- sp_TaiKhoan_GetAll
CREATE OR ALTER PROCEDURE sp_TaiKhoan_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tk.MaTaiKhoan,
        tk.TenDangNhap,
        tk.HoTen,
        tk.Email,
        tk.VaiTro,
        tk.TrangThai,
        tk.MaSinhVien,
        tk.IsDeleted,
        tk.NgayTao,
        tk.NguoiTao,
        tk.NgayCapNhat,
        tk.NguoiCapNhat,
        tk.SoLanDangNhapSai,
        tk.NgayKhoa,
        s.HoTen AS TenSinhVien,
        s.MSSV
    FROM TaiKhoan tk
    LEFT JOIN SinhVien s ON tk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    WHERE tk.IsDeleted = 0
    ORDER BY tk.TenDangNhap;
END;
GO

-- sp_TaiKhoan_GetById
CREATE OR ALTER PROCEDURE sp_TaiKhoan_GetById
    @MaTaiKhoan INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tk.MaTaiKhoan,
        tk.TenDangNhap,
        tk.HoTen,
        tk.Email,
        tk.VaiTro,
        tk.TrangThai,
        tk.MaSinhVien,
        tk.IsDeleted,
        tk.NgayTao,
        tk.NguoiTao,
        tk.NgayCapNhat,
        tk.NguoiCapNhat,
        tk.SoLanDangNhapSai,
        tk.NgayKhoa,
        s.HoTen AS TenSinhVien,
        s.MSSV
    FROM TaiKhoan tk
    LEFT JOIN SinhVien s ON tk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    WHERE tk.MaTaiKhoan = @MaTaiKhoan AND tk.IsDeleted = 0;
END;
GO

-- sp_TaiKhoan_Create
CREATE OR ALTER PROCEDURE sp_TaiKhoan_Create
    @TenDangNhap NVARCHAR(50),
    @MatKhau NVARCHAR(255),
    @HoTen NVARCHAR(200),
    @Email NVARCHAR(100) = NULL,
    @VaiTro NVARCHAR(20) = 'User',
    @TrangThai BIT = 1,
    @MaSinhVien INT = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, Email, VaiTro, TrangThai, MaSinhVien, NguoiTao)
    VALUES (@TenDangNhap, @MatKhau, @HoTen, @Email, @VaiTro, @TrangThai, @MaSinhVien, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaTaiKhoan;
END;
GO

-- sp_TaiKhoan_Update
CREATE OR ALTER PROCEDURE sp_TaiKhoan_Update
    @MaTaiKhoan INT,
    @TenDangNhap NVARCHAR(50),
    @HoTen NVARCHAR(200),
    @Email NVARCHAR(100) = NULL,
    @VaiTro NVARCHAR(20) = 'User',
    @TrangThai BIT = 1,
    @MaSinhVien INT = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaiKhoan 
    SET TenDangNhap = @TenDangNhap,
        HoTen = @HoTen,
        Email = @Email,
        VaiTro = @VaiTro,
        TrangThai = @TrangThai,
        MaSinhVien = @MaSinhVien,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaTaiKhoan = @MaTaiKhoan AND IsDeleted = 0;
END;
GO

-- sp_TaiKhoan_Delete
CREATE OR ALTER PROCEDURE sp_TaiKhoan_Delete
    @MaTaiKhoan INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaiKhoan 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaTaiKhoan = @MaTaiKhoan AND IsDeleted = 0;
END;
GO

-- sp_TaiKhoan_ChangePassword
CREATE OR ALTER PROCEDURE sp_TaiKhoan_ChangePassword
    @MaTaiKhoan INT,
    @MatKhauMoi NVARCHAR(255),
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaiKhoan 
    SET MatKhau = @MatKhauMoi,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaTaiKhoan = @MaTaiKhoan AND IsDeleted = 0;
END;
GO

-- sp_TaiKhoan_GetByTenDangNhap
CREATE OR ALTER PROCEDURE sp_TaiKhoan_GetByTenDangNhap
    @TenDangNhap NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tk.MaTaiKhoan,
        tk.TenDangNhap,
        tk.MatKhau,
        tk.HoTen,
        tk.Email,
        tk.VaiTro,
        tk.TrangThai,
        tk.MaSinhVien,
        tk.IsDeleted,
        tk.NgayTao,
        tk.NguoiTao,
        tk.NgayCapNhat,
        tk.NguoiCapNhat,
        tk.SoLanDangNhapSai,
        tk.NgayKhoa,
        s.HoTen AS TenSinhVien,
        s.MSSV
    FROM TaiKhoan tk
    LEFT JOIN SinhVien s ON tk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    WHERE tk.TenDangNhap = @TenDangNhap AND tk.IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - MUC PHI CRUD
-- =============================================

-- sp_MucPhi_GetAll
CREATE OR ALTER PROCEDURE sp_MucPhi_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaMucPhi,
        TenMucPhi,
        LoaiPhi,
        GiaTien,
        DonVi,
        TrangThai,
        GhiChu,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM MucPhi
    WHERE IsDeleted = 0
    ORDER BY LoaiPhi, TenMucPhi;
END;
GO

-- sp_MucPhi_GetById
CREATE OR ALTER PROCEDURE sp_MucPhi_GetById
    @MaMucPhi INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaMucPhi,
        TenMucPhi,
        LoaiPhi,
        GiaTien,
        DonVi,
        TrangThai,
        GhiChu,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM MucPhi
    WHERE MaMucPhi = @MaMucPhi AND IsDeleted = 0;
END;
GO

-- sp_MucPhi_Create
CREATE OR ALTER PROCEDURE sp_MucPhi_Create
    @TenMucPhi NVARCHAR(200),
    @LoaiPhi NVARCHAR(100),
    @GiaTien DECIMAL(18,2),
    @DonVi NVARCHAR(50) = NULL,
    @TrangThai BIT = 1,
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO MucPhi (TenMucPhi, LoaiPhi, GiaTien, DonVi, TrangThai, GhiChu, NguoiTao)
    VALUES (@TenMucPhi, @LoaiPhi, @GiaTien, @DonVi, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaMucPhi;
END;
GO

-- sp_MucPhi_Update
CREATE OR ALTER PROCEDURE sp_MucPhi_Update
    @MaMucPhi INT,
    @TenMucPhi NVARCHAR(200),
    @LoaiPhi NVARCHAR(100),
    @GiaTien DECIMAL(18,2),
    @DonVi NVARCHAR(50) = NULL,
    @TrangThai BIT = 1,
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE MucPhi 
    SET TenMucPhi = @TenMucPhi,
        LoaiPhi = @LoaiPhi,
        GiaTien = @GiaTien,
        DonVi = @DonVi,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaMucPhi = @MaMucPhi AND IsDeleted = 0;
END;
GO

-- sp_MucPhi_Delete
CREATE OR ALTER PROCEDURE sp_MucPhi_Delete
    @MaMucPhi INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE MucPhi 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaMucPhi = @MaMucPhi AND IsDeleted = 0;
END;
GO

-- sp_MucPhi_GetByLoaiPhi
CREATE OR ALTER PROCEDURE sp_MucPhi_GetByLoaiPhi
    @LoaiPhi NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaMucPhi,
        TenMucPhi,
        LoaiPhi,
        GiaTien,
        DonVi,
        TrangThai,
        GhiChu,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM MucPhi
    WHERE LoaiPhi = @LoaiPhi AND IsDeleted = 0
    ORDER BY TenMucPhi;
END;
GO

-- sp_MucPhi_GetByType (Alias for GetByLoaiPhi)
CREATE OR ALTER PROCEDURE sp_MucPhi_GetByType
    @LoaiPhi NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaMucPhi,
        TenMucPhi,
        LoaiPhi,
        GiaTien,
        DonVi,
        TrangThai,
        GhiChu,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM MucPhi
    WHERE LoaiPhi = @LoaiPhi AND IsDeleted = 0
    ORDER BY TenMucPhi;
END;
GO

-- =============================================
-- STORED PROCEDURES - HOP DONG CRUD
-- =============================================

-- sp_HopDong_GetAll
CREATE OR ALTER PROCEDURE sp_HopDong_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHopDong,
        hd.MaSinhVien,
        hd.MaGiuong,
        hd.NgayBatDau,
        hd.NgayKetThuc,
        hd.GiaPhong,
        hd.TrangThai,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        g.SoGiuong,
        p.SoPhong,
        t.TenToaNha
    FROM HopDong hd
    INNER JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN Giuong g ON hd.MaGiuong = g.MaGiuong AND g.IsDeleted = 0
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.IsDeleted = 0
    ORDER BY hd.NgayTao DESC;
END;
GO

-- sp_HopDong_GetById
CREATE OR ALTER PROCEDURE sp_HopDong_GetById
    @MaHopDong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHopDong,
        hd.MaSinhVien,
        hd.MaGiuong,
        hd.NgayBatDau,
        hd.NgayKetThuc,
        hd.GiaPhong,
        hd.TrangThai,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        g.SoGiuong,
        p.SoPhong,
        t.TenToaNha
    FROM HopDong hd
    INNER JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN Giuong g ON hd.MaGiuong = g.MaGiuong AND g.IsDeleted = 0
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.MaHopDong = @MaHopDong AND hd.IsDeleted = 0;
END;
GO

-- sp_HopDong_Create
CREATE OR ALTER PROCEDURE sp_HopDong_Create
    @MaSinhVien INT,
    @MaGiuong INT,
    @NgayBatDau DATE,
    @NgayKetThuc DATE,
    @GiaPhong DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO HopDong (MaSinhVien, MaGiuong, NgayBatDau, NgayKetThuc, GiaPhong, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @MaGiuong, @NgayBatDau, @NgayKetThuc, @GiaPhong, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaHopDong;
END;
GO

-- sp_HopDong_Update
CREATE OR ALTER PROCEDURE sp_HopDong_Update
    @MaHopDong INT,
    @MaSinhVien INT,
    @MaGiuong INT,
    @NgayBatDau DATE,
    @NgayKetThuc DATE,
    @GiaPhong DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HopDong 
    SET MaSinhVien = @MaSinhVien,
        MaGiuong = @MaGiuong,
        NgayBatDau = @NgayBatDau,
        NgayKetThuc = @NgayKetThuc,
        GiaPhong = @GiaPhong,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaHopDong = @MaHopDong AND IsDeleted = 0;
END;
GO

-- sp_HopDong_Delete
CREATE OR ALTER PROCEDURE sp_HopDong_Delete
    @MaHopDong INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HopDong 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaHopDong = @MaHopDong AND IsDeleted = 0;
END;
GO

-- sp_HopDong_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_HopDong_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHopDong,
        hd.MaSinhVien,
        hd.MaGiuong,
        hd.NgayBatDau,
        hd.NgayKetThuc,
        hd.GiaPhong,
        hd.TrangThai,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        g.SoGiuong,
        p.SoPhong,
        t.TenToaNha
    FROM HopDong hd
    INNER JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN Giuong g ON hd.MaGiuong = g.MaGiuong AND g.IsDeleted = 0
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.MaSinhVien = @MaSinhVien AND hd.IsDeleted = 0
    ORDER BY hd.NgayTao DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - HOA DON CRUD
-- =============================================

-- sp_HoaDon_GetAll
CREATE OR ALTER PROCEDURE sp_HoaDon_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHoaDon,
        hd.MaSinhVien,
        hd.MaPhong,
        hd.MaHopDong,
        hd.Thang,
        hd.Nam,
        hd.TongTien,
        hd.TrangThai,
        hd.HanThanhToan,
        hd.NgayThanhToan,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM HoaDon hd
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.IsDeleted = 0
    ORDER BY hd.NgayTao DESC;
END;
GO

-- sp_HoaDon_GetById
CREATE OR ALTER PROCEDURE sp_HoaDon_GetById
    @MaHoaDon INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHoaDon,
        hd.MaSinhVien,
        hd.MaPhong,
        hd.MaHopDong,
        hd.Thang,
        hd.Nam,
        hd.TongTien,
        hd.TrangThai,
        hd.HanThanhToan,
        hd.NgayThanhToan,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM HoaDon hd
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.MaHoaDon = @MaHoaDon AND hd.IsDeleted = 0;
END;
GO

-- sp_HoaDon_Create
CREATE OR ALTER PROCEDURE sp_HoaDon_Create
    @MaSinhVien INT,
    @MaPhong INT = NULL,
    @MaHopDong INT = NULL,
    @Thang INT,
    @Nam INT,
    @TongTien DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chưa thanh toán',
    @HanThanhToan DATE = NULL,
    @NgayThanhToan DATE = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO HoaDon (MaSinhVien, MaPhong, MaHopDong, Thang, Nam, TongTien, TrangThai, HanThanhToan, NgayThanhToan, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @MaPhong, @MaHopDong, @Thang, @Nam, @TongTien, @TrangThai, @HanThanhToan, @NgayThanhToan, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaHoaDon;
END;
GO

-- sp_HoaDon_Update
CREATE OR ALTER PROCEDURE sp_HoaDon_Update
    @MaHoaDon INT,
    @MaSinhVien INT,
    @MaPhong INT = NULL,
    @MaHopDong INT = NULL,
    @Thang INT,
    @Nam INT,
    @TongTien DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chưa thanh toán',
    @HanThanhToan DATE = NULL,
    @NgayThanhToan DATE = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HoaDon 
    SET MaSinhVien = @MaSinhVien,
        MaPhong = @MaPhong,
        MaHopDong = @MaHopDong,
        Thang = @Thang,
        Nam = @Nam,
        TongTien = @TongTien,
        TrangThai = @TrangThai,
        HanThanhToan = @HanThanhToan,
        NgayThanhToan = @NgayThanhToan,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaHoaDon = @MaHoaDon AND IsDeleted = 0;
END;
GO

-- sp_HoaDon_Delete
CREATE OR ALTER PROCEDURE sp_HoaDon_Delete
    @MaHoaDon INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HoaDon 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaHoaDon = @MaHoaDon AND IsDeleted = 0;
END;
GO

-- sp_HoaDon_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_HoaDon_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        hd.MaHoaDon,
        hd.MaSinhVien,
        hd.MaPhong,
        hd.MaHopDong,
        hd.Thang,
        hd.Nam,
        hd.TongTien,
        hd.TrangThai,
        hd.HanThanhToan,
        hd.NgayThanhToan,
        hd.GhiChu,
        hd.IsDeleted,
        hd.NgayTao,
        hd.NguoiTao,
        hd.NgayCapNhat,
        hd.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM HoaDon hd
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.MaSinhVien = @MaSinhVien AND hd.IsDeleted = 0
    ORDER BY hd.NgayTao DESC;
END;
GO

-- sp_HoaDon_GenerateMonthly
CREATE OR ALTER PROCEDURE sp_HoaDon_GenerateMonthly
    @Thang INT,
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MaHoaDon INT;
    
    -- Tạo hóa đơn cho tất cả sinh viên có hợp đồng trong tháng
    INSERT INTO HoaDon (MaSinhVien, MaPhong, MaHopDong, Thang, Nam, TongTien, TrangThai, HanThanhToan, NguoiTao)
    SELECT 
        hd.MaSinhVien,
        p.MaPhong,
        hd.MaHopDong,
        @Thang,
        @Nam,
        hd.GiaPhong + ISNULL((SELECT SUM(GiaTien) FROM MucPhi WHERE LoaiPhi = 'Dịch vụ' AND TrangThai = 1 AND IsDeleted = 0), 0),
        'Chưa thanh toán',
        DATEADD(DAY, 15, DATEFROMPARTS(@Nam, @Thang, 1)),
        'System'
    FROM HopDong hd
    INNER JOIN Giuong g ON hd.MaGiuong = g.MaGiuong AND g.IsDeleted = 0
    INNER JOIN Phong p ON g.MaPhong = p.MaPhong AND p.IsDeleted = 0
    WHERE hd.TrangThai = 'Đã duyệt' 
    AND hd.IsDeleted = 0
    AND (@Thang BETWEEN MONTH(hd.NgayBatDau) AND MONTH(hd.NgayKetThuc)
         AND @Nam BETWEEN YEAR(hd.NgayBatDau) AND YEAR(hd.NgayKetThuc))
    AND NOT EXISTS (
        SELECT 1 FROM HoaDon hd2 
        WHERE hd2.MaSinhVien = hd.MaSinhVien 
        AND hd2.Thang = @Thang 
        AND hd2.Nam = @Nam 
        AND hd2.IsDeleted = 0
    );
    
    SELECT @@ROWCOUNT AS SoHoaDonTao;
END;
GO

-- =============================================
-- STORED PROCEDURES - BIEN LAI THU CRUD
-- =============================================

-- sp_BienLaiThu_GetAll
CREATE OR ALTER PROCEDURE sp_BienLaiThu_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        blt.MaBienLai,
        blt.MaHoaDon,
        blt.SoTienThu,
        blt.NgayThu,
        blt.PhuongThucThanhToan,
        blt.NguoiThu,
        blt.GhiChu,
        blt.IsDeleted,
        blt.NgayTao,
        blt.NguoiTao,
        blt.NgayCapNhat,
        blt.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM BienLaiThu blt
    INNER JOIN HoaDon hd ON blt.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE blt.IsDeleted = 0
    ORDER BY blt.NgayThu DESC;
END;
GO

-- sp_BienLaiThu_GetById
CREATE OR ALTER PROCEDURE sp_BienLaiThu_GetById
    @MaBienLai INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        blt.MaBienLai,
        blt.MaHoaDon,
        blt.SoTienThu,
        blt.NgayThu,
        blt.PhuongThucThanhToan,
        blt.NguoiThu,
        blt.GhiChu,
        blt.IsDeleted,
        blt.NgayTao,
        blt.NguoiTao,
        blt.NgayCapNhat,
        blt.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM BienLaiThu blt
    INNER JOIN HoaDon hd ON blt.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE blt.MaBienLai = @MaBienLai AND blt.IsDeleted = 0;
END;
GO

-- sp_BienLaiThu_Create
CREATE OR ALTER PROCEDURE sp_BienLaiThu_Create
    @MaHoaDon INT,
    @SoTienThu DECIMAL(18,2),
    @NgayThu DATE,
    @PhuongThucThanhToan NVARCHAR(100),
    @NguoiThu NVARCHAR(100) = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO BienLaiThu (MaHoaDon, SoTienThu, NgayThu, PhuongThucThanhToan, NguoiThu, GhiChu, NguoiTao)
    VALUES (@MaHoaDon, @SoTienThu, @NgayThu, @PhuongThucThanhToan, @NguoiThu, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaBienLai;
END;
GO

-- sp_BienLaiThu_Update
CREATE OR ALTER PROCEDURE sp_BienLaiThu_Update
    @MaBienLai INT,
    @MaHoaDon INT,
    @SoTienThu DECIMAL(18,2),
    @NgayThu DATE,
    @PhuongThucThanhToan NVARCHAR(100),
    @NguoiThu NVARCHAR(100) = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BienLaiThu 
    SET MaHoaDon = @MaHoaDon,
        SoTienThu = @SoTienThu,
        NgayThu = @NgayThu,
        PhuongThucThanhToan = @PhuongThucThanhToan,
        NguoiThu = @NguoiThu,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaBienLai = @MaBienLai AND IsDeleted = 0;
END;
GO

-- sp_BienLaiThu_Delete
CREATE OR ALTER PROCEDURE sp_BienLaiThu_Delete
    @MaBienLai INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BienLaiThu 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaBienLai = @MaBienLai AND IsDeleted = 0;
END;
GO

-- sp_BienLaiThu_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_BienLaiThu_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        blt.MaBienLai,
        blt.MaHoaDon,
        blt.SoTienThu,
        blt.NgayThu,
        blt.PhuongThucThanhToan,
        blt.NguoiThu,
        blt.GhiChu,
        blt.IsDeleted,
        blt.NgayTao,
        blt.NguoiTao,
        blt.NgayCapNhat,
        blt.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM BienLaiThu blt
    INNER JOIN HoaDon hd ON blt.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE hd.MaSinhVien = @MaSinhVien AND blt.IsDeleted = 0
    ORDER BY blt.NgayThu DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - KY LUAT CRUD
-- =============================================

-- sp_KyLuat_GetAll
CREATE OR ALTER PROCEDURE sp_KyLuat_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        kl.MaKyLuat,
        kl.MaSinhVien,
        kl.LoaiViPham,
        kl.MoTa,
        kl.NgayViPham,
        kl.MucPhat,
        kl.TrangThai,
        kl.GhiChu,
        kl.IsDeleted,
        kl.NgayTao,
        kl.NguoiTao,
        kl.NgayCapNhat,
        kl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM KyLuat kl
    INNER JOIN SinhVien s ON kl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE kl.IsDeleted = 0
    ORDER BY kl.NgayViPham DESC;
END;
GO

-- sp_KyLuat_GetById
CREATE OR ALTER PROCEDURE sp_KyLuat_GetById
    @MaKyLuat INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        kl.MaKyLuat,
        kl.MaSinhVien,
        kl.LoaiViPham,
        kl.MoTa,
        kl.NgayViPham,
        kl.MucPhat,
        kl.TrangThai,
        kl.GhiChu,
        kl.IsDeleted,
        kl.NgayTao,
        kl.NguoiTao,
        kl.NgayCapNhat,
        kl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM KyLuat kl
    INNER JOIN SinhVien s ON kl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE kl.MaKyLuat = @MaKyLuat AND kl.IsDeleted = 0;
END;
GO

-- sp_KyLuat_Create
CREATE OR ALTER PROCEDURE sp_KyLuat_Create
    @MaSinhVien INT,
    @LoaiViPham NVARCHAR(100),
    @MoTa NVARCHAR(1000),
    @NgayViPham DATE,
    @MucPhat DECIMAL(18,2) = 0,
    @TrangThai NVARCHAR(50) = 'Chưa xử lý',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO KyLuat (MaSinhVien, LoaiViPham, MoTa, NgayViPham, MucPhat, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @LoaiViPham, @MoTa, @NgayViPham, @MucPhat, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaKyLuat;
END;
GO

-- sp_KyLuat_Update
CREATE OR ALTER PROCEDURE sp_KyLuat_Update
    @MaKyLuat INT,
    @MaSinhVien INT,
    @LoaiViPham NVARCHAR(100),
    @MoTa NVARCHAR(1000),
    @NgayViPham DATE,
    @MucPhat DECIMAL(18,2) = 0,
    @TrangThai NVARCHAR(50) = 'Chưa xử lý',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE KyLuat 
    SET MaSinhVien = @MaSinhVien,
        LoaiViPham = @LoaiViPham,
        MoTa = @MoTa,
        NgayViPham = @NgayViPham,
        MucPhat = @MucPhat,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaKyLuat = @MaKyLuat AND IsDeleted = 0;
END;
GO

-- sp_KyLuat_Delete
CREATE OR ALTER PROCEDURE sp_KyLuat_Delete
    @MaKyLuat INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE KyLuat 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaKyLuat = @MaKyLuat AND IsDeleted = 0;
END;
GO

-- sp_KyLuat_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_KyLuat_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        kl.MaKyLuat,
        kl.MaSinhVien,
        kl.LoaiViPham,
        kl.MoTa,
        kl.NgayViPham,
        kl.MucPhat,
        kl.TrangThai,
        kl.GhiChu,
        kl.IsDeleted,
        kl.NgayTao,
        kl.NguoiTao,
        kl.NgayCapNhat,
        kl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM KyLuat kl
    INNER JOIN SinhVien s ON kl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE kl.MaSinhVien = @MaSinhVien AND kl.IsDeleted = 0
    ORDER BY kl.NgayViPham DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - DIEM REN LUYEN CRUD
-- =============================================

-- sp_DiemRenLuyen_GetAll
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        drl.MaDiem,
        drl.MaSinhVien,
        drl.Thang,
        drl.Nam,
        drl.DiemSo,
        drl.XepLoai,
        drl.GhiChu,
        drl.IsDeleted,
        drl.NgayTao,
        drl.NguoiTao,
        drl.NgayCapNhat,
        drl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM DiemRenLuyen drl
    INNER JOIN SinhVien s ON drl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE drl.IsDeleted = 0
    ORDER BY drl.Nam DESC, drl.Thang DESC;
END;
GO

-- sp_DiemRenLuyen_GetById
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_GetById
    @MaDiem INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        drl.MaDiem,
        drl.MaSinhVien,
        drl.Thang,
        drl.Nam,
        drl.DiemSo,
        drl.XepLoai,
        drl.GhiChu,
        drl.IsDeleted,
        drl.NgayTao,
        drl.NguoiTao,
        drl.NgayCapNhat,
        drl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM DiemRenLuyen drl
    INNER JOIN SinhVien s ON drl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE drl.MaDiem = @MaDiem AND drl.IsDeleted = 0;
END;
GO

-- sp_DiemRenLuyen_Create
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_Create
    @MaSinhVien INT,
    @Thang INT,
    @Nam INT,
    @DiemSo DECIMAL(5,2),
    @XepLoai NVARCHAR(50),
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO DiemRenLuyen (MaSinhVien, Thang, Nam, DiemSo, XepLoai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @Thang, @Nam, @DiemSo, @XepLoai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaDiem;
END;
GO

-- sp_DiemRenLuyen_Update
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_Update
    @MaDiem INT,
    @MaSinhVien INT,
    @Thang INT,
    @Nam INT,
    @DiemSo DECIMAL(5,2),
    @XepLoai NVARCHAR(50),
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DiemRenLuyen 
    SET MaSinhVien = @MaSinhVien,
        Thang = @Thang,
        Nam = @Nam,
        DiemSo = @DiemSo,
        XepLoai = @XepLoai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDiem = @MaDiem AND IsDeleted = 0;
END;
GO

-- sp_DiemRenLuyen_Delete
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_Delete
    @MaDiem INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DiemRenLuyen 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDiem = @MaDiem AND IsDeleted = 0;
END;
GO

-- sp_DiemRenLuyen_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        drl.MaDiem,
        drl.MaSinhVien,
        drl.Thang,
        drl.Nam,
        drl.DiemSo,
        drl.XepLoai,
        drl.GhiChu,
        drl.IsDeleted,
        drl.NgayTao,
        drl.NguoiTao,
        drl.NgayCapNhat,
        drl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM DiemRenLuyen drl
    INNER JOIN SinhVien s ON drl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE drl.MaSinhVien = @MaSinhVien AND drl.IsDeleted = 0
    ORDER BY drl.Nam DESC, drl.Thang DESC;
END;
GO

-- sp_DiemRenLuyen_GetBySinhVienAndMonth
CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_GetBySinhVienAndMonth
    @MaSinhVien INT,
    @Thang INT,
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        drl.MaDiem,
        drl.MaSinhVien,
        drl.Thang,
        drl.Nam,
        drl.DiemSo,
        drl.XepLoai,
        drl.GhiChu,
        drl.IsDeleted,
        drl.NgayTao,
        drl.NguoiTao,
        drl.NgayCapNhat,
        drl.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM DiemRenLuyen drl
    INNER JOIN SinhVien s ON drl.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE drl.MaSinhVien = @MaSinhVien AND drl.Thang = @Thang AND drl.Nam = @Nam AND drl.IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - DON DANG KY CRUD
-- =============================================

-- sp_DonDangKy_GetAll
CREATE OR ALTER PROCEDURE sp_DonDangKy_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ddk.MaDon,
        ddk.MaSinhVien,
        ddk.MaPhongDeXuat,
        ddk.LyDo,
        ddk.NgayDangKy,
        ddk.TrangThai,
        ddk.GhiChu,
        ddk.IsDeleted,
        ddk.NgayTao,
        ddk.NguoiTao,
        ddk.NgayCapNhat,
        ddk.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong AS PhongDeXuat,
        t.TenToaNha AS ToaNhaDeXuat
    FROM DonDangKy ddk
    INNER JOIN SinhVien s ON ddk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON ddk.MaPhongDeXuat = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE ddk.IsDeleted = 0
    ORDER BY ddk.NgayDangKy DESC;
END;
GO

-- sp_DonDangKy_GetById
CREATE OR ALTER PROCEDURE sp_DonDangKy_GetById
    @MaDon INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ddk.MaDon,
        ddk.MaSinhVien,
        ddk.MaPhongDeXuat,
        ddk.LyDo,
        ddk.NgayDangKy,
        ddk.TrangThai,
        ddk.GhiChu,
        ddk.IsDeleted,
        ddk.NgayTao,
        ddk.NguoiTao,
        ddk.NgayCapNhat,
        ddk.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong AS PhongDeXuat,
        t.TenToaNha AS ToaNhaDeXuat
    FROM DonDangKy ddk
    INNER JOIN SinhVien s ON ddk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON ddk.MaPhongDeXuat = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE ddk.MaDon = @MaDon AND ddk.IsDeleted = 0;
END;
GO

-- sp_DonDangKy_Create
CREATE OR ALTER PROCEDURE sp_DonDangKy_Create
    @MaSinhVien INT,
    @MaPhongDeXuat INT = NULL,
    @LyDo NVARCHAR(1000) = NULL,
    @NgayDangKy DATE,
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO DonDangKy (MaSinhVien, MaPhongDeXuat, LyDo, NgayDangKy, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @MaPhongDeXuat, @LyDo, @NgayDangKy, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaDon;
END;
GO

-- sp_DonDangKy_Update
CREATE OR ALTER PROCEDURE sp_DonDangKy_Update
    @MaDon INT,
    @MaSinhVien INT,
    @MaPhongDeXuat INT = NULL,
    @LyDo NVARCHAR(1000) = NULL,
    @NgayDangKy DATE,
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DonDangKy 
    SET MaSinhVien = @MaSinhVien,
        MaPhongDeXuat = @MaPhongDeXuat,
        LyDo = @LyDo,
        NgayDangKy = @NgayDangKy,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDon = @MaDon AND IsDeleted = 0;
END;
GO

-- sp_DonDangKy_Delete
CREATE OR ALTER PROCEDURE sp_DonDangKy_Delete
    @MaDon INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DonDangKy 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDon = @MaDon AND IsDeleted = 0;
END;
GO

-- sp_DonDangKy_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_DonDangKy_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ddk.MaDon,
        ddk.MaSinhVien,
        ddk.MaPhongDeXuat,
        ddk.LyDo,
        ddk.NgayDangKy,
        ddk.TrangThai,
        ddk.GhiChu,
        ddk.IsDeleted,
        ddk.NgayTao,
        ddk.NguoiTao,
        ddk.NgayCapNhat,
        ddk.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong AS PhongDeXuat,
        t.TenToaNha AS ToaNhaDeXuat
    FROM DonDangKy ddk
    INNER JOIN SinhVien s ON ddk.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON ddk.MaPhongDeXuat = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE ddk.MaSinhVien = @MaSinhVien AND ddk.IsDeleted = 0
    ORDER BY ddk.NgayDangKy DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - YEU CAU CHUYEN PHONG CRUD
-- =============================================

-- sp_YeuCauChuyenPhong_GetAll
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        yccp.MaYeuCau,
        yccp.MaSinhVien,
        yccp.PhongHienTai,
        yccp.PhongMongMuon,
        yccp.LyDo,
        yccp.NgayYeuCau,
        yccp.TrangThai,
        yccp.GhiChu,
        yccp.IsDeleted,
        yccp.NgayTao,
        yccp.NguoiTao,
        yccp.NgayCapNhat,
        yccp.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p1.SoPhong AS PhongHienTaiSo,
        t1.TenToaNha AS ToaNhaHienTai,
        p2.SoPhong AS PhongMongMuonSo,
        t2.TenToaNha AS ToaNhaMongMuon
    FROM YeuCauChuyenPhong yccp
    INNER JOIN SinhVien s ON yccp.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p1 ON yccp.PhongHienTai = p1.MaPhong AND p1.IsDeleted = 0
    LEFT JOIN ToaNha t1 ON p1.MaToaNha = t1.MaToaNha AND t1.IsDeleted = 0
    LEFT JOIN Phong p2 ON yccp.PhongMongMuon = p2.MaPhong AND p2.IsDeleted = 0
    LEFT JOIN ToaNha t2 ON p2.MaToaNha = t2.MaToaNha AND t2.IsDeleted = 0
    WHERE yccp.IsDeleted = 0
    ORDER BY yccp.NgayYeuCau DESC;
END;
GO

-- sp_YeuCauChuyenPhong_GetById
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_GetById
    @MaYeuCau INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        yccp.MaYeuCau,
        yccp.MaSinhVien,
        yccp.PhongHienTai,
        yccp.PhongMongMuon,
        yccp.LyDo,
        yccp.NgayYeuCau,
        yccp.TrangThai,
        yccp.GhiChu,
        yccp.IsDeleted,
        yccp.NgayTao,
        yccp.NguoiTao,
        yccp.NgayCapNhat,
        yccp.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p1.SoPhong AS PhongHienTaiSo,
        t1.TenToaNha AS ToaNhaHienTai,
        p2.SoPhong AS PhongMongMuonSo,
        t2.TenToaNha AS ToaNhaMongMuon
    FROM YeuCauChuyenPhong yccp
    INNER JOIN SinhVien s ON yccp.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p1 ON yccp.PhongHienTai = p1.MaPhong AND p1.IsDeleted = 0
    LEFT JOIN ToaNha t1 ON p1.MaToaNha = t1.MaToaNha AND t1.IsDeleted = 0
    LEFT JOIN Phong p2 ON yccp.PhongMongMuon = p2.MaPhong AND p2.IsDeleted = 0
    LEFT JOIN ToaNha t2 ON p2.MaToaNha = t2.MaToaNha AND t2.IsDeleted = 0
    WHERE yccp.MaYeuCau = @MaYeuCau AND yccp.IsDeleted = 0;
END;
GO

-- sp_YeuCauChuyenPhong_Create
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_Create
    @MaSinhVien INT,
    @PhongHienTai INT,
    @PhongMongMuon INT = NULL,
    @LyDo NVARCHAR(1000),
    @NgayYeuCau DATE,
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO YeuCauChuyenPhong (MaSinhVien, PhongHienTai, PhongMongMuon, LyDo, NgayYeuCau, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @PhongHienTai, @PhongMongMuon, @LyDo, @NgayYeuCau, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaYeuCau;
END;
GO

-- sp_YeuCauChuyenPhong_Update
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_Update
    @MaYeuCau INT,
    @MaSinhVien INT,
    @PhongHienTai INT,
    @PhongMongMuon INT = NULL,
    @LyDo NVARCHAR(1000),
    @NgayYeuCau DATE,
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE YeuCauChuyenPhong 
    SET MaSinhVien = @MaSinhVien,
        PhongHienTai = @PhongHienTai,
        PhongMongMuon = @PhongMongMuon,
        LyDo = @LyDo,
        NgayYeuCau = @NgayYeuCau,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaYeuCau = @MaYeuCau AND IsDeleted = 0;
END;
GO

-- sp_YeuCauChuyenPhong_Delete
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_Delete
    @MaYeuCau INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE YeuCauChuyenPhong 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaYeuCau = @MaYeuCau AND IsDeleted = 0;
END;
GO

-- sp_YeuCauChuyenPhong_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        yccp.MaYeuCau,
        yccp.MaSinhVien,
        yccp.PhongHienTai,
        yccp.PhongMongMuon,
        yccp.LyDo,
        yccp.NgayYeuCau,
        yccp.TrangThai,
        yccp.GhiChu,
        yccp.IsDeleted,
        yccp.NgayTao,
        yccp.NguoiTao,
        yccp.NgayCapNhat,
        yccp.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p1.SoPhong AS PhongHienTaiSo,
        t1.TenToaNha AS ToaNhaHienTai,
        p2.SoPhong AS PhongMongMuonSo,
        t2.TenToaNha AS ToaNhaMongMuon
    FROM YeuCauChuyenPhong yccp
    INNER JOIN SinhVien s ON yccp.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p1 ON yccp.PhongHienTai = p1.MaPhong AND p1.IsDeleted = 0
    LEFT JOIN ToaNha t1 ON p1.MaToaNha = t1.MaToaNha AND t1.IsDeleted = 0
    LEFT JOIN Phong p2 ON yccp.PhongMongMuon = p2.MaPhong AND p2.IsDeleted = 0
    LEFT JOIN ToaNha t2 ON p2.MaToaNha = t2.MaToaNha AND t2.IsDeleted = 0
    WHERE yccp.MaSinhVien = @MaSinhVien AND yccp.IsDeleted = 0
    ORDER BY yccp.NgayYeuCau DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - CHI SO DIEN NUOC CRUD
-- =============================================

-- sp_ChiSoDienNuoc_GetAll
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        csdn.MaChiSo,
        csdn.MaPhong,
        csdn.Thang,
        csdn.Nam,
        csdn.ChiSoDien,
        csdn.ChiSoNuoc,
        csdn.NguoiGhi,
        csdn.TrangThai,
        csdn.GhiChu,
        csdn.IsDeleted,
        csdn.NgayTao,
        csdn.NguoiTao,
        csdn.NgayCapNhat,
        csdn.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ChiSoDienNuoc csdn
    INNER JOIN Phong p ON csdn.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE csdn.IsDeleted = 0
    ORDER BY csdn.Nam DESC, csdn.Thang DESC;
END;
GO

-- sp_ChiSoDienNuoc_GetById
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_GetById
    @MaChiSo INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        csdn.MaChiSo,
        csdn.MaPhong,
        csdn.Thang,
        csdn.Nam,
        csdn.ChiSoDien,
        csdn.ChiSoNuoc,
        csdn.NguoiGhi,
        csdn.TrangThai,
        csdn.GhiChu,
        csdn.IsDeleted,
        csdn.NgayTao,
        csdn.NguoiTao,
        csdn.NgayCapNhat,
        csdn.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ChiSoDienNuoc csdn
    INNER JOIN Phong p ON csdn.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE csdn.MaChiSo = @MaChiSo AND csdn.IsDeleted = 0;
END;
GO

-- sp_ChiSoDienNuoc_Create
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_Create
    @MaPhong INT,
    @Thang INT,
    @Nam INT,
    @ChiSoDien INT,
    @ChiSoNuoc INT,
    @NguoiGhi NVARCHAR(100) = NULL,
    @TrangThai NVARCHAR(50) = 'Đã ghi',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ChiSoDienNuoc (MaPhong, Thang, Nam, ChiSoDien, ChiSoNuoc, NguoiGhi, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaPhong, @Thang, @Nam, @ChiSoDien, @ChiSoNuoc, @NguoiGhi, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaChiSo;
END;
GO

-- sp_ChiSoDienNuoc_Update
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_Update
    @MaChiSo INT,
    @MaPhong INT,
    @Thang INT,
    @Nam INT,
    @ChiSoDien INT,
    @ChiSoNuoc INT,
    @NguoiGhi NVARCHAR(100) = NULL,
    @TrangThai NVARCHAR(50) = 'Đã ghi',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ChiSoDienNuoc 
    SET MaPhong = @MaPhong,
        Thang = @Thang,
        Nam = @Nam,
        ChiSoDien = @ChiSoDien,
        ChiSoNuoc = @ChiSoNuoc,
        NguoiGhi = @NguoiGhi,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaChiSo = @MaChiSo AND IsDeleted = 0;
END;
GO

-- sp_ChiSoDienNuoc_Delete
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_Delete
    @MaChiSo INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ChiSoDienNuoc 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaChiSo = @MaChiSo AND IsDeleted = 0;
END;
GO

-- sp_ChiSoDienNuoc_GetByPhong
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_GetByPhong
    @MaPhong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        csdn.MaChiSo,
        csdn.MaPhong,
        csdn.Thang,
        csdn.Nam,
        csdn.ChiSoDien,
        csdn.ChiSoNuoc,
        csdn.NguoiGhi,
        csdn.TrangThai,
        csdn.GhiChu,
        csdn.IsDeleted,
        csdn.NgayTao,
        csdn.NguoiTao,
        csdn.NgayCapNhat,
        csdn.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ChiSoDienNuoc csdn
    INNER JOIN Phong p ON csdn.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE csdn.MaPhong = @MaPhong AND csdn.IsDeleted = 0
    ORDER BY csdn.Nam DESC, csdn.Thang DESC;
END;
GO

-- sp_ChiSoDienNuoc_GetByThangNam
CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_GetByThangNam
    @Thang INT,
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        csdn.MaChiSo,
        csdn.MaPhong,
        csdn.Thang,
        csdn.Nam,
        csdn.ChiSoDien,
        csdn.ChiSoNuoc,
        csdn.NguoiGhi,
        csdn.TrangThai,
        csdn.GhiChu,
        csdn.IsDeleted,
        csdn.NgayTao,
        csdn.NguoiTao,
        csdn.NgayCapNhat,
        csdn.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ChiSoDienNuoc csdn
    INNER JOIN Phong p ON csdn.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE csdn.Thang = @Thang AND csdn.Nam = @Nam AND csdn.IsDeleted = 0
    ORDER BY t.TenToaNha, p.SoPhong;
END;
GO

-- =============================================
-- STORED PROCEDURES - CHI TIET HOA DON CRUD
-- =============================================

-- sp_ChiTietHoaDon_GetAll
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        cthd.MaChiTiet,
        cthd.MaHoaDon,
        cthd.LoaiChiPhi,
        cthd.SoLuong,
        cthd.DonGia,
        cthd.ThanhTien,
        cthd.GhiChu,
        cthd.IsDeleted,
        cthd.NgayTao,
        cthd.NguoiTao,
        cthd.NgayCapNhat,
        cthd.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM ChiTietHoaDon cthd
    INNER JOIN HoaDon hd ON cthd.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE cthd.IsDeleted = 0
    ORDER BY cthd.NgayTao DESC;
END;
GO

-- sp_ChiTietHoaDon_GetById
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_GetById
    @MaChiTiet INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        cthd.MaChiTiet,
        cthd.MaHoaDon,
        cthd.LoaiChiPhi,
        cthd.SoLuong,
        cthd.DonGia,
        cthd.ThanhTien,
        cthd.GhiChu,
        cthd.IsDeleted,
        cthd.NgayTao,
        cthd.NguoiTao,
        cthd.NgayCapNhat,
        cthd.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM ChiTietHoaDon cthd
    INNER JOIN HoaDon hd ON cthd.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE cthd.MaChiTiet = @MaChiTiet AND cthd.IsDeleted = 0;
END;
GO

-- sp_ChiTietHoaDon_Create
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_Create
    @MaHoaDon INT,
    @LoaiChiPhi NVARCHAR(100),
    @SoLuong INT,
    @DonGia DECIMAL(18,2),
    @ThanhTien DECIMAL(18,2),
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ChiTietHoaDon (MaHoaDon, LoaiChiPhi, SoLuong, DonGia, ThanhTien, GhiChu, NguoiTao)
    VALUES (@MaHoaDon, @LoaiChiPhi, @SoLuong, @DonGia, @ThanhTien, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaChiTiet;
END;
GO

-- sp_ChiTietHoaDon_Update
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_Update
    @MaChiTiet INT,
    @MaHoaDon INT,
    @LoaiChiPhi NVARCHAR(100),
    @SoLuong INT,
    @DonGia DECIMAL(18,2),
    @ThanhTien DECIMAL(18,2),
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ChiTietHoaDon 
    SET MaHoaDon = @MaHoaDon,
        LoaiChiPhi = @LoaiChiPhi,
        SoLuong = @SoLuong,
        DonGia = @DonGia,
        ThanhTien = @ThanhTien,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaChiTiet = @MaChiTiet AND IsDeleted = 0;
END;
GO

-- sp_ChiTietHoaDon_Delete
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_Delete
    @MaChiTiet INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ChiTietHoaDon 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaChiTiet = @MaChiTiet AND IsDeleted = 0;
END;
GO

-- sp_ChiTietHoaDon_GetByHoaDon
CREATE OR ALTER PROCEDURE sp_ChiTietHoaDon_GetByHoaDon
    @MaHoaDon INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        cthd.MaChiTiet,
        cthd.MaHoaDon,
        cthd.LoaiChiPhi,
        cthd.SoLuong,
        cthd.DonGia,
        cthd.ThanhTien,
        cthd.GhiChu,
        cthd.IsDeleted,
        cthd.NgayTao,
        cthd.NguoiTao,
        cthd.NgayCapNhat,
        cthd.NguoiCapNhat,
        hd.MaSinhVien,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        p.SoPhong,
        t.TenToaNha
    FROM ChiTietHoaDon cthd
    INNER JOIN HoaDon hd ON cthd.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN SinhVien s ON hd.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    LEFT JOIN Phong p ON hd.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE cthd.MaHoaDon = @MaHoaDon AND cthd.IsDeleted = 0
    ORDER BY cthd.NgayTao;
END;
GO

-- =============================================
-- STORED PROCEDURES - DICH VU CRUD
-- =============================================

-- sp_DichVu_GetAll
CREATE OR ALTER PROCEDURE sp_DichVu_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaDichVu,
        TenDichVu,
        MoTa,
        GiaTien,
        DonViTinh,
        TrangThai,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM DichVu
    WHERE IsDeleted = 0
    ORDER BY TenDichVu;
END;
GO

-- sp_DichVu_GetById
CREATE OR ALTER PROCEDURE sp_DichVu_GetById
    @MaDichVu INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        MaDichVu,
        TenDichVu,
        MoTa,
        GiaTien,
        DonViTinh,
        TrangThai,
        IsDeleted,
        NgayTao,
        NguoiTao,
        NgayCapNhat,
        NguoiCapNhat
    FROM DichVu
    WHERE MaDichVu = @MaDichVu AND IsDeleted = 0;
END;
GO

-- sp_DichVu_Create
CREATE OR ALTER PROCEDURE sp_DichVu_Create
    @TenDichVu NVARCHAR(200),
    @MoTa NVARCHAR(1000) = NULL,
    @GiaTien DECIMAL(18,2) = 0,
    @DonViTinh NVARCHAR(50) = NULL,
    @TrangThai BIT = 1,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO DichVu (TenDichVu, MoTa, GiaTien, DonViTinh, TrangThai, NguoiTao)
    VALUES (@TenDichVu, @MoTa, @GiaTien, @DonViTinh, @TrangThai, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaDichVu;
END;
GO

-- sp_DichVu_Update
CREATE OR ALTER PROCEDURE sp_DichVu_Update
    @MaDichVu INT,
    @TenDichVu NVARCHAR(200),
    @MoTa NVARCHAR(1000) = NULL,
    @GiaTien DECIMAL(18,2) = 0,
    @DonViTinh NVARCHAR(50) = NULL,
    @TrangThai BIT = 1,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DichVu 
    SET TenDichVu = @TenDichVu,
        MoTa = @MoTa,
        GiaTien = @GiaTien,
        DonViTinh = @DonViTinh,
        TrangThai = @TrangThai,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDichVu = @MaDichVu AND IsDeleted = 0;
END;
GO

-- sp_DichVu_Delete
CREATE OR ALTER PROCEDURE sp_DichVu_Delete
    @MaDichVu INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DichVu 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDichVu = @MaDichVu AND IsDeleted = 0;
END;
GO

-- =============================================
-- STORED PROCEDURES - DANG KY DICH VU CRUD
-- =============================================

-- sp_DangKyDichVu_GetAll
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        dkdv.MaDangKy,
        dkdv.MaSinhVien,
        dkdv.MaDichVu,
        dkdv.NgayDangKy,
        dkdv.NgayBatDau,
        dkdv.NgayKetThuc,
        dkdv.TrangThai,
        dkdv.GhiChu,
        dkdv.IsDeleted,
        dkdv.NgayTao,
        dkdv.NguoiTao,
        dkdv.NgayCapNhat,
        dkdv.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        dv.TenDichVu,
        dv.GiaTien,
        dv.DonViTinh,
        p.SoPhong,
        t.TenToaNha
    FROM DangKyDichVu dkdv
    INNER JOIN SinhVien s ON dkdv.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN DichVu dv ON dkdv.MaDichVu = dv.MaDichVu AND dv.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE dkdv.IsDeleted = 0
    ORDER BY dkdv.NgayDangKy DESC;
END;
GO

-- sp_DangKyDichVu_GetById
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_GetById
    @MaDangKy INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        dkdv.MaDangKy,
        dkdv.MaSinhVien,
        dkdv.MaDichVu,
        dkdv.NgayDangKy,
        dkdv.NgayBatDau,
        dkdv.NgayKetThuc,
        dkdv.TrangThai,
        dkdv.GhiChu,
        dkdv.IsDeleted,
        dkdv.NgayTao,
        dkdv.NguoiTao,
        dkdv.NgayCapNhat,
        dkdv.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        dv.TenDichVu,
        dv.GiaTien,
        dv.DonViTinh,
        p.SoPhong,
        t.TenToaNha
    FROM DangKyDichVu dkdv
    INNER JOIN SinhVien s ON dkdv.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN DichVu dv ON dkdv.MaDichVu = dv.MaDichVu AND dv.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE dkdv.MaDangKy = @MaDangKy AND dkdv.IsDeleted = 0;
END;
GO

-- sp_DangKyDichVu_Create
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_Create
    @MaSinhVien INT,
    @MaDichVu INT,
    @NgayDangKy DATE,
    @NgayBatDau DATE,
    @NgayKetThuc DATE = NULL,
    @TrangThai NVARCHAR(50) = 'Hoạt động',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO DangKyDichVu (MaSinhVien, MaDichVu, NgayDangKy, NgayBatDau, NgayKetThuc, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @MaDichVu, @NgayDangKy, @NgayBatDau, @NgayKetThuc, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaDangKy;
END;
GO

-- sp_DangKyDichVu_Update
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_Update
    @MaDangKy INT,
    @MaSinhVien INT,
    @MaDichVu INT,
    @NgayDangKy DATE,
    @NgayBatDau DATE,
    @NgayKetThuc DATE = NULL,
    @TrangThai NVARCHAR(50) = 'Hoạt động',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DangKyDichVu 
    SET MaSinhVien = @MaSinhVien,
        MaDichVu = @MaDichVu,
        NgayDangKy = @NgayDangKy,
        NgayBatDau = @NgayBatDau,
        NgayKetThuc = @NgayKetThuc,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDangKy = @MaDangKy AND IsDeleted = 0;
END;
GO

-- sp_DangKyDichVu_Delete
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_Delete
    @MaDangKy INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE DangKyDichVu 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaDangKy = @MaDangKy AND IsDeleted = 0;
END;
GO

-- sp_DangKyDichVu_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_DangKyDichVu_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        dkdv.MaDangKy,
        dkdv.MaSinhVien,
        dkdv.MaDichVu,
        dkdv.NgayDangKy,
        dkdv.NgayBatDau,
        dkdv.NgayKetThuc,
        dkdv.TrangThai,
        dkdv.GhiChu,
        dkdv.IsDeleted,
        dkdv.NgayTao,
        dkdv.NguoiTao,
        dkdv.NgayCapNhat,
        dkdv.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        dv.TenDichVu,
        dv.GiaTien,
        dv.DonViTinh,
        p.SoPhong,
        t.TenToaNha
    FROM DangKyDichVu dkdv
    INNER JOIN SinhVien s ON dkdv.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN DichVu dv ON dkdv.MaDichVu = dv.MaDichVu AND dv.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE dkdv.MaSinhVien = @MaSinhVien AND dkdv.IsDeleted = 0
    ORDER BY dkdv.NgayDangKy DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - THIET BI CRUD
-- =============================================

-- sp_ThietBi_GetAll
CREATE OR ALTER PROCEDURE sp_ThietBi_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tb.MaThietBi,
        tb.MaPhong,
        tb.TenThietBi,
        tb.LoaiThietBi,
        tb.GiaTri,
        tb.TrangThai,
        tb.NgayMua,
        tb.NgayBaoHanh,
        tb.GhiChu,
        tb.IsDeleted,
        tb.NgayTao,
        tb.NguoiTao,
        tb.NgayCapNhat,
        tb.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ThietBi tb
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tb.IsDeleted = 0
    ORDER BY t.TenToaNha, p.SoPhong, tb.TenThietBi;
END;
GO

-- sp_ThietBi_GetById
CREATE OR ALTER PROCEDURE sp_ThietBi_GetById
    @MaThietBi INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tb.MaThietBi,
        tb.MaPhong,
        tb.TenThietBi,
        tb.LoaiThietBi,
        tb.GiaTri,
        tb.TrangThai,
        tb.NgayMua,
        tb.NgayBaoHanh,
        tb.GhiChu,
        tb.IsDeleted,
        tb.NgayTao,
        tb.NguoiTao,
        tb.NgayCapNhat,
        tb.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ThietBi tb
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tb.MaThietBi = @MaThietBi AND tb.IsDeleted = 0;
END;
GO

-- sp_ThietBi_Create
CREATE OR ALTER PROCEDURE sp_ThietBi_Create
    @MaPhong INT,
    @TenThietBi NVARCHAR(200),
    @LoaiThietBi NVARCHAR(100) = NULL,
    @GiaTri DECIMAL(18,2) = 0,
    @TrangThai NVARCHAR(50) = 'Hoạt động',
    @NgayMua DATE = NULL,
    @NgayBaoHanh DATE = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ThietBi (MaPhong, TenThietBi, LoaiThietBi, GiaTri, TrangThai, NgayMua, NgayBaoHanh, GhiChu, NguoiTao)
    VALUES (@MaPhong, @TenThietBi, @LoaiThietBi, @GiaTri, @TrangThai, @NgayMua, @NgayBaoHanh, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaThietBi;
END;
GO

-- sp_ThietBi_Update
CREATE OR ALTER PROCEDURE sp_ThietBi_Update
    @MaThietBi INT,
    @MaPhong INT,
    @TenThietBi NVARCHAR(200),
    @LoaiThietBi NVARCHAR(100) = NULL,
    @GiaTri DECIMAL(18,2) = 0,
    @TrangThai NVARCHAR(50) = 'Hoạt động',
    @NgayMua DATE = NULL,
    @NgayBaoHanh DATE = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ThietBi 
    SET MaPhong = @MaPhong,
        TenThietBi = @TenThietBi,
        LoaiThietBi = @LoaiThietBi,
        GiaTri = @GiaTri,
        TrangThai = @TrangThai,
        NgayMua = @NgayMua,
        NgayBaoHanh = @NgayBaoHanh,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaThietBi = @MaThietBi AND IsDeleted = 0;
END;
GO

-- sp_ThietBi_Delete
CREATE OR ALTER PROCEDURE sp_ThietBi_Delete
    @MaThietBi INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ThietBi 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaThietBi = @MaThietBi AND IsDeleted = 0;
END;
GO

-- sp_ThietBi_GetByPhong
CREATE OR ALTER PROCEDURE sp_ThietBi_GetByPhong
    @MaPhong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tb.MaThietBi,
        tb.MaPhong,
        tb.TenThietBi,
        tb.LoaiThietBi,
        tb.GiaTri,
        tb.TrangThai,
        tb.NgayMua,
        tb.NgayBaoHanh,
        tb.GhiChu,
        tb.IsDeleted,
        tb.NgayTao,
        tb.NguoiTao,
        tb.NgayCapNhat,
        tb.NguoiCapNhat,
        p.SoPhong,
        t.TenToaNha
    FROM ThietBi tb
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tb.MaPhong = @MaPhong AND tb.IsDeleted = 0
    ORDER BY tb.TenThietBi;
END;
GO

-- =============================================
-- STORED PROCEDURES - BAO TRI CRUD
-- =============================================

-- sp_BaoTri_GetAll
CREATE OR ALTER PROCEDURE sp_BaoTri_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        bt.MaBaoTri,
        bt.MaThietBi,
        bt.NgayBaoTri,
        bt.LoaiBaoTri,
        bt.ChiPhi,
        bt.MoTa,
        bt.TrangThai,
        bt.NguoiThucHien,
        bt.GhiChu,
        bt.IsDeleted,
        bt.NgayTao,
        bt.NguoiTao,
        bt.NgayCapNhat,
        bt.NguoiCapNhat,
        tb.TenThietBi,
        tb.LoaiThietBi,
        p.SoPhong,
        t.TenToaNha
    FROM BaoTri bt
    INNER JOIN ThietBi tb ON bt.MaThietBi = tb.MaThietBi AND tb.IsDeleted = 0
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE bt.IsDeleted = 0
    ORDER BY bt.NgayBaoTri DESC;
END;
GO

-- sp_BaoTri_GetById
CREATE OR ALTER PROCEDURE sp_BaoTri_GetById
    @MaBaoTri INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        bt.MaBaoTri,
        bt.MaThietBi,
        bt.NgayBaoTri,
        bt.LoaiBaoTri,
        bt.ChiPhi,
        bt.MoTa,
        bt.TrangThai,
        bt.NguoiThucHien,
        bt.GhiChu,
        bt.IsDeleted,
        bt.NgayTao,
        bt.NguoiTao,
        bt.NgayCapNhat,
        bt.NguoiCapNhat,
        tb.TenThietBi,
        tb.LoaiThietBi,
        p.SoPhong,
        t.TenToaNha
    FROM BaoTri bt
    INNER JOIN ThietBi tb ON bt.MaThietBi = tb.MaThietBi AND tb.IsDeleted = 0
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE bt.MaBaoTri = @MaBaoTri AND bt.IsDeleted = 0;
END;
GO

-- sp_BaoTri_Create
CREATE OR ALTER PROCEDURE sp_BaoTri_Create
    @MaThietBi INT,
    @NgayBaoTri DATE,
    @LoaiBaoTri NVARCHAR(100),
    @ChiPhi DECIMAL(18,2) = 0,
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai NVARCHAR(50) = 'Hoàn thành',
    @NguoiThucHien NVARCHAR(100) = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO BaoTri (MaThietBi, NgayBaoTri, LoaiBaoTri, ChiPhi, MoTa, TrangThai, NguoiThucHien, GhiChu, NguoiTao)
    VALUES (@MaThietBi, @NgayBaoTri, @LoaiBaoTri, @ChiPhi, @MoTa, @TrangThai, @NguoiThucHien, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaBaoTri;
END;
GO

-- sp_BaoTri_Update
CREATE OR ALTER PROCEDURE sp_BaoTri_Update
    @MaBaoTri INT,
    @MaThietBi INT,
    @NgayBaoTri DATE,
    @LoaiBaoTri NVARCHAR(100),
    @ChiPhi DECIMAL(18,2) = 0,
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai NVARCHAR(50) = 'Hoàn thành',
    @NguoiThucHien NVARCHAR(100) = NULL,
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BaoTri 
    SET MaThietBi = @MaThietBi,
        NgayBaoTri = @NgayBaoTri,
        LoaiBaoTri = @LoaiBaoTri,
        ChiPhi = @ChiPhi,
        MoTa = @MoTa,
        TrangThai = @TrangThai,
        NguoiThucHien = @NguoiThucHien,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaBaoTri = @MaBaoTri AND IsDeleted = 0;
END;
GO

-- sp_BaoTri_Delete
CREATE OR ALTER PROCEDURE sp_BaoTri_Delete
    @MaBaoTri INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BaoTri 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaBaoTri = @MaBaoTri AND IsDeleted = 0;
END;
GO

-- sp_BaoTri_GetByThietBi
CREATE OR ALTER PROCEDURE sp_BaoTri_GetByThietBi
    @MaThietBi INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        bt.MaBaoTri,
        bt.MaThietBi,
        bt.NgayBaoTri,
        bt.LoaiBaoTri,
        bt.ChiPhi,
        bt.MoTa,
        bt.TrangThai,
        bt.NguoiThucHien,
        bt.GhiChu,
        bt.IsDeleted,
        bt.NgayTao,
        bt.NguoiTao,
        bt.NgayCapNhat,
        bt.NguoiCapNhat,
        tb.TenThietBi,
        tb.LoaiThietBi,
        p.SoPhong,
        t.TenToaNha
    FROM BaoTri bt
    INNER JOIN ThietBi tb ON bt.MaThietBi = tb.MaThietBi AND tb.IsDeleted = 0
    INNER JOIN Phong p ON tb.MaPhong = p.MaPhong AND p.IsDeleted = 0
    INNER JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE bt.MaThietBi = @MaThietBi AND bt.IsDeleted = 0
    ORDER BY bt.NgayBaoTri DESC;
END;
GO

-- =============================================
-- STORED PROCEDURES - THONG BAO QUA HAN CRUD
-- =============================================

-- sp_ThongBaoQuaHan_GetAll
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tbh.MaThongBao,
        tbh.MaSinhVien,
        tbh.MaHoaDon,
        tbh.NgayThongBao,
        tbh.NoiDung,
        tbh.TrangThai,
        tbh.GhiChu,
        tbh.IsDeleted,
        tbh.NgayTao,
        tbh.NguoiTao,
        tbh.NgayCapNhat,
        tbh.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM ThongBaoQuaHan tbh
    INNER JOIN SinhVien s ON tbh.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN HoaDon hd ON tbh.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tbh.IsDeleted = 0
    ORDER BY tbh.NgayThongBao DESC;
END;
GO

-- sp_ThongBaoQuaHan_GetById
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_GetById
    @MaThongBao INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tbh.MaThongBao,
        tbh.MaSinhVien,
        tbh.MaHoaDon,
        tbh.NgayThongBao,
        tbh.NoiDung,
        tbh.TrangThai,
        tbh.GhiChu,
        tbh.IsDeleted,
        tbh.NgayTao,
        tbh.NguoiTao,
        tbh.NgayCapNhat,
        tbh.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM ThongBaoQuaHan tbh
    INNER JOIN SinhVien s ON tbh.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN HoaDon hd ON tbh.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tbh.MaThongBao = @MaThongBao AND tbh.IsDeleted = 0;
END;
GO

-- sp_ThongBaoQuaHan_Create
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_Create
    @MaSinhVien INT,
    @MaHoaDon INT,
    @NgayThongBao DATE,
    @NoiDung NVARCHAR(1000),
    @TrangThai NVARCHAR(50) = 'Đã gửi',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ThongBaoQuaHan (MaSinhVien, MaHoaDon, NgayThongBao, NoiDung, TrangThai, GhiChu, NguoiTao)
    VALUES (@MaSinhVien, @MaHoaDon, @NgayThongBao, @NoiDung, @TrangThai, @GhiChu, @NguoiTao);
    
    SELECT SCOPE_IDENTITY() AS MaThongBao;
END;
GO

-- sp_ThongBaoQuaHan_Update
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_Update
    @MaThongBao INT,
    @MaSinhVien INT,
    @MaHoaDon INT,
    @NgayThongBao DATE,
    @NoiDung NVARCHAR(1000),
    @TrangThai NVARCHAR(50) = 'Đã gửi',
    @GhiChu NVARCHAR(1000) = NULL,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ThongBaoQuaHan 
    SET MaSinhVien = @MaSinhVien,
        MaHoaDon = @MaHoaDon,
        NgayThongBao = @NgayThongBao,
        NoiDung = @NoiDung,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaThongBao = @MaThongBao AND IsDeleted = 0;
END;
GO

-- sp_ThongBaoQuaHan_Delete
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_Delete
    @MaThongBao INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ThongBaoQuaHan 
    SET IsDeleted = 1,
        NgayCapNhat = GETDATE(),
        NguoiCapNhat = @NguoiCapNhat
    WHERE MaThongBao = @MaThongBao AND IsDeleted = 0;
END;
GO

-- sp_ThongBaoQuaHan_GetBySinhVien
CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_GetBySinhVien
    @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tbh.MaThongBao,
        tbh.MaSinhVien,
        tbh.MaHoaDon,
        tbh.NgayThongBao,
        tbh.NoiDung,
        tbh.TrangThai,
        tbh.GhiChu,
        tbh.IsDeleted,
        tbh.NgayTao,
        tbh.NguoiTao,
        tbh.NgayCapNhat,
        tbh.NguoiCapNhat,
        s.HoTen AS TenSinhVien,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha
    FROM ThongBaoQuaHan tbh
    INNER JOIN SinhVien s ON tbh.MaSinhVien = s.MaSinhVien AND s.IsDeleted = 0
    INNER JOIN HoaDon hd ON tbh.MaHoaDon = hd.MaHoaDon AND hd.IsDeleted = 0
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    WHERE tbh.MaSinhVien = @MaSinhVien AND tbh.IsDeleted = 0
    ORDER BY tbh.NgayThongBao DESC;
END;
GO

-- =============================================
-- BUSINESS LOGIC STORED PROCEDURES
-- =============================================

-- sp_TinhTienDien - Tính tiền điện theo bậc giá
CREATE OR ALTER PROCEDURE sp_TinhTienDien
    @SoKwh INT,
    @Thang INT,
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TongTien DECIMAL(18,2) = 0;
    DECLARE @SoKwhConLai INT = @SoKwh;
    
    -- Lấy các bậc giá điện theo thứ tự từ thấp đến cao
    DECLARE bac_cursor CURSOR FOR
    SELECT TuSo, DenSo, DonGia
    FROM BacGia
    WHERE Loai = 'Điện' AND TrangThai = 1 AND IsDeleted = 0
    ORDER BY ThuTu;
    
    DECLARE @TuSo INT, @DenSo INT, @DonGia DECIMAL(18,2);
    
    OPEN bac_cursor;
    FETCH NEXT FROM bac_cursor INTO @TuSo, @DenSo, @DonGia;
    
    WHILE @@FETCH_STATUS = 0 AND @SoKwhConLai > 0
    BEGIN
        DECLARE @SoKwhTrongBac INT;
        
        -- Tính số kWh trong bậc này
        IF @SoKwhConLai >= (@DenSo - @TuSo + 1)
            SET @SoKwhTrongBac = @DenSo - @TuSo + 1;
        ELSE
            SET @SoKwhTrongBac = @SoKwhConLai;
        
        -- Tính tiền cho bậc này
        SET @TongTien = @TongTien + (@SoKwhTrongBac * @DonGia);
        SET @SoKwhConLai = @SoKwhConLai - @SoKwhTrongBac;
        
        FETCH NEXT FROM bac_cursor INTO @TuSo, @DenSo, @DonGia;
    END;
    
    CLOSE bac_cursor;
    DEALLOCATE bac_cursor;
    
    SELECT @TongTien AS TongTienDien;
END;
GO

-- sp_TinhTienNuoc - Tính tiền nước theo bậc giá
CREATE OR ALTER PROCEDURE sp_TinhTienNuoc
    @SoKhoi INT,
    @Thang INT,
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TongTien DECIMAL(18,2) = 0;
    DECLARE @SoKhoiConLai INT = @SoKhoi;
    
    -- Lấy các bậc giá nước theo thứ tự từ thấp đến cao
    DECLARE bac_cursor CURSOR FOR
    SELECT TuSo, DenSo, DonGia
    FROM BacGia
    WHERE Loai = 'Nước' AND TrangThai = 1 AND IsDeleted = 0
    ORDER BY ThuTu;
    
    DECLARE @TuSo INT, @DenSo INT, @DonGia DECIMAL(18,2);
    
    OPEN bac_cursor;
    FETCH NEXT FROM bac_cursor INTO @TuSo, @DenSo, @DonGia;
    
    WHILE @@FETCH_STATUS = 0 AND @SoKhoiConLai > 0
    BEGIN
        DECLARE @SoKhoiTrongBac INT;
        
        -- Tính số khối trong bậc này
        IF @SoKhoiConLai >= (@DenSo - @TuSo + 1)
            SET @SoKhoiTrongBac = @DenSo - @TuSo + 1;
        ELSE
            SET @SoKhoiTrongBac = @SoKhoiConLai;
        
        -- Tính tiền cho bậc này
        SET @TongTien = @TongTien + (@SoKhoiTrongBac * @DonGia);
        SET @SoKhoiConLai = @SoKhoiConLai - @SoKhoiTrongBac;
        
        FETCH NEXT FROM bac_cursor INTO @TuSo, @DenSo, @DonGia;
    END;
    
    CLOSE bac_cursor;
    DEALLOCATE bac_cursor;
    
    SELECT @TongTien AS TongTienNuoc;
END;
GO

-- sp_TaoHoaDonHangThang - Tạo hóa đơn hàng tháng cho tất cả sinh viên
CREATE OR ALTER PROCEDURE sp_TaoHoaDonHangThang
    @Thang INT,
    @Nam INT,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @MaHoaDon INT;
    DECLARE @TongTien DECIMAL(18,2);
    DECLARE @TongTienDien DECIMAL(18,2);
    DECLARE @TongTienNuoc DECIMAL(18,2);
    DECLARE @TongTienPhong DECIMAL(18,2);
    
    -- Lấy danh sách sinh viên đang ở
    DECLARE sinhvien_cursor CURSOR FOR
    SELECT s.MaSinhVien, s.MaPhong, s.HoTen, s.MSSV
    FROM SinhVien s
    WHERE s.IsDeleted = 0 AND s.MaPhong IS NOT NULL;
    
    DECLARE @MaSinhVien INT, @MaPhong INT, @HoTen NVARCHAR(200), @MSSV NVARCHAR(20);
    
    OPEN sinhvien_cursor;
    FETCH NEXT FROM sinhvien_cursor INTO @MaSinhVien, @MaPhong, @HoTen, @MSSV;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @TongTien = 0;
        SET @TongTienDien = 0;
        SET @TongTienNuoc = 0;
        SET @TongTienPhong = 0;
        
        -- Tính tiền phòng
        SELECT @TongTienPhong = ISNULL(GiaTien, 0)
        FROM MucPhi
        WHERE LoaiPhi = 'Phòng' AND TrangThai = 1 AND IsDeleted = 0;
        
        -- Tính tiền điện
        SELECT @TongTienDien = ISNULL(ChiSoDien, 0)
        FROM ChiSoDienNuoc
        WHERE MaPhong = @MaPhong AND Thang = @Thang AND Nam = @Nam;
        
        IF @TongTienDien > 0
        BEGIN
            -- Tính tiền điện theo bậc giá
            DECLARE @TienDien DECIMAL(18,2) = 0;
            DECLARE @SoKwhConLai INT = @TongTienDien;
            
            DECLARE bac_dien_cursor CURSOR FOR
            SELECT TuSo, DenSo, DonGia
            FROM BacGia
            WHERE Loai = 'Điện' AND TrangThai = 1 AND IsDeleted = 0
            ORDER BY ThuTu;
            
            DECLARE @TuSoDien INT, @DenSoDien INT, @DonGiaDien DECIMAL(18,2);
            
            OPEN bac_dien_cursor;
            FETCH NEXT FROM bac_dien_cursor INTO @TuSoDien, @DenSoDien, @DonGiaDien;
            
            WHILE @@FETCH_STATUS = 0 AND @SoKwhConLai > 0
            BEGIN
                DECLARE @SoKwhTrongBac INT;
                
                IF @SoKwhConLai >= (@DenSoDien - @TuSoDien + 1)
                    SET @SoKwhTrongBac = @DenSoDien - @TuSoDien + 1;
                ELSE
                    SET @SoKwhTrongBac = @SoKwhConLai;
                
                SET @TienDien = @TienDien + (@SoKwhTrongBac * @DonGiaDien);
                SET @SoKwhConLai = @SoKwhConLai - @SoKwhTrongBac;
                
                FETCH NEXT FROM bac_dien_cursor INTO @TuSoDien, @DenSoDien, @DonGiaDien;
            END;
            
            CLOSE bac_dien_cursor;
            DEALLOCATE bac_dien_cursor;
            
            SET @TongTienDien = @TienDien;
        END;
        
        -- Tính tiền nước
        SELECT @TongTienNuoc = ISNULL(ChiSoNuoc, 0)
        FROM ChiSoDienNuoc
        WHERE MaPhong = @MaPhong AND Thang = @Thang AND Nam = @Nam;
        
        IF @TongTienNuoc > 0
        BEGIN
            -- Tính tiền nước theo bậc giá
            DECLARE @TienNuoc DECIMAL(18,2) = 0;
            DECLARE @SoKhoiConLai INT = @TongTienNuoc;
            
            DECLARE bac_nuoc_cursor CURSOR FOR
            SELECT TuSo, DenSo, DonGia
            FROM BacGia
            WHERE Loai = 'Nước' AND TrangThai = 1 AND IsDeleted = 0
            ORDER BY ThuTu;
            
            DECLARE @TuSoNuoc INT, @DenSoNuoc INT, @DonGiaNuoc DECIMAL(18,2);
            
            OPEN bac_nuoc_cursor;
            FETCH NEXT FROM bac_nuoc_cursor INTO @TuSoNuoc, @DenSoNuoc, @DonGiaNuoc;
            
            WHILE @@FETCH_STATUS = 0 AND @SoKhoiConLai > 0
            BEGIN
                DECLARE @SoKhoiTrongBac INT;
                
                IF @SoKhoiConLai >= (@DenSoNuoc - @TuSoNuoc + 1)
                    SET @SoKhoiTrongBac = @DenSoNuoc - @TuSoNuoc + 1;
                ELSE
                    SET @SoKhoiTrongBac = @SoKhoiConLai;
                
                SET @TienNuoc = @TienNuoc + (@SoKhoiTrongBac * @DonGiaNuoc);
                SET @SoKhoiConLai = @SoKhoiConLai - @SoKhoiTrongBac;
                
                FETCH NEXT FROM bac_nuoc_cursor INTO @TuSoNuoc, @DenSoNuoc, @DonGiaNuoc;
            END;
            
            CLOSE bac_nuoc_cursor;
            DEALLOCATE bac_nuoc_cursor;
            
            SET @TongTienNuoc = @TienNuoc;
        END;
        
        SET @TongTien = @TongTienPhong + @TongTienDien + @TongTienNuoc;
        
        -- Tạo hóa đơn
        INSERT INTO HoaDon (MaSinhVien, Thang, Nam, TongTien, TrangThai, NgayTao, NguoiTao)
        VALUES (@MaSinhVien, @Thang, @Nam, @TongTien, 'Chưa thanh toán', GETDATE(), @NguoiTao);
        
        SET @MaHoaDon = SCOPE_IDENTITY();
        
        -- Tạo chi tiết hóa đơn
        IF @TongTienPhong > 0
        BEGIN
            INSERT INTO ChiTietHoaDon (MaHoaDon, LoaiChiPhi, SoLuong, DonGia, ThanhTien)
            SELECT @MaHoaDon, LoaiPhi, 1, GiaTien, GiaTien
            FROM MucPhi
            WHERE LoaiPhi = 'Phòng' AND TrangThai = 1 AND IsDeleted = 0;
        END;
        
        IF @TongTienDien > 0
        BEGIN
            INSERT INTO ChiTietHoaDon (MaHoaDon, LoaiChiPhi, SoLuong, DonGia, ThanhTien)
            SELECT @MaHoaDon, LoaiPhi, @TongTienDien, GiaTien, @TongTienDien
            FROM MucPhi
            WHERE LoaiPhi = 'Điện' AND TrangThai = 1 AND IsDeleted = 0;
        END;
        
        IF @TongTienNuoc > 0
        BEGIN
            INSERT INTO ChiTietHoaDon (MaHoaDon, LoaiChiPhi, SoLuong, DonGia, ThanhTien)
            SELECT @MaHoaDon, LoaiPhi, @TongTienNuoc, GiaTien, @TongTienNuoc
            FROM MucPhi
            WHERE LoaiPhi = 'Nước' AND TrangThai = 1 AND IsDeleted = 0;
        END;
        
        FETCH NEXT FROM sinhvien_cursor INTO @MaSinhVien, @MaPhong, @HoTen, @MSSV;
    END;
    
    CLOSE sinhvien_cursor;
    DEALLOCATE sinhvien_cursor;
    
    SELECT 'Hóa đơn hàng tháng đã được tạo thành công' AS KetQua;
END;
GO

-- sp_BaoCaoTyLeLapDay - Báo cáo tỷ lệ lấp đầy phòng
CREATE OR ALTER PROCEDURE sp_BaoCaoTyLeLapDay
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Thang IS NULL SET @Thang = MONTH(GETDATE());
    IF @Nam IS NULL SET @Nam = YEAR(GETDATE());
    
    SELECT 
        t.MaToaNha,
        t.TenToaNha,
        COUNT(p.MaPhong) AS TongSoPhong,
        COUNT(CASE WHEN s.MaSinhVien IS NOT NULL THEN 1 END) AS SoPhongCoSinhVien,
        CASE 
            WHEN COUNT(p.MaPhong) > 0 
            THEN CAST(COUNT(CASE WHEN s.MaSinhVien IS NOT NULL THEN 1 END) * 100.0 / COUNT(p.MaPhong) AS DECIMAL(5,2))
            ELSE 0 
        END AS TyLeLapDay
    FROM ToaNha t
    LEFT JOIN Phong p ON t.MaToaNha = p.MaToaNha AND p.IsDeleted = 0
    LEFT JOIN SinhVien s ON p.MaPhong = s.MaPhong AND s.IsDeleted = 0
    WHERE t.IsDeleted = 0
    GROUP BY t.MaToaNha, t.TenToaNha
    ORDER BY TyLeLapDay DESC;
END;
GO

-- sp_BaoCaoDoanhThu - Báo cáo doanh thu theo tháng
CREATE OR ALTER PROCEDURE sp_BaoCaoDoanhThu
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Thang IS NULL SET @Thang = MONTH(GETDATE());
    IF @Nam IS NULL SET @Nam = YEAR(GETDATE());
    
    SELECT 
        hd.Thang,
        hd.Nam,
        COUNT(hd.MaHoaDon) AS TongSoHoaDon,
        SUM(hd.TongTien) AS TongDoanhThu,
        SUM(CASE WHEN hd.TrangThai = 'Đã thanh toán' THEN hd.TongTien ELSE 0 END) AS DoanhThuDaThu,
        SUM(CASE WHEN hd.TrangThai = 'Chưa thanh toán' THEN hd.TongTien ELSE 0 END) AS DoanhThuChuaThu,
        AVG(hd.TongTien) AS TrungBinhHoaDon
    FROM HoaDon hd
    WHERE hd.Thang = @Thang AND hd.Nam = @Nam AND hd.IsDeleted = 0
    GROUP BY hd.Thang, hd.Nam;
END;
GO

-- sp_BaoCaoCongNo - Báo cáo công nợ sinh viên
CREATE OR ALTER PROCEDURE sp_BaoCaoCongNo
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Thang IS NULL SET @Thang = MONTH(GETDATE());
    IF @Nam IS NULL SET @Nam = YEAR(GETDATE());
    
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha,
        COUNT(hd.MaHoaDon) AS SoHoaDonChuaThanhToan,
        SUM(hd.TongTien) AS TongCongNo
    FROM SinhVien s
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    INNER JOIN HoaDon hd ON s.MaSinhVien = hd.MaSinhVien AND hd.TrangThai = 'Chưa thanh toán' AND hd.IsDeleted = 0
    WHERE s.IsDeleted = 0 AND hd.Thang <= @Thang AND hd.Nam <= @Nam
    GROUP BY s.MaSinhVien, s.HoTen, s.MSSV, s.Lop, s.Khoa, p.SoPhong, t.TenToaNha
    HAVING SUM(hd.TongTien) > 0
    ORDER BY TongCongNo DESC;
END;
GO

-- sp_BaoCaoDienNuoc - Báo cáo tiêu thụ điện nước
CREATE OR ALTER PROCEDURE sp_BaoCaoDienNuoc
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Thang IS NULL SET @Thang = MONTH(GETDATE());
    IF @Nam IS NULL SET @Nam = YEAR(GETDATE());
    
    SELECT 
        t.MaToaNha,
        t.TenToaNha,
        COUNT(DISTINCT p.MaPhong) AS TongSoPhong,
        SUM(csdn.ChiSoDien) AS TongSoDien,
        SUM(csdn.ChiSoNuoc) AS TongSoNuoc,
        AVG(csdn.ChiSoDien) AS TrungBinhDien,
        AVG(csdn.ChiSoNuoc) AS TrungBinhNuoc
    FROM ToaNha t
    LEFT JOIN Phong p ON t.MaToaNha = p.MaToaNha AND p.IsDeleted = 0
    LEFT JOIN ChiSoDienNuoc csdn ON p.MaPhong = csdn.MaPhong AND csdn.Thang = @Thang AND csdn.Nam = @Nam AND csdn.IsDeleted = 0
    WHERE t.IsDeleted = 0
    GROUP BY t.MaToaNha, t.TenToaNha
    ORDER BY t.TenToaNha;
END;
GO

-- sp_BaoCaoKyLuat - Báo cáo kỷ luật sinh viên
CREATE OR ALTER PROCEDURE sp_BaoCaoKyLuat
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Thang IS NULL SET @Thang = MONTH(GETDATE());
    IF @Nam IS NULL SET @Nam = YEAR(GETDATE());
    
    SELECT 
        s.MaSinhVien,
        s.HoTen,
        s.MSSV,
        s.Lop,
        s.Khoa,
        p.SoPhong,
        t.TenToaNha,
        COUNT(kl.MaKyLuat) AS SoLanKyLuat,
        SUM(kl.MucPhat) AS TongMucPhat,
        MAX(kl.NgayViPham) AS LanKyLuatGanNhat
    FROM SinhVien s
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong AND p.IsDeleted = 0
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha AND t.IsDeleted = 0
    LEFT JOIN KyLuat kl ON s.MaSinhVien = kl.MaSinhVien AND kl.IsDeleted = 0
        AND MONTH(kl.NgayViPham) = @Thang AND YEAR(kl.NgayViPham) = @Nam
    WHERE s.IsDeleted = 0
    GROUP BY s.MaSinhVien, s.HoTen, s.MSSV, s.Lop, s.Khoa, p.SoPhong, t.TenToaNha
    HAVING COUNT(kl.MaKyLuat) > 0
    ORDER BY SoLanKyLuat DESC, TongMucPhat DESC;
END;
GO

-- =============================================
-- ALIASES FOR COMPATIBILITY
-- =============================================

-- Aliases for existing procedures to match controller calls
CREATE OR ALTER PROCEDURE sp_SinhVien_Insert
    @HoTen NVARCHAR(200),
    @MSSV NVARCHAR(20),
    @Lop NVARCHAR(50),
    @Khoa NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(500),
    @SoDienThoai NVARCHAR(20),
    @Email NVARCHAR(100),
    @MaPhong INT = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_SinhVien_Create @HoTen, @MSSV, @Lop, @Khoa, @NgaySinh, @GioiTinh, @DiaChi, @SoDienThoai, @Email, @MaPhong, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_HoaDon_GenerateMonthly
    @Thang INT,
    @Nam INT,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_TaoHoaDonHangThang @Thang, @Nam, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_MucPhi_GetByType
    @LoaiPhi NVARCHAR(50),
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    EXEC sp_MucPhi_GetByLoaiPhi @LoaiPhi, @Thang, @Nam;
END;
GO

CREATE OR ALTER PROCEDURE sp_ChiSoDienNuoc_Insert
    @MaPhong INT,
    @Thang INT,
    @Nam INT,
    @SoDien INT,
    @SoNuoc INT,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_ChiSoDienNuoc_Create @MaPhong, @Thang, @Nam, @SoDien, @SoNuoc, @NguoiTao;
END;
GO

-- Stored Procedures cho BacGia
CREATE OR ALTER PROCEDURE sp_BacGia_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaBac, Loai, ThuTu, TuSo, DenSo, DonGia, TrangThai, NguoiTao, NgayTao, NguoiCapNhat, NgayCapNhat
    FROM BacGia
    WHERE IsDeleted = 0
    ORDER BY Loai, ThuTu;
END;
GO

CREATE OR ALTER PROCEDURE sp_BacGia_GetById
    @MaBac INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaBac, Loai, ThuTu, TuSo, DenSo, DonGia, TrangThai, NguoiTao, NgayTao, NguoiCapNhat, NgayCapNhat
    FROM BacGia
    WHERE MaBac = @MaBac AND IsDeleted = 0;
END;
GO

CREATE OR ALTER PROCEDURE sp_BacGia_Create
    @Loai NVARCHAR(50),
    @ThuTu INT,
    @TuSo INT,
    @DenSo INT,
    @DonGia DECIMAL(18,2),
    @TrangThai BIT = 1,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO BacGia (Loai, ThuTu, TuSo, DenSo, DonGia, TrangThai, NguoiTao, NgayTao)
    VALUES (@Loai, @ThuTu, @TuSo, @DenSo, @DonGia, @TrangThai, @NguoiTao, GETDATE());
    
    SELECT SCOPE_IDENTITY() AS MaBac;
END;
GO

CREATE OR ALTER PROCEDURE sp_BacGia_Update
    @MaBac INT,
    @Loai NVARCHAR(50),
    @ThuTu INT,
    @TuSo INT,
    @DenSo INT,
    @DonGia DECIMAL(18,2),
    @TrangThai BIT = 1,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BacGia
    SET Loai = @Loai,
        ThuTu = @ThuTu,
        TuSo = @TuSo,
        DenSo = @DenSo,
        DonGia = @DonGia,
        TrangThai = @TrangThai,
        NguoiCapNhat = @NguoiCapNhat,
        NgayCapNhat = GETDATE()
    WHERE MaBac = @MaBac AND IsDeleted = 0;
END;
GO

CREATE OR ALTER PROCEDURE sp_BacGia_Delete
    @MaBac INT,
    @NguoiCapNhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE BacGia
    SET IsDeleted = 1,
        NguoiCapNhat = @NguoiCapNhat,
        NgayCapNhat = GETDATE()
    WHERE MaBac = @MaBac;
END;
GO

CREATE OR ALTER PROCEDURE sp_BacGia_GetByLoaiPhi
    @Loai NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaBac, Loai, ThuTu, TuSo, DenSo, DonGia, TrangThai, NguoiTao, NgayTao, NguoiCapNhat, NgayCapNhat
    FROM BacGia
    WHERE Loai = @Loai AND IsDeleted = 0
    ORDER BY ThuTu;
END;
GO

-- Thêm các aliases còn thiếu
CREATE OR ALTER PROCEDURE sp_ToaNha_Insert
    @TenToaNha NVARCHAR(200),
    @DiaChi NVARCHAR(500) = NULL,
    @SoTang INT = NULL,
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai BIT = 1,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_ToaNha_Create @TenToaNha, @DiaChi, @SoTang, @MoTa, @TrangThai, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_Phong_Insert
    @MaToaNha INT,
    @SoPhong NVARCHAR(20),
    @SoGiuong INT,
    @LoaiPhong NVARCHAR(100),
    @GiaPhong DECIMAL(18,2),
    @MoTa NVARCHAR(1000) = NULL,
    @TrangThai NVARCHAR(50) = 'Trống',
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_Phong_Create @MaToaNha, @SoPhong, @SoGiuong, @LoaiPhong, @GiaPhong, @MoTa, @TrangThai, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_Giuong_Insert
    @MaPhong INT,
    @SoGiuong NVARCHAR(20),
    @TrangThai NVARCHAR(50) = 'Trống',
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_Giuong_Create @MaPhong, @SoGiuong, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_TaiKhoan_Insert
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(500),
    @HoTen NVARCHAR(200),
    @Email NVARCHAR(100) = NULL,
    @VaiTro NVARCHAR(50) = 'Student',
    @TrangThai BIT = 1,
    @MaSinhVien INT = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_TaiKhoan_Create @TenDangNhap, @MatKhau, @HoTen, @Email, @VaiTro, @TrangThai, @MaSinhVien, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_MucPhi_Insert
    @TenMucPhi NVARCHAR(200),
    @LoaiPhi NVARCHAR(50),
    @GiaTien DECIMAL(18,2),
    @DonVi NVARCHAR(50),
    @TrangThai BIT = 1,
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_MucPhi_Create @TenMucPhi, @LoaiPhi, @GiaTien, @DonVi, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_HopDong_Insert
    @MaSinhVien INT,
    @MaGiuong INT,
    @NgayBatDau DATE,
    @NgayKetThuc DATE,
    @GiaPhong DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_HopDong_Create @MaSinhVien, @MaGiuong, @NgayBatDau, @NgayKetThuc, @GiaPhong, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_HoaDon_Insert
    @MaSinhVien INT,
    @MaPhong INT = NULL,
    @MaHopDong INT = NULL,
    @Thang INT,
    @Nam INT,
    @TongTien DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chưa thanh toán',
    @NgayHetHan DATE = NULL,
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_HoaDon_Create @MaSinhVien, @MaPhong, @MaHopDong, @Thang, @Nam, @TongTien, @TrangThai, @NgayHetHan, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_BienLaiThu_Insert
    @MaHoaDon INT,
    @SoTienThu DECIMAL(18,2),
    @NgayThu DATE,
    @PhuongThucThanhToan NVARCHAR(50) = 'Tiền mặt',
    @NguoiThu NVARCHAR(100),
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_BienLaiThu_Create @MaHoaDon, @SoTienThu, @NgayThu, @PhuongThucThanhToan, @NguoiThu, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_KyLuat_Insert
    @MaSinhVien INT,
    @LoaiViPham NVARCHAR(100),
    @MoTa NVARCHAR(1000),
    @NgayViPham DATE,
    @MucPhat DECIMAL(18,2),
    @TrangThai NVARCHAR(50) = 'Chưa xử lý',
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_KyLuat_Create @MaSinhVien, @LoaiViPham, @MoTa, @NgayViPham, @MucPhat, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_DiemRenLuyen_Insert
    @MaSinhVien INT,
    @Thang INT,
    @Nam INT,
    @DiemSo DECIMAL(5,2),
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_DiemRenLuyen_Create @MaSinhVien, @Thang, @Nam, @DiemSo, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_DonDangKy_Insert
    @MaSinhVien INT,
    @MaPhongDeXuat INT = NULL,
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @LyDo NVARCHAR(500) = NULL,
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_DonDangKy_Create @MaSinhVien, @MaPhongDeXuat, @TrangThai, @LyDo, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_YeuCauChuyenPhong_Insert
    @MaSinhVien INT,
    @PhongHienTai INT,
    @PhongMongMuon INT,
    @LyDo NVARCHAR(500),
    @TrangThai NVARCHAR(50) = 'Chờ duyệt',
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_YeuCauChuyenPhong_Create @MaSinhVien, @PhongHienTai, @PhongMongMuon, @LyDo, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

CREATE OR ALTER PROCEDURE sp_ThongBaoQuaHan_Insert
    @MaSinhVien INT,
    @MaHoaDon INT,
    @NgayThongBao DATE,
    @NoiDung NVARCHAR(1000),
    @TrangThai NVARCHAR(50) = 'Đã gửi',
    @GhiChu NVARCHAR(500) = NULL,
    @NguoiTao NVARCHAR(100) = NULL
AS
BEGIN
    EXEC sp_ThongBaoQuaHan_Create @MaSinhVien, @MaHoaDon, @NgayThongBao, @NoiDung, @TrangThai, @GhiChu, @NguoiTao;
END;
GO

PRINT 'Database setup completed successfully!';
PRINT 'Tables created successfully!';
PRINT 'Constraints created successfully!';
PRINT 'Indexes created successfully!';
PRINT 'Seed data inserted successfully!';
PRINT 'Stored Procedures created successfully!';
PRINT 'Business Logic Procedures created successfully!';
PRINT 'Aliases created successfully!';
PRINT 'BacGia Procedures created successfully!';
PRINT 'Additional Aliases created successfully!';
