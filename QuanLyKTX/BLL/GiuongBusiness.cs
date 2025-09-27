using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class GiuongBusiness : IGiuongBusiness
    {
        private IGiuongRepository _res;
        
        public GiuongBusiness(IGiuongRepository res)
        {
            _res = res;
        }

        public bool Create(GiuongModel model)
        {
            // Business logic validation
            if (model.ma_phong <= 0)
                throw new Exception("Mã phòng không hợp lệ");
            
            if (string.IsNullOrEmpty(model.so_giuong))
                throw new Exception("Số giường không được để trống");

            return _res.Create(model);
        }

        public bool Update(GiuongModel model)
        {
            // Business logic validation
            if (model.ma_giuong <= 0)
                throw new Exception("Mã giường không hợp lệ");
            
            if (model.ma_phong <= 0)
                throw new Exception("Mã phòng không hợp lệ");
            
            if (string.IsNullOrEmpty(model.so_giuong))
                throw new Exception("Số giường không được để trống");

            return _res.Update(model);
        }

        public GiuongModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã giường không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<GiuongModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<GiuongModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string so_giuong)
        {
            return _res.Search(pageIndex, pageSize, out total, ma_phong, so_giuong);
        }
    }
}