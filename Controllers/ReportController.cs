using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReportController : ControllerBase
    {
        private readonly IReportService _reportService;

        public ReportController(IReportService reportService)
        {
            _reportService = reportService;
        }

        [HttpGet("tong-quan")]
        public async Task<ActionResult<DashboardDto>> GetTongQuan()
        {
            var tongQuan = await _reportService.GetDashboardAsync();
            return Ok(tongQuan);
        }

        [HttpGet("thong-ke-phong")]
        public async Task<ActionResult<OccupancyReportDto>> GetThongKePhong([FromQuery] int? maToaNha = null)
        {
            var thongKe = await _reportService.GetOccupancyReportAsync(maToaNha);
            return Ok(thongKe);
        }

        [HttpGet("thong-ke-doanh-thu")]
        public async Task<ActionResult<RevenueReportDto>> GetThongKeDoanhThu([FromQuery] int thang, int nam)
        {
            var thongKe = await _reportService.GetRevenueReportAsync(thang, nam);
            return Ok(thongKe);
        }

        [HttpGet("thong-ke-no")]
        public async Task<ActionResult<DebtReportDto>> GetThongKeNo()
        {
            var thongKe = await _reportService.GetDebtReportAsync();
            return Ok(thongKe);
        }

        [HttpGet("thong-ke-ky-luat")]
        public async Task<ActionResult<DisciplineReportDto>> GetThongKeKyLuat([FromQuery] int hocKy, int namHoc)
        {
            var thongKe = await _reportService.GetDisciplineReportAsync(hocKy, namHoc);
            return Ok(thongKe);
        }
    }
}
