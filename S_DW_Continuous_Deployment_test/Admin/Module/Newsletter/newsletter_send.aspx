<%@ Page CodeBehind="newsletter_send.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_send" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%

	Dim y As Integer
	Dim x As Integer
	Dim r As Integer
	Dim m As Integer
	Dim i As Integer

	Dim stylesheet As String
	Dim arrNewsletterRecipientCategoryID() As String
	Dim arrNewsletterMailCategory() As String

	Dim Errcount As Byte
	Dim ExitNext As Boolean
	Dim mailfailcount As Byte
	Dim mailfailmails As String
    Dim ScriptStart As Double = DateAndTime.Timer

	Dim NewsletterMailSenderEmail As String
	Dim NewsletterMailBody As String
	Dim NewsletterMailFormat As String
	Dim NewsletterMailCategory As String
	Dim NewsletterMailSubject As String
	Dim NewsletterNewsCategory As String
	Dim NewsletterMailSenderName As String
	Dim NewsletterMailAttach As String

	Dim Root As String = "/"

	Dim dato As New Dates

	Dim arrRecipientNames As New ArrayList '() As String
	Dim arrRecipientEmails As New ArrayList '() As String

	'tmpNewsletterMailCategory = replace(NewsletterMailCategory, ", ", " OR NewsletterRecipientCategoryID = ")

	Response.Expires = -100
	Session.Timeout = 240
	Server.ScriptTimeout = 300000

	If File.Exists(Server.MapPath(Root & "Files/stylesheet" & Request.Form.Item("NewsletterStylesheet") & ".css")) Then
		stylesheet = Base.ReadTextFile(Server.MapPath(Root & "Files/stylesheet" & Request.Form.Item("NewsletterStylesheet") & ".css"))
	End If

	NewsletterMailSubject = Request.Form.Item("NewsletterMailSubject")
	NewsletterMailSenderName = Request.Form.Item("NewsletterMailSenderName")
	NewsletterMailSenderEmail = Request.Form.Item("NewsletterMailSenderEmail")
	NewsletterMailCategory = Request.Form.Item("NewsletterMailCategory")
	NewsletterMailAttach = Request.Form.Item("NewsletterMailAttach")
	NewsletterMailFormat = Request.Form.Item("NewsletterMailFormat")
	If Not IsNothing(Request.Form.GetValues("NewsletterMailBody")) Then
		NewsletterMailBody = Replace(Request.Form.Item("NewsletterMailBody"), "href=""Default.aspx?ID=", "href=""http://" & Request.ServerVariables.Item("SERVER_NAME") & "/Default.aspx?ID=")
		NewsletterMailBody = Replace(NewsletterMailBody, "href=""Files/", "href=""http://" & Request.ServerVariables.Item("SERVER_NAME") & "/Files/", 1, -1, CompareMethod.Text)
		NewsletterMailBody = Replace(NewsletterMailBody, "href=""/Files/", "href=""http://" & Request.ServerVariables.Item("SERVER_NAME") & "/Files/", 1, -1, CompareMethod.Text)
		NewsletterMailBody = Replace(NewsletterMailBody, "src=""Files/", "src=""http://" & Request.ServerVariables.Item("SERVER_NAME") & "/Files/", 1, -1, CompareMethod.Text)
		NewsletterMailBody = Replace(NewsletterMailBody, "src=""/Files/", "src=""http://" & Request.ServerVariables.Item("SERVER_NAME") & "/Files/", 1, -1, CompareMethod.Text)
	Else
		NewsletterMailBody = ""
	End If
	NewsletterMailAttach = Request.Form.Item("NewsletterMailAttach")
	NewsletterNewsCategory = Request.Form.Item("NewsletterNewsCategory")
	If NewsletterMailAttach <> "" Then
        NewsletterMailAttach = Server.MapPath(Root & "Files/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/" & NewsletterMailAttach)
	End If

    Dim mail As New System.Net.Mail.MailMessage
	If Request.Form("NewsletterEncodingUsed") <> "" Then
        mail.SubjectEncoding = EmailHandler.GetEncodingByName(Request.Form("NewsletterEncodingUsed"))
	Else
        mail.SubjectEncoding = Text.Encoding.UTF8
    End If
    mail.BodyEncoding = mail.SubjectEncoding
	''mail.CharSet = "utf-8"
    'mail.LogPath = Server.MapPath("/Files/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/NewsletterEmailLog.txt")
    mail.From = New System.Net.Mail.MailAddress(NewsletterMailSenderEmail, NewsletterMailSenderName)
    mail.Subject = NewsletterMailSubject

	If LCase(NewsletterMailFormat) = "html" Then
		Dim strTempMail As String = "<html><head><style>" & stylesheet & "</style></head><body>"
		strTempMail += NewsletterMailBody
		strTempMail += "</body></html>"
        mail.Body = strTempMail
        mail.IsBodyHtml = True
	Else
        mail.Body = Base.StripHTML(NewsletterMailBody)
        mail.IsBodyHtml = False
	End If



    If NewsletterMailAttach <> "" Then
        Dim mailattachment As New System.Net.Mail.Attachment(NewsletterMailAttach)
        mail.Attachments.Add(mailattachment)
    End If

	Dim cnNewsletter As IDbConnection = Database.CreateConnection("Newsletter.mdb")
	Dim cmdNewsletter As IDbCommand = cnNewsletter.CreateCommand
	cmdNewsletter.CommandText = "SELECT * FROM NewsletterRecipient"
	Dim drNewsletter As IDataReader = cmdNewsletter.ExecuteReader()

	Dim dsNewsletter As DataSet = New DataSet
	Dim daNewsletter As IDbDataAdapter = Database.CreateAdapter()
	daNewsletter.SelectCommand = cmdNewsletter
	Dim dtNewsletter As DataTable
	Dim row As DataRow

	mailfailcount = 0
	'h = 0
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>
		<%=Translate.JsTranslate("Sender mails")%></title>
	<link rel="stylesheet" type="text/css" href="../../Stylesheet.css">

	<script type="text/javascript">
		var ref = top.opener.location;
		var RecordCount;
		var MaxWidth = 200;
		function AppendText(html) {
			document.all.TaskText.innerHTML = html;
		}
		function AppendText2(CurrentNumber) {
			document.all.curnum.innerHTML = CurrentNumber
			document.all.progress.style.pixelWidth = 200 / RecordCount * (CurrentNumber - 1);
		}
	</script>

</head>
<body>
	<table border="0" width="202" height="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" valign="middle">
				<%=Translate.Translate("Sender %c% af %t% mails...", "%c%", "&nbsp;<span id='curnum'></span>&nbsp;", "%t%", "&nbsp;<span id='recordcount'></span>&nbsp;")%><br>
				&nbsp;
				<table border="0" cellpadding="1" cellspacing="0">
					<tr>
						<td width="200" bgcolor="#003366"><span id="progress" style="height: 15px; background-color: #dcdcdc;"></span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<%

		arrNewsletterMailCategory = Split(NewsletterMailCategory, ",")
		Do While drNewsletter.Read()
			If drNewsletter("NewsletterRecipientCategoryID").ToString <> "" Then
				arrNewsletterRecipientCategoryID = Split(drNewsletter("NewsletterRecipientCategoryID").ToString, ",")
			Else
				ReDim arrNewsletterRecipientCategoryID(1)
				arrNewsletterRecipientCategoryID(0) = "0"
			End If
	
			For y = 0 To UBound(arrNewsletterMailCategory)
				For x = 0 To UBound(arrNewsletterRecipientCategoryID)
			
					If Trim(arrNewsletterMailCategory(y)) = Trim(arrNewsletterRecipientCategoryID(x)) Then
						If Base.ValidateEmail(drNewsletter("NewsletterRecipientEmail").ToString) Then
							If drNewsletter("NewsletterRecipientName").ToString <> "" Then
								arrRecipientNames.Add(Replace(drNewsletter("NewsletterRecipientName").ToString, ",", "")) '(UBound(arrRecipientNames)) = 
							Else
								arrRecipientNames.Add(drNewsletter("NewsletterRecipientName").ToString)
							End If
							arrRecipientEmails.Add(drNewsletter("NewsletterRecipientEmail").ToString) '(UBound(arrRecipientEmails)) = 
							ExitNext = True
						End If
						Exit For
					End If
				Next
				If ExitNext = True Then
					ExitNext = False
					Exit For
				End If
			Next
		Loop
		drNewsletter.Close()
		drNewsletter.Dispose()

		Response.Write("<script>var RecordCount = " & arrRecipientNames.Count & ";document.all[""recordcount""].innerHTML=" & arrRecipientNames.Count & ";</script>")

		For r = 0 To arrRecipientNames.Count - 1
			i = i + 1
			'If h < 1 Then
			'	mellemtid = Timer()
			'End If
			'h = h + 1
	        mail.To.Clear()
			If Base.ValidateEmail(arrRecipientEmails(r)) Then
				If arrRecipientNames(r) <> "" Then
			
	                '' Hvad med name ?
	                mail.To.Add(arrRecipientEmails(r))
	                If Not EmailHandler.Send(mail, True) Then
	                    mailfailcount = mailfailcount + 1
	                End If
	            End If
		
				'Todo Kræver alt for meget at udskrive til skærmen.
				Response.Write("<script>AppendText2(" & i & ");</script>")
				Response.Flush()
				'if i mod 100 = 0 Then
				'	Response.Write("<script>AppendText2(" & i & ");</script>")
				'	Response.Flush()
				'End If
				'End If
			Else
				mailfailcount = mailfailcount + 1
				If Len(mailfailmails) > 0 Then
					mailfailmails = mailfailmails & ", " & CStr(arrRecipientEmails(r))
				Else
					mailfailmails = CStr(arrRecipientEmails(r))
				End If
			End If
		Next
		'Response.Write "<pre>" & msglog & "</pre>"
		cmdNewsletter.CommandText = "SELECT TOP 1 * FROM NewsletterArchive"
		daNewsletter.Fill(dsNewsletter)
		dtNewsletter = dsNewsletter.Tables(0)
		row = dtNewsletter.NewRow()
		dtNewsletter.Rows.Add(row)

		row("NewsletterArchiveHeader") = NewsletterMailSubject
		row("NewsletterArchiveBody") = NewsletterMailBody
		row("NewsletterArchiveSenderName") = NewsletterMailSenderName
		row("NewsletterArchiveSenderEmail") = NewsletterMailSenderEmail
		row("NewsletterArchiveFormat") = NewsletterMailFormat
		row("NewsletterArchiveFile") = NewsletterMailAttach
		row("NewsletterArchiveNewsCategory") = NewsletterNewsCategory
		row("NewsletterArchiveNewsletterCategory") = NewsletterMailCategory
		row("NewsletterArchiveSend") = Dates.DWNow
		row("NewsletterArchiveCount") = arrRecipientNames.Count

		'Updates Database
		Database.CreateCommandBuilder(daNewsletter)
		daNewsletter.Update(dsNewsletter)

		dsNewsletter.Dispose()
		cmdNewsletter.Dispose()

	%>

	<script type="text/javascript">
		function finishscript() {
		    alert('<%=Translate.JSTranslate("Nyhedsbrevet er nu udsendt.")%>\n<%=Translate.JSTranslate("%% sekund(er).","%%", Math.Round(CDbl(DateAndTime.Timer()) - ScriptStart,2))%> - <%=Translate.JSTranslate("%% fejl.","%%", Errcount)%>');
			if (top.opener.location == ref) {
				top.opener.location = "newsletter_front.aspx?tab=3";
			}
			window.close();
		}
		finishscript();
	</script>

</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>