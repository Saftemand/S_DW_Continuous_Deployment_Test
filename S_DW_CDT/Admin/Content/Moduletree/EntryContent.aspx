<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EntryContent.aspx.vb" Inherits="Dynamicweb.Admin.Moduletree.EntryContent1" EnableViewState="false" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>

	<link href="/Admin/Content/Moduletree/Start.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        function over(row) {
            row.className = 'over';
        }
        function out(row) {
            row.className = '';
        }

        /* Content menu */
		function editModulePermissions() {
		    var moduleSystemName = ContextMenu.callingID;
		    var moduleName = ContextMenu.callingItemID;
		        
		    dialog.setTitle('EditModulePermissionsDialog', '<%=Backend.Translate.JsTranslate("Module permissions") %>: ' + moduleName);

		    document.getElementById('EditModulePermissionsDialogIFrame').src = '/Admin/FastLoadRedirect.aspx?redirect=/Admin/Module/ModulePermissionEdit.aspx?ModuleSystemName=' + moduleSystemName + '%26CloseOnExit=True%26DialogID=EditModulePermissionsDialog';
		    dialog.show('EditModulePermissionsDialog');
		}

		function openModule() {
		    var moduleSystemName = ContextMenu.callingID;
		    var moduleName = ContextMenu.callingItemID;

            new Ajax.Request('Default.aspx?AJAX=OpenModule&ModuleSystemName=' + moduleSystemName, {
                onSuccess: function (response) {
                    // Get values from response
                    var jsonObj = response.responseText.evalJSON();
                    var urlValue = jsonObj.urlValue;
                    document.location.href = urlValue;
                },

                onFailure: function () {
                    alert('Something went wrong!');
                }
            });
		}


    </script>

</head>

<body>

    <form id="form1" runat="server">
	    <h1 class="title">
		    <dw:TranslateLabel ID="lbModuleList" runat="server" Text="Module list" />
	    </h1>
	    <h2 class="subtitle">&nbsp;</h2>

        <div runat="server" id="myContent">
            <table>
                <asp:Repeater ID="repRootNodes" OnItemDataBound="repRootNodes_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <tr id="rowSection" runat="server">
                            <td>
                                <div id="myContent" style="margin: 0px !important;">
                                    <table>
                                        <tr >
                                            <td style="width:20px;" valign="top">
                                                <img id="imgIcon" src="" alt="" runat="server" style="margin:0px;" />
                                            </td>
                                            <td valign= "top" >
                                                <h1 id="sHeader" runat="server" style="margin:0px;"></h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:20px;" valign="top"></td>
                                            <td valign="top">
                                                <asp:Repeater ID="repSectionNodes" runat="server">
                                                    <ItemTemplate>
                                                        <div id="cell" onmouseover="over(this)" onmouseout="out(this)">
                                                            <img src="" id="imgModule" runat="server" alt="Module" /><a id="lnkNode" runat="server"></a>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>

		<dw:ContextMenu runat="server" ID="mnuModules" Translate="true" >
			<dw:ContextMenuButton runat="server" ID="mmiOpen" DoTranslate="True" ImagePath="/Admin/Images/Icons/Module_Default_small.gif" Text="Open" OnClientClick="openModule();"  />
			<dw:ContextMenuButton runat="server" ID="mmiPermission"  DoTranslate="True" ImagePath="/Admin/Images/Icons/user1_lock.png" Text="Permissions" OnClientClick="editModulePermissions();" />
		</dw:ContextMenu>

        <dw:Dialog runat="server" ID="EditModulePermissionsDialog" Width="316" Title="Module permission" ShowClose="true" HidePadding="true">
	        <iframe id="EditModulePermissionsDialogIFrame" style="width:300px; height: 510px;"></iframe>
	    </dw:Dialog>
    </form>

</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()  %>
</html>
