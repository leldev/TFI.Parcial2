USE [TFI.Parcial2]
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[AlumnoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Alumno] PRIMARY KEY CLUSTERED 
(
	[AlumnoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Beca]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beca](
	[BecaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Beca] PRIMARY KEY CLUSTERED 
(
	[BecaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Curso]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curso](
	[CursoID] [int] IDENTITY(1,1) NOT NULL,
	[DisciplinaID] [int] NOT NULL,
	[Costo] [decimal](18, 2) NOT NULL,
	[FechaLimite] [datetime2](7) NOT NULL,
	[Cupo] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Curso] PRIMARY KEY CLUSTERED 
(
	[CursoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Disciplina]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disciplina](
	[DisciplinaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Disciplina] PRIMARY KEY CLUSTERED 
(
	[DisciplinaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripcion](
	[CursoID] [int] NOT NULL,
	[AlumnoID] [int] NOT NULL,
	[BecaID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [FK_Curso_Disciplina] FOREIGN KEY([DisciplinaID])
REFERENCES [dbo].[Disciplina] ([DisciplinaID])
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [FK_Curso_Disciplina]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Alumno] FOREIGN KEY([AlumnoID])
REFERENCES [dbo].[Alumno] ([AlumnoID])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Alumno]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Beca] FOREIGN KEY([BecaID])
REFERENCES [dbo].[Beca] ([BecaID])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Beca]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Curso] FOREIGN KEY([CursoID])
REFERENCES [dbo].[Curso] ([CursoID])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Curso]
GO
/****** Object:  StoredProcedure [dbo].[USP_CreateAlumno]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_CreateAlumno]
    (
	@Nombre			   NVARCHAR(50)
)
AS

SET NOCOUNT ON;
BEGIN TRANSACTION
DECLARE @NewId INT;

INSERT INTO [dbo].[Alumno]
    ([Nombre])
VALUES
    (@Nombre)
SET @NewId = SCOPE_IDENTITY();

IF @@ERROR <> 0
BEGIN
    ROLLBACK
    RETURN
END

COMMIT
SELECT @NewId
GO
/****** Object:  StoredProcedure [dbo].[USP_CreateCurso]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAlumnos]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_GetAlumnos]
AS

SET NOCOUNT ON;

SELECT
    a.[AlumnoID] AS Id, a.[Nombre]
FROM [dbo].[Alumno] a
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCurso]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCursos]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
/****** Object:  StoredProcedure [dbo].[USP_InscribeCurso]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateCurso]    Script Date: 11/7/2020 12:52:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
GO
