<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="Dynamicweb.Admin._default1" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!-- This page can be used to force the display of terminology for translation. -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<TITLE>Translation Helper Page</TITLE>
</HEAD>
<BODY topmargin="4" leftmargin="5">

<%=Translate.Translate("Tilmeld")%>
<%=Translate.Translate("E-mail")%>
<%=Translate.Translate("Ingen brugere tilmeldt")%>

</BODY>
</HTML>

<%
	' BBR 2005-01-11
	Translate.GetEditOnlineScript()
%>