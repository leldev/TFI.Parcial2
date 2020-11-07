using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TFI.Parcial2.Common.Interfaces;
using TFI.Parcial2.DataAccess.Mappers;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Business
{
    public class AlumnoBll : ICrud<Alumno>
    {
        private readonly AlumnoDal mapper;

        public AlumnoBll()
        {
            this.mapper = new AlumnoDal();
        }

        public int Create(Alumno entity)
        {
            return this.mapper.Create(entity);
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
            return this.mapper.Read();
        }

        public int Update(Alumno entity)
        {
            throw new NotImplementedException();
        }
    }
}