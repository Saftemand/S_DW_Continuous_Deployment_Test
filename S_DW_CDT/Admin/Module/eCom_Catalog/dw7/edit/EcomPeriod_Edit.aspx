<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>

<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="EcomPeriod_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.PeriodEdit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <style type="text/css">
        BODY.margin
        {
            margin: 0px;
        }
        INPUT
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        SELECT
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        TEXTAREA
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
    </style>

    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('PeriodName').focus();
        });

        function save(close) {
            document.getElementById("Close").value = close ? 1 : 0;
            document.getElementById('Form1').SaveButton.click();
        }

        function AlwaysCheckBoxClick() {
            var isChecked = $('Always').checked;
            var inputs = $$('td#Cell_THEENDDATE select');
            inputs.each(function (input) {
                input.disabled = isChecked;
            });
            $('THEENDDATE_calendar_btn').style.display = isChecked ? "none" : "";
        }

    </script>

</head>
<body ms_positioning="GridLayout" onload="AlwaysCheckBoxClick()" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
    <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
        <tbody>
            <tr>
                <td valign="top">
                    <div id="Tab1">
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%'>
                            <tr>
                                <td>
                                    <!-- ORDER DATA -->
                                    <dw:GroupBoxStart runat="server" Title="Product period" ID="GroupBoxStart1"></dw:GroupBoxStart>
                                    <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%'>
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="2">
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel>
                                                        </td>
                                                        <td colspan="2">
                                                            <div id="errPeriodName" name="errPeriodName" style="color: Red;">
                                                            </div>
                                                            <asp:TextBox ID="PeriodName" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelStartDate" runat="server" Text="Gyldig fra"></dw:TranslateLabel>
                                                        </td>
                                                        <td>
                                                            <asp:Literal ID="THESTARTDATE" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelEndDate" runat="server" Text="Gyldig til"></dw:TranslateLabel>
                                                        </td>
                                                        <td id="Cell_THEENDDATE">
                                                            <asp:Literal ID="THEENDDATE" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelAlways" runat="server" Text="Altid gyldig"></dw:TranslateLabel>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="Always" onclick="javascript:AlwaysCheckBoxClick()" runat="server"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelActive" runat="server" Text="Active"></dw:TranslateLabel>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="Active" runat="server"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tShowProductsAfterExpiration" runat="server" Text="Show products after product period expires" />
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="ShowProductsAfterExpiration" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <dw:GroupBoxEnd runat="server" ID="GroupBoxEnd1"></dw:GroupBoxEnd>
                                    <br>
                                    <br>
                                    <asp:Button ID="SaveButton" Style="display: none" runat="server"></asp:Button>
                                    <asp:Button ID="DeleteButton" Style="display: none" runat="server"></asp:Button>
                                    <div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>

    <script>
        addMinLengthRestriction('PeriodName', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
