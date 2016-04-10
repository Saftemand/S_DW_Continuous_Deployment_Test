<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Search.ascx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.Search" %>
<asp:Table runat="server" ID="SearchTable" width="100%" height="20px" cellpadding="0" cellspacing="0">
    <asp:TableRow ID="SearchTableRow" runat="server" VerticalAlign="Middle">
        <asp:TableCell runat="server" ID="SearchComment" HorizontalAlign="Left">
            <asp:TextBox ID="SearchText" CssClass="NewUIinput" style="width:130px; vertical-align:middle; margin-right:4px;" runat="server" />
            <asp:Button ID="SearchButton" CssClass="buttonSubmit" style="height:20px; width:60px; vertical-align:middle;" runat="server" Text="Search"/>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
