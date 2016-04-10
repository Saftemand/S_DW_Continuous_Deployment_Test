<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Options.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2.Options" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Options</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
</head>
<body>
    <table width="100%" cellspacing="0" cellpadding="0" id="header">
        <tr>
            <td>
                <strong>
                    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="NewsV2 options" />
                </strong>
            </td>
        </tr>
    </table>
    <div id="containerNews">
        <form id="form1" runat="server" class="formNews">
            <dw:TabHeader ID="TabHeader1" runat="server" Headers="Options" ReturnWhat="all" />
            <table border="0" cellpadding="0" cellspacing="0" class="tabTable">
                <tr>
                    <td valign="top">
                        <dw:GroupBoxStart runat="server" ID="ListsStart" doTranslation="true" Title="Lists"
                            ToolTip="Lists" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td class="leftCol">
                                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Number of rows per page" />
                                </td>
                                <td>
                                    <asp:TextBox ID="RecordsPerPageBox" runat="server" size="3" MaxLength="3" CssClass="std"
                                        Width="40" />
                                    <asp:RangeValidator runat="server" ID="RecordsPerPageValidator" ControlToValidate="RecordsPerPageBox"
                                        Type="Integer" MaximumValue="99" Display="Dynamic" ErrorMessage="Only numbers from 1 to 99"
                                        MinimumValue="1" />
                                    <asp:RequiredFieldValidator runat="server" ID="RecordsPerPageRequiredFieldValidator"
                                        ControlToValidate="RecordsPerPageBox" ErrorMessage="required" Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <dw:GroupBoxEnd runat="server" ID="ListsEnd" />
                    </td>
                </tr>
                <tr>
                    <td class="buttonsRow">
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Button ID="butOk" Text="OK" CssClass="buttonSubmit" runat="server" />
                                </td>
                                <td style="width: 20px;">
                                    <button onclick="<%=Gui.Help("newsv2", "modules.newsv2")%>">
                                        <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Help" />
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <% Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>
