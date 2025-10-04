using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Model;
using System.Security.Claims;

namespace API.Controllers
{
    //[Authorize]
    //http://localhost:52872/api/Auth/login
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private ITaiKhoanBusiness _taiKhoanBusiness;
        
        public AuthController(ITaiKhoanBusiness taiKhoanBusiness)
        {
            _taiKhoanBusiness = taiKhoanBusiness;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            try
            {
                var result = _taiKhoanBusiness.Authenticate(request);
                return Ok(new ResponseModel { Success = true, Message = "Đăng nhập thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPost("register")]
        public IActionResult Register([FromBody] TaiKhoanModel model)
        {
            try
            {
                var result = _taiKhoanBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Đăng ký tài khoản thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPost("changepassword")]
        [Authorize]
        public IActionResult ChangePassword([FromBody] ChangePasswordRequest request)
        {
            try
            {
                var userId = GetCurrentUserId();
                var result = _taiKhoanBusiness.ChangePassword(userId, request.MatKhauMoi, request.MatKhauCu);
                return Ok(new ResponseModel { Success = true, Message = "Đổi mật khẩu thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("profile")]
        [Authorize]
        public IActionResult GetProfile()
        {
            try
            {
                var userId = GetCurrentUserId();
                var result = _taiKhoanBusiness.GetDatabyID(userId);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin profile thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        private int GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim == null || !int.TryParse(userIdClaim.Value, out int userId))
                throw new Exception("Không thể xác định người dùng");
            return userId;
        }
    }

    public class ChangePasswordRequest
    {
        public string MatKhauCu { get; set; } = string.Empty;
        public string MatKhauMoi { get; set; } = string.Empty;
    }
}