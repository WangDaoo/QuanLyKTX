using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface ISinhVienRepository
    {
        bool Create(SinhVienModel model);
        bool Update(SinhVienModel model);
        SinhVienModel GetDatabyID(int id);
        List<SinhVienModel> GetDataAll();
        List<SinhVienModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string ho_ten);
    }
}