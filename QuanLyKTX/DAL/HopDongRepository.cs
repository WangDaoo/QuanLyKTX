using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class HopDongRepository : IHopDongRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public HopDongRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(HopDongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hopdong_create",
                    "@ma_sinh_vien", model.ma_sinh_vien,
                    "@ma_giuong", model.ma_giuong,
                    "@ngay_bat_dau", model.ngay_bat_dau,
                    "@ngay_ket_thuc", model.ngay_ket_thuc,
                    "@gia_phong", model.gia_phong,
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

        public bool Update(HopDongModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hopdong_update",
                    "@ma_hop_dong", model.ma_hop_dong,
                    "@ma_sinh_vien", model.ma_sinh_vien,
                    "@ma_giuong", model.ma_giuong,
                    "@ngay_bat_dau", model.ngay_bat_dau,
                    "@ngay_ket_thuc", model.ngay_ket_thuc,
                    "@gia_phong", model.gia_phong,
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

        public bool Delete(int maHopDong)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hopdong_delete",
                    "@ma_hop_dong", maHopDong);
                
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

        public HopDongModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hopdong_getbyid",
                    "@ma_hop_dong", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<HopDongModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HopDongModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hopdong_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<HopDongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HopDongModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hopdong_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_sinh_vien", ma_sinh_vien,
                    "@trang_thai", trang_thai);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<HopDongModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}