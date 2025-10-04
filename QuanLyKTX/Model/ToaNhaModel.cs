using System;

namespace Model
{
    public class ToaNhaModel
    {
        public int ma_toa_nha { get; set; }
        public string ten_toa_nha { get; set; } = string.Empty;
        public string dia_chi { get; set; } = string.Empty;
        public int so_tang { get; set; }
        public int so_phong { get; set; }
        public string mo_ta { get; set; } = string.Empty;
        public string trang_thai { get; set; } = string.Empty;
        public string? ghi_chu { get; set; }
        public DateTime ngay_tao { get; set; }
        public DateTime? ngay_cap_nhat { get; set; }
    }
}