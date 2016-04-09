<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim ShopDeliveryID As String
Dim strSQL As String
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

Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

If CInt(Request.Form("ShopDeliveryDefault")) = 1 Then
	strSQL = "UPDATE ShopDelivery SET ShopDeliveryDefault = 0"
	cmdShop.CommandText = strSQL
	cmdShop.ExecuteNonQuery()
End If


ShopDeliveryID = CType(Base.ChkNumber(Request.Form("ShopDeliveryID")), String)

strSQL = "SELECT * FROM ShopDelivery WHERE ShopDeliveryID=" & ShopDeliveryID

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet
Dim newRow As DataRow

cmdShop.CommandText = strSQL
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

If ShopDeliveryID = "0" Then
    newRow = dsShop.Tables(0).NewRow()
    dsShop.Tables(0).Rows.Add(newRow)
Else
    newRow = dsShop.Tables(0).Rows(0)
End If

newRow("ShopDeliveryName") = Base.ChkValue(Request.Form.Item("ShopDeliveryName"))
If Request.Form("ShopDeliveryPrice") <> "" Then
	newRow("ShopDeliveryPrice") = CInt(Base.ChkValues(Request.Form.Item("ShopDeliveryPrice")))
End If
If Request.Form("ShopDeliveryPrice2") <> "" Then
	newRow("ShopDeliveryPrice2") = CInt(Base.ChkValues(Request.Form.Item("ShopDeliveryPrice2")))
End If
If Request.Form("ShopDeliveryMaxTotal") <> "" Then
	newRow("ShopDeliveryMaxTotal")	= CInt(Base.ChkValues(Request.Form.Item("ShopDeliveryMaxTotal")))
End If
newRow("ShopDeliveryDefault") = CInt(Request.Form.Item("ShopDeliveryDefault"))
newRow("ShopDeliveryActive") = CInt(Request.Form.Item("ShopDeliveryActive"))

adShopAdapter.Update(dsShop)

dsShop.Dispose()
cmdShop.Dispose()
ShopConn.Dispose()

Response.Redirect(("Delivery_List.aspx"))
%>
