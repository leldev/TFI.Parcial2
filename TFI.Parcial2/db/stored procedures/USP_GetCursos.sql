USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_GetCursos]
GO

CREATE PROCEDURE [dbo].[USP_GetCursos]
AS

SET NOCOUNT ON;

SELECT
    c.[CursoID] AS id, c.[Costo], c.[Cupo], c.[DisciplinaID], c.[FechaLimite], c.[Nombre],
	i.[AlumnoID] AS AlumnoId, i.[BecaID] AS Beca, i.[CursoID] AS CursoId
FROM [dbo].[Curso] c
LEFT JOIN [dbo].[Inscripcion] i ON i.[CursoID] = c.[CursoID]
ORDER BY c.[Nombre] ASC
