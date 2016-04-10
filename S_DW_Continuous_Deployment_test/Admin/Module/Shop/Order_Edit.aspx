<%@ Page Language="vb" AutoEventWireup="false" LCID=1030 UICulture="da-DK"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim SQL As String
Dim strShopOrderPaymentFee As String
Dim strShopOrderDeliveryFee As String
Dim TotalPrice As Double
Dim blnHasRows As Boolean
Dim strTotalPrice As String
Dim dblVatOfTotalPrice As Double
Dim dblTotalInclVat As Double
Dim strVatOfTotalPrice As String
Dim strTotalInclVat As String

Dim ShopOrderID As String
Dim ShopOrderDate As String
Dim ShopOrderModified As String
Dim ShopOrderUserName As String
Dim ShopOrderPaymentType As String
Dim ShopOrderPaymentFee As String
Dim ShopPaymentName As String
Dim ShopOrderDeliveryType As String
Dim ShopOrderDeliveryFee As String
Dim ShopDeliveryName As String
Dim ShopOrderCurrency As String
Dim ShopOrderPriceGroupID As String
Dim ShopOrderComment As String
Dim ShopOrderComment2 As String
Dim ShopOrderComment3 As String
Dim ShopOrderComment4 As String
		'**** Dankort, Visa etc. *****
Dim ShopOrderTransActionValue As String
Dim ShopOrderTransActionType As String
Dim ShopOrderStatus As String
		
Dim ShopOrderCustomerNumber As String
Dim ShopOrderCustomerCompany As String
Dim ShopOrderCustomerName As String
Dim ShopOrderCustomerAddress As String
Dim ShopOrderCustomerAddress2 As String
Dim ShopOrderCustomerZip As String
Dim ShopOrderCustomerCity As String
Dim ShopOrderCustomerCountry As String
Dim ShopOrderCustomerPhone As String
Dim ShopOrderCustomerCell As String
Dim ShopOrderCustomerFax As String
Dim ShopOrderCustomerEmail As String
Dim ShopOrderCustomerReference As String

Dim ShopOrderDeliveryCompany As String
Dim ShopOrderDeliveryName As String
Dim ShopOrderDeliveryAddress As String
Dim ShopOrderDeliveryAddress2 As String
Dim ShopOrderDeliveryZip As String
Dim ShopOrderDeliveryCity As String
Dim ShopOrderDeliveryCountry As String
Dim ShopOrderDeliveryPhone As String
Dim ShopOrderDeliveryCell As String
Dim ShopOrderDeliveryFax As String
Dim ShopOrderDeliveryEmail As String
Dim ShopOrderDeliveryReference As String

Dim ShopOrderCurrencyID As String
Dim ShopOrderCurrencyName As String
Dim ShopOrderCurrencyCharacter As String
Dim ShopOrderCurrencyRate As String

Function WriteLine(ByRef strText As Object, ByRef strType As String)
	If Len(Trim(strText)) > 0 Then
		WriteLine = ("<tr><td valign=top td width=170>" & strType & "</td><td>" & strText & "</td></tr>")
	End If
End Function
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Edit orders
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script>
function Send(FileToHandle){
//	if (document.getElementById('ShopOrder').ShopOrderName.value.length < 1){
//		alert("<%=Translate.Translate("Der skal angives et navn")%>");
//	}else{
		document.getElementById('ShopOrder').action = FileToHandle;
		document.getElementById('ShopOrder').submit();
//	}
}
function CheckPrice(objPrice) {
	var dblPrice
	dblPrice = objPrice.value.replace(',', '.')
	if(isNaN(dblPrice)) {
		alert('<%=Translate.JsTranslate("%% er ikke en gyldig pris!")%>'.replace('%%', objPrice.value) + '/n' + '<%=Translate.JsTranslate("Formatet skal være 1299,95 eller 1299.95.")%>');
		return false;
	}
	
}
</script>
</head>
<%

Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

If IsNothing(Request.QueryString("ID")) Then
	ShopOrderID = 0
Else

	ShopOrderID = Request.QueryString("ID")

	SQL = "SELECT ShopPayment.ShopPaymentName, ShopDelivery.ShopDeliveryName, ShopOrder.* FROM ShopDelivery RIGHT JOIN (ShopOrder LEFT JOIN ShopPayment ON ShopOrder.ShopOrderPaymentType = ShopPayment.ShopPaymentID) ON ShopDelivery.ShopDeliveryID = ShopOrder.ShopOrderDeliveryType WHERE ShopOrderID = " & ShopOrderID
	sCmdShop.CommandText = sql

	Dim ShopReader As IDataReader = sCmdShop.ExecuteReader()

	If ShopReader.Read Then
		ShopOrderID = Base.ChkString(ShopReader("ShopOrderID"))
		ShopOrderDate = Base.ChkString(ShopReader("ShopOrderDate"))
		ShopOrderModified = Base.ChkString(ShopReader("ShopOrderModified"))
		ShopOrderUserName = Base.ChkString(ShopReader("ShopOrderUserName"))
		ShopOrderPaymentType = Base.ChkString(ShopReader("ShopOrderPaymentType"))
		ShopOrderPaymentFee = Base.ChkString(ShopReader("ShopOrderPaymentFee"))
		ShopPaymentName = Base.ChkString(ShopReader("ShopPaymentName"))
		ShopOrderDeliveryType = Base.ChkString(ShopReader("ShopOrderDeliveryType"))
		ShopOrderDeliveryFee = Base.ChkString(ShopReader("ShopOrderDeliveryFee"))
		ShopDeliveryName = Base.ChkString(ShopReader("ShopDeliveryName"))
		ShopOrderCurrency = Base.ChkString(ShopReader("ShopOrderCurrency"))
		ShopOrderPriceGroupID = Base.ChkString(ShopReader("ShopOrderPriceGroupID"))
		ShopOrderComment = Base.ChkString(ShopReader("ShopOrderComment"))
		ShopOrderComment2 = Base.ChkString(ShopReader("ShopOrderComment2"))
		ShopOrderComment3 = Base.ChkString(ShopReader("ShopOrderComment3"))
		ShopOrderComment4 = Base.ChkString(ShopReader("ShopOrderComment4"))
		'**** Dankort, Visa etc. *****
		ShopOrderTransActionValue = Base.ChkString(ShopReader("ShopOrderTransActionValue"))
		ShopOrderTransActionType = Base.ChkString(ShopReader("ShopOrderTransActionType"))
		ShopOrderStatus = Base.ChkString(ShopReader("ShopOrderStatus"))
		
		ShopOrderCustomerNumber = Base.ChkString(ShopReader("ShopOrderCustomerNumber"))
		ShopOrderCustomerCompany = Base.ChkString(ShopReader("ShopOrderCustomerCompany"))
		ShopOrderCustomerName = Base.ChkString(ShopReader("ShopOrderCustomerName"))
		ShopOrderCustomerAddress = Base.ChkString(ShopReader("ShopOrderCustomerAddress"))
		ShopOrderCustomerAddress2 = Base.ChkString(ShopReader("ShopOrderCustomerAddress2"))
		ShopOrderCustomerZip = Base.ChkString(ShopReader("ShopOrderCustomerZip"))
		ShopOrderCustomerCity = Base.ChkString(ShopReader("ShopOrderCustomerCity"))
		ShopOrderCustomerCountry = Base.ChkString(ShopReader("ShopOrderCustomerCountry"))
		ShopOrderCustomerPhone = Base.ChkString(ShopReader("ShopOrderCustomerPhone"))
		ShopOrderCustomerCell = Base.ChkString(ShopReader("ShopOrderCustomerCell"))
		ShopOrderCustomerFax = Base.ChkString(ShopReader("ShopOrderCustomerFax"))
		ShopOrderCustomerEmail = Base.ChkString(ShopReader("ShopOrderCustomerEmail"))
		ShopOrderCustomerReference = Base.ChkString(ShopReader("ShopOrderCustomerReference"))
		
		ShopOrderDeliveryCompany = Base.ChkString(ShopReader("ShopOrderDeliveryCompany"))
		ShopOrderDeliveryName = Base.ChkString(ShopReader("ShopOrderDeliveryName"))
		ShopOrderDeliveryAddress = Base.ChkString(ShopReader("ShopOrderDeliveryAddress"))
		ShopOrderDeliveryAddress2 = Base.ChkString(ShopReader("ShopOrderDeliveryAddress2"))
		ShopOrderDeliveryZip = Base.ChkString(ShopReader("ShopOrderDeliveryZip"))
		ShopOrderDeliveryCity = Base.ChkString(ShopReader("ShopOrderDeliveryCity"))
		ShopOrderDeliveryCountry = Base.ChkString(ShopReader("ShopOrderDeliveryCountry"))
		ShopOrderDeliveryPhone = Base.ChkString(ShopReader("ShopOrderDeliveryPhone"))
		ShopOrderDeliveryCell = Base.ChkString(ShopReader("ShopOrderDeliveryCell"))
		ShopOrderDeliveryFax = Base.ChkString(ShopReader("ShopOrderDeliveryFax"))
		ShopOrderDeliveryEmail = Base.ChkString(ShopReader("ShopOrderDeliveryEmail"))
		ShopOrderDeliveryReference = Base.ChkString(ShopReader("ShopOrderDeliveryReference"))
		
		ShopOrderCurrencyID = Base.ChkString(ShopReader("ShopOrderCurrencyID"))
		ShopOrderCurrencyName = Base.ChkString(ShopReader("ShopOrderCurrencyName"))
		ShopOrderCurrencyCharacter = Base.ChkString(ShopReader("ShopOrderCurrencyCharacter"))
		ShopOrderCurrencyRate = Base.ChkString(ShopReader("ShopOrderCurrencyRate"))

		If Not IsNothing(Request.QueryString("CurrencyID")) Then
			strShopOrderPaymentFee = Base.Currency(ShopOrderPaymentFee, ShopOrderCurrencyRate, "", "")
			strShopOrderDeliveryFee = Base.Currency(ShopOrderDeliveryFee, ShopOrderCurrencyRate, "", "")
		Else
			strShopOrderPaymentFee = FormatNumber(Base.ChkDouble(ShopOrderPaymentFee), 2)
			strShopOrderDeliveryFee = FormatNumber(Base.ChkDouble(ShopOrderDeliveryFee), 2)
		End If

	End If

	ShopReader.Dispose

End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Ordre"), Translate.Translate("Ordre") & ", " & Translate.Translate("Kunde") & ", " & Translate.Translate("Levering"), "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
	<tr>
		<td valign=top>
		<form name="ShopOrder" id="ShopOrder" method="Post">
		<input type="hidden" name="ShopOrderID" value="<%=ShopOrderID%>">
		<input type="hidden" name="ShopOrderCurrencyRate" value="<%=ShopOrderCurrencyRate%>">
		<div id="Tab1" style="display:;">
		<br>
		<%=Gui.GroupBoxStart(Translate.Translate("Ordre"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Nummer")%></td>
				<td><%=ShopOrderID%></td>
			</tr>

			<%If ShopOrderStatus = "2" Then ' V2 ordre (onlinebetaling / ikke gennemført)%>
				<tr>
					<td><%=Translate.Translate("Transactions ID")%></td>
					<td><%=Translate.Translate("Afventer betaling")%>&nbsp;&nbsp;<img src="../../images/infoicon.gif" width="14" height="16" align="absmiddle"></td>
				</tr>	
			<%ElseIf ShopOrderStatus = "3" Then  ' V2 ordre (onlinebetaling / gennemført)%>
				<tr>
					<td><%=Translate.Translate("Transactions ID")%></td>
					<%If ShopOrderTransActionType = "DOBSPayment" Then%>
						<td><%= ShopOrderTransActionValue %><a target="dibs_admin" href="http://www.dobs.dk/adm/login.asp">&nbsp;&nbsp;<img src="../../images/dobs.gif" border="0"></a></td>
					<%Else%>
						<td><%= ShopOrderTransActionValue %><a target="dibs_admin" href="http://payment.architrade.com/admin/">&nbsp;&nbsp;<img src="../../images/dibs.gif" border="0"></a></td>
					<%End If%>
				</tr>	
			<%ElseIf ShopOrderStatus = "4" Then  ' V2 ordre (onlinebetaling / MD5 fejl)%>
				<tr>
					<td><%=Translate.Translate("Transactions ID")%></td>
					<td><%=Translate.Translate("Betaling fejlede med DIBS pga. MD5 fejl")%>&nbsp;&nbsp;<img src="../../images/Icons/stop.gif" width="14" height="16" align="absmiddle"></td>
				</tr>	
			<%End If%>

			<tr>
				<td><%=Translate.Translate("Dato")%></td>
				<td><%=Dates.ShowDate(CDate(ShopOrderDate), Dates.Dateformat.Short, True)%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Ændret")%></td>
				<td><%=Dates.ShowDate(CDate(ShopOrderModified), Dates.Dateformat.Short, True)%></td>
			</tr>
			<%If ShopOrderCurrencyName <> "" And Base.HasVersion("18.5.1.0") Then%>
			<tr>
				<td>&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Valuta")%></td>
				<td><%=ShopOrderCurrencyName & "(" & ShopOrderCurrencyCharacter & ")"%></td>
			</tr>	
			<tr>
				<td><%=Translate.Translate("Kurs")%></td>
				<td>
					<%=ShopOrderCurrencyRate%>
				</td>
			</tr>

			<tr>
				<td></td>
				<td>
					<%If Not IsNothing(Request.QueryString("CurrencyID")) Then%>
						<input type="Button" onclick="location='Order_Edit.aspx?ID=<%=Request.QueryString("ID")%>'" style="Cursor: Hand;" value="<%=Translate.Translate("Vis i standardkurs")%>" id="Button1" name="Button1">
					<%Else%>
						<input type="Button" onclick="location='Order_Edit.aspx?ID=<%=Request.QueryString("ID")%>&CurrencyID=<%=ShopOrderCurrencyID%>'" style="Cursor: Hand;" value="<%=Translate.Translate("Vis i købskurs")%>" id="Button2" name="Button2">
					<%End If%>
				</td>
			</tr>

			<%End If%>			
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Kunde"))%>
		<table cellpadding=2 cellspacing=0 id="Table1">
			<%=WriteLine(ShopOrderCustomerCompany, Translate.Translate("Firma"))%>
			<%=WriteLine(ShopOrderCustomerName, Translate.Translate("Navn"))%>
			<%=WriteLine(ShopOrderCustomerAddress, Translate.Translate("Adresse"))%>
			<%=WriteLine(ShopOrderCustomerAddress2, "")%>
			<%=WriteLine(ShopOrderCustomerZip & " " & ShopOrderCustomerCity, Translate.Translate("Postnr. og by"))%>
			<%=WriteLine(ShopOrderCustomerCountry, Translate.Translate("Land"))%>
			<%=WriteLine(ShopOrderCustomerEmail, Translate.Translate("E-mail"))%>
			<tr>
				<td>&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Kommentar")%></td>
				<td><textarea name=ShopOrderComment class="std" style="width:400px;height:100px;"><%=ShopOrderComment%></textarea></td>
			</tr>
			<%If ShopOrderComment2 <> "" Then%>
			<tr>
				<td></td>
				<td><textarea name=ShopOrderComment2 class="std" style="width:400px;height:50px;"><%=ShopOrderComment2%></textarea></td>
			</tr>
			<%End If%>
			<%If ShopOrderComment3 <> "" Then%>
			<tr>
				<td></td>
				<td><textarea name=ShopOrderComment3 class="std" style="width:400px;height:50px;"><%=ShopOrderComment3%></textarea></td>
			</tr>
			<%End If%>
			<%If ShopOrderComment4 <> "" Then%>
			<tr>
				<td></td>
				<td><textarea name=ShopOrderComment4 class="std" style="width:400px;height:50px;"><%=ShopOrderComment4%></textarea></td>
			</tr>
			<%End If%>
		</table>
		<%=Gui.GroupBoxEnd%>
		
		<%=Gui.GroupBoxStart(Translate.Translate("Ordrelinier"))%>
		<table cellpadding=0 cellspacing=0 width=100% border=0>
			<tr>
				<td><b><%=Translate.Translate("Vare")%></b></td>
				<td width="50" align=right><b><%=Translate.Translate("Antal")%></b></td>
				<td width="100" align=right><b><%=Translate.Translate("Pris")%></b></td>
				<td width="100" align=right><b><%=Translate.Translate("Total")%></b></td>
			</tr>
			<%

			SQL = "SELECT * FROM ShopOrderLine WHERE ShopOrderLineOrderID = " & ShopOrderID
			sCmdShop.CommandText = sql

			Dim OrderLineReader As IDataReader = sCmdShop.ExecuteReader()
			Dim opShopOrderLineProductName As Integer = OrderLineReader.getordinal("ShopOrderLineProductName")
			Dim opShopOrderLineProductNumber As Integer = OrderLineReader.getordinal("ShopOrderLineProductNumber")
			Dim opShopOrderLineProductAmount As Integer = OrderLineReader.getordinal("ShopOrderLineProductAmount")
			Dim opShopOrderLineProductPrice As Integer = OrderLineReader.getordinal("ShopOrderLineProductPrice")
			Dim opShopOrderLineID As Integer = OrderLineReader.getordinal("ShopOrderLineID")
			Dim opShopOrderLineComment1 As Integer = OrderLineReader.getordinal("ShopOrderLineComment1")
			Dim opShopOrderLineComment2 As Integer = OrderLineReader.getordinal("ShopOrderLineComment2")

			TotalPrice = 0
			blnHasRows = False
			
			Do While OrderLineReader.Read
				Response.Write("<tr height=20>")
				Response.Write("	<td>" & OrderLineReader(opShopOrderLineProductName) & " (" & OrderLineReader(opShopOrderLineProductNumber) & ")</td>")
				Response.Write("	<td align=right><input style=""width:40px;text-align:right;"" width=4 size=""5"" maxlength=""10"" class=""std"" type=""text"" name=""ShopOrderLineProductAmount" & OrderLineReader(opShopOrderLineID) & """ value=" & OrderLineReader(opShopOrderLineProductAmount) & "></td>")
				If Not IsNothing(Request.QueryString("CurrencyID")) Then
					Response.Write("	<td align=right><input onchange=""JavaScript:CheckPrice(this);"" style=""width:80px;text-align:right;"" width=4 size=""5"" maxlength=""10"" class=""std"" type=""text"" name=""ShopOrderLineProductPrice" & OrderLineReader(opShopOrderLineID) & """ value=" & Base.Currency(OrderLineReader(opShopOrderLineProductPrice), ShopOrderCurrencyRate, "", "") & "></td>")
				Else
					Response.Write("	<td align=right><input onchange=""JavaScript:CheckPrice(this);"" style=""width:80px;text-align:right;"" width=4 size=""5"" maxlength=""10"" class=""std"" type=""text"" name=""ShopOrderLineProductPrice" & OrderLineReader(opShopOrderLineID) & """ value=" & FormatNumber(base.ChkDouble(OrderLineReader(opShopOrderLineProductPrice)), 2) & "></td>")
				End If
				
				If Not IsNothing(Request.QueryString("CurrencyID")) Then
					Response.Write("	<td align=right>" & Base.Currency(OrderLineReader(opShopOrderLineProductAmount) * OrderLineReader(opShopOrderLineProductPrice), ShopOrderCurrencyRate, "", "") & "</td>")
				Else
					Response.Write("	<td align=right>" & FormatNumber(base.ChkDouble(OrderLineReader(opShopOrderLineProductAmount)) * base.ChkDouble(OrderLineReader(opShopOrderLineProductPrice)), 2) & "</td>")
				End If
				Response.Write("</tr>")
				If Base.ChkString(OrderLineReader(opShopOrderLineComment1)) <> "" Then
					Response.Write("<tr height=20>")
					Response.Write("	<td>1) <i>" & OrderLineReader(opShopOrderLineComment1) & "</i></td>")
					Response.Write("</tr>")
				End If
				If Base.ChkString(OrderLineReader(opShopOrderLineComment2)) <> "" Then
					Response.Write("<tr height=20>")
					Response.Write("	<td>2 <i>" & OrderLineReader(opShopOrderLineComment2) & "</i></td>")
					Response.Write("</tr>")
				End If

				TotalPrice = TotalPrice + (OrderLineReader(opShopOrderLineProductAmount) * OrderLineReader(opShopOrderLineProductPrice))
				Response.Write("<tr>")
				Response.Write("	<td colspan=5 bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1></td>")
				Response.Write("</tr>")

				blnHasRows = True
			Loop 

			If Not blnHasRows Then
				Response.Write("<tr><td colspan=5>" & Translate.Translate("Ingen ordrelinier") & "</td></tr>")
			End If

			Response.Write("<tr height=20>")
			Response.Write("	<td colspan=3><b>" & Translate.Translate("Levering") & " (" & ShopDeliveryName & ")</b></td>")
			Response.Write("	<td align=right>" & strShopOrderDeliveryFee & "</td>")
			Response.Write("</tr>")
			TotalPrice = CDbl(Base.ChkDouble(TotalPrice)) + Base.ChkDouble(ShopOrderDeliveryFee)
			If Not IsNothing(Request.QueryString("CurrencyID")) Then
				strTotalPrice = Base.Currency(TotalPrice, ShopOrderCurrencyRate, "", "")
			Else
				strTotalPrice = FormatNumber(TotalPrice, 2)
			End If
			Response.Write("<tr height=20>")
			Response.Write("	<td colspan=3><b>" & Translate.Translate("Betaling") & " (" & ShopPaymentName & ")</b></td>")
			Response.Write("	<td align=right>" & strShopOrderPaymentFee & "</td>")
			Response.Write("</tr>")
			TotalPrice = CDbl(Base.ChkDouble(TotalPrice)) + Base.ChkDouble(ShopOrderPaymentFee)
			If Not IsNothing(Request.QueryString("CurrencyID")) Then
				strTotalPrice = Base.Currency(TotalPrice, ShopOrderCurrencyRate, "", "")
			Else
				strTotalPrice = FormatNumber(Base.ChkDouble(TotalPrice), 2)
			End If

			If Base.GetGs("/Globalsettings/Modules/Cart/VAT") = "True" Then
				dblVatOfTotalPrice = TotalPrice * 0.25
				dblTotalInclVat = TotalPrice + dblVatOfTotalPrice
				
				If Not IsNothing(Request.QueryString("CurrencyID")) Then
					strVatOfTotalPrice = Base.Currency(dblVatOfTotalPrice, ShopOrderCurrencyRate, "", "")
					strTotalInclVat = Base.Currency(dblTotalInclVat, ShopOrderCurrencyRate, "", "")
				Else
					strVatOfTotalPrice = FormatNumber(dblVatOfTotalPrice, 2)
					strTotalInclVat = FormatNumber(dblTotalInclVat, 2)
				End If
				
				Response.Write("<tr height=20>")
				Response.Write("	<td colspan=3><strong>" & Translate.Translate("Subtotal") & "</strong></td>")
				Response.Write("	<td align=right>" & strTotalPrice & "</td>")
				Response.Write("</tr>")
				Response.Write("<tr height=20>")
				Response.Write("	<td colspan=3><strong>" & Translate.Translate("Moms") & "</strong></td>")
				Response.Write("	<td align=right>" & strVatOfTotalPrice & "</td>")
				Response.Write("</tr>")
				Response.Write("<tr height=20>")
				Response.Write("	<td colspan=3><strong>" & Translate.Translate("Total") & "</strong></td>")
				Response.Write("	<td align=right>" & strTotalInclVat & "</td>")
				Response.Write("</tr>")
			Else
				Response.Write("<tr height=20>")
				Response.Write("	<td colspan=3><strong>" & Translate.Translate("Total") & "</strong></td>")
				Response.Write("	<td align=right>" & strTotalPrice & "</td>")
				Response.Write("</tr>")
			End If
			%>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<div id="Tab2" style="display:none;">
		<br>
		<%=Gui.GroupBoxStart(Translate.Translate("Kundeoplysninger"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Kundenummer")%></td>
				<td><input type="text" name="ShopOrderCustomerNumber" size="30" maxlength="255" value="<%=ShopOrderCustomerNumber%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Firmanavn")%></td>
				<td><input type="text" name="ShopOrderCustomerCompany" size="30" maxlength="255" value="<%=ShopOrderCustomerCompany%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Navn")%></td>
				<td><input type="text" name="ShopOrderCustomerName" size="30" maxlength="255" value="<%=ShopOrderCustomerName%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Adresse")%></td>
				<td><input type="text" name="ShopOrderCustomerAddress" size="30" maxlength="255" value="<%=ShopOrderCustomerAddress%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Adresse2")%></td>
				<td><input type="text" name="ShopOrderCustomerAddress2" size="30" maxlength="255" value="<%=ShopOrderCustomerAddress2%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Postnummer")%></td>
				<td><input type="text" name="ShopOrderCustomerZip" size="30" maxlength="255" value="<%=ShopOrderCustomerZip%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("By")%></td>
				<td><input type="text" name="ShopOrderCustomerCity" size="30" maxlength="255" value="<%=ShopOrderCustomerCity%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Land")%></td>
				<td><input type="text" name="ShopOrderCustomerCountry" size="30" maxlength="255" value="<%=ShopOrderCustomerCountry%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Telefon")%></td>
				<td><input type="text" name="ShopOrderCustomerPhone" size="30" maxlength="255" value="<%=ShopOrderCustomerPhone%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Mobil")%></td>
				<td><input type="text" name="ShopOrderCustomerCell" size="30" maxlength="255" value="<%=ShopOrderCustomerCell%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fax")%></td>
				<td><input type="text" name="ShopOrderCustomerFax" size="30" maxlength="255" value="<%=ShopOrderCustomerFax%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mail")%></td>
				<td><input type="text" name="ShopOrderCustomerEmail" size="30" maxlength="255" value="<%=ShopOrderCustomerEmail%>" class=std></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		<div id="Tab3" style="display:none;">
		<br>
		<%=Gui.GroupBoxStart(Translate.Translate("Levering"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Firmanavn")%></td>
				<td><input type="text" name="ShopOrderDeliveryCompany" size="30" maxlength="255" value="<%=ShopOrderDeliveryCompany%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Navn")%></td>
				<td><input type="text" name="ShopOrderDeliveryName" size="30" maxlength="255" value="<%=ShopOrderDeliveryName%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Adresse")%></td>
				<td><input type="text" name="ShopOrderDeliveryAddress" size="30" maxlength="255" value="<%=ShopOrderDeliveryAddress%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Adresse2")%></td>
				<td><input type="text" name="ShopOrderDeliveryAddress2" size="30" maxlength="255" value="<%=ShopOrderDeliveryAddress2%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Postnummer")%></td>
				<td><input type="text" name="ShopOrderDeliveryZip" size="30" maxlength="255" value="<%=ShopOrderDeliveryZip%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("By")%></td>
				<td><input type="text" name="ShopOrderDeliveryCity" size="30" maxlength="255" value="<%=ShopOrderDeliveryCity%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Land")%></td>
				<td><input type="text" name="ShopOrderDeliveryCountry" size="30" maxlength="255" value="<%=ShopOrderDeliveryCountry%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Telefon")%></td>
				<td><input type="text" name="ShopOrderDeliveryPhone" size="30" maxlength="255" value="<%=ShopOrderDeliveryPhone%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Mobil")%></td>
				<td><input type="text" name="ShopOrderDeliveryCell" size="30" maxlength="255" value="<%=ShopOrderDeliveryCell%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fax")%></td>
				<td><input type="text" name="ShopOrderDeliveryFax" size="30" maxlength="255" value="<%=ShopOrderDeliveryFax%>" class=std></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("E-mail")%></td>
				<td><input type="text" name="ShopOrderDeliveryEmail" size="30" maxlength="255" value="<%=ShopOrderDeliveryEmail%>" class=std></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td><%=Gui.Button(Translate.Translate("OK"), "Send('Order_save.aspx');", 0)%> </td>
					<td width=5></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Order_List.aspx';", 0)%></td>
					<td width=7></td>
				</tr>
				<tr height=5>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<%=Gui.SelectTab()%>
<%ShopConn.Dispose%>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>