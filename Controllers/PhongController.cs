using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PhongController : ControllerBase
    {
        private readonly IPhongService _phongService;

        public PhongController(IPhongService phongService)
        {
            _phongService = phongService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<PhongDto>>> GetAll()
        {
            var result = await _phongService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PhongDto>> GetById(int id)
        {
            var phong = await _phongService.GetByIdAsync(id);
            if (phong == null)
                return NotFound();
            return Ok(phong);
        }

        [HttpGet("toa-nha/{toaNhaId}")]
        public async Task<ActionResult<IEnumerable<PhongDto>>> GetByToaNha(int toaNhaId)
        {
            var phongs = await _phongService.GetByToaNhaAsync(toaNhaId);
            return Ok(phongs);
        }

        [HttpPost]
        public async Task<ActionResult<PhongDto>> Create(CreatePhongDto createPhongDTO)
        {
            var phong = await _phongService.CreateAsync(createPhongDTO);
            return CreatedAtAction(nameof(GetById), new { id = phong.MaPhong }, phong);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<PhongDto>> Update(int id, UpdatePhongDto updatePhongDTO)
        {
            var phong = await _phongService.UpdateAsync(id, updatePhongDTO);
            if (phong == null)
                return NotFound();
            return Ok(phong);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _phongService.DeleteAsync(id);
            if (!result)
                return NotFound();
            return NoContent();
        }

    }
}
