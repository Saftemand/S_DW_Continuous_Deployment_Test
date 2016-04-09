<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="NewsletterExtended_Letter_Body_Send.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Body_Send" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%

Dim NewsletterMailAttach As String
Dim TemplateIcon As String
Dim NewsletterContentEnd As String
Dim IndexEnd As Integer
Dim TemplatePath As String
Dim TemplateOutput As String
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
Dim strSpan As String
Dim myStyle As String
Dim NewsletterSubscriptionLink As String
Dim strSendText As String
Dim NewsletterContent As String
Dim blnCategoryChecked As Integer
Dim strName As String
Dim varAttachmentList As String
Dim tempStr As String
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
Dim FileHome As String = "/Files/"
Dim IndexStart As Double

Dim varTab As String
Dim DWArray(50, 2) As String
Dim Counter As Integer
Dim AutoStart As String

Dim blnPagebased As boolean = false
Dim NewsletterPageBasedLink As String
Dim NewsletterLetterType As String

response.Expires = -100

Dynamicweb.Admin.NewsletterExtended.CheckLiveThreads()

Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim drNewsletter			As IDataReader	 
Dim drSeletedTemplate		As IDataReader
Dim drTemplate				As IDataReader
Dim dr						As IDataReader
Dim drAttachment			As IDataReader
Dim drUserField			As IDataReader

varTab = Request.QueryString.Item("Tab")
NewsletterID = Base.ChkNumber(Request.Item("ID"))

sql = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
cmdNewsletterExtended.CommandText = sql
drNewsletter = cmdNewsletterExtended.ExecuteReader() 

If drNewsletter.Read() Then
	'NewsletterID = drNewsletter("NewsletterID").ToString
	
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
	NewsletterTemplateID			= drNewsletter("NewsletterTemplateID").ToString
	NewsletterEncodingID			= drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel					= drNewsletter("NewsletterLevel").ToString
	NewsletterContent				= drNewsletter("NewsletterContent").ToString
	NewsletterMailSenderName		= drNewsletter("NewsletterMailSenderName").ToString
	NewsletterMailSenderEmail		= drNewsletter("NewsletterMailSenderEmail").ToString
	NewsletterMailSubject			= drNewsletter("NewsletterMailSubject").ToString
	NewsletterCancelLink			= drNewsletter("NewsletterCancelLink").ToString
	NewsletterSubscriptionLink		= drNewsletter("NewsletterSubscriptionLink").ToString
	NewsletterCancelLinkText		= drNewsletter("NewsletterCancelLinkText").ToString
	NewsletterSubscriptionLinkText	= drNewsletter("NewsletterSubscriptionLinkText").ToString
	NewsletterDescription			= drNewsletter("NewsletterDescription").ToString
	'NewsletterStylesheetID = drNewsletter("NewsletterStylesheetID").ToString
	ParagraphTemplateID				= drNewsletter("NewsletterTemplateID").ToString
	NewsletterEncodingID			= drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel					= drNewsletter("NewsletterLevel").ToString
	NewsletterTextMailBody			= drNewsletter("NewsletterTextMailBody").ToString
	
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

%>
		<SCRIPT LANGUAGE="JavaScript">
<!--

// variable ensure the DWEditor does not load the content automatic and therefore won't overwrite the content you load.

function SendLetter() {
	if(confirm("<%=Translate.JsTranslate("Skal nyhedsbrevet sendes?")%>")) {		
		document.getElementById('NewsletterSendForm').Accept.value = 'Yes';		
		document.getElementById('NewsletterSendForm').action = 'NewsletterExtended_Letter_Send.aspx?Ticks=' + (new Date().getTime()); 
		document.getElementById('NewsletterSendForm').submit();		
	}
}

//-->
		</SCRIPT>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
			<%
If NewsletterLevel >= 3 Then
	strSendText = Translate.Translate("(Sendt)")
End If
%>
			<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & strSendText & "<br>", Translate.Translate("Send",1), "javascript")%>
	</HEAD>
	<body LEFTMARGIN="20" TOPMARGIN="16">
		
		<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & strSendText & "<br>", Translate.Translate("Send",1), "html")%>
		<div ID="Tab1" STYLE="DISPLAY:">
			<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
				<form NAME="NewsletterSendForm" id="NewsletterSendForm" METHOD="post" ACTION="NewsletterExtended_Letter_Send.aspx">
					<TBODY>
						<tr>
							<td valign="top"><br>
								<br>
								<%=Gui.GroupBoxStart(Translate.Translate("Info"))%>
								<table cellpadding="2" cellspacing="0">
									<tr>
										<td width="170"><%=Translate.Translate("Navn")%>:</td>
										<td width="170"><%=NewsletterName%></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Beskrivelse")%>:</td>
										<td width="170"><%=NewsletterDescription%></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Emne")%>:</td>
										<td width="170"><%=NewsletterMailSubject%></td>
									</tr>
									<tr>
										<td><br>
										</td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Lister")%>:</td>
										<%  Dim intNumberOfLines As Integer = 0
							Dim myNewsletterExtended As New Dynamicweb.Admin.NewsletterExtended
						'	Base.we(myNewsletterExtended.HasCustomRecipientList(Base.ChkNumber(NewsletterID)))
							If myNewsletterExtended.HasCustomRecipientList(Base.ChkNumber(NewsletterID)) Then
								sql = " SELECT NewsletterExtendedCustomList.* FROM NewsletterExtendedCustomList WHERE NewsletterExtendedCustomListNewsletterID = " & NewsletterID

								''sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT COUNT(NewsLetterCategoryRecipientID) FROM NewsletterExtendedCategoryRecipient WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID) AS NumberOfLines FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"
								cmdNewsletterExtended.CommandText = sql
								dr = cmdNewsletterExtended.ExecuteReader() 

								blnCategoryChecked = 0
								
								If dr.Read() Then
											Response.Write("<td width='170px'><font color=red>" & dr("NewsletterExtendedCustomListName").ToString & "</font></td><td align=left>" &  Translate.Translate("%% modtagere", "%%", dr("NewsletterExtendedCustomListNumberOfLines").ToString) & "</td></tr>")
											intNumberOfLines += Base.ChkNumber(dr("NewsletterExtendedCustomListNumberOfLines").ToString)
								End If
															
								Response.Write("<tr><td width='170px'></td><td width='170px'><br><b>" & Translate.Translate("Total") & "</b></td><td align=left><br><b>" & Translate.Translate("%% modtagere", "%%", intNumberOfLines.ToString) & "</b></td></tr>")
								Response.Write("<tr><td><br></td></tr>")
								Response.Write("<tr><td>" & Translate.Translate("Filstørrelse pr. email") & "</td><td>" & Dynamicweb.Admin.NewsletterExtended_Preview_Eml.GetEMLSize(NewsletterID) & " Kb </td></tr>")
								Response.Write("<tr><td>" & Translate.Translate("Størrelsen på forsendelsen") & "</td><td>" & Math.Round((Dynamicweb.Admin.NewsletterExtended_Preview_Eml.GetEMLSize(NewsletterID) * intNumberOfLines) / 1024,2) & " Mb </td></tr>")
								dr.Dispose
															
							Else
						
								''sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT COUNT(NewsLetterCategoryRecipientID) FROM NewsletterExtendedCategoryRecipient WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID) AS NumberOfLines FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"
										        sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT Count(NewsletterExtendedRecipient.NewsletterRecipientID) as Antal FROM (NewsletterExtendedRecipient INNER JOIN NewsletterExtendedCategoryRecipient ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientRecipientID) LEFT JOIN NewsletterExtendedEmailCheck ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedEmailCheck.NewsletterEmailCheckRecipientID WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID =NewsletterExtendedCategory.NewsletterCategoryID AND (NewsletterRecipientConfirmed <> 0 OR NewsletterRecipientConfirmed IS NULL)) AS NumberOfLines FROM NewsletterExtendedCategory ORDER BY NewsletterCategoryName"
										        'Base.we(sql)
								cmdNewsletterExtended.CommandText = sql
								dr = cmdNewsletterExtended.ExecuteReader() 

								blnCategoryChecked = 0
								Dim blnDrHasRows As Boolean = False
								Do While dr.Read()
									If Not blnDrHasRows Then 
										If dr("Selected").ToString <> "" Then
											blnDrHasRows = True
											Response.Write("<td width='170px'>" & dr("NewsletterCategoryName").ToString & "</td><td align=left>" &  Translate.Translate("%% modtagere", "%%", dr("NumberOfLines").ToString) & "</td></tr>")
											intNumberOfLines += Base.ChkNumber(dr("NumberOfLines").ToString)
										End If
									Else
										If dr("Selected").ToString <> "" Then
											response.Write("<tr><td width='170px'></td><td width='170px'>" & dr("NewsletterCategoryName") & "</td><td align=left>" & Translate.Translate("%% modtagere", "%%", dr("NumberOfLines").ToString) & "</td></tr>")
											intNumberOfLines += Base.ChkNumber(dr("NumberOfLines").ToString)
										End If
									End If
								Loop 
								
								Response.Write("<tr><td width='170px'></td><td width='170px'><br><b>" & Translate.Translate("Total") & "</b></td><td align=left><br><b>" & Translate.Translate("%% modtagere", "%%", intNumberOfLines.ToString) & "</b></td></tr>")
								Response.Write("<tr><td><br></td></tr>")
								Response.Write("<tr><td>" & Translate.Translate("Filstørrelse pr. email") & "</td><td>" & Dynamicweb.Admin.NewsletterExtended_Preview_Eml.GetEMLSize(NewsletterID) & " Kb </td></tr>")
								Response.Write("<tr><td>" & Translate.Translate("Størrelsen på forsendelsen") & "</td><td>" & Math.Round((Dynamicweb.Admin.NewsletterExtended_Preview_Eml.GetEMLSize(NewsletterID) * intNumberOfLines) / 1024,2) & " Mb </td></tr>")
								dr.Dispose
															
								If Not blnDrHasRows Then 
									Response.Redirect("NewsletterExtended_Letter_Body.aspx?ID=" & NewsletterID & "&Tab=Tab1")
								End if	
							End If												
						%>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
							</td>
						</tr>
						<tr>
							<td valign="top"><br>
								<%=Gui.GroupBoxStart(Translate.Translate("Send",1))%>
								<table cellpadding="2" cellspacing="0">
									<tr>
										<td width="170">
											<input type="hidden" value="<%=NewsletterID%>" name="ID"> <input type="hidden" name="Accept" ID="Accept">
										</td>
										<td></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Send via")%></td>
										<td><input type="radio" name="SendType" value="2" checked> &nbsp;<%=Translate.Translate("Dropbox")%>
										</td>
										<td><input type="radio" name="SendType" value="1"> &nbsp;<%=Translate.Translate("SMTP Server")%>
										</td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td align="right"><%=Gui.Button(Translate.Translate("Send"), "javascript:SendLetter();", 0)%></td>
										<td width="5"></td>
										<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='NewsletterExtended_Blank.html'", 0)%></td>
										<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.send",,5)%>
										<td width="5"></td>
									</tr>
									<tr>
										<td colspan="4" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
				</form>
				</TBODY>
			</TABLE>
		</div>
		<%
cmdNewsletterExtended.Dispose()
cnNewsletterExtended.Close()
cnNewsletterExtended.Dispose()
%>
		<SCRIPT LANGUAGE="JavaScript">
<!--

parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');

//-->
		</SCRIPT>
		<%
Translate.GetEditOnlineScript()

%>
	</body>
</HTML>
