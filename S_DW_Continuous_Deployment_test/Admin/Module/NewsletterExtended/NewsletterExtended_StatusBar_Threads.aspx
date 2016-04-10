<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0">
		<br>
		<%
Dim strAbort As String = CStr(Request.Item("Abort"))
Dim NumberOfLines As Integer = Base.ChkNumber(Request.Item("NumberOfLines"))
Dim recordCount As Integer 
Dim cStatusBar As New StatusBar
Dim strServerName As String
Dim strNewsletterID As String = CStr(Request.Item("NewsletterID"))
Dim strFinnishedSend As String = "false"

strServerName = HttpContext.Current.Request.ServerVariables.Item("server_name") & strNewsletterID

Dynamicweb.Admin.NewsletterExtended.CheckLiveThreads()

If Dynamicweb.Admin.NewsletterExtended.Threads.ContainsKey(strServerName) Then

	If Dynamicweb.Admin.NewsletterExtended.RecordCount.Contains(strServerName) Then
		recordCount = CType(Dynamicweb.Admin.NewsletterExtended.RecordCount.Item(strServerName), Integer)
	Else
		recordCount = NumberOfLines
	End If

	cStatusBar.Value = recordCount
	cStatusBar.MaxValue = NumberOfLines
	cStatusBar.Name = "Statusbar"
			
	'Response.Write(Backend.NewsletterExtended.RecordCount.Count & " / " & Backend.NewsletterExtended.Threads.Count & vbNewLine)
	Response.Write(CType(Dynamicweb.Admin.NewsletterExtended.RecordCount.Item(strServerName), Integer) & " / " & NumberOfLines)
	Response.Write(cStatusBar.Render())
	Response.Write(cStatusBar.Increase())
	'Response.Write(Gui.Button("Abort","document.location = 'NewsletterExtended_ShowStatusBar.aspx?Abort=true';" , 90))
Else
	Response.Write(Translate.Translate("Dette nyhedsbrev er udsendt."))
End If

Translate.GetEditOnlineScript()
%>
<SCRIPT LANGUAGE="JavaScript">
	<!--
	t = setTimeout("document.location = 'NewsletterExtended_StatusBar_Threads.aspx?NumberOfLines=<%=NumberOfLines%>&NewsletterID=<%=strNewsletterID%>'", 5000);
	//-->
	
</SCRIPT>

</body>
</HTML>
