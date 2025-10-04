# 📚 Tài Liệu API - Hệ Thống Quản Lý Ký Túc Xá

## 🏗️ Kiến Trúc Hệ Thống

Hệ thống sử dụng kiến trúc microservices với 3 services chính:

- **Gateway** (Port 8000): API Gateway với Ocelot, tích hợp Swagger
- **Admin API** (Port 8001): Quản lý toàn bộ hệ thống (Admin/Officer)
- **User API** (Port 8002): Chức năng dành cho sinh viên

## 🔐 Xác Thực & Phân Quyền

### Đăng Nhập
**Endpoint:** `POST /auth/token`

**Request Body:**
```json
{
  "username": "admin",
  "password": "admin@123"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "role": "Admin"
}
```

**Headers cho các API khác:**
```
Authorization: Bearer <token>
```

### Vai Trò Hệ Thống
- **Admin**: Toàn quyền quản lý
- **Officer**: Quản lý sinh viên, phòng, hóa đơn
- **Student**: Xem thông tin cá nhân, đăng ký phòng

---

## 🏢 ADMIN API (Port 8001)

### 1. Quản Lý Tòa Nhà

#### Lấy Danh Sách Tòa Nhà
**GET** `/api/buildings`
```json
[
  {
    "maToaNha": 1,
    "tenToaNha": "Tòa A",
    "diaChi": "123 Đường ABC",
    "soTang": 5,
    "trangThai": true,
    "ghiChu": "Tòa nam"
  }
]
```

#### Tạo Tòa Nhà Mới
**POST** `/api/buildings`
```json
{
  "tenToaNha": "Tòa B",
  "diaChi": "456 Đường XYZ",
  "soTang": 4,
  "trangThai": true,
  "ghiChu": "Tòa nữ"
}
```

#### Cập Nhật Tòa Nhà
**PUT** `/api/buildings/{id}`
```json
{
  "tenToaNha": "Tòa A - Cập nhật",
  "diaChi": "123 Đường ABC - Mới",
  "soTang": 6,
  "trangThai": true,
  "ghiChu": "Đã nâng cấp"
}
```

#### Xóa Tòa Nhà
**DELETE** `/api/buildings/{id}`

### 2. Quản Lý Phòng

#### Lấy Danh Sách Phòng
**GET** `/api/rooms`
```json
[
  {
    "maPhong": 1,
    "tenPhong": "A101",
    "maToaNha": 1,
    "soGiuong": 4,
    "loaiPhong": "Phòng 4 người",
    "trangThai": "Trống",
    "ghiChu": "Phòng tầng 1"
  }
]
```

#### Tạo Phòng Mới
**POST** `/api/rooms`
```json
{
  "tenPhong": "A102",
  "maToaNha": 1,
  "soGiuong": 4,
  "loaiPhong": "Phòng 4 người",
  "trangThai": "Trống",
  "ghiChu": "Phòng tầng 1"
}
```

### 3. Quản Lý Giường

#### Lấy Danh Sách Giường
**GET** `/api/beds`
```json
[
  {
    "maGiuong": 1,
    "tenGiuong": "Giường 1",
    "maPhong": 1,
    "trangThai": "Trống",
    "ghiChu": "Giường trên"
  }
]
```

#### Tạo Giường Mới
**POST** `/api/beds`
```json
{
  "tenGiuong": "Giường 2",
  "maPhong": 1,
  "trangThai": "Trống",
  "ghiChu": "Giường dưới"
}
```

### 4. Quản Lý Mức Phí

#### Lấy Danh Sách Mức Phí
**GET** `/api/fees`
```json
[
  {
    "maMucPhi": 1,
    "tenMucPhi": "Phí phòng 4 người",
    "loaiPhi": "Phí phòng",
    "giaTien": 500000,
    "donVi": "VND/tháng",
    "trangThai": true,
    "ghiChu": "Phí cơ bản"
  }
]
```

#### Tạo Mức Phí Mới
**POST** `/api/fees`
```json
{
  "tenMucPhi": "Phí điện",
  "loaiPhi": "Phí điện",
  "giaTien": 3500,
  "donVi": "VND/kWh",
  "trangThai": true,
  "ghiChu": "Theo bậc thang"
}
```

### 5. Quản Lý Bậc Giá

#### Lấy Danh Sách Bậc Giá
**GET** `/api/price-tiers`
```json
[
  {
    "maBacGia": 1,
    "tenBacGia": "Bậc 1",
    "tuKwh": 0,
    "denKwh": 50,
    "giaTien": 1800,
    "trangThai": true,
    "ghiChu": "Bậc cơ bản"
  }
]
```

### 6. Quản Lý Chỉ Số Điện Nước

#### Lấy Danh Sách Chỉ Số
**GET** `/api/meter-readings`
```json
[
  {
    "maChiSo": 1,
    "maPhong": 1,
    "thang": 1,
    "nam": 2024,
    "chiSoDien": 100,
    "chiSoNuoc": 50,
    "ngayGhi": "2024-01-01T00:00:00",
    "nguoiGhi": "admin",
    "trangThai": "Đã ghi"
  }
]
```

#### Ghi Chỉ Số Mới
**POST** `/api/meter-readings`
```json
{
  "maPhong": 1,
  "thang": 1,
  "nam": 2024,
  "chiSoDien": 100,
  "chiSoNuoc": 50,
  "ngayGhi": "2024-01-01T00:00:00",
  "nguoiGhi": "admin"
}
```

#### Import Excel Chỉ Số
**POST** `/api/meter-readings/import-excel`
- **Content-Type:** `multipart/form-data`
- **File:** Excel file với cột: Phòng, Tháng, Năm, Chỉ số điện, Chỉ số nước

### 7. Quản Lý Hợp Đồng

#### Lấy Danh Sách Hợp Đồng
**GET** `/api/contracts`
```json
[
  {
    "maHopDong": 1,
    "maSinhVien": 1,
    "maGiuong": 1,
    "ngayBatDau": "2024-01-01T00:00:00",
    "ngayKetThuc": "2024-12-31T00:00:00",
    "trangThai": "Có hiệu lực",
    "ghiChu": "Hợp đồng năm học 2024"
  }
]
```

#### Tạo Hợp Đồng Mới
**POST** `/api/contracts`
```json
{
  "maSinhVien": 1,
  "maGiuong": 1,
  "ngayBatDau": "2024-01-01T00:00:00",
  "ngayKetThuc": "2024-12-31T00:00:00",
  "trangThai": "Có hiệu lực",
  "ghiChu": "Hợp đồng năm học 2024"
}
```

### 8. Quản Lý Hóa Đơn

#### Lấy Danh Sách Hóa Đơn
**GET** `/api/bills`
```json
[
  {
    "maHoaDon": 1,
    "maSinhVien": 1,
    "thang": 1,
    "nam": 2024,
    "tongTien": 550000,
    "trangThai": "Chưa thanh toán",
    "ngayTao": "2024-01-01T00:00:00",
    "hanThanhToan": "2024-01-15T00:00:00"
  }
]
```

#### Tạo Hóa Đơn Mới
**POST** `/api/bills`
```json
{
  "maSinhVien": 1,
  "thang": 1,
  "nam": 2024,
  "tongTien": 550000,
  "trangThai": "Chưa thanh toán",
  "hanThanhToan": "2024-01-15T00:00:00"
}
```

#### Tính Phí Tự Động
**POST** `/api/bills/calculate-monthly`
```json
{
  "thang": 1,
  "nam": 2024
}
```

### 9. Quản Lý Biên Lai

#### Lấy Danh Sách Biên Lai
**GET** `/api/receipts`
```json
[
  {
    "maBienLai": 1,
    "maHoaDon": 1,
    "soTienThu": 550000,
    "ngayThu": "2024-01-10T00:00:00",
    "phuongThucThanhToan": "Tiền mặt",
    "nguoiThu": "admin",
    "ghiChu": "Thanh toán đầy đủ"
  }
]
```

#### Tạo Biên Lai
**POST** `/api/receipts`
```json
{
  "maHoaDon": 1,
  "soTienThu": 550000,
  "ngayThu": "2024-01-10T00:00:00",
  "phuongThucThanhToan": "Tiền mặt",
  "nguoiThu": "admin",
  "ghiChu": "Thanh toán đầy đủ"
}
```

### 10. Quản Lý Thông Báo Quá Hạn

#### Lấy Danh Sách Thông Báo
**GET** `/api/overdue-notices`
```json
[
  {
    "maThongBao": 1,
    "maSinhVien": 1,
    "maHoaDon": 1,
    "ngayThongBao": "2024-01-20T00:00:00",
    "noiDung": "Bạn đã quá hạn thanh toán 5 ngày",
    "trangThai": "Đã gửi"
  }
]
```

### 11. Quản Lý Kỷ Luật

#### Lấy Danh Sách Kỷ Luật
**GET** `/api/violations`
```json
[
  {
    "maKyLuat": 1,
    "maSinhVien": 1,
    "loaiViPham": "Vi phạm nội quy",
    "moTa": "Đi muộn sau 22h",
    "ngayViPham": "2024-01-15T00:00:00",
    "mucPhat": 50000,
    "trangThai": "Chưa xử lý"
  }
]
```

#### Tạo Kỷ Luật Mới
**POST** `/api/violations`
```json
{
  "maSinhVien": 1,
  "loaiViPham": "Vi phạm nội quy",
  "moTa": "Đi muộn sau 22h",
  "ngayViPham": "2024-01-15T00:00:00",
  "mucPhat": 50000,
  "trangThai": "Chưa xử lý"
}
```

### 12. Quản Lý Điểm Rèn Luyện

#### Lấy Danh Sách Điểm Rèn Luyện
**GET** `/api/discipline-scores`
```json
[
  {
    "maDiem": 1,
    "maSinhVien": 1,
    "thang": 1,
    "nam": 2024,
    "diemRenLuyen": 85,
    "xepLoai": "Khá",
    "ghiChu": "Có tiến bộ"
  }
]
```

### 13. Quản Lý Sinh Viên

#### Lấy Danh Sách Sinh Viên
**GET** `/api/students`
```json
[
  {
    "maSinhVien": 1,
    "hoTen": "Nguyễn Văn A",
    "ngaySinh": "2000-01-01T00:00:00",
    "gioiTinh": "Nam",
    "soDienThoai": "0123456789",
    "email": "nguyenvana@email.com",
    "lop": "CNTT01",
    "khoa": "Công nghệ thông tin",
    "trangThai": "Đang ở"
  }
]
```

#### Tạo Sinh Viên Mới
**POST** `/api/students`
```json
{
  "hoTen": "Nguyễn Văn B",
  "ngaySinh": "2001-01-01T00:00:00",
  "gioiTinh": "Nữ",
  "soDienThoai": "0987654321",
  "email": "nguyenvanb@email.com",
  "lop": "CNTT02",
  "khoa": "Công nghệ thông tin",
  "trangThai": "Chưa ở"
}
```

### 14. Quản Lý Đăng Ký

#### Lấy Danh Sách Đăng Ký
**GET** `/api/registrations`
```json
[
  {
    "maDon": 1,
    "maSinhVien": 1,
    "ngayDangKy": "2024-01-01T00:00:00",
    "trangThai": "Chờ duyệt",
    "ghiChu": "Đăng ký phòng mới"
  }
]
```

#### Duyệt Đăng Ký
**PUT** `/api/registrations/{id}/approve`
```json
{
  "trangThai": "Đã duyệt",
  "ghiChu": "Đã duyệt đăng ký"
}
```

### 15. Quản Lý Yêu Cầu Chuyển Phòng

#### Lấy Danh Sách Yêu Cầu
**GET** `/api/change-requests`
```json
[
  {
    "maYeuCau": 1,
    "maSinhVien": 1,
    "phongHienTai": 1,
    "phongMongMuon": 2,
    "lyDo": "Gần thư viện hơn",
    "ngayYeuCau": "2024-01-01T00:00:00",
    "trangThai": "Chờ duyệt"
  }
]
```

### 16. Báo Cáo

#### Báo Cáo Tỷ Lệ Lấp Đầy
**GET** `/api/reports/occupancy`
```json
{
  "tongSoPhong": 100,
  "soPhongTrong": 20,
  "soPhongDangO": 80,
  "tyLeLapDay": 80.0,
  "chiTietTheoToa": [
    {
      "maToaNha": 1,
      "tenToaNha": "Tòa A",
      "tyLeLapDay": 85.0
    }
  ]
}
```

#### Báo Cáo Doanh Thu
**GET** `/api/reports/revenue`
```json
{
  "thang": 1,
  "nam": 2024,
  "tongDoanhThu": 50000000,
  "chiTietTheoLoai": [
    {
      "loaiPhi": "Phí phòng",
      "soTien": 40000000
    },
    {
      "loaiPhi": "Phí điện",
      "soTien": 10000000
    }
  ]
}
```

#### Báo Cáo Nợ Đọng
**GET** `/api/reports/outstanding-debts`
```json
{
  "tongSoNguoiNo": 15,
  "tongSoTienNo": 2500000,
  "chiTiet": [
    {
      "maSinhVien": 1,
      "hoTen": "Nguyễn Văn A",
      "soTienNo": 500000,
      "soNgayQuaHan": 10
    }
  ]
}
```

---

## 👤 USER API (Port 8002)

### 1. Thông Tin Cá Nhân

#### Lấy Thông Tin Sinh Viên
**GET** `/api/students/profile`
```json
{
  "maSinhVien": 1,
  "hoTen": "Nguyễn Văn A",
  "ngaySinh": "2000-01-01T00:00:00",
  "gioiTinh": "Nam",
  "soDienThoai": "0123456789",
  "email": "nguyenvana@email.com",
  "lop": "CNTT01",
  "khoa": "Công nghệ thông tin",
  "trangThai": "Đang ở"
}
```

### 2. Thông Tin Phòng

#### Lấy Thông Tin Phòng Hiện Tại
**GET** `/api/rooms/current`
```json
{
  "maPhong": 1,
  "tenPhong": "A101",
  "maToaNha": 1,
  "tenToaNha": "Tòa A",
  "soGiuong": 4,
  "loaiPhong": "Phòng 4 người",
  "trangThai": "Đang ở",
  "ghiChu": "Phòng tầng 1"
}
```

### 3. Hóa Đơn Cá Nhân

#### Lấy Danh Sách Hóa Đơn
**GET** `/api/bills/my-bills`
```json
[
  {
    "maHoaDon": 1,
    "thang": 1,
    "nam": 2024,
    "tongTien": 550000,
    "trangThai": "Chưa thanh toán",
    "ngayTao": "2024-01-01T00:00:00",
    "hanThanhToan": "2024-01-15T00:00:00",
    "chiTiet": [
      {
        "loaiPhi": "Phí phòng",
        "soTien": 500000
      },
      {
        "loaiPhi": "Phí điện",
        "soTien": 50000
      }
    ]
  }
]
```

### 4. Đăng Ký Phòng

#### Tạo Đăng Ký Mới
**POST** `/api/registrations`
```json
{
  "ghiChu": "Đăng ký phòng mới"
}
```

#### Lấy Trạng Thái Đăng Ký
**GET** `/api/registrations/my-registrations`
```json
[
  {
    "maDon": 1,
    "ngayDangKy": "2024-01-01T00:00:00",
    "trangThai": "Chờ duyệt",
    "ghiChu": "Đăng ký phòng mới"
  }
]
```

### 5. Yêu Cầu Chuyển Phòng

#### Tạo Yêu Cầu Chuyển Phòng
**POST** `/api/change-requests`
```json
{
  "phongMongMuon": 2,
  "lyDo": "Gần thư viện hơn"
}
```

#### Lấy Danh Sách Yêu Cầu
**GET** `/api/change-requests/my-requests`
```json
[
  {
    "maYeuCau": 1,
    "phongHienTai": 1,
    "phongMongMuon": 2,
    "lyDo": "Gần thư viện hơn",
    "ngayYeuCau": "2024-01-01T00:00:00",
    "trangThai": "Chờ duyệt"
  }
]
```

### 6. Điểm Rèn Luyện

#### Lấy Điểm Rèn Luyện
**GET** `/api/discipline-scores/my-scores`
```json
[
  {
    "thang": 1,
    "nam": 2024,
    "diemRenLuyen": 85,
    "xepLoai": "Khá",
    "ghiChu": "Có tiến bộ"
  }
]
```

### 7. Kỷ Luật

#### Lấy Danh Sách Kỷ Luật
**GET** `/api/violations/my-violations`
```json
[
  {
    "maKyLuat": 1,
    "loaiViPham": "Vi phạm nội quy",
    "moTa": "Đi muộn sau 22h",
    "ngayViPham": "2024-01-15T00:00:00",
    "mucPhat": 50000,
    "trangThai": "Chưa xử lý"
  }
]
```

---

## 🌐 GATEWAY API (Port 8000)

### Swagger UI Tổng Hợp
- **URL:** `http://localhost:8000/swagger`
- **Mô tả:** Hiển thị tất cả API của Admin và User

### Redirects
- **URL:** `http://localhost:8000/` → `http://localhost:8000/admin/swagger`
- **URL:** `http://localhost:8000/admin` → `http://localhost:8000/admin/swagger`
- **URL:** `http://localhost:8000/user` → `http://localhost:8000/user/swagger`

### Routing
- **Admin APIs:** `http://localhost:8000/admin/*` → `http://localhost:8001/api/*`
- **User APIs:** `http://localhost:8000/user/*` → `http://localhost:8002/api/*`
- **Auth:** `http://localhost:8000/auth/*` → `http://localhost:8001/api/*`

---

## 🔧 Cấu Hình & Triển Khai

### Khởi Động Services

1. **Admin API:**
```bash
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Admin\KTX-Admin"
dotnet run -c Release
```

2. **User API:**
```bash
cd "QuanLyKTX(Cấu trúc gateway)\KTX-NguoiDung\KTX-NguoiDung"
dotnet run -c Release
```

3. **Gateway:**
```bash
cd "QuanLyKTX(Cấu trúc gateway)\KTX-Gateway\KTX-Gateway"
dotnet run -c Release
```

### Database Connection
```json
{
  "ConnectionStrings": {
    "KTX": "Server=localhost;Database=QuanLyKTX;Trusted_Connection=true;TrustServerCertificate=true;"
  }
}
```

### JWT Configuration
```json
{
  "AppSettings": {
    "Secret": "super_secret_ktx_admin_key_32_chars_minimum"
  }
}
```

---

## 📝 Ghi Chú Quan Trọng

1. **Authentication:** Tất cả API (trừ `/auth/token`) đều yêu cầu Bearer token
2. **Authorization:** Kiểm tra role trong JWT token
3. **CORS:** Đã cấu hình cho phép tất cả origins
4. **Validation:** Tất cả input đều được validate
5. **Error Handling:** Trả về HTTP status codes chuẩn
6. **Logging:** Ghi log tất cả requests và errors

---

## 🚀 Testing với Postman

### Collection Import
1. Import file `QuanLyKTX_Postman_Collection.json`
2. Set environment variables:
   - `base_url`: `http://localhost:8000`
   - `admin_url`: `http://localhost:8001`
   - `user_url`: `http://localhost:8002`

### Test Flow
1. **Login:** POST `/auth/token` → Lấy token
2. **Set Token:** Thêm `Authorization: Bearer <token>` vào headers
3. **Test APIs:** Gọi các API theo role

---

## 📊 Monitoring & Health Checks

- **Admin Health:** `http://localhost:8001/health`
- **User Health:** `http://localhost:8002/health`
- **Gateway Health:** `http://localhost:8000/health`

---

*Tài liệu này được cập nhật tự động từ source code. Để có thông tin mới nhất, vui lòng kiểm tra Swagger UI tại các URL tương ứng.*
