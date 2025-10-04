namespace KTX_NguoiDung.Models
{
    public sealed class HopDong
    {
        public int MaHopDong { get; set; }
        public int MaSinhVien { get; set; }
        public int MaGiuong { get; set; }
        public DateTime NgayBatDau { get; set; }
        public DateTime NgayKetThuc { get; set; }
        public decimal GiaPhong { get; set; }
        public string TrangThai { get; set; } = string.Empty;
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }

    public sealed class HoaDon
    {
        public int MaHoaDon { get; set; }
        public int MaSinhVien { get; set; }
        public int? MaPhong { get; set; }
        public int? MaHopDong { get; set; }
        public int Thang { get; set; }
        public int Nam { get; set; }
        public decimal TongTien { get; set; }
        public string TrangThai { get; set; } = string.Empty;
        public DateTime NgayHetHan { get; set; }
        public DateTime? NgayThanhToan { get; set; }
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }

    public sealed class BienLaiThu
    {
        public int MaBienLai { get; set; }
        public int MaHoaDon { get; set; }
        public decimal SoTienThu { get; set; }
        public DateTime NgayThu { get; set; }
        public string? NguoiThu { get; set; }
        public string? GhiChu { get; set; }
    }
}


