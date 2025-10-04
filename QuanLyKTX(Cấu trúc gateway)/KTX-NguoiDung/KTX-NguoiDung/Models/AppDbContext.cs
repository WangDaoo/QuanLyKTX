using Microsoft.EntityFrameworkCore;

namespace KTX_NguoiDung.Models
{
    public sealed class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<HopDong> HopDongs => Set<HopDong>();
        public DbSet<HoaDon> HoaDons => Set<HoaDon>();
        public DbSet<BienLaiThu> BienLaiThus => Set<BienLaiThu>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<HopDong>(b => { b.ToTable("HopDong"); b.HasKey(x => x.MaHopDong); });
            modelBuilder.Entity<HoaDon>(b => { b.ToTable("HoaDon"); b.HasKey(x => x.MaHoaDon); });
            modelBuilder.Entity<BienLaiThu>(b => { b.ToTable("BienLaiThu"); b.HasKey(x => x.MaBienLai); });
        }
    }
}


