<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim sql As String
Dim i As Byte
Dim ID As Integer
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List payment methods
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(request.QueryString("ID")) Then
	ID = request.QueryString("ID")
Else
	ID = 0
End If
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>
<%=Gui.MakeHeaders(Translate.Translate("Valuta"), Translate.Translate("Valuta"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:;width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
			Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

			sql = "SELECT * FROM ShopCurrency ORDER BY ShopCurrencyName"
			sCmdShop.CommandText = sql

			Dim CurrencyReader As IDataReader = sCmdShop.ExecuteReader()

			Dim opShopCurrencyID As Integer = CurrencyReader.getordinal("ShopCurrencyID")
			Dim opShopCurrencyName As Integer = CurrencyReader.getordinal("ShopCurrencyName")
			Dim opShopCurrencyRate As Integer = CurrencyReader.getordinal("ShopCurrencyRate")
			Dim opShopCurrencyCharacter As Integer = CurrencyReader.getordinal("ShopCurrencyCharacter")
			Dim opShopCurrencyDefault As Integer = CurrencyReader.getordinal("ShopCurrencyDefault")

			Dim blnHasRows = False
			Dim FirstLoop = True
			Do While CurrencyReader.Read   'Then we list the fields
				If FirstLoop Then%>
					<tr>
						<td><img src="../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Beskrivelse")%></strong></td>
						<td width="50"><strong><%=Translate.Translate("Kurs")%></strong></td>
						<td width="50"><strong><%=Translate.Translate("Enhed")%></strong></td>
						<td width="50"><strong><%=Translate.Translate("Standard")%></strong></td>
						<td width="30" align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
				<%End If
				i = i + 1
				%>
				<TR>
					<td><a href="Currency_Edit.aspx?ID=<%=CurrencyReader(opShopCurrencyID)%>"><img src="../../images/icons/Page_closed.gif" border="0" align=absmiddle>&nbsp;<%=CurrencyReader(opShopCurrencyName)%></a></td>
					<td><%=CurrencyReader(opShopCurrencyRate)%></td>
					<td><%=CurrencyReader(opShopCurrencyCharacter)%></td>
					<td align="center">
					<%		
					If CurrencyReader(opShopCurrencyDefault) Then
						Response.Write("<img src=""../../images/Check.gif"">")
					End If
					%>
					</td>
					<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("valuta")) & "\n(" & Base.JSEnable(Server.HtmlEncode(CurrencyReader(opShopCurrencyName))) &")"%>')){location='Currency_Delete.aspx?ID=<%=CurrencyReader(opShopCurrencyID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet valuta")%>"></a></td>
				</TR>
				<tr>
					<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				</tr>
				<%
				FirstLoop = False
				blnHasRows = True
			Loop 

			If Not blnHasRows Then 'There are no fields%>
				<tr>
					<td><strong><br>&nbsp;<%=Translate.Translate("Ingen valutaer")%></strong></td>
				</tr>
			<%End If

			CurrencyReader.Dispose
			sCmdShop.Dispose
			ShopConn.Dispose
			%>
			</TABLE>
			</div>
		</td>
	</tr>
	<tr>
		<td align=right valign=bottom id=functionsbutton>
			<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("Ny valuta"), "location='Currency_edit.aspx';", 100)%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</HTML>
<%
Translate.GetEditOnlineScript()
%>