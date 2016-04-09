<%@ Page CodeBehind="Template_Preview.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Preview" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<TITLE><%=Translate.JSTranslate("Template preview")%></TITLE>
	<Link HREF="../../Stylesheet.css" REL="stylesheet" REV="stylesheet">
</HEAD>
<script>
    function doClick(templateID){
        if(window.parent.openTemplateViewer){
            window.parent.openTemplateViewer();
        }else{
            window.parent.templateClick(templateID);
        }
    }
</script>

<BODY style="background-color:#FFFFFF;cursor:hand;" OnClick="doClick('<%= Request.QueryString.Item("TemplateID")  %>');">
<%

Dim strType as String = Request.QueryString("Type")
Dim tmpPreview as New TemplatePreview(strType)

Response.Write(tmpPreview.TemplatePreview(Request.QueryString.Item("TemplateID")))

%>
</BODY>
</HTML>
<% 
	' Translate.GetEditOnlineScript() ' BBR 01/2005
%>