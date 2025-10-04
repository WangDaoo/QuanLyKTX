# Hướng dẫn nhanh chạy backend Quản Lý KTX

## 1) Yêu cầu
- .NET 8 SDK
- SQL Server (khuyến nghị `WINDOWS-PC\\SQLEXPRESS`) + SSMS

## 2) Tạo CSDL
- Mở SSMS → Connect tới `WINDOWS-PC\\SQLEXPRESS` → New Query → chạy file:
  - `QuanLyKTX(Cấu trúc gateway)/Database/CSDL_GENERATED.sql`
- Hoặc PowerShell:
```powershell
sqlcmd -S WINDOWS-PC\SQLEXPRESS -E -i "QuanLyKTX(Cấu trúc gateway)\Database\CSDL_GENERATED.sql"
```
- Database tạo: `QuanLyKyTucXa`
- Tài khoản seed: `admin/admin@123`, `officer/officer@123`, `student/student@123`

## 3) Cấu hình kết nối (đã sẵn)
- `KTX-Admin/appsettings.json`
- `KTX-NguoiDung/appsettings.json`
```json
{
  "ConnectionStrings": {
    "KTX": "Server=WINDOWS-PC\\SQLEXPRESS;Database=QuanLyKyTucXa;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=True"
  }
}
```

## 4) Khởi động dịch vụ (mỗi lệnh ở một cửa sổ PowerShell)
```powershell
# Admin API (8001)
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Admin\KTX-Admin"; dotnet run -c Release
# User API (8002)
cd "QuanLyKTX(Cấu trúc gateway)\KTX-NguoiDung\KTX-NguoiDung"; dotnet run -c Release
# Gateway (8000)
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Gateway\KTX-Gateway"; dotnet run -c Release
```

## 5) Swagger
- Gateway (tổng hợp): `http://localhost:8000/swagger`
- Admin: `http://localhost:8001/swagger`
- User: `http://localhost:8002/swagger`
- Redirect tiện dụng: `/` → `/admin/swagger`

## 6) Đăng nhập & gọi API
- Đăng nhập (qua Gateway):
  - POST `http://localhost:8000/auth/token`
  - JSON:
```json
{ "username": "admin", "password": "admin@123" }
```
- Dùng JWT:
  - Header: `Authorization: Bearer <token>`

## 7) Bộ Postman
- Import 2 file trong thư mục `Postman/`:
  - `QuanLyKTX.postman_collection.json`
  - `QuanLyKTX.postman_environment.json`
- Chọn env "QuanLyKTX Local"
- Chạy request "Login (Gateway) - POST /auth/token" → các request khác tự gắn `{{token}}`

## 8) Lỗi thường gặp
- SQL Error 40: bật dịch vụ `SQL Server (SQLEXPRESS)` và `SQL Server Browser`; bật TCP/IP (port 1433) trong SQL Server Configuration Manager; mở firewall TCP 1433.
- Port bận: đang dùng 8000/8001/8002 → tắt tiến trình cũ (`taskkill /F /IM KTX-*.exe`) hoặc đổi port trong `launchSettings.json`.
- JWT key: đảm bảo `AppSettings:Secret` ≥ 32 ký tự ở Gateway/Admin/User.

## 9) Tài liệu API chi tiết
- Xem `API_DOCUMENTATION.md` để có mô tả đầy đủ tất cả endpoints và JSON mẫu.
