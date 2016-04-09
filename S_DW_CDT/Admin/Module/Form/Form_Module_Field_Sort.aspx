<%@ Page CodeBehind="Form_Module_Field_Sort.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Field_Sort" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

Dim strFormID As String
Dim i As Short
Dim strSortDirection As String
Dim strFormFieldID As String


strFormID			= request.QueryString.Item("FormID")
strFormFieldID		= request.QueryString.Item("FormFieldID")
strSortDirection	= request.QueryString.Item("SortDirection")

Dim cn		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd		As IDbCommand		= cn.CreateCommand
Dim ds		As DataSet			= New DataSet
Dim da		As IDbDataAdapter	= Database.CreateAdapter()
da.SelectCommand				= cmd
Dim dt		As DataTable
Dim row		As DataRow
cmd.CommandText = "SELECT * FROM FormField WHERE FormFieldFormID = " & strFormID & " ORDER BY FormFieldSort ASC"
da.Fill(ds)
dt = ds.Tables(0)
row = dt.Rows(0)

i = 1
For intRowNumber As Integer = 0 To dt.Rows.Count - 1
	row = dt.Rows(intRowNumber)
	If CInt(row("FormFieldID")) = CInt(strFormFieldID) Then
		If strSortDirection = "Up" Then
			row("FormFieldSort") = i - 3
		Else
			row("FormFieldSort") = i + 3
		End If
	Else
		row("FormFieldSort") = i
	End If
	i = i + 2
Next intRowNumber

Database.CreateCommandBuilder(da)
da.Update(ds)

ds.Dispose()
cmd.Dispose()
cn.Dispose()

response.Redirect("Form_Module_Edit.aspx?FormID=" & strFormID & "&Tab=2")
%>

