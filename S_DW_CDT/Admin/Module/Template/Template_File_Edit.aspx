<%@ Page CodeBehind="Template_File_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_File_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Collections" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim TagPath As String
Dim IndexStart As Integer
Dim NewsletterContentHead As String
Dim NewsletterContentEnd As String
Dim TemplateCategoryID As String
Dim TemplateFile As String
Dim NewsletterContent As String
Dim StaticCounter As Double
Dim strSQL As String
Dim tempStr As String
Dim TemplatePath As String
Dim strName As String

Dim strSpan As String
Dim Root As String

Dim TemplateID As String


Dim IndexEnd As Integer
Dim TemplateOutput As String
Dim myStyle As String
Dim AutoStart As String

Dim dicTags As HashTable
Dim strHolder As String
Dim DWArray(50, 2) As String
Dim Counter As Double

</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			28-04-2003
'
'	Purpose: A Template Editor. Uses DHTML Editor and changes DW tags to <SPAN>'s while the user edits.
'
'	Revision history:
'		1.0 - 28-04-2003 - John Krogh
'		First version
'**************************************************************************************************

Response.Expires = -100

TemplateID = Request.Item("TemplateID")
TemplateFile = Request.Item("TemplateFile")
TemplateCategoryID = Request.Item("TemplateCategoryID")

strSQL = "SELECT Template.*, TemplateCategory.* FROM TemplateCategory INNER JOIN Template ON TemplateCategory.TemplateCategoryID = Template.TemplateCategoryID WHERE Template.TemplateID = 1"' & Base.ChkNumber(CInt(TemplateID))
'Throw New Exception(strSQL)
Dim cnTemplate As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdTemplateSelect As IDbCommand = cnTemplate.CreateCommand
cmdTemplateSelect.CommandText = strSql
Dim drTemplate as IDataReader = cmdTemplateSelect.ExecuteReader()

TemplateOutput = ""
If drTemplate.Read() Then
	TemplateID = drTemplate("TemplateID")
	TemplatePath = Server.MapPath(Root & "Files/Templates/" & drTemplate("TemplateCatgeoryDirectory")) & "/" & TemplateFile
	TemplateOutput = Base.ReadTextFile(TemplatePath)
End If

'drTemplate.NextResult()
'drTemplate.Read()
dicTags = New HashTable()
TagPath = Server.MapPath("..") & "\Template\DWTag_Check_List.txt"
Dim Tagf as New StreamReader(TagPath)

Do 
	strHolder = Trim(Tagf.ReadLine)
	If Not strHolder = "" Then dicTags.Add(strHolder, strHolder)
Loop Until strHolder = ""

Tagf.Close()

IndexStart = 1
IndexEnd = 2
Counter = 0

Do While IndexStart > 0
	
	IndexStart = InStr(IndexStart + 1, TemplateOutput, "<!--@", 1)
	If IndexStart > 0 Then
		IndexEnd = InStr(IndexStart, TemplateOutput, "-->", 1)
		If IndexEnd > 0 Then
			If dicTags.Contains(Mid(TemplateOutput, IndexStart, IndexEnd + 3 - IndexStart)) = True Then
				
				'TagStr = tempStr =  Mid(TemplateOutput, IndexStart, IndexEnd+3-IndexStart)
				'				BigStr = Mid(TemplateOutput, IndexStart-7, IndexEnd-IndexStart + 20)
				'				BigStr = Replace(BigStr, " ", "")
				'				IndexBigStr = InStr(1, BigStr, TagStr, 1)
				'				'w IndexBigStr
				'				BigStr = Replace(BigStr, TagStr, "")
				'				If Len(BigStr) > 0 AND IndexBigStr > 0 Then 
				'					If Mid(BigStr, IndexBigStr, 2) = "><" Then
				'				'		We "ok"
				'						Counter = Counter + 1
				'						DWArray(Counter-1,0) = tempStr
				'						w "HANNNZ"
				'					Else
				tempStr = Mid(TemplateOutput, IndexStart, IndexEnd + 3 - IndexStart)
				Counter = Counter + 1
				DWArray(Counter - 1, 0) = "X" & tempStr
				'						w "HANNNN"
				'					End If
				'				End If
				'
				'				'w Replace(BigStr, "!", "")
				'				'Response.Write("Key exists, and is = " & Replace(dicTags.Item(strHolder), "!", "") & "<br>")
			Else
				tempStr = Mid(TemplateOutput, IndexStart, IndexEnd + 3 - IndexStart)
				Counter = Counter + 1
				DWArray(Counter - 1, 0) = tempStr
			End If
		End If
	End If
Loop 

StaticCounter = Counter

Do While Counter > 0
	If Left(DWArray(Counter - 1, 0), 1) = "X" Then
		strName = Mid(DWArray(Counter - 1, 0), 7, Len(DWArray(Counter - 1, 0)) - 9)
		strSpan = "@" & strName
		DWArray(Counter - 1, 1) = strSpan
		TemplateOutput = Replace(TemplateOutput, Mid(DWArray(Counter - 1, 0), 2), strSpan)
		Counter = Counter - 1
	Else
		strName = Mid(DWArray(Counter - 1, 0), 6, Len(DWArray(Counter - 1, 0)) - 8)
		strSpan = "<SPAN class=dataslug contentEditable=false>{" & Translate.Translate("Her kommer ") & strName & "}</SPAN>"
		DWArray(Counter - 1, 1) = strSpan
		TemplateOutput = Replace(TemplateOutput, DWArray(Counter - 1, 0), strSpan)
		Counter = Counter - 1
	End If
Loop 

Session("TemplateArray") = DWArray.Clone()

myStyle = "<style> SPAN.dataslug { background-color: #ffff33; } </style>"

NewsletterContentHead = "<HTML><HEAD><TITLE> New Document </TITLE><link rel='STYLESHEET' type='text/css' href='http://" & Request.ServerVariables.Item("server_name") & "/Files/Stylesheet1.css'>" & myStyle & "</HEAD><BODY>" '<Div Name='@Gui.EditorStart' style='display: none'></div>"
'NewsletterContentEnd = "<Div Name='@Gui.EditorEnd' style='display: none'></Div></BODY></HTML>"
NewsletterContentEnd = "</BODY></HTML>"
NewsletterContent = NewsletterContentHead & NewsletterContent & TemplateOutput & NewsletterContentEnd

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--

function Save()
{
	Gui.Editor.DOM.body.innerHTML = Gui.Editor.FilterSourceCode(Gui.Editor.DOM.body.innerHTML);
	if (html()) {
		TemplateEditorForm.submit();
	}
}


function SaveAS() {
	var entry = prompt("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>","")
	if (entry != null) 
		{
		Gui.Editor.DOM.body.innerHTML = Gui.Editor.FilterSourceCode(Gui.Editor.DOM.body.innerHTML);
		TemplateEditorForm.FileName.value = entry;
		if(html()){
			TemplateEditorForm.submit();
		}
		}
	}

//-->
</SCRIPT>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("Edit Template"), Translate.Translate("Edit Template"), "javascript")
%>
<body LEFTMARGIN="20" TOPMARGIN="16" onLoad="loadMail();">
<%=Gui.MakeHeaders(Translate.Translate("Edit Template"), Translate.Translate("Edit Template	"), "html")%>
<%Response.ContentType = "application/x-msdownload"%>

<div ID="Tab1" STYLE="display:;">
	<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
		<form name="TemplateEditorForm" method="post" action="Template_File_Save.aspx">
		<tr>
			<td valign="top"><br><br>
				<%=Gui.GroupBoxStart(Translate.Translate("Edit Template"))%>
					<TABLE cellpadding=2 cellspacing=0>
					<tr>
						<td width='170px'>
							<input type="hidden" name="FileName" value="<%=TemplateFile%>">
							<input type="hidden" name="TemplateCategoryID" value="<%'=drTemplate("Template.TemplateCategoryID")%>">
							<input type="hidden" name="TemplateID" value="<%=drTemplate("TemplateID")%>">
							<input type="hidden" name="Counter" value="<%=StaticCounter%>">
							</td>
						<td></td> 
					</tr>
					<%AutoStart = "1"%>
					<tr>
						<td colspan="2"><%'=Gui.Editor("NewsletterMailBody", 550, "", "")%></td>
					</tr>
					<tr>
						<td colspan="2"><br></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>

			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right"><%=Gui.Button(Translate.Translate("Gem som") & "...", "SaveAS();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("OK"), "Save();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Template_Admin_Edit.aspx?TemplateID=" & TemplateID & "&TemplateCategoryID=" & drTemplate("Template.TemplateCategoryID") & "'", 0)%></td>
						<%=Gui.HelpButton("templates", "modules.template.general.list.item.edit.file")%>
						<td width="10"></td>
					</tr>
					<tr>
						<td colspan="4" height="5"></td>
					</tr>			
				</table>
			</td>
		</tr>
	</table>
</div>
<div style="display:none;" width="1px" height="1px" ID="divNewsletterContent" Name="divNewsletterContent"><%=NewsletterContent%></div>
</body>
</html>

<SCRIPT LANGUAGE="JavaScript">
<!--
	function loadMail() {
		Gui.Editor.DocumentHTML = unescape(escape(document.getElementById("divNewsletterContent").innerHTML));
		Gui.Editor.ShowBorders = true;
		init = true;
	}
//-->
</SCRIPT>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>