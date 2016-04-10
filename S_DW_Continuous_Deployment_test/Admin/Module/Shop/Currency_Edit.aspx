<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim ShopCurrencyImage As String
Dim ShopCurrencyID As Integer
Dim ShopCurrencyCharacter As String
Dim ShopCurrencyName As String
Dim ShopCurrencyDefault As String
Dim sql As String
Dim ShopCurrencyActive As String
Dim ShopCurrencyRate As String
Dim ShopCurrencyDIBSAccount As String
Dim ShopCurrencyDIBSLanguageID As String
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
	if (document.getElementById('ShopCurrency').ShopCurrencyName.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en v�rdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
		document.getElementById('ShopCurrency').ShopCurrencyName.focus();
	}else if (document.getElementById('ShopCurrency').ShopCurrencyCharacter.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en v�rdi i: %%", "%%", Translate.JsTranslate("Enhed"))%>");
		document.getElementById('ShopCurrency').ShopCurrencyCharacter.focus()
	}else if (document.getElementById('ShopCurrency').ShopCurrencyRate.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en v�rdi i: %%", "%%", Translate.JsTranslate("Kurs"))%>");
		document.getElementById('ShopCurrency').ShopCurrencyRate.focus()
	}else if(!chkInt(document.getElementById('ShopCurrency').ShopCurrencyRate.value)){
		alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Kurs"))%>");
		document.getElementById('ShopCurrency').ShopCurrencyRate.focus()
	}else{
		document.getElementById('ShopCurrency').action = FileToHandle;
		document.getElementById('ShopCurrency').submit();
	}
}
</script>
</HEAD>
<%
Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand
Dim ShopConnLanguage As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShopLanguage As IDbCommand = ShopConnLanguage.CreateCommand

If IsNothing(Request.QueryString("ID")) Then
	ShopCurrencyID = 0
	ShopCurrencyName = ""
	ShopCurrencyDefault = "0"
	ShopCurrencyActive = "1"
Else
	ShopCurrencyID = Request.QueryString("ID")
	
	sql = "SELECT * FROM ShopCurrency WHERE ShopCurrencyID = " & ShopCurrencyID
	sCmdShop.CommandText = sql

	Dim CurrencyReader As IDataReader = sCmdShop.ExecuteReader()

	Dim opShopCurrencyName As Integer = CurrencyReader.getordinal("ShopCurrencyName")
	Dim opShopCurrencyRate As Integer = CurrencyReader.getordinal("ShopCurrencyRate")
	Dim opShopCurrencyCharacter As Integer = CurrencyReader.getordinal("ShopCurrencyCharacter")
	Dim opShopCurrencyImage As Integer = CurrencyReader.getordinal("ShopCurrencyImage")
	Dim opShopCurrencyDefault As Integer = CurrencyReader.getordinal("ShopCurrencyDefault")
	Dim opShopCurrencyDIBSAccount As Integer = CurrencyReader.getordinal("ShopCurrencyDIBSAccount")
	Dim opShopCurrencyDIBSLanguageID As Integer = CurrencyReader.getordinal("ShopCurrencyDIBSLanguageID")

	If CurrencyReader.Read Then
		ShopCurrencyName = CurrencyReader(opShopCurrencyName).ToString
		ShopCurrencyRate = CurrencyReader(opShopCurrencyRate).ToString
		ShopCurrencyCharacter = CurrencyReader(opShopCurrencyCharacter).ToString
		ShopCurrencyImage = CurrencyReader(opShopCurrencyImage).ToString
		ShopCurrencyDefault = CurrencyReader(opShopCurrencyDefault).ToString
		ShopCurrencyDIBSAccount = CurrencyReader(opShopCurrencyDIBSAccount).ToString
		ShopCurrencyDIBSLanguageID = CurrencyReader(opShopCurrencyDIBSLanguageID).ToString		
	End If
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("valuta")), Translate.Translate("Valuta"), "all")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable>
	<tr>
		<td valign=top>
		<form name="ShopCurrency" id="ShopCurrency" method="Post">
		<input type="hidden" name="ShopCurrencyID" value="<%=ShopCurrencyID%>">
		<div ID="Tab1" STYLE="display:;">
		<br>
		<table border="0" cellpadding="0" width=598>
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
					<table cellpadding=2 cellspacing=0>
						<tr>
							<td width=170><%=Translate.Translate("Navn")%></td>
							<td><input type="text" name="ShopCurrencyName" size="30" maxlength="255" value="<%=Server.HtmlEncode(ShopCurrencyName)%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Kurs")%></td>
							<td><input type="text" name="ShopCurrencyRate" size="30" maxlength="255" value="<%=ShopCurrencyRate%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Enhed")%></td>
							<td><input type="text" name="ShopCurrencyCharacter" size="30" maxlength="3" value="<%=Server.HtmlEncode(ShopCurrencyCharacter)%>" class=std></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Standard")%></td>
							<td><%=Gui.CheckBox(ShopCurrencyDefault, "ShopCurrencyDefault")%></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Billede")%></td>
							<td><%= Gui.FileManager(ShopCurrencyImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ShopCurrencyImage")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%If Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/MerchantID") <> "" OR Base.GetGs("/Globalsettings/Modules/Paygate/DOBS/MerchantID") <> "" Then%>
						<%If Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/MerchantID") <> "" Then%>
							<%=Gui.GroupBoxStart(Translate.Translate("DIBS"))%>
						<%Else%>
							<%=Gui.GroupBoxStart(Translate.Translate("ePay"))%>
						<%End If%>
						<table cellpadding=2 cellspacing=0>
								<tr>
									<%If Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/MerchantID") <> "" Then%>
										<td width=170><%=Translate.Translate("Konto")%></td>
									<%Else%>
										<td width=170><%=Translate.Translate("Gruppe")%></td>
									<%End If%>
									<td><input type="text" name="ShopCurrencyDIBSAccount" size="30" value="<%=ShopCurrencyDIBSAccount%>" class=std></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Sprog")%></td>
									<td>

									<%If Base.GetGs("/Globalsettings/Modules/Paygate/DIBS/MerchantID") <> "" Then

										SQL = "SELECT * FROM ShopLanguage"
										sCmdShopLanguage.CommandText = sql
										Dim drShopLanguage As IDataReader = sCmdShopLanguage.ExecuteReader()
										%>
										<select name="ShopCurrencyDIBSLanguageID" class=std>
											<option value=""><%=Translate.Translate("Intet valgt")%></option>
											<%Do While drShopLanguage.Read%>
												<option value="<%=drShopLanguage("ShopLanguageID").ToString%>"<%=IIf(ShopCurrencyDIBSLanguageID = drShopLanguage("ShopLanguageID").ToString, " SELECTED", "")%>><%=Translate.Translate(drShopLanguage("ShopLanguageText").ToString)%></option>
											<%Loop%>
										</select>
										<%drShopLanguage.Close%>
										<%drShopLanguage.Dispose%>

									<%Else%>

										<select name="ShopCurrencyDIBSLanguageID" class=std>
											<option value=""><%=Translate.Translate("Intet valgt")%></option>
											<option value="1"<%=IIf("1" = ShopCurrencyDIBSLanguageID, " SELECTED", "")%>><%=Translate.Translate("Dansk")%></option>
											<option value="2"<%=IIf("2" = ShopCurrencyDIBSLanguageID, " SELECTED", "")%>><%=Translate.Translate("Engelsk")%></option>
											<option value="3"<%=IIf("3" = ShopCurrencyDIBSLanguageID, " SELECTED", "")%>><%=Translate.Translate("Svensk")%></option>
											<option value="4"<%=IIf("4" = ShopCurrencyDIBSLanguageID, " SELECTED", "")%>><%=Translate.Translate("Norsk")%></option>
										</select>

									<%End If%>

									</td>
								</tr>
							</table>
						<%=Gui.GroupBoxEnd%>
					<%End If%>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right">
			<%=gui.MakeOkCancelHelp("Send('Currency_save.aspx');", "location='Currency_List.aspx';", True, "modules.shop.general.currency.list.item.edit", "Currency_Payment")%>
		</td>
	</tr>
</table>
</form>
<%=Gui.SelectTab()%>
<%
sCmdShopLanguage.Dispose
sCmdShop.Dispose
ShopConn.Close
ShopConn.Dispose
ShopConnLanguage.Close
ShopConnLanguage.Dispose
%>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>