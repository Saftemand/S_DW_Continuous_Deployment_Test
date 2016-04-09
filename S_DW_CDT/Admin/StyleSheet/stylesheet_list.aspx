<%@ Page CodeBehind="stylesheet_list.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.stylesheet_list" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<html>
<head>
	<title>
		<%=Translate.JSTranslate("Stylesheet")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script type="text/javascript">
<%	If Gui.NewUI Then%>
	var openIcon = "/Admin/Images/Ribbon/Icons/Small/Document.png";
	var closedIcon = "/Admin/Images/Ribbon/Icons/Small/Document.png";
<%else %>
	var openIcon = "UserGroup_open.gif"
	var closedIcon = "UserGroup_closed.gif"
<%End if %>
</script>
	<script src="Stylesheet_TreeView.js" type="text/javascript"></script>
	<script type="text/javascript">
	//document.oncontextmenu= function(){return false}
	DeleteStylesheetID = 0
		function NoAccess(cmd) {
			var alertMsg = ''
			if (cmd == "0") {
				alertMsg = '<%=Translate.JSTranslate("Du har ikke de nødvendige rettigheder til denne funktion.")%>\n(<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("stylesheet"))%>)';
			}
			else if (cmd == "1") {
				alertMsg = '<%=Translate.JSTranslate("Du har ikke de nødvendige rettigheder til denne funktion.")%>\n(<%=Translate.JSTranslate("Nyt stylesheet")%>)';
			}
			else {
				alertMsg = '<%=Translate.JSTranslate("Du har ikke de nødvendige rettigheder til denne funktion.")%>';
			}
			
			alert(alertMsg);
		}
	
		function DWDelete(dwmsg, dwurl){
			if (confirm(dwmsg)){
				location = dwurl;
			}
		}
		
		function copy(StylesheetID){
			hideNow();
			window.StylesheetEditClass.location = "stylesheet_create.aspx?StylesheetID=" + StylesheetID;
		}
		function deletess(StylesheetID){
			hideNow();
			if (StylesheetID > 1) {
				DWDelete('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("stylesheet"))%>\n(' + DeleteStylesheetName + ')', 'stylesheet_delete.aspx?StylesheetID=' + StylesheetID + '');
			}
			else{
				alert('<%=Translate.JSTranslate("Vælg stylesheet")%>');
			}
		}
		<%
		Dim CopyIcon as String = "UserGroup_open.gif"
		Dim DeleteIcon as String = "../images/Delete.gif"
		if Gui.NewUI Then
			CopyIcon = "/Admin/Images/Ribbon/Icons/Small/AddDocument.png"
			DeleteIcon = "/Admin/Images/Ribbon/Icons/Small/Delete.png"
		end if 
		%>
		function rightClick(e,ID) {

			var evt = (window.event)?window.event:e;

			MenuHTML = "<span class=altMenuLeftPane></span>";
			MenuHTML += '<table cellpadding=0 cellspacing=0 border=0 id="altMenuTable" style="position:relative;top:0px;left:0px;">';
		<%If NumberOfStylesheets > 1 And Base.HasAccess("Light", "") Then%>
		<%Else%>
			MenuHTML += '<tr><td onclick="copy(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="<%=CopyIcon %>" align=absmiddle class=altMenuImg><%=Translate.Translate("Kopier")%></td></tr>';
		<%End If%>
			MenuHTML += '<tr><td onclick="deletess(' + ID + ');" onmouseover="this.className=\'moov\';doNotHide();" onmouseout="this.className=\'mout\';hideMenu()" class=mout nowrap><img src="<%=DeleteIcon %>" align=absmiddle class=altMenuImg><%=Translate.Translate("Slet %%", "%%", Translate.Translate("stylesheet"))%></td></tr>';

			MenuHTML += '</table>';

			menuobject = document.getElementById("Rmenu");
			menuobject.innerHTML = MenuHTML;

			documentObj = document;
			if (evt.pageX) {
				Ex = evt.pageX;
				Ey = evt.pageY;
			} else {
				Ey = evt.clientY;
				Ex = evt.clientX;
			}

			menuobject.style.left=Ex + 0;
			menuobject.style.top=Ey;

			menuobject.style.display = "block";
			
			menuobject.style.height = document.getElementById("altMenuTable").offsetHeight;
			document.getElementById("altMenuTable").style.width = (menuobject.offsetWidth-4);
            
			evt.returnValue=false;
			return false;
		}

		function SetCurrentFolder(Type, ID) {
			ActualFolder	 = ID;
			ActualFolderType = Type;
		}

		hide = true;
		function doNotHide(){
			hide = false;
		}

		function hideMenu(){
			hide = true;
			setTimeout("doTheHide()", 700);
		}

		function doTheHide(){
			if (hide) {
				document.getElementById('Rmenu').style.display = 'none';
				hide = false;
			}
		}

		function hideNow(){
			document.getElementById('Rmenu').style.display = 'none';
		}
		
		//opens the menu (or rather unhides it)
		function openMenu()
		{
			document.getElementById('TreeView').style.display='';
			document.getElementById('MenuOpen').style.display='none';
		}

	</script>
	<link rel="Stylesheet" type="text/css" href="../Stylesheet.css" />
	<link rel="Stylesheet" type="text/css" href="FileMangerTreeView.css" />
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="false" IncludeScriptaculous="false" IncludeUIStylesheet="true" ></dw:ControlResources>

	<style type="text/css">
		<%	If Gui.NewUI Then%>
	/* Alternate menus - new ui styles */
.altMenu{
	border: solid 1px #6593CF;
	background-color:#F6F6F6;
}

.altMenuLeftPane
{
	background-image:url(/Admin/Images/Ribbon/UI/Tree/img/iconBg.gif);
	background-position:left top;
	background-repeat:repeat-y;
}

.altMenuDivider{
	background-color:#9AC6FF;
}

.moov
{
	background-color:#FFE7A2;
	border:solid 1px #FFBD69;
}

	
	
	<%End If%>
	
	<%If Gui.NewUI Then %>
	tr.title
	{
		background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
	}
	.title
	{
		height:25px;
		vertical-align:middle;
		
	}
	.title strong{
		color: #15428b;
		font-size:14px;
		font-weight:bolder;
		font-family: Arial, Microsoft JhengHei;
	}
	.subtitle
	{
		background-color:<%=Gui.NewUIsubtitleBgColor()%>;
		height:20px;
		padding-left:2px;
		padding-top:1px;
		border-top:solid 1px #FFFFFF;
		border-left:solid 1px #FFFFFF;
		border-bottom:solid 1px <%=Gui.NewUIsubtitleBorderColor()%>;
		font-family: Arial, Microsoft JhengHei;
		font-weight:bold;
		color: #15428b;
	}
.Toolbar
{
	margin: 0px;
	padding: 0px;
	padding-right:2px;
	list-style: none;
	height: 26px;
	line-height: 24px;
	background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
	border-bottom: solid 1px #6F9DD9;
}
.Toolbar span .container
{
	margin-right: 5px;
	
}
.Toolbar span a
{
	margin-top: 1px;
	display: block;
	text-decoration: none;
	color: #15428b;
	cursor: default;
	height: 20px;
	line-height: 20px;
	border: solid 1px transparent;
	float: left;
}
.Toolbar span a:hover
{
	border: solid 1px #FFBD69;
	background: url('/Admin/Images/Ribbon/UI/Toolbar/PipeOver.gif');
	background-position: left center;
	background-repeat: repeat-x;
}
.Toolbar span img
{
	vertical-align:middle;
	border: 0px;
	float: left;
}
.Toolbar span img.icon
{
	vertical-align:middle;
	margin-right:3px;
	border: 0px;
	padding-left: 1px;
}

.Toolbar span img.icon
{
	vertical-align:middle;
	margin:2px;
	border: 0px;
}

	<%Else%>
	.tr{
		border:1px solid <%=Gui.NewUIborderColor()%>;
		/*border:1px solid #ACA899;*/
	}
	.title
	{
		background-color: <%=Gui.NewUIbgColor()%>;
		height:20px;
		line-height:20px;
		vertical-align:middle;
	}
	<%End If%>
	</style>
	
</head>
<body style="margin:0px;overflow:hidden">
	<table cellpadding="0" cellspacing="0" border="0" class="CLEANTABLE" width="100%" height="100%">
		<tr>
			<td width="22" align="center" id="MenuOpen" style="display: none;" valign="top" bgcolor="<%=Gui.NewUIbgColor()%>">
				<img src="images/Nothing.gif" width="3" alt="" /><img src="../images/OpenTreeView_off.gif" title="<%=Translate.JSTranslate("Vis")%>" onmouseover="this.src='../images/OpenTreeView_on.gif'" onmouseout="this.src='../images/OpenTreeView_off.gif'" onmousedown="this.src='../images/OpenTreeView_press.gif'" onmouseup="this.src='../images/OpenTreeView_on.gif'" onclick="openMenu();"><div style="writing-mode: tb-rl">&nbsp;<strong></strong></div>
			</td>
			<td width="200" valign="top" id="TreeView" style="background-color: #FFFFFF">
				<table cellpadding="0" cellspacing="0" border="0" height="100%" width="100%">
					<tr class="title" height="23">
						<td colspan="2">&nbsp;<strong><%=Translate.Translate("Stylesheet")%></strong></td>
						<td align="right">
							<img src="../images/CloseTreeView_off.gif" title="<%=Translate.JSTranslate("Skjul")%>" onmouseover="this.src='../images/CloseTreeView_on.gif'" onmouseout="this.src='../images/CloseTreeView_off.gif'" onmousedown="this.src='../images/CloseTreeView_press.gif'" onmouseup="this.src='../images/CloseTreeView_on.gif'" onclick="document.getElementById('TreeView').style.display='none';document.getElementById('MenuOpen').style.display='';" width="20" height="17"></td>
					</tr>
					<tr bgcolor="<%=Gui.NewUIborderColor()%>" height="1">
						<td colspan="3"></td>
					</tr>
					<%If Gui.NewUI Then %>
					<tr>
						<td class="subtitle" colspan="3">
							<%=Translate.Translate("Stylesheets")%>
						</td>
					</tr>
					<%End If %>
					<tr>
						<td colspan="3">
							<div style="overflow: auto; height: 100%;">
								<table cellspacing="0" border="0">
									<%	StylesheetTree((0))%>
								</table>
							</div>
						</td>
					</tr>
				</table>
			</td>
			<%If Gui.NewUI Then %>
			<td width="1" bgcolor="<%=Gui.NewUIborderColor()%>"></td>
			<%else %>
			<td width="4" bgcolor="#ECE9D8"></td>
			<%End If%>
			<td valign="top" style="background-color: #FFFFFF" width="0,100%">
				<table cellpadding="0" cellspacing="0" border="0" class="cleantable" width="100%">
					<tr bgcolor="<%=Gui.NewUIbgColor()%>" id="topbuttons">
						<td>
						<%	If Not Gui.NewUI Then%>
							<table cellpadding="4" cellspacing="0" border="0" width="100%">
								<tr bgcolor="<%=Gui.NewUIbgColor()%>" valign="top">
									<%If NumberOfStylesheets > 1 And Base.HasAccess("Light", "") Then%>
									<td align="center" width="15"></td>
									<td align="center" class="preview">
										<img src="NewStyleSheet.gif" alt="" border="0" style="filter: progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);" width="25" height="32"><br>
										<%=Translate.Translate("Nyt Stylesheet")%></td>
									<%Else%>
									<td align="center" width="15"></td>
									<td align="center" class="preview"><a href="stylesheet_create.aspx?StylesheetID=1" target="StylesheetEditClass">
										<img src="NewStyleSheet.gif" alt="" border="0"><br>
										<%=Translate.Translate("Nyt Stylesheet")%></a></td>
									<%End If%>
									<td align="center" width="15"></td>
									<td align="center" class="preview"><a href="#" onclick="deletess(DeleteStylesheetID)" id="DeleteButton">
										<img src="StyleSheet_Delete.gif" alt="" border="0"><br>
										<%=Translate.Translate("Slet %%", "%%", Translate.Translate("stylesheet"))%></a></td>
									<td align="center" width="15"></td>
									<td align="center" class="preview"><a href="font_list.aspx" target="StylesheetEditClass">
										<img src="/Admin/images/icons/Fonts.gif" alt="" border="0"><br>
										<%=Translate.Translate("Skrifttyper")%></a></td>
									<td align="center" width="15"></td>
									<td align="center" class="preview"><a href="Dropdown_list.aspx" target="StylesheetEditClass">
										<img src="DropdownAdmin.gif" alt="" border="0"><br>
										<%=Translate.Translate("Dropdown")%></a></td>
									<%If Base.HasVersion("18.1.1.0") Then%>
									<td align="center" width="15"></td>
									<td align="center" class="preview"><a href="PageFeature_List.aspx" target="StylesheetEditClass">
										<img src="PageFeaturesAdmin.gif" alt="" border="0"><br>
										<%=Translate.Translate("Side egenskaber")%></a></td>
									<%End If%>
									<td align="center" width=15></td>
									<td class="preview" valign="top" align="center" width="48">
											<a href="#" onClick="<%=Gui.Help("stylesheet", "gui.tabs.stylesheet")%>;">
												<img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.JSTranslate("Hjælp")%>" border="0">
												<br />
												<%=Translate.Translate("Hjælp")%>
											</a>
									</td>
								</tr>
							</table>
							<%	Else%>
							<div class="Toolbar" id="Toolbar1">
		<span><img src="/Admin/Images/Ribbon/UI/Toolbar/Start.gif" style="margin-top: 4px; margin-bottom:4px; margin-left: 2px;" alt="" /></span>
		<span><a href="stylesheet_create.aspx?StylesheetID=1" target="StylesheetEditClass"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/AddDocument.png" alt="" class="icon" /><%=Translate.Translate("Nyt Stylesheet")%></span></a></span>
		<span><a href="#" onclick="deletess(DeleteStylesheetID)"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" class="icon" /><%=Translate.Translate("Slet %%", "%%", Translate.Translate("stylesheet"))%></span></a></span>
		<span><a href="font_list.aspx" target="StylesheetEditClass"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/font.png" alt="" class="icon" /><%=Translate.Translate("Skrifttyper")%></span></a></span>
		<span><a href="Dropdown_list.aspx" target="StylesheetEditClass"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/Tree.png" alt="" class="icon" /><%=Translate.Translate("Dropdown")%></span></a></span>
		<span><a href="PageFeature_List.aspx" target="StylesheetEditClass"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/DocumentProperties.png" alt="" class="icon" /><%=Translate.Translate("Side egenskaber")%></span></a></span>
		<span style="float:right;"><a href="#" onclick="<%=Gui.Help("stylesheet", "gui.tabs.stylesheet")%>"><span class="container"><img src="/Admin/Images/Ribbon/Icons/Small/Help.png" alt="" class="icon" /><%=Translate.Translate("Hjælp")%></span></a></span>
</div>

							<%End If%>
						</td>
					</tr>
					<%If Gui.NewUI Then %>
					
					<%else %>
					<tr bgcolor="<%=Gui.NewUIbgColor()%>" height="4">
						<td background="../Images/spacerbg.gif"></td>
					</tr>
					<%End If%>
				</table>
				<iframe src="about:blank" frameborder="0" style="padding-bottom:25px;" width="100%" height="100%" id="StylesheetEditClass" name="StylesheetEditClass"></iframe>
			</td>
			<%If Gui.NewUI Then %>
			<td width="1" bgcolor="<%=Gui.NewUIborderColor()%>"></td>
			<%else %>
			<td width="4" bgcolor="#ECE9D8"></td>
			<%End If%>
		</tr>
	</table>
	<div id="Rmenu" class="altMenu" style="display: none;">
	</div>
	<%If Request("NoAccess") = "1" Then%>
	<script type="text/javascript">
	NoAccess("<%=Request("NoAccessID")%>");
	</script>
<%End If%>

</body>
</html>
<%
Translate.GetEditOnlineScript()
%>