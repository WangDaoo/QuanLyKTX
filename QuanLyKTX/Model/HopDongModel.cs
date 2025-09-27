using System;

namespace Model
{
    public class HopDongModel
    {
        public int ma_hop_dong { get; set; }
        public int ma_sinh_vien { get; set; }
        public int ma_giuong { get; set; }
        public DateTime ngay_bat_dau { get; set; }
        public DateTime ngay_ket_thuc { get; set; }
        public decimal gia_phong { get; set; }
        public string trang_thai { get; set; } = string.Empty;
        public string? ghi_chu { get; set; }
        public DateTime ngay_tao { get; set; }
        public DateTime? ngay_cap_nhat { get; set; }
    }
}