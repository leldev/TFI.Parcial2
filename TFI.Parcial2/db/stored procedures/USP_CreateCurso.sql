USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_CreateCurso]
GO

CREATE PROCEDURE [dbo].[USP_CreateCurso]
    (
    @Nombre		           NVARCHAR(50),
    @DisciplinaId	       INT,
    @Costo				   DECIMAL(18, 2),
	@Cupo				   INT,
	@FechaLimite		   DATETIME2(7)
)
AS

SET NOCOUNT ON;
BEGIN TRANSACTION
DECLARE @NewId INT;

INSERT INTO [dbo].[Curso]
    ([Costo], [Cupo], [DisciplinaID], [FechaLimite], [Nombre])
VALUES
    (@Costo, @Cupo, @DisciplinaId, @FechaLimite, @Nombre)
SET @NewId = SCOPE_IDENTITY();

IF @@ERROR <> 0
BEGIN
    ROLLBACK
    RETURN
END

COMMIT
SELECT @NewId