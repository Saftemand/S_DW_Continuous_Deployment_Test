<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="HeaderColumn.ascx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.HeaderColumn" %>
<td id="Cell" class="columnCell" runat="server">
    <asp:LinkButton  runat="server" ID="Link" ForeColor="#000000" Font-Underline="false"></asp:LinkButton>
    <asp:Label runat="server" ID="Label" Font-Underline="false"></asp:Label>
    <asp:ImageButton runat="server" ID="Image" Width="11px" Height="11px" ImageAlign="AbsMiddle"/>
</td>