using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ViPhamController : ControllerBase
    {
        private readonly IViPhamService _viPhamService;

        public ViPhamController(IViPhamService viPhamService)
        {
            _viPhamService = viPhamService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ViPhamDto>>> GetAll()
        {
            var result = await _viPhamService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ViPhamDto>> GetById(int id)
        {
            var viPham = await _viPhamService.GetByIdAsync(id);
            if (viPham == null)
                return NotFound();
            return Ok(viPham);
        }

        [HttpGet("sinh-vien/{sinhVienId}")]
        public async Task<ActionResult<IEnumerable<ViPhamDto>>> GetBySinhVien(int sinhVienId)
        {
            var viPham = await _viPhamService.GetBySinhVienAsync(sinhVienId);
            return Ok(viPham);
        }


        [HttpPost]
        public async Task<ActionResult<ViPhamDto>> Create(CreateViPhamDto createViPhamDTO)
        {
            var viPham = await _viPhamService.CreateAsync(createViPhamDTO);
            return CreatedAtAction(nameof(GetById), new { id = viPham.MaViPham }, viPham);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<ViPhamDto>> Update(int id, UpdateViPhamDto updateViPhamDTO)
        {
            var viPham = await _viPhamService.UpdateAsync(id, updateViPhamDTO);
            if (viPham == null)
                return NotFound();
            return Ok(viPham);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _viPhamService.DeleteAsync(id);
            if (!result)
                return NotFound();
            return NoContent();
        }

        [HttpGet("tim-kiem")]
        public async Task<ActionResult<PagedResult<ViPhamDto>>> Search([FromQuery] SearchDto searchDto)
        {
            var result = await _viPhamService.SearchAsync(searchDto);
            return Ok(result);
        }
    }
}
