<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomStockLocation_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.StockLocationEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">

    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
        <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
        
        <style type="text/css">
        body.margin {
            margin-top: 0px;
            margin-left: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            
        }
        
        input,select,textarea {font-size: 11px; font-family: verdana,arial;}
        </style>	
        <script type="text/javascript" src="/Admin/FormValidation.js"></script>	
        <script type="text/javascript">

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('Name').focus();
            });

            function save(close) {
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }

            var deleteMsg = '<%= DeleteMessage %>';
            function deleteStockLocation() {
                if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click();
            }
        </script>
</head>
<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal id="BoxStart" runat="server"></asp:Literal>
    
        <form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
        <asp:Literal id="NoUnitExistsForLanguageBlock" runat="server"></asp:Literal>
        <dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
        
            <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
            <tr>
            <td valign="top">
        
            <div id="Tab1">
                <br>

                <table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
                <tr><td>

                <fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Stock location")%>&nbsp;</legend>

                <table border=0 cellpadding=2 cellspacing=0 width='100%' style='width:100%;'>
                <tr><td>
                    <table border=0 cellpadding=2 cellspacing=2 width="100%">
                        <tr>
                            <td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Name"></dw:TranslateLabel></td>
                            <td>
                                <div id="errName" name="errName" style="color: Red;"></div>
                                <asp:textbox id="Name" CssClass="NewUIinput" runat="server"></asp:textbox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px; vertical-align: top;"><dw:TranslateLabel id="tLabelDescription" runat="server" Text="Description"></dw:TranslateLabel></td>
                            <td>
                                <div id="errDescription" name="errDescription" style="color: Red;"></div>
                                <asp:textbox id="Description" CssClass="NewUIinput" runat="server" TextMode="MultiLine" Rows="6"></asp:textbox>
                            </td>
                        </tr>
                    </table>
                </td></tr>
                </table>

                </fieldset><br><br>

                </td></tr>
                </table>

                <br>
                
                <asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
                <asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>

            </div>
            
            </td>
            </tr>
            </table>

        </form>

    <asp:Literal id="BoxEnd" runat="server"></asp:Literal>
    <script>
        addMinLengthRestriction('Name', 1, '<%=Translate.JsTranslate("A name needs to be specified")%>');
        activateValidation('Form1');
    </script>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
