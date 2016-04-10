<%@ Page CodeBehind="NewsletterExtended_Letter_Copy.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Copy" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			30-04-2003
'
'	Purpose: Saves the actual Newsletter.
'
'	Revision history:
'		1.0 - 30-04-2003 - John Krogh
'		First version.
'**************************************************************************************************
Dim SQL As String
Dim NewNewsletterID As String
Dim NewsletterID As String = Request.Item("NewsletterID")
If NewsletterID <> "" And Not NewsletterID = "0" Then 
	Dim cnNewsletterAdd As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
	Dim cmdNewsletterAdd As IDbCommand = cnNewsletterAdd.CreateCommand
	Dim dsNewsletterAdd As DataSet = New DataSet
	Dim daNewsletterAdd As IDbDataAdapter = Database.CreateAdapter()
	Dim dtNewsletterAdd As DataTable
	Dim rowNewsletterAdd As DataRow

	Dim cnNewsletterGet As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
	Dim cmdNewsletterGet As IDbCommand = cnNewsletterGet.CreateCommand
	Dim dsNewsletterGet As DataSet = New DataSet
	Dim daNewsletterGet As IDbDataAdapter = Database.CreateAdapter()
	Dim dtNewsletterGet As DataTable
	Dim rowNewsletterGet As DataRow

	SQL = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
	cmdNewsletterGet.CommandText = SQL
	daNewsletterGet.SelectCommand = cmdNewsletterGet
	daNewsletterGet.Fill(dsNewsletterGet)
	dtNewsletterGet = dsNewsletterGet.Tables(0)
	rowNewsletterGet = dtNewsletterGet.Rows(0)

	SQL = "SELECT top 1 * FROM NewsletterExtended"
	cmdNewsletterAdd.CommandText = SQL
	daNewsletterAdd.SelectCommand = cmdNewsletterAdd
	daNewsletterAdd.Fill(dsNewsletterAdd)
	dtNewsletterAdd = dsNewsletterAdd.Tables(0)
	rowNewsletterAdd = dtNewsletterAdd.NewRow()
	dtNewsletterAdd.Rows.Add(rowNewsletterAdd)

	rowNewsletterAdd("NewsletterName")					=	Translate.Translate("Kopi af ") & rowNewsletterGet("NewsletterName")
	rowNewsletterAdd("NewsletterDescription")			=	rowNewsletterGet("NewsletterDescription")
	rowNewsletterAdd("NewsletterStylesheetID")			=	rowNewsletterGet("NewsletterStylesheetID")
	rowNewsletterAdd("NewsletterContent")				=	rowNewsletterGet("NewsletterContent")
	rowNewsletterAdd("NewsletterContentParsed")			=	rowNewsletterGet("NewsletterContentParsed")
	rowNewsletterAdd("NewsletterTemplateID")			=	rowNewsletterGet("NewsletterTemplateID")	
	rowNewsletterAdd("NewsletterEncodingID")			=	rowNewsletterGet("NewsletterEncodingID")
	rowNewsletterAdd("NewsletterMailSubject")			=	rowNewsletterGet("NewsletterMailSubject")
	rowNewsletterAdd("NewsletterMailSenderName")		=	rowNewsletterGet("NewsletterMailSenderName")
	rowNewsletterAdd("NewsletterMailSenderEmail")		=	rowNewsletterGet("NewsletterMailSenderEmail")
	rowNewsletterAdd("NewsletterLevel")					=	2
	rowNewsletterAdd("NewsletterCancelLink")			=	rowNewsletterGet("NewsletterCancelLink")
	rowNewsletterAdd("NewsletterSubscriptionLink")		=	rowNewsletterGet("NewsletterSubscriptionLink")
	rowNewsletterAdd("NewsletterSubscriptionLinkText")	=	rowNewsletterGet("NewsletterSubscriptionLinkText")
	rowNewsletterAdd("NewsletterCancelLinkText")		=	rowNewsletterGet("NewsletterCancelLinkText")
	rowNewsletterAdd("NewsletterLetterType")			=	rowNewsletterGet("NewsletterLetterType")
	rowNewsletterAdd("NewsletterPageBasedLink")			=	rowNewsletterGet("NewsletterPageBasedLink")
	rowNewsletterAdd("NewsletterTextMailBody")			=   rowNewsletterGet("NewsletterTextMailBody")
	rowNewsletterAdd("NewsletterSpecTextMail")			=   rowNewsletterGet("NewsletterSpecTextMail")
	
	'Update
	Database.CreateCommandBuilder(daNewsletterAdd)
	daNewsletterAdd.Update(dsNewsletterAdd)
	
	'Sets the NewsletterStatID for the new row.
    Database.GetAddedIdentityKey(rowNewsletterAdd, cnNewsletterAdd, 0)

	NewNewsletterID = rowNewsletterAdd("NewsletterID")

	cnNewsletterGet.Dispose()
	cmdNewsletterGet.Dispose()
	dsNewsletterGet.Dispose()
	
	cnNewsletterAdd.Dispose()
	cmdNewsletterAdd.Dispose()
	dsNewsletterAdd.Dispose()
	
	Dim cnNewsletterExtended As IDbConnection	= Database.CreateConnection("NewsletterExtended.mdb")
	Dim cmdNewsletterExtended As IDbCommand		= cnNewsletterExtended.CreateCommand
    
	Dim	strSQLCategoryInsert As String	=	" INSERT INTO NewsletterExtendedCategoryLetter (NewsLetterCategoryLetterCategoryID, NewsLetterCategoryLetterLetterID) " & _
								" SELECT NewsLetterCategoryLetterCategoryID, " & NewNewsletterID & " FROM NewsLetterExtendedCategoryLetter WHERE NewsLetterCategoryLetterLetterID = " & NewsletterID
	cmdNewsletterExtended.CommandText = strSQLCategoryInsert
	cmdNewsletterExtended.ExecuteNonQuery()

	Dim strSQLAttachmentInsert As String =	" INSERT INTO NewsletterExtendedAttachment (NewsletterAttachmentPath, NewsletterLetterID) " & _
								" SELECT NewsletterAttachmentPath, " & NewNewsletterID & " FROM NewsletterExtendedAttachment WHERE NewsletterLetterID = " & NewsletterID
								
	cmdNewsletterExtended.CommandText = strSQLAttachmentInsert
	cmdNewsletterExtended.ExecuteNonQuery()

	cmdNewsletterExtended.Dispose()
	cnNewsletterExtended.Dispose()
End If


%>
<SCRIPT LANGUAGE="JavaScript">
<!--
window.opener.parent.document.getElementById('ContentCell').setAttribute("src", "NewsletterExtended_Treeview.aspx?OpenWhat=Letters");
window.opener.parent.document.getElementById('ListRight').setAttribute("src", "NewsletterExtended_letter_body.aspx?ID=<%=NewNewsletterID%>&Tab=Tab2");
window.close();

//-->
</SCRIPT>