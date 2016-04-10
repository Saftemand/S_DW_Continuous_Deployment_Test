<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Order_Export.aspx.vb" Inherits="Dynamicweb.Admin.Order_Export"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%
Dim Path As String
Dim sql As String
Dim FileHome As String
Dim ShowSettings As Boolean
Dim Save2CSV As Boolean

ShowSettings = True

Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand


sql = "SELECT ShopOrderID As Ordrenummer, ShopOrderDate As Dato, '' As Ordrelinier, ShopOrder.ShopOrderComment As Kommentar1, ShopOrder.ShopOrderComment2 As Kommentar2, ShopOrder.ShopOrderComment3 As Kommentar3, ShopOrder.ShopOrderComment4 As Kommentar4, ShopPayment.ShopPaymentName As Betalingsmetode, ShopOrderPaymentFee As Betalingsgebyr, ShopDelivery.ShopDeliveryName As Leveringsmetode, ShopOrderDeliveryFee As Leveringsgebyr, ShopOrderCurrencyName As Valuta, ShopOrderTransActionValue As Transaktionsnummer, ShopOrderCustomerNumber, ShopOrderCustomerCompany, ShopOrderCustomerName, ShopOrderCustomerAddress, ShopOrderCustomerAddress2, ShopOrderCustomerZip, ShopOrderCustomerCity, ShopOrderCustomerCountry, ShopOrderCustomerPhone, ShopOrderCustomerCell, ShopOrderCustomerFax, ShopOrderCustomerEmail, ShopOrderCustomerReference, ShopOrderStatus As Onlinebetaling"
sql = sql & " FROM ShopDelivery RIGHT JOIN (ShopOrder LEFT JOIN ShopPayment ON ShopOrder.ShopOrderPaymentType = ShopPayment.ShopPaymentID) ON ShopDelivery.ShopDeliveryID = ShopOrder.ShopOrderDeliveryType "

If Request.QueryString("Archive") = "True" Then
	SQL = SQL & "WHERE ShopOrder.ShopOrderArchiveDate Is Not Null And ShopOrderDeleted <> " & Database.SQLBool(1)
Else
	SQL = SQL & "WHERE ShopOrder.ShopOrderArchiveDate Is Null And ShopOrderDeleted <> " & Database.SQLBool(1)
End If

sql = sql & " ORDER BY ShopOrderID DESC"

sCmdShop.CommandText = sql

Dim drOrderReader As IDataReader = sCmdShop.ExecuteReader()

Path = Server.MapPath("/Files/OrderExport.csv")
Save2CSV = DatareaderToCSVshop(drOrderReader, Path)

%>
<script>
	location = 'Order_List.aspx?Export=True';
</script>

