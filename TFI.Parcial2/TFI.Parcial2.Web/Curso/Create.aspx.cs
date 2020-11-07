using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TFI.Parcial2.Business;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Web.Curso
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
            foreach (DisciplinaType type in Enum.GetValues(typeof(DisciplinaType)))
            {
                DdlDisciplina.Items.Add(new ListItem(type.ToString(), ((int)type).ToString()));
            }
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
                var result = new CursoBll().Create(
                    new Domain.Curso()
                    {
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