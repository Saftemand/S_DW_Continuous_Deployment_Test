<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrderFlow_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomOrderFlowEdit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%
    Dim strBBR As String
    strBBR = "BBR"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <style type="text/css">
        BODY.margin
        {
            margin: 0px;
        }
        input, select, textarea
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
    </style>
    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
    <script type="text/javascript">
        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
        }); 

        function saveOrderFlow(close) {
            document.getElementById("Close").value = close ? 1 : 0;
            document.getElementById('Form1').SaveButton.click();
        }
    </script>
</head>
<body style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
    <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
        <tr>
            <td valign="top">
                <div id="Tab1">
                    <br />
                    <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%;'>
                        <tr>
                            <td>
                                <fieldset style='width: 100%; margin: 5px;'>
                                    <legend class="gbTitle">
                                        <%=Translate.Translate("Indstillinger")%>&nbsp;</legend>
                                    <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID='tLabelName' runat='server' Text='Navn' />
                                                        </td>
                                                        <td>
                                                            <div id="errNameStr" name="errNameStr" style="color: Red;">
                                                            </div>
                                                            <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelDescr" runat="server" Text="Beskrivelse" />
                                                        </td>
                                                        <td>
                                                            <div id="errDescrStr" name="errDescrStr" style="color: Red;">
                                                            </div>
                                                            <asp:TextBox ID="DescrStr" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelDefault" runat="server" Text="Default" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="IsDefault" runat="server"></asp:CheckBox><asp:CheckBox ID="IsDefaultTmp"
                                                                runat="server" disabled></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="SaveButton" Style="display: none;" runat="server" />
                    <asp:Button ID="DeleteButton" Style="display: none;" runat="server" />
                </div>
            </td>
        </tr>
    </table>
    </form>
    <asp:Literal ID="BoxEnd" runat="server" />
    <asp:Literal ID="removeDelete" runat="server" />
    <script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>