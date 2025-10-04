using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class TaiKhoanRepository : ITaiKhoanRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public TaiKhoanRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public TaiKhoanModel Authenticate(string tenDangNhap, string matKhau)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_authenticate",
                    "@ten_dang_nhap", tenDangNhap,
                    "@mat_khau", matKhau);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<TaiKhoanModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TaiKhoanModel GetById(int maTaiKhoan)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_getbyid",
                    "@ma_tai_khoan", maTaiKhoan);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<TaiKhoanModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(TaiKhoanModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_taikhoan_create",
                    "@ten_dang_nhap", model.ten_dang_nhap,
                    "@mat_khau", model.mat_khau,
                    "@ho_ten", model.ho_ten,
                    "@email", model.email,
                    "@vai_tro", model.vai_tro);
                
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(TaiKhoanModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_taikhoan_update",
                    "@ma_tai_khoan", model.ma_tai_khoan,
                    "@ten_dang_nhap", model.ten_dang_nhap,
                    "@ho_ten", model.ho_ten,
                    "@email", model.email,
                    "@vai_tro", model.vai_tro,
                    "@trang_thai", model.trang_thai);
                
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TaiKhoanModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_getbyid",
                    "@ma_tai_khoan", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<TaiKhoanModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<TaiKhoanModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<TaiKhoanModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<TaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string ten_dang_nhap, string vai_tro)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_dang_nhap", ten_dang_nhap,
                    "@vai_tro", vai_tro);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<TaiKhoanModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool ChangePassword(int maTaiKhoan, string matKhauMoi)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_taikhoan_changepassword",
                    "@ma_tai_khoan", maTaiKhoan,
                    "@mat_khau_moi", matKhauMoi);
                
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}