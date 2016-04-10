<%@ Page CodeBehind="NewsletterExtended_Letter_SendExec.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_SendExec" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="aspNetEmail" %>

<%
dim counter As Integer = 0
Dim filehome As String = "\Files\"
Dim NLDropbox_Path As String' = Base.GetGS("/Globalsettings/Modules/NewsletterExtended/DropboxAndPickup/DropboxPath")
Dim cStatusBar As New StatusBar
Dim NumberOfLines As String
Dim recordCount As String
Dim QueryString As String
QueryString = Request.QueryString.ToString()
NumberOfLines = Request.Item("NumberOfLines")
recordCount = NumberOfLines

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ECE9D8;margin:0px;">
<br>

<div id="StatusText"></div>
<%

    Dim strHashkey As String = Session.SessionID & "_" & Request.Item("NewsletterID")

    If Not Dynamicweb.Admin.NewsletterExtended.Threads.Contains(strHashkey) Then
        Dim ticks As String = Request.Item("Ticks")
        If HttpContext.Current.Session.Item(ticks) Is Nothing Then
            HttpContext.Current.Session.Add(ticks, ticks)
            Dim newsletterextended As New Dynamicweb.Admin.NewsletterExtended()
            newsletterextended.SendNewsletter()
	
            'Response.Redirect("NewsletterExtended_ShowStatusBar.aspx?" & QueryString)
            Response.Redirect("Newsletter_Active_Threads.aspx")
        End If
    Else
        'Response.Redirect("NewsletterExtended_ShowStatusBar.aspx?AllreadySendingNewsletter=true")
    End If
%>
</div>
</body>
</html>
<%
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
parent.updateinfo("Total: <%=recordCount%>/<%=NumberOfLines%>")
parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Blank.html");
parent.document.getElementById('ContentCell').setAttribute("src", "NewsletterExtended_Treeview.aspx?OpenWhat=List");

//-->
</SCRIPT>
<%
Translate.GetEditOnlineScript()
%>
