<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="Dynamicweb.Admin.Menu1"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim SelectedPageID As Integer
Dim AreaID As String
Dim Action As String
Dim UserID As String
Dim MoveID As String
Dim Caller As String
Dim CopyID As String
Dim strSQL As String
</SCRIPT>

<%
Server.ScriptTimeOut = 90
'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: Show treeview of groups in shops
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(request.QueryString("ID")) Then
	SelectedPageID = request.QueryString("ID")
Else
	SelectedPageID = 0
End If

Action = request.QueryString("Action")
AreaID = request.QueryString("AreaID")
MoveID = request.QueryString("MoveID")
UserID = request.QueryString("UserID")
Caller = request.QueryString("Caller")

If MoveID = "" Then
	MoveID = 0
End If

CopyID = request.QueryString("CopyID")

If CopyID = "" Then
	CopyID = 0
End If



'START  INCLUDE FILE="Menu_TreeView.aspx" 
' END

'**************************************************************************************************
'	Current version:	1.0
'	Created:			26-01-2002
'	Last modfied:		26-01-2002
'
'	Purpose: Show treeview of pages in navigation
'
'	Revision history:
'		1.0 - 26-01-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************


%>
<html>
<head>
<title><%=Translate.JSTranslate("Menu")%>-<%=Translate.JSTranslate("Shop","9")%></title>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script src="Menu_TreeView.js.aspx?" type="text/javascript"></script>
<script language="JavaScript">
InternalAllID = '<%=request.QueryString.Item("Caller")%>';
function internal(ID, Name){
	top.opener.document.getElementById("Link_" + InternalAllID).value = Name;
	top.opener.document.getElementById(InternalAllID).value = "Default.aspx?ID=" + ID;
	self.close();
}

function AddPage(ID){
	top.opener.location = "Group_Rotation_add.aspx?ID=<%=SelectedPageID%>&RotateID=" + ID;
}

function movepage(ID)
{
	CopyMoveInProcess = 1
	
	movepageWindow = window.open("menu.aspx?MoveID=" + ID + "&Action=Move", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function copygroup(ID){
	CopypageWindow = window.open("Menu.aspx?CopyID=" + ID + "&Action=CopyGroup", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function movegroup(ID){
	MoveGroupWindow = window.open("Menu.aspx?MoveID=" + ID + "&Action=MoveGroup", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function movePageTo(ID){
	location = "Group_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

function moveGroupTo(ID){
	location = "Group_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

function copyGroupTo(ID){
	location = "Group_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function moveProductTo(ID){
	location = "Product_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

function copyProductTo(ID){
	location = "Product_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function profileVisitPreview() {
        window.open("/Admin/Module/Omc/Profiles/PreviewProfile.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(document.getElementById("previewUrl").value), "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
}


function copypage(ID)
{
	CopyMoveInProcess = 1
	
	CopypageWindow = window.open("menu.aspx?CopyID=" + ID + "&Action=Copy", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function showparagraphs(ID){
	window.ShopRight.location = "Product_List.aspx?ID="+ID;
	hideNow();
}

function previewpage(ID){
	window.open("../Default.aspx?ID="+ID);
	hideNow();
}

function editpage(ID){
	window.ShopRight.location = "Group_Edit.aspx?ID=" + ID;
	hideNow();
}

function newparagraph(ID){
	window.ShopRight.location = "Product_Edit.aspx?ShopProductGroupID="+ID;
	hideNow();
}

function newsubpage(ID){
	window.ShopRight.location = "Group_Edit.aspx?uID="+ID;
	hideNow();
}


function deletepage(ID){

	if(document.getElementById("s"+ID)){
		PageName = document.getElementById("s"+ID).innerHTML;
		var tr = /<[^>]+>/ig;
		PageName = PageName.replace(tr, "");
		PageName = PageName.replace("&amp;", "&").replace("&lt;", "<").replace("&gt;", ">");
	}
	hideNow();
	if(confirm("<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("gruppe"))%>\n(" + PageName + ")")){
		window.ShopRight.location = "Group_Delete.aspx?ID=" + ID;
	}
}

function newProduct(ID)
{
	window.ShopRight.location = "Product_Edit.aspx?ShopProductGroupID="+ID;
	hideNow();
}

function rightClick2(){
	event.returnValue=false;
	return false;
}

cellObject = ""

document.oncontextmenu= function(){return false}
var my=0;
var mx=0;
var mevent

function rightClick(ev, PageID, co){
	if (!window.event){
		mx = ev.pageX;
		my = ev.pageY;
		mevent = ev;
	}else{
		mevent = window.event
	}

	if(cellObject){
		cellObject.style.fontWeight = "";

	}
	if(document.getElementById("s"+PageID).style){
		document.getElementById("s"+PageID).style.fontWeight = "bold";
		cellObject = document.getElementById("s"+PageID);
	}
	showMenu(PageID);
	mevent.returnValue=false;
	return false;
}

function showMenu(ID, menuobject, documentObj, Ey, Ex){
	//objJsdoc = "top.left.";
	objJsdoc = "";

	MenuHTML = "<span class=altMenuLeftPane></span>";
	MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 style="width:100%">';
	MenuHTML += '<tr><td onClick="newsubpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Folder_New.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny gruppe")%></td></tr>';
	MenuHTML += '<tr><td onClick="newProduct('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Paragraph.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny vare")%></td></tr>';
	MenuHTML += '<tr><td onClick="editpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Folder_edit.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ret gruppe")%></td></tr>';
	MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
	<%If Base.HasVersion("18.5.1.0") Then%>
	MenuHTML += '<tr><td onClick="movepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Folder_Move.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Flyt gruppe")%></td></tr>';
	MenuHTML += '<tr><td onClick="copypage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Folder_Copy.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Kopier gruppe")%></td></tr>';
	<%End If%>
	MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
	MenuHTML += '<tr><td onClick="deletepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Slet %%", "%%", Translate.Translate("gruppe"))%></td></tr>';

	MenuHTML += '</table>';
	if(!menuobject){
		menuobject = document.getElementById('Rmenu');
	}
	if(!documentObj){
		documentObj = document;
	}
	menuobject.innerHTML = MenuHTML;
	if(!Ey){ //Called from leftmenu
               	if (!window.event){
			Ey = my;
			Ex = mx
		}else{
			Ey = event.clientY+ documentObj.body.scrollTop;
		Ex = event.clientX;
		}
		menuobject.style.top=Ey;
		if (Ex+160<195){
			menuobject.style.left=Ex;
		} else {
			menuobject.style.left=195-160;
		}
	}
	else{ //Called from paragraph_list.aspx
		menuobject.style.top=Ey;
		menuobject.style.left=Ex-50;
	}
	menuobject.style.display = "";
	//setTimeout("hideMenu()",2000)
	ReplaceMenuPosition(menuobject);
}

//Replaceing menu to fit into frame
function ReplaceMenuPosition(menuObj) {
    var frameHeight = document.body.clientHeight;
    
    var mouseY = 0;
    var IE = document.all?true:false
    if (!IE) document.captureEvents(Event.MOUSEMOVE);
    if (IE) {
        mouseY = event.clientY + document.body.scrollTop;
    } else {  
        mouseY = e.pageY;
    }  
    if (mouseY < 0){mouseY = 0}  
    if (frameHeight < 0){frameHeight = 0}  

    var min = 192;
    
    if ((parseInt(frameHeight) - parseInt(mouseY)) < min) {
        menuObj.style.top = frameHeight - min;    
    }
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
		if(cellObject.style){
			cellObject.style.fontWeight = "";
		}
		hide = false;
	}
}

function hideNow(){
	document.getElementById('Rmenu').style.display = 'none';
	if(cellObject.style){
		cellObject.style.fontWeight = "";
	}
}

function Area(){
	document.forms.area.submit();
	//location = "menu.aspx"
}

function closeMenu(){
	top.MainFrame.cols='20,*';
	document.getElementById('MenuTable').style.display='none';
	document.getElementById('MenuOpen').style.display='';
}

function openMenu(){
	top.MainFrame.cols='200,*';
	document.getElementById('MenuTable').style.display='';
	document.getElementById('MenuOpen').style.display='none';
}

function setContentCell(){
	TreeStartHeight = 0;
	if(document.getElementById('TreeStart')){
		TreeStartHeight = document.getElementById('TreeStart').offsetHeight;
	}
	
	TreeEndHeight = 0;
	if(document.getElementById('TreeEnd')){
		TreeEndHeight = document.getElementById('TreeEnd').offsetHeight;
	}
	
	if(document.getElementById('ContentCell')){
		height = document.body.clientHeight;
		document.getElementById('ContentCell').style.height = height - TreeEndHeight - TreeStartHeight-1;
	}
}


function refreshMenuStruct(PageParentPageID){
	window.location.href='Menu.aspx';
}
</script>
</head>
<body onMouseover="document.body.style.cursor = 'default'" DONTonContextmenu="rightClick2();" onClick="hideNow();" onLoad="setContentCell();" style="background-color:#DAE8F7;margin:0px;" scroll="no">
<table cellspacing=0 cellpadding=0 border=0 ID=MenuOpen style="display:none;" width="200">
	<tr height=17>
		<td align=center><img src="../../images/OpenTreeView_off.gif" onmouseover="this.src='../../images/OpenTreeView_on.gif'" onmouseout="this.src='../../images/OpenTreeView_off.gif'" onmousedown="this.src='../../images/OpenTreeView_press.gif'" onmouseup="this.src='../../images/OpenTreeView_on.gif'" onClick="openMenu();"></td>
	</tr>
	<tr>
		<td><DIV STYLE="writing-mode:tb-rl">&nbsp;<strong><%=Translate.Translate("Grupper")%></strong></div></td>
	</td>
</table>
<table cellspacing=0 cellpadding=0 border=0 height=100% width=100% ID=MenuTable style="display:">
	<tr bgColor="#FFFFFF">
		<td width=5 bgColor="#DAE8F7" rowspan=2></td>
		<td valign=top width=190>
			<table cellspacing=0 cellpadding=0 border=0 width=190>
				<tr height=23 bgColor="#DAE8F7" ID=TreeStart>
					<td colspan=3>
						<table cellspacing=0 cellpadding=0 border=0 width="100%">
							<tr>
								<td>&nbsp;<strong><%=Translate.Translate("Grupper")%></strong></td>
								<!--td align=right width=20><img src="../../images/CloseTreeView_off.gif" onmouseover="this.src='../../images/CloseTreeView_on.gif'" onmouseout="this.src='../../images/CloseTreeView_off.gif'" onmousedown="this.src='../../../../images/CloseTreeView_press.gif'" onmouseup="this.src='../../images/CloseTreeView_on.gif'" onClick="<%If Action = "" Then%>closeMenu();<%Else%>self.close();<%End If%>"></td-->
							</tr>
						</table>
					</td>
				</tr>
				<tr bgColor="#ACA899" height=1>
					<td colspan=3></td>
				</tr>
				<tr>
					<td colspan=3>
						<div style="width:100%;height:100%;overflow:auto;" ID=ContentCell>
						<table cellpadding=0 cellspacing=0>
						<%=ListPages(0, True)%>
						</table>
						</Div>
					</td>
				</tr>
			</table>
		</td>
		<td width=5 bgColor="#DAE8F7" rowspan=2></td>
		<td valign=top>
			<table cellspacing=0 cellpadding=0 border=0 width=100% height=100%>
				<tr height=50 bgColor="#DAE8F7">
					<td width=5 bgColor="#DAE8F7"></td>
					<td>
						<table cellspacing=0 cellpadding=4 border=0 width="100%">
							<tr valign="top">
								<td align=center width=15></td>
								<td align=center class=preview><a href="Group_Edit.aspx" target="ShopRight"><img src="/Admin/Images/Icons/Module_Shop_NewGroup.gif" alt="" border="0"><br /><%=Translate.Translate("Ny gruppe")%></a></td>
								<td align=center width=15></td>
								<td align=center class=preview><a href="Order_List.aspx" target="ShopRight"><img src="/Admin/Images/Icons/Module_shop_orders.gif" alt="" border="0"><br /><%=Translate.Translate("Ordrer")%></a></td>
								<td align=center width=15></td>
								<td align=center class=preview><a href="Product_list.aspx?Action=Search" target="ShopRight"><img src="/Admin/Images/Icons/Module_Search.gif" alt="" border="0"><br /><%=Translate.Translate("Søg")%></a></td>
								<td align=center width=15></td>
								<td align=center class=preview><a href="Delivery_List.aspx" target="ShopRight"><img src="/Admin/Images/Icons/Module_Shop_Delivery.gif" alt="" border="0"><br /><%=Translate.Translate("Levering")%></a></td>
								<td align=center width=15></td>
								<td align=center class=preview><a href="Payment_List.aspx" target="ShopRight"><img src="/Admin/Images/Icons/Module_Shop_Payment.gif" alt="" border="0"><br /><%=Translate.Translate("Betaling")%></a></td>
								<td align=center width=15></td>
								<%If Base.HasVersion("18.5.1.0") Then%>
								<td align=center class=preview>
									<a href="Currency_List.aspx" target="ShopRight">
										<img src="/Admin/Images/Icons/Module_Shop_Currency.gif" alt="" border="0"><br /><%=Translate.Translate("Valuta")%>
									</a>
								</td>
								<td align=center width=15></td>
								<%End If%>
								<td align=center class=preview>
									<a href="Product_Field_List.aspx" target="ShopRight">
										<img src="/Admin/Images/Icons/Module_Form.gif" alt="" border="0"><br /><%=Translate.Translate("Vare felter")%>
									</a>
								</td>
								<%If Base.HasVersion("18.2.1.0") Then%>
								<td align=center width=15></td>
								<td class=preview valign="top" align="center" width="58">
									<a href="#" onClick="<%=Gui.Help("dynamicshop", "modules.shop.general")%>;">
										<img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" border="0"><br /><%=Translate.Translate("Hjælp")%>
									</a>
								</td>
								<%End If%>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="border-top: solid 1px #D5DFE5" colspan="2">
						<iframe width=100% height=100% id="ShopRight" name="ShopRight" src="Order_List.aspx" LEFTMARGIN="10" TOPMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0" BORDER="0" FRAMEBORDER="0"></iframe>
					</td>
				</tr>
			</table>	
		</td>
	</tr>
	<tr ID=TreeEnd height=45>
		<td colspan=2>
			<%
			Dim ShopConn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
			Dim sCmdShop As IDbCommand = ShopConn.CreateCommand

			strSQL = "SELECT TOP 1 (SELECT Count(ShopProduct.ShopProductID) AS SumOfShopProductID FROM ShopProduct) AS NumOfProducts, (SELECT Count(ShopProduct.ShopProductID) AS SumOfShopProductID FROM ShopProduct WHERE ShopProductActive = " & Database.SqlBool(1) & ") AS NumOfActiveProducts,(SELECT Count(ShopGroup.ShopGroupID) AS SumOfShopGroupID FROM ShopGroup) AS NumOfGroups FROM ShopGroup"
			sCmdShop.CommandText = strSQL

			Dim ShopReader As IDataReader = sCmdShop.ExecuteReader()
			Dim opNumOfProducts As Integer = ShopReader.getordinal("NumOfProducts")
			Dim opNumOfActiveProducts As Integer = ShopReader.getordinal("NumOfActiveProducts")
			Dim opNumOfGroups As Integer = ShopReader.getordinal("NumOfGroups")

			If ShopReader.Read Then
			%>
				<TABLE cellspacing="3" cellpadding="0">
					<TR>
						<TD><%=Translate.Translate("Varer")%>:</TD>
						<TD><%=ShopReader(opNumOfProducts)%> (<%=ShopReader(opNumOfActiveProducts)%>&nbsp;<%=Translate.Translate("aktive")%>)</TD>
					</TR>
					<TR>
						<TD><%=Translate.Translate("Grupper")%>:</TD>
						<TD><%=ShopReader(opNumOfGroups)%></TD>
					</TR>
				</TABLE>
			<%	
			End If
			ShopReader.Dispose
			sCmdShop.Dispose
			ShopConn.Dispose
			%>
		</td>
	</tr>
</table>
<%
'If Action = "" Or Action = "Internal" Or Action = "AddPage" Then
'	For i = UBound(chosen) To 0 Step -1
'		If chosen(i) <> 0 Then
'			response.Write("toggle('" & chosen(i) & "', this, " & UBound(chosen) - i + 1 & ");" & vbCrLf)
'			If i = 0 And Action = "" Then
'				response.Write("n(" & chosen(i) & ");")
'			End If
'		End If
'	Next 
'Else
'	response.Write("window.onblur='self.close();'" & vbCrLf)
'End If
%>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
