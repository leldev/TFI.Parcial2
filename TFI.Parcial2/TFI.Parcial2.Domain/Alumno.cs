using TFI.Parcial2.Common.Interfaces;

namespace TFI.Parcial2.Domain
{
    public class Alumno : IEntity
    {
        /// <inheritdoc/>
        public int Id { get; set; }
        public string Nombre { get; set; }
    }
}
