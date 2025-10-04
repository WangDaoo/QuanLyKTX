using Microsoft.EntityFrameworkCore;

namespace KTX_Admin.Models
{
    public sealed class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<ToaNha> ToaNhas => Set<ToaNha>();
        public DbSet<Phong> Phongs => Set<Phong>();
        public DbSet<Giuong> Giuongs => Set<Giuong>();
        public DbSet<MucPhi> MucPhis => Set<MucPhi>();
        public DbSet<BacGia> BacGias => Set<BacGia>();
        public DbSet<CauHinhPhi> CauHinhPhis => Set<CauHinhPhi>();
        public DbSet<ChiSoDienNuoc> ChiSoDienNuocs => Set<ChiSoDienNuoc>();
        public DbSet<HopDong> HopDongs => Set<HopDong>();
        public DbSet<HoaDon> HoaDons => Set<HoaDon>();
        public DbSet<BienLaiThu> BienLaiThus => Set<BienLaiThu>();
        public DbSet<ThongBaoQuaHan> ThongBaoQuaHans => Set<ThongBaoQuaHan>();
        public DbSet<KyLuat> KyLuats => Set<KyLuat>();
        public DbSet<DiemRenLuyen> DiemRenLuyens => Set<DiemRenLuyen>();
        public DbSet<DonDangKy> DonDangKys => Set<DonDangKy>();
        public DbSet<YeuCauChuyenPhong> YeuCauChuyenPhongs => Set<YeuCauChuyenPhong>();
        public DbSet<TaiKhoan> TaiKhoans => Set<TaiKhoan>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ToaNha>(b =>
            {
                b.ToTable("ToaNha");
                b.HasKey(x => x.MaToaNha);
                b.Property(x => x.TenToaNha).HasMaxLength(200).IsRequired();
            });

            modelBuilder.Entity<Phong>(b =>
            {
                b.ToTable("Phong");
                b.HasKey(x => x.MaPhong);
                b.Property(x => x.SoPhong).HasMaxLength(20).IsRequired();
                b.Property(x => x.LoaiPhong).HasMaxLength(50).IsRequired();
                b.HasOne<ToaNha>()
                 .WithMany()
                 .HasForeignKey(x => x.MaToaNha);
            });

            modelBuilder.Entity<Giuong>(b =>
            {
                b.ToTable("Giuong");
                b.HasKey(x => x.MaGiuong);
                b.Property(x => x.SoGiuong).HasMaxLength(10).IsRequired();
                b.HasOne<Phong>()
                 .WithMany()
                 .HasForeignKey(x => x.MaPhong);
            });

            modelBuilder.Entity<MucPhi>(b =>
            {
                b.ToTable("MucPhi");
                b.HasKey(x => x.MaMucPhi);
                b.Property(x => x.TenMucPhi).HasMaxLength(200).IsRequired();
                b.Property(x => x.LoaiMucPhi).HasMaxLength(100);
                b.Property(x => x.DonViTinh).HasMaxLength(50);
            });

            modelBuilder.Entity<BacGia>(b =>
            {
                b.ToTable("BacGia");
                b.HasKey(x => x.MaBac);
                b.Property(x => x.Loai).HasMaxLength(20).IsRequired();
            });

            modelBuilder.Entity<CauHinhPhi>(b =>
            {
                b.ToTable("CauHinhPhi");
                b.HasKey(x => x.MaCauHinh);
                b.Property(x => x.Loai).HasMaxLength(20).IsRequired();
            });

            modelBuilder.Entity<ChiSoDienNuoc>(b =>
            {
                b.ToTable("ChiSoDienNuoc");
                b.HasKey(x => x.MaChiSo);
                b.HasIndex(x => new { x.MaPhong, x.Thang, x.Nam }).IsUnique();
                b.HasOne<Phong>()
                 .WithMany()
                 .HasForeignKey(x => x.MaPhong);
            });

            modelBuilder.Entity<HopDong>(b =>
            {
                b.ToTable("HopDong");
                b.HasKey(x => x.MaHopDong);
            });

            modelBuilder.Entity<HoaDon>(b =>
            {
                b.ToTable("HoaDon");
                b.HasKey(x => x.MaHoaDon);
            });

            modelBuilder.Entity<BienLaiThu>(b =>
            {
                b.ToTable("BienLaiThu");
                b.HasKey(x => x.MaBienLai);
            });

            modelBuilder.Entity<ThongBaoQuaHan>(b =>
            {
                b.ToTable("ThongBaoQuaHan");
                b.HasKey(x => x.MaThongBao);
            });

            modelBuilder.Entity<KyLuat>(b =>
            {
                b.ToTable("KyLuat");
                b.HasKey(x => x.MaKyLuat);
            });

            modelBuilder.Entity<DiemRenLuyen>(b =>
            {
                b.ToTable("DiemRenLuyen");
                b.HasKey(x => x.MaDiem);
                b.HasIndex(x => new { x.MaSinhVien, x.Thang, x.Nam }).IsUnique();
            });

            modelBuilder.Entity<DonDangKy>(b =>
            {
                b.ToTable("DonDangKy");
                b.HasKey(x => x.MaDon);
            });

            modelBuilder.Entity<YeuCauChuyenPhong>(b =>
            {
                b.ToTable("YeuCauChuyenPhong");
                b.HasKey(x => x.MaYeuCau);
            });

            modelBuilder.Entity<TaiKhoan>(b =>
            {
                b.ToTable("TaiKhoan");
                b.HasKey(x => x.MaTaiKhoan);
                b.Property(x => x.Username).HasMaxLength(100).IsRequired();
                b.HasIndex(x => x.Username).IsUnique();
                b.Property(x => x.Role).HasMaxLength(50).IsRequired();
            });
        }
    }
}


