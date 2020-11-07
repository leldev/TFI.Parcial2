USE [TFI.Parcial2]
GO

DROP PROCEDURE IF EXISTS [dbo].[USP_InscribeCurso]
GO

CREATE PROCEDURE [dbo].[USP_InscribeCurso]
    (
    @Id		           INT,
    @AlumnoId	       INT,
    @Beca			   INT
)
AS

SET NOCOUNT ON;
BEGIN TRANSACTION

DECLARE @CursoFechaLimite		DATETIME2(7);
DECLARE @CursoAlumnoId			INT;
DECLARE @CursoCupo				INT;
DECLARE @CursoCant				INT;

/******************* Get fecha curso *******************/
SELECT @CursoFechaLimite = c.[FechaLimite], @CursoCupo = c.[Cupo]
FROM [dbo].[Curso] c
WHERE c.[CursoID] = @Id

IF (GETDATE() > @CursoFechaLimite)
	/******************* No se puede incribir por fecha *******************/
	BEGIN
		ROLLBACK
		SELECT -2
		RETURN
	END
ELSE
	BEGIN
	/******************* Get alumno in curso *******************/
	SELECT @CursoAlumnoId = i.[AlumnoID]
	FROM [dbo].[Inscripcion] i
	WHERE i.[CursoID] = @Id AND i.[AlumnoID] = @AlumnoId

	print @CursoAlumnoId
	print @AlumnoId
	IF (@CursoAlumnoId = @AlumnoId)
	/******************* Alumno in curso *******************/
	BEGIN
		ROLLBACK
		SELECT -3
		RETURN
	END
	ELSE
		BEGIN

		/******************* Get alumnos inscripto *******************/
		SELECT @CursoCant = COUNT(i.[CursoID])
		FROM [dbo].[Inscripcion] i
		WHERE i.[CursoID] = @Id
		GROUP BY i.[CursoID]
		
		print @CursoCupo
		print @CursoCant
		IF (@CursoCant >= @CursoCupo)
		/******************* Curso sold *******************/
			BEGIN
				ROLLBACK
				SELECT -4
				RETURN
			END
		ELSE
			BEGIN
			INSERT INTO [dbo].[Inscripcion]
				([CursoID], [AlumnoID], [BecaID])
			VALUES
				(@Id, @AlumnoId, @Beca)

			IF @@ERROR <> 0
			BEGIN
				ROLLBACK
				RETURN
			END

			COMMIT
			SELECT @Id
		END
	END
END