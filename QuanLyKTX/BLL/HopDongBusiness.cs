using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public partial class HopDongBusiness : IHopDongBusiness
    {
        private IHopDongRepository _res;
        
        public HopDongBusiness(IHopDongRepository res)
        {
            _res = res;
        }

        public bool Create(HopDongModel model)
        {
            // Business logic validation
            if (model.ma_sinh_vien <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");
            
            if (model.ma_giuong <= 0)
                throw new Exception("Mã giường không hợp lệ");
            
            if (model.ngay_bat_dau >= model.ngay_ket_thuc)
                throw new Exception("Ngày bắt đầu phải nhỏ hơn ngày kết thúc");
            
            if (model.gia_phong <= 0)
                throw new Exception("Giá phòng phải lớn hơn 0");

            return _res.Create(model);
        }

        public bool Update(HopDongModel model)
        {
            // Business logic validation
            if (model.ma_hop_dong <= 0)
                throw new Exception("Mã hợp đồng không hợp lệ");
            
            if (model.ma_sinh_vien <= 0)
                throw new Exception("Mã sinh viên không hợp lệ");
            
            if (model.ma_giuong <= 0)
                throw new Exception("Mã giường không hợp lệ");

            return _res.Update(model);
        }

        public HopDongModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã hợp đồng không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<HopDongModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<HopDongModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai)
        {
            return _res.Search(pageIndex, pageSize, out total, ma_sinh_vien, trang_thai);
        }
    }
}