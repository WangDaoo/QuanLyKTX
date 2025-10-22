using Microsoft.AspNetCore.Mvc;
using QuanLyKyTucXa.API.DTOs;
using QuanLyKyTucXa.API.Interfaces;

namespace QuanLyKyTucXa.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("login")]
        public async Task<ActionResult<AuthResponseDto>> Login([FromBody] LoginDto loginDto)
        {
            var result = await _authService.LoginAsync(loginDto);
            
            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("register")]
        public async Task<ActionResult<AuthResponseDto>> Register([FromBody] RegisterDto registerDto)
        {
            var result = await _authService.RegisterAsync(registerDto);
            
            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("change-password")]
        public async Task<ActionResult<ResponseDto>> ChangePassword([FromBody] ChangePasswordDto changePasswordDto)
        {
            var result = await _authService.ChangePasswordAsync(changePasswordDto);
            
            if (!result)
            {
                return BadRequest(new ResponseDto
                {
                    Success = false,
                    Message = "Đổi mật khẩu thất bại"
                });
            }

            return Ok(new ResponseDto
            {
                Success = true,
                Message = "Đổi mật khẩu thành công"
            });
        }

        [HttpPost("reset-password")]
        public async Task<ActionResult<ResponseDto>> ResetPassword([FromBody] ResetPasswordDto resetPasswordDto)
        {
            var result = await _authService.ResetPasswordAsync(resetPasswordDto);
            
            if (!result)
            {
                return BadRequest(new ResponseDto
                {
                    Success = false,
                    Message = "Đặt lại mật khẩu thất bại"
                });
            }

            return Ok(new ResponseDto
            {
                Success = true,
                Message = "Đặt lại mật khẩu thành công"
            });
        }
    }
}
