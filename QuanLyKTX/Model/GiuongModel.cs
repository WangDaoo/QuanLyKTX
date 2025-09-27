using System;
using System.Collections.Generic;

namespace Model
{
    public class GiuongModel
    {
        public int ma_giuong { get; set; }
        public int ma_phong { get; set; }
        public string so_giuong { get; set; } = string.Empty;
        public string trang_thai { get; set; } = string.Empty;
        public string? ghi_chu { get; set; }
    }
}