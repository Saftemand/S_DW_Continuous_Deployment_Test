<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Menu" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim RequestAction As String
Dim MoveID As String
Dim CopyID As String
</SCRIPT>

<%
Server.ScriptTimeOut = 90

RequestAction = request.QueryString("RequestAction")

MoveID = request.QueryString("MoveID")
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
<title><%=Translate.JSTranslate("Menu")%>-<%=Translate.JSTranslate("Afdelinger","9")%></title>
<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<script src="Menu_TreeView.js" type="text/javascript"></script>
<script language=javascript >

function getDepartmentList() {
    return document.getElementById('DepartmentList');
}

function DeleteDepartment(ID)
{
    var dep = document.getElementById('s' + ID);
    var DepName = '';
    
	if(dep)
 	{
 		DepName = dep.innerText;
 		if(!DepName)
 		    DepName = dep.innerHTML;
 	}
 	
 	hideNow();
 	if(confirm("Delete Department (" + DepName + ")?"))
 	{
 		getDepartmentList().src = "Department_Delete.aspx?ID=" + ID;
 	}
 }

function CopyDepartment(ID)
{
	CopyMoveInProcess = 1
	
	CopydepWindow = window.open("menu.aspx?CopyID=" + ID + "&RequestAction=CopyDepartment", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();	
}

function CopyDepartmentTo(ID)
{
	location = "Department_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function CopyEmployeeTo(ID)
{
	location = "Employee_Copy.aspx?ID=" + ID + "&CopyID=<%=CopyID%>";
}

function MoveDepartment(ID)
{
	CopyMoveInProcess = 1	
	movedepWindow = window.open("menu.aspx?MoveID=" + ID + "&RequestAction=MoveDepartment", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
	hideNow();
	
}

function MoveDepartmentTo(ID)
{
	location = "Department_move.aspx?ID=" + ID + "&MoveID=<%=MoveID%>";
}

function MoveEmployeeTo(ID)
{
    var from = <%=_moveFrom%>;
	location = "Employee_move.aspx?MoveFrom="+ from + "&ID=" + ID + "&MoveID=<%=MoveID%>";
}

function EditDepartment(ID)
{
	getDepartmentList().src = "Department_Add.aspx?Id="+ID;
	hideNow();
}

function NewSubDepartment(ID)
{
	getDepartmentList().src = "Department_Add.aspx?Dept="+ID;
	hideNow();
}

function NewEmployee(ID)
{
	getDepartmentList().src = "Employee_Add.aspx?Dept="+ID;
	hideNow();
}

function rightClick2(e)
{
    if(!e)
        e = event;
    
    e.returnValue = false;
    
    if(typeof(e.preventDefault) == 'function')
        e.preventDefault();
	
	return false;
}

cellObject = ""
function rightClick(DepID, co, e)
{
    var currentNode = document.getElementById("s" + DepID);
	
	if(cellObject)
		cellObject.style.fontWeight = "";
	
	if(currentNode && currentNode.style)
	{
		currentNode.style.fontWeight = "bold";
		cellObject = currentNode;
	}
	
	showMenu(DepID, null, null, null, null, e);
	
	return rightClick2(e);	
}

function showMenu(ID, menuobject, documentObj, Ey, Ex, e)
{
	objJsdoc = "";
	MenuHTML = "<span class=altMenuLeftPane></span>";
	MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 width="100%" style="position:relative;top:0px;left:0px;">';
	MenuHTML += '<tr><td onClick="NewSubDepartment('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Folder_New.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Ny")%>&nbsp;<%=Translate.JSTranslate("afdeling")%></td></tr>';	
	MenuHTML += '<tr><td onClick="NewEmployee('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/EmployeeFields.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Ny")%>&nbsp;<%=Translate.JSTranslate("medarbejder")%></td></tr>';	
	MenuHTML += '<tr><td onClick="EditDepartment('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Folder_edit.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Rediger")%>&nbsp;<%=Translate.JSTranslate("afdeling")%></td></tr>';	
	MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
	<%If Base.HasVersion("18.5.1.0") Then%>
	MenuHTML += '<tr><td onClick="MoveDepartment('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Folder_Move.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Flyt")%>&nbsp;<%=Translate.JSTranslate("afdeling")%></td></tr>';	
	MenuHTML += '<tr><td onClick="CopyDepartment('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Folder_Copy.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Kopier")%>&nbsp;<%=Translate.JSTranslate("afdeling")%></td></tr>';
	<%End If%>
	MenuHTML += '<tr><td align=right><img src="/Admin/images/nothing.gif" class=altMenuDivider></td></tr>';
	MenuHTML += '<tr><td onClick="DeleteDepartment('+ID+');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout><img src="/Admin/images/Icons/Page_Delete.gif" align=absmiddle class=altMenuImg><%=Translate.JSTranslate("Slet")%>&nbsp;<%=Translate.JSTranslate("afdeling")%></td></tr>';	
	MenuHTML += '</table>';
	
	if(!e)
	    e = event;
	
	if(!menuobject)
	{
		menuobject = document.getElementById('Rmenu');
	}
	if(!documentObj)
	{
		documentObj = document;
	}

	menuobject.innerHTML = MenuHTML;
	//menuobject.setCapture();
	
	if(!Ey)
	{ 
		Ey = e.clientY;
		Ex = e.clientX;
		menuobject.style.top=Ey + documentObj.body.scrollTop;
		if (Ex+105<195)
		{
			menuobject.style.left=Ex + 0;
		}
		else
		{
			menuobject.style.left=195-120;
		}
	}
	else
	{
		menuobject.style.top=Ey + documentObj.body.scrollTop - 150;
		menuobject.style.left=Ex-50;
	}
	//menuobject.releaseCapture();
	menuobject.style.display = "";
}

hide = true;

function doNotHide()
{
	hide = false;
}

function hideMenu()
{
	hide = true;
	setTimeout("doTheHide()", 2500);
}

function doTheHide()
{
	if(hide)
	{
		document.getElementById('Rmenu').style.display = 'none';
		if(cellObject.style){
			cellObject.style.fontWeight = "";
		}
		hide = false;
	}
}

function hideNow()
{
	document.getElementById('Rmenu').style.display = 'none';
	if(cellObject.style)
	{
		cellObject.style.fontWeight = "";
	}
}

function openMenu()
{
	top.MainFrame.cols='200,*';
	document.getElementById('MenuTable').style.display='';
	document.getElementById('MenuOpen').style.display='none';
}

function setContentCell()
{
	TreeStartHeight = 0;
	if(document.getElementById('TreeStart'))
	{
		TreeStartHeight = document.getElementById('TreeStart').offsetHeight;
	}	
	TreeEndHeight = 0;
	if(document.getElementById('TreeEnd'))
	{
		TreeEndHeight = document.getElementById('TreeEnd').offsetHeight;
	}	
	if(document.getElementById('ContentCell'))
	{
		height = document.body.clientHeight;
		document.getElementById('ContentCell').style.height = height - TreeEndHeight - TreeStartHeight-1;
	}

	SetFrameSource()	
}

function SetFrameSource()
{
    var frame = getDepartmentList();
    
	if(SelectedDepartmentID == 0 && frame)
		frame.src = "Department_Empty.aspx";
}

</script>
</head>
<body onMouseover="try { this.style.cursor = 'default' } catch(ex) { }" onContextmenu="return rightClick2(event);" onClick="hideNow();" onLoad="setContentCell();" style="background-color:#ECE9D8;margin:0px;" scroll="no">
<table cellspacing=0 cellpadding=0 border=0 ID=MenuOpen style="display:none;" width="200">
	<tr height=17>
		<td align=center><img src="/Admin/images/OpenTreeView_off.gif" onmouseover="this.src='/Admin/images/OpenTreeView_on.gif'" onmouseout="this.src='/Admin/images/OpenTreeView_off.gif'" onmousedown="this.src='/Admin/images/OpenTreeView_press.gif'" onmouseup="this.src='/Admin/images/OpenTreeView_on.gif'" onClick="openMenu();"></td>
	</tr>
	<tr>
		<td><DIV STYLE="writing-mode:tb-rl">&nbsp;<strong> <%=Translate.Translate("Grupper")%></strong></div></td>
	</td>
</table>
<table cellspacing=0 cellpadding=0 border=0 height=100% width=100% ID=MenuTable style="display:">
	<tr bgColor="#FFFFFF">
		<td width=5 bgColor="#ECE9D8" rowspan=2></td>
		<td valign=top width=190>
			<table cellspacing=0 cellpadding=0 border=0 width=190>
				<tr height=23 bgColor="#ECE9D8" ID=TreeStart>
					<td colspan=3>
						<table cellspacing=0 cellpadding=0 border=0 width="100%">
							<tr>
								<td>&nbsp;<strong><%=Translate.Translate("Afdelinger")%></strong></td>
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
							<%=Tree.Tree%>			
						</table>
						</Div>
					</td>
				</tr>
			</table>
		</td>
		<td width=5 bgColor="#ECE9D8" rowspan=2></td>
		<td valign=top>
		<asp:Panel ID=pnlHorizontalMenu Width="100%" Height="100%" Runat=server>
			<table cellspacing=0 cellpadding=0 border=0 width=100% height=100%>
				<tr height=50 bgColor="#ECE9D8">
					<td width=5 bgColor="#ECE9D8"></td>
					<td>
					
						<table cellspacing=0 cellpadding=4 border=0>
							<tr valign="top">								
								<td align= center class=preview><a href="Department_Add.aspx" target="DepartmentList"><img src="/Admin/Images/Icons/Module_Shop_NewGroup.gif" alt="" border="0"><br /><%=Translate.Translate("Ny")%><br/><%=Translate.Translate("Afdeling")%></a></td>
								<td align= center width=15></td>								
								<td align= center class=preview><a href="CustomFields_List.aspx?context=AccessCustomFieldDepartment" target="DepartmentList"><img src="/Admin/Images/Icons/FolderFields.gif" alt="" border="0"><br /><%=Translate.Translate("Afdelingsfelter")%></a></td>
								<td align= center width=15></td>
								<td align= center class=preview><a href="CustomFields_List.aspx?context=AccessUser" target="DepartmentList"><img src="/Admin/Images/Icons/EmployeeFields.gif" alt="" border="0"><br /><%=Translate.Translate("Medarbejder")%><br/><%=Translate.Translate("felter")%></a></td>
								<td align= center width=15></td>
								<td align= center class=preview><a href="Competence_List.aspx" target="DepartmentList"><img src="/Admin/Images/Icons/Competence.gif" alt="" border="0"><br /><%=Translate.Translate("Kompetencer")%></a></td>
								<td align= center width=15></td>
								<td align= center class=preview><a href="Employee_Options.aspx" target="DepartmentList"><img src="/Admin/Images/Icons/ControlPanel.gif" alt="" border="0"><br /><%=Translate.Translate("Valgmuligheder")%></a></td>
								<td align= center width=15></td>
								<td align= center class=preview>
								    <a href="#" onClick="<%=Gui.Help("HR", "modules.hr.general")%>;">
										<img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" border="0"><br />
										<%=Translate.Translate("Hjælp")%>
									</a>
								</td>
								<td align= center width=15></td>
							</tr>
						</table>
						
					</td>
				</tr>
				<tr>
					<td width=5 bgColor="#F9F8F3"></td>
					<td>
						<iframe width=100% height=100% name="DepartmentList" id="DepartmentList"  src="" LEFTMARGIN="10" TOPMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0" BORDER="0" FRAMEBORDER="0"></iframe>
					</td>
				</tr>
			</table>
			</asp:Panel>	
		</td>
	</tr>
	<tr ID=TreeEnd height=45>
		<td colspan=2>
			<%=StaticticInformation%>
		</td>
	</tr>
</table>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
</body>
</html>
<%Translate.GetEditOnlineScript()%>
<%=Tree.ExpandTreeByNode%>			
