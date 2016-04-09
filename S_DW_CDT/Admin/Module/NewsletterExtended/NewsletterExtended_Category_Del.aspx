<%@ Page CodeBehind="NewsletterExtended_Category_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Category_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
parent.document.getElementById('ContentCell').setAttribute("src", "NewsletterExtended_Treeview.aspx");
<%If Not IsNothing(Request.QueryString.GetValues("Path")) Then%>
	parent.document.getElementById('ListRight').setAttribute("src", "<%=Request.QueryString.Item("Path")%>");
<%Else%>
	parent.document.getElementById('ListRight').setAttribute("src", "NewsletterExtended_Blank.html");
<%End If%>
//-->
</SCRIPT>

