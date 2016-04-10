<%@ Page CodeBehind="newsletter_category_delete.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_category_delete" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

Dim strNewsletterCategoryID As String = request.QueryString.Item("NewsletterCategoryID")

If strNewsletterCategoryID <> "" And Not strNewsletterCategoryID = "0" Then
	Dim cn		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
	Dim cmd		As IDbCommand		= cn.CreateCommand
				
	cmd.CommandText = "DELETE FROM [NewsletterCategory] WHERE [NewsletterCategoryID] = " & strNewsletterCategoryID
	cmd.ExecuteNonQuery()

	cmd.Dispose()
	cn.Dispose()
End If

response.Redirect("newsletter_front.aspx?Tab=2")

%>
