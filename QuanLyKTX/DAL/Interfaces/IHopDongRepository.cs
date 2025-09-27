using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface IHopDongRepository
    {
        bool Create(HopDongModel model);
        bool Update(HopDongModel model);
        HopDongModel GetDatabyID(int id);
        List<HopDongModel> GetDataAll();
        List<HopDongModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai);
    }
}