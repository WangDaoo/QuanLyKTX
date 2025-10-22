using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HoaDonController : ControllerBase
    {
        private readonly IHoaDonService _hoaDonService;

        public HoaDonController(IHoaDonService hoaDonService)
        {
            _hoaDonService = hoaDonService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> GetAll()
        {
            var result = await _hoaDonService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<HoaDonDto>> GetById(int id)
        {
            var hoaDon = await _hoaDonService.GetByIdAsync(id);
            if (hoaDon == null)
                return NotFound();
            return Ok(hoaDon);
        }

        [HttpGet("sinh-vien/{sinhVienId}")]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> GetBySinhVien(int sinhVienId)
        {
            var hoaDon = await _hoaDonService.GetBySinhVienAsync(sinhVienId);
            return Ok(hoaDon);
        }

        [HttpGet("phong/{phongId}")]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> GetByPhong(int phongId)
        {
            var hoaDon = await _hoaDonService.GetByPhongAsync(phongId);
            return Ok(hoaDon);
        }

        [HttpGet("trang-thai/{trangThai}")]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> GetByTrangThai(string trangThai)
        {
            var hoaDon = await _hoaDonService.GetByTrangThaiAsync(trangThai);
            return Ok(hoaDon);
        }

        [HttpGet("thang/{thang}/{nam}")]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> GetByThang(int thang, int nam)
        {
            var hoaDon = await _hoaDonService.GetByThangAsync(thang, nam);
            return Ok(hoaDon);
        }

        [HttpPost]
        public async Task<ActionResult<HoaDonDto>> Create(CreateHoaDonDto createHoaDonDTO)
        {
            var hoaDon = await _hoaDonService.CreateAsync(createHoaDonDTO);
            return CreatedAtAction(nameof(GetById), new { id = hoaDon.MaHoaDon }, hoaDon);
        }


        [HttpPut("{id}")]
        public async Task<ActionResult<HoaDonDto>> Update(int id, UpdateHoaDonDto updateHoaDonDTO)
        {
            var hoaDon = await _hoaDonService.UpdateAsync(id, updateHoaDonDTO);
            if (hoaDon == null)
                return NotFound();
            return Ok(hoaDon);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _hoaDonService.DeleteAsync(id);
            if (!result)
                return NotFound();
            return NoContent();
        }

        [HttpPost("{id}/thanh-toan")]
        public async Task<ActionResult<HoaDonDto>> ThanhToan(int id, PayHoaDonDto thanhToanDTO)
        {
            var result = await _hoaDonService.PayAsync(id, thanhToanDTO);
            if (!result)
                return NotFound();
            var hoaDon = await _hoaDonService.GetByIdAsync(id);
            return Ok(hoaDon);
        }

        [HttpPost("tao-hoa-don-thang")]
        public async Task<ActionResult<IEnumerable<HoaDonDto>>> CreateMonthlyBills([FromQuery] int thang, int nam)
        {
            var hoaDons = await _hoaDonService.CreateMonthlyBillsAsync(thang, nam);
            return Ok(hoaDons);
        }
    }
}
