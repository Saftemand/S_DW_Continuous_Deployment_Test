<%@ Page CodeBehind="newsletter_archive_view.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_archive_view" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim newslist As String
Dim NewsletterArchiveSenderEmail As String
Dim Sql As String
Dim lists As String
Dim NewsletterArchiveBody As String
Dim NewsletterArchiveSenderName As String
Dim NewsletterArchiveFile As String
Dim NewsletterArchiveNewsCategory As String
Dim NewsletterArchiveHeader As String
Dim NewsletterArchiveNewsletterCategory As String
Dim NewsletterArchiveFormat As String
Dim NewsletterArchiveSend As String
Dim tmpNewsletterArchiveNewsletterCategory As String
Dim i As Integer
Dim NewsletterArchiveCount As String
Dim tmpNewsletterArchiveNewsCategory As String

Response.Expires = -100

Dim cnDynamic		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cnNewsletter	As IDbConnection = Database.CreateConnection("Newsletter.mdb")
Dim cmdNewsletter	As IDbCommand	 = cnNewsletter.CreateCommand
Dim cmdDynamic		As IDbCommand	 = cnDynamic.CreateCommand
Dim drNewsletter	As IDataReader	 
Dim drDynamic		As IDataReader	 

cmdNewsletter.CommandText = "SELECT * FROM NewsletterArchive WHERE NewsletterArchiveID = " & Base.ChkNumber(Request.QueryString.Item("ID"))
drNewsletter = cmdNewsletter.ExecuteReader()

If drNewsletter.Read() Then
	NewsletterArchiveHeader				= Server.HtmlEncode(drNewsletter("NewsletterArchiveHeader").ToString)
	NewsletterArchiveBody				= drNewsletter("NewsletterArchiveBody").ToString
	If NewsletterArchiveBody <> "" then
	NewsletterArchiveBody				= Replace(NewsletterArchiveBody, vbCrLf, "<br>").ToString
	End If
	NewsletterArchiveSenderName			= Server.HtmlEncode(drNewsletter("NewsletterArchiveSenderName").ToString)
	NewsletterArchiveSenderEmail		= drNewsletter("NewsletterArchiveSenderEmail").ToString
	NewsletterArchiveFormat				= drNewsletter("NewsletterArchiveFormat").ToString
	NewsletterArchiveFile				= drNewsletter("NewsletterArchiveFile").ToString
	NewsletterArchiveNewsCategory		= drNewsletter("NewsletterArchiveNewsCategory").ToString
	NewsletterArchiveNewsletterCategory = drNewsletter("NewsletterArchiveNewsletterCategory").ToString
	NewsletterArchiveSend				= drNewsletter("NewsletterArchiveSend").ToString
	NewsletterArchiveCount				= drNewsletter("NewsletterArchiveCount").ToString
End If
drNewsletter.Close()

If Len(NewsletterArchiveNewsletterCategory) > 0 Then
	tmpNewsletterArchiveNewsletterCategory = Replace(NewsletterArchiveNewsletterCategory, ", ", " OR NewsletterCategoryID = ")
	cmdNewsletter.CommandText = "SELECT * FROM NewsletterCategory WHERE NewsletterCategoryID IN (" & tmpNewsletterArchiveNewsletterCategory & ")"
	drNewsletter = cmdNewsletter.ExecuteReader()
	
	Dim blnDrNewsletterHasMoreRows As Boolean = False
	Do While drNewsletter.Read()
		If blnDrNewsletterHasMoreRows Then 
			lists = lists & ", "
		End If
		
		lists = lists & Server.HtmlEncode(drNewsletter("NewsletterCategoryName"))
		
		If Not blnDrNewsletterHasMoreRows Then blnDrNewsletterHasMoreRows = True
	Loop 
	drNewsletter.Close()
End If

If Len(NewsletterArchiveNewsCategory) > 0 Then
	tmpNewsletterArchiveNewsCategory = Replace(NewsletterArchiveNewsCategory, ", ", " OR NewsCategoryID = ")
	cmdDynamic.CommandText  = "SELECT * FROM NewsCategory WHERE NewsCategoryID = " & tmpNewsletterArchiveNewsCategory
	drDynamic = cmdDynamic.ExecuteReader()
	Dim blnDrDynamicHasMoreRows As Boolean = False
	Do While drDynamic.Read()
		If blnDrDynamicHasMoreRows Then 
			newslist = newslist & ", "
		End If
	
		newslist = newslist & drDynamic("NewsCategoryName") 
	Loop 
	drDynamic.Close()
	drDynamic.Dispose()
End If
'Cleanup

drNewsletter.Dispose()
cmdNewsletter.Dispose()	
cmdDynamic.Dispose()		
cnDynamic.Dispose()		
cnNewsletter.Dispose()	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<%=Gui.MakeHeaders(Translate.Translate("Nyhedsbrev - %%", "%%", NewsletterArchiveHeader), Translate.Translate("Oplysninger"), "all")%>
<div ID="Tab1" STYLE="display:;">
	<table border="0" cellpadding="0" cellspacing="2" class="tabTable">
		<tr>
			<td valign="top"><br>
				<table border="0" cellpadding="0" width="100%">
					<tr>
				    	<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<td width="50" height="17"><strong><%=Translate.Translate("Dato")%>:</strong></td>
						<td><%=Dates.ShowDate(CDate(NewsletterArchiveSend), Dates.Dateformat.Short, True)%></td>
					</tr>
					<tr>
						<td width="50" height="17"><strong><%=Translate.Translate("Fra")%>:</strong></td>
						<td><%=NewsletterArchiveSenderName%> (<%=NewsletterArchiveSenderEmail%>)</td>
					</tr>
					<tr>
						<td width="50" height="17"><strong><%=Translate.Translate("Til")%>:</strong></td>
						<td><%=lists%></td>
					</tr>
					<tr>
						<td width="50" height="17"><strong><%=Translate.Translate("Nyhedskategorier")%>:</strong></td>
						<td><%=newslist%></td>
					</tr>
					<tr>
						<td width="50" height="17"><strong><%=Translate.Translate("Emne")%>:</strong></td>
						<td><%=NewsletterArchiveHeader%></td>
					</tr>
					<tr>
				    	<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<td width="50" valign="top" height="17"><strong><%=Translate.Translate("Tekst")%>:</strong></td>
						<td><%=NewsletterArchiveBody%></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right" width="520"></td>
			<td align="right" width="80"><%=Gui.Button(Translate.Translate("Luk"), "window.open('newsletter_front.aspx?tab=3','_self');", 0)%></td>
		</tr>
	</table>
</div>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>