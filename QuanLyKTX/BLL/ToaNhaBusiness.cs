using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class ToaNhaBusiness : IToaNhaBusiness
    {
        private IToaNhaRepository _res;
        
        public ToaNhaBusiness(IToaNhaRepository res)
        {
            _res = res;
        }

        public bool Create(ToaNhaModel model)
        {
            // Business logic validation
            if (string.IsNullOrEmpty(model.ten_toa_nha))
                throw new Exception("Tên tòa nhà không được để trống");
            
            if (model.so_tang <= 0)
                throw new Exception("Số tầng phải lớn hơn 0");

            return _res.Create(model);
        }

        public bool Update(ToaNhaModel model)
        {
            // Business logic validation
            if (model.ma_toa_nha <= 0)
                throw new Exception("Mã tòa nhà không hợp lệ");
            
            if (string.IsNullOrEmpty(model.ten_toa_nha))
                throw new Exception("Tên tòa nhà không được để trống");

            return _res.Update(model);
        }

        public ToaNhaModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã tòa nhà không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<ToaNhaModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<ToaNhaModel> Search(int pageIndex, int pageSize, out long total, string ten_toa_nha)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_toa_nha);
        }
    }
}