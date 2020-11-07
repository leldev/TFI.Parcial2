using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TFI.Parcial2.Common.Interfaces;

namespace TFI.Parcial2.DataAccess
{
    public class SqlHelper
    {
        public static DataTable GetDataTableFromList<T>(IList<T> entities)
            where T : IEntity
        {
            var table = new DataTable();
            table.Columns.Add("CommonValue", typeof(int));

            foreach (var item in entities)
            {
                var row = table.NewRow();
                row["CommonValue"] = item.Id;
                table.Rows.Add(row);
            }

            return table;
        }

        public static SqlParameter GetParameter(string name, string value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.Text,
        };

        public static SqlParameter GetParameter(string name, int value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.Int,
        };

        public static SqlParameter GetParameter(string name, bool value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.Bit,
        };

        public static SqlParameter GetParameter(string name, DateTime value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.DateTime2,
        };

        public static SqlParameter GetParameter(string name, double value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.Decimal,
        };

        public static SqlParameter GetParameter(string name, decimal value) => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            SqlDbType = SqlDbType.Decimal,
        };

        public static SqlParameter GetParameter(string name, DataTable value, string typeName = "TTListInt") => new SqlParameter
        {
            ParameterName = name,
            Value = value,
            TypeName = typeName,
        };
    }
}
