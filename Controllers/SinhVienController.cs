using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SinhVienController : ControllerBase
    {
        private readonly ISinhVienService _sinhVienService;

        public SinhVienController(ISinhVienService sinhVienService)
        {
            _sinhVienService = sinhVienService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SinhVienDto>>> GetAll()
        {
            var result = await _sinhVienService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SinhVienDto>> GetById(int id)
        {
            var sinhVien = await _sinhVienService.GetByIdAsync(id);
            if (sinhVien == null)
                return NotFound();
            return Ok(sinhVien);
        }

        [HttpGet("ma-sv/{maSinhVien}")]
        public async Task<ActionResult<SinhVienDto>> GetByMaSinhVien(string maSinhVien)
        {
            var sinhVien = await _sinhVienService.GetByMaSinhVienAsync(maSinhVien);
            if (sinhVien == null)
                return NotFound();
            return Ok(sinhVien);
        }

        [HttpGet("phong/{phongId}")]
        public async Task<ActionResult<IEnumerable<SinhVienDto>>> GetByPhong(int phongId)
        {
            var sinhVien = await _sinhVienService.GetByPhongAsync(phongId);
            return Ok(sinhVien);
        }

        [HttpPost]
        public async Task<ActionResult<SinhVienDto>> Create(CreateSinhVienDto createSinhVienDTO)
        {
            var sinhVien = await _sinhVienService.CreateAsync(createSinhVienDTO);
            return CreatedAtAction(nameof(GetById), new { id = sinhVien.MaSinhVien }, sinhVien);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<SinhVienDto>> Update(int id, UpdateSinhVienDto updateSinhVienDTO)
        {
            var sinhVien = await _sinhVienService.UpdateAsync(id, updateSinhVienDTO);
            if (sinhVien == null)
                return NotFound();
            return Ok(sinhVien);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _sinhVienService.DeleteAsync(id);
            if (!result)
                return NotFound();
            return NoContent();
        }

        [HttpGet("tim-kiem")]
        public async Task<ActionResult<PagedResult<SinhVienDto>>> Search([FromQuery] SearchDto searchDto)
        {
            var result = await _sinhVienService.SearchAsync(searchDto);
            return Ok(result);
        }
    }
}
