using System;
using System.Collections.Generic;
using TFI.Parcial2.Common.Interfaces;

namespace TFI.Parcial2.Domain
{
    public class Curso : IEntity
    {
        public Curso()
        {
            this.Inscripciones = new List<Inscripcion>();
        }

        /// <inheritdoc/>
        public int Id { get; set; }
        public string Nombre { get; set; }
        public DisciplinaType DisciplinaId { get; set; }
        public decimal Costo { get; set; }
        public DateTime FechaLimite { get; set; }
        public int Cupo { get; set; }
        public virtual IList<Inscripcion> Inscripciones { get; set; }
    }
}
