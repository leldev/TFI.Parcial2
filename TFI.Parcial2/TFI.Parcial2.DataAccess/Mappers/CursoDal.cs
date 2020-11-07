using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TFI.Parcial2.Common.Interfaces;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.DataAccess.Mappers
{
    public class CursoDal : ICrud<Curso>
    {
        private readonly AccessSql context;

        public CursoDal()
        {
            this.context = new AccessSql();
        }

        public int Create(Curso entity)
        {
            var parameters = new List<SqlParameter>
            {
                SqlHelper.GetParameter(nameof(Curso.Costo), entity.Costo),
                SqlHelper.GetParameter(nameof(Curso.Cupo), entity.Cupo),
                SqlHelper.GetParameter(nameof(Curso.DisciplinaId), (int)entity.DisciplinaId),
                SqlHelper.GetParameter(nameof(Curso.FechaLimite), entity.FechaLimite),
                SqlHelper.GetParameter(nameof(Curso.Nombre), entity.Nombre),
            };

            return this.context.Write("USP_CreateCurso", parameters);
        }

        public int Delete(Curso entity)
        {
            throw new NotImplementedException();
        }

        public Curso Read(int id)
        {
            var parameters = new List<SqlParameter>
            {
                SqlHelper.GetParameter(nameof(Curso.Id), id),
            };

            var ds = this.context.Read("USP_GetCurso", parameters);

            Curso result = null;

            foreach (DataTable table in ds.Tables)
            {
                foreach (DataRow row in table.Rows)
                {
                    result = GetResult(row);
                }
            }

            return result;
        }

        public IList<Curso> Read()
        {
            var dt = this.context.Read("USP_GetCursos");

            var result = new List<Curso>();

            foreach (DataTable table in dt.Tables)
            {

                foreach (DataRow row in table.Rows)
                {
                    var rowId = Convert.ToInt32(row[nameof(Curso.Id)]);
                    var item = result.FirstOrDefault(x => x.Id.Equals(rowId));

                    if (item == null)
                    {
                        result.Add(GetResult(row));
                    }
                    else
                    {
                        item.Inscripciones.Add(
                            new Inscripcion()
                            {
                                AlumnoId = Convert.ToInt32(row[nameof(Inscripcion.AlumnoId)]),
                                Beca = (BecaType)Convert.ToInt32(row[nameof(Inscripcion.Beca)]),
                                CursoId = Convert.ToInt32(row[nameof(Curso.Id)]),
                            });
                    }
                }
            }

            return result;
        }

        public int Update(Curso entity)
        {
            var parameters = new List<SqlParameter>
            {
                SqlHelper.GetParameter(nameof(Curso.Id), entity.Id),
                SqlHelper.GetParameter(nameof(Curso.Costo), entity.Costo),
                SqlHelper.GetParameter(nameof(Curso.Cupo), entity.Cupo),
                SqlHelper.GetParameter(nameof(Curso.DisciplinaId), (int)entity.DisciplinaId),
                SqlHelper.GetParameter(nameof(Curso.FechaLimite), entity.FechaLimite),
                SqlHelper.GetParameter(nameof(Curso.Nombre), entity.Nombre),
            };

            return this.context.Write("USP_UpdateCurso", parameters);
        }

        public int Inscribe(Curso entity)
        {
            if (entity.Inscripciones.Any())
            {
                var incripcion = entity.Inscripciones[0];

                var parameters = new List<SqlParameter>
                {
                    SqlHelper.GetParameter(nameof(Curso.Id), entity.Id),
                    SqlHelper.GetParameter(nameof(Inscripcion.AlumnoId), incripcion.AlumnoId),
                    SqlHelper.GetParameter(nameof(Inscripcion.Beca), (int)incripcion.Beca),
                };

                return this.context.Write("USP_InscribeCurso", parameters);
            }

            return 0; // error
        }

        private Curso GetResult(DataRow row)
        {
            return new Curso()
            {
                Costo = Convert.ToDecimal(row[nameof(Curso.Costo)]),
                Cupo = Convert.ToInt32(row[nameof(Curso.Cupo)]),
                DisciplinaId = (DisciplinaType)Convert.ToInt32(row[nameof(Curso.DisciplinaId)]),
                Id = Convert.ToInt32(row[nameof(Curso.Id)]),
                Nombre = row[nameof(Curso.Nombre)].ToString(),
                FechaLimite = Convert.ToDateTime(row[nameof(Curso.FechaLimite)]),
                Inscripciones = GetInscripciones(row),
            };
        }

        private IList<Inscripcion> GetInscripciones(DataRow row)
        {
            var result = new List<Inscripcion>();

            if (row.Table.Columns.Contains(nameof(Inscripcion.AlumnoId)))
            {
                if (!row.IsNull(nameof(Inscripcion.AlumnoId)))
                {
                    result.Add(
                        new Inscripcion()
                        {
                            AlumnoId = Convert.ToInt32(row[nameof(Inscripcion.AlumnoId)]),
                            Beca = (BecaType)Convert.ToInt32(row[nameof(Inscripcion.Beca)]),
                            CursoId = Convert.ToInt32(row[nameof(Curso.Id)]),
                        });
                }
            }

            return result;
        }
    }
}
