using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;
using QuanLyKyTucXa.API.Models;

namespace QuanLyKyTucXa.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HopDongController : ControllerBase
    {
        private readonly IHopDongService _hopDongService;

        public HopDongController(IHopDongService hopDongService)
        {
            _hopDongService = hopDongService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<HopDongDto>>> GetAll()
        {
            var result = await _hopDongService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<HopDongDto>> GetById(int id)
        {
            var hopDong = await _hopDongService.GetByIdAsync(id);
            if (hopDong == null)
                return NotFound();
            return Ok(hopDong);
        }

        [HttpGet("sinh-vien/{sinhVienId}")]
        public async Task<ActionResult<IEnumerable<HopDongDto>>> GetBySinhVien(int sinhVienId)
        {
            var hopDong = await _hopDongService.GetBySinhVienAsync(sinhVienId);
            return Ok(hopDong);
        }


        [HttpPost]
        public async Task<ActionResult<HopDongDto>> Create(CreateHopDongDto createHopDongDTO)
        {
            var hopDong = await _hopDongService.CreateAsync(createHopDongDTO);
            return CreatedAtAction(nameof(GetById), new { id = hopDong.MaHopDong }, hopDong);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<HopDongDto>> Update(int id, UpdateHopDongDto updateHopDongDTO)
        {
            var hopDong = await _hopDongService.UpdateAsync(id, updateHopDongDTO);
            if (hopDong == null)
                return NotFound();
            return Ok(hopDong);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _hopDongService.DeleteAsync(id);
            if (!result)
                return NotFound();
            return NoContent();
        }

        [HttpPost("{id}/duyet")]
        public async Task<ActionResult<HopDongDto>> DuyetHopDong(int id)
        {
            var result = await _hopDongService.ApproveAsync(id);
            if (!result)
                return NotFound();
            var hopDong = await _hopDongService.GetByIdAsync(id);
            return Ok(hopDong);
        }

        [HttpPost("{id}/huy")]
        public async Task<ActionResult<HopDongDto>> HuyHopDong(int id, [FromBody] string lyDo)
        {
            var result = await _hopDongService.RejectAsync(id, lyDo);
            if (!result)
                return NotFound();
            var hopDong = await _hopDongService.GetByIdAsync(id);
            return Ok(hopDong);
        }
    }
}
