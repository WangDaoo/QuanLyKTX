/*
  CSDL_GENERATED.sql
  Sinh từ Models và AppDbContext của KTX-Admin (.NET 8)
  Database mục tiêu: QuanLyKyTucXa
*/

IF DB_ID('QuanLyKyTucXa') IS NULL
BEGIN
  CREATE DATABASE QuanLyKyTucXa;
END
GO

USE QuanLyKyTucXa;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

/* Bảng: ToaNha */
IF OBJECT_ID('dbo.ToaNha','U') IS NULL
BEGIN
  CREATE TABLE dbo.ToaNha (
    MaToaNha     INT IDENTITY(1,1) PRIMARY KEY,
    TenToaNha    NVARCHAR(200) NOT NULL,
    DiaChi       NVARCHAR(255) NULL,
    SoTang       INT NULL,
    MoTa         NVARCHAR(1000) NULL,
    TrangThai    BIT NOT NULL DEFAULT(1),
    IsDeleted    BIT NOT NULL DEFAULT(0)
  );
END
GO

/* Bảng: Phong */
IF OBJECT_ID('dbo.Phong','U') IS NULL
BEGIN
  CREATE TABLE dbo.Phong (
    MaPhong      INT IDENTITY(1,1) PRIMARY KEY,
    MaToaNha     INT NOT NULL,
    SoPhong      NVARCHAR(20) NOT NULL,
    SoGiuong     INT NOT NULL,
    LoaiPhong    NVARCHAR(50) NOT NULL,
    GiaPhong     DECIMAL(18,2) NOT NULL,
    MoTa         NVARCHAR(1000) NULL,
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'Trống'),
    IsDeleted    BIT NOT NULL DEFAULT(0),
    CONSTRAINT FK_Phong_ToaNha FOREIGN KEY (MaToaNha) REFERENCES dbo.ToaNha(MaToaNha)
  );
END
GO

/* Bảng: Giuong */
IF OBJECT_ID('dbo.Giuong','U') IS NULL
BEGIN
  CREATE TABLE dbo.Giuong (
    MaGiuong     INT IDENTITY(1,1) PRIMARY KEY,
    MaPhong      INT NOT NULL,
    SoGiuong     NVARCHAR(10) NOT NULL,
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'Trống'),
    GhiChu       NVARCHAR(1000) NULL,
    IsDeleted    BIT NOT NULL DEFAULT(0),
    CONSTRAINT FK_Giuong_Phong FOREIGN KEY (MaPhong) REFERENCES dbo.Phong(MaPhong)
  );
END
GO

/* Bảng: MucPhi */
IF OBJECT_ID('dbo.MucPhi','U') IS NULL
BEGIN
  CREATE TABLE dbo.MucPhi (
    MaMucPhi     INT IDENTITY(1,1) PRIMARY KEY,
    TenMucPhi    NVARCHAR(200) NOT NULL,
    LoaiMucPhi   NVARCHAR(100) NULL,
    DonGia       DECIMAL(18,2) NOT NULL DEFAULT(0),
    DonViTinh    NVARCHAR(50) NULL,
    HieuLucTu    DATETIME NULL,
    HieuLucDen   DATETIME NULL,
    TrangThai    BIT NOT NULL DEFAULT(1),
    IsDeleted    BIT NOT NULL DEFAULT(0)
  );
END
GO

/* Bảng: BacGia */
IF OBJECT_ID('dbo.BacGia','U') IS NULL
BEGIN
  CREATE TABLE dbo.BacGia (
    MaBac        INT IDENTITY(1,1) PRIMARY KEY,
    Loai         NVARCHAR(20) NOT NULL, -- Dien/Nuoc
    ThuTu        INT NOT NULL,
    TuSo         INT NULL,
    DenSo        INT NULL,
    DonGia       DECIMAL(18,2) NOT NULL,
    TrangThai    BIT NOT NULL DEFAULT(1)
  );
END
GO

/* Bảng: CauHinhPhi */
IF OBJECT_ID('dbo.CauHinhPhi','U') IS NULL
BEGIN
  CREATE TABLE dbo.CauHinhPhi (
    MaCauHinh    INT IDENTITY(1,1) PRIMARY KEY,
    Loai         NVARCHAR(20) NOT NULL, -- Dien/Nuoc
    MucToiThieu  DECIMAL(18,2) NOT NULL,
    TrangThai    BIT NOT NULL DEFAULT(1)
  );
END
GO

/* Bảng: ChiSoDienNuoc */
IF OBJECT_ID('dbo.ChiSoDienNuoc','U') IS NULL
BEGIN
  CREATE TABLE dbo.ChiSoDienNuoc (
    MaChiSo      INT IDENTITY(1,1) PRIMARY KEY,
    MaPhong      INT NOT NULL,
    Thang        INT NOT NULL,
    Nam          INT NOT NULL,
    DienCu       INT NOT NULL,
    DienMoi      INT NOT NULL,
    NuocCu       INT NOT NULL,
    NuocMoi      INT NOT NULL,
    NgayGhi      DATETIME NULL,
    GhiChu       NVARCHAR(1000) NULL,
    IsDeleted    BIT NOT NULL DEFAULT(0),
    CONSTRAINT FK_ChiSo_Phong FOREIGN KEY (MaPhong) REFERENCES dbo.Phong(MaPhong)
  );
  CREATE UNIQUE INDEX UX_ChiSoDienNuoc_MaPhong_Thang_Nam
  ON dbo.ChiSoDienNuoc(MaPhong, Thang, Nam);
END
GO

/* Bảng: HopDong */
IF OBJECT_ID('dbo.HopDong','U') IS NULL
BEGIN
  CREATE TABLE dbo.HopDong (
    MaHopDong    INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    MaGiuong     INT NOT NULL,
    NgayBatDau   DATE NOT NULL,
    NgayKetThuc  DATE NOT NULL,
    GiaPhong     DECIMAL(18,2) NOT NULL,
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'Chờ duyệt'),
    GhiChu       NVARCHAR(1000) NULL
  );
END
GO

/* Bảng: HoaDon */
IF OBJECT_ID('dbo.HoaDon','U') IS NULL
BEGIN
  CREATE TABLE dbo.HoaDon (
    MaHoaDon     INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    MaPhong      INT NULL,
    MaHopDong    INT NULL,
    Thang        INT NOT NULL,
    Nam          INT NOT NULL,
    TongTien     DECIMAL(18,2) NOT NULL DEFAULT(0),
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'Chưa thanh toán'),
    NgayHetHan   DATE NOT NULL,
    NgayThanhToan DATE NULL,
    GhiChu       NVARCHAR(1000) NULL,
    IsDeleted    BIT NOT NULL DEFAULT(0)
  );
END
GO

/* Bảng: BienLaiThu */
IF OBJECT_ID('dbo.BienLaiThu','U') IS NULL
BEGIN
  CREATE TABLE dbo.BienLaiThu (
    MaBienLai    INT IDENTITY(1,1) PRIMARY KEY,
    MaHoaDon     INT NOT NULL,
    SoTienThu    DECIMAL(18,2) NOT NULL,
    NgayThu      DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    NguoiThu     NVARCHAR(200) NULL,
    GhiChu       NVARCHAR(1000) NULL
  );
END
GO

/* Bảng: ThongBaoQuaHan */
IF OBJECT_ID('dbo.ThongBaoQuaHan','U') IS NULL
BEGIN
  CREATE TABLE dbo.ThongBaoQuaHan (
    MaThongBao   INT IDENTITY(1,1) PRIMARY KEY,
    MaHoaDon     INT NOT NULL,
    NgayHetHan   DATE NOT NULL,
    NgayThongBao DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    HinhThuc     NVARCHAR(200) NULL,
    NoiDung      NVARCHAR(2000) NULL
  );
END
GO

/* Bảng: KyLuat */
IF OBJECT_ID('dbo.KyLuat','U') IS NULL
BEGIN
  CREATE TABLE dbo.KyLuat (
    MaKyLuat     INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    HanhVi       NVARCHAR(500) NOT NULL,
    HinhThucXuLy NVARCHAR(500) NULL,
    NgayViPham   DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    GhiChu       NVARCHAR(1000) NULL
  );
END
GO

/* Bảng: DiemRenLuyen */
IF OBJECT_ID('dbo.DiemRenLuyen','U') IS NULL
BEGIN
  CREATE TABLE dbo.DiemRenLuyen (
    MaDiem       INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    Thang        INT NOT NULL,
    Nam          INT NOT NULL,
    Diem         INT NOT NULL,
    GhiChu       NVARCHAR(1000) NULL
  );
  CREATE UNIQUE INDEX UX_DiemRenLuyen_MaSV_Thang_Nam
  ON dbo.DiemRenLuyen(MaSinhVien, Thang, Nam);
END
GO

/* Bảng: DonDangKy */
IF OBJECT_ID('dbo.DonDangKy','U') IS NULL
BEGIN
  CREATE TABLE dbo.DonDangKy (
    MaDon        INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    MaPhongDeXuat INT NULL,
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'ChoDuyet'),
    LyDo         NVARCHAR(1000) NULL,
    NgayTao      DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    NgayCapNhat  DATETIME NULL
  );
END
GO

/* Bảng: YeuCauChuyenPhong */
IF OBJECT_ID('dbo.YeuCauChuyenPhong','U') IS NULL
BEGIN
  CREATE TABLE dbo.YeuCauChuyenPhong (
    MaYeuCau     INT IDENTITY(1,1) PRIMARY KEY,
    MaSinhVien   INT NOT NULL,
    MaPhongCu    INT NOT NULL,
    MaPhongMoi   INT NOT NULL,
    TrangThai    NVARCHAR(50) NOT NULL DEFAULT(N'ChoDuyet'),
    LyDo         NVARCHAR(1000) NULL,
    NgayTao      DATETIME NOT NULL DEFAULT(GETUTCDATE()),
    NgayCapNhat  DATETIME NULL
  );
END
GO

/* Gợi ý thêm FK (tuỳ schema thực tế của bảng SinhVien):
   - HoaDon.MaSinhVien, KyLuat.MaSinhVien, DiemRenLuyen.MaSinhVien, HopDong.MaSinhVien, DonDangKy.MaSinhVien, YeuCauChuyenPhong.MaSinhVien
   - Khi có bảng SinhVien, thêm FOREIGN KEY tương ứng. */

PRINT N'Hoàn tất tạo CSDL theo mô hình hiện tại.';
GO

/* Bảng tài khoản và seed admin mặc định (phục vụ RBAC) */
IF OBJECT_ID('dbo.TaiKhoan','U') IS NULL
BEGIN
  CREATE TABLE dbo.TaiKhoan (
    MaTaiKhoan   INT IDENTITY(1,1) PRIMARY KEY,
    Username     NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role         NVARCHAR(50)  NOT NULL,  -- Admin/Officer/Student
    MaSinhVien   INT NULL,
    TrangThai    BIT NOT NULL DEFAULT(1),
    NgayTao      DATETIME NOT NULL DEFAULT(GETUTCDATE())
  );
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TaiKhoan WHERE Username = N'admin')
BEGIN
  INSERT INTO dbo.TaiKhoan(Username, PasswordHash, Role)
  VALUES (N'admin', N'admin@123', N'Admin');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TaiKhoan WHERE Username = N'officer')
BEGIN
  INSERT INTO dbo.TaiKhoan(Username, PasswordHash, Role)
  VALUES (N'officer', N'officer@123', N'Officer');
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.TaiKhoan WHERE Username = N'student')
BEGIN
  INSERT INTO dbo.TaiKhoan(Username, PasswordHash, Role, MaSinhVien)
  VALUES (N'student', N'student@123', N'Student', NULL);
END
GO


