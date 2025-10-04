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
    //http://localhost:52872/api/Phong/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class PhongController : ControllerBase
    {
        private IPhongBusiness _phongBusiness;
        
        public PhongController(IPhongBusiness phongBusiness)
        {
            _phongBusiness = phongBusiness;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] PhongModel model)
        {
            try
            {
                var result = _phongBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Tạo phòng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] PhongModel model)
        {
            try
            {
                var result = _phongBusiness.Update(model);
                return Ok(new ResponseModel { Success = true, Message = "Cập nhật phòng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpGet("getbyid/{maPhong}")]
        public IActionResult GetById(int maPhong)
        {
            try
            {
                var result = _phongBusiness.GetDatabyID(maPhong);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin phòng thành công", Data = result });
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
                var result = _phongBusiness.GetDataAll();
                return Ok(new ResponseModel { Success = true, Message = "Lấy danh sách phòng thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }
    }
}