<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin._Default2" EnableViewState="false" %>
<%@ Register TagPrefix="Accordion" TagName="Accordion" Src="/Admin/Content/Accordion/Accordion.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
	</dw:ControlResources>
    <script type="text/javascript" src="Default.js"></script>
	<script type="text/javascript" src="/Admin/Content/JsLib/dw/Collapse.js"></script>
    <script type="text/javascript" src="/Admin/Filemanager/Upload/js/EventsManager.js"></script>
	<script type="text/javascript">
	    _keycache = "TreeManagementIsCollapsed";

	    function go(lnk) {
	        window.open(lnk, 'ManagementWindow');
	    }

	    function setTreeHeight() {
	        var accordionName = "accordion1";
	        var accHeight = document.getElementById(accordionName) && document.getElementById(accordionName).offsetHeight || 0;
	        document.getElementById("tree1").style.height = (document.getElementById("tree1").offsetHeight - accHeight) + "px";
	    }

        function addStylesheet(copyID) {
	        var frame = document.getElementById('ContentFrame');

	        if (!copyID) {
	            copyID = 1;
	        }
	        
	        if(frame)
	            frame.contentWindow.document.location = '/Admin/Content/Management/Pages/DesignerStylesheetNew_cpl.aspx?StylesheetID=' + copyID;
	    }

	    function copyStylesheet() {
	        addStylesheet(ContextMenu.callingItemID);
	    }

	    function deleteStylesheet() {
	        var stylesheetID = ContextMenu.callingItemID;
	        
	        ContextMenu.hide();
	        if (confirm('<%=Translate.JSTranslate("Are you sure you want to delete this stylesheet ?")%>')) {
	            location = '/Admin/Stylesheet/Stylesheet_delete.aspx?Caller=ManagementCenter&StylesheetID=' + stylesheetID;
	        }
	    }

	    function deleteRepository() {
	        var repositoryId = ContextMenu.callingItemID.replace("repositories-", "");
	        var msg = '<%=Translate.JSTranslate("Are you sure you want to delete %%? This will delete the repository, including all diagnostics and indexes related to it.")%>';
	        msg = msg.replace('%%', repositoryId);

	        ContextMenu.hide();
	        if (confirm(msg)) {

	            var o = new overlay('PleaseWait');
	            o.show();

	            var url = "/Admin/Api/repositories/_sys_delete_repository/" + repositoryId + "/";

	            new Ajax.Request(url, {
	                asynchronous: false,
	                method: "get",
	                onSuccess: function (response) {
	                    o.hide();
	                    location.href = 'Default.aspx?OpenTo=Repositories';
	                },
	                onFailure: function (response) {
	                    o.hide();
	                    alert(response.transport.responseText);
	                }
	            });

	        }
	    }

	    function editModulePermissions() {
	        var separatorIndex = -1;
	        var itemID = ContextMenu.callingItemID;
	        var moduleName = '', moduleSystemName = '';

	        separatorIndex = itemID.indexOf('@');
            
            if(separatorIndex > 0) {
                moduleSystemName = itemID.substr(0, separatorIndex);
                moduleName = itemID.substr(separatorIndex + 1);
            } else {
                moduleSystemName = itemID;
            }

	        dialog.setTitle('EditModulePermissionsDialog', '<%=Translate.JsTranslate("Module permissions") %>: ' + moduleName);

	        document.getElementById('EditModulePermissionsDialogIFrame').src = '/Admin/FastLoadRedirect.aspx?redirect=/Admin/Module/ModulePermissionEdit.aspx?ModuleSystemName=' + moduleSystemName + '%26CloseOnExit=True%26DialogID=EditModulePermissionsDialog';
	        dialog.show('EditModulePermissionsDialog');
	    }

	    function onAccordionContextMenuView(sender, arg) {
	        return arg.callingID;
	    }

	    function onAccordionContextMenu(sender, arg) {
	        window.open('/Admin/Default.aspx?accordionAction=' + arg);
	        return false;
	    }

	    function newRepository() {
	        dialog.show("dlgNewRepository");
	        $("txtNewRepositoryName").focus();
        }

        function newRepositoryCreate() {
            var o = new overlay('PleaseWait');
            o.show();

            var repoName = $('txtNewRepositoryName').value;

            if (repoName === '') {
                alert('<%=Translate.Translate("Repository name cannot be empty")%>.');
                o.hide();
                $("txtNewRepositoryName").focus();
                return;
            }

            if (repoName.indexOf("-") > -1) {
                alert('<%=Translate.JsTranslate("Repository name cannot contain '-'")%>.');
                o.hide();
                $("txtNewRepositoryName").focus();
                return;
            }

            new Ajax.Request("/Admin/Module/Repositories/ViewRepository.aspx?CMD=Create&Name=" + repoName, {
                asynchronous: false,
                method: "get",
                onSuccess: function(response) {
                    o.hide();
                    location.href = 'Default.aspx?OpenTo=repositories-' + repoName;
                },
                onFailure: function(response) {
                    o.hide();
                    alert(response.transport.responseText);
                }
            });
        }

        function handleSubmit() {
            if ($("txtNewRepositoryName").value !== '') {
                newRepositoryCreate();
                return false;
            }

            return true;
        }
	</script>
	<style type="text/css">
	#accordion1
	{
		position:fixed;
		bottom:0px;
		left:0px;
		z-index:1000;
		<%If Request.ServerVariables("HTTP_USER_AGENT").contains("Firefox") Then%>
        border-left:solid 1px #9FAEC2;
        border-right:solid 1px #9FAEC2;
        <%else %>
        border-right:solid 1px #9FAEC2;
        <%end if %>		
	}
	#cellTreeCollapsed
    {
        background-color: #dae8f7;
        border-right: 1px solid #9faec2;
    }
	.LayoutTable .TreeContainer
    {
	    width:249px;
	    max-width:249px;
	    height:100%;
    }
    .LayoutTable .ContentFrameContainer
    {
	    width: 100%;
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
    .delete-container p
    {
        font-weight: bold;
        margin: 15px;
    }
    .delete-container ul,
    .delete-container ul li
    {
        list-style: none;
        margin: 0px;
        padding: 0px;
    }
    .delete-container ul
    {
        margin-left: 30px;
    }
    .delete-container ul li
    {
        height: 24px;
        line-height: 24px;
    }
    .delete-container ul li input,
    .delete-container ul li label
    {
        float: left;
        margin-left: 22px;
    }
    .delete-container ul li input
    {
        width: 16px;
        height: 16px;
        margin: 0px;
        padding: 0px;
        outline: none;
        margin-right: -20px;
        margin-top: 3px;
    }
	</style>
</head>
<body>

<form id="ManagementTreeForm" runat="server" style="height:100%; width:100%;" onsubmit="return handleSubmit();">
    <input type="hidden" id="PostBackAction" name="PostBackAction" value="" />
    <input type="hidden" id="PostBackArgument" name="PostBackArgument" value="" />
    <input type="hidden" id="NodeSystemName" name="NodeSystemName" value="" />
    <input type="hidden" id="OpenTo" name="OpenTo" value="" />

    <table id="Container" style="height:100%; width:100%;" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top">
            <td id="cellTreeCollapsed" style="width: 24px; height:100%; display: none;">
                <img id="imgShowNav" class="tree-toolbar-button" style="cursor: pointer" src="/Admin/images/OpenTreeView_off.gif"
                    runat="server" />
            </td>
            <td style="height:100%;">
	            <dw:ModuleAdmin ID="ModuleAdmin1" runat="server" ContentFrameSrc="/Admin/Content/Management/Start.aspx">
	             <dw:Tree ID="Tree1" runat="server" SubTitle="Dynamicweb" Title="Management Center" ShowRoot="false" UseCookies="false">
		            <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Root" ParentID="-1" ImagePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/home.png">
		            </dw:TreeNode>
	            </dw:Tree>
	            </dw:ModuleAdmin>
            </td>
        </tr>
    </table>

    <dw:Contextmenu ID="cmModulePermissions" runat="server">
		<dw:ContextmenuButton ID="cmdEditPrmssins" runat="server" ImagePath="/Admin/Images/Icons/user1_lock.png" Text="Edit permissions" OnClientClick="editModulePermissions();" />
	</dw:Contextmenu>

    <dw:Contextmenu ID="cmItemTypes" runat="server" OnClientSelectView="Dynamicweb.ManagementTree.onItemTypeMenuView">
        <dw:ContextMenuButton ID="cmiAdd" Views="root,category" Image="AddItemType" Text="Add item type" OnClientClick="Dynamicweb.ManagementTree.get_current().addItemType();" runat="server" />
		<dw:ContextMenuButton ID="cmiEdit" Views="item" Image="EditDocument" Text="Edit item type" OnClientClick="Dynamicweb.ManagementTree.get_current().editItemType();" runat="server" />
        <dw:ContextMenuButton ID="cmiCopy" Views="item" Image="Copy" Text="Copy" OnClientClick="Dynamicweb.ManagementTree.get_current().copyItemType();" runat="server" />
        <dw:ContextMenuButton ID="cmiDelete" Views="item" Image="DeleteDocument" Text="Delete" Divide="Before" OnClientClick="Dynamicweb.ManagementTree.get_current().tryDeleteItem();" runat="server" />
        <dw:ContextMenuButton ID="cmiDeleteCategory" Views="category" Image="DeleteDocument" Text="Delete category" Divide="Before" OnClientClick="Dynamicweb.ManagementTree.get_current().tryDeleteItem();" runat="server" />
    </dw:Contextmenu>
   
    <dw:ContextMenu ID="cpAllStylesheets" runat="server">
        <dw:ContextMenuButton ID="cmdAddStylesheet" Text="New stylesheet" Image="AddDocument" OnClientClick="addStylesheet();" runat="server" />
    </dw:ContextMenu>
	
	<dw:ContextMenu ID="cmAllStylesheetsCreateEdit" runat="server">
	    <dw:ContextMenuButton ID="cmdNewStylesheetCreateEdit" Text="New stylesheet" Image="AddDocument" OnClientClick="addStylesheet();" runat="server" />
        <dw:ContextMenuButton ID="cmdEditPermissionsCreateEdit" Text="Edit permissions" ImagePath="/Admin/Images/Icons/user1_lock.png" OnClientClick="editModulePermissions();" runat="server" />
	</dw:ContextMenu>
	
	<dw:ContextMenu ID="cmAllStylesheetsEdit" runat="server">
	    <dw:ContextMenuButton ID="cmdEditPermissionsEdit" Text="Edit permissions" ImagePath="/Admin/Images/Icons/user1_lock.png" OnClientClick="editModulePermissions();" runat="server" />
	</dw:ContextMenu>
	
	<dw:ContextMenu ID="cpStylesheet" runat="server">
	    <dw:ContextMenuButton ID="cmdCopyStylesheet" Text="Copy" Image="Copy" OnClientClick="copyStylesheet();" runat="server" />
	    <dw:ContextMenuButton ID="cmdDeleteStylesheet" Divide="Before" Text="Delete stylesheet" Image="Delete" OnClientClick="deleteStylesheet();" runat="server" />
	</dw:ContextMenu>
	
	<dw:ContextMenu ID="cpStylesheetCopyOnly" runat="server">
	    <dw:ContextMenuButton ID="cmdCopyOnlyStylesheet" Text="Copy" Image="Copy" OnClientClick="copyStylesheet();" runat="server" />
	</dw:ContextMenu>
	
	<dw:ContextMenu ID="cpStylesheetDeleteOnly" runat="server">
	    <dw:ContextMenuButton ID="cmdDeleteOnlyStylesheet" Text="Delete stylesheet" Image="Delete" OnClientClick="deleteStylesheet();" runat="server" />
	</dw:ContextMenu>
    
    <dw:ContextMenu ID="cmRepositories" runat="server" OnClientSelectView="Dynamicweb.ManagementTree.onRepositoriesMenuView">
        <dw:ContextMenuButton ID="cmdNewRepository" Views="root" Text="New repository" Image="AddDocument" OnClientClick="newRepository();" runat="server" />
        <dw:ContextMenuButton ID="cmdDeleteRepository" Views="repository" Image="DeleteDocument" Text="Delete" OnClientClick="deleteRepository()" runat="server" />
    </dw:ContextMenu>
	
    <dw:Dialog runat="server" ID="dlgNewRepository" Width="500" UseTabularLayout="true" Title="New repository" ShowClose="true" ShowOkButton="true" ShowCancelButton="false" OkAction="newRepositoryCreate();">
        <dw:GroupBox runat="server" ID="grpRepository" Title="Repository">
            <table>
                <tr>
                    <td style="width:170px;"><dw:TranslateLabel runat="server" Text="Repository name" /></td>
                    <td><input type="text" class="std" name="txtNewRepositoryName" id="txtNewRepositoryName" /></td>
                </tr>
            </table>
        </dw:GroupBox>
    </dw:Dialog>

	<dw:Dialog runat="server" ID="EditModulePermissionsDialog" Width="316" Title="Module permission" ShowClose="true" HidePadding="true">
	    <iframe id="EditModulePermissionsDialogIFrame" style="width:300px; height: 495px;" scrolling="no"></iframe>
	</dw:Dialog>

    <dw:Dialog ID="dlgDeleteItemTypes" Title="Delete item types" UseTabularLayout="true" ShowOkButton="true" Width="500" ShowCancelButton="true" ShowClose="true" OkAction="Dynamicweb.ManagementTree.get_current().deleteItem();" runat="server">
    <div class="delete-container">
        <p><dw:TranslateLabel Text="Are you sure you want to delete the selected item types?" runat="server" /></p>
        <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align:middle;margin-left:10px;margin-right:10px;" /><dw:TranslateLabel Text="All item data for pages, paragraphs and websites will be completely removed and cannot be restored" runat="server" />
        <ul>
            <li>
                <input type="radio" name="DeleteMode" id="DeleteModePreservePages" value="PreservePages" checked="checked" />
                <label for="DeleteModePreservePages"><dw:TranslateLabel Text="Delete item types and item type data but keep related pages and paragraphs." runat="server" /></label>
                <div class="clearfix"></div>
            </li>

            <li>
                <input type="radio" name="DeleteMode" id="DeleteModeDeletePages" value="DeletePages" />
                <label for="DeleteModeDeletePages"><dw:TranslateLabel Text="Delete item types, item type data and all related pages and paragraphs (if pages contains ordinary paragraphs then the page itself is not deleted but only the paragraphs based on the specific item type)." runat="server" /></label>
                <div class="clearfix"></div>
            </li>
        </ul>
    </div>
    </dw:Dialog>
	
	<% Translate.GetEditOnlineScript()%>
	<Accordion:Accordion SelectedButton="managementcenter" id="Accordion" runat="server" ContextMenuID="AccordionMenu" />

    <dw:ContextMenu ID="AccordionMenu" runat="server" OnClientSelectView="onAccordionContextMenuView">
        <dw:ContextMenuButton ID="cmdPages" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'page()');" Views="page" />
        <dw:ContextMenuButton ID="cmdFiles" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'filemanager()');" Views="filemanager" />
        <dw:ContextMenuButton ID="cmdManagementCenter" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'mgmtcenter()');" Views="managementcenter" />
        <dw:ContextMenuButton ID="cmdEcom" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'ecom()');" Views="ecom" />
        <dw:ContextMenuButton ID="cmdOMC" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'omc()');" Views="omc" />
        <dw:ContextMenuButton ID="cmdModules" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'modules()');" Views="modules" />
        <dw:ContextMenuButton ID="cmdUserManagement" Text="Open in new window" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="onAccordionContextMenu(this, 'userManagement()');" Views="usermanagement" />
    </dw:ContextMenu>

    <dw:Overlay ID="PleaseWait" runat="server" />
</form>

	<script type="text/javascript">
		setTreeHeight();
		Dynamicweb.ManagementTree.get_current().get_terminology()['ItemListReference'] = '<%=Dynamicweb.Backend.Translate.Translate("Can not delete the list item type. It is referenced from another item.").Replace("'", "\'")%>';
		Dynamicweb.ManagementTree.get_current().get_terminology()['ItemInheritanceReference'] = '<%=Dynamicweb.Backend.Translate.Translate("Can not delete item type(s). It has derived item(s).").Replace("'", "\'")%>';
	    Dynamicweb.ManagementTree.get_current().get_terminology()['ItemListMessage'] = '<%=Dynamicweb.Backend.Translate.Translate("List of items:").Replace("'", "\'")%>';
	    Dynamicweb.ManagementTree.get_current().get_terminology()['itemHasItemRelatedList'] = '<%=Dynamicweb.Backend.Translate.Translate("Can not delete item type(s). There are item lists based on this item type.").Replace("'", "\'")%>';

	    parent.frames.left.hidePageFrame();
    </script>

    <dw:PopUpWindow ID="pwDialog" ContentUrl="" AutoReload="true" ShowClose="true" ShowCancelButton="false" ShowOkButton="False" runat="server"
        Width="360" Height="80" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" SnapToScreen="true" IsModal="true" />
</body>
</html>
