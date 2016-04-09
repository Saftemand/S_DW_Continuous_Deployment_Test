<%@ Page CodeBehind="News_Module_Save.aspx.vb" validateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Module_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<script language="javascript">
	var strNewURL = (window.opener.location).toString();

	if(strNewURL.indexOf("NewsID=") != -1) {
		myIndexOf = strNewURL.indexOf("NewsID=");
		strNewURL = strNewURL.substr(0, myIndexOf);
		strNewURL = strNewURL + "NewsID=" + "<%=NewsID%>";
		window.opener.location = strNewURL
	} else {
		window.opener.location.reload();
	}
	window.close();
</script>
