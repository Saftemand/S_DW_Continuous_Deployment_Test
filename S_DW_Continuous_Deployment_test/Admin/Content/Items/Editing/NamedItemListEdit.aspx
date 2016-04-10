<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NamedItemListEdit.aspx.vb" Inherits="Dynamicweb.Admin.NamedItemListEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><dw:TranslateLabel ID="lblTitle" runat="server" Text="Item lists" /></title>
    <dw:ControlResources CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/js/NamedItemListEdit.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/Items/css/NamedItemListEdit.css" />
        </Items>
    </dw:ControlResources>

    <style>
        .item-list-editor-list {
            height: 500px; /* for support correct scrolling in Chrome, FF, IE */
        }
    </style>

</head>
<body>
    <form id="MainForm" runat="server">
        <input type="hidden" id="cmd" name="cmd" value="" />
        <input type="hidden" id="SortIndex" name="SortIndex" value="" />
        <input type="hidden" id="SortOrder" name="SortOrder" value="" />

        <div class="title">
            <span class="header">
                <dw:TranslateLabel ID="lblItemLists" runat="server" Text="Item lists" />
            </span>
            <span class="rightCorner">
                <dw:Toolbar runat="server" ID="toolbar1" ShowEnd="false" ShowStart="false">
                    <dw:ToolbarButton runat="server" Image="DeleteDocument" Text="Delete selected list" Translate="false" id="btnDeleteList" OnClientClick="Dynamicweb.Items.NamedListItemEdit.get_current().deleteItemList();" />
                    <dw:ToolbarButton runat="server" Image="AddDocument" Text="Add list" id="btnNewList" OnClientClick="Dynamicweb.Items.NamedListItemEdit.get_current().showAddNamedItemListDialog();" />
                </dw:Toolbar>
            </span>
        </div>
        <div class="subtitle">
            <div>
                <span>
                    <select id="lstNamedItemLists" onchange="Dynamicweb.Items.NamedListItemEdit.get_current().loadNamedList();" runat="server"></select>
                    <input id="txtFilter" style="height:16px;" runat="server" placeholder="Search" type="text" />
                    <input id="btnFilter" width="22" src="/Admin/Images/Ribbon/Icons/Small/Search.png" type="image" onclick="Dynamicweb.Items.NamedListItemEdit.get_current().loadNamedList();" />
                </span>
            </div>
        </div>
        
        <div id="content" style="overflow-y:auto; margin-top:-1px;">
            <asp:Literal id="litFields" runat="server" />
        </div>

	    <dw:Dialog runat="server" ID="AddNamedItemListDialog" Width="460" Title="New named item list" ShowOkButton="true" ShowCancelButton="true" OkAction="Dynamicweb.Items.NamedListItemEdit.get_current().addNamedItemList();">
	    <dw:GroupBox ID="GroupBox3" runat="server" Title="Named item list">
	    <table style="border-top-width:0px;">
            <tr>
                <td style="width: 170px">
				    <dw:TranslateLabel ID="TranslateLabel3" Text="Name" runat="server" />
                </td>
                <td>
                    <input maxlength="255" class="std" style="width:299px;" id="NamedListName" runat="server" type="text" />
                </td>
            </tr>
	        <tr>
                <td style="width: 170px">
				    <dw:TranslateLabel ID="TranslateLabel4" Text="Item type" runat="server" />
                </td>
                <td>
				    <dw:Richselect ID="NamedListItemType" runat="server" Height="60" Itemheight="60" Width ="300" Itemwidth="300">
				    </dw:Richselect>
			    </td>
            </tr>
	    </table>
	    </dw:GroupBox>
	    </dw:Dialog>

    </form>

    <dw:ContextMenu ID="SortingContextMenu" runat="server">
        <dw:ContextMenuButton ID="cmdSortAscending" ImagePath="/Admin/Filemanager/Icons/sort_ascending.png" Text="Sort ascending" runat="server" OnClientClick="Dynamicweb.Items.NamedListItemEdit.get_current().sortAscending();" />
        <dw:ContextMenuButton ID="cmdDeselectAll" ImagePath="/Admin/Filemanager/Icons/sort_descending.png" Text="Sort descending" runat="server" OnClientClick="Dynamicweb.Items.NamedListItemEdit.get_current().sortDescending();" />
    </dw:ContextMenu>

	<dw:ContextMenu ID="languageSelectorContext" runat="server" MaxHeight="400">
	</dw:ContextMenu>

    <%Translate.GetEditOnlineScript()%>
</body>
</html>
