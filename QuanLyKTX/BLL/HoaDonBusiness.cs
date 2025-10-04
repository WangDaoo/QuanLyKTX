using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class HoaDonBusiness : IHoaDonBusiness
    {
        private IHoaDonRepository _res;
        
        public HoaDonBusiness(IHoaDonRepository res)
        {
            _res = res;
        }

        public bool Create(HoaDonModel model)
        {
            // Business logic validation
            if (model.ma_sinh_vien <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");
            
            if (model.thang < 1 || model.thang > 12)
                throw new Exception("Tháng phải từ 1 đến 12");
            
            if (model.nam < 2020 || model.nam > 2030)
                throw new Exception("Năm phải từ 2020 đến 2030");
            
            if (model.tong_tien <= 0)
                throw new Exception("Tổng tiền phải lớn hơn 0");

            return _res.Create(model);
        }

        public bool Update(HoaDonModel model)
        {
            // Business logic validation
            if (model.ma_hoa_don <= 0)
                throw new Exception("Mã hóa đơn không hợp lệ");
            
            if (model.ma_sinh_vien <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");

            return _res.Update(model);
        }

        public HoaDonModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã hóa đơn không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<HoaDonModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai)
        {
            return _res.Search(pageIndex, pageSize, out total, ma_sinh_vien, trang_thai);
        }
    }
}