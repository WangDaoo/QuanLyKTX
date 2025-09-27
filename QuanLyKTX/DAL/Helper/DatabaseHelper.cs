using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DAL.Helper
{
    public class DatabaseHelper : IDatabaseHelper
    {
        public string StrConnection { get; set; }
        public SqlConnection sqlConnection { get; set; }
        public SqlTransaction sqlTransaction { get; set; }

        public DatabaseHelper(IConfiguration configuration)
        {
            var configured = configuration["ConnectionStrings:DefaultConnection"];
            if (string.IsNullOrWhiteSpace(configured))
            {
                throw new InvalidOperationException("ConnectionStrings:DefaultConnection is not configured.");
            }
            StrConnection = configured;
        }

        public void SetConnectionString(string connectionString)
        {
            StrConnection = connectionString;
        }

        public string OpenConnection()
        {
            try
            {
                if (string.IsNullOrWhiteSpace(StrConnection))
                {
                    throw new InvalidOperationException("Connection string is null or empty.");
                }
                if (sqlConnection == null)
                    sqlConnection = new SqlConnection(StrConnection);

                if (sqlConnection.State != ConnectionState.Open)
                    sqlConnection.Open();

                return "";
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }

        public string CloseConnection()
        {
            try
            {
                if (sqlConnection != null && sqlConnection.State != ConnectionState.Closed)
                    sqlConnection.Close();
                return "";
            }
            catch (Exception exception)
            {
                return exception.Message;
            }
        }

        public string ExecuteNoneQuery(string strquery)
        {
            string msgError = "";
            try
            {
                OpenConnection();
                var sqlCommand = new SqlCommand(strquery, sqlConnection);
                sqlCommand.ExecuteNonQuery();
                sqlCommand.Dispose();
            }
            catch (Exception exception)
            {
                msgError = exception.ToString();
            }
            finally
            {
                CloseConnection();
            }
            return msgError;
        }

        public DataTable ExecuteQueryToDataTable(string strquery, out string msgError)
        {
            msgError = "";
            var result = new DataTable();
            var sqlDataAdapter = new SqlDataAdapter(strquery, StrConnection);
            try
            {
                sqlDataAdapter.Fill(result);
            }
            catch (Exception exception)
            {
                msgError = exception.ToString();
                result = null;
            }
            finally
            {
                sqlDataAdapter.Dispose();
            }
            return result;
        }

        public object ExecuteScalar(string strquery, out string msgError)
        {
            object result = null;
            try
            {
                OpenConnection();
                var sqlCommand = new SqlCommand(strquery, sqlConnection);
                result = sqlCommand.ExecuteScalar();
                sqlCommand.Dispose();
                msgError = "";
            }
            catch (Exception ex) 
            { 
                msgError = ex.StackTrace; 
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }

        public string ExecuteSProcedure(string sprocedureName, params object[] paramObjects)
        {
            string result = "";
            SqlConnection connection = new SqlConnection(StrConnection);
            try
            {
                SqlCommand cmd = new SqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection.Open();
                cmd.Connection = connection;
                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    cmd.Parameters.Add(new SqlParameter(paramName, value ?? DBNull.Value));
                }
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception exception)
            {
                result = exception.ToString();
            }
            finally
            {
                connection.Close();
            }
            return result;
        }

        public object ExecuteScalarSProcedure(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            msgError = "";
            object result = null;
            SqlConnection connection = new SqlConnection(StrConnection);
            try
            {
                SqlCommand cmd = new SqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection.Open();
                cmd.Connection = connection;
                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]);
                    object value = paramObjects[j++];
                    cmd.Parameters.Add(new SqlParameter(paramName, value ?? DBNull.Value));
                }
                result = cmd.ExecuteScalar();
                cmd.Dispose();
            }
            catch (Exception exception)
            {
                result = null;
                msgError = exception.ToString();
            }
            finally
            {
                connection.Close();
            }
            return result;
        }

        public DataTable ExecuteSProcedureReturnDataTable(out string msgError, string sprocedureName, params object[] paramObjects)
        {
            DataTable tb = new DataTable();
            SqlConnection connection;
            try
            {
                SqlCommand cmd = new SqlCommand { CommandType = CommandType.StoredProcedure, CommandText = sprocedureName };
                connection = new SqlConnection(StrConnection);
                cmd.Connection = connection;

                int parameterInput = (paramObjects.Length) / 2;
                int j = 0;
                for (int i = 0; i < parameterInput; i++)
                {
                    string paramName = Convert.ToString(paramObjects[j++]).Trim();
                    object value = paramObjects[j++];
                    cmd.Parameters.Add(new SqlParameter(paramName, value ?? DBNull.Value));
                }

                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                ad.Fill(tb);
                cmd.Dispose();
                ad.Dispose();
                connection.Dispose();
                msgError = "";
            }
            catch (Exception exception)
            {
                tb = null;
                msgError = exception.ToString();
            }
            return tb;
        }
    }
}