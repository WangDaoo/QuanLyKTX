using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class GiuongRepository : IGiuongRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public GiuongRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(GiuongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_giuong_create",
                    "@ma_phong", model.ma_phong,
                    "@so_giuong", model.so_giuong,
                    "@trang_thai", model.trang_thai,
                    "@ghi_chu", model.ghi_chu);
                
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

        public bool Update(GiuongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_giuong_update",
                    "@ma_giuong", model.ma_giuong,
                    "@ma_phong", model.ma_phong,
                    "@so_giuong", model.so_giuong,
                    "@trang_thai", model.trang_thai,
                    "@ghi_chu", model.ghi_chu);
                
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

        public bool Delete(int maGiuong)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_giuong_delete",
                    "@ma_giuong", maGiuong);
                
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

        public GiuongModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_giuong_getbyid",
                    "@ma_giuong", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<GiuongModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<GiuongModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_giuong_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<GiuongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<GiuongModel> Search(int pageIndex, int pageSize, out long total, int? ma_phong, string so_giuong)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_giuong_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_phong", ma_phong,
                    "@so_giuong", so_giuong);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<GiuongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}