using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL
{
    public partial interface ISinhVienBusiness
    {
        bool Create(SinhVienModel model);
        bool Update(SinhVienModel model);
        SinhVienModel GetDatabyID(int id);
        List<SinhVienModel> GetDataAll();
        List<SinhVienModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string ho_ten);
    }
}