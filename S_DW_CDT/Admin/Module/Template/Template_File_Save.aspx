<%@ Page CodeBehind="Template_File_Save.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_File_Save" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Collections" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim Ext As String
Dim FileName As String

Dim NewsletterFile As System.IO.StreamWriter
Dim TemplateCategoryID As String
Dim IndexEnd As Integer
Dim Root As String = "/"
Dim TemplateOutput As String
Dim Path As String 

Dim NewsletterMailBody As String
Dim tempStr As String
Dim find As String
Dim TemplateID As String

Dim sql As String
Dim replacewith As Object
Dim IndexStart As Integer
Dim DicCheck As HashTable
Dim Counter As Object
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			28-04-2003
'
'	Purpose: Savefile used by Template_File_Edit.asp. Saves the file from the template editor.
'			 and changes the special <SPAN> tags back to the original DW tags.
'
'	Revision history:
'		1.0 - 28-04-2003 - John Krogh
'		First version
'**************************************************************************************************

TemplateID			= Request.Form.Item("TemplateID")
TemplateCategoryID	= Request.Form.Item("TemplateCategoryID")
Counter				= Request.Form.Item("Counter")
NewsletterMailBody	= Request.Form.Item("NewsletterMailBody")
FileName			= Request.Form.Item("FileName")
DicCheck			= New HashTable()


IndexStart = 1
IndexEnd = 2
TemplateOutput = NewsletterMailBody

Do While IndexStart > 0
	IndexStart = InStr(IndexStart + 1, TemplateOutput, "contentEditable=false s", 1)
	If IndexStart > 0 Then
		IndexEnd = InStr(IndexStart, TemplateOutput, ">", 1)
		If IndexEnd > 0 Then
			tempStr = Mid(TemplateOutput, IndexStart + 21, IndexEnd - IndexStart - 21)
			TemplateOutput = Replace(TemplateOutput, tempStr, "")
		End If
	End If
Loop 

NewsletterMailBody = TemplateOutput

Do While Counter > 0
	Counter = Counter - 1
	find = Session("TemplateArray")(Counter, 1)
	replacewith = Session("TemplateArray")(Counter, 0)
	If Left(replacewith, 1) = "X" Then
		replacewith = Mid(replacewith, 2)
	End If
	
	If DicCheck.Exists(replacewith) = False Then
		DicCheck.add(replacewith, replacewith)
		NewsletterMailBody = Replace(NewsletterMailBody, find, replacewith)
	End If
Loop 

Dim file As New System.IO.FileInfo(FileName)
Ext = file.Extension
Select Case Ext
	Case "htm"
	Case "html"
	Case "asp"
	Case Else
		FileName = FileName & ".html"
End Select

strSql = "UPDATE [Template] SET [TemplateFile]=" & FileName & ", [TemplateIcon]='default.gif' WHERE TemplateID = " & TemplateID
Dim cnTemplateUpdate As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdUpdate As IDbCommand = cnTemplateUpdate.CreateCommand
cmdUpdate.CommandText = strSql
cmdUpdate.ExecuteNonQuery()

strSql = "SELECT TemplateCategory.* FROM TemplateCategory WHERE TemplateCategoryID = " & TemplateCategoryID
Dim cnTemplateCategory As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect As IDbCommand = cnTemplateCategory.CreateCommand
cmdSelect.CommandText = strSql
Dim drTemplateCategory as IDataReader = cmdSelect.ExecuteReader()

Path = Server.MapPath(Root & "Files/Templates/" & drTemplateCategory("TemplateCatgeoryDirectory")) & "\" & FileName

Try
	NewsletterFile = New System.IO.StreamWriter(Path, False, System.Text.Encoding.UTF8)
	NewsletterFile.Write(NewsletterMailBody)
	NewsletterFile.Close()
Catch e as Exception
	Throw new Exception(e)
End Try

drTemplate.Dispose()
drTemplateCategory.Dispose()

cmdSelectDispose()
cnTemplateCategoryDispose()

Response.Redirect(("Template_Admin_Edit.aspx?TemplateID=" & TemplateID & "&TemplateCategoryID=" & TemplateCategoryID))

%>
