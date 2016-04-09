<%@ Page CodeBehind="Form_Module_Save.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim FormEmailFieldID As String
Dim FormID As Integer
Dim FormLabelOverField As String
Dim FormLabelRequired As String
Dim FormLabelBold As String
Dim NewFormID As Integer
Dim FormColumnShiftFormFieldID As String
Dim FormName As String
Dim FormNameOld As String
Dim FormSubject As String

	Dim Redirect As String
Dim blnNewForm as Boolean = false
Dim blnEditForm as Boolean = true

FormID						= CInt(Request.Form.Item("FormID"))
FormName					= Base.ChkValue(Request.Form.Item("FormName"))
FormNameOld					= Base.ChkValue(Request.Form.Item("FormNameOld"))
FormEmailFieldID			= Base.ChkValue(Request.Form.Item("FormEmailFieldID")& "")

FormColumnShiftFormFieldID	= Base.ChkValue(Request.Form.Item("FormColumnShiftFormFieldID"))
FormLabelOverField			= Base.ChkBoolean(Request.Form.Item("FormLabelOverField") & "")
FormLabelBold				= Base.ChkBoolean(Request.Form.Item("FormLabelBold")& "")
FormLabelRequired			= Base.ChkValue(Request.Form.Item("FormLabelRequired"))

	If FormSubject <> "" Then
		FormSubject = Base.ChkValue(Replace(FormSubject, "'", "''"))
	End If

Dim dm As New DataManager()
'Dim cnFormModule	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
'Dim cmdFormModule	As IDbCommand		= cnFormModule.CreateCommand
Dim dsFormModule	As DataSet			= New DataSet
'Dim daFormModule	As IDbDataAdapter	= Database.GetAdapter()
'daFormModule.SelectCommand				= cmdFormModule
Dim dtFormModule	As DataTable
Dim row				As DataRow

If IsNumeric(FormID) And FormID > 0 Then
	If ChkFormExists(FormID, FormName, FormNameOld) Then
		blnEditForm = false
	Else
		'cmdFormModule.CommandText = "SELECT * FROM [Form] WHERE FormID = " & FormID
		'daFormModule.Fill(dsFormModule)
		dsFormModule = dm.getDataSet("Dynamic.mdb", "SELECT * FROM [Form] WHERE FormID = " & FormID)
		dtFormModule = dsFormModule.Tables(0)
		row = dtFormModule.Rows(0)
	End If
Else
	blnNewForm = true

	If ChkFormExists(0, FormName, "") Then
		blnEditForm = false
		FormID = 0
	Else
		'cmdFormModule.CommandText = "SELECT * FROM [Form] WHERE FormID = -1"
		'daFormModule.Fill(dsFormModule)
		dsFormModule = dm.getDataSet("Dynamic.mdb", "SELECT * FROM [Form] WHERE FormID = -1")
		dtFormModule = dsFormModule.Tables(0)
		row = dtFormModule.NewRow()
		dtFormModule.Rows.Add(row)
	End If
End If	

If Not blnEditForm Then
	Redirect = "Form_Module_Edit.aspx?alertFormExists=1&"
	Redirect = Redirect &"FormID="& FormID &"&"
	Redirect = Redirect &"FormName="& FormName &"&"
	Redirect = Redirect &"FormEmailFieldID="& FormEmailFieldID &"&"
	Redirect = Redirect &"FormColumnShiftFormFieldID="& FormColumnShiftFormFieldID &"&"
	Redirect = Redirect &"FormLabelOverField="& FormLabelOverField &"&"
	Redirect = Redirect &"FormLabelBold="& FormLabelBold &"&"
	Redirect = Redirect &"FormLabelRequired="& FormLabelRequired &""
	
Else
	row("FormName") = FormName

	If FormEmailFieldID = "" Then
		row("FormEmailFieldID") = 0 'Default
	Else
		row("FormEmailFieldID") = FormEmailFieldID
	End If

	If FormColumnShiftFormFieldID = "" Then
		row("FormColumnShiftFormFieldID") =	0
	Else
		row("FormColumnShiftFormFieldID") = FormColumnShiftFormFieldID
	End if

	If FormLabelOverField = "" Then
		row("FormLabelOverField") = 0
	Else
		row("FormLabelOverField") = FormLabelOverField
	End If

	If FormLabelBold = "" Then
		row("FormLabelBold") = 0
	Else
		row("FormLabelBold") = FormLabelBold
	End If

	If FormLabelRequired = "" Then
		row("FormLabelRequired") = System.DBNull.Value
	Else
		row("FormLabelRequired") = FormLabelRequired
	End If

	
	'Updates Database
	'Database.GetCommandBuilder(daFormModule)
	'daFormModule.Update(dsFormModule)
		dm.Update(dsFormModule)
    

	If Not IsNumeric(FormID) Or FormID = 0 Then
		'FormID = Database.UpdateDatasetIdentity(row, cnFormModule, 0)
		FormID = dm.GetIdentity()
	End if

	dsFormModule.Dispose()
	'cmdFormModule.Dispose()
	'cnFormModule.Dispose()
	dm.Dispose()

	If not blnNewForm then 'IsNumeric(FormID) And FormID > 0 Then
		Redirect = "Form_Module_List.aspx"
	Else
		Redirect = "Form_Module_Edit.aspx?FormID=" & FormID
	End If
End If


response.Redirect(Redirect)
response.end


%>
