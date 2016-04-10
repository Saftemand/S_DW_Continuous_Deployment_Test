<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim sql As String
Dim TemplateCategoryID As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			07-02-2002
'	Last modfied:		07-02-2002
'
'	Purpose: List paragraphs
'
'	Revision history:
'		1.0 - 07-02-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************

If Not IsNothing(Request.QueryString("ID")) Then

	Dim cnTemplate As IDbConnection = Database.CreateConnection("Dynamic.mdb")
	Dim cmdTemplate As IDbCommand = cnTemplate.CreateCommand

	SQL = "SELECT * FROM [Template] WHERE TemplateID=" & request.QueryString("ID")

	Dim adTemplate As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adTemplate)
	Dim ds As DataSet = New DataSet
	Dim newRow As DataRow

	cmdTemplate.CommandText = sql
	adTemplate.SelectCommand = cmdTemplate
	adTemplate.Fill(ds)

	newRow = ds.Tables(0).Rows(0)
	
	if Base.ChkNumber(request.QueryString("active")) = 1 Then
		newRow("TemplateActive") = true
	Else
		newRow("TemplateActive") = false
	End If
	
	TemplateCategoryID = ds.Tables(0).Rows(0).Item("TemplateCategoryID")
	adTemplate.Update(ds)
	
	cmdTemplate.Dispose
	cnTemplate.Close
	cnTemplate.Dispose

End If

response.Redirect("Template_List.aspx?TemplateCategoryID=" & TemplateCategoryID)
%>
