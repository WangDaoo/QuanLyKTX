namespace KTX_Admin.Models
{
    public sealed class MucPhi
    {
        public int MaMucPhi { get; set; }
        public string TenMucPhi { get; set; } = string.Empty;
        public string? LoaiMucPhi { get; set; }
        public decimal DonGia { get; set; }
        public string? DonViTinh { get; set; }
        public DateTime? HieuLucTu { get; set; }
        public DateTime? HieuLucDen { get; set; }
        public bool TrangThai { get; set; } = true;
        public bool IsDeleted { get; set; }
    }
}


