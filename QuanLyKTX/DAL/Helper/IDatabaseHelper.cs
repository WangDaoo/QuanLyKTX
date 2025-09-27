using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace DAL.Helper
{
    public interface IDatabaseHelper
    {
        string StrConnection { get; set; }
        string OpenConnection();
        string CloseConnection();
        string ExecuteNoneQuery(string strquery);
        DataTable ExecuteQueryToDataTable(string strquery, out string msgError);
        object ExecuteScalar(string strquery, out string msgError);
        string ExecuteSProcedure(string sprocedureName, params object[] paramObjects);
        object ExecuteScalarSProcedure(out string msgError, string sprocedureName, params object[] paramObjects);
        DataTable ExecuteSProcedureReturnDataTable(out string msgError, string sprocedureName, params object[] paramObjects);
    }
}