using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class ToaNhaRepository : IToaNhaRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public ToaNhaRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(ToaNhaModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_toanha_create",
                    "@ten_toa_nha", model.ten_toa_nha,
                    "@dia_chi", model.dia_chi,
                    "@so_tang", model.so_tang,
                    "@mo_ta", model.mo_ta,
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

        public bool Update(ToaNhaModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_toanha_update",
                    "@ma_toa_nha", model.ma_toa_nha,
                    "@ten_toa_nha", model.ten_toa_nha,
                    "@dia_chi", model.dia_chi,
                    "@so_tang", model.so_tang,
                    "@mo_ta", model.mo_ta,
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

        public bool Delete(int maToaNha)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_toanha_delete",
                    "@ma_toa_nha", maToaNha);
                
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

        public ToaNhaModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_toanha_getbyid",
                    "@ma_toa_nha", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<ToaNhaModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ToaNhaModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_toanha_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<ToaNhaModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ToaNhaModel> Search(int pageIndex, int pageSize, out long total, string ten_toa_nha)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_toanha_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_toa_nha", ten_toa_nha);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<ToaNhaModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}