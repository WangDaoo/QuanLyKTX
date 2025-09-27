-- =============================================
-- QUẢN LÝ KÝ TÚC XÁ - COMPLETE DATABASE SETUP
-- =============================================
-- File tổng hợp: Database + Tables + Stored Procedures + Seed Data
-- Chạy file này một lần để thiết lập hoàn chỉnh database

-- =============================================
-- 1. TẠO DATABASE
-- =============================================
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QuanLyKyTucXa')
BEGIN
    CREATE DATABASE QuanLyKyTucXa;
END
GO

USE QuanLyKyTucXa;
GO

-- =============================================
-- 2. TẠO CÁC BẢNG
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
        MoTa NVARCHAR(1000),
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
        GhiChu NVARCHAR(500),
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
        SDT NVARCHAR(20),
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

-- Bảng HopDong
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HopDong' AND xtype='U')
BEGIN
    CREATE TABLE HopDong (
        MaHopDong INT IDENTITY(1,1) PRIMARY KEY,
        MaSinhVien INT NOT NULL,
        MaGiuong INT NOT NULL,
        NgayBatDau DATETIME NOT NULL,
        NgayKetThuc DATETIME NOT NULL,
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
        MaSinhVien INT NOT NULL,
        MaPhong INT,
        MaHopDong INT,
        Thang INT NOT NULL,
        Nam INT NOT NULL,
        TongTien DECIMAL(18,2) NOT NULL,
        TrangThai NVARCHAR(50) DEFAULT 'Chưa thanh toán',
        NgayHetHan DATETIME NOT NULL,
        NgayThanhToan DATETIME,
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

-- Bảng TaiKhoan
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TaiKhoan' AND xtype='U')
BEGIN
    CREATE TABLE TaiKhoan (
        MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
        TenDangNhap NVARCHAR(100) NOT NULL UNIQUE,
        MatKhau NVARCHAR(255) NOT NULL,
        HoTen NVARCHAR(200) NOT NULL,
        Email NVARCHAR(100),
        VaiTro NVARCHAR(50) DEFAULT 'User',
        TrangThai BIT DEFAULT 1,
        IsDeleted BIT DEFAULT 0,
        NgayTao DATETIME DEFAULT GETDATE(),
        NguoiTao NVARCHAR(100),
        NgayCapNhat DATETIME,
        NguoiCapNhat NVARCHAR(100)
    );
END
GO

PRINT 'Đã tạo xong tất cả các bảng!';

-- =============================================
-- 3. STORED PROCEDURES CƠ BẢN
-- =============================================
GO

-- ToaNha CRUD
CREATE OR ALTER PROCEDURE sp_toanha_create
    @ten_toa_nha NVARCHAR(200),
    @dia_chi NVARCHAR(500) = NULL,
    @so_tang INT = NULL,
    @mo_ta NVARCHAR(1000) = NULL,
    @trang_thai BIT = 1,
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO ToaNha (TenToaNha, DiaChi, SoTang, MoTa, TrangThai, NguoiTao)
    VALUES (@ten_toa_nha, @dia_chi, @so_tang, @mo_ta, @trang_thai, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaToaNha;
END
GO

CREATE OR ALTER PROCEDURE sp_toanha_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM ToaNha WHERE IsDeleted = 0 ORDER BY MaToaNha;
END
GO

CREATE OR ALTER PROCEDURE sp_toanha_getbyid
    @ma_toa_nha INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM ToaNha WHERE MaToaNha = @ma_toa_nha AND IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_toanha_update
    @ma_toa_nha INT,
    @ten_toa_nha NVARCHAR(200),
    @dia_chi NVARCHAR(500) = NULL,
    @so_tang INT = NULL,
    @mo_ta NVARCHAR(1000) = NULL,
    @trang_thai BIT = 1,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ToaNha 
    SET TenToaNha = @ten_toa_nha, DiaChi = @dia_chi, SoTang = @so_tang, 
        MoTa = @mo_ta, TrangThai = @trang_thai, NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaToaNha = @ma_toa_nha AND IsDeleted = 0;
END
GO

-- Phong CRUD
GO
CREATE OR ALTER PROCEDURE sp_phong_create
    @ma_toa_nha INT,
    @so_phong NVARCHAR(20),
    @so_giuong INT,
    @loai_phong NVARCHAR(50),
    @gia_phong DECIMAL(18,2),
    @mo_ta NVARCHAR(1000) = NULL,
    @trang_thai NVARCHAR(50) = 'Trống',
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, NguoiTao)
    VALUES (@ma_toa_nha, @so_phong, @so_giuong, @loai_phong, @gia_phong, @mo_ta, @trang_thai, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaPhong;
END
GO

CREATE OR ALTER PROCEDURE sp_phong_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.*, t.TenToaNha FROM Phong p 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE p.IsDeleted = 0 ORDER BY p.MaPhong;
END
GO

CREATE OR ALTER PROCEDURE sp_phong_getbyid
    @ma_phong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.*, t.TenToaNha FROM Phong p 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE p.MaPhong = @ma_phong AND p.IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_phong_update
    @ma_phong INT,
    @ma_toa_nha INT,
    @so_phong NVARCHAR(20),
    @so_giuong INT,
    @loai_phong NVARCHAR(50),
    @gia_phong DECIMAL(18,2),
    @mo_ta NVARCHAR(1000) = NULL,
    @trang_thai NVARCHAR(50) = 'Trống',
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Phong 
    SET MaToaNha = @ma_toa_nha, SoPhong = @so_phong, SoGiuong = @so_giuong, 
        LoaiPhong = @loai_phong, GiaPhong = @gia_phong, MoTa = @mo_ta, 
        TrangThai = @trang_thai, NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaPhong = @ma_phong AND IsDeleted = 0;
END
GO

-- SinhVien CRUD
GO
CREATE OR ALTER PROCEDURE sp_sinhvien_create
    @ho_ten NVARCHAR(200),
    @mssv NVARCHAR(20),
    @lop NVARCHAR(50),
    @khoa NVARCHAR(100),
    @ngay_sinh DATETIME = NULL,
    @gioi_tinh NVARCHAR(10) = NULL,
    @sdt NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL,
    @dia_chi NVARCHAR(500) = NULL,
    @ma_phong INT = NULL,
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM SinhVien WHERE MSSV = @mssv AND IsDeleted = 0)
        THROW 50001, 'MSSV đã tồn tại', 1;
    
    INSERT INTO SinhVien (HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, MaPhong, NguoiTao)
    VALUES (@ho_ten, @mssv, @lop, @khoa, @ngay_sinh, @gioi_tinh, @sdt, @email, @dia_chi, @ma_phong, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaSinhVien;
END
GO

CREATE OR ALTER PROCEDURE sp_sinhvien_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.*, p.SoPhong, t.TenToaNha FROM SinhVien s 
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE s.IsDeleted = 0 ORDER BY s.MaSinhVien;
END
GO

CREATE OR ALTER PROCEDURE sp_sinhvien_getbyid
    @ma_sinh_vien INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.*, p.SoPhong, t.TenToaNha FROM SinhVien s 
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE s.MaSinhVien = @ma_sinh_vien AND s.IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_sinhvien_update
    @ma_sinh_vien INT,
    @ho_ten NVARCHAR(200),
    @mssv NVARCHAR(20),
    @lop NVARCHAR(50),
    @khoa NVARCHAR(100),
    @ngay_sinh DATETIME = NULL,
    @gioi_tinh NVARCHAR(10) = NULL,
    @sdt NVARCHAR(20) = NULL,
    @email NVARCHAR(100) = NULL,
    @dia_chi NVARCHAR(500) = NULL,
    @ma_phong INT = NULL,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE SinhVien 
    SET HoTen = @ho_ten, MSSV = @mssv, Lop = @lop, Khoa = @khoa, 
        NgaySinh = @ngay_sinh, GioiTinh = @gioi_tinh, SDT = @sdt, 
        Email = @email, DiaChi = @dia_chi, MaPhong = @ma_phong, 
        NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaSinhVien = @ma_sinh_vien AND IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_sinhvien_search
    @page_index INT,
    @page_size INT,
    @ma_phong INT = NULL,
    @ho_ten NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @offset INT = (@page_index - 1) * @page_size;
    
    -- Count total records
    SELECT COUNT(*) as Total
    FROM SinhVien s 
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong 
    WHERE s.IsDeleted = 0 
    AND (@ma_phong IS NULL OR s.MaPhong = @ma_phong)
    AND (@ho_ten IS NULL OR s.HoTen LIKE '%' + @ho_ten + '%');
    
    -- Get paged data
    SELECT s.*, p.SoPhong, t.TenToaNha 
    FROM SinhVien s 
    LEFT JOIN Phong p ON s.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE s.IsDeleted = 0 
    AND (@ma_phong IS NULL OR s.MaPhong = @ma_phong)
    AND (@ho_ten IS NULL OR s.HoTen LIKE '%' + @ho_ten + '%')
    ORDER BY s.MaSinhVien
    OFFSET @offset ROWS FETCH NEXT @page_size ROWS ONLY;
END
GO

-- Giuong CRUD
GO
CREATE OR ALTER PROCEDURE sp_giuong_create
    @ma_phong INT,
    @so_giuong NVARCHAR(10),
    @trang_thai NVARCHAR(50) = 'Trống',
    @ghi_chu NVARCHAR(500) = NULL,
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
    VALUES (@ma_phong, @so_giuong, @trang_thai, @ghi_chu, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaGiuong;
END
GO

CREATE OR ALTER PROCEDURE sp_giuong_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.*, p.SoPhong, t.TenToaNha FROM Giuong g 
    LEFT JOIN Phong p ON g.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE g.IsDeleted = 0 ORDER BY g.MaGiuong;
END
GO

CREATE OR ALTER PROCEDURE sp_giuong_getbyid
    @ma_giuong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT g.*, p.SoPhong, t.TenToaNha FROM Giuong g 
    LEFT JOIN Phong p ON g.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE g.MaGiuong = @ma_giuong AND g.IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_giuong_update
    @ma_giuong INT,
    @ma_phong INT,
    @so_giuong NVARCHAR(10),
    @trang_thai NVARCHAR(50) = 'Trống',
    @ghi_chu NVARCHAR(500) = NULL,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Giuong 
    SET MaPhong = @ma_phong, SoGiuong = @so_giuong, TrangThai = @trang_thai, 
        GhiChu = @ghi_chu, NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaGiuong = @ma_giuong AND IsDeleted = 0;
END
GO

-- HopDong CRUD
GO
CREATE OR ALTER PROCEDURE sp_hopdong_create
    @ma_sinh_vien INT,
    @ma_giuong INT,
    @ngay_bat_dau DATETIME,
    @ngay_ket_thuc DATETIME,
    @gia_phong DECIMAL(18,2),
    @trang_thai NVARCHAR(50) = 'Chờ duyệt',
    @ghi_chu NVARCHAR(1000) = NULL,
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO HopDong (MaSinhVien, MaGiuong, NgayBatDau, NgayKetThuc, GiaPhong, TrangThai, GhiChu, NguoiTao)
    VALUES (@ma_sinh_vien, @ma_giuong, @ngay_bat_dau, @ngay_ket_thuc, @gia_phong, @trang_thai, @ghi_chu, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaHopDong;
END
GO

CREATE OR ALTER PROCEDURE sp_hopdong_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.*, s.HoTen, s.MSSV, g.SoGiuong, p.SoPhong, t.TenToaNha 
    FROM HopDong h 
    LEFT JOIN SinhVien s ON h.MaSinhVien = s.MaSinhVien 
    LEFT JOIN Giuong g ON h.MaGiuong = g.MaGiuong 
    LEFT JOIN Phong p ON g.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE h.IsDeleted = 0 ORDER BY h.MaHopDong;
END
GO

CREATE OR ALTER PROCEDURE sp_hopdong_getbyid
    @ma_hop_dong INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.*, s.HoTen, s.MSSV, g.SoGiuong, p.SoPhong, t.TenToaNha 
    FROM HopDong h 
    LEFT JOIN SinhVien s ON h.MaSinhVien = s.MaSinhVien 
    LEFT JOIN Giuong g ON h.MaGiuong = g.MaGiuong 
    LEFT JOIN Phong p ON g.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE h.MaHopDong = @ma_hop_dong AND h.IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_hopdong_update
    @ma_hop_dong INT,
    @ma_sinh_vien INT,
    @ma_giuong INT,
    @ngay_bat_dau DATETIME,
    @ngay_ket_thuc DATETIME,
    @gia_phong DECIMAL(18,2),
    @trang_thai NVARCHAR(50) = 'Chờ duyệt',
    @ghi_chu NVARCHAR(1000) = NULL,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HopDong 
    SET MaSinhVien = @ma_sinh_vien, MaGiuong = @ma_giuong, NgayBatDau = @ngay_bat_dau, 
        NgayKetThuc = @ngay_ket_thuc, GiaPhong = @gia_phong, TrangThai = @trang_thai, 
        GhiChu = @ghi_chu, NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaHopDong = @ma_hop_dong AND IsDeleted = 0;
END
GO

-- HoaDon CRUD
GO
CREATE OR ALTER PROCEDURE sp_hoadon_create
    @ma_sinh_vien INT,
    @ma_phong INT = NULL,
    @ma_hop_dong INT = NULL,
    @thang INT,
    @nam INT,
    @tong_tien DECIMAL(18,2),
    @trang_thai NVARCHAR(50) = 'Chưa thanh toán',
    @ngay_het_han DATETIME,
    @ghi_chu NVARCHAR(1000) = NULL,
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO HoaDon (MaSinhVien, MaPhong, MaHopDong, Thang, Nam, TongTien, TrangThai, NgayHetHan, GhiChu, NguoiTao)
    VALUES (@ma_sinh_vien, @ma_phong, @ma_hop_dong, @thang, @nam, @tong_tien, @trang_thai, @ngay_het_han, @ghi_chu, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaHoaDon;
END
GO

CREATE OR ALTER PROCEDURE sp_hoadon_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.*, s.HoTen, s.MSSV, p.SoPhong, t.TenToaNha 
    FROM HoaDon h 
    LEFT JOIN SinhVien s ON h.MaSinhVien = s.MaSinhVien 
    LEFT JOIN Phong p ON h.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE h.IsDeleted = 0 ORDER BY h.MaHoaDon;
END
GO

CREATE OR ALTER PROCEDURE sp_hoadon_getbyid
    @ma_hoa_don INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.*, s.HoTen, s.MSSV, p.SoPhong, t.TenToaNha 
    FROM HoaDon h 
    LEFT JOIN SinhVien s ON h.MaSinhVien = s.MaSinhVien 
    LEFT JOIN Phong p ON h.MaPhong = p.MaPhong 
    LEFT JOIN ToaNha t ON p.MaToaNha = t.MaToaNha 
    WHERE h.MaHoaDon = @ma_hoa_don AND h.IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_hoadon_update
    @ma_hoa_don INT,
    @ma_sinh_vien INT,
    @ma_phong INT = NULL,
    @ma_hop_dong INT = NULL,
    @thang INT,
    @nam INT,
    @tong_tien DECIMAL(18,2),
    @trang_thai NVARCHAR(50) = 'Chưa thanh toán',
    @ngay_het_han DATETIME,
    @ngay_thanh_toan DATETIME = NULL,
    @ghi_chu NVARCHAR(1000) = NULL,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HoaDon 
    SET MaSinhVien = @ma_sinh_vien, MaPhong = @ma_phong, MaHopDong = @ma_hop_dong, 
        Thang = @thang, Nam = @nam, TongTien = @tong_tien, TrangThai = @trang_thai, 
        NgayHetHan = @ngay_het_han, NgayThanhToan = @ngay_thanh_toan, GhiChu = @ghi_chu, 
        NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaHoaDon = @ma_hoa_don AND IsDeleted = 0;
END
GO

-- TaiKhoan CRUD
GO
CREATE OR ALTER PROCEDURE sp_taikhoan_create
    @ten_dang_nhap NVARCHAR(100),
    @mat_khau NVARCHAR(255),
    @ho_ten NVARCHAR(200),
    @email NVARCHAR(100) = NULL,
    @vai_tro NVARCHAR(50) = 'User',
    @nguoi_tao NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE TenDangNhap = @ten_dang_nhap AND IsDeleted = 0)
        THROW 50001, 'Tên đăng nhập đã tồn tại', 1;
    
    INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, Email, VaiTro, NguoiTao)
    VALUES (@ten_dang_nhap, @mat_khau, @ho_ten, @email, @vai_tro, @nguoi_tao);
    SELECT SCOPE_IDENTITY() AS MaTaiKhoan;
END
GO

CREATE OR ALTER PROCEDURE sp_taikhoan_authenticate
    @ten_dang_nhap NVARCHAR(100),
    @mat_khau NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaTaiKhoan, TenDangNhap, HoTen, Email, VaiTro, TrangThai 
    FROM TaiKhoan 
    WHERE TenDangNhap = @ten_dang_nhap AND MatKhau = @mat_khau AND IsDeleted = 0 AND TrangThai = 1;
END
GO

CREATE OR ALTER PROCEDURE sp_taikhoan_getall
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaTaiKhoan, TenDangNhap, HoTen, Email, VaiTro, TrangThai, NgayTao 
    FROM TaiKhoan WHERE IsDeleted = 0 ORDER BY MaTaiKhoan;
END
GO

CREATE OR ALTER PROCEDURE sp_taikhoan_getbyid
    @ma_tai_khoan INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaTaiKhoan, TenDangNhap, HoTen, Email, VaiTro, TrangThai, NgayTao 
    FROM TaiKhoan WHERE MaTaiKhoan = @ma_tai_khoan AND IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_taikhoan_update
    @ma_tai_khoan INT,
    @ten_dang_nhap NVARCHAR(100),
    @mat_khau NVARCHAR(255),
    @ho_ten NVARCHAR(200),
    @email NVARCHAR(100) = NULL,
    @vai_tro NVARCHAR(50) = 'User',
    @trang_thai BIT = 1,
    @nguoi_cap_nhat NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaiKhoan 
    SET TenDangNhap = @ten_dang_nhap, MatKhau = @mat_khau, HoTen = @ho_ten, 
        Email = @email, VaiTro = @vai_tro, TrangThai = @trang_thai, 
        NgayCapNhat = GETDATE(), NguoiCapNhat = @nguoi_cap_nhat
    WHERE MaTaiKhoan = @ma_tai_khoan AND IsDeleted = 0;
END
GO

CREATE OR ALTER PROCEDURE sp_taikhoan_changepassword
    @ma_tai_khoan INT,
    @mat_khau_moi NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaiKhoan 
    SET MatKhau = @mat_khau_moi, NgayCapNhat = GETDATE()
    WHERE MaTaiKhoan = @ma_tai_khoan AND IsDeleted = 0;
END
GO

PRINT 'Đã tạo xong tất cả stored procedures!';

-- =============================================
-- 4. SEED DATA
-- =============================================
GO

-- Tạo tài khoản admin
IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE TenDangNhap = 'admin')
BEGIN
    INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, Email, VaiTro, NguoiTao)
    VALUES ('admin', '$2a$11$rQZ8K9vL8mN3pQ2sT5uVwOeR7yA1bC4dF6gH9iJ2kL5mN8pQ1sT4vW7yZ', 'Quản trị viên', 'admin@kytucxa.edu.vn', 'Admin', 'System');
END

-- Tạo tài khoản user
IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE TenDangNhap = 'user')
BEGIN
    INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, Email, VaiTro, NguoiTao)
    VALUES ('user', '$2a$11$rQZ8K9vL8mN3pQ2sT5uVwOeR7yA1bC4dF6gH9iJ2kL5mN8pQ1sT4vW7yZ', 'Người dùng', 'user@kytucxa.edu.vn', 'User', 'System');
END

-- Tạo tòa nhà mẫu
IF NOT EXISTS (SELECT 1 FROM ToaNha WHERE TenToaNha = 'Tòa A')
BEGIN
    INSERT INTO ToaNha (TenToaNha, DiaChi, SoTang, MoTa, TrangThai, NguoiTao)
    VALUES ('Tòa A', '123 Đường ABC, Quận 1, TP.HCM', 5, 'Tòa nhà chính', 1, 'System');
END

IF NOT EXISTS (SELECT 1 FROM ToaNha WHERE TenToaNha = 'Tòa B')
BEGIN
    INSERT INTO ToaNha (TenToaNha, DiaChi, SoTang, MoTa, TrangThai, NguoiTao)
    VALUES ('Tòa B', '456 Đường XYZ, Quận 2, TP.HCM', 6, 'Tòa nhà phụ', 1, 'System');
END

-- Tạo phòng mẫu
DECLARE @MaToaA INT = (SELECT MaToaNha FROM ToaNha WHERE TenToaNha = 'Tòa A');
DECLARE @MaToaB INT = (SELECT MaToaNha FROM ToaNha WHERE TenToaNha = 'Tòa B');

IF NOT EXISTS (SELECT 1 FROM Phong WHERE SoPhong = 'A101')
BEGIN
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, NguoiTao)
    VALUES (@MaToaA, 'A101', 4, '4 người', 1500000, 'Phòng 4 giường, có điều hòa', 'Trống', 'System');
END

IF NOT EXISTS (SELECT 1 FROM Phong WHERE SoPhong = 'A102')
BEGIN
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, NguoiTao)
    VALUES (@MaToaA, 'A102', 4, '4 người', 1500000, 'Phòng 4 giường, có điều hòa', 'Trống', 'System');
END

IF NOT EXISTS (SELECT 1 FROM Phong WHERE SoPhong = 'B101')
BEGIN
    INSERT INTO Phong (MaToaNha, SoPhong, SoGiuong, LoaiPhong, GiaPhong, MoTa, TrangThai, NguoiTao)
    VALUES (@MaToaB, 'B101', 2, '2 người', 2000000, 'Phòng 2 giường, cao cấp', 'Trống', 'System');
END

-- Tạo giường mẫu
DECLARE @MaPhongA101 INT = (SELECT MaPhong FROM Phong WHERE SoPhong = 'A101');
DECLARE @MaPhongA102 INT = (SELECT MaPhong FROM Phong WHERE SoPhong = 'A102');
DECLARE @MaPhongB101 INT = (SELECT MaPhong FROM Phong WHERE SoPhong = 'B101');

-- Giường cho phòng A101
INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA101, '1', 'Trống', 'Giường số 1', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA101 AND SoGiuong = '1');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA101, '2', 'Trống', 'Giường số 2', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA101 AND SoGiuong = '2');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA101, '3', 'Trống', 'Giường số 3', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA101 AND SoGiuong = '3');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA101, '4', 'Trống', 'Giường số 4', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA101 AND SoGiuong = '4');

-- Giường cho phòng A102
INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA102, '1', 'Trống', 'Giường số 1', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA102 AND SoGiuong = '1');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA102, '2', 'Trống', 'Giường số 2', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA102 AND SoGiuong = '2');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA102, '3', 'Trống', 'Giường số 3', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA102 AND SoGiuong = '3');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongA102, '4', 'Trống', 'Giường số 4', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongA102 AND SoGiuong = '4');

-- Giường cho phòng B101
INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongB101, '1', 'Trống', 'Giường số 1', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongB101 AND SoGiuong = '1');

INSERT INTO Giuong (MaPhong, SoGiuong, TrangThai, GhiChu, NguoiTao)
SELECT @MaPhongB101, '2', 'Trống', 'Giường số 2', 'System'
WHERE NOT EXISTS (SELECT 1 FROM Giuong WHERE MaPhong = @MaPhongB101 AND SoGiuong = '2');

-- Tạo sinh viên mẫu
IF NOT EXISTS (SELECT 1 FROM SinhVien WHERE MSSV = 'SV001')
BEGIN
    INSERT INTO SinhVien (HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, MaPhong, NguoiTao)
    VALUES ('Nguyễn Văn A', 'SV001', 'CNTT01', 'Công nghệ thông tin', '2000-01-15', 'Nam', '0123456789', 'nguyenvana@email.com', 'TP.HCM', @MaPhongA101, 'System');
END

IF NOT EXISTS (SELECT 1 FROM SinhVien WHERE MSSV = 'SV002')
BEGIN
    INSERT INTO SinhVien (HoTen, MSSV, Lop, Khoa, NgaySinh, GioiTinh, SDT, Email, DiaChi, MaPhong, NguoiTao)
    VALUES ('Trần Thị B', 'SV002', 'CNTT02', 'Công nghệ thông tin', '2000-03-20', 'Nữ', '0987654321', 'tranthib@email.com', 'Hà Nội', @MaPhongA102, 'System');
END

PRINT 'Đã tạo xong dữ liệu mẫu!';
PRINT 'Database QuanLyKyTucXa đã được thiết lập hoàn chỉnh!';
PRINT 'Tài khoản mặc định:';
PRINT '  - Admin: admin / admin123';
PRINT '  - User: user / user123';