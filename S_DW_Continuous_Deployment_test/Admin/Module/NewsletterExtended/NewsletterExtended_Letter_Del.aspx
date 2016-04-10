<%@ Page CodeBehind="NewsletterExtended_Letter_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim NewsletterID As String
Dim strPath As String
Dim SQL As String

NewsletterID = Base.ChkNumber(Request.QueryString.Item("ID"))
strPath = Request.QueryString.Item("Path")

If NewsletterID <> "" And Not NewsletterID = "0" Then
	
		Dim cn		As IDbConnection		= Database.CreateConnection("NewsletterExtended.mdb")
		Dim cmd		As IDbCommand			= cn.CreateCommand()
		
		'SQL = " DELETE FROM NewsletterExtendedStatHits WHERE NewsletterStatHitsStatID NOT IN (SELECT NewsletterStatID FROM NewsletterExtendedStat WHERE NewsletterStatLetterID = " & NewsletterID & ")"
		'cmd.CommandText = SQL
		'cmd.ExecuteNonQuery()
		
		SQL = " DELETE FROM NewsletterExtendedStat WHERE NewsletterStatLetterID = " & NewsletterID
		cmd.CommandText = SQL
		cmd.ExecuteNonQuery()
		
		SQL = " DELETE FROM NewsletterExtendedAttachment WHERE NewsletterLetterID = " & NewsletterID
		cmd.CommandText = SQL
		cmd.ExecuteNonQuery()
		
		SQL = " DELETE FROM NewsletterExtendedCategoryLetter WHERE NewsLetterCategoryLetterLetterID = " & NewsletterID
		cmd.CommandText = SQL
		cmd.ExecuteNonQuery()
		
		SQL = " DELETE FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
		cmd.CommandText = SQL
		cmd.ExecuteNonQuery()
		
		cmd.Dispose()
		cn.Dispose()

End If

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
<%
If strPath <> "" Then
	
	Response.Write("parent.document.getElementById('ListRight').setAttribute(""src"", """ & strPath & """);")
	If InStr(strPath, "ListList") = 0 Then
		Response.Write("parent.document.getElementById('ContentCell').setAttribute(""src"", ""NewsletterExtended_Treeview.aspx"");")
	End If
Else
	Response.Write("parent.document.getElementById('ContentCell').setAttribute(""src"", ""NewsletterExtended_Treeview.aspx?OpenWhat=Letters"");")
	Response.Write("parent.document.getElementById('ListRight').setAttribute(""src"", ""NewsletterExtended_Blank.html"");")
End If
%>
//-->
</SCRIPT>
