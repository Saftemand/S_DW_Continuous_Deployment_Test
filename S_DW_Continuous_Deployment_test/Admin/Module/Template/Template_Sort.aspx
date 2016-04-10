<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Sort products
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
    Dim MoveDirection As String = Request.QueryString.Item("MoveDirection")
    Dim TemplateID As Integer = Base.ChkNumber(Request.QueryString.Item("TemplateID"))
    Dim TemplateCategoryID As Integer = Base.ChkNumber(Request.QueryString.Item("TemplateCategoryID"))
   
    Dynamicweb.Admin.Template_List.SortTemplate(MoveDirection, TemplateID, TemplateCategoryID)
    
    Response.Redirect("Template_List.aspx?TemplateCategoryID=" & TemplateCategoryID)
%>
