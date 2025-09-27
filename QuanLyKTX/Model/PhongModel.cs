using System;

namespace Model
{
    public class PhongModel
    {
        public int ma_phong { get; set; }
        public int ma_toa_nha { get; set; }
        public string so_phong { get; set; } = string.Empty;
        public int so_giuong { get; set; }
        public string loai_phong { get; set; } = string.Empty;
        public decimal gia_phong { get; set; }
        public string mo_ta { get; set; } = string.Empty;
        public string trang_thai { get; set; } = string.Empty;
        public string? ghi_chu { get; set; }
        public DateTime ngay_tao { get; set; }
        public DateTime? ngay_cap_nhat { get; set; }
    }
}