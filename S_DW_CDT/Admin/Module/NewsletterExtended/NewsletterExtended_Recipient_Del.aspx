<%@ Page CodeBehind="NewsletterExtended_Recipient_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>



<%
Dim RecipientID As String
Dim CategoryID As String
Dim sql As String
Dim SortColumn As String
Dim PageType As String
Dim SortOrder As String

RecipientID = Request.QueryString.Item("RecipientID")
CategoryID = Request.QueryString.Item("CategoryID")
SortOrder = Request.QueryString.Item("SortOrder")
SortColumn = Request.QueryString.Item("SortColumn")
PageType = Request.QueryString.Item("PageType")

If SortOrder = "ASC" Then
	SortOrder = "DESC"
Else
	SortOrder = "ASC"
End If

If RecipientID <> "" And Not RecipientID = "0" Then

	Dim cn		As IDbConnection		= Database.CreateConnection("NewsletterExtended.mdb")
	Dim cmd		As IDbCommand			= cn.CreateCommand()

	sql = "DELETE FROM NewsletterExtendedCategoryRecipient WHERE NewsletterCategoryRecipientRecipientID = " & RecipientID
	cmd.CommandText = SQL
	cmd.ExecuteNonQuery()

	sql = "DELETE FROM NewsletterExtendedEmailCheck WHERE NewsletterEmailCheckRecipientID = " & RecipientID
	cmd.CommandText = SQL
	cmd.ExecuteNonQuery()

	sql = "DELETE FROM NewsletterExtendedRecipient WHERE NewsletterRecipientID = " & RecipientID
	cmd.CommandText = SQL
	cmd.ExecuteNonQuery()
		
	sql = "DELETE FROM NewsletterExtendedUserFieldData WHERE NewsletterRecipientID = " & RecipientID
	cmd.CommandText = SQL
	cmd.ExecuteNonQuery()
	
	cmd.Dispose()
	cn.Dispose()

End If 
If Not IsNothing(Request.QueryString.GetValues("Path")) Then
	Response.Redirect(Request.QueryString.Item("Path"))
End If

If PageType = "NewsletterExtended_recipient_checkemail_List.aspx" Then
	Response.Redirect(("NewsletterExtended_recipient_checkemail_List.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SortColumn=" & SortColumn))
Else
	Response.Redirect(("NewsletterExtended_Recipient.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SortColumn=" & SortColumn))
End If
%>
