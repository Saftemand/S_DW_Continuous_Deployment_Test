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
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Delete payment
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(Request.QueryString("ID")) Then
	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim cmdShop As IDbCommand = ShopConn.CreateCommand

	If Request.QueryString("Moveback") = "true" Then
		SQL = "UPDATE ShopOrder SET ShopOrderArchiveDate = NULL WHERE ShopOrderID = " & Request.QueryString("ID")
	Else
		SQL = "UPDATE ShopOrder SET ShopOrderArchiveDate = '" & Dates.DWNow() & "' WHERE ShopOrderID = " & Request.QueryString("ID")
	End If
	
	CmdShop.CommandText = SQL
	CmdShop.ExecuteNonQuery()

	cmdShop.Dispose
	ShopConn.Dispose
End If

If Request.QueryString("Moveback") = "true" Then
	Response.Redirect("Order_List.aspx?Archive=True&ShopOrderDateTimeFrom=" & request.querystring("ShopOrderDateTimeFrom") & "&ShopOrderDateTimeTo=" & request.querystring("ShopOrderDateTimeTo"))
Else
	Response.Redirect("Order_List.aspx?ShopOrderDateTimeFrom=" & request.querystring("ShopOrderDateTimeFrom") & "&ShopOrderDateTimeTo=" & request.querystring("ShopOrderDateTimeTo"))
End If
%>
