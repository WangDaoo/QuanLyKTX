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

namespace API.Controllers
{
    //[Authorize]
    //http://localhost:52872/api/Giuong/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class GiuongController : ControllerBase
    {
        private IGiuongBusiness _giuongBusiness;
        
        public GiuongController(IGiuongBusiness giuongBusiness)
        {
            _giuongBusiness = giuongBusiness;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] GiuongModel model)
        {
            try
            {
                var result = _giuongBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Tạo giường thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] GiuongModel model)
        {
            try
            {
                var result = _giuongBusiness.Update(model);
                return Ok(new ResponseModel { Success = true, Message = "Cập nhật giường thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("getbyid/{maGiuong}")]
        public IActionResult GetById(int maGiuong)
        {
            try
            {
                var result = _giuongBusiness.GetDatabyID(maGiuong);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin giường thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("getall")]
        public IActionResult GetAll()
        {
            try
            {
                var result = _giuongBusiness.GetDataAll();
                return Ok(new ResponseModel { Success = true, Message = "Lấy danh sách giường thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }
    }
}