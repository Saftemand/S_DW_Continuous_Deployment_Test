<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="NewsletterExtended_Letter_Body.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Body" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%
Dim NewsletterMailAttach As String
Dim NewsletterContentEnd As String
Dim NewsletterLevel As String
Dim NewsletterStylesheetID As String
Dim NewsletterDescription As String
Dim NewsletterCancelLink  As String
Dim NewsletterName As String
Dim NewsletterEncodingID As String
Dim NewsletterContentHead As String
Dim NewsletterTextMailBody As String
Dim NewsletterSaved As String
Dim NewsletterMailSenderEmail As String
Dim NewsletterCancelLinkText As String
Dim NewsletterSubscriptionLinkText As String
Dim NewsletterSpecTextMail As Boolean
Dim NewsletterEndcodingID As String
Dim NewsletterID As String
Dim NewsletterMailSenderName As String
Dim NewsletterTemplateID As String
Dim NewsletterMailSubject As String
Dim NewsletterSubscriptionLink As String
Dim NewsletterContent As String

Dim ParagraphTemplateID As String
Dim TemplatePath As String
Dim TemplateOutput As String

Dim DWEditorTagsArray() As String
Dim IndexStart As Integer
Dim IndexEnd As Integer

Dim strSpan As String
Dim myStyle As String
Dim strSendText As String
Dim blnCategoryChecked As Integer
Dim strName As String
Dim varAttachmentList As String
Dim tempStr As String
Dim DWEditorTagsArrayString As String

Dim FileHome As String = "/Files/"
Dim StaticCounter As Byte
Dim sql As String

Dim varTab As String
Dim DWArray(50, 1) As String
Dim Counter As Integer
Dim AutoStart As String
Dim blnPagebased As boolean = false
Dim NewsletterPageBasedLink As String
Dim NewsletterLetterType As String

%>
<%

Dim cnDynamic				As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand
Dim cmdDynamic				As IDbCommand	 = cnDynamic.CreateCommand

Dim drNewsletter			As IDataReader	 
Dim drSeletedTemplate		As IDataReader
Dim drTemplate				As IDataReader
Dim dr						As IDataReader
Dim drAttachment			As IDataReader
Dim drUserField				As IDataReader


response.Expires = -100

varTab = Request.QueryString.Item("Tab")
NewsletterID = Base.ChkNumber(Request.Item("ID"))

sql = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
cmdNewsletterExtended.CommandText = sql
drNewsletter = cmdNewsletterExtended.ExecuteReader() 

If drNewsletter.Read() Then
	
	NewsletterLetterType = drNewsletter("NewsletterLetterType").ToString
	if NewsletterLetterType = "1" Then
		blnPagebased = true
	End If
	
	NewsletterPageBasedLink = drNewsletter("NewsletterPageBasedLink").ToString
	NewsletterName = drNewsletter("NewsletterName").ToString
	NewsletterDescription = drNewsletter("NewsletterDescription").ToString
	If drNewsletter("NewsletterStylesheetID").ToString <> "" And Not drNewsletter("NewsletterStylesheetID").ToString = "0" Then
		NewsletterStylesheetID = drNewsletter("NewsletterStylesheetID").ToString
	Else
		NewsletterStylesheetID = "1"
	End If
	NewsletterTemplateID = drNewsletter("NewsletterTemplateID").ToString
	If Not NewsletterTemplateID <> "" Then
		NewsletterTemplateID = 0
	End If
	NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel = drNewsletter("NewsletterLevel").ToString
	NewsletterContent = drNewsletter("NewsletterContent").ToString
	NewsletterMailSenderName = drNewsletter("NewsletterMailSenderName").ToString
	NewsletterMailSenderEmail = drNewsletter("NewsletterMailSenderEmail").ToString
	NewsletterMailSubject = drNewsletter("NewsletterMailSubject").ToString
	NewsletterCancelLink = drNewsletter("NewsletterCancelLink").ToString
	NewsletterSubscriptionLink = drNewsletter("NewsletterSubscriptionLink").ToString
	NewsletterCancelLinkText = drNewsletter("NewsletterCancelLinkText").ToString
	NewsletterSubscriptionLinkText = drNewsletter("NewsletterSubscriptionLinkText").ToString
	NewsletterDescription = drNewsletter("NewsletterDescription").ToString
	ParagraphTemplateID = NewsletterTemplateID
	NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel = drNewsletter("NewsletterLevel").ToString
	NewsletterTextMailBody = drNewsletter("NewsletterTextMailBody").ToString
	NewsletterSpecTextMail = Base.ChkBoolean(LTrim(RTrim(drNewsletter("NewsletterSpecTextMail").ToString)))
	NewsletterSaved = "Yes"
Else
	NewsletterName = ""
	NewsletterDescription = ""
	NewsletterStylesheetID = "1"
	NewsletterEndcodingID = "utf-8"
	NewsletterLevel = "1"
	NewsletterSaved = "No"
End If

drNewsletter.Dispose()

sql = "SELECT * FROM Template WHERE TemplateID = " & Base.ChkNumber(NewsletterTemplateID)
cmdDynamic.CommandText = sql
drTemplate = cmdDynamic.ExecuteReader()

TemplateOutput = ""
If NewsletterLevel = 1 Then
	NewsletterContent = ""
	If drTemplate.Read() Then
		TemplatePath = Server.MapPath(FileHome & "Templates\Newsletters") & "\" & drTemplate("TemplateFile").ToString
		TemplateOutput = Base.ReadTextFile(TemplatePath)
		If InStr(1, Mid(TemplateOutput, 1, 5), "<TR>", 1) Then
			TemplateOutput = "<TABLE>" & TemplateOutput
		End If
		If InStr(1, Mid(TemplateOutput, 1, 5), "<TD>", 1) Then
			TemplateOutput = "<TABLE><TR>" & TemplateOutput
		End If
	End If
End If
drTemplate.Dispose()

NewsletterContent = NewsletterContent & TemplateOutput

'IndexStart = 1
'IndexEnd = 2
'Counter = 0
'Do While IndexStart > 0
'	IndexStart = InStr(IndexStart + 1, NewsletterContent, "<!--@", CompareMethod.Text)
'	If IndexStart > 0 Then
'		IndexEnd = InStr(IndexStart, NewsletterContent, "-->", CompareMethod.Text)
'		If IndexEnd > 0 Then
'			Counter = Counter + 1
			
'			tempStr = Mid(NewsletterContent, IndexStart, IndexEnd + 3 - IndexStart)
'			DWArray(Counter - 1, 0) = tempStr
			
'		End If
	'End If
'Loop 
'StaticCounter = Counter

'Do While Counter > 0
'	strName = Mid(DWArray(Counter - 1, 0), 6, Len(DWArray(Counter - 1, 0)) - 8)
'	strSpan = "<SPAN class=dataslug contentEditable=false>{" & Translate.Translate("Her kommer %%", "%%", strName) & "}</SPAN>"
'	DWArray(Counter - 1, 1) = strSpan
'	NewsletterContent = Replace(NewsletterContent, DWArray(Counter - 1, 0), strSpan)
'	Counter = Counter - 1
'Loop 

'Session("NewsletterArray") = DWArray.Clone()

myStyle = "<style> SPAN.dataslug { background-color: #ffff33; } </style>"

NewsletterContentHead = "<HTML><HEAD><TITLE> New Document </TITLE><link rel='STYLESHEET' type='text/css' href='http://" & Request.ServerVariables.Item("server_name") & "/Files/Stylesheet" & NewsletterStylesheetID & ".css'>" & myStyle & "</HEAD><BODY>"
NewsletterContentEnd = "</BODY></HTML>"
NewsletterContent = NewsletterContentHead & NewsletterContent & NewsletterContentEnd

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedAttachment WHERE NewsletterletterID = " & NewsletterID
drAttachment = cmdNewsletterExtended.ExecuteReader()

varAttachmentList = "<table width='570px'><tr>" & "<td align='left'><strong>" & Translate.Translate("Fil") & "</strong></td>" & "<td align='right'><strong>" & Translate.Translate("Størrelse") & "</strong></td>" & "<td align='center' width='48'><strong>" & Translate.Translate("Slet") & "</strong></td></tr>"
varAttachmentList &= "<tr><td bgColor='#c4c4c4' colSpan='3'></td></tr>"

Dim dblTotalAttachment As Double = 0
Dim blnDrAttachmentHasRows As Boolean = false
Do While drAttachment.Read()
	If Not blnDrAttachmentHasRows Then
		blnDrAttachmentHasRows = True
	End If
	Try
            Dim fi As New System.IO.FileInfo(Server.MapPath("/Files/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/" & drAttachment("NewsletterAttachmentPath").ToString))
		dblTotalAttachment += Math.Round((fi.Length / 1024), 2)
		varAttachmentList = varAttachmentList & "<tr><td align='left'>"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Icons/Attachment.gif"" align=""absMiddle"" border=""0"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td align='right'>" & Math.Round((fi.Length / 1024), 2) &  " Kb </td>" 
		varAttachmentList = varAttachmentList & "<td align='center'><a href=""JavaScript:DeleteAttachment('" & drAttachment("NewsletterAttachmentID").ToString & "')"">"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Delete.gif"" border=""0"" width=""15"" height=""17""></a></td>"
		varAttachmentList = varAttachmentList & "</tr>"
		varAttachmentList = varAttachmentList & "<tr><span width='100%' id='bodyheight'><td bgColor='#c4c4c4' colSpan='3'>"
		varAttachmentList = varAttachmentList & "</td></span></tr>"
	Catch e As Exception
		varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Icons/Attachment.gif"" align=""absMiddle"" border=""0"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td align='center' valign='middle'><a href=""JavaScript:DeleteAttachment('" & drAttachment("NewsletterAttachmentID").ToString & "')"">"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Delete.gif"" border=""0"" width=""15"" height=""17""></a></td>"
		varAttachmentList = varAttachmentList & "</tr>"
		varAttachmentList = varAttachmentList & "<tr><span width='100%' id='bodyheight'><td bgColor='#c4c4c4' colSpan='2'>"
		varAttachmentList = varAttachmentList & "</td></span></tr>"
	End Try
Loop 

drAttachment.Dispose()

If Not blnDrAttachmentHasRows Then
	varAttachmentList = varAttachmentList & "<tr><td>"
	varAttachmentList = varAttachmentList & "&nbsp;" & Translate.Translate("Ingen vedhæftede filer") & "</td>"
	varAttachmentList = varAttachmentList & "</tr>"
Else
	varAttachmentList = varAttachmentList & "<tr><td></td><td align='right'><strong>" & dblTotalAttachment & " Kb</strong></td></tr>"
End If

varAttachmentList = varAttachmentList & "</table>"
AutoStart = "1"

'''' NP 06/04-2006
'''' WARNING DO NOT MAKE CHANGES to this without cheking out NewsletterExtended_Letter_Save.aspx.vb --> LoadTagsIntoArray()

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedUserField"
drUserField = cmdNewsletterExtended.ExecuteReader()

    DWEditorTagsArrayString = ",DWUserName,DWUserID,DWUserEmail,DWUserPassword,DWNewsletterSubscriptionLink,DWNewsletterCancelLink"

Do While drUserField.Read()
	DWEditorTagsArrayString = DWEditorTagsArrayString & ",DW" & drUserField("NewsletterUserFieldSystemName").ToString
Loop 
drUserField.Close()
drUserField.Dispose()

DWEditorTagsArray = Split(DWEditorTagsArrayString, ",")

    For iTag As Integer = 1 To DWEditorTagsArray.Length - 1
        strName = DWEditorTagsArray(iTag)
        strSpan = "<SPAN class=dataslug contentEditable=false>{" & Translate.Translate("Her kommer %%", "%%", strName) & "}</SPAN>"
        DWArray(iTag, 0) = "<!--@" & strName & "-->"
        DWArray(iTag, 1) = strSpan
        NewsletterContent = Replace(NewsletterContent, DWArray(iTag, 0), strSpan)
    Next
'''' Warning end '''

StaticCounter = DWEditorTagsArray.length

Session("NewsletterArray") = DWArray.Clone()

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JavaScript">
<!--

function MTabClick(elm){
	var id = elm.id;
	if (id.indexOf('_head')>0){
		TabClick(elm);
	}else{
		id = id+"_head";
		TabClick(document.getElementById(id));
	}
}
// variable ensure the DWEditor does not load the content automatic and therefore won't overwrite the content you load.
function loadMail()
{
	DWEditor.DocumentHTML = document.getElementById("divNewsletterContent").value;
	DWEditor.ShowBorders = true;
	init = true;
		
}

function RipDocumentHTML(strDocumentHTML)
{
return (strDocumentHTML.replace("<%=NewsletterContentHead%>", "")).replace( "<%=NewsletterContentEnd%>", "");
}

function SaveMail(imgObj)
{
	var varEmailTest
	varEmailTest = validateEmail(document.getElementById('NewsletterMail').NewsletterMailSenderEmail.value);
	
	if(document.getElementById('NewsletterMail').NewsletterMailSubject.value.length > 255 || document.getElementById('NewsletterMail').NewsletterMailSubject.value.length < 1)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Emne"))%>\n<%=Translate.JSTranslate("Max %% tegn i Â´%f%Â´","%%","255", "%f%", Translate.JSTranslate("Emne"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').NewsletterMailSenderName.value.length > 255)
		{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Afsender navn")%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(varEmailTest==false)
		{
		alert("<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Afsender e-mail"))%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	<%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") <> "EditorNew" Then%>
	else if(RipDocumentHTML(DWEditor.DocumentHTML).replace("&nbsp;","") == "" && document.getElementById('NewsletterMail').NewsletterLetterType.value == 0)
		{
		alert('<%=Translate.JsTranslate("Nyhedsbrevet er tomt")%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		<%End If%>

	if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length < 1)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Afmeldingslink"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length > 0)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Afmelding"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length < 1)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Abonnementslink"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length > 0)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Abonnement ændringsside"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}

		
	if(document.getElementById('NewsletterMail').NewsletterLetterType.value == 1 && document.getElementById('NewsletterMail').NewsletterPageBasedLink.value.length < 1)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til kildeside"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}

	//editSource(imgObj)
	
	
	var blnTestValue = IsCategorySelected();
	
	//if(blnTestValue == false) {
//		alert("<%=Translate.JsTranslate("Der skal vælges en liste!")%>");
//		MTabClick(document.getElementById('Tab2'));
//	} else {
		if(<%=blnPageBased%> = 'True'){
			var blnTestValue = IsCategorySelected();
			if(blnTestValue == false) {
				document.getElementById('NewsletterMail').submit();
			} else {
				document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true";
				document.getElementById('NewsletterMail').submit();
			}
		}
		else if(html()){
			DWEditor.DOM.body.innerHTML = DWEditor.FilterSourceCode(DWEditor.DOM.body.innerHTML);
			var blnTestValue = IsCategorySelected();
			if(blnTestValue == false) {
				document.getElementById('NewsletterMail').submit();
			} else {
				document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true";
				document.getElementById('NewsletterMail').submit();
			}
		}
	//}
}

function SaveSendMail()
{
	var varEmailTest
	varEmailTest = validateEmail(document.getElementById('NewsletterMail').NewsletterMailSenderEmail.value);
	
	if(document.getElementById('NewsletterMail').NewsletterMailSubject.value.length > 255 || document.getElementById('NewsletterMail').NewsletterMailSubject.value.length < 1)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%","%%", Translate.JsTranslate("Emne"))%>\n<%=Translate.JSTranslate("Max %% tegn i ´%f%´","%%","255", "´%f%´", Translate.JSTranslate("Emne"))%>');
		return false;
		}
	else if(document.getElementById('NewsletterMail').NewsletterMailSenderName.value.length > 255)
		{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Afsender navn")%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(varEmailTest==false)
		{
		alert("<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Afsender e-mail"))%>");
		return false;
		}
	else if(RipDocumentHTML(DWEditor.DocumentHTML).replace("&nbsp;","") == "" && document.getElementById('NewsletterMail').NewsletterLetterType.value == 0)
		{
		alert("<%=Translate.JsTranslate("Nyhedsbrevet er tomt")%>");
		return false;
		}
	
	if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length < 1)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Afmeldingslink"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		
	else if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length > 0)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Afmelding"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length < 1)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Abonnementslink"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length > 0)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Abonnement ændringsside"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}

	//editSource(imgObj)
	DWEditor.DOM.body.innerHTML = DWEditor.FilterSourceCode(DWEditor.DOM.body.innerHTML);
	
	var blnTestValue = IsCategorySelected();
	
	if(blnTestValue == false) {
		alert('<%=Translate.JsTranslate("Der skal vælges en liste!")%>');
		MTabClick(document.getElementById('Tab2_head'));
	} else {
		if(html()){
			var blnTestValue = IsCategorySelected();
			if(blnTestValue == false) {
				document.getElementById('NewsletterMail').submit();
			} else {
				document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true&SendMail=true";
				document.getElementById('NewsletterMail').submit();
			}
		}
	}
}

function SavePreviewMail()
{
	var varEmailTest
	varEmailTest = validateEmail(document.getElementById('NewsletterMail').NewsletterMailSenderEmail.value);
	
	if(document.getElementById('NewsletterMail').NewsletterMailSubject.value.length > 255 || document.getElementById('NewsletterMail').NewsletterMailSubject.value.length < 1)
		{
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%","%%", Translate.JsTranslate("Emne"))%>\n<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Emne")%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').NewsletterMailSenderName.value.length > 255)
		{
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Afsender navn")%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(varEmailTest==false)
		{
		alert("<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Afsender e-mail"))%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		<%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") <> "EditorNew" Then%>
	else if(RipDocumentHTML(DWEditor.DocumentHTML).replace("&nbsp;","") == "" && document.getElementById('NewsletterMail').NewsletterLetterType.value == 0)
		{
		alert("<%=Translate.JsTranslate("Nyhedsbrevet er tomt")%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		<%End If%>
	
	if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length < 1)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Afmeldingslink"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		
	else if(document.getElementById('NewsletterMail').Link_NewsletterCancelLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterCancelLinkText.value.length > 0)
		{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Afmelding"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length > 0 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length < 1)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst på Abonnementslink"))%>");
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
	else if(document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value.length < 1 && document.getElementById('NewsletterMail').NewsletterSubscriptionLinkText.value.length > 0)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til Abonnement ændringsside"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}
		
	if(document.getElementById('NewsletterMail').NewsletterLetterType.value == 1 && document.getElementById('NewsletterMail').NewsletterPageBasedLink.value.length < 1)
		{
		document.getElementById('NewsletterMail').Link_NewsletterSubscriptionLink.value
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Link til kildeside"))%>');
		MTabClick(document.getElementById('Tab1_head'));
		return false;
		}

	//editSource(imgObj)
	
	
	var blnTestValue = IsCategorySelected();
	
	if(blnTestValue == false) {
		alert("<%=Translate.JsTranslate("Der skal vælges en liste!")%>");
		MTabClick(document.getElementById('Tab2'));
	} else {
		if(<%=blnPageBased%> = 'True'){
			var blnTestValue = IsCategorySelected();
			if(blnTestValue == false) {
				document.getElementById('NewsletterMail').submit();
			} else {
				document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true&PreviewMail=true";
				document.getElementById('NewsletterMail').submit();
			}
		}
		else if(html()){
			DWEditor.DOM.body.innerHTML = DWEditor.FilterSourceCode(DWEditor.DOM.body.innerHTML);
			var blnTestValue = IsCategorySelected();
			if(blnTestValue == false) {
				document.getElementById('NewsletterMail').submit();
			} else {
				document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true&PreviewMail=true";
				document.getElementById('NewsletterMail').submit();
			}
		}
	}
}

function validateEmail(strEmail)
{
	 var re = new RegExp(/^[\w-\.]{1,}\@([\w-]{1,}\.){1,}[\w]{2,3}$/);
	 var s = re.test(strEmail);
	 return(s);
}

function SaveAttachment()
{
	if(document.getElementById('NewsletterMail').NewsletterMailAttach.value != "")
		{
		document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true&SaveAttachment=true";
		document.getElementById('NewsletterMail').submit();
		}
	else
		alert("<%=Translate.JsTranslate("Der er ikke valgt en fil")%>");
}

function DeleteAttachment(ID)
{
	html();
	document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_save.aspx?Type=Body&SaveCategory=true&DeleteAttachment=true&ID=" + ID;
	document.getElementById('NewsletterMail').submit();
	//location = "NewsletterExtended_attachment_del.aspx?ID=" + ID + "&NewsletterID=<%=NewsletterID%>" 
}

function DisableTextMailArea(objChkBox) {
	
	if(document.getElementById('NewsletterMail').NewsletterSpecTextMail.checked == false) {
		alert('<%=Translate.JsTranslate("Ved deaktivering af tekstudgaven vil tekstmodtagere få en mail baseret på htmludgaven")%>');
		document.getElementById("NewsletterTextMailBody").disabled = true;
	} else {
		document.getElementById("NewsletterTextMailBody").disabled = false;
	}
}

function IsCategorySelected() {
	var boxes = document.getElementsByName('NewsletterMailCategory');
	var blnIsChecked
	blnIsChecked = false
	if(boxes == null){
		//alert('<%=Translate.JsTranslate("Opret en kategori")%>');
			blnIsChecked = false
			
	}
	else 
	{
		for (i = 0; i < boxes.length; i++){
			if (boxes[i].checked == true){
				blnIsChecked = true
			}
		}
	}
	return blnIsChecked;
}
//-->
</SCRIPT>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & strSendText, Translate.Translate("Nyhedsbrev") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Vedhæft filer"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16" onLoad="loadMail();">
<form name="NewsletterMail" id="NewsletterMail" method="post" action="NewsletterExtended_letter_save.aspx?Type=Body">
<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & "&nbsp;" & strSendText, Translate.Translate("Nyhedsbrev") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Vedhæft filer"), "html")%>
	<TABLE border="0" cellpadding="0" width="598" cellspacing="0" class="tabTable">
 		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Afsender"))%>
								<TABLE cellpadding=0 cellspacing=0>
									<tr>
										<td width="170px"><%=Translate.Translate("Afsender navn")%></td>
										<td><input type="Text" class="std" value="<%=Base.ChkValues(NewsletterMailSenderName)%>" name="NewsletterMailSenderName" style="std"></td> 
									</tr>
									<tr>
										<td width="170px"><%=Translate.Translate("Afsender e-mail")%></td>
										<td ><input type="Text" class="std" value="<%=NewsletterMailSenderEmail%>" name="NewsletterMailSenderEmail" style="std;"></td> 
									</tr>
									<tr>
										<td width='170px'><%=Translate.Translate("Emne")%></td>
										<td><input type="Text" class="std" value="<%=Base.ChkValues(NewsletterMailSubject)%>" name="NewsletterMailSubject" style="std">
											<input type="hidden" name="NewsletterID" value="<%=NewsletterID%>">
											<input type="hidden" name="Counter" value="<%=StaticCounter%>">
											<input type="hidden" name="NewsletterLevel" value="<%=NewsletterLevel%>">
											<input type="hidden" name="NewsletterLetterType" value="<%=NewsletterLetterType%>">
										</td> 
									</tr>
								</TABLE>
								<%=Gui.GroupBoxEnd()%>
				
								<div id="pagebasedmail" style="display:<%=Base.IIf(blnPagebased, "", "none")%>">
									<%=Gui.GroupBoxStart(Translate.Translate("Sidebaseret nyhedsbrev"))%>
									<TABLE cellpadding=0 cellspacing=0>
										<tr>
											<td width='170px'><%=Translate.Translate("Link til kildeside")%></td>
											<td><%=Gui.LinkManager(NewsletterPageBasedLink, "NewsletterPageBasedLink", "")%></td>
										</tr>
									</TABLE>
									<%=Gui.GroupBoxEnd()%>
								</div>
				
								<div id="htmlmail" style="display:<%=Base.IIf(blnPagebased, "none", "")%>">
									<%=Gui.GroupBoxStart(Translate.Translate("Html"))%>
										<TABLE cellpadding=0 cellspacing=0  width="100%">				
											<tr>
												<td colspan="2"><%= Gui.Editor("NewsletterMailBody", 560, 250, NewsletterContent)%></td>
											</tr>
											<tr>
												<td align=right colspan="2"></td>
											</tr>
										</TABLE>
									<%=Gui.GroupBoxEnd()%>
								</div>
								<%=Gui.GroupBoxStart(Translate.Translate("Tekstudgave"))%>
									<TABLE cellpadding=0 cellspacing=0>
										<tr>
											<td><input type="checkbox" onclick="DisableTextMailArea(this);" name="NewsletterSpecTextMail" name="NewsletterSpecTextMail" <%
											If NewsletterSpecTextMail = true then 
												response.Write("CHECKED") 
											End If %>>
											<%=Translate.Translate("Angiv tekstudgave")%></td>
																	
										</tr>
										<tr Name="tr_NewsletterTextMailBody" ID="tr_NewsletterTextMailBody">
											<td colspan="2">
												&nbsp;<textarea style="BACKGROUND-COLOR: #F4F4F4; BORDER-BOTTOM: #666666 solid 1px; BORDER-LEFT: #666666 solid 1px; BORDER-RIGHT: #666666 solid 1px; BORDER-TOP: #666666 solid 1px; COLOR: #333333; FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; FONT-SIZE: 11px;	z-index:10;" rows="10" cols="89" name="NewsletterTextMailBody" id="NewsletterTextMailBody"  <%
											If Not NewsletterSpecTextMail = true then 
												response.Write("disabled") 
											End If %>><%=NewsletterTextMailBody%></textarea>
											</td>
										</tr>
									</TABLE>
								<%=Gui.GroupBoxEnd()%>
			
								<div id="abonnement" style="display:<%=Base.IIf(blnPagebased, "none", "")%>">
									<%=Gui.GroupBoxStart(Translate.Translate("Abonnement"))%>
										<TABLE cellpadding=0 cellspacing=0>
											<tr>
												<td width="170px"><%=Translate.Translate("Tekst på Afmeldingslink")%></td>
												<td ><input type="Text" class="std" value="<%=NewsletterCancelLinkText%>" name="NewsletterCancelLinkText" style="std;"></td> 
											</tr>
											<tr>
												<td><%=Translate.Translate("Link til Afmelding")%></td>
												<td><%=Gui.LinkManager(NewsletterCancelLink, "NewsletterCancelLink", "")%></td>
											</tr>
											<tr>
												<td width="170px"><%=Translate.Translate("Tekst på Abonnementslink")%></td>
												<td ><input type="Text" class="std" value="<%=NewsletterSubscriptionLinkText%>" name="NewsletterSubscriptionLinkText" style="std;"></td> 
											</tr>
											<tr>
												<td><%=Translate.Translate("Link til Abonnementsside")%></td>
												<td><%=Gui.LinkManager(NewsletterSubscriptionLink, "NewsletterSubscriptionLink", "")%></td>
											</tr>
										</TABLE>
									<%=Gui.GroupBoxEnd()%>
								</div>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "location='NewsletterExtended_Letter_Edit.aspx?ID=" & NewsletterID & "'", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "html();SavePreviewMail();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Gem"), "html();SaveMail(NewsletterMail.htmltab);", 0)%></td>
										<td width="5"></td>
										<td align="right"><%'=Gui.Button(Translate.Translate("Gå Til Send"), "html();SaveSendMail();", 0)%></td>
										<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.body",,5)%>
										<td width="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>



				<!-- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 --- TAB2 ---  -->

				<div ID="Tab2" STYLE="display:none;">
					<TABLE border="0" cellpadding="0" width="100%" cellspacing="0">
						<tr>
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Lister"))%>
									<TABLE cellpadding=0 cellspacing=0>
									<%
									
				'sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected " & " FROM NewsletterExtendedCategory"
				' 'sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT COUNT(NewsLetterCategoryRecipientID) FROM NewsletterExtendedCategoryRecipient WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID) AS NumberOfLines FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"
									    sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT Count(NewsletterExtendedRecipient.NewsletterRecipientID) as Antal FROM (NewsletterExtendedRecipient INNER JOIN NewsletterExtendedCategoryRecipient ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientRecipientID) LEFT JOIN NewsletterExtendedEmailCheck ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedEmailCheck.NewsletterEmailCheckRecipientID WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID =NewsletterExtendedCategory.NewsletterCategoryID AND (NewsletterRecipientConfirmed <> 0 OR NewsletterRecipientConfirmed IS NULL)) AS NumberOfLines FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"


				cmdNewsletterExtended.CommandText = sql
				dr = cmdNewsletterExtended.ExecuteReader() 
				'					throw new exception(sql)
				blnCategoryChecked = 0
				Dim blnDrHasRows As Boolean = False
				Do While dr.Read()
					If Not blnDrHasRows Then blnDrHasRows = True
					response.Write("<tr>")
					response.Write("<td><input name=""NewsletterMailCategory"" ")
					response.Write(dr("Selected").ToString)
					response.Write("type=""CheckBox"" class=""clean"" value=""" & dr("NewsletterCategoryID").ToString & """></td>")
					If dr("Selected").ToString = " checked " Then
						blnCategoryChecked = 1
					End If
					response.Write("<td width='270px'>&nbsp;" & dr("NewsletterCategoryName").ToString & "</td>")
					response.Write("<td width='170px'>" & dr("NumberOfLines").ToString & " " & Translate.Translate("Tilmeldte") & "</td>")
					response.Write("</tr>")
				Loop 

				If Not blnDrHasRows Then
					response.Write("<tr>")
					response.Write("<td colspan=""2"">" & Translate.Translate("Der er ikke oprettet nyhedsbrevslister!") & "</td>")
					response.Write("</tr>")
				End If
				%>
										<tr>
											<td colspan="2"><INPUT TYPE="HIDDEN" ID="blnCategoryChecked" NAME="blnCategoryChecked" VALUE="<%=blnCategoryChecked%>"><br></td>
										</tr>
									</TABLE>
								<%=Gui.GroupBoxEnd%>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "location='NewsletterExtended_Letter_Edit.aspx?ID=" & NewsletterID & "'", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "html();SavePreviewMail();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Gem"), "html();SaveMail(NewsletterMail.htmltab);", 0)%></td>
										<td width="5"></td>
										<td align="right"><%'=Gui.Button(Translate.Translate("Gå Til Send"), "html();SaveSendMail();", 0)%></td>
										<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.body.list",,5)%>
										<td width="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>

				<!-- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 --- TAB3 ---  -->

				<div ID="Tab3" STYLE="display:none;">
					<TABLE border="0" cellpadding="0" width="100%" cellspacing="0">
						<tr>
							<td>
								<%=Gui.GroupBoxStart(Translate.Translate("Vedhæft fil"))%>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width='170px'><%=Translate.Translate("Vælg fil")%></td>
							
							<td nowrap><%=Gui.FileManager(NewsletterMailAttach, Dynamicweb.Content.Management.Installation.FilesFolderName, "NewsletterMailAttach")%></td>	
											<td width='20px'></td>
											<td align="Right">
												<table border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td>
															<%=Gui.Button(Translate.Translate("Vedhæft"), "html();SaveAttachment();", 0)%>
														</td>
														<td width="32px">
														</td>
													</tr>
												</table>
											</td>	
										</tr>
									</table>
								<%=Gui.GroupBoxEnd%>
									
								<%=Gui.GroupBoxStart(Translate.Translate("Vedhæftede filer"))%>
										<%=varAttachmentList%>
								<%=Gui.GroupBoxEnd%>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom"><br />
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "location='NewsletterExtended_Letter_Edit.aspx?ID=" & NewsletterID & "'", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "html();SavePreviewMail();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%'=Gui.Button(Translate.Translate("Gå Til Send"), "html();SaveSendMail();", 0)%></td>
										<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.body.attachments",,5)%>
										<td width="5"></td>
									</tr>
									<tr>
										<td colspan="4" height="5"></td>
									</tr>			
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</FORM>
<%
cmdNewsletterExtended.Dispose()
cmdDynamic.Dispose()
cnDynamic.Dispose()		
cnNewsletterExtended.Dispose()
%>
<textarea style="display:none;" ID="divNewsletterContent"><%=NewsletterContent%></textarea>
<SCRIPT LANGUAGE="JavaScript">
<!--
<% 
If varTab <> "" Then
	response.write("MTabClick(document.getElementById('" & varTab & "'));")
End If 
%>
parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');

//-->
</SCRIPT>
</body>
</html>


<%
Translate.GetEditOnlineScript()
     
%>
