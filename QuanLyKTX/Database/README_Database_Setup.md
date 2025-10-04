# Hướng dẫn thiết lập Database cho Quản lý Ký túc xá

## Tổng quan
Hệ thống sử dụng SQL Server với stored procedures để quản lý dữ liệu. Các file SQL đã được tách thành nhiều file nhỏ để dễ quản lý.

## Thứ tự thực thi các file SQL

### 1. File chính - Complete_Database_Setup.sql
**Mục đích**: Tạo database, bảng và stored procedures cơ bản
**Nội dung**:
- Tạo database `QuanLyKyTucXa`
- Tạo tất cả các bảng (ToaNha, Phong, Giuong, SinhVien, HopDong, HoaDon, TaiKhoan)
- Stored procedures cho ToaNha và Phong
- Seed data cơ bản (tài khoản admin/user, tòa nhà, phòng mẫu)

### 2. File bổ sung - Additional_StoredProcedures.sql
**Mục đích**: Thêm stored procedures cho SinhVien
**Nội dung**:
- sp_sinhvien_create
- sp_sinhvien_update
- sp_sinhvien_delete
- sp_sinhvien_getbyid
- sp_sinhvien_getall
- sp_sinhvien_getbyphong

### 3. File còn lại - Remaining_StoredProcedures.sql
**Mục đích**: Thêm stored procedures cho Giuong và HopDong
**Nội dung**:
- Stored procedures cho Giuong (create, update, delete, getbyid, getall, getbyphong)
- Stored procedures cho HopDong (create, update, delete, getbyid, getall, getbysinhvien)

### 4. File cuối - Final_StoredProcedures.sql
**Mục đích**: Thêm stored procedures cho HoaDon và TaiKhoan
**Nội dung**:
- Stored procedures cho HoaDon (create, update, delete, getbyid, getall, getbysinhvien)
- Stored procedures cho TaiKhoan (create, authenticate, getbyid, changepassword)

## Cách thực thi

### Phương pháp 1: Thực thi từng file riêng biệt
```sql
-- 1. Chạy file chính
-- Mở SQL Server Management Studio
-- Kết nối đến SQL Server
-- Mở file Complete_Database_Setup.sql và thực thi

-- 2. Chạy file bổ sung
-- Mở file Additional_StoredProcedures.sql và thực thi

-- 3. Chạy file còn lại
-- Mở file Remaining_StoredProcedures.sql và thực thi

-- 4. Chạy file cuối
-- Mở file Final_StoredProcedures.sql và thực thi
```

### Phương pháp 2: Tạo file tổng hợp (Khuyến nghị)
Nếu muốn tất cả trong một file, bạn có thể:
1. Copy nội dung từ Complete_Database_Setup.sql
2. Thêm nội dung từ Additional_StoredProcedures.sql
3. Thêm nội dung từ Remaining_StoredProcedures.sql
4. Thêm nội dung từ Final_StoredProcedures.sql
5. Lưu thành một file duy nhất và thực thi

## Kiểm tra sau khi thiết lập

### 1. Kiểm tra database
```sql
USE QuanLyKyTucXa;
SELECT name FROM sys.tables;
```

### 2. Kiểm tra stored procedures
```sql
SELECT name FROM sys.procedures WHERE name LIKE 'sp_%';
```

### 3. Kiểm tra seed data
```sql
-- Kiểm tra tài khoản
SELECT * FROM TaiKhoan;

-- Kiểm tra tòa nhà
SELECT * FROM ToaNha;

-- Kiểm tra phòng
SELECT * FROM Phong;
```

## Tài khoản mặc định

Sau khi thiết lập, hệ thống sẽ có 2 tài khoản mặc định:

### Tài khoản Admin
- **Tên đăng nhập**: admin
- **Mật khẩu**: admin123
- **Vai trò**: Admin

### Tài khoản User
- **Tên đăng nhập**: user
- **Mật khẩu**: user123
- **Vai trò**: User

## Lưu ý quan trọng

1. **Backup**: Luôn backup database trước khi thực hiện thay đổi
2. **Quyền**: Đảm bảo tài khoản SQL Server có quyền tạo database và stored procedures
3. **Connection String**: Cập nhật connection string trong appsettings.json sau khi thiết lập
4. **Mật khẩu**: Thay đổi mật khẩu mặc định trong môi trường production

## Xử lý lỗi thường gặp

### Lỗi: Database đã tồn tại
```sql
-- Xóa database cũ (nếu cần)
DROP DATABASE QuanLyKyTucXa;
```

### Lỗi: Stored procedure đã tồn tại
- Các stored procedure sử dụng `CREATE OR ALTER` nên sẽ tự động cập nhật
- Không cần xóa thủ công

### Lỗi: Quyền không đủ
- Đảm bảo tài khoản SQL Server có quyền `db_owner` hoặc `sysadmin`
- Hoặc cấp quyền cụ thể cho từng thao tác

## Kết nối từ ứng dụng

Sau khi thiết lập database, cập nhật connection string trong `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=QuanLyKyTucXa;Trusted_Connection=true;TrustServerCertificate=true;"
  }
}
```

Thay đổi `localhost` thành tên server SQL Server thực tế nếu cần.