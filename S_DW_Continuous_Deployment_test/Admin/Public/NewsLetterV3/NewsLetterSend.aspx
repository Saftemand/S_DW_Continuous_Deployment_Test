<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewsLetterSend.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.NewsLetterSend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="UC" TagName="Progress" Src="~/Admin/Module/NewsLetterV3/Control/Progress.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NewsLetter send</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
	<% 	If Dynamicweb.Gui.NewUI Then%>
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	<%End If%>
</head>
<body>
    <h2 class="subtitle"><%= Dynamicweb.Backend.Translate.Translate("Udsend_mail")%></h2>
    <div id="containerNewsletter">
    <form id="form1" runat="server" class="formNewsletter">

        <div id="Div1">
            <UC:Progress ID="_ucProgress" runat="server" 
            HeaderText="Sender_mails" 
            HeaderToolTip="Sender_mails"
            HeaderTitle="" 
            ExecutedText="Sent_Items"
            ElapsedText="Tidsforbrug"
            CancelPage="/Admin/Module/NewsLetterV3/Category_List.aspx" 
            RefreshPage="/Admin/Public/NewsLetterV3/NewsLetterSendBackend.aspx"
            ShowLog="True"  
            UseThread="False"     
              />
        </div>        
    </form>
    </div>    
</body>
</html>  
