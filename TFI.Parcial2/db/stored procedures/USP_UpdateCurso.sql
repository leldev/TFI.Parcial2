USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_UpdateCurso]
GO

CREATE PROCEDURE [dbo].[USP_UpdateCurso]
    (
    @Id			           NVARCHAR(22),
    @Nombre		           NVARCHAR(50),
    @DisciplinaId	       INT,
    @Costo				   DECIMAL(18, 2),
	@Cupo				   INT,
	@FechaLimite		   DATETIME2(7)
)
AS

SET NOCOUNT ON;
BEGIN TRANSACTION

UPDATE [dbo].[Curso]
SET 
[Nombre] = @Nombre,
[DisciplinaID] = @DisciplinaId,
[Costo] = @Costo,
[Cupo] = @Cupo,
[FechaLimite] = @FechaLimite
WHERE [CursoID] = @Id

IF @@ERROR <> 0
BEGIN
    ROLLBACK
    RETURN
END

COMMIT
SELECT @Id