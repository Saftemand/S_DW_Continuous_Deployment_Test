﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="News_list.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2.News_list" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <link rel="Stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/news.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <style type="text/css">
        body
        {
            border-left: 1px solid transparent;
            border-right: 1px solid transparent;
        }
    </style>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("newsv2", "modules.newsv2.general")%>
	    }

     news.filters = '<% = GetFilters() %>'; 
    </script>
</head>
<body onload="news.listControl.disableRelatedRows();">
    <form id="form1" runat="server">
    <input type="hidden" name="prevpage" id="prevpage" value="<% = Me.pageNumber%>" />
    <input type="hidden" name="showitems" id="showitems" value="<% = Me.showItems %>" />
    <input type="hidden" name="selectedItems" id="selectedItems" value="<% = Me.SelectedItemsStr %>" />
    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"
        runat="server">
        <dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="AddNews" runat="server" Divide="None" Image="AddDocument" Text="Ny nyhed">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="RibbonEditCategory" runat="server" Divide="None" Image="FolderEdit"
                Text="Edit category">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="Folder"
                Text="Categories" OnClientClick="category.list();">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
                OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <dw:List ID="List1" runat="server" Title="» Bikes » Road bikes" TranslateTitle="false"
            AllowMultiSelect="true" StretchContent="true" UseCountForPaging="true" HandlePagingManually="true">
            <Filters>
                <dw:ListTextFilter runat="server" ID="TextFilter" WaterMarkText="Search" Width="175"
                    ShowSubmitButton="True" Divide="None" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="News per page"
                    AutoPostBack="true" Priority="3" runat="server">
                    <Items>
                        <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                        <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                        <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                        <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                        <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                    </Items>
                </dw:ListDropDownListFilter>
            </Filters>
            <Columns>
                <dw:ListColumn ID="NewsName" runat="server" EnableSorting="true" Name="Name"></dw:ListColumn>
                <dw:ListColumn ID="NewsActive" runat="server" Name="Active" EnableSorting="true"
                    ItemAlign="Center" HeaderAlign="Center" Width="50"></dw:ListColumn>
                <dw:ListColumn ID="NewsDate" runat="server" EnableSorting="true" Name="Date" ItemAlign="Center"
                    HeaderAlign="Center" Width="140"></dw:ListColumn>
                <dw:ListColumn ID="NewsUpdated" runat="server" EnableSorting="true" Name="Updated"
                    ItemAlign="Center" HeaderAlign="Center" Width="140"></dw:ListColumn>
            </Columns>
        </dw:List>
        <dw:ContextMenu ID="NewsMenu" OnClientSelectView="news.listControl.contextMenuView"
            runat="server">
            <dw:ContextMenuButton ID="EditNewsActive" Views="active_arc,unactive_arc,active_unarc,unactive_unarc,related"
                runat="server" Divide="None" Image="EditDocument" Text="Edit news">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="CopyNewsActive" Views="active_arc,unactive_arc,active_unarc,unactive_unarc"
                runat="server" Divide="Before" Image="Copy" Text="Copy news">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="MoveNewsActive" Views="active_arc,unactive_arc,active_unarc,unactive_unarc"
                runat="server" Divide="None" Image="MoveDocument" Text="Move news">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="ArcNews" runat="server" Views="active_arc,unactive_arc"
                Divide="None" ImagePath="/Admin/Images/Icons/Module_NewsV2_archive.gif" Text="Move to Archive">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="UnArcNews" runat="server" Views="active_unarc,unactive_unarc"
                Divide="None" ImagePath="/Admin/Images/Icons/Module_NewsV2_archive.gif" Text="Extract from Archive">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="ApplyContentSubs" Views="active_arc,unactive_arc,active_unarc,unactive_unarc"
                runat="server" Divide="Before" ImagePath="/Admin/Images/Icons/Module_NewsletterV3_small.gif"
                Text="Content Subscription">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="ActivationNews" Views="active_arc,active_unarc" runat="server"
                Divide="None" Image="Delete" Text="Deactivate">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="DeactivationNews" Views="unactive_arc,unactive_unarc" runat="server"
                Divide="None" Image="Check" Text="Activate">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="DeleteNewsActive" Views="active_arc,unactive_arc,active_unarc,unactive_unarc"
                runat="server" Divide="Before" Image="DeleteDocument" Text="Delete news">
            </dw:ContextMenuButton>
        </dw:ContextMenu>
    </dw:StretchedContainer>
    </form>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
%>
</html>
