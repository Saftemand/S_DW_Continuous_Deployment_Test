<%@ Page CodeBehind="NewsletterExtended_Preview_Eml.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Preview_Eml" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="aspNetEmail" %>

<%

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
window.open('../../Public/Download.aspx?File=<%=Replace(Replace(strPath, "\", "/"), "/files", "")%>', "Preview", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=1,height=1,top=2000,left=2000");
document.location = "NewsletterExtended_letter_body_Preview.aspx?ID=<%=NewsletterID%>&Tab=Tab2"
//-->
</SCRIPT>
