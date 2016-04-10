<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim ID As Integer
Dim sql As String
Dim i As Byte
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List delivery methods
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
<%=Gui.MakeHeaders(Translate.Translate("Levering"), Translate.Translate("Levering"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:;width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
			Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

			sql = "SELECT * FROM ShopDelivery ORDER BY ShopDeliveryName"
			sCmdShop.CommandText = sql

			Dim DeliveryReader As IDataReader = sCmdShop.ExecuteReader()

			Dim opShopDeliveryID As Integer = DeliveryReader.getordinal("ShopDeliveryID")
			Dim opShopDeliveryName As Integer = DeliveryReader.getordinal("ShopDeliveryName")
			Dim opShopDeliveryPrice As Integer = DeliveryReader.getordinal("ShopDeliveryPrice")
			Dim opShopDeliveryDefault As Integer = DeliveryReader.getordinal("ShopDeliveryDefault")

			Dim blnHasRows = False
			i = 0
			
			Do While DeliveryReader.Read
				i = i + 1

				If i = 1 Then
				%>
					<tr>
						<td><img src="../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Navn")%></strong></td>
						<td width="150"><strong><%=Translate.Translate("Pris")%></strong></td>
						<td width="50"><strong><%=Translate.Translate("Standard")%></strong></td>
						<td width="30" align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
				<%End If%>

				<TR>
					<td><a href="Delivery_Edit.aspx?ID=<%=DeliveryReader(opShopDeliveryID)%>"><img src="../../images/icons/Page_closed.gif" border="0" align=absmiddle>&nbsp;<%=DeliveryReader(opShopDeliveryName)%></a></td>
					<td><%=DeliveryReader(opShopDeliveryPrice)%></td>
					<td align="center">
					<%		
					If DeliveryReader(opShopDeliveryDefault) Then
						Response.Write("<img src=""../../images/Check.gif"">")
					End If
					%>
					</td>
					<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("leveringsmetode")) & "\n(" & Base.JSEnable(Server.HtmlEncode(DeliveryReader(opShopDeliveryName))) &")"%>')){location='Delivery_Delete.aspx?ID=<%=DeliveryReader(opShopDeliveryID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("leveringsmetode"))%>"></a></td>
				</TR>
				<tr>
					<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				</tr>
				<%		
				blnHasRows = True
			Loop 
			
			If Not blnHasRows Then 'There are no fields
			%>
				<tr>
					<td><strong><br>&nbsp;<%=Translate.Translate("Ingen Leveringsmetoder")%></strong></td>
				</tr>
			<%	
			End If
			i = 0
			%>
			</TABLE>
			</div>
		</td>
	</tr>
	<tr>
		<td align=right valign=bottom id=functionsbutton>
			<table>
				<tr>
					<td><%=Gui.Button(Translate.JSTranslate("Ny leveringsmetode"), "location='Delivery_edit.aspx';", 100)%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</HTML>
<%
Translate.GetEditOnlineScript()
%>