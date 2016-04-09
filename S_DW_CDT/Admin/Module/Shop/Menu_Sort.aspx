<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim i As Object
Dim sql As String
Dim SQLStmt As String
Dim ShopGroupParentID As Object
Dim AreaID As String
Dim intRowCount As Integer
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Sort groups
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand

If CDbl(request("mode")) = 1 Then

	For i = 1 To Request.Params.GetValues("ShopGroupSort").Length
		SQLStmt = "UPDATE ShopGroup "
		SQLStmt = SQLStmt & "SET ShopGroupSort=" & i & " "
		SQLStmt = SQLStmt & " WHERE ShopGroupID=" & request.Params.GetValues("ShopGroupSort").GetValue(i - 1)
		cmdShop.CommandText = SQLStmt
		cmdShop.ExecuteNonQuery()
	Next 

	ShopGroupParentID = request("ShopGroupParentID")
	AreaID = request("AreaID")
	%>

	<script language="JavaScript">
		parent.ShopRight.location = "Product_List.aspx?ID=<%=ShopGroupParentID%>";
		//parent.document.all.item("Sort_<%'=PageParentPageID%>"); 
		//parent.UpdateMenuEntry(<%=ShopGroupParentID%>);
		parent.refreshMenuStruct(<%=ShopGroupParentID%>);
	</script>

	<%response.End%>
<%Else
	If Not IsNothing(request.QueryString.GetValues("ShopGroupParentID")) Then
		ShopGroupParentID = request.QueryString.Item("ShopGroupParentID")
	Else
		ShopGroupParentID = 0
	End If
	%>
	<HTML>
	<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
	<TITLE></TITLE>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function checkInput(theForm) {
		document.getElementById('rang').ShopGroupSort.multiple = true;
		setTimeout("submitit()", 200);
	}

	function submitit(){
		for(i = 0; i < document.getElementById('rang').ShopGroupSort.length; i++){
			document.getElementById('rang').ShopGroupSort.options[i].selected = true;
		}
		document.getElementById('rang').action = "Menu_sort.aspx";
		document.getElementById('rang').submit();
	}
	
	function MoveUp(){
		ID = document.getElementById('rang').ShopGroupSort.selectedIndex
		if(ID != 0)
		{
			val1 = document.getElementById('rang').ShopGroupSort[ID - 1].value;
			val2 = document.getElementById('rang').ShopGroupSort[ID - 1].text;
			document.getElementById('rang').ShopGroupSort.options[ID - 1] = new Option(document.getElementById('rang').ShopGroupSort[ID].text, document.getElementById('rang').ShopGroupSort[ID].value);
			document.getElementById('rang').ShopGroupSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').ShopGroupSort.options[ID - 1].selected = true;
			ToggleImage(ID - 1);
		}
	}
	
	function MoveDown(){
		ID = document.getElementById('rang').ShopGroupSort.selectedIndex
		if(ID != document.getElementById('rang').ShopGroupSort.length - 1)
		{
			val1 = document.getElementById('rang').ShopGroupSort[ID + 1].value;
			val2 = document.getElementById('rang').ShopGroupSort[ID + 1].text;
			document.getElementById('rang').ShopGroupSort.options[ID + 1] = new Option(document.getElementById('rang').ShopGroupSort[ID].text, document.getElementById('rang').ShopGroupSort[ID].value);
			document.getElementById('rang').ShopGroupSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').ShopGroupSort.options[ID + 1].selected = true;
			ToggleImage(ID + 1);
		}
	}
	
	function ToggleImage(ID){
		if(ID > -1){
			if(ID == 0){
				document.images["up"].src = "../../images/Collapse_inactive.GIF";
				document.images["up"].alt = "";
			}else{
				document.images["up"].src = "../../images/Collapse.GIF";
				document.images["up"].alt = "<%=Translate.JsTranslate("Flyt op")%>";
			}
		
			if(ID == document.getElementById('rang').ShopGroupSort.length - 1){
				document.images["down"].src = "/Admin/images/Expand_inactive.GIF";
				document.images["down"].alt = "";
			}else{
				document.images["down"].src = "/Admin/images/Expand_active.GIF";
				document.images["down"].alt = "<%=Translate.JsTranslate("Flyt ned")%>";
			}
		}else{
			document.images["up"].src = "/Admin/images/images/Collapse_inactive.GIF";
			document.images["up"].alt = "";
			document.images["down"].src = "/Admin/images/images/Expand_inactive.GIF";
			document.images["down"].alt = "";
		}
	}
	</script>
	<%=Gui.MakeHeaders(Translate.Translate("Sortering"), Translate.Translate("Sortering"), "Javascript")%>
	</HEAD>
	<BODY onLoad="document.getElementById('rang').ShopGroupSort.multiple = false;">
	<%	

	sql = "SELECT * FROM ShopGroup WHERE ShopGroupParentID=" & ShopGroupParentID & " ORDER BY ShopGroupSort, ShopGroupName "
	
	Dim adShopAdapter As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adShopAdapter)
	Dim dsShop As DataSet = New DataSet

	cmdShop.CommandText = SQL
	adShopAdapter.SelectCommand = cmdShop
	adShopAdapter.Fill(dsShop)

	Dim groupView As DataView = New DataView(dsShop.Tables(0))

	%>
	<%=Gui.MakeHeaders(Translate.Translate("Sortering"), Translate.Translate("Sortering"), "html")%>
	<table border="0" cellpadding="0" cellspacing=0 class=tabTable style="height:200px;">
	<form name="rang" method="post">
	<input type=hidden name="ShopGroupParentID" value="<%=ShopGroupParentID%>">
	<input type=hidden name="Mode" value="1">
		<tr>
			<td valign=top>
				<DIV ID=Tab1><br>
				<table>
		  			<tr>
						<td>&nbsp;
							<select size=<%=groupView.count + 1%> name=ShopGroupSort style="width: 400px;" onChange="ToggleImage(this.selectedIndex);" class=std>
								<%	
								For i = 0 To groupView.count - 1
									%>
									<option value="<%=groupView(i)("ShopGroupID")%>"><%=Left(groupView(i)("ShopGroupName"),100)%></option>
									<%		
								Next%>
							</select>
						</td>
						<td>
						<a href="JavaScript:void(0);" onmousedown="MoveUp();"><img src="../../images/Collapse.GIF" width="16" height="16" alt="" border="0" name="up"></a>
						<br>
						<a href="JavaScript:void(0);" onmousedown="MoveDown();"><img src="../../images/Expand_active.GIF" width="16" height="16" alt="" border="0" name="down"></a>
		  				</td>
					</tr>
				</table>
				</DIV>
			</td>
		</tr>
		<tr>
			<td align=right>
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td><%= Gui.Button(Translate.Translate("OK"), "checkInput(document.getElementById('rang'));", 0)%></td>
						<td width=5></td>
						<td><%=Gui.Button(Translate.Translate("Annuller"), "history.back();", 0)%></td>
						<td width=10></td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
	</BODY>
	</HTML>
	<script language="JavaScript">
		document.getElementById('rang').ShopGroupSort.selectedIndex = 0;
		ToggleImage(0);
	</script>
<%
End If

ShopConn.Dispose

Translate.GetEditOnlineScript()
%>
