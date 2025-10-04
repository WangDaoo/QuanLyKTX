namespace KTX_Admin.Models
{
    public sealed class BacGia
    {
        public int MaBac { get; set; }
        public string Loai { get; set; } = string.Empty; // Dien/Nuoc
        public int ThuTu { get; set; }
        public int? TuSo { get; set; }
        public int? DenSo { get; set; }
        public decimal DonGia { get; set; }
        public bool TrangThai { get; set; } = true;
    }
}


