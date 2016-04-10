<%@ Page Language="vb" AutoEventWireup="false" Codebehind="NewsletterExtended_ShowStatusBar.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_ShowStatusBar" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0" style="MARGIN:0px;BACKGROUND-COLOR:#ece9d8">
		<br>
		<%
Dim strAbort As String = CStr(Request.Item("Abort"))
Dim NumberOfLines As Integer = Base.ChkNumber(Request.Item("NumberOfLines"))
Dim recordCount As Integer 
Dim cStatusBar As New StatusBar
Dim strServerName As String
Dim strNewsletterID As String = CStr(Request.Item("NewsletterID"))
Dim strFinnishedSend As String = "false"
Dim AllreadySendingNewsletter As String =  CStr(Request.Item("AllreadySendingNewsletter"))

'if strAbort = "true" then
'	KillAllThreads()
'end if

strServerName = HttpContext.Current.Request.ServerVariables.Item("server_name") & strNewsletterID

If Backend.NewsletterExtended.RecordCount.Contains(strServerName) Then
	recordCount = CType(Backend.NewsletterExtended.RecordCount.Item(strServerName), Integer)
Else
	strFinnishedSend = "true"
End if

If NumberOfLines-10 >= recordCount Then
	cStatusBar.Value = recordCount
	cStatusBar.MaxValue = NumberOfLines
	cStatusBar.Name = "Statusbar"
Else
	If Backend.NewsletterExtended.RecordCount.ContainsKey(strServerName) Then
		Backend.NewsletterExtended.RecordCount.Remove(strServerName)
	End If
	If Backend.NewsletterExtended.Threads.ContainsKey(strServerName) Then
		Backend.NewsletterExtended.Threads.Remove(strServerName)
	End If
	strFinnishedSend = "true"
End If
		
If AllreadySendingNewsletter = "true" Then
	Response.Write("The newsletter is allready in queue and sending.")
Else
	'Response.Write(Backend.NewsletterExtended.RecordCount.Count & " / " & Backend.NewsletterExtended.Threads.Count & vbNewLine)
	Response.Write(CType(Backend.NewsletterExtended.RecordCount.Item(strServerName), Integer) & " / " & NumberOfLines)
	Response.Write(cStatusBar.Render())
	Response.Write(cStatusBar.Increase())
	'Response.Write(Gui.Button("Abort","document.location = 'NewsletterExtended_ShowStatusBar.aspx?Abort=true';" , 90))
End If
		
%>
		<DIV></DIV>
<%
Translate.GetEditOnlineScript()
%>
<SCRIPT LANGUAGE="JavaScript">
	<!--
		if('<%=strFinnishedSend%>' == 'true' && '<%=AllreadySendingNewsletter%>' != 'true')
		{
			parent.updateinfo("Total: <%=recordCount%>/<%=NumberOfLines%>")
			parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Blank.html");
			parent.document.getElementById('ContentCell').setAttribute("src", "NewsletterExtended_Treeview.aspx?OpenWhat=List");
		}

		t = setTimeout("document.location = 'NewsletterExtended_ShowStatusBar.aspx?NumberOfLines=<%=NumberOfLines%>&NewsletterID=<%=strNewsletterID%>'", 5000);
	//-->
	
</SCRIPT>

</body>
</HTML>
