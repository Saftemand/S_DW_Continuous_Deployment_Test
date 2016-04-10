<%@ Page CodeBehind="Forum_Category_Toggle.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Category_Toggle" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim strItemID As Object

strItemID = Request.QueryString.Item("categoryid")

If Not strItemID = "0" And strItemID <> "" Then
	If request.QueryString.Item("SetActiveInactive") = "Active" Then
		Dim cn	As IDbConnection	= Database.CreateConnection("Forum.mdb")
		Dim cmd As IDbCommand		= cn.CreateCommand
		cmd.CommandText = "UPDATE ForumCategory SET ForumCategoryActive = " & Database.SqlBool(0) & " WHERE ForumCategoryID=" & strItemID
		cmd.ExecuteNonQuery()
		cmd.Dispose()
		cn.Dispose()
	ElseIf request.QueryString.Item("SetActiveInactive") = "Inactive" Then 
		Dim cn	As IDbConnection	= Database.CreateConnection("Forum.mdb")
		Dim cmd As IDbCommand		= cn.CreateCommand
		cmd.CommandText = "UPDATE ForumCategory SET ForumCategoryActive = " & Database.SqlBool(1) & " WHERE ForumCategoryID=" & strItemID
		cmd.ExecuteNonQuery()
		cmd.Dispose()
		cn.Dispose()
	End If
End If

Response.Redirect("Forum_Category_List.aspx")
%>
