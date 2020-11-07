<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="TFI.Parcial2.Web.Empleado.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="LblTitle" runat="server" Text="Alta Inscripción" CssClass="display-4 text-uppercase" />
    <br />
    <asp:Label ID="LblError" runat="server" Visible="false" CssClass="display-4 text-danger" />
    <asp:Panel ID="PnlMain" runat="server" CssClass="jumbotron">
        <div class="form-row">
            <div class="form-group col-md col-sm-12">
                <label class="h4">Curso</label>
                <asp:DropDownList ID="DdlCurso" runat="server" CssClass="browser-default custom-select" />
            </div>
            <div class="form-group col-md col-sm-12">
                <label class="h4">Alumno</label>
                <asp:DropDownList ID="DdlAlumno" runat="server" CssClass="browser-default custom-select" />
            </div>
            <div class="form-group col-md col-sm-12">
                <label class="h4">Beca</label>
                <asp:DropDownList ID="DdlBeca" runat="server" CssClass="browser-default custom-select" />
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
