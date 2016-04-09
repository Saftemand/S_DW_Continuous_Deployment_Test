<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim SQL As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Save product
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(request.QueryString("ID")) Then
	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	SQL = "DELETE FROM ShopProduct WHERE ShopProductID = " & Request.QueryString("ID")

	sCmdShop.CommandText = SQL
	sCmdShop.ExecuteNonQuery()

	sCmdShop.Dispose
	ShopConn.Dispose
End If

response.Redirect(("Product_List.aspx?ID=" & Request.QueryString("ShopProductGroupID")))
%>
