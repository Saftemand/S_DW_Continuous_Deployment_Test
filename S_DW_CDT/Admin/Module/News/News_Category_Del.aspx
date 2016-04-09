<%@ Page CodeBehind="News_Category_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Category_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim strCategoryID As String
strCategoryID = Request.QueryString.Item("CategoryID")

If strCategoryID <> "" And Not isNothing(strCategoryID) Then
	Dim cn		As IDbConnection		= Database.CreateConnection("Dynamic.mdb")
	Dim cmd		As IDbCommand			= cn.CreateCommand()
	
	cmd.CommandText = "DELETE FROM [News] WHERE [NewsCategoryID]= " & strCategoryID
	cmd.ExecuteNonQuery()
	
	cmd.CommandText = "DELETE FROM [NewsCategory] WHERE [NewsCategoryID] = " & strCategoryID
	cmd.ExecuteNonQuery()

	'Cleanup
	cn.Close()
	cmd.Dispose()
	cn.Dispose()
	
End if

response.Redirect("News_Category_List.aspx")
%>

