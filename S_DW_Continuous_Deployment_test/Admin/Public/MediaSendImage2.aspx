<%@ Page CodeBehind="MediaSendImage.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.DWMediaSendImage" %>
<%@ Import namespace="jmail" %>
<%'UPGRADE_NOTE: All function, subroutine and variable declarations were moved into a script tag global. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1007.htm%>
<script language="VB" runat="Server">
Dim DWsmtpserver As Object
Dim Redirect As String
Dim SenderSubject As String
Dim ValidateEmail() As Boolean
Dim SenderName As String
Dim FileName As String
Dim FilePath As Object
Dim getStrHref() As String
Dim FileNameArray() As String
Dim Recipient As String
Dim Sender As String
Dim SenderMessage As String
Dim i As Integer
Dim RecipientName As String
Dim Fso As Scripting.FileSystemObject
'UPGRADE_ISSUE: DWMediaSendImage_asp_vbscript.jmail.Message object was not upgraded. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup2068"'
Dim jmail As jmail.Message


</script>
<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file 'Common.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="Common.asp" -->

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			04-02-2003
'	Last modfied:		04-02-2003
'
'	Purpose: Create image on the fly for download
'
'	Revision history:
'		1.0 - 04-02-2003 - Nicolai Pedersen
'		First version.
'**************************************************************************************************
FileName = Request.QueryString.Item("FileName")
Recipient = Request.QueryString.Item("Recipient")
RecipientName = Request.QueryString.Item("RecipientName")
Sender = Request.QueryString.Item("Sender")
SenderName = Request.QueryString.Item("SenderName")
SenderMessage = Request.QueryString.Item("SenderMessage")
SenderSubject = Request.QueryString.Item("SenderSubject")
Redirect = Request.QueryString.Item("Redirect")

FileName = "imm011.jpg, imm024.jpg"
Recipient = "np@dynamicsystems.dk"
RecipientName = "Nicolai Pedersen"
Sender = "download@dynamicsystems.dk"
SenderName = "Dynamic Systems BilledDB"
SenderMessage = "Her er din fil..."
SenderSubject = "Fil fra www.dynamicsystems.dk"
Redirect = ""

If FileName <> "" Then
	FileNameArray = Split(FileName, ", ")
End If

Fso = New Scripting.FileSystemObject
If IsArray(FileNameArray) Then
	jmail = New jmail.Message
	jmail.silent = True
	'JMail.SimpleLayout = true
	jmail.ISOEncodeHeaders = False
	jmail.AddHeader("Originating-IP", Request.ServerVariables.Item("REMOTE_ADDR"))
	jmail.Priority = 3
	
	jmail.From = Sender
	jmail.FromName = SenderName
	jmail.Subject = SenderSubject
	jmail.Body = SenderMessage
	'JMail.HTMLBody = "<html><body><b>" & SenderMessage & "</b></body></html>"'
	
	If ValidateEmail(Recipient) Then
		jmail.AddRecipient(Recipient, RecipientName)
		If IsArray(FileNameArray) Then
			For i = 0 To UBound(FileNameArray)
				FilePath = Server.MapPath("Files/" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "/MediaDB/Originals/" & FileNameArray(i))
				If InStr(FilePath, "Files") < 1 Then
					Response.Write("Access denied")
					Response.End()
				End If
				If Fso.FileExists(FilePath) Then
					jmail.AddAttachment(FilePath)
				End If
			Next 
		End If
		jmail.Send(DWsmtpserver)
	Else
		Response.Write("Not a valid recipient...")
	End If
	
	'Response.write JMail.Text
	
	'UPGRADE_NOTE: Object jmail may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	jmail = Nothing
Else
	Response.Write("File not found...")
End If
'UPGRADE_NOTE: Object Fso may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
Fso = Nothing

If Redirect <> "" Then
	Response.Redirect(getStrHref(Redirect))
End If
%>
Filen er sendt....
