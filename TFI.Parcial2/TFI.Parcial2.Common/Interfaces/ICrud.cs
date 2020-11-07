namespace TFI.Parcial2.Common.Interfaces
{
    using System.Collections.Generic;

    /// <summary>
    /// ICrud.
    /// </summary>
    /// <typeparam name="T">IEntity.</typeparam>
    public interface ICrud<T>
        where T : IEntity
    {
        /// <summary>
        /// Create.
        /// </summary>
        /// <param name="entity">IEntity.</param>
        /// <returns>int.</returns>
        int Create(T entity);

        /// <summary>
        /// Read.
        /// </summary>
        /// <param name="id">IEntity id.</param>
        /// <returns>IEntity.</returns>
        T Read(int id);

        /// <summary>
        /// Read.
        /// </summary>
        /// <returns>List IEntity.</returns>
        IList<T> Read();

        /// <summary>
        /// Update.
        /// </summary>
        /// <param name="entity">IEntity.</param>
        /// <returns>int.</returns>
        int Update(T entity);

        /// <summary>
        /// Delete.
        /// </summary>
        /// <param name="entity">IEntity.</param>
        /// <returns>int.</returns>
        int Delete(T entity);
    }
}
