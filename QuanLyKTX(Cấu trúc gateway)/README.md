# QuanLyKTX (Kiến trúc Gateway)

Hệ thống Quản lý Ký túc xá theo kiến trúc API Gateway (dựa theo “Gateway 2”), gồm Gateway điều phối, Admin API (quản trị) và User API (sinh viên). Đã hoàn thiện xác thực JWT, RBAC, CRUD danh mục, nghiệp vụ hợp đồng – tính phí (bậc/ tối thiểu), thu phí – công nợ – quá hạn, kỷ luật, báo cáo, và Swagger tổng hợp qua Ocelot.

## Mục lục
- Kiến trúc & cổng dịch vụ
- Yêu cầu hệ thống
- Cài đặt CSDL và kết nối SQL Server
- Cấu hình ứng dụng (JWT, CORS, Ocelot)
- Khởi động dịch vụ
- Xác thực & Phân quyền (JWT/RBAC)
- Nhóm API & JSON mẫu trả về
- Swagger & Gateway
- Ví dụ gọi API (curl/Postman)
- Xử lý sự cố thường gặp

## Kiến trúc & cổng dịch vụ
```
QuanLyKTX(Cấu trúc gateway)/
  KTX-Gateway/        # API Gateway (Ocelot + Swagger For Ocelot)
  KTX-Admin/          # Dịch vụ quản trị (Admin/Officer)
  KTX-NguoiDung/      # Dịch vụ sinh viên (Student)
  Database/           # Script SQL (CSDL_GENERATED.sql)
  admin/              # Trang login demo (tùy chọn)
```

- Cổng chạy (đã chuẩn hóa để tránh xung đột):
  - Gateway: http://localhost:8000
  - Admin API: http://localhost:8001
  - User API: http://localhost:8002

## Yêu cầu hệ thống
- .NET 8 SDK
- SQL Server (khuyến nghị SQLEXPRESS) và SSMS
- PowerShell/Command Prompt

## Cài đặt CSDL và kết nối SQL Server
1) Kết nối đến instance: `WINDOWS-PC\SQLEXPRESS`
2) Tạo CSDL và bảng:
   - Mở SSMS → New Query → chạy file: `QuanLyKTX(Cấu trúc gateway)/Database/CSDL_GENERATED.sql`
   - Hoặc PowerShell:
     ```powershell
     sqlcmd -S WINDOWS-PC\SQLEXPRESS -E -i "QuanLyKTX(Cấu trúc gateway)\Database\CSDL_GENERATED.sql"
     ```
3) Connection string (đã cấu hình sẵn):
   - `KTX-Admin/appsettings.json`
   - `KTX-NguoiDung/appsettings.json`
   ```json
   {
     "ConnectionStrings": {
       "KTX": "Server=WINDOWS-PC\\SQLEXPRESS;Database=QuanLyKyTucXa;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=True"
     }
   }
   ```
4) Tài khoản seed trong bảng `TaiKhoan`:
   - admin/admin@123 (Admin)
   - officer/officer@123 (Officer)
   - student/student@123 (Student)

## Cấu hình ứng dụng
- JWT secret: `AppSettings:Secret` đồng bộ ở Gateway/Admin/User (đủ 32 ký tự+). Token ký bằng HMAC SHA256.
- CORS: mở theo `AllowAll` cho phát triển.
- Ocelot (Gateway): định tuyến `/admin/*`, `/user/*`, `/auth/*` đến Admin/User; tích hợp Swagger For Ocelot để hợp nhất tài liệu.

## Khởi động dịch vụ
Khuyến nghị chạy mỗi service ở 1 cửa sổ PowerShell riêng:
```powershell
# Admin API
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Admin\KTX-Admin"; dotnet run -c Release

# User API
cd "QuanLyKTX(Cấu trúc gateway)\KTX-NguoiDung\KTX-NguoiDung"; dotnet run -c Release

# Gateway
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Gateway\KTX-Gateway"; dotnet run -c Release
```
Mặc định đã tắt auto-launch browser; có thể mở Swagger thủ công như dưới.

## Xác thực & Phân quyền
- Đăng nhập lấy JWT (qua Gateway):
  - POST `http://localhost:8000/auth/token`
  - Body:
    ```json
    { "username": "admin", "password": "admin@123" }
    ```
- Dùng token:
  - Header: `Authorization: Bearer <jwt>`
- Vai trò:
  - Admin: toàn quyền cấu hình/phiếu thu/báo cáo
  - Officer: vận hành: phòng/giường, hợp đồng, chỉ số, thu phí, báo cáo
  - Student: tra cứu thông tin cá nhân, hóa đơn, đăng ký/chuyển phòng

## Nhóm API & JSON mẫu
Chi tiết đầy đủ xem file `API_DOCUMENTATION.md`. Tóm tắt chính:
- Danh mục (Admin): Tòa nhà (`/api/buildings`), Phòng (`/api/rooms`), Giường (`/api/beds`), Mức phí (`/api/fees`), Bậc giá (`/api/price-tiers`)
- Chỉ số điện nước (Admin): `/api/meter-readings`, import Excel `/api/meter-readings/import-excel`
- Hợp đồng (Admin/User): `/api/contracts`
- Hóa đơn – Thu phí – Quá hạn (Admin/Officer): `/api/bills`, `/api/receipts`, `/api/overdue-notices`, tính tháng `/api/bills/calculate-monthly`
- Kỷ luật – Điểm rèn luyện (Admin/Officer): `/api/violations`, `/api/discipline-scores`
- Đăng ký – Chuyển phòng (Admin/User): `/api/registrations`, `/api/change-requests`

Ví dụ JSON trả về (rút gọn):
```json
{
  "maHoaDon": 1,
  "thang": 9,
  "nam": 2025,
  "tongTien": 650000,
  "trangThai": "Chưa thanh toán"
}
```

## Swagger & Gateway
- Admin Swagger: http://localhost:8001/swagger
- User Swagger: http://localhost:8002/swagger
- Gateway Swagger tổng hợp: http://localhost:8000/swagger
- Redirect tiện dụng:
  - `/` → `/admin/swagger`
  - `/admin` → `/admin/swagger`; `/user` → `/user/swagger`

## Ví dụ gọi API (qua Gateway)
```bash
# Lấy token
curl -s -X POST http://localhost:8000/auth/token \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin@123"}' | jq

# Danh sách phòng (Admin)
curl -s -H "Authorization: Bearer $TOKEN" \
  http://localhost:8000/admin/api/rooms | jq

# Tính hóa đơn tháng
curl -s -X POST -H "Authorization: Bearer $TOKEN" \
  "http://localhost:8000/admin/api/bills/calculate-monthly" \
  -H "Content-Type: application/json" -d '{"thang":9,"nam":2025}' | jq
```

## Xử lý sự cố
- Port đang bận: đổi port trong `launchSettings.json` (đang dùng 8000/8001/8002) hoặc dừng process chiếm port (`netstat -ano`, `taskkill /F /PID <pid>`)
- Lỗi SQL Error 40 (không kết nối được SQL):
  - Đảm bảo dịch vụ `SQL Server (SQLEXPRESS)` và `SQL Server Browser` đang chạy
  - Bật TCP/IP trong SQL Server Configuration Manager, IPAll: TCP Port=1433
  - Tường lửa mở TCP 1433
  - Connection string khớp instance `WINDOWS-PC\SQLEXPRESS`
- JWT key không đủ 256-bit: dùng secret ≥ 32 ký tự và đã băm SHA256 trong AuthController

## Giấy phép
MIT (cập nhật theo yêu cầu dự án)
