<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="TFI.Parcial2.Web.Curso.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="LblTitle" runat="server" Text="Alta Curso" CssClass="display-4 text-uppercase" />
    <br />
    <asp:Label ID="LblError" runat="server" Visible="false" CssClass="display-4 text-danger" />
    <asp:Panel ID="PnlMain" runat="server" CssClass="jumbotron">
        <div class="form-row">
            <div class="form-group col-md col-sm-12">
                <label class="h4">Nombre</label>
                <asp:TextBox ID="TxtName" runat="server" CssClass="form-control" MaxLength="50" required="" />
                <div class="invalid-feedback">
                    <label>Requerido</label>
                </div>
            </div>
            <div class="form-group col-md col-sm-12">
                <label class="h4">Disciplina</label>
                <asp:DropDownList ID="DdlDisciplina" runat="server" CssClass="browser-default custom-select" />
            </div>
            
        </div>
        <div class="form-row">
            <div class="form-group col-md col-sm-12">
                <label class="h4">Costo</label>
               <div class="input-group">
                    <div class="input-group-prepend">
                        <div class="input-group-text">$</div>
                    </div>
                    <asp:TextBox ID="TxtCosto" runat="server" CssClass="form-control" TextMode="Number" min="0" max="1000000" step=".10" required="" />
                    <div class="invalid-feedback">
                        <label>Requerido</label>
                    </div>
                </div>
            </div>
            <div class="form-group col-md col-sm-12">
                <label class="h4">Fecha límite</label>
                <asp:TextBox ID="TxtFechaLimite" runat="server" CssClass="form-control" TextMode="Date" required="" />
                <div class="invalid-feedback">
                    <label>Requerido</label>
                </div>
            </div>
             <div class="form-group col-md col-sm-12">
                <label class="h4">Cupo</label>
                <asp:TextBox ID="TxtCupo" runat="server" CssClass="form-control" TextMode="Number" min="0" max="100" required="" />
                <div class="invalid-feedback">
                    <label>Requerido</label>
                </div>
            </div>
        </div>
        <div class="form-row">
            <asp:Button ID="BtnCreate" runat="server" Text="Alta" OnClick="BtnCreate_Click" CssClass="btn btn-light" />
        </div>
    </asp:Panel>
    <script type="text/javascript">
        ready(() => {
            (function () {
                'use strict';
                window.addEventListener('load', function () {
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    var forms = document.getElementsByClassName('needs-validation');
                    // Loop over them and prevent submission
                    Array.prototype.filter.call(forms, (form) => {
                        form.addEventListener('submit', (event) => {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        });
    </script>
</asp:Content>
