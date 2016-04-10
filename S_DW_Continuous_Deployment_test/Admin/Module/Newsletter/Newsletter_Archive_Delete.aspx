<%@ Page CodeBehind="Newsletter_Archive_Delete.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Newsletter_Archive_Delete" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%

response.Expires = -100

Dim strNewsletterArchieveID As String = Request.QueryString.Item("ID")

If strNewsletterArchieveID <> "" And Not strNewsletterArchieveID = "0" Then
	Dim cn		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
	Dim cmd		As IDbCommand		= cn.CreateCommand
				
	cmd.CommandText = "DELETE FROM [NewsletterArchive] WHERE [NewsletterArchiveID] = " & strNewsletterArchieveID
	cmd.ExecuteNonQuery()

	cmd.Dispose()
	cn.Dispose()
End If

response.Redirect("Newsletter_Front.aspx?Tab=3")
%>

