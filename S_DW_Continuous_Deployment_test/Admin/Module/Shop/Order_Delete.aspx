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

	Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	SQL = "UPDATE ShopOrder SET ShopOrderDeleted = " & Database.SQLBool(1) & " WHERE ShopOrderID = " & Request.QueryString("ID")

	sCmdShop.CommandText = SQL
	sCmdShop.ExecuteNonQuery()

	sCmdShop.Dispose
	ShopConn.Dispose
	
End If

If Request.QueryString("Archive") = "True" Then
	Response.Redirect("Order_List.aspx?Archive=True&ShopOrderDateTimeFrom=" & request.querystring("ShopOrderDateTimeFrom") & "&ShopOrderDateTimeTo=" & request.querystring("ShopOrderDateTimeTo"))
Else
	Response.Redirect("Order_List.aspx")
End If


%>
