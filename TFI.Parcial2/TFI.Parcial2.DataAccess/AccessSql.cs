using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TFI.Parcial2.DataAccess
{
    public class AccessSql
    {
        private readonly string connectionString = "Server=LAPTOP-F605BNIJ;Database=TFI.Parcial2;User Id=sa;Password=P2ssw0rd;";
        private SqlConnection connection;
        private string message;

        public DataSet Read(string name, List<SqlParameter> parameters = null)
        {
            this.Open();

            var dataSet = new DataSet();
            SqlDataAdapter adapter = new SqlDataAdapter
            {
                SelectCommand = this.CreateCommand(name, parameters),
            };

            try
            {
                adapter.Fill(dataSet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                this.Close();
            }

            return dataSet;
        }

        public int Write(string name, List<SqlParameter> parameters)
        {
            this.Open();

            int result = 0;
            SqlCommand command = this.CreateCommand(name, parameters);
            this.connection.InfoMessage += this.Connection_InfoMessage;

            try
            {
                result = Convert.ToInt32(command.ExecuteScalar());

                // TODO: debbug
                var aux = this.message;
            }
            catch (Exception ex)
            {
                var aux = ex.Message;
                result = -1;
            }
            finally
            {
                this.Close();
            }

            return result;
        }

        private void Connection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            this.message += e.Message;
        }

        private SqlCommand CreateCommand(string name, List<SqlParameter> parameters = null)
        {
            SqlCommand command = new SqlCommand
            {
                Connection = this.connection,
                CommandText = name,
                CommandType = CommandType.StoredProcedure,
            };

            if (parameters != null && parameters.Count > 0)
            {
                command.Parameters.AddRange(parameters.ToArray());
            }

            return command;
        }

        private void Open()
        {
            this.connection = new SqlConnection(this.connectionString);
            this.connection.Open();
        }

        private void Close()
        {
            if (this.connection != null)
            {
                this.connection.Close();
                this.connection = null;
            }

            GC.Collect();
        }
    }
}
