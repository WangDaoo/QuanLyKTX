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
    //http://localhost:52872/api/ToaNha/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class ToaNhaController : ControllerBase
    {
        private IToaNhaBusiness _toaNhaBusiness;
        
        public ToaNhaController(IToaNhaBusiness toaNhaBusiness)
        {
            _toaNhaBusiness = toaNhaBusiness;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] ToaNhaModel model)
        {
            try
            {
                var result = _toaNhaBusiness.Create(model);
                return Ok(new ResponseModel { Success = true, Message = "Tạo tòa nhà thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] ToaNhaModel model)
        {
            try
            {
                var result = _toaNhaBusiness.Update(model);
                return Ok(new ResponseModel { Success = true, Message = "Cập nhật tòa nhà thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }


        [HttpGet("getbyid/{maToaNha}")]
        public IActionResult GetById(int maToaNha)
        {
            try
            {
                var result = _toaNhaBusiness.GetDatabyID(maToaNha);
                return Ok(new ResponseModel { Success = true, Message = "Lấy thông tin tòa nhà thành công", Data = result });
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
                var result = _toaNhaBusiness.GetDataAll();
                return Ok(new ResponseModel { Success = true, Message = "Lấy danh sách tòa nhà thành công", Data = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseModel { Success = false, Message = ex.Message });
            }
        }
    }
}