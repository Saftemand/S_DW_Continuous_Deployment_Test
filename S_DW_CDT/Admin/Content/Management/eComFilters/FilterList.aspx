<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FilterList.aspx.vb" Inherits="Dynamicweb.Admin.FilterList" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Filters" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/eComFilters/FilterList.js" />
            </Items>
        </dw:ControlResources>
        <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    </head>
    <script type="text/javascript" language="JavaScript" src="../../../Module/eCom_Catalog/images/layermenu.js"></script>
    <script type="text/javascript">
        document.observe('dom:loaded', function () {
            eComFilters.FilterList.initialize();
        });

        var groupId = <%=Base.ChkNumber(Base.Request("GroupID"))%>;
    </script>

    <style type="text/css">
        .popup-progress
        {
	        padding-top: 150px !important;
	        height: 230px !important;
        }
    </style>

    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" id="PostBackAction" name="PostBackAction" value="" />
            <input type="hidden" id="FilterID" name="FilterID" value="" />
            <input type="hidden" id="isIndexExists" name="isIndexExists" value="" runat="server"/>
            <input type="hidden" id="selectedLangID" name="selectedLangID" value="" runat="server"/>

            <asp:Literal ID="BoxStart" runat="server"></asp:Literal>

            <dw:Infobar ID="infoNoIndex" Type="Warning" Message="Please configure your search index first." Visible="false" runat="server" />
            <dw:List ID="lstFilters" AllowMultiSelect="true" ShowPaging="true" ShowTitle="false" runat="server" pagesize="25">
                <Columns>
                    <dw:ListColumn ID="colName" EnableSorting="true" Name="Name" Width="250" runat="server" />
                    <dw:ListColumn ID="colType" EnableSorting="true" Name="Type" Width="200" runat="server" />
                    <dw:ListColumn ID="colRemove" ItemAlign="Center" HeaderAlign="Center" EnableSorting="false" Name="Delete" Width="100" runat="server" /> 
                </Columns>
            </dw:List>

            <dw:ContextMenu ID="cmFilter" OnClientSelectView="eComFilters.FilterList.onSelectFilterContextMenuView" runat="server">
                <dw:ContextMenuButton ID="cmdEdit" Views="SingleActiveItem, SingleInactiveItem, MultipleActiveItems, MultipleInactiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_edit.png" Text="Edit" 
                    OnClientClick="eComFilters.FilterList.openEditDialog(ContextMenu.callingID);" runat="server" />
                
                <dw:ContextMenuButton ID="cmdVisibilityOptions" Views="SingleActiveItem, SingleInactiveItem, MultipleActiveItems, MultipleInactiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_display.png" Text="Visibility options"
                    OnClientClick="eComFilters.FilterList.openVisibilityOptionsDialog(ContextMenu.callingID);" Divide="After" runat="server" />

                <dw:ContextMenuButton ID="cmdActivate" Views="SingleInactiveItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_ok.png" Text="Activate" OnClientClick="eComFilters.FilterList.setFiltersActive(true, ContextMenu.callingID);" runat="server" />
                <dw:ContextMenuButton ID="cmdActivateSelected" Views="MultipleInactiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_ok.png" Text="Activate selected" OnClientClick="eComFilters.FilterList.setFiltersActive(true);" runat="server" />
                <dw:ContextMenuButton ID="cmdDeactivate" Views="SingleActiveItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_forbidden.png" Text="Deactivate" OnClientClick="eComFilters.FilterList.setFiltersActive(false, ContextMenu.callingID);" runat="server" />
                <dw:ContextMenuButton ID="cmdDeactivateSelected" Views="MultipleActiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_forbidden.png" Text="Deactivate selected" OnClientClick="eComFilters.FilterList.setFiltersActive(false);" runat="server" />
                <dw:ContextMenuButton ID="cmdDelete" Views="SingleActiveItem, SingleInactiveItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_delete.png" Text="Delete" Divide="Before" OnClientClick="eComFilters.FilterList.tryDeleteFilters(ContextMenu.callingID);" runat="server" />
                <dw:ContextMenuButton ID="cmdDeleteSelected" Views="MultipleActiveItems, MultipleInactiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_delete.png" Text="Delete selected" OnClientClick="eComFilters.FilterList.tryDeleteFilters();" runat="server" />
            </dw:ContextMenu>

            <dw:PopUpWindow ID="dlgEditFilter" UseTabularLayout="true" AutoReload="true" Width="600" Height="400" ContentUrl="" runat="server" />

            <span id="jsHelp" style="display: none"><%= Dynamicweb.Gui.Help("", "managementcenter.ecommerce.filters.group.list")%> </span>
            <span id="confirmDelete" style="display: none"><dw:TranslateLabel id="lbDelete" Text="Slet?" runat="server" /></span>  

            <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 
        </form>
    </body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
