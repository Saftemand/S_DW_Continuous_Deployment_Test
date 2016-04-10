<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomRmaEvent_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.EcomRmaEvent_Edit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
        <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/layermenu.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <dw:Toolbar runat="server" ID="Toolbar" ShowStart="True" ShowEnd="false">
    </dw:Toolbar>
    <h2 class="subtitle">
        <asp:Literal runat="server" ID="Header"></asp:Literal></h2>
    <dw:Infobar runat="server" ID="InfoBarNotTranslated" Visible="False">
    </dw:Infobar>
    <dw:GroupBox ID="GroupBox1" runat="server" Title="State settings">
        <table>
            <tr>
                <td style="width: 170px;">
                    <dw:TranslateLabel ID="LabelType" runat="server" Text="Name" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="Type" CssClass="NewUIinput" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td style="width: 170px;">
                    <dw:TranslateLabel ID="LabeDescription" runat="server" Text="Description" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="Description" TextMode="MultiLine" Height="50" CssClass="NewUIinput" />
                </td>
            </tr>
        </table>
    </dw:GroupBox>
   

    <input type="hidden" name="Save" id="Save" value="" />
    <input type="hidden" name="SaveClose" id="SaveClose" value="" />
    <input type="hidden" name="Delocalize" id="Delocalize" value="" />
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
    </form>
</body>
</html>
