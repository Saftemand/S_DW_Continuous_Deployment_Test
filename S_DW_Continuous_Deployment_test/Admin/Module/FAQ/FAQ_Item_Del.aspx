<%@ Page CodeBehind="FAQ_Item_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Item_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim ArtConn As Object
Dim strCategoryID As String
Dim sql As String
Dim strFAQID As String

strFAQID = request.QueryString.Item("FAQID")
strCategoryID = request.QueryString.Item("CategoryID")

If strFAQID <> "" And Not isNothing(strFAQID) Then
	Dim cnTagwallDel	As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTagwallDel	As IDbCommand					= cnTagwallDel.CreateCommand()
	'Todo FAQ_Item_del - Versionsstyring mangler
	'cmdTagwallDel.CommandText = "Delete from FAQItem where FAQItemVersionParentID = (Select f2.FAQItemVersionParentID from FAQItem as f2 where f2.FAQItemID = " & FAQID & ")"
	cmdTagwallDel.CommandText = "DELETE From FAQItem WHERE FAQItemID = " & strFAQID
	cmdTagwallDel.ExecuteNonQuery()

	'Cleanup
	cnTagwallDel.Close()
	cmdTagwallDel.Dispose()
	cnTagwallDel.Dispose()
	
End if

response.Redirect("FAQ_Item_List.aspx?CategoryID=" & strCategoryID)
%>



