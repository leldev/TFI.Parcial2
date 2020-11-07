USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_GetAlumnos]
GO

CREATE PROCEDURE [dbo].[USP_GetAlumnos]
AS

SET NOCOUNT ON;

SELECT
    a.[AlumnoID] AS Id, a.[Nombre]
FROM [dbo].[Alumno] a