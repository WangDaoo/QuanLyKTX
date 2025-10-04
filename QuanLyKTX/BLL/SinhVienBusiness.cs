using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class SinhVienBusiness : ISinhVienBusiness
    {
        private ISinhVienRepository _res;
        
        public SinhVienBusiness(ISinhVienRepository res)
        {
            _res = res;
        }

        public bool Create(SinhVienModel model)
        {
            // Business logic validation
            if (string.IsNullOrEmpty(model.ho_ten))
                throw new Exception("Họ tên không được để trống");
            
            if (string.IsNullOrEmpty(model.mssv))
                throw new Exception("MSSV không được để trống");
            
            if (string.IsNullOrEmpty(model.lop))
                throw new Exception("Lớp không được để trống");
            
            if (string.IsNullOrEmpty(model.khoa))
                throw new Exception("Khoa không được để trống");

            return _res.Create(model);
        }

        public bool Update(SinhVienModel model)
        {
            // Business logic validation
            if (model.ma_sinh_vien <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");
            
            if (string.IsNullOrEmpty(model.ho_ten))
                throw new Exception("Họ tên không được để trống");
            
            if (string.IsNullOrEmpty(model.mssv))
                throw new Exception("MSSV không được để trống");

            return _res.Update(model);
        }

        public SinhVienModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<SinhVienModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<SinhVienModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string ho_ten)
        {
            return _res.Search(pageIndex, pageSize, out total, ma_phong, ho_ten);
        }
    }
}