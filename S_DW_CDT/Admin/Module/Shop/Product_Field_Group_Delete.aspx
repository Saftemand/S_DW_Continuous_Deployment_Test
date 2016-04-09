<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim ShopProductFieldGroupID As String
Dim SQL As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Save field
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

ShopProductFieldGroupID = Request("GroupID")

SQL = "DELETE FROM ShopProductField WHERE ShopProductFieldGroupID=" & ShopProductFieldGroupID
sCmdShop.CommandText = SQL
sCmdShop.ExecuteNonQuery()

SQL = "DELETE FROM ShopProductFieldGroup WHERE ShopProductFieldGroupID=" & ShopProductFieldGroupID
sCmdShop.CommandText = SQL
sCmdShop.ExecuteNonQuery()

sCmdShop.Dispose
ShopConn.Dispose

Response.Redirect(("Product_Field_List.aspx?Tab=2"))
%>
