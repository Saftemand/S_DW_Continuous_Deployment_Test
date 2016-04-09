<%@ Page CodeBehind="Tagwall_Category_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Category_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<script language="VB" runat="Server">
Dim sql2 As String
Dim strCategoryID As String
Dim sql1 As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-07-2002
'	Last modfied:		10-08-2004
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'		1.1 - 10-08-2004 - David Frandsen
'		First version.
'**************************************************************************************************

strCategoryID = Request.QueryString.Item("CategoryID")

If strCategoryID <> "" And Not isNothing(strCategoryID) Then
	Dim cnTagwallDel	As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTagwallDel	As IDbCommand					= cnTagwallDel.CreateCommand()
	
	cmdTagwallDel.CommandText = "DELETE FROM TagwallItem WHERE TagwallItemCategoryID = " & strCategoryID
	cmdTagwallDel.ExecuteNonQuery()
	cmdTagwallDel.CommandText = "DELETE FROM TagwallCategory WHERE TagwallCategoryID = " & strCategoryID
	cmdTagwallDel.ExecuteNonQuery()

	'Cleanup
	cnTagwallDel.Close()
	cmdTagwallDel.Dispose()
	cnTagwallDel.Dispose()
	
End if

response.Redirect("Tagwall_Category_List.aspx")
%>

