<%@ Page CodeBehind="Template_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-02-2002
'	Last modfied:		13-02-2002
'
'	Purpose: Deletefile used by Template_List.asp
'
'	Revision history:
'		1.0 - 12-02-2002 - Michael Lykke
'		First version
'		1.1 - 07-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

If Request.QueryString.Item("TemplateID") <> "0" And Not isNothing(Request.QueryString.Item("TemplateID")) Then
        Database.ExecuteNonQuery("DELETE FROM TemplateMenu WHERE TemplateMenuTemplateID = " & Request.QueryString.Item("TemplateID"))
        Database.ExecuteNonQuery("DELETE FROM Template WHERE TemplateID=" & Request.QueryString.Item("TemplateID"))
End if

Response.Redirect(("Template_List.aspx?TemplateCategoryID=" & Request.QueryString.Item("TemplateCategoryID")))

%>