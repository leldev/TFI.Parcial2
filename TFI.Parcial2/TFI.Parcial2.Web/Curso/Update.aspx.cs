using System;
using System.Web.UI.WebControls;
using TFI.Parcial2.Business;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Web.Curso
{
    public partial class Update : System.Web.UI.Page
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
            var id = Convert.ToInt32(this.Request.QueryString["Id"]);
            if (id == 0)
            {
                this.ShowError("Elemento no encontrado.");
            }
            else
            {
                var result = new CursoBll().Read(id);

                if (result == null)
                {
                    this.ShowError("Elemento no encontrado.");
                }
                else
                {
                    foreach (DisciplinaType type in Enum.GetValues(typeof(DisciplinaType)))
                    {
                        DdlDisciplina.Items.Add(new ListItem(type.ToString(), ((int)type).ToString()));
                    }

                    this.DdlDisciplina.SelectedValue = ((int)result.DisciplinaId).ToString();

                    this.TxtCosto.Text = result.Costo.ToString();
                    this.TxtCupo.Text = result.Cupo.ToString();
                    this.TxtFechaLimite.Text = result.FechaLimite.ToShortDateString();
                    this.FldFechaLimite.Value = result.FechaLimite.ToString("yyyy-MM-dd");
                    this.TxtName.Text = result.Nombre;
                }
            }
        }

        private void ShowError(string message, bool showMainPanel = false)
        {
            this.LblError.Text = message;
            this.LblError.Visible = true;
            this.PnlMain.Visible = showMainPanel;
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                var result = new CursoBll().Update(
                    new Domain.Curso()
                    {
                        Id = Convert.ToInt32(Convert.ToInt32(this.Request.QueryString["Id"])),
                        Nombre = this.TxtName.Text,
                        Costo = Convert.ToDecimal(this.TxtCosto.Text),
                        Cupo = Convert.ToInt32(this.TxtCupo.Text),
                        DisciplinaId = (DisciplinaType)Convert.ToInt32(this.DdlDisciplina.SelectedValue),
                        FechaLimite = Convert.ToDateTime(this.TxtFechaLimite.Text),
                    });

                if (result > 0)
                {
                    this.Response.Redirect("/Curso", false);
                }
                else
                {
                    this.ShowError("Se produjo un error inesperado, inténtalo de nuevo.", true);
                }
            }
            catch (Exception ex)
            {
                this.ShowError(ex.Message, true);
            }
        }
    }
}