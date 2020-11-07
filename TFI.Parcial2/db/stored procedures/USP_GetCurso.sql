USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_GetCurso]
GO

CREATE PROCEDURE [dbo].[USP_GetCurso]
(
    @Id			       INT
)
AS

SET NOCOUNT ON;

SELECT
    c.[CursoID] AS id, c.[Costo], c.[Cupo], c.[DisciplinaID], c.[FechaLimite], c.[Nombre]
FROM [dbo].[Curso] c
WHERE c.[CursoID] = @Id
