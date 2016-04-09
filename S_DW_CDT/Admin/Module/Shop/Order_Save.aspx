<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" LCID=1030 UICulture="da-DK"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim ShopOrderID As String
Dim strSQL As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Save order
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

ShopOrderID = CType(Base.ChkNumber(Request.Form("ShopOrderID")), String)

strSQL = "SELECT * FROM ShopOrder WHERE ShopOrderID=" & ShopOrderID

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet
Dim newRow As DataRow

cmdShop.CommandText = strSQL
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

If ShopOrderID <> "0" Then
    newRow = dsShop.Tables(0).Rows(0)
	newRow("ShopOrderModified") = Dates.DWNow()
	newRow("ShopOrderCustomerNumber") = Base.ChkValue(Request.Form("ShopOrderCustomerNumber"))
	newRow("ShopOrderCustomerCompany") = Base.ChkValue(Request.Form("ShopOrderCustomerCompany"))
	newRow("ShopOrderCustomerName") = Base.ChkValue(Request.Form("ShopOrderCustomerName"))
	newRow("ShopOrderCustomerAddress") = Base.ChkValue(Request.Form("ShopOrderCustomerAddress"))
	newRow("ShopOrderCustomerAddress2") = Base.ChkValue(Request.Form("ShopOrderCustomerAddress2"))
	newRow("ShopOrderCustomerZip") = Base.ChkValue(Request.Form("ShopOrderCustomerZip"))
	newRow("ShopOrderCustomerCity") = Base.ChkValue(Request.Form("ShopOrderCustomerCity"))
	newRow("ShopOrderCustomerCountry") = Base.ChkValue(Request.Form("ShopOrderCustomerCountry"))
	newRow("ShopOrderCustomerPhone") = Base.ChkValue(Request.Form("ShopOrderCustomerPhone"))
	newRow("ShopOrderCustomerCell") = Base.ChkValue(Request.Form("ShopOrderCustomerCell"))
	newRow("ShopOrderCustomerFax") = Base.ChkValue(Request.Form("ShopOrderCustomerFax"))
	newRow("ShopOrderCustomerEmail") = Base.ChkValue(Request.Form("ShopOrderCustomerEmail"))
	newRow("ShopOrderCustomerReference") = Base.ChkValue(Request.Form("ShopOrderCustomerReference"))
	newRow("ShopOrderDeliveryCompany") = Base.ChkValue(Request.Form("ShopOrderDeliveryCompany"))
	newRow("ShopOrderDeliveryName") = Base.ChkValue(Request.Form("ShopOrderDeliveryName"))
	newRow("ShopOrderDeliveryAddress") = Base.ChkValue(Request.Form("ShopOrderDeliveryAddress"))
	newRow("ShopOrderDeliveryAddress2") = Base.ChkValue(Request.Form("ShopOrderDeliveryAddress2"))
	newRow("ShopOrderDeliveryZip") = Base.ChkValue(Request.Form("ShopOrderDeliveryZip"))
	newRow("ShopOrderDeliveryCity") = Base.ChkValue(Request.Form("ShopOrderDeliveryCity"))
	newRow("ShopOrderDeliveryCountry") = Base.ChkValue(Request.Form("ShopOrderDeliveryCountry"))
	newRow("ShopOrderDeliveryPhone") = Base.ChkValue(Request.Form("ShopOrderDeliveryPhone"))
	newRow("ShopOrderDeliveryCell") = Base.ChkValue(Request.Form("ShopOrderDeliveryCell"))
	newRow("ShopOrderDeliveryFax") = Base.ChkValue(Request.Form("ShopOrderDeliveryFax"))
	newRow("ShopOrderDeliveryEmail") = Base.ChkValue(Request.Form("ShopOrderDeliveryEmail"))
	newRow("ShopOrderDeliveryReference") = Base.ChkValue(Request.Form("ShopOrderDeliveryReference"))
	newRow("ShopOrderComment") = Base.ChkValue(Request.Form("ShopOrderComment"))
	newRow("ShopOrderComment2") = Base.ChkValue(Request.Form("ShopOrderComment2"))
	newRow("ShopOrderComment3") = Base.ChkValue(Request.Form("ShopOrderComment3"))
	newRow("ShopOrderComment4") = Base.ChkValue(Request.Form("ShopOrderComment4"))
	newRow("ShopOrderRead") = 0

	adShopAdapter.Update(dsShop)
End If
dsShop.Dispose()
cmdShop.Dispose()


Dim SQL as string = "SELECT * FROM ShopOrderLine WHERE ShopOrderLineOrderID = " & ShopOrderID
Dim cmdOrderline As IDbCommand = ShopConn.CreateCommand
Dim adOrderlineAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cbOrderline As Object = Database.CreateCommandBuilder(adOrderlineAdapter)
Dim dsOrderline As DataSet = New DataSet
Dim newOrderline As DataRow

cmdOrderline.CommandText = SQL
adOrderlineAdapter.SelectCommand = cmdOrderline
adOrderlineAdapter.Fill(dsOrderline)

For i As Integer = 0 To dsOrderline.Tables(0).Rows.Count - 1
	newOrderline = dsOrderline.Tables(0).Rows(i)
	newOrderline("ShopOrderLineProductAmount") = CType(Request.Form("ShopOrderLineProductAmount" & newOrderline("ShopOrderLineID")), Double)
	If Request.Form("ShopOrderCurrencyRate") = "" OR Request.Form("ShopOrderCurrencyRate") = Nothing Then
		newOrderline("ShopOrderLineProductPrice") = CType(Request.Form("ShopOrderLineProductPrice" & newOrderline("ShopOrderLineID")), Double)
	Else
		newOrderline("ShopOrderLineProductPrice") = CType((CDbl(Request.Form("ShopOrderLineProductPrice" & newOrderline("ShopOrderLineID").ToString()))/Cdbl(Request.Form("ShopOrderCurrencyRate"))* 100.00), Double)
	End If
	i += 1
Next

adOrderlineAdapter.Update(dsOrderline)


dsOrderline.Dispose()
cmdOrderline.Dispose()
ShopConn.Dispose()

Response.Redirect(("Order_List.aspx"))
%>
