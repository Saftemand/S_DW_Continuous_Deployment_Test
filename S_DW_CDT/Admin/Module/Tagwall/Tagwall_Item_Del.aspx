<%@ Page CodeBehind="Tagwall_Item_Del.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Item_Del" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<script language="VB" runat="Server">
Dim TagwallID As String
Dim CategoryID As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			12-07-2002
'	Last modfied:		10-06-2004
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'		1.1 - 10-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************

TagwallID = request.QueryString.Item("TagwallID")
CategoryID = request.QueryString.Item("CategoryID")

If TagwallID <> "0" And Not isNothing(TagwallID) Then
	Dim cnTagwallDel	As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
	Dim cmdTagwallDel	As IDbCommand					= cnTagwallDel.CreateCommand()
	
	cmdTagwallDel.CommandText = "Delete from TagwallItem where TagwallItemID = " & TagwallID
	cmdTagwallDel.ExecuteNonQuery()

	'Cleanup
	cnTagwallDel.Close()
	cmdTagwallDel.Dispose()
	cnTagwallDel.Dispose()
	
End if
response.Redirect("Tagwall_Item_List.aspx?CategoryID=" & CategoryID)
%>



