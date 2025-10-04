# Quản Lý Ký Túc Xá API - 3-Layer Architecture

## 🎯 Tổng quan

Dự án được xây dựng theo kiến trúc 3-layer giống như bài mẫu BanOto, với các tính năng:
- ✅ JWT Authentication đầy đủ
- ✅ Swagger UI với JWT support
- ✅ Database schema và stored procedures
- ✅ Business logic validation
- ✅ Error handling
- ✅ CORS configuration

## 📁 Cấu trúc dự án

### 1. Model Layer
- Chứa các entity models (SinhVienModel, PhongModel, ToaNhaModel, etc.)
- Chứa các model hỗ trợ (ResponseModel, AuthenticateModel, AppSettings)

### 2. DAL Layer (Data Access Layer)
- **DatabaseHelper**: Quản lý kết nối database và thực thi stored procedures
- **Repository Pattern**: Các repository classes thực hiện CRUD operations
- **Interfaces**: Định nghĩa contracts cho các repository

### 3. BLL Layer (Business Logic Layer)
- **Business Classes**: Chứa business logic và validation
- **Interfaces**: Định nghĩa contracts cho các business classes

### 4. API Layer
- **Controllers**: Xử lý HTTP requests và responses
- **Program.cs**: Cấu hình dependency injection và middleware

## 🚀 Cài đặt và chạy

### Yêu cầu
- .NET 9.0 SDK
- SQL Server (hoặc SQL Server Express)
- Visual Studio 2022 hoặc VS Code

### Cấu hình Database
1. **Tạo database**: Chạy file `Database/01_CreateDatabase.sql`
2. **Tạo tables**: Chạy file `Database/02_CreateTables.sql`
3. **Tạo stored procedures**: Chạy các file từ `03_` đến `09_` trong thư mục Database
4. **Thêm dữ liệu mẫu**: Chạy file `Database/10_SeedData.sql`
5. **Cập nhật connection string** trong `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=YOUR_SERVER;Database=QuanLyKyTucXa;Trusted_Connection=true;TrustServerCertificate=true;"
  }
}
```

### Chạy ứng dụng
```bash
dotnet run
```

API sẽ chạy tại: `https://localhost:7000` hoặc `http://localhost:5000`

### Swagger UI
Truy cập: `https://localhost:7000` để mở Swagger UI với JWT authentication support

## 📋 Database Schema

### Tables
- **ToaNha**: Quản lý tòa nhà
- **Phong**: Quản lý phòng trong tòa nhà
- **Giuong**: Quản lý giường trong phòng
- **SinhVien**: Quản lý thông tin sinh viên
- **HopDong**: Quản lý hợp đồng thuê phòng
- **HoaDon**: Quản lý hóa đơn thanh toán
- **TaiKhoan**: Quản lý tài khoản đăng nhập

### Stored Procedures

#### SinhVien
- `sp_sinhvien_create`
- `sp_sinhvien_update`
- `sp_sinhvien_delete`
- `sp_sinhvien_getbyid`
- `sp_sinhvien_getall`
- `sp_sinhvien_getbyphong`

#### Phong
- `sp_phong_create`
- `sp_phong_update`
- `sp_phong_delete`
- `sp_phong_getbyid`
- `sp_phong_getall`
- `sp_phong_getbytoanha`

#### ToaNha
- `sp_toanha_create`
- `sp_toanha_update`
- `sp_toanha_delete`
- `sp_toanha_getbyid`
- `sp_toanha_getall`

#### HopDong
- `sp_hopdong_create`
- `sp_hopdong_update`
- `sp_hopdong_delete`
- `sp_hopdong_getbyid`
- `sp_hopdong_getall`
- `sp_hopdong_getbysinhvien`

#### HoaDon
- `sp_hoadon_create`
- `sp_hoadon_update`
- `sp_hoadon_delete`
- `sp_hoadon_getbyid`
- `sp_hoadon_getall`
- `sp_hoadon_getbysinhvien`

#### Giuong
- `sp_giuong_create`
- `sp_giuong_update`
- `sp_giuong_delete`
- `sp_giuong_getbyid`
- `sp_giuong_getall`
- `sp_giuong_getbyphong`

### Chạy ứng dụng
```bash
dotnet run
```

API sẽ chạy tại: `https://localhost:7000` hoặc `http://localhost:5000`

## 🔐 Authentication

### Login
```http
POST /api/auth/login
{
  "tenDangNhap": "admin",
  "matKhau": "admin123"
}
```

### Register
```http
POST /api/auth/register
{
  "tenDangNhap": "newuser",
  "matKhau": "password123",
  "hoTen": "Người dùng mới",
  "email": "newuser@email.com",
  "vaiTro": "User"
}
```

**Lưu ý:** Tất cả API khác đều cần JWT token trong header:
```
Authorization: Bearer YOUR_JWT_TOKEN
```

## 📡 API Endpoints

### 🔑 Auth
- `POST /api/auth/login` - Đăng nhập
- `POST /api/auth/register` - Đăng ký tài khoản
- `POST /api/auth/changepassword` - Đổi mật khẩu (cần auth)
- `GET /api/auth/profile` - Lấy thông tin profile (cần auth)

### 👨‍🎓 SinhVien
- `POST /api/sinhvien/create` - Tạo sinh viên mới (cần auth)
- `PUT /api/sinhvien/update` - Cập nhật sinh viên (cần auth)
- `DELETE /api/sinhvien/delete/{id}` - Xóa sinh viên (cần auth)
- `GET /api/sinhvien/getbyid/{id}` - Lấy thông tin sinh viên theo ID (cần auth)
- `GET /api/sinhvien/getall` - Lấy danh sách tất cả sinh viên (cần auth)
- `GET /api/sinhvien/getbyphong/{id}` - Lấy danh sách sinh viên theo phòng (cần auth)

### Phong
- `POST /api/phong/create` - Tạo phòng mới
- `PUT /api/phong/update` - Cập nhật phòng
- `DELETE /api/phong/delete/{id}` - Xóa phòng
- `GET /api/phong/getbyid/{id}` - Lấy thông tin phòng theo ID
- `GET /api/phong/getall` - Lấy danh sách tất cả phòng
- `GET /api/phong/getbytoanha/{id}` - Lấy danh sách phòng theo tòa nhà

### ToaNha
- `POST /api/toanha/create` - Tạo tòa nhà mới
- `PUT /api/toanha/update` - Cập nhật tòa nhà
- `DELETE /api/toanha/delete/{id}` - Xóa tòa nhà
- `GET /api/toanha/getbyid/{id}` - Lấy thông tin tòa nhà theo ID
- `GET /api/toanha/getall` - Lấy danh sách tất cả tòa nhà

### HopDong
- `POST /api/hopdong/create` - Tạo hợp đồng mới
- `PUT /api/hopdong/update` - Cập nhật hợp đồng
- `DELETE /api/hopdong/delete/{id}` - Xóa hợp đồng
- `GET /api/hopdong/getbyid/{id}` - Lấy thông tin hợp đồng theo ID
- `GET /api/hopdong/getall` - Lấy danh sách tất cả hợp đồng
- `GET /api/hopdong/getbysinhvien/{id}` - Lấy danh sách hợp đồng theo sinh viên

### HoaDon
- `POST /api/hoadon/create` - Tạo hóa đơn mới
- `PUT /api/hoadon/update` - Cập nhật hóa đơn
- `DELETE /api/hoadon/delete/{id}` - Xóa hóa đơn
- `GET /api/hoadon/getbyid/{id}` - Lấy thông tin hóa đơn theo ID
- `GET /api/hoadon/getall` - Lấy danh sách tất cả hóa đơn
- `GET /api/hoadon/getbysinhvien/{id}` - Lấy danh sách hóa đơn theo sinh viên

### Giuong
- `POST /api/giuong/create` - Tạo giường mới
- `PUT /api/giuong/update` - Cập nhật giường
- `DELETE /api/giuong/delete/{id}` - Xóa giường
- `GET /api/giuong/getbyid/{id}` - Lấy thông tin giường theo ID
- `GET /api/giuong/getall` - Lấy danh sách tất cả giường
- `GET /api/giuong/getbyphong/{id}` - Lấy danh sách giường theo phòng

## Response Format

Tất cả API endpoints đều trả về response theo format:

```json
{
  "success": true,
  "message": "Thông báo",
  "data": "Dữ liệu trả về"
}
```

## 🧪 Testing

Xem file `API_Testing_Guide.md` để có hướng dẫn chi tiết về cách test API.

### Dữ liệu mẫu
Sau khi chạy seed data, bạn sẽ có:
- **Tài khoản admin**: `admin` / `admin123`
- **Tài khoản user**: `user` / `user123`
- **2 tòa nhà**: Tòa A, Tòa B
- **3 phòng**: A101, A102, B101
- **10 giường**
- **2 sinh viên mẫu**

## 📝 Lưu ý

- ✅ Dự án sử dụng SQL Server với stored procedures
- ✅ JWT Authentication đã được implement đầy đủ
- ✅ Swagger UI với JWT support
- ✅ Business logic validation được thực hiện trong BLL layer
- ✅ Error handling và response format thống nhất
- ✅ CORS đã được cấu hình cho tất cả origins

## 🔧 Troubleshooting

### Lỗi thường gặp:
1. **Connection String Error**: Kiểm tra SQL Server và connection string
2. **JWT Token Error**: Kiểm tra secret key và token expiry
3. **Stored Procedure Not Found**: Chạy lại các file SQL
4. **CORS Error**: API đã cấu hình CORS, kiểm tra browser console

## 📚 Tài liệu tham khảo

- [API Testing Guide](API_Testing_Guide.md) - Hướng dẫn test API chi tiết
- [Database Schema](Database/) - Các file SQL để tạo database