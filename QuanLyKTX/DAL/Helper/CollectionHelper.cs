using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;

namespace DAL.Helper
{
    public static class CollectionHelper
    {
        public static List<T> ConvertToModel<T>(this DataTable dt) where T : new()
        {
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T item = new T();
                foreach (DataColumn column in dt.Columns)
                {
                    PropertyInfo property = typeof(T).GetProperty(column.ColumnName);
                    if (property != null && row[column] != DBNull.Value)
                    {
                        property.SetValue(item, row[column], null);
                    }
                }
                data.Add(item);
            }
            return data;
        }
    }
}