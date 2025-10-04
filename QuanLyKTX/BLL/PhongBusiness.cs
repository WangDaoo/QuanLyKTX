using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class PhongBusiness : IPhongBusiness
    {
        private IPhongRepository _res;
        
        public PhongBusiness(IPhongRepository res)
        {
            _res = res;
        }

        public bool Create(PhongModel model)
        {
            // Business logic validation
            if (model.ma_toa_nha <= 0)
                throw new Exception("Mã tòa nhà không hợp lệ");
            
            if (string.IsNullOrEmpty(model.so_phong))
                throw new Exception("Số phòng không được để trống");
            
            if (model.so_giuong <= 0)
                throw new Exception("Số giường phải lớn hơn 0");
            
            if (string.IsNullOrEmpty(model.loai_phong))
                throw new Exception("Loại phòng không được để trống");
            
            if (model.gia_phong <= 0)
                throw new Exception("Giá phòng phải lớn hơn 0");

            return _res.Create(model);
        }

        public bool Update(PhongModel model)
        {
            // Business logic validation
            if (model.ma_phong <= 0)
                throw new Exception("Mã phòng không hợp lệ");
            
            if (model.ma_toa_nha <= 0)
                throw new Exception("Mã tòa nhà không hợp lệ");
            
            if (string.IsNullOrEmpty(model.so_phong))
                throw new Exception("Số phòng không được để trống");

            return _res.Update(model);
        }

        public PhongModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã phòng không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<PhongModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<PhongModel> Search(int pageIndex, int pageSize, out long total, int? ma_toa_nha, string so_phong)
        {
            return _res.Search(pageIndex, pageSize, out total, ma_toa_nha, so_phong);
        }
    }
}