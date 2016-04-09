<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Order_Export_Download.aspx.vb" Inherits="Dynamicweb.Admin.Order_Export_Download"%>
<%
If Request.QueryString("File") <> "" Then
	Response.Redirect(Request.QueryString("File"))
End If
%>
