using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL
{
    public partial interface IGiuongBusiness
    {
        bool Create(GiuongModel model);
        bool Update(GiuongModel model);
        GiuongModel GetDatabyID(int id);
        List<GiuongModel> GetDataAll();
        List<GiuongModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string so_giuong);
    }
}