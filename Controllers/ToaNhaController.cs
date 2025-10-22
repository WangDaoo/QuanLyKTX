using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;

namespace QuanLyKyTucXa.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ToaNhaController : ControllerBase
    {
        private readonly IToaNhaService _toaNhaService;

        public ToaNhaController(IToaNhaService toaNhaService)
        {
            _toaNhaService = toaNhaService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ToaNhaDto>>> GetAll()
        {
            var toaNhas = await _toaNhaService.GetAllAsync();
            return Ok(toaNhas);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ToaNhaDto>> GetById(int id)
        {
            var toaNha = await _toaNhaService.GetByIdAsync(id);
            
            if (toaNha == null)
            {
                return NotFound(new ResponseDto<ToaNhaDto>
                {
                    Success = false,
                    Message = "Không tìm thấy tòa nhà"
                });
            }

            return Ok(new ResponseDto<ToaNhaDto>
            {
                Success = true,
                Data = toaNha
            });
        }

        [HttpPost]
        public async Task<ActionResult<ToaNhaDto>> Create([FromBody] CreateToaNhaDto dto)
        {
            try
            {
                var toaNha = await _toaNhaService.CreateAsync(dto);
                return CreatedAtAction(nameof(GetById), new { id = toaNha.MaToaNha }, new ResponseDto<ToaNhaDto>
                {
                    Success = true,
                    Message = "Tạo tòa nhà thành công",
                    Data = toaNha
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseDto<ToaNhaDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<ToaNhaDto>> Update(int id, [FromBody] UpdateToaNhaDto dto)
        {
            try
            {
                var toaNha = await _toaNhaService.UpdateAsync(id, dto);
                return Ok(new ResponseDto<ToaNhaDto>
                {
                    Success = true,
                    Message = "Cập nhật tòa nhà thành công",
                    Data = toaNha
                });
            }
            catch (ArgumentException ex)
            {
                return NotFound(new ResponseDto<ToaNhaDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseDto<ToaNhaDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var result = await _toaNhaService.DeleteAsync(id);
            
            if (!result)
            {
                return NotFound(new ResponseDto
                {
                    Success = false,
                    Message = "Không tìm thấy tòa nhà"
                });
            }

            return Ok(new ResponseDto
            {
                Success = true,
                Message = "Xóa tòa nhà thành công"
            });
        }

        [HttpPost("search")]
        public async Task<ActionResult<PagedResult<ToaNhaDto>>> Search([FromBody] SearchDto searchDto)
        {
            var result = await _toaNhaService.SearchAsync(searchDto);
            return Ok(result);
        }
    }
}
