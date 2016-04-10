<%@ Page CodeBehind="News_Module_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Module_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%


If Request.QueryString.Item("source") = "frontend" Then
	%>
<script language="javascript">
		var strNewURL = (window.opener.location).toString();

	if(strNewURL.indexOf("&M=News") != -1) {
		myIndexOf = strNewURL.indexOf("&M=News");
		strNewURL = strNewURL.substr(0, myIndexOf);
		window.opener.location = strNewURL
	} else {
		window.opener.location.reload();
	}
	window.close();
</script>
<%	
Else
	response.Redirect("News_Module_List.aspx?CategoryID=" & strCategoryID)
End If
%>

