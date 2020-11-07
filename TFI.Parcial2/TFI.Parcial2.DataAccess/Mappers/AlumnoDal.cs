using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TFI.Parcial2.Common.Interfaces;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.DataAccess.Mappers
{
    public class AlumnoDal : ICrud<Alumno>
    {
        private readonly AccessSql context;

        public AlumnoDal()
        {
            this.context = new AccessSql();
        }

        public int Create(Alumno entity)
        {
            var parameters = new List<SqlParameter>
            {
                SqlHelper.GetParameter(nameof(Alumno.Nombre), entity.Nombre),
            };

            return this.context.Write("USP_CreateAlumno", parameters);
        }

        public int Delete(Alumno entity)
        {
            throw new NotImplementedException();
        }

        public Alumno Read(int id)
        {
            throw new NotImplementedException();
        }

        public IList<Alumno> Read()
        {
            var dt = this.context.Read("USP_GetAlumnos");

            var result = new List<Alumno>();

            foreach (DataTable table in dt.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    result.Add(GetResult(row));
                }
            }

            return result;
        }

        public int Update(Alumno entity)
        {
            throw new NotImplementedException();
        }

        private Alumno GetResult(DataRow row)
        {
            return new Alumno()
            {
                Id = Convert.ToInt32(row[nameof(Alumno.Id)]),
                Nombre = row[nameof(Alumno.Nombre)].ToString(),
            };
        }
    }
}
