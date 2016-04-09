<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomGroups_edit.aspx.vb"
    Inherits="Dynamicweb.Admin.ModulesCommon.CustomGroups_edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>CustomFields_edit</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
       <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/Common/dw7UI.css" />
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
</head>
<body>
<div class="list">
    <div class="title">
      <%=GetBreadcrumb() %>
    </div>
    <form method="post" runat="server" id="Form1" class="formNews">
        <div id="containerNews">
            <dw:TabHeader ID="tabheader1" runat="server" ReturnWhat="all" Headers="Group"></dw:TabHeader>
            <div id="Tab1">
                <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
                    <tr valign="top">
                        <td colspan="2">
                            <dw:GroupBoxStart runat="server" ID="gb1" Title="Generelt" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td class="leftCol">
                                        <dw:TranslateLabel ID="tLabel1" runat="server" Text="Navn" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextName" CssClass="std" MaxLength="100" runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="NameValidator" Display="Dynamic" runat="server" ErrorMessage=" required"
                                            ControlToValidate="TextName"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <asp:Panel ID="FieldsPanel" runat="server">
                        <tr>
                            <td style="height: 250px;">
                                <iframe id="FieldsListFrame" name="FieldsListFrame" runat="server" marginwidth="0"
                                    marginheight="0" scrolling="auto" frameborder="0" height="100%" width="100%" />
                            </td>
                        </tr>
                    </asp:Panel>
                    <tr valign="bottom">
                        <td class="buttonsRow" colspan="2">
                            <table cellspacing="0" cellpadding="2" border="0">
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="BtnSubmit" CausesValidation="True" Text="OK" CssClass="buttonSubmit"
                                            runat="server"></asp:Button></td>
                                    <td align="right">
                                        <asp:Button ID="BtnCancel" CausesValidation="false" Text="Cancel" CssClass="buttonSubmit"
                                            runat="server"></asp:Button>
                                    </td>
                                    <td style="width: 20px;">
                                        <button onclick="<%=HelpHref()%>"
                                            class="buttonSubmit">
                                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Hjælp" />
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    </div>
</body>
</html>
<%  Translate.GetEditOnlineScript()%>
