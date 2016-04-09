<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TemplateViewer.aspx.vb" Inherits="Dynamicweb.Admin.TemplateViewerASPX"%>
<%@ Import namespace="Dynamicweb" %>
<%

Dim TemplateArea As String
    Dim FormNameId As String
Dim ParagraphTemplateID As String
Dim  ParagraphTemplateIcon As String
Dim templateviewer As New templateviewer

    FormNameId = Request.Item("FormNameId")
    Dim strFormNameId As String = "'" & FormNameId & "'"
    
TemplateArea = Request.Item("Type") 
ParagraphTemplateID = Request.Item("ParagraphTemplateID") 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title><%=Dynamicweb.Backend.Translate.JsTranslate("Template picker")%></title>
    <link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css">
    <base href="/">
  </head>
  <body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ECE9D8;margin:0px;" onload="var v='opener.document.getElementById('+<%=strFormNameId%>+').ParagraphTemplateID.value'; templateClick(v);">
  <table><tr><td>
  
  <%= templateviewer.Templateviewer(TemplateArea, ParagraphTemplateID, FormNameId)%></body>
  </td></tr></table>
</html>
