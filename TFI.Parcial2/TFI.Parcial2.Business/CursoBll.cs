using System;
using System.Collections.Generic;
using TFI.Parcial2.Common.Interfaces;
using TFI.Parcial2.DataAccess.Mappers;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Business
{
    public class CursoBll : ICrud<Curso>
    {
        private readonly CursoDal mapper;

        public CursoBll()
        {
            this.mapper = new CursoDal();
        }

        public int Create(Curso entity)
        {
            return this.mapper.Create(entity);
        }

        public int Delete(Curso entity)
        {
            throw new NotImplementedException();
        }

        public Curso Read(int id)
        {
            return this.mapper.Read(id);
        }

        public IList<Curso> Read()
        {
            return this.mapper.Read();
        }

        public int Update(Curso entity)
        {
            return this.mapper.Update(entity);
        }

        public int Inscribe(Curso entity)
        {
            return this.mapper.Inscribe(entity);
        }
    }
}