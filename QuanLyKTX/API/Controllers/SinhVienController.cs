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
    //http://localhost:52872/api/SinhVien/get-by-id/1
    [Route("api/[controller]")]
    [ApiController]
    public class SinhVienController : ControllerBase
    {
        private ISinhVienBusiness _sinhVienBusiness;
        private IMemoryCache _memoryCache;
        public SinhVienController(ISinhVienBusiness sinhVienBusiness, IMemoryCache memoryCache)
        {
            _sinhVienBusiness = sinhVienBusiness;
            _memoryCache = memoryCache;
        }

        [Route("create-sinhvien")]
        [HttpPost]
        public SinhVienModel CreateSinhVien([FromBody] SinhVienModel model)
        {
            //_memoryCache.Remove("all-sinhvien");
            _sinhVienBusiness.Create(model);
            return model;
        }
        [Route("update-sinhvien")]
        [HttpPost]
        public SinhVienModel UpdateSinhVien([FromBody] SinhVienModel model)
        {
            //_memoryCache.Remove("all-sinhvien");
            _sinhVienBusiness.Update(model);
            return model;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public SinhVienModel GetDatabyID(int id)
        {
            return _sinhVienBusiness.GetDatabyID(id);
        }
        [Route("get-all")]
        [HttpGet]
        public List<SinhVienModel> GetDataAll()
        {
            return _sinhVienBusiness.GetDataAll();
        }
        [Route("search")]
        [HttpPost]
        public List<SinhVienModel> Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int? ma_phong = null;
                if (formData.Keys.Contains("ma_phong") && !string.IsNullOrEmpty(Convert.ToString(formData["ma_phong"]))) { ma_phong = int.Parse(formData["ma_phong"].ToString()); }
                string ho_ten = "";
                if (formData.Keys.Contains("ho_ten") && !string.IsNullOrEmpty(Convert.ToString(formData["ho_ten"]))) { ho_ten = Convert.ToString(formData["ho_ten"]); }
                long total = 0;
                var data = _sinhVienBusiness.Search(page, pageSize, out total, ma_phong, ho_ten);
                return data;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}