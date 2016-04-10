<%@ Page Language="vb" AutoEventWireup="false" LCID=1030 UICulture="da-DK" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim i As Byte
Dim ID As Integer
Dim sql As String
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
<%=Gui.MakeHeaders(Translate.Translate("Betaling"), Translate.Translate("Betaling"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:;width:598;">
			<table border="0" cellpadding="0" width="598">
				<%
				Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
				Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

				sql = "SELECT * FROM ShopPayment ORDER BY ShopPaymentName"

				sCmdShop.CommandText = sql

				Dim PaymentReader As IDataReader = sCmdShop.ExecuteReader()

				Dim opShopPaymentID As Integer = PaymentReader.getordinal("ShopPaymentID")
				Dim opShopPaymentName As Integer = PaymentReader.getordinal("ShopPaymentName")
				Dim opShopPaymentPrice As Integer = PaymentReader.getordinal("ShopPaymentPrice")
				Dim opShopPaymentDefault As Integer = PaymentReader.getordinal("ShopPaymentDefault")

				Dim blnHasRows = False
				i = 0
				
				Do While PaymentReader.Read
					i = i + 1

					If i = 1 Then 
					%>
						<tr>
							<td><img src="../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Navn")%></strong></td>
							<td width="150"><strong><%=Translate.Translate("Pris")%></strong></td>
							<td width="50"><strong><%=Translate.Translate("Standard")%></strong></td>
							<td width="30" align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
						</tr>
					<%	
					End If
					%>

					<TR>
						<td><a href="Payment_Edit.aspx?ID=<%=PaymentReader(opShopPaymentID)%>"><img src="../../images/icons/Page_closed.gif" border="0" align=absmiddle>&nbsp;<%=PaymentReader(opShopPaymentName)%></a></td>
						<td><%=PaymentReader(opShopPaymentPrice)%></td>
						<td align="center">
						<%		
						If PaymentReader(opShopPaymentDefault) Then
							Response.Write("<img src=""../../images/Check.gif"">")
						End If
						%>
						</td>
						<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("betalingsmetode")) & "\n(" & Base.JSEnable(Server.HtmlEncode(PaymentReader(opShopPaymentName))) &")"%>')){location='Payment_Delete.aspx?ID=<%=PaymentReader(opShopPaymentID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet betalingsmetode")%>"></a></td>
					</TR>
					<tr>
						<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<%		
					blnHasRows = True 			
				Loop 

				If Not blnHasRows Then  'There are no fields%>
					<tr>
						<td><strong><br>&nbsp;<%=Translate.Translate("Ingen betalingsmetoder")%></strong></td>
					</tr>
				<%End If%>
			</TABLE>
			</div>
		</td>
	</tr>
	<tr>
		<td align=right valign=bottom id=functionsbutton>
			<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("Ny betalingsmetode"), "location='Payment_edit.aspx';", 100)%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>