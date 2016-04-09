<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Recipient_ImportProgress.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.Recipient_ImportProgress" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="UC" TagName="Progress" Src="~/Admin/Module/NewsLetterV3/Control/Progress.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Recipient import</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
	<% 	If Dynamicweb.Gui.NewUI Then%>
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	<%End If%>
</head>
<body>
    <h2 class="subtitle"><%= Dynamicweb.Backend.Translate.Translate("Import")%></h2>
    <div id="containerNewsletter">
    <form id="form1" runat="server">
       <div id="Div1">
            <UC:Progress ID="_ucProgress" runat="server" 
            HeaderText="Import" 
            HeaderToolTip="Import"
            HeaderTitle=""
            CancelPage="/Admin/Module/NewsLetterV3/Recipient_Import.aspx" 
            RefreshPage="/Admin/Public/NewsLetterV3/Recipient_ImportBackend.aspx" 
            ExecutedText="Importerede"
            ElapsedText="Tidsforbrug"
		    ShowLog="True"
            UseThread="False"
		    ShowLogButton="True"/>
        </div>
    </form>
    </div>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript() %>
</body>
</html>
