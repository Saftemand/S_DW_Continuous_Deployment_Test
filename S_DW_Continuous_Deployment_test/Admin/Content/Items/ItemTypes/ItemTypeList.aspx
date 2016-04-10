<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemTypeList.aspx.vb" Inherits="Dynamicweb.Admin.ItemTypeList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <dw:ControlResources CombineOutput="False" IncludeClientSideSupport="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemTypeList.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/ItemTypeList.css" />
            </Items>
        </dw:ControlResources>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" id="PostBackAction" name="PostBackAction" value="" />
            <input type="hidden" id="PostBackArgument" name="PostBackArgument" value="" />
            <input type="hidden" id="ItemSystemNames" name="ItemSystemNames" value="" />
            <input type="hidden" id="SelectedItems" name="SelectedItems" runat="server" value="" />

            <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="body" runat="server">
                <dw:Toolbar runat="server" ShowStart="true" ShowEnd="false">
                    <dw:ToolbarButton ID="cmdNew" Image="AddItemType" Text="New item type" runat="server" />
                    <dw:ToolbarButton ID="cmdSync" Image="Refresh" OnClientClick="Dynamicweb.Items.ItemTypeList.get_current().initiatePostBack('Refresh');" Text="Refresh" Divide="After" runat="server" />
                    <dw:ToolbarButton ID="cmdUsage" ImagePath="../img/ItemTypeUsage.png" OnClientClick="location.href = '/Admin/Content/Items/ItemTypes/ItemTypeUsage.aspx';" Text="Item type usage" Divide="After" runat="server" />
                    <dw:ToolbarButton ID="cmdHelp" Image="Help" OnClientClick="Dynamicweb.Items.ItemTypeList.help();"  Text="Help" runat="server" />
                </dw:Toolbar>
                <h2 class="subtitle">
	                <dw:TranslateLabel Text="Item types" runat="server" />
	            </h2>
                <dw:Infobar ID="infError" runat="server" Type="Error" Visible="False" TranslateMessage="False"></dw:Infobar>
                <dw:List ID="lstItemTypes" ShowTitle="false" StretchContent="true" NoItemsMessage="No item types found" ShowPaging="true" PageSize="25" AllowMultiSelect="true" runat="server">
                    <Columns>
                        <dw:ListColumn Name="Name" Width="300"  EnableSorting="true" />
                        <dw:ListColumn Name="System name" EnableSorting="true" />
                        <dw:ListColumn Name="Inherited from" EnableSorting="true" />
                        <dw:ListColumn ItemAlign="Center" HeaderAlign="Center" EnableSorting="false" Name="Delete" Width="100" runat="server" /> 
                    </Columns>
                </dw:List>
            </dw:StretchedContainer>

            <dw:ContextMenu ID="cmItem" runat="server" OnClientSelectView="Dynamicweb.Items.ItemTypeList.onContextMenuView">
                <dw:ContextMenuButton ID="cmiEdit" Views="mixed,common" Image="EditDocument" Text="Edit item type" OnClientClick="Dynamicweb.Items.ItemTypeList.get_current().openEditDialog(ContextMenu.callingItemID);" runat="server" />
                <dw:ContextMenuButton ID="cmiCopy" Views="mixed,common" Image="Copy" Text="Copy" OnClientClick="Dynamicweb.Items.ItemTypeList.get_current().copy(ContextMenu.callingItemID);" runat="server" />
                <dw:ContextMenuButton ID="cmiDelete" Views="common" Image="DeleteDocument" Text="Delete" Divide="Before" OnClientClick="Dynamicweb.Items.ItemTypeList.get_current().tryDeleteItem(ContextMenu.callingItemID);" runat="server" />
                <dw:ContextMenuButton ID="cmiDeleteAll" Views="mixed,selection" Image="DeleteDocument" Text="Delete selected" Divide="Before" OnClientClick="Dynamicweb.Items.ItemTypeList.get_current().tryDeleteItem();" runat="server" />
             </dw:ContextMenu>

             <dw:Dialog ID="dlgDeleteItemTypes" Title="Delete item types" UseTabularLayout="true" ShowOkButton="true" Width="500" ShowCancelButton="true" ShowClose="true" OkAction="Dynamicweb.Items.ItemTypeList.get_current().deleteItem();" runat="server">
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

             <dw:Overlay ID="PleaseWait" runat="server" />
        </form>

        <%Translate.GetEditOnlineScript()%>
    </body>
</html>
