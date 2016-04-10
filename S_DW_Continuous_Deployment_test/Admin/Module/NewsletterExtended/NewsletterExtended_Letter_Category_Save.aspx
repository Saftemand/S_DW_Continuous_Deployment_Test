<%@ Page CodeBehind="NewsletterExtended_Letter_Category_Save.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Category_Save" validateRequest="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim i As Integer
Dim arrNewsletterMailCategoryID() As String
Dim SQL As String

Dim NewsletterMailCategoryID As String
Dim NewsletterID As String

NewsletterID = Base.ChkNumber(Request.Item("NewsletterID"))
NewsletterMailCategoryID = Base.ChkValues(Request.Form.Item("NewsletterMailCategory"))

Dim cn		As IDbConnection		= Database.CreateConnection("NewsletterExtended.mdb")
Dim cmd		As IDbCommand			= cn.CreateCommand

SQL = "DELETE FROM NewsletterExtendedCategoryLetter WHERE NewsletterCategoryLetterLetterID = " & NewsletterID
cmd.CommandText = SQL
cmd.ExecuteNonQuery()

If NewsletterMailCategoryID <> "" And Not NewsletterMailCategoryID = "0" Then
	arrNewsletterMailCategoryID = Split(NewsletterMailCategoryID, ",")
	For i = 0 To UBound(arrNewsletterMailCategoryID)
		SQL = " INSERT INTO NewsletterExtendedCategoryLetter (NewsletterCategoryLetterLetterID, NewsletterCategoryLetterCategoryID) " & " VALUES (" & NewsletterID & ", " & arrNewsletterMailCategoryID(i) & ")"
		cmd.CommandText = SQL
		cmd.ExecuteNonQuery()
	Next 
End If

cmd.Dispose()
cn.Dispose()

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
document.location = "NewsletterExtended_letter_body.aspx?ID=<%=NewsletterID%>&Tab=Tab3"
//-->
</SCRIPT>
