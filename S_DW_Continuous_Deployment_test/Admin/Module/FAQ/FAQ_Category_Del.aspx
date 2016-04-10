<%@ Page CodeBehind="FAQ_Category_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Category_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim strCategoryID As String

strCategoryID = Request.QueryString.Item("CategoryID")

If strCategoryID <> "" And Not isNothing(strCategoryID) Then
	Dim cnTagwallDel	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTagwallDel	As IDbCommand		= cnTagwallDel.CreateCommand()
	
	cmdTagwallDel.CommandText = "DELETE FROM FAQItem WHERE FAQItemCategoryID = " & strCategoryID
	cmdTagwallDel.ExecuteNonQuery()
	cmdTagwallDel.CommandText = "DELETE FROM FAQCategory WHERE FAQCategoryID = " & strCategoryID
	cmdTagwallDel.ExecuteNonQuery()

	'Cleanup
	cnTagwallDel.Close()
	cmdTagwallDel.Dispose()
	cnTagwallDel.Dispose()
	
End if

response.Redirect("FAQ_Category_List.aspx")
%>

