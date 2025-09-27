using System;

namespace Model
{
    public class SinhVienModel
    {
        public int ma_sinh_vien { get; set; }
        public string ho_ten { get; set; } = string.Empty;
        public string mssv { get; set; } = string.Empty;
        public string email { get; set; } = string.Empty;
        public string sdt { get; set; } = string.Empty;
        public string cccd { get; set; } = string.Empty;
        public DateTime ngay_sinh { get; set; }
        public string gioi_tinh { get; set; } = string.Empty;
        public string dia_chi { get; set; } = string.Empty;
        public string khoa { get; set; } = string.Empty;
        public string lop { get; set; } = string.Empty;
        public string anh_dai_dien { get; set; } = string.Empty;
        public int? ma_phong { get; set; }
        public string trang_thai { get; set; } = string.Empty;
        public string? ghi_chu { get; set; }
        public DateTime ngay_tao { get; set; }
        public DateTime? ngay_cap_nhat { get; set; }
    }
}