<%@ Page CodeBehind="Form_Module_Copy.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Copy" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>

<%

CopyForm(CStr(Request.QueryString.Item("FormID")))

Response.Redirect("Form_Module_List.aspx")
%>
