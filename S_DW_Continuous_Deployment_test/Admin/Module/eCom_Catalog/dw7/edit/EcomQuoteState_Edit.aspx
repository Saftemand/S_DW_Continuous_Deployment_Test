<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomQuoteState_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomQuoteStateEdit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%
    Dim strBBR As String
    strBBR = "BBR"
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
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

        function saveState(close) {
            document.getElementById("Close").value = close ? 1 : 0;
            document.getElementById('Form1').SaveButton.click();
        }
    </script>
</head>
<body ms_positioning="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
    <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
    <dw:Infobar Visible="false" ID="deleteStateInfoBar" runat="server"></dw:Infobar>
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
        <tr>
            <td valign="top">
                <div id="Tab1">
                    <br>
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
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelAllowOrder" runat="server" Text="Allow order" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="AllowOrder" runat="server"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="tLabelDontUseInstatistics" runat="server" Text="Udelad fra statistik" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="DontUseInstatistics" runat="server"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset style='width: 100%; margin: 5px;'>
                                    <legend class="gbTitle">
                                        <%= Translate.Translate("Notification")%>&nbsp;</legend>
                                    <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Subject" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="MailSubject" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="E-mail template" />
                                                        </td>
                                                        <td>
                                                            <dw:FileManager runat="server" ID="NotificationTemplate" Folder="Templates/eCom/Order/"
                                                                FullPath="True"></dw:FileManager>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Sender name" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="SenderName" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="170">
                                                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Sender e-mail" />
                                                        </td>
                                                        <td>
                                                            <div id="errSenderMail" name="errSenderMail" style="color: Red;">
                                                            </div>
                                                            <asp:TextBox ID="SenderMail" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset style='width: 100%; margin: 5px;'>
                                    <legend class="gbTitle">
                                        <%= Translate.Translate("State rules")%>&nbsp;</legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                    <tr>
                                                        <td style="width:170px;vertical-align:top">
                                                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Quotes can move to this state from" />
                                                        </td>
                                                        <td>
                                                            <asp:Literal ID="ltQuotesFromStatesList" runat="server"></asp:Literal>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:170px;vertical-align:top">
                                                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Quotes can move from this state to" />
                                                        </td>
                                                        <td>
                                                            <asp:Literal ID="ltQuotesToStatesList" runat="server"></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                    <br/>
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