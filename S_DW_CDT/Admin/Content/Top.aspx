<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Top.aspx.vb" Inherits="Dynamicweb.Admin.Top" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%
	Response.Expires = -100
	Dim LockStylesheet As Boolean = Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockStylesheet"))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<dw:ControlResources runat="server"></dw:ControlResources>
	<link href="Top.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
		function HandleClick(obj) {
//		var o = obj.parentNode;
//		//alert(o.offsetTop);
//		alert($(o).cumulativeOffset().left + ' ' + ($(o).cumulativeOffset().top + $(o).getHeight()));
		}
		function openPublicSite() {
			var path = '/Default.aspx?AreaID=' + parent.left.areaid;
			window.open(path);
		}
		function setPass() {
		    top.right.location = '/Admin/Content/Management/Pages/ChangePassword.aspx';		    
		}
	</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" width="100%" style="height:36px;">
		<tr>
			<td valign="bottom">
				<dw:Toolbar ID="Toolbar1" runat="server">
					<dw:ToolbarButton runat="server" Divide="None" Image="Home" Text="Min side" ShowText="false" OnClientClick="top.right.location='/Admin/MyPage/default.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton runat="server" Divide="None" ImagePath="/Admin/images/Icons/Logoff.gif" Text="Logaf" ShowText="false" OnClientClick="top.location='/Admin/Access/Access_Logoff.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton runat="server" Divide="None" Image="Key" Text="Skift kodeord" ShowText="false" OnClientClick="setPass();">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="translation" runat="server" Divide="None" ImagePath="/Admin/images/icons/cplOnlineTranslation_small.gif" Text="Oversættelse" ShowText="false" OnClientClick="location='/Admin/Top.aspx?OnlineTrans=OnlineTrans';">
					</dw:ToolbarButton>
					<dw:ToolbarButton runat="server" Divide="Before" Image="ControlPanel" Text="Kontrol Panel" OnClientClick="top.right.location='/Admin/Module/ControlPanel.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton runat="server" Divide="none" Image="Module" Text="Moduler" OnClientClick="top.right.location='/Admin/module/Modules.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="filemanager" runat="server" Divide="Before" Image="Folder" Text="Filarkiv" OnClientClick="top.right.location='/Admin/FileManager/Browser/Default.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="Stylesheet" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Stylesheet_Small.gif" Text="Stylesheet" OnClientClick="top.right.location='/Admin/Stylesheet/stylesheet_list.aspx';">
					</dw:ToolbarButton>					
					<dw:ToolbarButton ID="Users" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Brugerstyring" OnClientClick="top.right.location='/Admin/Module/UserManagement/Main.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="UserManagement" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="UserManagement" OnClientClick="top.right.location='/Admin/Module/UserManagement/Main.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="Shop" runat="server" Divide="Before" ImagePath="/Admin/Images/Icons/Module_Shop_small.gif" Text="Shop" OnClientClick="top.right.location='/Admin/Module/Shop/Menu.aspx';">
					</dw:ToolbarButton>
					<dw:ToolbarButton ID="eCommerce" runat="server" Divide="Before" ImagePath="/Admin/Images/Icons/Module_eCom_Extended_small.gif" Text="eCommerce" OnClientClick="top.right.location='/Admin/Module/eCom_Catalog/EcomFrame.aspx';">
					</dw:ToolbarButton>
				</dw:Toolbar>
			</td>
			<td align="right" style="vertical-align:middle;padding-right:10px;padding-top:0px;"><a href="#" onclick="openPublicSite();">
				<img src="/Admin/access/DW_hvid_150.png" border="0" alt="<%=Translate.JSTranslate("Vis offentlig site")%>" /></a></td>
		</tr>
	</table>
	
</body>
</html>
