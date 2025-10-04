namespace KTX_Admin.Models
{
    public sealed class ChiSoDienNuoc
    {
        public int MaChiSo { get; set; }
        public int MaPhong { get; set; }
        public int Thang { get; set; }
        public int Nam { get; set; }
        public int DienCu { get; set; }
        public int DienMoi { get; set; }
        public int NuocCu { get; set; }
        public int NuocMoi { get; set; }
        public DateTime? NgayGhi { get; set; }
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }
}


