<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="NewsletterExtended_Letter_Body_Preview.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Body_Preview" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim NewsletterContentEnd As String
Dim NewsletterLevel As String
Dim NewsletterStylesheetID As String
Dim NewsletterDescription As String
Dim NewsletterCancelLink  As String
Dim NewsletterName As String
Dim NewsletterEncodingID As String
Dim NewsletterContentHead As String
Dim sql As String
Dim NewsletterTextMailBody As String
Dim NewsletterSaved As String
Dim NewsletterSubscriptionLink As String
Dim strSendText As String
Dim NewsletterContent As String
Dim varAttachmentList As String
Dim NewsletterMailSenderEmail As String
Dim NewsletterCancelLinkText As String
Dim StaticCounter As Byte
Dim NewsletterSubscriptionLinkText As String
Dim NewsletterSpecTextMail As Boolean
Dim NewsletterEndcodingID As String
Dim NewsletterID As String
Dim NewsletterMailSenderName As String
Dim NewsletterTemplateID As String
Dim NewsletterMailSubject As String

Dim ParagraphTemplateID As String

Dim varTab As String
Dim Counter As Integer

Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim drNewsletter			As IDataReader	 
Dim drAttachment			As IDataReader

response.Expires = -100

varTab = Request.QueryString.Item("Tab")
NewsletterID = Base.ChkNumber(Request.Item("ID"))

sql = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
cmdNewsletterExtended.CommandText = sql
drNewsletter = cmdNewsletterExtended.ExecuteReader() 

If drNewsletter.Read() Then
	'NewsletterID = drNewsletter("NewsletterID").ToString
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
	ParagraphTemplateID = drNewsletter("NewsletterTemplateID").ToString
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

If Trim(NewsletterTextMailBody) = "" Then
	NewsletterTextMailBody = Base.StripHTML(NewsletterContent)
End If

drNewsletter.Dispose()

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedAttachment WHERE NewsletterletterID = " & NewsletterID
drAttachment = cmdNewsletterExtended.ExecuteReader()

varAttachmentList = "<table width='570px'><tr>" & "<td align='left'><strong>" & Translate.Translate("Fil") & "</strong></td>" & "<td align='right'><strong>" & Translate.Translate("Størrelse") & "</strong></td></tr>"
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
		varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Icons/Attachment.gif"" align=""absMiddle"" border=""0"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td align='right'>" & Math.Round((fi.Length / 1024), 2) &  " Kb </td>" 
		varAttachmentList = varAttachmentList & "<tr width='100%' ><span width='100%' id=""bodyheight""><td  width='100%' bgColor=""#c4c4c4"" colSpan=""3"">"
		varAttachmentList = varAttachmentList & "</td></span></tr>"
	Catch e As Exception
		varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
		varAttachmentList = varAttachmentList & "<img src=""/Admin/images/Icons/Attachment.gif"" align=""absMiddle"" border=""0"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td valign='middle'></td>" 
		varAttachmentList = varAttachmentList & "<tr><span width='100%' id=""bodyheight""><td  width='100%' bgColor=""#c4c4c4"" colSpan=""3"">"
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

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JavaScript">
<!--

function GoToBody() {
	document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_body.aspx?ID=<%=NewsletterID%>&Tab=Tab1";
	document.getElementById('NewsletterMail').submit();
}

function GoToSend() {
	document.getElementById('NewsletterMail').action= "NewsletterExtended_letter_body_Send.aspx?ID=<%=NewsletterID%>&Tab=Tab1";
	document.getElementById('NewsletterMail').submit();
}

function SendTestMail()
{
	if(<%=Cint(NewsletterLevel)%> < 2)
		{
		alert('<%=Translate.JsTranslate("%% skal gemmes før den funktion kan udføres!", "%%", "Nyhedsbrevet")%>');
		return false;
		}

	if(document.getElementById('NewsletterMail').TestEmailAddress.value != "" && validateEmail(document.getElementById('NewsletterMail').TestEmailAddress.value))
		{
		document.getElementById('NewsletterMail').action= 'NewsletterExtended_send_test.aspx?NewsletterID=<%=NewsletterID%>';
		document.getElementById('NewsletterMail').submit();
		}
	else
		alert('<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))%>');
	
}

function validateEmail(strEmail)
{
	 var re = new RegExp(/^[\w-\.]{1,}\@([\w-]{1,}\.){1,}[\w]{2,4}$/);
	 var s = re.test(strEmail);
	 return(s);
}

function OpenTextFile()
{
if(<%=CInt(NewsletterLevel)%> < 2)
	{
	alert("<%=Translate.JsTranslate("%% skal gemmes før den funktion kan udføres!", "%%", "Nyhedsbrevet")%>");
	return false;
	}

	document.getElementById('NewsletterMail').action= "NewsletterExtended_preview_file.aspx?NewsletterID=<%=NewsletterID%>";
	document.getElementById('NewsletterMail').submit();
}

function OpenMail() {
	if(<%=CInt(NewsletterLevel)%> < 2) {
		alert("<%=Translate.JsTranslate("%% skal gemmes før den funktion kan udføres!", "%%", "Nyhedsbrevet")%>");
		return false;
	}
	document.getElementById('NewsletterMail').action= "NewsletterExtended_preview_eml.aspx?NewsletterID=<%=NewsletterID%>";
	document.getElementById('NewsletterMail').submit();
}

function PreviewInBrowser() {
	if(<%=CInt(NewsletterLevel)%> < 2) {
		alert("<%=Translate.JsTranslate("%% skal gemmes før den funktion kan udføres!", "%%", "Nyhedsbrevet")%>");
		return false;
	}
	window.open("NewsletterExtended_preview.aspx?NewsletterID=<%=NewsletterID%>", "Preview", "resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=800,height=600,top=10,left=10");
}

function PreviewCall() {
	if(document.getElementById('NewsletterMail').PreviewType[0].checked) {
		PreviewInBrowser();
	}else if(document.getElementById('NewsletterMail').PreviewType[1].checked){
		OpenTextFile();
	}else{
		OpenMail();
	}
}

function show(i) {
	if (document.getElementById(i).style.display=='none') {
		document.getElementById(i).style.display='';
	}else{
		document.getElementById(i).style.display='none';
	}
}

function SendBasic() {
	if (document.Newsletter_letter.NewsletterName.length < 1)	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		return false;
	} else if (document.Newsletter_letter.NewsletterName.length > 255) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Navn")%>");
		return false;
	} else if (document.Newsletter_letter.NewsletterDescription.length > 2000) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","2000")%><%=Translate.JSTranslate("Beskrivelse")%>");
		return false;
	}<%If NewsletterLevel > 1 Then%>
	else if (document.Newsletter_letter.ParagraphTemplateID != <%=NewsletterTemplateID%>)
		{
		if(confirm('<%=Translate.JsTranslate("Der er valgt en ny Template.") & "\n" & Translate.JsTranslate("Indholdet af nyhedsbrevet vil blive overskrevet.") & "\n" & Translate.JsTranslate("Fortsæt?")%>'))
			{
			document.Newsletter_letter.submit();
			}
		}<%End If%>
	else {
		document.Newsletter_letter.submit();
	}
}

function SendLetter() {
	if(confirm("<%=Translate.JsTranslate("Skal nyhedsbrevet sendes?")%>")) {		
		document.NewsletterSendForm.Accept.value = 'Yes';
		document.NewsletterSendForm.submit();		
	}
}

function IsCategorySelected() {
	var boxes = document.getElementById('NewsletterMailCategory');
	var blnIsChecked
	blnIsChecked = false
	if(!boxes.length){
		if(boxes.checked == true){
			blnIsChecked = true
		}
	}
	for (i = 0; i < boxes.length; i++){
		if (boxes[i].checked == true){
			blnIsChecked = true
		}
	}
	return(blnIsChecked);
}
//-->
</SCRIPT>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<%
If NewsletterLevel >= 3 Then
	strSendText = Translate.Translate("(Sendt)")
End If
%>
<%Response.Write(Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & strSendText & "<br>", Translate.Translate("Preview") & ", " & Translate.Translate("Test"), "javascript"))%>
<body LEFTMARGIN="20" TOPMARGIN="16">


<%Response.Write(Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & strSendText & "<br>", Translate.Translate("Preview") & ", " & Translate.Translate("Test"), "html"))%>

<div ID="Tab1" STYLE="display:;">
	<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
		<tr>
			<td><br><br>
				<%=Gui.GroupBoxStart(Translate.Translate("Afsender"))%>
				<TABLE cellpadding=2 cellspacing=0>
					<tr>
						<td width="170px"><%=Translate.Translate("Afsender navn")%></td>
						<td><%=NewsletterMailSenderName%></td> 
					</tr>
					<tr>
						<td width="170px"><%=Translate.Translate("Afsender e-mail")%></td>
						<td><%=NewsletterMailSenderEmail%></td> 
					</tr>
					
					<tr>
						<td width='170px'><%=Translate.Translate("Emne")%></td>
						<td><%=NewsletterMailSubject%>
							<input type="hidden" name="NewsletterID" value="<%=NewsletterID%>">
							<input type="hidden" name="Counter" value="<%=StaticCounter%>">
							<input type="hidden" name="NewsletterLevel" value="<%=NewsletterLevel%>">
						</td> 
					</tr>
					
					<tr>
						<td width="170px"></td>
						<td></td>
					</tr>
				</TABLE>
				<%=Gui.GroupBoxEnd()%>
			
				<%=Gui.GroupBoxStart(Translate.Translate("Vedhæftede filer"))%>
					<%=varAttachmentList%>
				<%=Gui.GroupBoxEnd%>
			
			
				<%=Gui.GroupBoxStart(Translate.Translate("Html"))%>
				<TABLE cellpadding="0" cellspacing="0" class="InfoBox" ID="Table3">
					<tr>
						<td><br>&nbsp;&nbsp;
							<iframe src="<%="NewsletterExtended_Preview.aspx?NewsletterID=" & NewsletterID%>" frameborder="1" width="555" height="300" scrolling=yes ></iframe>
						</td>
						<tr><td><br></td></tr>
					</tr>
				</TABLE>	
				<%=Gui.GroupBoxEnd%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Tekstudgave"))%>
				<TABLE cellpadding=2 cellspacing=0>
					<tr Name="tr_NewsletterTextMailBody" ID="tr_NewsletterTextMailBody" style="display:"">
						<td colspan="2"><br>&nbsp;
							&nbsp;<textarea readonly style="BACKGROUND-COLOR: #F4F4F4; BORDER-BOTTOM: #666666 solid 1px; BORDER-LEFT: #666666 solid 1px; BORDER-RIGHT: #666666 solid 1px; BORDER-TOP: #666666 solid 1px; COLOR: #333333; FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; FONT-SIZE: 11px;	z-index:10;" rows="10" cols="89" name="NewsletterTextMailBody" id="NewsletterTextMailBody"><%=Dynamicweb.Admin.NewsletterExtended.GetTextMailPreview(NewsletterID)%></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2"><br></td>
					</tr>
				</TABLE>
				<%=Gui.GroupBoxEnd()%>
			</td>
		</tr>	
		
		<tr>
			<td align="right" valign="bottom">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<%'If Not NewsletterLevel >= 3 Then%>
						<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "GoToBody();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "GoToSend();", 0)%></td>
						<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.preview",,5)%>
						<%'End If%>
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
<%' If NewsletterLevel < 3 Then%>
<div ID="Tab2" STYLE="display:none;">
<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
	<form name="NewsletterMail" id="NewsletterMail" method="post" action="NewsletterExtended_letter_save.aspx?Type=Body">
		<tr>
			<td valign="top"><br><br>
		
				<%=Gui.GroupBoxStart(Translate.Translate("Test mail"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width='170px'><%=Translate.Translate("Email adresse")%></td>
							<td><input type="Text" class="std" name="TestEmailAddress" value="" style="std"></td> 
						</tr>
						<tr>
							<td width='170px'><%=Translate.Translate("E-mailformat")%></td>
							<td><%=Gui.RadioButton(2, "TestMailType", "1")%>&nbsp;<%=Translate.Translate("Text")%></td>
						</tr>
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(2, "TestMailType", "2")%>&nbsp;<%=Translate.Translate("Html")%></td>
						</tr>
						<tr><td></td><td><br/><%=Gui.Button(Translate.Translate("Send",1), "SendTestMail();", 0)%></td></tr>					
					</table>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<tr>
			<td>
				<%=Gui.GroupBoxStart(Translate.Translate("Preview"))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr valign="top">
							<td width="170"><%=Translate.Translate("Preview type")%></td>
							<td>
								<%=Gui.RadioButton(1, "PreviewType", "1")%><%=Translate.Translate("Preview i Browser")%><br />
								<%=Gui.RadioButton(1, "PreviewType", "2")%><%=Translate.Translate("Åben som tekstfil")%><br />
								<%=Gui.RadioButton(1, "PreviewType", "3")%><%=Translate.Translate("Åben som Email")%>
							</td>
						</tr>
						<tr><td></td><td><br/><%=Gui.Button(Translate.Translate("Preview"), "PreviewCall();", 0)%></td></tr>	
					</table>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<%'If Not NewsletterLevel >= 3 Then%>
						<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "GoToBody();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "GoToSend();", 0)%></td>
						<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.preview.test",,5)%>
						<%'End If%>
						<td width="5"></td>
					</tr>
					<tr>
						<td colspan="4" height="5"></td>
					</tr>			
				</table>
			</td>
		</tr>
	</FORM>
	</table>
</div>
<%'End If%>
<%
cmdNewsletterExtended.Dispose()
cnNewsletterExtended.Dispose()
%>
<SCRIPT LANGUAGE="JavaScript">
<!--

parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');

//-->
</SCRIPT>

</body>
</html>


<%
Translate.GetEditOnlineScript()

%>
