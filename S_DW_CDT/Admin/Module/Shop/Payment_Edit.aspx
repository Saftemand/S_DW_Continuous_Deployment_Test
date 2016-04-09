<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim ShopPaymentActive As Object
Dim ShopPaymentID As Object
Dim ShopPaymentSystemName As Object
Dim sql As String
Dim ShopPaymentPrice As Object
Dim ShopPaymentDefault As Object
Dim ShopPaymentMaxTotal As Object
Dim ShopPaymentPrice2 As Object
Dim ShopPaymentName As Object
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: Edit payment
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script>

function chkInt(value) {
	var rg = /[^0-9]/gi
	return !rg.test(value);
}

function Send(FileToHandle){

	var form = document.forms["ShopPayment"];
	var price = form.elements["ShopPaymentPrice"];
	var limit = form.elements["ShopPaymentMaxTotal"];
	var limitExceeding = form.elements["ShopPaymentPrice2"];
	
	if (document.getElementById('ShopPayment').ShopPaymentName.value.length < 1)
	{
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
	}
	else if (price.value.length < 1)
	{
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Pris"))%>");
		price.focus();
	}
	else if (price.value != "" && !chkInt(price.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Pris"))%>");
		price.focus();
	}
	else if (limit.value !="" && !chkInt(limit.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Ordre grænse"))%>");
		limit.focus();
	}
	else if (limitExceeding.value !="" && !chkInt(limitExceeding.value))
	{
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Pris ved køb over ordre grænse"))%>");
		limitExceeding.focus();
	}
	else
	{
		document.getElementById('ShopPayment').action = FileToHandle;
		document.getElementById('ShopPayment').submit();
	}
}
</script>
</HEAD>
<%
If IsNothing(Request.QueryString("ID")) Then
	ShopPaymentID = 0
	ShopPaymentName = ""
	ShopPaymentDefault = "0"
	ShopPaymentActive = "1"
Else

	ShopPaymentID = Request.QueryString("ID")

	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	sql = "SELECT * FROM ShopPayment WHERE ShopPaymentID = " & ShopPaymentID
	sCmdShop.CommandText = sql

	Dim PaymentReader As IDataReader = sCmdShop.ExecuteReader()

	Dim opShopPaymentName As Integer = PaymentReader.getordinal("ShopPaymentName")
	Dim opShopPaymentPrice As Integer = PaymentReader.getordinal("ShopPaymentPrice")
	Dim opShopPaymentDefault As Integer = PaymentReader.getordinal("ShopPaymentDefault")
	Dim opShopPaymentPrice2 As Integer = PaymentReader.getordinal("ShopPaymentPrice2")
	Dim opShopPaymentMaxTotal As Integer = PaymentReader.getordinal("ShopPaymentMaxTotal")
	Dim opShopPaymentActive As Integer = PaymentReader.getordinal("ShopPaymentActive")
	Dim opShopPaymentSystemName As Integer = PaymentReader.getordinal("ShopPaymentSystemName")

	If PaymentReader.Read Then
		ShopPaymentName = PaymentReader("ShopPaymentName").ToString
		ShopPaymentPrice = PaymentReader("ShopPaymentPrice").ToString
		ShopPaymentDefault = PaymentReader("ShopPaymentDefault").ToString
		ShopPaymentPrice2 = PaymentReader("ShopPaymentPrice2").ToString
		ShopPaymentMaxTotal = PaymentReader("ShopPaymentMaxTotal").ToString
		ShopPaymentActive = PaymentReader("ShopPaymentActive").ToString
		ShopPaymentSystemName = PaymentReader("ShopPaymentSystemName").ToString
	End If
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("betalingsmetode")), Translate.Translate("Betaling"), "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
	<tr>
		<td valign=top>
		<form name="ShopPayment" id="ShopPayment" method="Post">
		<input type="hidden" name="ShopPaymentID" value="<%=ShopPaymentID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="ShopPaymentName" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopPaymentName)%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Pris")%></td>
							<td><input type="text" name="ShopPaymentPrice" size="30" maxlength="255" value="<%=ShopPaymentPrice%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Standard")%></td>
							<td><%=Gui.CheckBox(ShopPaymentDefault, "ShopPaymentDefault")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Aktiv")%></td>
							<td><%=Gui.CheckBox(ShopPaymentActive, "ShopPaymentActive")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Ordre grænse")%></td>
							<td><input type="text" name="ShopPaymentMaxTotal" size="30" maxlength="255" value="<%=ShopPaymentMaxTotal%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Pris ved køb over ordre grænse")%></td>
							<td><input type="text" name="ShopPaymentPrice2" size="30" maxlength="255" value="<%=ShopPaymentPrice2%>" class=std></td>
						</tr>
						<%If Session("DW_Admin_UserID") = 1 Then%>
						<tr>
							<td><%=Translate.Translate("Betalingsgateway")%></td>
							<td>
							<select name="ShopPaymentSystemName" class=std>
								<option value="-"><%=Translate.Translate("Ingen")%></option>
								<option value="DIBSPayment"<%=IIf(ShopPaymentSystemName = "DIBSPayment", " SELECTED", "")%>>DIBS</option>
								<option value="DOBSPayment"<%=IIf(ShopPaymentSystemName = "DOBSPayment", " SELECTED", "")%>>DOBS</option>
								<option value="EPAYPayment"<%=IIf(ShopPaymentSystemName = "EPAYPayment", " SELECTED", "")%>>ePay</option>
							</select>
							</td>
						</tr>
						<%End If%>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
			<%=gui.MakeOkCancelHelp("Send('Payment_save.aspx');", "location='Payment_List.aspx';", True, "modules.shop.general.payment.list.item.edit", "Shop_Payment")%>
		</td>
	</tr>
</table>
</form>
<%=Gui.SelectTab()%>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>