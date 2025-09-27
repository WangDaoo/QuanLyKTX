using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class SinhVienRepository : ISinhVienRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public SinhVienRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(SinhVienModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_sinhvien_create",
                    "@ho_ten", model.ho_ten,
                    "@mssv", model.mssv,
                    "@lop", model.lop,
                    "@khoa", model.khoa,
                    "@ngay_sinh", model.ngay_sinh,
                    "@gioi_tinh", model.gioi_tinh,
                    "@sdt", model.sdt,
                    "@email", model.email,
                    "@dia_chi", model.dia_chi,
                    "@anh_dai_dien", model.anh_dai_dien,
                    "@ma_phong", model.ma_phong);
                
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

        public bool Update(SinhVienModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_sinhvien_update",
                    "@ma_sinh_vien", model.ma_sinh_vien,
                    "@ho_ten", model.ho_ten,
                    "@mssv", model.mssv,
                    "@lop", model.lop,
                    "@khoa", model.khoa,
                    "@ngay_sinh", model.ngay_sinh,
                    "@gioi_tinh", model.gioi_tinh,
                    "@sdt", model.sdt,
                    "@email", model.email,
                    "@dia_chi", model.dia_chi,
                    "@anh_dai_dien", model.anh_dai_dien,
                    "@ma_phong", model.ma_phong);
                
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

        public SinhVienModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sinhvien_getbyid",
                    "@ma_sinh_vien", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<SinhVienModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SinhVienModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sinhvien_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<SinhVienModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SinhVienModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string ho_ten)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_sinhvien_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_phong", ma_phong,
                    "@ho_ten", ho_ten);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<SinhVienModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}