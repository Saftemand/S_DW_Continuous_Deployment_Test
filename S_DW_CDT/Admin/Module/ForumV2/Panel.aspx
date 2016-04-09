<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Panel.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Panel" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HTML>
	<HEAD>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
			<script src="Navigation.js" language="javascript"></script>
			<script language="javascript">
		<!--
		function LoadPage(img, page)
		{
			if(img.style.cssText == "")
				parent.frames["ForumV2Main"].location.href = page;
		}
		
		function InitPage()
		{
			<asp:Literal id="AccessProc" runat="server"></asp:Literal>
		}
		//-->
			</script>
	</HEAD>
	<body style="BACKGROUND-COLOR: #ece9d8" onload="InitPage();">
		<table cellspacing="2" cellpadding="0" border="0" height="50" width="100%">
			<tr colspan="7"><td><img src="x.gif" height="3" width="1" border="0" /></td></tr>
			<tr>
				<td vAlign="top" align="center" valign="top">
					<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgCategory);" onmouseout="SwitchAnchorCursor(this, imgCategory);" onclick="javascript:LoadPage(imgCategory, 'Category_Edit.aspx');">
						<img name="imgCategory" id="imgCategory" src="/Admin/Images/ForumV2/Category_Add.gif" alt="<%=Translate.Translate("Ny kategori")%>"	border="0">
					</a>
				</td>
				<td valign="top" align="center">
					<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgThread);"	onmouseout="SwitchAnchorCursor(this, imgThread);" onclick="javascript:LoadPage(imgThread, 'Thread_Edit.aspx');">
						<img name="imgThread" id="imgThread" src="/Admin/Images/ForumV2/Thread_Add.gif" alt="<%=Translate.Translate("Ny tråd")%>" border="0">
					</a>
				</td>
				<td valign="top" align="center">
					<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgPost);" onmouseout="SwitchAnchorCursor(this, imgPost);" onclick="javascript:LoadPage(imgPost, 'Post_Edit.aspx');"><img name="imgPost" id="imgPost" src="/Admin/Images/ForumV2/Post_Add.gif" alt="<%=Translate.Translate("Nyt indlæg")%>" border="0">
					</a>
				</td>
				<td valign="top" align="center">
					<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgSettings);" onmouseout="SwitchAnchorCursor(this, imgSettings);" onclick="javascript:LoadPage(imgSettings, 'Settings.aspx');">
						<img name="imgSettings" id="imgSettings" src="/Admin/Images/ForumV2/Settings.gif" alt="<%=Translate.Translate("Indstillinger")%>" border="0">
					</a>
				</td>
			        <td vAlign="top" align="center"><a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgSearch);" onclick="javascript:LoadPage(imgSearch, 'Search.aspx');" onmouseout="SwitchAnchorCursor(this, imgSearch);"><IMG id="imgSearch" alt="<%=Translate.Translate("Søg")%>" src="/Admin/Images/ForumV2/Search.gif" border="0" name="imgSearch">
					</a>
				</td>
				<td width="100%">&nbsp;<A oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgSettings);"
						onclick="javascript:LoadPage(imgSettings, 'Settings.aspx');" onmouseout="SwitchAnchorCursor(this, imgSettings);"></A>
				</td>
				<td align="right" valign="top">
					<a href="#" onClick="<%=Gui.Help("ForumV2", "modules.ForumV2")%>;"><img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" width="32" height="32" border="0">
				
			</a>
		</td>
			</tr>
			<tr>
				<td nowrap>&nbsp;<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgCategory);" onmouseout="SwitchAnchorCursor(this, imgCategory);" onclick="javascript:LoadPage(imgCategory, 'Category_Edit.aspx');"><%=Translate.Translate("Ny kategori")%></a>&nbsp;</td>
				<td nowrap>&nbsp;<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgThread);"	onmouseout="SwitchAnchorCursor(this, imgThread);" onclick="javascript:LoadPage(imgThread, 'Thread_Edit.aspx');"><%=Translate.Translate("Ny tråd")%></a>&nbsp;</td>
				<td nowrap>&nbsp;<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgPost);" onmouseout="SwitchAnchorCursor(this, imgPost);" onclick="javascript:LoadPage(imgPost, 'Post_Edit.aspx');"><%=Translate.Translate("Nyt indlæg")%></a>&nbsp;</td>
				<td nowrap>&nbsp;<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgSettings);" onmouseout="SwitchAnchorCursor(this, imgSettings);" onclick="javascript:LoadPage(imgSettings, 'Settings.aspx');"><%=Translate.Translate("Indstillinger")%></a>&nbsp;</td>
				<td nowrap>&nbsp;<a oncontextmenu="return false;" onmouseover="SwitchAnchorCursor(this, imgSearch);" onclick="javascript:LoadPage(imgSearch, 'Search.aspx');" onmouseout="SwitchAnchorCursor(this, imgSearch);"><%=Translate.Translate("Søg")%></a>&nbsp;</td>
				<td width="100%">&nbsp;</td>
				<td nowrap align="right">&nbsp;<a href="#" onClick="<%=Gui.Help("ForumV2", "modules.ForumV2")%>;"><%=Translate.Translate("Hjælp")%></a></td>
			</tr>
		</table>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>