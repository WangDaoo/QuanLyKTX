using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL
{
    public partial interface IToaNhaBusiness
    {
        bool Create(ToaNhaModel model);
        bool Update(ToaNhaModel model);
        ToaNhaModel GetDatabyID(int id);
        List<ToaNhaModel> GetDataAll();
        List<ToaNhaModel> Search(int pageIndex, int pageSize, out long total, string ten_toa_nha);
    }
}