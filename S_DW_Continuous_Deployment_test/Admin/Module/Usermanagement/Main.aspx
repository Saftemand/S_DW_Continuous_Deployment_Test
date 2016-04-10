<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Main.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement.Main" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="Accordion" TagName="Accordion" Src="/Admin/Content/Accordion/Accordion.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" runat="server" />
	<link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
    <link rel="Stylesheet" href="/Admin/Module/Usermanagement/Css/UserManagementWait.css" />
	<script type="text/javascript" src="Main.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Collapse.js"></script>

    <style type="text/css">
	#accordion1
	{
		position: fixed;
		bottom: 0px;
		left: 0px;
		z-index: 1000;
		<%If Request.ServerVariables("HTTP_USER_AGENT").contains("Firefox") Then%>
        border-left:solid 1px #9FAEC2;
        <%end if %>
		border-right:solid 1px #9FAEC2;
	}
	#cellTreeCollapsed
    {
        background-color: #dae8f7;
        border-right: 1px solid #9faec2;
    }
    #ContentFrame
    {
        height:100%;
        width: 100%;
    }
	.LayoutTable .TreeContainer
    {
	    width:249px;
	    max-width:249px;
	    height:100%;
    }
	
	.nav
    {
	    width: 247px;
    }
    
    .nav .tree
    {
	    width: 246px;
    }
    
    .nav .title
    {
	    width:246px;
    }
    
    .nav .subtitle
    {
	    width:246px;
    }
    </style>
</head>
<body onload="GroupTree.onLoad(0, <%= UserID %>, '<%= Action %>');" style="height:100%; ">
    
    <!-- Page content -->
    
    <form id="GroupTreeForm" runat="server" style="height:100%; ">

		<table id="Container" style="height:100%; width:100%;" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td id="cellTreeCollapsed" style="width: 24px; display: none;">
                    <img id="imgShowNav" class="tree-toolbar-button" style="cursor: pointer" src="/Admin/images/OpenTreeView_off.gif"
                        runat="server" />
                </td>
                <td id="cellContent" style="height:100%; width:100%;">
                    <div id="cellContentLoading">
                        <div class="umgm-loading-container">
                            <div class="umgm-loading-container-inner">
                                <img src="/Admin/Images/Ribbon/UI/Overlay/wait.gif" alt="" title="" />
                                <div class="umgm-loading-container-text">
                                    One moment please...
                                </div>
                            </div>
                        </div>
                    </div>
                    <dw:ModuleAdmin ID="ModuleAdmin" runat="server">
                        <dw:Tree ContextMenuID="TreeContext" ID="UserGroupTree" runat="server" SubTitle="All groups"
                            Title="Groups" ShowRoot="false" OpenAll="false" UseSelection="true" LoadOnDemand="true"
                            UseCookies="false" UseLines="true" InOrder="true" ClientNodeComparator="GroupTree.sortNodes">
                            <dw:TreeNode ID="Root" NodeID="0" runat="server" Name="Root" ParentID="-1" />
                        </dw:Tree>
                    </dw:ModuleAdmin>
                </td>
            </tr>
        </table>

        <input type="hidden" id="noDeleteGroups" value="3,255" />
    </form>
    
    <!-- End: page content -->
    
    <!-- Group context menu -->
    
    <dw:Contextmenu OnShow="GroupTree.contextMenu.onShow(ContextMenu.callingID); GroupTree.selectGroup(ContextMenu.callingID);" ID="GroupContext" runat="server">
		<dw:ContextmenuButton ID="cbEditGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_edit.png" Text="Edit group" OnClientClick="GroupTree.contextMenu.editGroup();" />
        <dw:ContextmenuButton ID="cbMoveGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_move.png" Text="Move group" OnClientClick="GroupTree.contextMenu.moveGroup();" />
		<dw:ContextmenuButton ID="cbDeleteGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_delete.png" Text="Delete group" OnClientClick="GroupTree.contextMenu.deleteGroup();" />
		<dw:ContextmenuButton ID="cbAddSubGroup" runat="server" Divide="Before" ImagePath="/Admin/Module/Usermanagement/Images/folder_add.png" Text="New subgroup" OnClientClick="GroupTree.contextMenu.addGroup(false);" />
		<dw:ContextmenuButton ID="cbAddUser" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="New user" OnClientClick="GroupTree.contextMenu.addUser();" />
        <dw:ContextmenuButton ID="cbSortUsers" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Page_Sort.gif" Text="Sort users" OnClientClick="GroupTree.contextMenu.sortUsers();" />
        <dw:ContextmenuButton ID="cbImportUsers" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="Import users" OnClientClick="GroupTree.contextMenu.importUsers();" />
        <dw:ContextmenuButton ID="cbExportUsers" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="Export users" OnClientClick="GroupTree.contextMenu.exportUsers(false);" />
	</dw:Contextmenu>

    <!-- Group as SmartSearch context menu -->
    <dw:Contextmenu OnShow="GroupTree.contextMenu.onShow(ContextMenu.callingID); GroupTree.selectGroup(ContextMenu.callingID);" ID="GroupAsSmartSearchContext" runat="server">
		<dw:ContextmenuButton ID="cbEditSSGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_edit.png" Text="Edit group" OnClientClick="GroupTree.contextMenu.editGroup();" />
        <dw:ContextmenuButton ID="cbMoveSSGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_move.png" Text="Move group" OnClientClick="GroupTree.contextMenu.moveGroup();" />
		<dw:ContextmenuButton ID="cbDeleteSSGroup" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_delete.png" Text="Delete group" OnClientClick="GroupTree.contextMenu.deleteGroup();" />
		<dw:ContextmenuButton ID="cbAddSubSSGroup" runat="server" Divide="Before" ImagePath="/Admin/Module/Usermanagement/Images/folder_add.png" Text="New subgroup" OnClientClick="GroupTree.contextMenu.addGroup(false);" />        
	</dw:Contextmenu>
	
	<!-- End: Group context menu -->

    <!-- Tree context menu -->

    <dw:Contextmenu ID="TreeContext" runat="server">
		<dw:ContextmenuButton runat="server" ID="TreeContextNewGroup" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/folder_add.png" Text="New group" OnClientClick="GroupTree.contextMenu.addGroup(true);" />
	</dw:Contextmenu>
	
    <dw:Contextmenu ID="FolderSmartSearchContextMenu" runat="server">
        <dw:ContextmenuButton ID="cbNewSmartSearch" runat="server" Divide="None" Image="View_Add" Text="New smart search" OnClientClick="GroupTree.contextMenu.addSmartSearch();" />
    </dw:Contextmenu>

    <dw:Contextmenu ID="SmartSearchContextMenu" OnShow="GroupTree.contextMenu.onShow(ContextMenu.callingID); GroupTree.selectGroup(ContextMenu.callingID);" runat="server">
		<dw:ContextmenuButton ID="cbAddNewSmartSearch" runat="server" Divide="None" Image="View_Add" Text="New smart search" OnClientClick="GroupTree.contextMenu.addSmartSearch();" />
		<dw:ContextmenuButton ID="cbEditSmartSearch" runat="server" Divide="None" Image="View_Edit" Text="Edit smart search" OnClientClick="GroupTree.contextMenu.editSmartSearch();" />
		<dw:ContextmenuButton ID="cbDeleteSmartSearch" runat="server" Divide="None" Image="View_Delete" Text="Delete smart search" OnClientClick="GroupTree.contextMenu.deleteSmartSearch();" />
        <dw:ContextmenuButton ID="cbExportUsersFromSmartSearch" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_add.png" Text="Export users" OnClientClick="GroupTree.contextMenu.exportUsers(true);" />
	</dw:Contextmenu>

	<!-- End: Tree context menu -->

	<Accordion:Accordion SelectedButton="usermanagement" id="Accordion" runat="server" ContextMenuID="AccordionMenu" />
    <dw:ContextMenu ID="AccordionMenu" runat="server" OnClientSelectView="onAccordionContextMenuView">
        <dw:ContextMenuButton runat="server" ID="cmdPages" Views="page" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'page()');" />
        <dw:ContextMenuButton runat="server" ID="cmdFiles" Views="filemanager" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'filemanager()');" />
        <dw:ContextMenuButton runat="server" ID="cmdUserManagement" Views="usermanagement" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'userManagement()');" />
        <dw:ContextMenuButton runat="server" ID="cmdEcom" Views="ecom" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'ecom()');" />
        <dw:ContextMenuButton runat="server" ID="cmdOMC" Views="omc" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'omc()');" />
        <dw:ContextMenuButton runat="server" ID="cmdModules" Views="modules" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'modules()');" />
        <dw:ContextMenuButton runat="server" ID="cmdManagementCenter" Views="managementcenter" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'mgmtcenter()');" />
    </dw:ContextMenu>

	<script type="text/javascript">
	    resizeTree();
	</script>	
	
	<!-- Translated messages (used in JS) -->
	
    <span id="mDeleteGroup" style="display: none">
        <dw:TranslateLabel ID="lbDeleteGroup" Text="Delete this group and all subgroups and users?" runat="server" />
    </span>

    <span id="mDeleteSmartSearch" style="display: none">
        <dw:TranslateLabel ID="lbDeleteSmartSearch" Text="Delete smart search?" runat="server" />
    </span>
    
    <!-- End: Translated messages (used in JS) -->
  
   <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    
    <script type="text/javascript">
            parent.frames.left.hidePageFrame();
    </script>      
</body>
<dw:PopUpWindow ID="pwDialog" ContentUrl="" AutoReload="true" ShowClose="true" ShowCancelButton="false" ShowOkButton="False" runat="server"
    Width="360" Height="80" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" SnapToScreen="true" IsModal="true" />
</html>






    
	
    
    



