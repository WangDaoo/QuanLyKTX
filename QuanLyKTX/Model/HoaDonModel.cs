using System;
using System.Collections.Generic;

namespace Model
{
    public class HoaDonModel
    {
        public int ma_hoa_don { get; set; }
        public int ma_sinh_vien { get; set; }
        public int? ma_phong { get; set; }
        public int? ma_hop_dong { get; set; }
        public int thang { get; set; }
        public int nam { get; set; }
        public decimal tong_tien { get; set; }
        public string trang_thai { get; set; } = string.Empty;
        public DateTime ngay_het_han { get; set; }
        public DateTime? ngay_thanh_toan { get; set; }
        public string? ghi_chu { get; set; }
    }
}