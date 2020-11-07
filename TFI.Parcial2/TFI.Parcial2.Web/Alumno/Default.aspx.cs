using System;
using System.Web.UI.WebControls;
using TFI.Parcial2.Business;

namespace TFI.Parcial2.Web.Alumno
{
    public partial class Default : System.Web.UI.Page
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

        private void ShowError(string message, bool showMainPanel = false)
        {
            this.LblError.Text = message;
            this.LblError.Visible = true;
            this.PnlMain.Visible = showMainPanel;
        }

        private void Build()
        {
            this.BtnCreate.NavigateUrl = "/Alumno/Create";

            var result = new AlumnoBll().Read();

            if (result.Count > 0)
            {
                this.RptData.ItemDataBound += this.RptData_ItemDataBound;
                this.RptData.DataSource = result;
                this.RptData.DataBind();
            }
            else
            {
                this.ShowError("No hay elementos.", true);
            }
        }

        private void RptData_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
            }
        }
    }
}