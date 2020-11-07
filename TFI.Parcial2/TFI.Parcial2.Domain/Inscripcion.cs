using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TFI.Parcial2.Common.Interfaces;

namespace TFI.Parcial2.Domain
{
    public class Inscripcion
    {
        /// <inheritdoc/>
        public int CursoId { get; set; }
        public int AlumnoId { get; set; }
        public BecaType Beca { get; set; }
    }
}
