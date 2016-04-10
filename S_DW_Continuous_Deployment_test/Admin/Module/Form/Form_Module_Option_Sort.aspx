<%@ Page CodeBehind="Form_Module_Option_Sort.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Option_Sort" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim strFormOptionsID As String
Dim strSortDirection As String
Dim i As Integer
Dim strFormFieldID As String


strFormOptionsID	= request.QueryString.Item("FormOptionsID")
strFormFieldID		= request.QueryString.Item("FormFieldID")
strSortDirection	= request.QueryString.Item("SortDirection")

Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd	As IDbCommand		= cn.CreateCommand
Dim ds	As DataSet			= New DataSet
Dim da	As IDbDataAdapter	= Database.CreateAdapter()
da.SelectCommand			= cmd
Dim dt	As DataTable
Dim row	As DataRow

cmd.CommandText = "SELECT * FROM FormOptions WHERE FormOptionsFormFieldID = " & strFormFieldID & " ORDER BY FormOptionsSort ASC"
da.Fill(ds)
dt = ds.Tables(0)
row = dt.Rows(0)

i = 1
For intRowNumber As Integer = 0 To dt.Rows.Count - 1
	row = dt.Rows(intRowNumber)
	If CInt(row("FormOptionsID")) = CInt(strFormOptionsID) Then
		If strSortDirection.ToLower() = "up" Then
			row("FormOptionsSort") = i - 3
		Else
			row("FormOptionsSort") = i + 3
		End If
	Else
		row("FormOptionsSort") = i
	End If
	i = i + 2
Next intRowNumber

Database.CreateCommandBuilder(da)
da.Update(ds)

ds.Dispose()
cmd.Dispose()
cn.Dispose()

If IsNothing(request.QueryString.GetValues("Redirect")) Then
	response.Redirect("Form_Module_Field_Edit.aspx?FormFieldID=" & strFormFieldID)
Else
	response.Redirect("Form_Module_Option_Edit.aspx?FormFieldID=" & strFormFieldID & "&Redirect=Option")
End If

%>

