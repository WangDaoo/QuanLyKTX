using Model;
using System;
using System.Collections.Generic;
using System.Text;

namespace DAL
{
    public partial interface ITaiKhoanRepository
    {
        bool Create(TaiKhoanModel model);
        bool Update(TaiKhoanModel model);
        TaiKhoanModel GetDatabyID(int id);
        List<TaiKhoanModel> GetDataAll();
        List<TaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string ten_dang_nhap, string vai_tro);
        TaiKhoanModel Authenticate(string tenDangNhap, string matKhau);
        bool ChangePassword(int maTaiKhoan, string matKhauMoi);
    }
}