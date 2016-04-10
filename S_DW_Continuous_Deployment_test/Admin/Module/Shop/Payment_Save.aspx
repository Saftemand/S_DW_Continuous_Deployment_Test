<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim strSQL As String
Dim ShopPaymentID As String
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

If CInt(Request.Form("ShopPaymentDefault")) = 1 Then
	strSQL = "UPDATE ShopPayment SET ShopPaymentDefault = 0"
	cmdShop.CommandText = strSQL 
	cmdShop.ExecuteNonQuery()
End If


ShopPaymentID = CType(Base.ChkNumber(Request.Form("ShopPaymentID")), String)

strSQL = "SELECT * FROM ShopPayment WHERE ShopPaymentID = " & ShopPaymentID

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet
Dim newRow As DataRow

cmdShop.CommandText = strSQL
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

If ShopPaymentID = "0" Then
    newRow = dsShop.Tables(0).NewRow()
    dsShop.Tables(0).Rows.Add(newRow)
Else
    newRow = dsShop.Tables(0).Rows(0)
End If

newRow("ShopPaymentName") = Base.ChkValue(request.Form("ShopPaymentName"))
If request.Form("ShopPaymentPrice") <> "" Then
	newRow("ShopPaymentPrice") = CInt(Base.ChkValues(request.Form("ShopPaymentPrice")))
End If
If request.Form("ShopPaymentPrice2") <> "" Then
	newRow("ShopPaymentPrice2") = CInt(Base.ChkValues(request.Form("ShopPaymentPrice2")))
End If
newRow("ShopPaymentDefault") = CInt(request.Form("ShopPaymentDefault"))
If request.Form("ShopPaymentMaxTotal") <> "" Then
	newRow("ShopPaymentMaxTotal") = CInt(Base.ChkValues(request.Form("ShopPaymentMaxTotal")))
End If

newRow("ShopPaymentActive") = CInt(request.Form("ShopPaymentActive"))
If Not IsNothing(request.Form("ShopPaymentSystemName")) Then
	newRow("ShopPaymentSystemName") = Base.ChkValue(request.Form("ShopPaymentSystemName"))
End If

adShopAdapter.Update(dsShop)

dsShop.Dispose()
cmdShop.Dispose()
ShopConn.Dispose()

Response.Redirect(("Payment_List.aspx"))
%>
