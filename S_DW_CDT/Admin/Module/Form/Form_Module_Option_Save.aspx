<%@ Page CodeBehind="Form_Module_Option_Save.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Option_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim FormFieldFormID As String
Dim FormOptionsValue As String
Dim FormOptionsText As Object
Dim FormOptionsSort As String
Dim FormFieldID As String
Dim FormOptionsID As String

FormFieldFormID		= Request.QueryString.Item("FormFieldFormID")
FormFieldID			= Request.QueryString.Item("FormFieldID")
FormOptionsID		= Request.Form.Item("FormOptionsID")
FormOptionsText		= Base.ChkValue(Request.Form.Item("FormOptionsText"))
FormOptionsValue	= Base.ChkValue(Request.Form.Item("FormOptionsValue"))
FormOptionsSort		= Request.Form.Item("FormOptionsSort")

Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd	As IDbCommand		= cn.CreateCommand
Dim ds	As DataSet			= New DataSet
Dim da	As IDbDataAdapter	= Database.CreateAdapter()
da.SelectCommand			= cmd
Dim dt	As DataTable
Dim row	As DataRow

If Not FormOptionsID = "" Then
	cmd.CommandText = "SELECT * FROM FormOptions WHERE FormOptionsID = " & FormOptionsID
	da.Fill(ds)
	dt = ds.Tables(0)
	row = dt.Rows(0)
Else
	cmd.CommandText = "SELECT TOP 1 * FROM FormOptions"
	da.Fill(ds)
	dt				= ds.Tables(0)
	row				= dt.NewRow()
	dt.Rows.Add(row)
	row("FormOptionsActive")		= True
End If

row("FormOptionsFormFieldID")	= FormFieldID
row("FormOptionsText")			= FormOptionsText
row("FormOptionsValue")			= FormOptionsValue
row("FormOptionsSort")			= CInt(FormOptionsSort) + 1

'Updates Database
Database.CreateCommandBuilder(da)
da.Update(ds)

ds.Dispose()
cmd.Dispose()
cn.Dispose()

response.Redirect("Form_Module_Option_Edit.aspx?FormFieldID=" & FormFieldID & "&FormFieldFormID=" & FormFieldFormID)

%>
