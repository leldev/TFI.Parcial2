<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TFI.Parcial2.Web.Curso.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="LblTitle" Text="Cursos" runat="server" CssClass="display-4 text-uppercase" />
    <br />
    <br />
    <asp:Label ID="LblError" runat="server" Visible="false" CssClass="display-4 text-danger" />
    <asp:Panel ID="PnlMain" runat="server" CssClass="">
        <asp:HyperLink ID="BtnCreate" Text="Alta" runat="server" CssClass="btn btn-light" />
        <br />
        <br />
        <div class="form-row">
            <div class="form-group col-md col-sm-12">
                <label class="h4">Recaudación total: </label>
                <asp:Label ID="LblTotal" runat="server" CssClass="h4" />
            </div>
        </div>
        <asp:Repeater ID="RptData" runat="server">
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table table-hover text-center">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">
                                    <asp:Literal ID="LtlName" Text="Nombre" runat="server" />
                                </th>
                                <th scope="col">
                                    <asp:Literal ID="LtlCuil" Text="Disciplina" runat="server" />
                                </th>
                                <th scope="col">
                                    <asp:Literal ID="LtlHireDate" Text="Costo" runat="server" />
                                </th>
                                <th scope="col">
                                    <asp:Literal ID="LtlSalary" Text="Fecha límite" runat="server" />
                                </th>
                                <th scope="col">
                                    <asp:Literal ID="LtlBank" Text="Cupo" runat="server" />
                                </th>
                                <th scope="col">
                                    <asp:Literal ID="LtlTotal" Text="$" runat="server" />
                                </th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <th scope="row">
                        <%#Eval(nameof(TFI.Parcial2.Domain.Curso.Id))%>
                    </th>
                    <td>
                        <%#Eval(nameof(TFI.Parcial2.Domain.Curso.Nombre))%>
                    </td>
                    <td>
                        <asp:Literal ID="LtlDisciplina" runat="server" />
                    </td>
                    <td>
                        $ <%#Eval(nameof(TFI.Parcial2.Domain.Curso.Costo))%>
                    </td>
                    <td>
                        <asp:Literal ID="LtlFechaLimite" runat="server" />
                    </td>
                    <td>
                        <%#Eval(nameof(TFI.Parcial2.Domain.Curso.Cupo))%>
                    </td>
                    <td>
                        $ <asp:Label ID="LblTotal" runat="server" data-toggle="tooltip" data-html="true" />
                    </td>
                    <td>
                        <asp:HyperLink ID="LnkUpdate" runat="server" CssClass="text-dark">
                           <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pen-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                              <path fill-rule="evenodd" d="M13.498.795l.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001z"/>
                            </svg>
                        </asp:HyperLink>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
            </table>
            </div>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
    <script type="text/javascript">
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>
</asp:Content>
