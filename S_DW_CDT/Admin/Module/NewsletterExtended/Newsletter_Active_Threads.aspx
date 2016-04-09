<%@ Page CodeBehind="Newsletter_Active_Threads.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Newsletter_Active_Threads" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<body LEFTMARGIN="20" TOPMARGIN="16">
<table width=512 border="0">
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Module_NewsletterExtended_SendProgress.gif" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Breve under forsendelse")%></strong></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC; height:1px; width:100%;"></td>
	</tr>
	<tr>
		<td><table width='100%' cellpadding='2' cellspacing='0' border='0'<%=FindThreads()%></table></td>
	</tr>
</table><br />
<table width=512 border="0">
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Sidste %% sendte nyhedsbreve", "%%", "10")%></strong></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%"></td>
	</tr>
	<tr>
		<td><%=getLastNewsletters()%></td>
	</tr>
</TABLE>		

</body>
</html>


<%
Translate.GetEditOnlineScript()
%>
