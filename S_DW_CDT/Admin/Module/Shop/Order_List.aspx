<%@ Page Language="vb" AutoEventWireup="false" LCID=1030 UICulture="da-DK"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List orders
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim intOrderTotal As Decimal
Dim SQL As String
Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

Dim TS As Date
Dim ShopOrderDateTimeFrom As String

'If Request.QueryString("Archive") = "True" And Request.Querystring("ShopOrderDateTimeFrom") <> "" Then
If Request.Querystring("ShopOrderDateTimeFrom") <> "" Then
	ShopOrderDateTimeFrom = Request.Querystring("ShopOrderDateTimeFrom")
Else
	ShopOrderDateTimeFrom = Dates.ParseDate("ShopOrderDateTimeFrom")
End If

If ShopOrderDateTimeFrom = "" Then
	TS = DateAdd(Microsoft.VisualBasic.DateInterval.Month, -1, CDate(Dates.DWNow))
	ShopOrderDateTimeFrom = Year(TS) & "-" & Month(TS) & "-01 00:00:00"
End If


Dim ShopOrderDateTimeTo As String

'If Request.QueryString("Archive") = "True" And Request.Querystring("ShopOrderDateTimeFrom") <> "" Then
If Request.Querystring("ShopOrderDateTimeTo") <> "" Then
	ShopOrderDateTimeTo = Request.Querystring("ShopOrderDateTimeTo")
Else
	ShopOrderDateTimeTo = Dates.ParseDate("ShopOrderDateTimeTo")
End If

If ShopOrderDateTimeTo = "" Then
	TS = DateAdd(Microsoft.VisualBasic.DateInterval.Day, 0, CDate(Dates.DWNow))
	ShopOrderDateTimeTo = Year(TS) & "-" & Month(TS) & "-" & Day(TS) & " 23:59:59"
	'ShopOrderDateTimeTo = Dates.DWNow
End If

If Not IsNothing(Request.QueryString("TicketID")) Then
	sql = "UPDATE ShopOrder SET ShopOrderTransActionStatus = 1 WHERE ShopOrderTransActionValue = '" & Request.QueryString("TicketID") & "'"
	sCmdShop.CommandText = sql
	sCmdShop.ExecuteNonQuery()
End If
%>

<HTML>
<HEAD>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<SCRIPT LANGUAGE="javascript">
	<!--
		function ShopRequestAmount(TransactionID) {
			var ThisLocation	= "";
			ThisLocation		= "<%=Server.URLEncode("http://" & Request.ServerVariables("HTTP_HOST") & Base.GetHttpUrl(False, True))%>";
			DWPayment			= window.open("https://secure.dynamicsystems.dk/dwpayment.asp?TicketID=" + TransactionID + "&ref=" + ThisLocation, "DWPayment", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=300,height=300");
			DWPayment.focus();
		}
	//-->
	</SCRIPT>
</HEAD>

<script>
function downloadXLSExport(){
	if(location.search.indexOf('Export=True') > 0){
		document.frames.dl.location = '/Admin/Public/download.aspx?File=<%="/Files/OrderExport.csv"%>';
	}
}
</script>

<body onLoad="setTimeout('downloadXLSExport();', 500);">
<iframe name=dl src="about:blank" style="display:none;"></iframe>
<!--
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="590" align=right><img src="../../Images/ext/xls.gif" alt="<%=Translate.JSTranslate("Eksporter")%>" width="22" height="18" border="0" style="cursor:pointer;" onClick="javascript:location='Order_Export.aspx?Archive=<%=Request.QueryString("Archive")%>';"></td>
	</tr>
</table>
-->
<%
If Request.QueryString("Archive") = "True" Then%>
	<%=Gui.MakeHeaders(Translate.Translate("Ordrearkiv"), Translate.Translate("Ordrer"), "all")%>
<%Else%>
	<%=Gui.MakeHeaders(Translate.Translate("Aktive ordrer"), Translate.Translate("Ordrer"), "all")%>
<%End If%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign=top>
			<br>
			<div ID="Div2" STYLE="display:;">

			<%'If Request.QueryString("Archive") = "True" Then%>
				<%=Gui.GroupBoxStart(Translate.Translate("Datointerval"))%>
				<Table BORDER="0" CELLPADDING="0" width="100%">
					<form name="orderlist" action="Order_List.aspx" method="get">
						<input type="hidden" name="Archive" value="<%If Request("Archive") = "True" Then%>True<%End If%>">
						<tr>
							<td width="65%">
								<table border="0" width="100%">
									<tr>
										<td width="150">&nbsp;<%=Translate.Translate("Fra dato")%></td>
										<td><%=Dates.DateSelect(ShopOrderDateTimeFrom, False, True, True, "ShopOrderDateTimeFrom")%></td>
									</tr>
									<tr>
										<td width="150">&nbsp;<%=Translate.Translate("Til dato")%></td>
										<td><%=Dates.DateSelect(ShopOrderDateTimeTo, False, True, True, "ShopOrderDateTimeTo")%></td>
									</tr>
								</table>
							</td>
							<td align=left width="35%">
								<table border="0" width="100%">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td valign="bottom"><%=Gui.Button(Translate.Translate("OK"), "", 90)%></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
						</tr>
					</from>
				</Table>
				<%=Gui.GroupBoxEnd%>
			<%'End If%>

			<%=Gui.GroupBoxStart(Translate.Translate("Ordrer"))%>
			<TABLE BORDER="0" CELLPADDING="0" width="100%">
				<tr>
					<td width="60"><img src="../../images/Nothing.gif" width="20" height="1" alt="" border="0"><b><%=Translate.Translate("Nr.")%></b></td>
					<td width="120"><b><%=Translate.Translate("Dato")%></b></td>
					<td><b><%=Translate.Translate("Navn")%></b></td>
					<td width="40"><b><%=Translate.Translate("Antal")%></b></td>
					<td width="75" align="right"><b><%=Translate.Translate("Beløb")%></b></td>
					<td width=35 align="right"></td>
					<%If Request.QueryString("Archive") = "True" Then%>
						<td width=30 align="right"><b><%=Translate.Translate("Aktiver")%></b></td>
					<%Else%>
						<td width=30 align="right"><b><%=Translate.Translate("Arkiv")%></b></td>
					<%End If%>
					<td width=30 align="right"><b><%=Translate.Translate("Slet")%></b></td>
				</tr>
				<%
				If Base.GetGs("/Globalsettings/System/Database/Type") = "ms_sqlserver" Then
					SQL = "SELECT ShopOrder.ShopOrderID, ShopOrder.ShopOrderDate, ShopOrder.ShopOrderCustomerName, ShopOrder.ShopOrderTransActionValue, ShopOrder.ShopOrderTransActionType, ShopOrder.ShopOrderTransActionStatus, ShopOrder.ShopOrderStatus, "
					SQL = SQL & "((SELECT Sum(ShopOrderLine.ShopOrderLineProductAmount*ShopOrderLine.ShopOrderLineProductPrice) AS LineTotal FROM ShopOrderLine WHERE ShopOrderLine.ShopOrderLineOrderID=ShopOrder.ShopOrderID) + (Case When ShopOrder.ShopOrderPaymentFee is null Then 0 Else ShopOrder.ShopOrderPaymentFee End) + (Case When ShopOrder.ShopOrderDeliveryFee is null Then 0 Else ShopOrder.ShopOrderDeliveryFee End)) AS OrderTotal, "
					SQL = SQL & "(SELECT Sum(ShopOrderLine.ShopOrderLineProductAmount) AS SumOfShopOrderLineProductAmount FROM ShopOrderLine WHERE ShopOrderLine.ShopOrderLineOrderID=ShopOrder.ShopOrderID) AS OrderAmount "
					SQL = SQL & "FROM ShopOrder "					
				Else
					SQL = "SELECT ShopOrder.ShopOrderID, ShopOrder.ShopOrderDate, ShopOrder.ShopOrderCustomerName, ShopOrder.ShopOrderTransActionValue, ShopOrder.ShopOrderTransActionType, ShopOrder.ShopOrderTransActionStatus, ShopOrder.ShopOrderStatus, "
					SQL = SQL & "((SELECT Sum(ShopOrderLine.ShopOrderLineProductAmount*ShopOrderLine.ShopOrderLineProductPrice) AS LineTotal FROM ShopOrderLine WHERE ShopOrderLine.ShopOrderLineOrderID=ShopOrder.ShopOrderID) + ShopOrder.ShopOrderPaymentFee + ShopOrder.ShopOrderDeliveryFee) AS OrderTotal, "
					SQL = SQL & "(SELECT Sum(ShopOrderLine.ShopOrderLineProductAmount) AS SumOfShopOrderLineProductAmount FROM ShopOrderLine WHERE ShopOrderLine.ShopOrderLineOrderID=ShopOrder.ShopOrderID) AS OrderAmount "
					SQL = SQL & "FROM ShopOrder "
				End If

				If Request.QueryString("Archive") = "True" Then
					SQL = SQL & "WHERE ShopOrder.ShopOrderArchiveDate Is Not Null And (ShopOrderDeleted <> " & Database.SQLBool(1) & " Or ShopOrderDeleted Is Null) "
				Else
					SQL = SQL & "WHERE ShopOrder.ShopOrderArchiveDate Is Null And (ShopOrderDeleted <> " & Database.SQLBool(1) & " Or ShopOrderDeleted Is Null) "
				End If

				'If ShopOrderDateTimeFrom <> "" And ShopOrderDateTimeTo <> "" And Request.QueryString("Archive") = "True" Then
				If ShopOrderDateTimeFrom <> "" And ShopOrderDateTimeTo <> "" Then
					SQL = SQL & " AND (ShopOrder.ShopOrderDate BETWEEN " & Database.SqlDate(ShopOrderDateTimeFrom) & " AND " & Database.SqlDate(ShopOrderDateTimeTo) & ")"
				End If

				SQL = SQL & " ORDER BY ShopOrderDate DESC"
				sCmdShop.CommandText = sql
				Dim ShopReader As IDataReader = sCmdShop.ExecuteReader()
				Dim opOrderTotal As Integer = ShopReader.getordinal("OrderTotal")
				Dim opShopOrderID As Integer = ShopReader.getordinal("ShopOrderID")
				Dim opShopOrderDate As Integer = ShopReader.getordinal("ShopOrderDate")
				Dim opOrderAmount As Integer = ShopReader.getordinal("OrderAmount")

				Dim opShopOrderStatus As Integer = ShopReader.getordinal("ShopOrderStatus")
				Dim opShopOrderCustomerName As Integer = ShopReader.getordinal("ShopOrderCustomerName")
				Dim opShopOrderTransActionType As Integer = ShopReader.getordinal("ShopOrderTransActionType")
				Dim opShopOrderTransActionStatus As Integer = ShopReader.getordinal("ShopOrderTransActionStatus")
				Dim opShopOrderTransActionValue As Integer = ShopReader.getordinal("ShopOrderTransActionValue")

				Dim blnHasRows As Boolean = False
				Dim dblOrderListPrice As Double = 0
				Dim intOrderListAmount As Integer = 0

				Do While ShopReader.Read
					intOrderTotal = FormatNumber(Base.ChkDouble(ShopReader(opOrderTotal)), 2)
					
					If Base.GetGs("/Globalsettings/Modules/Cart/VAT") = "True" Then
						intOrderTotal = System.Math.Round(intOrderTotal * 1.25, 2)
					End If
					
					dblOrderListPrice += intOrderTotal
					If Not IsDBNull(ShopReader(opOrderAmount)) Then
						intOrderListAmount += ShopReader(opOrderAmount)
					End If
					
					Response.Write("<tr>")
					Response.Write("<td><img src=""../../images/Icons/Module_Tagwall_small.gif"" align=absmiddle border=0> " & ShopReader(opShopOrderID) & "</td>")
					Response.Write("<td><a href=""Order_Edit.aspx?ID=" & ShopReader(opShopOrderID) & """>" & Dates.ShowDate(CDate(ShopReader(opShopOrderDate)), Dates.Dateformat.Short, True) & "</a></td>")
					Response.Write("<td>" & ShopReader(opShopOrderCustomerName) & "</td>")
					Response.Write("<td align=center>" & ShopReader(opOrderAmount) & "</td>")
					Response.Write("<td align=right>" & formatnumber(intOrderTotal,2) & "</td>")
					Response.Write("<td align=center>")
					
					If IsDbNull(ShopReader(opShopOrderStatus)) Or Base.ChkNumber(ShopReader(opShopOrderStatus)) = 0 Then ' V1 ordre
						If Not ISDBNull(ShopReader(opShopOrderTransActionType)) Then
							If ShopReader(opShopOrderTransActionType) = "DWDK" And CStr(ShopReader(opShopOrderTransActionStatus) & "") = "1" Then
								Response.Write("<img border=""0"" src=""../../Images/dkgrey.gif"" align=absmiddle>")
							ElseIf ShopReader(opShopOrderTransActionType) = "DWDK" Then 
								Response.Write("<A href=""#""><img border=""0"" onClick=""javascript:ShopRequestAmount('" & ShopReader(opShopOrderTransActionValue) & "');"" src=""../../Images/DK.gif"" align=absmiddle></A>")
							ElseIf ShopReader(opShopOrderTransActionType) = "DIBSPayment" Then 
								Response.Write("<A target=""dibs_admin"" href=""http://payment.architrade.com/admin/""><IMG alt='"  & Translate.Translate("Transaction ID") & "= " & ShopReader(opShopOrderTransActionValue) & "' src=""../../images/dibs.gif"" border=""0""></A>")
							ElseIf ShopReader(opShopOrderTransActionType) = "DOBSPayment" Then 
								Response.Write("<A href=""http://www.dobs.dk/adm/login.aspx"" target=""dobs""><img border=""0"" alt='"  & Translate.Translate("Transaction ID") & ": " & ShopReader(opShopOrderTransActionValue) & "' src=""../../Images/dobs.gif"" align=absmiddle></A>")
							End If
						End If						
					ElseIf Base.ChkNumber(ShopReader(opShopOrderStatus)) = 2 Then  ' V2 ordre (onlinebetaling / ikke gennemført)
						Response.Write("<img src=""../../images/infoicon.gif"" width=""14"" height=""16"" align=""absmiddle"" alt='" & Translate.Translate("Ordre afventer betaling") & "'"">")
					ElseIf Base.ChkNumber(ShopReader(opShopOrderStatus)) = 3 Then  ' V2 ordre (onlinebetaling / gennemført)
						If ShopReader(opShopOrderTransActionType).ToString = "DOBSPayment" Then
							Response.Write("<A href=""http://www.dobs.dk/adm/login.asp"" target=""dobs""><img border=""0"" alt='"  & Translate.Translate("Transaction ID") & "= " & ShopReader(opShopOrderTransActionValue) & "' src=""../../Images/dobs.gif"" align=absmiddle></A>")
						Else
							Response.Write("<A target=""dibs_admin"" href=""http://payment.architrade.com/admin/""><IMG alt='"  & Translate.Translate("Transaction ID") & "= " & ShopReader(opShopOrderTransActionValue) & "' src=""../../images/dibs.gif"" border=""0""></A>")
						End If
					ElseIf Base.ChkNumber(ShopReader(opShopOrderStatus)) = 4 Then  ' V2 ordre (onlinebetaling / MD5 fejl)
						Response.Write("<img src=""../../images/Icons/stop.gif"" width=""14"" height=""16"" align=""absmiddle"" alt='" & Translate.Translate("Betaling fejlede med DIBS pga. MD5 fejl") & "'"">")
					End If
					
					Response.Write("</td>")
					If Request.QueryString("Archive") = "True" Then
						Response.Write("<td align=center><a href=""javascript:if(confirm('" & Translate.JSTranslate("Reaktiver ordre?")  & "\n(" & ShopReader(opShopOrderID).ToString & ")')){location='Order_Archive.aspx?ID=" & ShopReader(opShopOrderID) & "&Moveback=true&ShopOrderDateTimeFrom=" & ShopOrderDateTimeFrom & "&ShopOrderDateTimeTo=" & ShopOrderDateTimeTo & "';}""><img src=""../../images/Return.gif"" border=""0"" alt=""" & Translate.Translate("Reaktiver ordre") & """></a></td>")
					Else
						Response.Write("<td align=center><a href=""javascript:if(confirm('" & Translate.JSTranslate("Arkiver %%?", "%%", Translate.JSTranslate("ordre")) & "\n(" & ShopReader(opShopOrderID).ToString & ")')){location='Order_Archive.aspx?ID=" & ShopReader(opShopOrderID) & "&ShopOrderDateTimeFrom=" & ShopOrderDateTimeFrom & "&ShopOrderDateTimeTo=" & ShopOrderDateTimeTo & "';}""><img src=""../../images/Arkiver.gif"" border=""0"" alt=""" & Translate.Translate("Arkiver %%", "%%", Translate.JSTranslate("ordre")) & """></a></td>")
					End If
					Response.Write("<td align=right><a href=""javascript:if(confirm('" & Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("ordre")) & "\n(" & ShopReader(opShopOrderID).ToString & ")')){location='Order_Delete.aspx?ID=" & ShopReader(opShopOrderID) & "&Archive=" & Request.QueryString("Archive") & "&ShopOrderDateTimeFrom=" & ShopOrderDateTimeFrom & "&ShopOrderDateTimeTo=" & ShopOrderDateTimeTo & "';}""><img src=""../../images/Delete.gif"" border=""0"" alt=""" & Translate.Translate("Slet ordre") & """></a></td>")
					Response.Write("</tr>")
					Response.Write("<tr>")
					Response.Write("<td colspan=""8"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1></td>")
					Response.Write("</tr>")

					blnHasRows = True
				Loop 

				If Not blnHasRows Then
					Response.Write("<tr><td colspan=5><br>&nbsp;" & Translate.Translate("Ingen ordrer for perioden") & "</td></tr>")
				Else
					Response.Write("<tr></tr>")
					Response.Write("<tr>")
					Response.Write("<td></td>")
					Response.Write("<td><b>Total</b></td>")
					Response.Write("<td></td>")
					Response.Write("<td align=center><b>" & intOrderListAmount & "</b></td>")
					Response.Write("<td align=right><b>" & formatnumber(dblOrderListPrice,2) & "</b></td>")
					Response.Write("<td></td>")
					Response.Write("<td></td>")
					Response.Write("<td></td>")
					Response.Write("</tr>")
					Response.Write("<tr></tr>")
				End If				
				
				ShopReader.Dispose
				sCmdShop.Dispose
				ShopConn.Dispose
				%>
			</table>
			<%=Gui.GroupBoxEnd%>			
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align=right valign=bottom id=functionsbutton>
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td>
					<%
					If Request.QueryString("Archive") = "True" Then
						Response.Write(Gui.Button(Translate.Translate("Aktive ordrer"), "location='Order_List.aspx';", 100))
					Else
						Response.Write(Gui.Button(Translate.Translate("Ordrearkiv"), "location='Order_List.aspx?Archive=True';", 100))
					End If
					%>
					</td>
					<%=Gui.HelpButton("Shop_Order_List", "modules.shop.general.order.list",,5)%>
					<td width="5"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</HTML>
<%
Translate.GetEditOnlineScript()
%>