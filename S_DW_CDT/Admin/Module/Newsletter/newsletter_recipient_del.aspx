<%@ Page CodeBehind="newsletter_recipient_del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_recipient_del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim strNewsletterRecipientID As String = request.QueryString.Item("NewsletterRecipientID")

If strNewsletterRecipientID <> "" And Not strNewsletterRecipientID = "0" Then
	Dim cn		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
	Dim cmd		As IDbCommand		= cn.CreateCommand
	
	cmd.CommandText = "DELETE FROM NewsletterRecipient WHERE NewsletterRecipientID = " & strNewsletterRecipientID
	cmd.ExecuteNonQuery()

	cmd.Dispose()
	cn.Dispose()
End If

Response.Redirect("newsletter_category_edit.aspx?NewsletterCategoryID=" & request.QueryString.Item("NewsletterCategoryID"))
%>
