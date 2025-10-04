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
    //http://localhost:52872/api/HopDong/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class HopDongController : ControllerBase
    {
        private IHopDongBusiness _hopDongBusiness;
        
        public HopDongController(IHopDongBusiness hopDongBusiness)
        {
            _hopDongBusiness = hopDongBusiness;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] HopDongModel model)
        {
            try
            {
                var result = _hopDongBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Tạo hợp đồng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] HopDongModel model)
        {
            try
            {
                var result = _hopDongBusiness.Update(model);
                return Ok(new ResponseModel { Success = true, Message = "Cập nhật hợp đồng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("getbyid/{maHopDong}")]
        public IActionResult GetById(int maHopDong)
        {
            try
            {
                var result = _hopDongBusiness.GetDatabyID(maHopDong);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin hợp đồng thành công", Data = result });
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
                var result = _hopDongBusiness.GetDataAll();
                return Ok(new ResponseModel { Success = true, Message = "Lấy danh sách hợp đồng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }
    }
}