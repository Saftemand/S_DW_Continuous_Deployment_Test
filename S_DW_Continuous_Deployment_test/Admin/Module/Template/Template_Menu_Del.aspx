<%@ Page CodeBehind="Template_Menu_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Menu_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			11-03-2002
'	Last modfied:		11-03-2002
'
'	Purpose: Deletefile used by Template_Admin_Edit.asp
'
'	Revision history:
'		1.0 - 11-03-2002 - Michael Lykke
'		First version
'		1.1 - 03-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************
Dim intTemplateMenuID as Integer
intTemplateMenuID = Request.QueryString.Item("TemplateMenuID")

Dim cnCategoryDel As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdCategoryDel As IDbCommand = cnCategoryDel.CreateCommand()
cmdCategoryDel.CommandText = "DELETE FROM TemplateMenu WHERE TemplateMenuID=" & intTemplateMenuID
cmdCategoryDel.ExecuteNonQuery()

cnCategoryDel.Close()
cmdCategoryDel.Dispose()
cnCategoryDel.Dispose()

Response.Redirect(("Template_Admin_Edit.aspx?TemplateCategoryID=" & Request.QueryString.Item("TemplateCategoryID") & "&TemplateID=" & Request.QueryString.Item("TemplateID")))
%>
