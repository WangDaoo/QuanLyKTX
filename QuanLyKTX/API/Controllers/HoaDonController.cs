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
    //http://localhost:52872/api/HoaDon/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonController : ControllerBase
    {
        private IHoaDonBusiness _hoaDonBusiness;
        
        public HoaDonController(IHoaDonBusiness hoaDonBusiness)
        {
            _hoaDonBusiness = hoaDonBusiness;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] HoaDonModel model)
        {
            try
            {
                var result = _hoaDonBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Tạo hóa đơn thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] HoaDonModel model)
        {
            try
            {
                var result = _hoaDonBusiness.Update(model);
                return Ok(new ResponseModel { Success = true, Message = "Cập nhật hóa đơn thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("getbyid/{maHoaDon}")]
        public IActionResult GetById(int maHoaDon)
        {
            try
            {
                var result = _hoaDonBusiness.GetDatabyID(maHoaDon);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin hóa đơn thành công", Data = result });
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
                var result = _hoaDonBusiness.GetDataAll();
                return Ok(new ResponseModel { Success = true, Message = "Lấy danh sách hóa đơn thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }
    }
}