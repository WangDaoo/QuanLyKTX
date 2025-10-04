using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface IPhongRepository
    {
        bool Create(PhongModel model);
        bool Update(PhongModel model);
        PhongModel GetDatabyID(int id);
        List<PhongModel> GetDataAll();
        List<PhongModel> Search(int pageIndex, int pageSize, out long total, int? ma_toa_nha, string so_phong);
    }
}