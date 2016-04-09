<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Record.ascx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.Record" %>
<td id="Cell" runat="server">   
    <a id="Button" runat="server" onserverclick="OnButtonClick">
        <img id="ButtonImage" runat="server" style="border:0; vertical-align:middle;" />
        <asp:Label id="ButtonLabel" runat="server"></asp:Label>        
    </a>
    <asp:Image runat="server" ID="Image" ImageAlign="AbsMiddle" />
    <asp:Label runat="server" ID="Label" Font-Underline="false" ></asp:Label>
</td>