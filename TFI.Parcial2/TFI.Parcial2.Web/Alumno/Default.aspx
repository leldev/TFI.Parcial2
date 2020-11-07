<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TFI.Parcial2.Web.Alumno.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="LblTitle" Text="Alumnos" runat="server" CssClass="display-4 text-uppercase" />
    <br />
    <br />
    <asp:Label ID="LblError" runat="server" Visible="false" CssClass="display-4 text-danger" />
    <asp:Panel ID="PnlMain" runat="server" CssClass="">
        <asp:HyperLink ID="BtnCreate" Text="Alta" runat="server" CssClass="btn btn-light" />
        <br />
        <br />
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
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <th scope="row">
                        <%#Eval(nameof(TFI.Parcial2.Domain.Alumno.Id))%>
                    </th>
                    <td>
                        <%#Eval(nameof(TFI.Parcial2.Domain.Alumno.Nombre))%>
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
</asp:Content>
