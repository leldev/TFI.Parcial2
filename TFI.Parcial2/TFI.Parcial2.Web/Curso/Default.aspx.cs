using System;
using System.Linq;
using System.Web.UI.WebControls;
using TFI.Parcial2.Business;
using TFI.Parcial2.Domain;

namespace TFI.Parcial2.Web.Curso
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
            this.BtnCreate.NavigateUrl = "/Curso/Create";

            var result = new CursoBll().Read();

            if (result.Count > 0)
            {
                decimal total = 0;

                foreach (var item in result)
                {
                    total += GetTotal(item);
                }

                this.LblTotal.Text = $"$ {total}";

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
                var item = e.Item.DataItem as Domain.Curso;

                var lnkUpdate = e.Item.FindControl("LnkUpdate") as HyperLink;
                var ltlDisciplina = e.Item.FindControl("LtlDisciplina") as Literal;
                var ltlFechaLimite = e.Item.FindControl("LtlFechaLimite") as Literal;
                var lblTotal = e.Item.FindControl("LblTotal") as Label;

                ltlDisciplina.Text = item.DisciplinaId.ToString();
                ltlFechaLimite.Text = item.FechaLimite.ToString("dd/MM/yyy");

                lblTotal.Text = GetTotal(item).ToString();
                var beca1 = item.Inscripciones.Count(x => x.Beca == BecaType.Regular);
                var beca2 = item.Inscripciones.Count(x => x.Beca == BecaType.MediaBeca);
                var beca3 = item.Inscripciones.Count(x => x.Beca == BecaType.Beca80);
                lblTotal.ToolTip = $"Regular: {beca1} <br /> Media beca: {beca2} <br /> Beca 80%: {beca3} <br /> ";

                lnkUpdate.NavigateUrl = $"/Curso/Update?Id={item.Id}";
            }
        }

        private decimal GetTotal(Domain.Curso curso)
        {
            decimal total = 0;

            foreach (var item in curso.Inscripciones)
            {
                switch (item.Beca)
                {
                    case Domain.BecaType.Regular:
                        total += curso.Costo;
                        break;
                    case Domain.BecaType.MediaBeca:
                        total += (curso.Costo * 50 / 100);
                        break;
                    case Domain.BecaType.Beca80:
                        total += (curso.Costo * 80 / 100);
                        break;
                    default:
                        break;
                }
            }

            return total;
        }
    }
}