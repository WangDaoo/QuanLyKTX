namespace KTX_Admin.Models
{
    public sealed class KyLuat
    {
        public int MaKyLuat { get; set; }
        public int MaSinhVien { get; set; }
        public string LoaiViPham { get; set; } = string.Empty;
        public string MoTa { get; set; } = string.Empty;
        public DateTime NgayViPham { get; set; } = DateTime.UtcNow;
        public decimal MucPhat { get; set; }
        public string TrangThai { get; set; } = "Chưa xử lý";
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }
}





