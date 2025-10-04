namespace KTX_Admin.Models
{
    public sealed class CauHinhPhi
    {
        public int MaCauHinh { get; set; }
        public string Loai { get; set; } = string.Empty; // Dien/Nuoc
        public decimal MucToiThieu { get; set; }
        public bool TrangThai { get; set; } = true;
    }
}


