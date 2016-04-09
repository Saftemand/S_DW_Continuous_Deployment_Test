<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
	Dim ID As Integer
Dim Title As String
Dim no As Integer
Dim ModuleIcon As String
Dim SqlWhere As String
Dim Action As String
Dim SqlWhereVariant As String
Dim i As Integer
Dim j As Integer
Dim sql As String
Dim style As String
Dim msg As String
Dim span As String
Dim colspnTotal As Integer = 0 
Dim inclVariant As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: List products in group
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
'################################################
'TFC 30-06-05 - Incl. variant in list 
'################################################
If Request.QueryString("inclVariant") = "yes" Then
	Session("DW_inclVariant") = "yes"
End If	
If Request.QueryString("inclVariant") = "no" Then
	Session("DW_inclVariant") = ""
End If	

Try
	inclVariant = Session("DW_inclVariant").ToString()
Catch ex As Exception
	inclVariant = ""
End Try	
'################################################ 


Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

'If Request.QueryString("inclVariant") <> "yes" Then
If inclVariant <> "yes" Then 
	SqlWhereVariant = " AND (ShopProduct.ShopProductParentID = 0 OR ShopProduct.ShopProductParentID IS NULL)"
End If

If Not IsNothing(Request.QueryString("ID")) And IsNumeric(Request.QueryString("ID")) Then
	ID = Replace(Request.QueryString("ID") & "", "@", "")
	ID = CInt(ID)
Else
	ID = 0
End If

	If ID > 0 Then
		If inclVariant = "yes" Then
			Dim FixSortSql As String = "SELECT ShopProductID from ShopProduct WHERE (ShopProductParentID=0 or ShopProductParentID is null) and ShopProductGroupID = " & ID & " order by ShopProductSort, ShopProductName"
			Dim dr As IDataReader = Database.CreateDataReader(FixSortSql, "DWShop.mdb")
			Dim sort As Integer = 1
			Do While dr.Read
				Dim prodId As Integer = Base.ChkInteger(dr.Item("ShopProductID"))
				Database.ExecuteNonQuery("update ShopProduct set ShopProductSort=" & sort & " where ShopProductID = " & prodId, "DWShop.mdb")
				sort += 1
				Dim FixSortSql2 As String = "SELECT ShopProductID from ShopProduct WHERE (ShopProductParentID=" & prodId & ") and ShopProductGroupID = " & ID & " order by ShopProductSort, ShopProductName"
				Dim dr2 As IDataReader = Database.CreateDataReader(FixSortSql2, "DWShop.mdb")
				Do While dr2.Read
					prodId = Base.ChkInteger(dr2.Item("ShopProductID"))
					Database.ExecuteNonQuery("update ShopProduct set ShopProductSort=" & sort & " where ShopProductID = " & prodId, "DWShop.mdb")
					sort += 1
				Loop
				dr2.Close()
				dr2.Dispose()
			Loop
			dr.Close()
			dr.Dispose()
		End If

		
		
		sql = "SELECT ShopGroup.ShopGroupName, Count(ShopProduct.ShopProductID) AS CountOfShopProductID "
		sql = sql & "FROM ShopGroup LEFT JOIN ShopProduct ON ShopGroup.ShopGroupID = ShopProduct.ShopProductGroupID "
		sql = sql & "WHERE ((ShopGroup.ShopGroupID)=" & ID & ") "
		sql = sql & SqlWhereVariant
		sql = sql & " GROUP BY ShopGroup.ShopGroupName "

		cmdShop.CommandText = sql

		Dim GroupReader As IDataReader = cmdShop.ExecuteReader()

		Dim opShopGroupName As Integer = GroupReader.GetOrdinal("ShopGroupName")
		Dim opCountOfShopProductID As Integer = GroupReader.GetOrdinal("CountOfShopProductID")

		If GroupReader.Read Then
			Title = Translate.Translate("%p% (%c% varer)", "%p%", GroupReader(opShopGroupName), "%c%", GroupReader(opCountOfShopProductID))
		End If

		GroupReader.Dispose()

	Else
		Title = "&nbsp;"
	End If
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<script language="JavaScript">
<!--
mac = false;
if(navigator.appVersion.toLowerCase().indexOf("mac") > 0){
	mac = true;
}

function ParagraphDelete(ID, ShopProductGroupID, PageName){
	if (confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("vare"))%>\n(" + PageName + ")")){
		location = "Product_Delete.aspx?ID=" + ID + "&ShopProductGroupID=" + ShopProductGroupID
	}
}

function movepage(ID, AreaID){
	movepageWindow = window.open("Menu.aspx?MoveID=" + ID + "&Action=Move&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=202");
	hideNow();
}

function copyproduct(ID, GroupID){
	CopypageWindow = window.open("Menu.aspx?CopyID=" + ID + "&GroupID=" + GroupID + "&Action=CopyProduct", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function moveproduct(ID, GroupID){
	movepageWindow = window.open("Menu.aspx?MoveID=" + ID + "&GroupID=" + GroupID + "&Action=MoveProduct", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

hide = true;
function doNotHide(){
	hide = false;
}

function hideMenu(){
	hide = true;
	setTimeout("doTheHide()", 2500);
}

function doTheHide(){
	if(hide){
		document.getElementById('Rmenu').style.display = 'none';
		hide = false;
	}
}

function hideNow(){
	document.getElementById('Rmenu').style.display = 'none';
}

function FieldSize(){
	var height = document.body.clientHeight;
	height = height-140
	if(height > 425){
		height = 425;
	}
}

<%If Request.QueryString("Mode") = "Browse" Then%>
function Choose(ProductID, ProdcutName, ProductNumber, doClose){
	var SelectionCount;
	var arrProdIDs;
	var blnTooMany;
	blnTooMany = false;
	SelectionCount = 0; <%'=Request.QueryString("SelectionCount")%>
		
	obj = top.opener.document.getElementById('<%=Request.QueryString("Caller")%>');
	objList = top.opener.document.getElementById('<%=Request.QueryString("Caller")%>List');

	if(SelectionCount > 0) {
		if(obj.value.length > 0) {
			arrProdIDs = obj.value.split(",");
			if(arrProdIDs.length >= SelectionCount) {
				// alert('<%=Translate.JsTranslate("Der må kun vælges")%>' + ' ' + SelectionCount + ' ' + '<%=Translate.JsTranslate("varer\nSlet en vare før du vælger en ny.")%>');
				alert('<%=Translate.JsTranslate("Der kan max. vælges %% genstande!")%>'.replace("%%", SelectionCount) + '\n<%=Translate.JsTranslate("Fjern en genstand før du tilføjer nye genstande.")%>');
				blnTooMany = true;
			}
		}
	}

	if(blnTooMany == false) {
		if(!top.opener.document.getElementById("R<%=Request.QueryString("Caller")%>" + ProductID)){
			if(obj.value.length > 0){
				obj.value += ", " + ProductID;
			}
			else{
				obj.value = ProductID;
			}
			objList.innerHTML += "<table ID=R<%=Request.QueryString("Caller")%>" + ProductID + "><tr><td width=150>" + ProductNumber + "</td><td width=150>" + ProdcutName + "</td><td width=30><a href='javascript:del<%=Request.QueryString("Caller")%>(" + ProductID + ");'><img src=\"/Admin/images/Delete.gif\" border=0></a></td></tr></table>"
		}
		else{
			alert("<%=Translate.JsTranslate("Den valgte vare er tilføjet")%>");
		}
	}
	if(doClose){
		self.close();
	}
}
<%End If%>
-->
</script>

</HEAD>
<BODY onload="FieldSize();">
<span id=bodyheight>
<%=Gui.MakeHeaders(Title, Translate.Translate("Varer"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
<tr><td valign=top>
<div ID="Tab1" STYLE="display:;width:598;">
<table border="0" cellpadding="0" width="598">
<%
Action = Request.QueryString("Action")
If Action = "Search" Then
	%>
	<tr>
		<td colspan="7">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Søg"))%>
			<table cellpadding=2 cellspacing=0>
				<form name="Search" id="Search" action="Product_List.aspx" Method=get>
				<input type=hidden name="Action" value="Search">
				<input type=hidden name="Search" value="True">
				<%	If Request.QueryString("Mode") = "Browse" Then%>
				<input type=hidden name="Mode" value="Browse">
				<input type=hidden name="Caller" value="<%=Request.QueryString("Caller")%>">
				<%	End If%>
				<tr>
					<td width=170><%=Translate.Translate("Varenavn")%></td>
					<td><input type=text name="ProductName" value="<%=Request.QueryString("ProductName")%>" class=std style="width:150px;"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Varenummer")%></td>
					<td><input type=text name="ProductNumber" value="<%=Request.QueryString("ProductNumber")%>" class=std style="width:150px;">&nbsp;</td>
				</tr>
				<tr>
					<td colspan=2 align=right><%= Gui.Button(Translate.Translate("Søg"), "document.getElementById('Search').submit();", 0)%></td>
				</tr>
				</form>
			</table>
			<%=Gui.GroupBoxEnd%>
		</td>
    </tr>
	<%	
	If Request.QueryString("Search") = "True" Then
		Dim productName as String = Dynamicweb.Modules.Common.DbHandler.LikeEscapeCharacters(Base.ChkString(Request.QueryString("ProductName")))
		Dim productNumber as String = Dynamicweb.Modules.Common.DbHandler.LikeEscapeCharacters(Base.ChkString(Request.QueryString("ProductNumber")))
		'### 24/11-05 ADDED EXTRA LOGIC By RAP
		If Request.QueryString("ProductName") <> "" AND Request.QueryString.Item("ProductNumber") = ""  Then
			SqlWhere = "WHERE ShopProductName LIKE '%" & productName & "%'" & SqlWhereVariant & " ORDER BY ShopProductName"
		End If
		
		If Request.QueryString.Item("ProductNumber") <> "" AND Request.QueryString("ProductName") = "" Then
			SqlWhere = "WHERE ShopProductNumber LIKE '%" & productNumber & "%'" & SqlWhereVariant & " ORDER BY ShopProductName"
		End If
		If Request.QueryString.Item("ProductNumber") <> "" AND Request.QueryString("ProductName") <> "" Then
			SqlWhere = "WHERE ShopProductName LIKE '%" & productName & "%' AND ShopProductNumber LIKE '%" & productNumber & "%'" & SqlWhereVariant & " ORDER BY ShopProductName"
		End If
		'### END EXTRA LOGIC
	Else
		SqlWhere = "WHERE 1=2" & SqlWhereVariant
	End If
Else
	SqlWhere = "WHERE ShopProduct.ShopProductGroupID=" & ID & SqlWhereVariant & " "
	SqlWhere = SqlWhere & "ORDER BY ShopProductSort, ShopProductName"
	'SqlWhere = SqlWhere & "ORDER BY ShopProductSort, ShopProductParentID, ShopProductName"
End If

	sql = "SELECT ShopProduct.*, ShopGroup.ShopGroupName, ShopGroup.ShopGroupParentID FROM ShopProduct "
sql = sql & "LEFT JOIN ShopGroup ON ShopGroup.ShopGroupID = ShopProduct.ShopProductGroupID "
sql = sql & SqlWhere

'response.write(sql)

Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
Dim dsShop As DataSet = New DataSet

cmdShop.CommandText = sql
adShopAdapter.SelectCommand = cmdShop
adShopAdapter.Fill(dsShop)

Dim productView As DataView = New DataView(dsShop.Tables(0))

Dim blnHasRows = False
i = 0

For j = 0 To productView.count - 1
	i = i + 1
    If Base.HasAccess("ShopCategories", productView(j)("ShopProductGroupID").ToString) or productView(j)("ShopGroupParentID").ToString <> "0" Then

		If i = 1 Then
		%>
			<tr>
				<td width="150" colspan="2"><img src="../../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Vare")%></strong></td>
				<td width="90"><strong><%=Translate.Translate("Varenr")%></strong></td>
				<%If request("Action") <> "Search" Then%>
					<td width="60" align="center"><strong><%=Translate.Translate("Sorter")%></strong></td>
				<%End If%>
				<td width=30><strong><%=Translate.Translate("Medtag")%></strong></td>
				<td width=68><strong><%=Translate.Translate("Oprettet")%></strong></td>
				<td width=68><strong><%=Translate.Translate("Redigeret")%></strong></td>
				<%If Base.HasVersion("18.5.1.0") Then%>
					<td width=30 align="right"><strong><%=Translate.Translate("Flyt")%></strong></td>
					<td width=30 align="right"><strong><%=Translate.Translate("Kopi")%></strong></td>
				<%End If%>
				<td width=30 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
			</tr>
			
			<%
			colspnTotal = 7
			If request("Action") <> "Search" Then
				colspnTotal += 1
			End If
			If Base.HasVersion("18.5.1.0") Then
				colspnTotal += 2
			End If
			%>
			
			<tr>
				<td colspan="<%=colspnTotal%>" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			</tr>
			
		<%End If%>

		<%
		'TFC - Sort order test 
		'response.write("<tr><td colspan=10>"& productView(j)("ShopProductSort").ToString &"</td></tr>")
		%>

		<TR>
			<%
			span = "<span>"
			style = ""
			
			Dim tdStyle As String 
			
			If Not CBool(productView(j)("ShopProductActive").ToString) Then
				span = "<span style=""color:#C1C1C1;"">"
				style = " STYLE=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);"""
			End If
			If Base.ChkNumber(productView(j)("ShopProductParentID").ToString) <> 0 Then
				ModuleIcon = "../../images/Icons/ProductVariant.gif"
				tdStyle = "<td><img src=""../../images/nothing.gif"" width=""10"" border=""0""></td><td>"
			Else
				ModuleIcon = "../../images/Icons/Paragraph.gif"
				tdStyle = "<td colspan=""2"">"
			End If
			If Request.QueryString("Mode") = "Browse" Then
				If productView.count = 1 Then
					%>
					<script>
					Choose(<%=productView(j)("ShopProductID").ToString%>, '<%=Base.JSEnable(Left(productView(j)("ShopProductName").ToString, 22)) & "..."%>', '<%=Base.JSEnable(productView(j)("ShopProductNumber").ToString)%>', true);
					</script>
				<%Else%>
					<%=tdStyle%><a href="Javascript:Choose(<%=productView(j)("ShopProductID").ToString%>, '<%=Base.JSEnable(Replace(Left(productView(j)("ShopProductName").ToString, 22), """", "&quot;")) & "..."%>', '<%=Base.JSEnable(productView(j)("ShopProductNumber").ToString)%>', false)"><img src="<%=ModuleIcon%>" border="0" align=absmiddle<%=style%>>&nbsp;
				<%End If%>
			<%ElseIf Base.ChkNumber(productView(j)("ShopProductParentID").ToString) <> 0 Then %>
				<%=tdStyle%><a href="Product_edit.aspx?ID=<%=productView(j)("ShopProductParentID").ToString%>&PageID=<%=productView(j)("ShopProductGroupID").ToString%>"><img title="<%=Translate.JsTranslate("Rediger Hoved-varen")%>" src="<%=ModuleIcon%>" border="0" align=absmiddle<%=style%>>&nbsp;</a><a href="Product_edit.aspx?ID=<%=productView(j)("ShopProductID").ToString%>&PageID=<%=productView(j)("ShopProductGroupID").ToString%>">
			<%Else%>
				<%=tdStyle%><a href="Product_edit.aspx?ID=<%=productView(j)("ShopProductID").ToString%>&PageID=<%=productView(j)("ShopProductGroupID").ToString%>"><img src="<%=ModuleIcon%>" border="0" align=absmiddle<%=style%> alt="<%=productView(j)("ShopGroupName").ToString%>">&nbsp;
			<%End If%>
			<%		
			If Len(productView(j)("ShopProductName").ToString) > 25 Then
				Response.Write(span & Left(productView(j)("ShopProductName").ToString, 22) & "...")
			Else
				Response.Write(span & productView(j)("ShopProductName").ToString)
			End If
			%>
			</span></a>
			</td>
			<td>
				<%		
			If Len(productView(j)("ShopProductNumber").ToString) > 12 Then
				Response.Write(span & Left(productView(j)("ShopProductNumber").ToString, 10) & "...")
			Else
				Response.Write(span & productView(j)("ShopProductNumber").ToString)
			End If
			%></span>
			</td>

			<%If request("Action") <> "Search" Then%>
				<%If (i = 1 And i = productView.count) Or productView(j)("ShopProductSort").ToString = "0" Then%>
					<td align="center"></td>
				<%ElseIf i = 1 Then %>
					<td align="center"><img src="../../images/nothing.gif" width="15" border="0"><a href="Product_Sort.aspx?ID=<%=ID%>&ShopProductID=<%=productView(j)("ShopProductID").ToString%>&ShopProductGroupID=<%=productView(j)("ShopProductGroupID").ToString%>&MoveDirection=down&inclVariant=<%=inclVariant%>"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td>
				<%ElseIf i = productView.count Then %>
					<%If Base.ChkNumber(productView(j)("ShopProductParentID").ToString) <> 0 Then%>
						<td align="center"><img src="../../images/pilop_none.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>><img src="../../images/nothing.gif" width="15" border="0"<%=style%>></td>
					<%Else%>
						<td align="center"><a href="Product_Sort.aspx?ID=<%=ID%>&ShopProductID=<%=productView(j)("ShopProductID").ToString%>&ShopProductGroupID=<%=productView(j)("ShopProductGroupID").ToString%>&MoveDirection=up&inclVariant=<%=inclVariant%>"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><img src="../../images/nothing.gif" width="15" border="0"<%=style%>></td>
					<%End If%>
				<%Else%>
					<%If Base.ChkNumber(productView(j)("ShopProductParentID").ToString) <> 0 Then%>
						<td align="center"><img src="../../images/pilop_none.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>><img src="../../images/pilned_none.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></td>
					<%Else%>
						<td align="center"><a href="Product_Sort.aspx?ID=<%=ID%>&ShopProductID=<%=productView(j)("ShopProductID").ToString%>&ShopProductGroupID=<%=productView(j)("ShopProductGroupID").ToString%>&MoveDirection=up&inclVariant=<%=inclVariant%>"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><a href="Product_Sort.aspx?ID=<%=ID%>&ShopProductID=<%=productView(j)("ShopProductID")%>&ShopProductGroupID=<%=productView(j)("ShopProductGroupID")%>&ShopProductSort=<%=productView(j)("ShopProductSort")%>&MoveDirection=down&inclVariant=<%=inclVariant%>"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td>
					<%End If%>
				<%End If%>
			<%End If%>
			<td align="center">
			<%		
			If CBool(productView(j)("ShopProductActive").ToString) Then 'Is the paragraph active or not? Show the right icon (and make the right link)
				Response.Write("<a href=""Product_Toggle_Active.aspx?ID=" & productView(j)("ShopProductID").ToString & "&active=0&inclVariant="& inclVariant &"""><img src=""../../images/Check.gif"" border=0></a>")
			Else
				Response.Write("<a href=""Product_Toggle_Active.aspx?ID=" & productView(j)("ShopProductID").ToString & "&active=1&inclVariant="& inclVariant &"""><img src=""../../images/Minus.gif"" border=0></a>")
			End If%>
			</td>
			<td>
				<%
				if Not Base.ChkString(productView(j)("ShopProductCreatedDate")) = "" then
						response.write(span & Dates.ShowDate(CDate(productView(j)("ShopProductCreatedDate").ToString), Dates.Dateformat.Short, false))
				end if
				%>
			</span></td>
			<td><%
				if Not Base.ChkString(productView(j)("ShopProductUpdatedDate")) = "" then
						response.write(span & Dates.ShowDate(CDate(productView(j)("ShopProductUpdatedDate").ToString), Dates.Dateformat.Short, false))
				end if
				%>
			</span></td>
	<%		If Base.HasVersion("18.5.1.0") Then%>
			<td align="center" onClick="moveproduct(<%=productView(j)("ShopProductID").ToString%>, <%=productView(j)("ShopProductGroupID").ToString%>);" Style="Cursor: pointer;"><img src="../../images/Icons/Page_Move.gif" border="0"<%=style%>></td>
			<td align="center" onClick="copyproduct(<%=productView(j)("ShopProductID").ToString%>, <%=productView(j)("ShopProductGroupID").ToString%>);" Style="Cursor: pointer;"><img src="../../images/Icons/Page_Copy.gif" border="0"<%=style%>></td>
	<%		End If%>
			<td align="center"><a href="JavaScript:ParagraphDelete(<%=productView(j)("ShopProductID").ToString%>, <%=productView(j)("ShopProductGroupID").ToString%>, '<%=Base.JSEnable(Server.HtmlEncode(productView(j)("ShopProductName").ToString))%>')"><img src="../../images/Delete.gif" alt="<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("vare"))%>" border="0"<%=style%>></a></td>
		</TR>
		<tr>
			<td colspan="10" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
		</tr>
		<%		
		blnHasRows = True
	End If
Next 

If (Not blnHasRows) And (Request.QueryString("Search") = "True" Or Action = "") Then
	%>
	<tr>
		<!--td colspan="<%=colspnTotal%>"><strong><br>&nbsp;<%=Translate.Translate("Der er ikke fundet nogle varer")%></strong></td-->
		<td colspan="<%=colspnTotal%>"><strong><br>&nbsp;<%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("varer"))%></strong></td>
	</tr>
	<tr>
		<td colspan="<%=colspnTotal%>" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
	</tr>
<%End If

i = 0


'Check for variants - enable/disable "Vis varianter" button
sql = "SELECT ShopGroup.ShopGroupName "
sql = sql & "FROM ShopGroup LEFT JOIN ShopProduct ON ShopGroup.ShopGroupID = ShopProduct.ShopProductGroupID "
sql = sql & "WHERE ((ShopGroup.ShopGroupID)=" & ID & ") "
sql = sql & "AND (ShopProduct.ShopProductParentID <> 0 AND ShopProduct.ShopProductParentID IS NOT NULL)"

cmdShop.CommandText = sql

Dim VariantReader As IDataReader = cmdShop.ExecuteReader()
Dim blnVariants As Boolean

If VariantReader.Read Then
	blnVariants = True
End If

VariantReader.Dispose



ShopConn.Dispose 

If msg <> "" Then%>
	<tr>
		<td colspan="<%=colspnTotal%>"><%=msg%></td>
    </tr>
<%End If%>
</TABLE>
</div>
</td></tr>
<tr>
	<td align=right valign=bottom id=functionsbutton>
		<table>
			<tr>
			<%If Base.HasVersion("18.5.1.0") And Request.QueryString("Action") <> "Search" Then%>
				<%'If Request.QueryString("inclVariant") <> "yes" Then%>
				<%If inclVariant <> "yes" Then %>
					<td align="right"><%=Gui.Button(Translate.Translate("Vis varianter"), "location='Product_list.aspx?ID=" & Request.QueryString("ID") & "&inclVariant=yes';", 0, Not blnVariants)%></td>
				<%Else%>
					<td align="right"><%=Gui.Button(Translate.Translate("Skjul varianter"), "location='Product_list.aspx?ID=" & Request.QueryString("ID") & "&inclVariant=no';", 0, Not blnVariants)%></td>
				<%End If%>
				<td width="5"></td>
			<%End If%>
				<td>
				<%If Request.QueryString("Mode") = "Browse" Then%>
				<%=Gui.Button(Translate.Translate("Luk vindue"), "self.close();", 100)%>
				<%Else%>
				<%=Gui.Button(Translate.Translate("Ny vare"), "location='Product_edit.aspx?ShopProductGroupID=" & ID & "';", 0)%>
				<%End If%>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
</span>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
</BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>