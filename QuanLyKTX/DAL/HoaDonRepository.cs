using DAL.Helper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAL
{
    public partial class HoaDonRepository : IHoaDonRepository
    {
        private IDatabaseHelper _dbHelper;
        
        public HoaDonRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hoadon_create",
                    "@ma_sinh_vien", model.ma_sinh_vien,
                    "@ma_phong", model.ma_phong,
                    "@ma_hop_dong", model.ma_hop_dong,
                    "@thang", model.thang,
                    "@nam", model.nam,
                    "@tong_tien", model.tong_tien,
                    "@trang_thai", model.trang_thai,
                    "@ngay_het_han", model.ngay_het_han,
                    "@ngay_thanh_toan", model.ngay_thanh_toan,
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

        public bool Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hoadon_update",
                    "@ma_hoa_don", model.ma_hoa_don,
                    "@ma_sinh_vien", model.ma_sinh_vien,
                    "@ma_phong", model.ma_phong,
                    "@ma_hop_dong", model.ma_hop_dong,
                    "@thang", model.thang,
                    "@nam", model.nam,
                    "@tong_tien", model.tong_tien,
                    "@trang_thai", model.trang_thai,
                    "@ngay_het_han", model.ngay_het_han,
                    "@ngay_thanh_toan", model.ngay_thanh_toan,
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

        public bool Delete(int maHoaDon)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedure(out msgError, "sp_hoadon_delete",
                    "@ma_hoa_don", maHoaDon);
                
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

        public HoaDonModel GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoadon_getbyid",
                    "@ma_hoa_don", id);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<HoaDonModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HoaDonModel> GetDataAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoadon_getall");
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                return dt.ConvertToModel<HoaDonModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HoaDonModel> Search(int pageIndex, int pageSize, out long total, int? ma_sinh_vien, string trang_thai)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoadon_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_sinh_vien", ma_sinh_vien,
                    "@trang_thai", trang_thai);
                
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertToModel<HoaDonModel>();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}