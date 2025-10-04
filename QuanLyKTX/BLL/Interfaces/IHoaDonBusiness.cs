using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL
{
    public partial interface IHoaDonBusiness
    {
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
        HoaDonModel GetDatabyID(int id);
        List<HoaDonModel> GetDataAll();
        List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai);
    }
}