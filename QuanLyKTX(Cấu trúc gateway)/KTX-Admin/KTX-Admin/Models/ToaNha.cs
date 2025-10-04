namespace KTX_Admin.Models
{
    public sealed class ToaNha
    {
        public int MaToaNha { get; set; }
        public string TenToaNha { get; set; } = string.Empty;
        public string? DiaChi { get; set; }
        public int? SoTang { get; set; }
        public string? MoTa { get; set; }
        public bool TrangThai { get; set; } = true;
        public bool IsDeleted { get; set; }
    }
}


