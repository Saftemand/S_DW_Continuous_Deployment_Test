<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ValidateEmails.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.ValidateEmails" %>

<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="UC" TagName="Progress" Src="Control/Progress.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email validation</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
	<% 	If Dynamicweb.Gui.NewUI Then%>
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	<%End If%>
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
</head>
<body>
    <h2 class="subtitle"><%= Translate.Translate("Check e-mails in categories")%></h2>
    <div id="containerNewsletter">
        <form id="form1" runat="server" class="formNewsletter">
            <div>
                <UC:Progress ID="_ucProgress" runat="server" HeaderText="Email Validation" HeaderToolTip="Email Validation"
                    RedirectPage="/Admin/Module/NewsLetterV3/ValidateEmailsResults.aspx" CancelPage="Category_List.aspx"
                    RefreshPage="Control/RefreshProgress.aspx" ErrorsText="Wrong emails:" ElapsedText="Tidsforbrug"
                    ShowLog="False" />
            </div>
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>
