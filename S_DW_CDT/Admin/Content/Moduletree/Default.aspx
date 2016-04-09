<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.Moduletree._Default" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="Accordion" TagName="Accordion" Src="/Admin/Content/Accordion/Accordion.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>
	<dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Collapse.js"></script>
    <script type="text/javascript" src="/Admin/Filemanager/Upload/js/EventsManager.js"></script>
	<script type="text/javascript">
	    _keycache = "TreeModulesIsCollapsed";

	    function setTreeMode(mode) {
	        location.href = 'Default.aspx?treeMode=' + mode;
	    }

		/* Content menu */
		function editModulePermissions() {
		    var separatorIndex = -1;
		    var itemID = ContextMenu.callingItemID;
		    var moduleName = '', moduleSystemName = '';

		    separatorIndex = itemID.indexOf('@');

		    if (separatorIndex > 0) {
		        moduleSystemName = itemID.substr(0, separatorIndex);
		        moduleName = itemID.substr(separatorIndex + 1);
		    } else {
		        moduleSystemName = itemID;
		    }

		    dialog.setTitle('EditModulePermissionsDialog', '<%=Translate.JsTranslate("Module permissions") %>: ' + moduleName);

		    document.getElementById('EditModulePermissionsDialogIFrame').src = '/Admin/FastLoadRedirect.aspx?redirect=/Admin/Module/ModulePermissionEdit.aspx?ModuleSystemName=' + moduleSystemName + '%26CloseOnExit=True%26DialogID=EditModulePermissionsDialog';
		    dialog.show('EditModulePermissionsDialog');
		}

		function openModule() {
		    var itemID = ContextMenu.callingItemID;
		    var moduleName = '', moduleSystemName = '';

		    separatorIndex = itemID.indexOf('@');

		    if (separatorIndex > 0) {
		        moduleSystemName = itemID.substr(0, separatorIndex);
		        moduleName = itemID.substr(separatorIndex + 1);
		    } else {
		        moduleSystemName = itemID;
		    }

            new Ajax.Request('Default.aspx?AJAX=OpenModule&ModuleSystemName=' + moduleSystemName, {
                onSuccess: function (response) {
                    // Get values from response
                    var jsonObj = response.responseText.evalJSON();
                    var urlValue = jsonObj.urlValue;
                    $("ContentFrame").contentDocument.location.href = urlValue;
                },

                onFailure: function () {
                    alert('Something went wrong!');
                }
            });

		    //$("ContentFrame").contentDocument.location.href = 'ModuleContent.aspx?ModuleSystemName=' + moduleSystemName;
		}

        /* Accordion */
        function onAccordionContextMenuView(sender, arg) {
            return arg.callingID;
        }

        function onAccordionContextMenu(sender, arg) {
            window.open('/Admin/Default.aspx?accordionAction=' + arg);
            return false;
        }

	</script>

    <style type="text/css">
        
	body
	{
		background: <%=Gui.NewUIbgColor()%>;
	}
			        
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
    
    .contextmenu a
    {
	    width:180px;
    }
    
    .dtree .dis
    {
        background-color: transparent;
        -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)";
        -moz-opacity: 0.6;
        color: Gray;
    }

    .dtree .bold
    {
        font-weight: bold;
        color: #003366;
    }
    
    </style>

</head>
<body id="body" runat="server">
	<form id="form1" runat="server" style="height: 100%;" enableviewstate="false">
		<input type="hidden" id="rootFolder" runat="server" />
        <table id="Container" style="width:100%; height:100%;" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td id="cellTreeCollapsed" style="width: 24px; display: none;">
                    <img id="imgShowNav" class="tree-toolbar-button" style="cursor: pointer" src="/Admin/images/OpenTreeView_off.gif"
                        runat="server" />
                </td>
                <td style="height:100%; width:100%;">
		            <dw:ModuleAdmin runat="server" ContentFrameSrc="EntryContent.aspx" ID="ModuleAdmin" EnableViewState="false">
			            <dw:Tree ID="Tree1" runat="server" Title="Modules" EnableControlMenu="true" ShowRoot="false" OpenAll="false" UseSelection="true" UseCookies="false" UseLines="true" AutoID="false" LoadOnDemand="false" CloseSameLevel="false" UseStatusText="false" InOrder="true" EnableViewState="false">
				            <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Modules" ParentID="-1">
				            </dw:TreeNode>
			            </dw:Tree>
		            </dw:ModuleAdmin>
                </td>
            </tr>
        </table>

        <dw:Contextmenu ID="mnuModulesPermission" runat="server">
		    <dw:ContextmenuButton ID="mmpiPermission" runat="server" ImagePath="/Admin/Images/Icons/user1_lock.png" Text="Permissions" OnClientClick="editModulePermissions();" />
	    </dw:Contextmenu>

		<dw:ContextMenu runat="server" ID="mnuModules" Translate="true" >
			<dw:ContextMenuButton runat="server" ID="mmiOpen" DoTranslate="True" ImagePath="/Admin/Images/Icons/ModuleOpen_small.png" Text="Edit module settings" OnClientClick="openModule();"  />
			<dw:ContextMenuButton runat="server" ID="mmiPermission"  DoTranslate="True" ImagePath="/Admin/Images/Icons/user1_lock.png" Text="Permissions" OnClientClick="editModulePermissions();" />
		</dw:ContextMenu>

	    <Accordion:Accordion SelectedButton="modules" id="Accordion" runat="server" ContextMenuID="AccordionMenu" />
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
		    var accHeight = $("accordion1") ? $("accordion1").offsetHeight : 0;
		    $("ContentFrame").style.height = "100%";
	       	$("tree1").style.height = ($("tree1").offsetHeight - accHeight) + "px";
		</script>


        <dw:Dialog runat="server" ID="EditModulePermissionsDialog" Width="316" Title="Module permission" ShowClose="true" HidePadding="true">
	        <iframe id="EditModulePermissionsDialogIFrame" style="width:300px; height: 510px;"></iframe>
	    </dw:Dialog>

	</form>

    <script type="text/javascript">
        window.onload = function () {
            parent.frames.left.hidePageFrame();
        }
    </script>

</body>
<dw:PopUpWindow ID="pwDialog" ContentUrl="" AutoReload="true" ShowClose="true" ShowCancelButton="false" ShowOkButton="False" runat="server"
    Width="360" Height="80" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" SnapToScreen="true" IsModal="true" />

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>

</html>
