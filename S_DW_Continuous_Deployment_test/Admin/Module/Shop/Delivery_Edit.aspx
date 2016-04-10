<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim ShopDeliveryMaxTotal As Object
Dim ShopDeliveryDefault As Object
Dim ShopDeliveryActive As Object
Dim ShopDeliveryID As Object
Dim sql As String
Dim ShopDeliveryPrice As Object
Dim ShopDeliveryName As Object
Dim ShopDeliveryPrice2 As Object
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

	var form = document.forms["ShopDelivery"];
	var price = form.elements["ShopDeliveryPrice"];
	var limit = form.elements["ShopDeliveryMaxTotal"];
	var limitExceeding = form.elements["ShopDeliveryPrice2"];
	
	if (document.getElementById('ShopDelivery').ShopDeliveryName.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		}
	else if (price.value == "")
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
		document.getElementById('ShopDelivery').action = FileToHandle;
		document.getElementById('ShopDelivery').submit();
	}
}
</script>
</HEAD>
<%
If IsNothing(Request.QueryString("ID")) Then
	ShopDeliveryID = 0
	ShopDeliveryName = ""
	ShopDeliveryDefault = "0"
	ShopDeliveryActive = "1"
Else

	ShopDeliveryID = Request.QueryString.Item("ID")

	Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
	Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

	sql = "SELECT * FROM ShopDelivery WHERE ShopDeliveryID = " & ShopDeliveryID
	sCmdShop.CommandText = sql

	Dim DeliveryReader As IDataReader = sCmdShop.ExecuteReader()

	Dim opShopDeliveryName As Integer = DeliveryReader.getordinal("ShopDeliveryName")
	Dim opShopDeliveryPrice As Integer = DeliveryReader.getordinal("ShopDeliveryPrice")
	Dim opShopDeliveryDefault As Integer = DeliveryReader.getordinal("ShopDeliveryDefault")
	Dim opShopDeliveryPrice2 As Integer = DeliveryReader.getordinal("ShopDeliveryPrice2")
	Dim opShopDeliveryMaxTotal As Integer = DeliveryReader.getordinal("ShopDeliveryMaxTotal")
	Dim opShopDeliveryActive As Integer = DeliveryReader.getordinal("ShopDeliveryActive")

	If DeliveryReader.Read Then
		ShopDeliveryName = DeliveryReader(opShopDeliveryName).ToString
		ShopDeliveryPrice = DeliveryReader(opShopDeliveryPrice).ToString
		ShopDeliveryDefault = DeliveryReader(opShopDeliveryDefault).ToString
		ShopDeliveryPrice2 = DeliveryReader(opShopDeliveryPrice2).ToString
		ShopDeliveryMaxTotal = DeliveryReader(opShopDeliveryMaxTotal).ToString
		ShopDeliveryActive = DeliveryReader(opShopDeliveryActive).ToString
	End If
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("leveringsmetode")), Translate.Translate("Levering"), "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
	<tr>
		<td valign=top>
		<form name="ShopDelivery" id="ShopDelivery" method="Post">
		<input type="hidden" name="ShopDeliveryID" value="<%=ShopDeliveryID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="ShopDeliveryName" size="30" maxlength="255" value="<%=ShopDeliveryName%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Pris")%></td>
							<td><input type="text" name="ShopDeliveryPrice" size="30" maxlength="255" value="<%=ShopDeliveryPrice%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Standard")%></td>
							<td><%=Gui.CheckBox(ShopDeliveryDefault, "ShopDeliveryDefault")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Aktiv")%></td>
							<td><%=Gui.CheckBox(ShopDeliveryActive, "ShopDeliveryActive")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Ordre grænse")%></td>
							<td><input type="text" name="ShopDeliveryMaxTotal" size="30" maxlength="255" value="<%=ShopDeliveryMaxTotal%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Pris ved køb over ordre grænse")%></td>
							<td><input type="text" name="ShopDeliveryPrice2" size="30" maxlength="255" value="<%=ShopDeliveryPrice2%>" class=std></td>
						</tr>
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
			<%=gui.MakeOkCancelHelp("Send('Delivery_save.aspx');", "location='Delivery_List.aspx';", True, "modules.shop.general.delivery.list.item.edit", "Shop_Delivery")%>
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