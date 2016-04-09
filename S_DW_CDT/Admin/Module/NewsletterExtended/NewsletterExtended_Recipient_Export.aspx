<%@ Page CodeBehind="NewsletterExtended_Recipient_Export.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_Export" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.IO" %>



<%


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ECE9D8;margin:0px;">
<BR>
<%

%>
		<div id="StatusText"></div>
<%

''Base.we("/admin/public/Download.aspx?File=" & Replace(Replace(path, "\", "/"), "/Files", ""))

%>
</div>
</body>
</html>
<%'Response.Flush()%>
<SCRIPT LANGUAGE="JavaScript">
<!--
parent.updateinfo("Total: <%=recordCount%>/<%=NumberOfLines%>")
//parent.document.getElementById("ListRight").setAttribute("src", "NewsletterExtended_Blank.html");
//parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_ExportLink_with_color.html");

location = '/admin/public/Download.aspx?File=<%=Replace(Replace(path, "\", "/"), "/Files", "")%>';
//alert('/admin/public/Download.aspx?File=<%=Replace(Replace(path, "\", "/"), "/Files", "")%>');
//window.open('/admin/public/Download.aspx?Filarchive=true&File=<%=Replace(Replace(path, "\", "/"), "/Files", "")%>', "Preview", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=500,height=500,top=10,left=10");
//t = setTimeout("document.location = 'NewsletterExtended_Blank_with_color.html'", 5000);

//-->
</SCRIPT>
<%
'Response.Flush()
Translate.GetEditOnlineScript()
%>