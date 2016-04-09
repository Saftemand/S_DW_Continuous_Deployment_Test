<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VoucherAdd.aspx.vb" Inherits="Dynamicweb.Admin.VouchersManager.VoucherAdd" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="True" />
    <script type="text/javascript" language="javascript" src="js/VoucherAdd.js"></script>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/Main.css" />

    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            if (document.getElementById('voucherCode')) {
                window.focus(); // for ie8-ie9 
                document.getElementById('voucherCode').focus();
            }
        });

    </script>
</head>
<body style="background-color: #F0F0F0; overflow-y: hidden;">
    <form id="voucherAddFrom" runat="server" defaultfocus="txVoucherCode">
            <div id="GeneralDiv">
                <dw:GroupBox ID="gbGeneral" Title="Voucher Code" runat="server">
                    <table>
                        <tr>
                            <td style="width: 107px; vertical-align:top;">
                                <dw:TranslateLabel ID="lbVoucherCode" Text="Voucher Code" runat="server" />
                            </td>
                            <td align="right">
                                <asp:TextBox ID="txVoucherCode" CssClass="std field-name" runat="server" ClientIDMode="Static" TextMode="MultiLine" Rows="13"  />
                                <asp:RequiredFieldValidator ID="requiredFiledValidator" runat="server" ErrorMessage="*" ControlToValidate="txVoucherCode"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regExpValidator" runat="server" ErrorMessage="*" ControlToValidate="txVoucherCode" ValidationExpression="[a-zA-Z0-9\s\., ]+"></asp:RegularExpressionValidator>
                                <input type="button" value="Add" id="btnAdd" style="width:120px" onclick="voucherAdd.PostbackForm(<%= ListID %>);" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
