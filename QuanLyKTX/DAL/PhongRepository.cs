using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class PhongRepository : IPhongRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public PhongRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(PhongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_phong_create",
                    "@ma_toa_nha", model.ma_toa_nha,
                    "@so_phong", model.so_phong,
                    "@so_giuong", model.so_giuong,
                    "@loai_phong", model.loai_phong,
                    "@gia_phong", model.gia_phong,
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

        public bool Update(PhongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_phong_update",
                    "@ma_phong", model.ma_phong,
                    "@ma_toa_nha", model.ma_toa_nha,
                    "@so_phong", model.so_phong,
                    "@so_giuong", model.so_giuong,
                    "@loai_phong", model.loai_phong,
                    "@gia_phong", model.gia_phong,
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

        public bool Delete(int maPhong)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_phong_delete",
                    "@ma_phong", maPhong);
                
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

        public PhongModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_phong_getbyid",
                    "@ma_phong", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<PhongModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PhongModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_phong_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<PhongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PhongModel> Search(int pageIndex, int pageSize, out long total, int? ma_toa_nha, string so_phong)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_phong_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_toa_nha", ma_toa_nha,
                    "@so_phong", so_phong);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<PhongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}