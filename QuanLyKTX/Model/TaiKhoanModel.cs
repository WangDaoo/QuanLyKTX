using System;

namespace Model
{
    public class TaiKhoanModel
    {
        public int ma_tai_khoan { get; set; }
        public string ten_dang_nhap { get; set; } = string.Empty;
        public string mat_khau { get; set; } = string.Empty;
        public string ho_ten { get; set; } = string.Empty;
        public string email { get; set; } = string.Empty;
        public string vai_tro { get; set; } = string.Empty;
        public int? ma_sinh_vien { get; set; }
        public string trang_thai { get; set; } = string.Empty;
        public DateTime ngay_tao { get; set; }
        public DateTime? ngay_dang_nhap_cuoi { get; set; }
        public string? ghi_chu { get; set; }
    }
}