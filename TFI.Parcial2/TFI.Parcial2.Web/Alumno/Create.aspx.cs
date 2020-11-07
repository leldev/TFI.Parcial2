using System;
using TFI.Parcial2.Business;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Web.Alumno
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
                var result = new AlumnoBll().Create(
                    new Domain.Alumno()
                    {
                        Nombre = this.TxtName.Text,
                    });

                if (result > 0)
                {
                    this.Response.Redirect("/Alumno", false);
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