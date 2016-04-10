<%@ Page CodeBehind="Form_Module_Field_Save.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Field_Save" ValidateRequest="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim GoToOptionEdit As Boolean
Dim FormFieldSize As String
Dim FormFieldFormID As String
Dim FormFieldText As String
Dim FormFieldName As String
Dim FormFieldDefaultValue As String
Dim FormFieldColor As String
Dim FormFieldAutoValue As String
Dim FormFieldTextareaHeight As String
Dim FormFieldSort As Integer
Dim FormFieldMaxLength As String
Dim FormFieldSystemName As String
Dim FormFieldRequired As String
Dim FormFieldActive As String
Dim FormFieldID As String
Dim FormFieldImage As String
Dim FormFieldType As String

	FormFieldID = Base.ChkValue(Request.Form.Item("FormFieldID"))
FormFieldFormID			= Base.ChkValue(Request.Form.Item("FormFieldFormID"))
FormFieldName			= Base.ChkValue(Request.Form.Item("FormFieldName"))
FormFieldSystemName		= Base.ChkValue(Request.Form.Item("FormFieldSystemName"))
FormFieldType			= Base.ChkValue(Request.Form.Item("FormFieldType"))
FormFieldDefaultValue	= Base.ChkValue(Request.Form.Item("FormFieldDefaultValue"))
FormFieldMaxLength		= Base.ChkValue(Request.Form.Item("FormFieldMaxLength"))
FormFieldSize			= Base.ChkValue(Request.Form.Item("FormFieldSize"))
FormFieldTextareaHeight = Base.ChkValue(Request.Form.Item("FormFieldTextareaHeight"))
FormFieldRequired		= Base.ChkValue(Request.Form.Item("FormFieldRequired"))
FormFieldActive			= Base.ChkValue(Request.Form.Item("FormFieldActive"))
FormFieldText			= Base.ChkValue(Request.Form.Item("FormFieldText"))
FormFieldImage			= Base.ChkValue(Request.Form.Item("FormFieldImage"))
FormFieldColor			= Base.ChkValue(Request.Form.Item("FormFieldColor"))
FormFieldAutoValue		= Base.ChkValue(Request.Form.Item("FormFieldAutoValue"))



    'If FormFieldName <> "" Then
    '	FormFieldName = Base.ChkValue(Replace(FormFieldName, "'", "''"))
    'End If
If FormFieldRequired = "on" Then
	FormFieldRequired = 1
Else
	FormFieldRequired = 0
End If
If FormFieldActive = "on" Then
	FormFieldActive = 1
Else
	FormFieldActive = 0
End If
If FormFieldMaxLength = "" Then
	FormFieldMaxLength = 0
End If
If FormFieldSize = "" Then
	FormFieldSize = 0
End If

Dim cnFormModule	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdFormModule	As IDbCommand		= cnFormModule.CreateCommand
Dim dsFormModule	As DataSet			= New DataSet
Dim daFormModule	As IDbDataAdapter	= Database.CreateAdapter()
daFormModule.SelectCommand				= cmdFormModule
Dim dtFormModule	As DataTable
Dim row				As DataRow

If isNumeric(Request.Form.Item("NewSort")) Then
	FormFieldSort = CInt(Request.Form.Item("NewSort")) + 1
	cmdFormModule.CommandText = "UPDATE FormField SET FormFieldSort = FormField.FormFieldSort+1 WHERE FormFieldFormID=" & FormFieldFormID & " AND FormFieldSort > " & Request.Form.Item("NewSort")
	cmdFormModule.ExecuteNonQuery()
Else
	cmdFormModule.CommandText = "SELECT * FROM FormField ORDER BY FormFieldSort DESC"
	Dim dr as IDataReader = cmdFormModule.ExecuteReader()
	If dr.Read() Then
		FormFieldSort = CInt(dr("FormFieldSort").ToString) + 1
	Else
		FormFieldSort = 1
	End If
	dr.Close()
	dr.Dispose()
End If

If FormFieldID <> "" Then
	cmdFormModule.CommandText = "SELECT * FROM FormField WHERE FormFieldID = " & FormFieldID
	daFormModule.Fill(dsFormModule)
	dtFormModule = dsFormModule.Tables(0)
	row = dtFormModule.Rows(0)
	GoToOptionEdit = False
Else
	cmdFormModule.CommandText = "SELECT TOP 1 * FROM FormField"
	daFormModule.Fill(dsFormModule)
	dtFormModule = dsFormModule.Tables(0)
	row = dtFormModule.NewRow()
	dtFormModule.Rows.Add(row)
	row("FormFieldSort")		= FormFieldSort
	GoToOptionEdit = True
End If

row("FormFieldFormID")			= FormFieldFormID
row("FormFieldName")			= FormFieldName
row("FormFieldSystemName")		= FormFieldSystemName
row("FormFieldType")			= FormFieldType
row("FormFieldDefaultValue")	= FormFieldDefaultValue

If IsNumeric(FormFieldMaxLength) Then
	row("FormFieldMaxLength")		= FormFieldMaxLength
Else
	row("FormFieldMaxLength")		= 0
End If

If IsNumeric(FormFieldSize) Then
	row("FormFieldSize")			= FormFieldSize
Else
	row("FormFieldSize")			= 0
End If

If IsNumeric(FormFieldTextareaHeight) Then
	row("FormFieldTextareaHeight")	= FormFieldTextareaHeight
Else
	row("FormFieldTextareaHeight")	= 0
End If


row("FormFieldRequired")	= Base.ChkBoolean(FormFieldRequired)
row("FormFieldActive")		= Base.ChkBoolean(FormFieldActive)
row("FormFieldText")		= FormFieldText
row("FormFieldImage")		= FormFieldImage
row("FormFieldColor")		= FormFieldColor
row("FormFieldAutoValue")	= FormFieldAutoValue

'Updates Database
Database.CreateCommandBuilder(daFormModule)
daFormModule.Update(dsFormModule)

'new id
If Not isNumeric(FormFieldID) Then
	FormFieldID = Database.GetAddedIdentityKey(row, cnFormModule, 0)
End if

dsFormModule.Dispose()
cmdFormModule.Dispose()
cnFormModule.Dispose()

If (FormFieldType = "Select" Or FormFieldType = "Radio") And GoToOptionEdit Then
	response.Redirect("Form_Module_Option_Edit.aspx?FormFieldID=" & FormFieldID & "&FormFieldFormID=" & FormFieldFormID)
Else
	response.Redirect("Form_Module_Edit.aspx?FormID=" & FormFieldFormID & "&Tab=2")
End If

%>
