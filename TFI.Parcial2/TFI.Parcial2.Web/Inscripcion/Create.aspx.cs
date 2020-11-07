using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TFI.Parcial2.Business;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Web.Empleado
{
    public partial class Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    this.Build();
                }
            }
            catch (Exception ex)
            {
                this.ShowError(ex.Message);
            }
        }

        private void Build()
        {
            var cursos = new CursoBll().Read();
            var alumnos = new AlumnoBll().Read();

            foreach (var item in cursos)
            {
                this.DdlCurso.Items.Add(new ListItem(item.Nombre, item.Id.ToString()));
            }

            foreach (var item in alumnos)
            {
                this.DdlAlumno.Items.Add(new ListItem(item.Nombre, item.Id.ToString()));
            }

            this.DdlBeca.Items.Add(new ListItem("Regular", ((int)BecaType.Regular).ToString()));
            this.DdlBeca.Items.Add(new ListItem("Media Beca", ((int)BecaType.MediaBeca).ToString()));
            this.DdlBeca.Items.Add(new ListItem("80%", ((int)BecaType.Beca80).ToString()));
        }

        private void ShowError(string message, bool showMainPanel = false)
        {
            this.LblError.Text = message;
            this.LblError.Visible = true;
            this.PnlMain.Visible = showMainPanel;
        }

        protected void BtnCreate_Click(object sender, EventArgs e)
        {
            try
            {
                var curso = new Domain.Curso()
                {
                    Id = Convert.ToInt32(this.DdlCurso.SelectedValue),
                };

                curso.Inscripciones.Add(new Inscripcion()
                {

                    CursoId = Convert.ToInt32(this.DdlCurso.SelectedValue),
                    AlumnoId = Convert.ToInt32(this.DdlAlumno.SelectedValue),
                    Beca = (BecaType)Convert.ToInt32(this.DdlBeca.SelectedValue)
                });

                var result = new CursoBll().Inscribe(curso);

                if (result > 0)
                {
                    this.Response.Redirect("/Curso", false);
                }
                else
                {
                    this.ShowError(GetErrorMessage(result), true);
                }
            }
            catch (Exception ex)
            {
                this.ShowError(ex.Message, true);
            }
        }

        private static string GetErrorMessage(int code)
        {
            var result = "Se produjo un error inesperado, inténtalo de nuevo.";

            switch (code)
            {
                case -2:
                    result = "No se puede inscribir un alumno fuera de fecha en el curso seleccionado.";
                    break;
                case -3:
                    result = "El alumno seleccionado ya se encuentra inscrito en el curso.";
                    break;
                case -4:
                    result = "No se puede inscribir un alumno porque el curso está completo.";
                    break;
                default:
                    break;
            }

            return result;
        }
    }
}