using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace BLL
{
    public partial interface ITaiKhoanBusiness
    {
        bool Create(TaiKhoanModel model);
        bool Update(TaiKhoanModel model);
        TaiKhoanModel GetDatabyID(int id);
        List<TaiKhoanModel> GetDataAll();
        List<TaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string ten_dang_nhap, string vai_tro);
        LoginResponse Authenticate(LoginRequest request);
        bool ChangePassword(int maTaiKhoan, string matKhauMoi, string matKhauCu);
    }
}