<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="Dynamicweb.Admin.Menu2" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="uc" TagName="buttons" Src="UCButtons.ascx" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
Dim SelectedPageID As Object
Dim sql As String
Dim MoveID As String
Dim UserID As String
Dim AreaID As String
Dim CopyID As String
Dim Caller As String
Dim Action As String

Server.ScriptTimeOut = 90


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


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Translate.JSTranslate("Menu")%>-<%=Translate.JSTranslate("Medie database","9")%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>

    <style type="text/css">
        td.title
        {
            margin: 0px;
            padding-left: 5px;
            border-bottom: solid 1px #9FAEC2;
            background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
            height: 25px;
            line-height: 23px;
            vertical-align: middle;
            color: #15428b;
            font-family: Arial, Microsoft JhengHei;
            font-weight: bolder;
            font-size: 14px;
        }
    </style>

<script src="Menu_TreeView.js.aspx" type="text/javascript"></script>
<script language="JavaScript">
InternalAllID = '<%=request.QueryString("Caller")%>';

function changeReportSrc(reportScript) {
   var rpt = window.document.getElementById("ShopRight");
   rpt.src = reportScript;
}

function internal(ID, Name){
	top.opener.document.getElementById("Link_" + InternalAllID).value = Name;
	top.opener.document.getElementById(InternalAllID).value = "Default.aspx?ID=" + ID;
	self.close();
}

function AddPage(ID){
	top.opener.location = "Group_Rotation_add.aspx?ID=<%=SelectedPageID%>&RotateID=" + ID;
}

function movepage(ID){
	movepageWindow = window.open("Menu.aspx?MoveID=" + ID + "&Action=Move&AreaID=0", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
}

function movePageTo(ID){
	location = "Group_Move.aspx?ID=" + ID + "&AreaID=0&MoveID=<%=MoveID%>";
}

function copypage(ID){
	CopypageWindow = window.open("Menu.aspx?CopyID=" + ID + "&Action=Copy&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=202");
	hideNow();
}

function copyPageTo(ID){
	location = "Group_Copy.aspx?ID=" + ID + "&AreaID=" + AreaID + "&CopyID=<%=CopyID%>";
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
	window.ShopRight.location = "Media_Edit.aspx?GroupID="+ID;
	hideNow();
}

function newsubpage(ID){
	window.ShopRight.location = "Group_Edit.aspx?uID="+ID;
	hideNow();
}

function deletepage(ID){
	if(document.getElementById("s"+ID)){
		PageName = document.getElementById("s"+ID).innerText;
	}
	hideNow();
	if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("gruppe"))%>\n(" + PageName + ")\n\n<%=Translate.JSTranslate("Alle %% og indhold vil blive slettet!", "%%", Translate.JSTranslate("undergrupper"))%>")){
		window.ShopRight.location = "Group_Delete.aspx?ID=" + ID;
	}
}

function rightClick2(){
	event.returnValue=false;
	return false;
}

cellObject = ""
document.oncontextmenu= function(){return false}
var my=0;
var mx=0;

function rightClick(PageID, co, ev){
	var evt = (window.event)?window.event:ev;
	if (!window.event){
		mx = ev.pageX;
		my = ev.pageY;
	}
	if(cellObject){
		cellObject.style.fontWeight = "";
	}
	if(document.getElementById("s"+PageID).style){
		document.getElementById("s"+PageID).style.fontWeight = "bold";
		cellObject = document.getElementById("s"+PageID);
	}
	showMenu(PageID);
	evt.returnValue=false;
	return false;
}

function showMenu(ID, menuobject, documentObj, Ey, Ex){
	//objJsdoc = "top.left.";
	objJsdoc = "";
	MenuHTML = "<span class=altMenuLeftPane></span>";
	MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 width="100%" style="position:relative;top:0px;left:0px;">';
	MenuHTML += '<tr><td onClick="' + objJsdoc + 'newsubpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Page_open.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny gruppe")%></td></tr>';
	// MenuHTML += '<tr><td onClick="' + objJsdoc + 'newparagraph('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Paragraph.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ny fil")%></td></tr>';
	MenuHTML += '<tr><td onClick="' + objJsdoc + 'editpage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Page_edit.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Ret gruppe")%></td></tr>';
	MenuHTML += '<tr><td onClick="' + objJsdoc + 'movepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Page_Move.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Flyt gruppe")%></td></tr>';
	MenuHTML += '<tr><td onClick="' + objJsdoc + 'deletepage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Slet %%", "%%", Translate.Translate("gruppe"))%></td></tr>';
	//MenuHTML += '<tr><td onClick="' + objJsdoc + 'copypage('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="../../images/Icons/Page_Copy.gif" align=absmiddle class=altMenuImg><%=Translate.Translate("Kopier gruppe")%></td></tr>';
	MenuHTML += '</table>';
	if(!menuobject){
		menuobject = document.all.Rmenu;
	}
	if(!documentObj){
		documentObj = document;
	}
	menuobject.innerHTML = MenuHTML;
	if(!Ey){ //Called from leftmenu
        if (!window.event){
			Ey = my;
			Ex = mx;
		}else{
		    Ey = window.event.clientY;
		    Ex = window.event.clientX;
		    Ey = Ey + documentObj.body.scrollTop;
		}
			menuobject.style.top=Ey;
		if (Ex+160<195){
			menuobject.style.left=Ex;
		} else {
			menuobject.style.left=195-160;
	}
	}
	menuobject.style.display = "";
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
	document.getElementById('TreeEnd').style.display='';
	document.getElementById('TreeView').style.display='';
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
</script>
</head>
<body onmouseover="document.body.style.cursor = 'default'" DONTonContextmenu="rightClick2();" onclick="hideNow();" onload="setContentCell();" style="background:url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom #DFE9F5;margin:0px;height: 100%;">
<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" id="MenuTable">
	<tr bgColor="#FFFFFF">
		<td align="center" id="MenuOpen" nowrap="nowrap" style="display:none; background: url(/Admin/Images/Ribbon/UI/ContentBG2.gif) #6591cd repeat-x left top;
                width: 22px; padding-top:3px; " valign="top" >
                <img src="../../images/OpenTreeView_off.gif" onmouseover="this.src='../../images/OpenTreeView_on.gif'" onmouseout="this.src='../../images/OpenTreeView_off.gif'" onmousedown="this.src='../../images/OpenTreeView_press.gif'" onmouseup="this.src='../../images/OpenTreeView_on.gif'" onclick="openMenu();">
        </td>
		<td width="200" valign="top" id="TreeView" nowrap="nowrap" style="background-color:#FFFFFF">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr id="TreeStart">
                    <td height="20px"  colspan="2"><h1 class="title"><%= Translate.Translate("Media Database")%></h1></td>
					<td  class="title" align="right"><IMG SRC="../../images/CloseTreeView_off.gif" title=<%=Translate.Translate("Skjul")%> OnMouseOver="this.src='../../images/CloseTreeView_on.gif'" OnMouseOut="this.src='../../images/CloseTreeView_off.gif'" OnMouseDown="this.src='../../images/CloseTreeView_press.gif'" OnMouseUp="this.src='../../images/CloseTreeView_on.gif'" onclick="document.getElementById('TreeView').style.display='none';document.getElementById('TreeEnd').style.display='none';document.getElementById('MenuOpen').style.display='';" width="20" height="17"></td>
				</tr>
                <tr>
                    <td  style="height:18px" colspan="3">
				        <h2 class="subtitle"><%= Translate.Translate("Grupper")%></h2>
				    </td>
                </tr>
				<tr>
					<td colspan="3">
						<div style="width:190px;height:100%;overflow:auto;" id="ContentCell">
						<table cellpadding="0" cellspacing="0">
							<%Call ListPages(0, True)%>
						</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
        <td width="1" nowrap="nowrap" bgcolor="<%=Dynamicweb.Gui.NewUIbordercolor%>"></td>
		<td nowrap="nowrap">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
				<tr valign="top" height="25" style="background:url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
					<td>
						<uc:buttons ID="_buttons2" runat="server"></uc:buttons>
					</td>
				</tr>
				<tr>
			            <td align="left">
							<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
								<tr>
								    <td width="100%">
                                        <!--Right frame-->
										<iframe runat="server" id="ShopRight" name="ShopRight" width="100%" height="100%" src="Files_inbox.aspx" frameborder="0" marginheight="0" marginwidth="0"></iframe>
                                        <!--/Right frame-->
									</td>
								</tr>
							</table>
						</td>
				</tr>
			</table>	
		</td>
	</tr>
    <tr colspan="2"><td height="1"></td></tr>
	<tr id="TreeEnd" style="border-top-width:1; border-top-color:<%=Dynamicweb.Gui.NewUIbordercolor%>">
		<td height="45" colspan="2">
		<%
		Dim MediaConn As System.Data.IDbConnection = Database.CreateConnection("DWMedia.mdb")
		Dim sCmdMedia As IDbCommand = MediaConn.CreateCommand

		sql = "SELECT TOP 1 (SELECT Count(MediaDBMedia.MediaDBMediaID) AS SumOfMediaDBMediaID FROM MediaDBMedia) AS NumOfMedias, (SELECT Count(MediaDBMedia.MediaDBMediaID) AS SumOfMediaDBMediaID FROM MediaDBMedia WHERE MediaDBMediaActive = " & Database.SQLBool(1) & ") AS NumOfActiveMedias,(SELECT Count(MediaDBGroup.MediaDBGroupID) AS SumOfMediaDBGroupID FROM MediaDBGroup) AS NumOfGroups FROM MediaDBGroup"

		sCmdMedia.CommandText = sql

		Dim drMediaReader As IDataReader = sCmdMedia.ExecuteReader()
		If drMediaReader.Read Then
		%>
			<TABLE cellspacing="3" cellpadding="0">
				<TR>
					<TD><%=Translate.Translate("Filer")%>:</TD>
					<TD><%=drMediaReader("NumOfMedias")%> (<%=Translate.Translate("%% aktive","%%",drMediaReader("NumOfActiveMedias"))%>)</TD>
				</TR>
				<TR>
					<TD><%=Translate.Translate("Grupper")%>:</TD>
					<TD><%=drMediaReader("NumOfGroups")%></TD>
				</TR>
			</TABLE>
				<%	
		End If
		drMediaReader.Dispose
		sCmdMedia.Dispose
		MediaConn.Dispose
		%>
		</td>
	</tr>
</table>
<script>
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
</script>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
