<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2._Default6" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/news.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin ID="ModuleAdmin1" runat="server">
        <dw:Tree ID="Tree1" runat="server" SubTitle="All categories" Title="Navigation" ShowRoot="false"
            OpenAll="false" UseSelection="true" UseCookies="false" LoadOnDemand="true" UseLines="true"
            ClientNodeComparator="function() {return 0;}">
            <dw:TreeNode ID="Root" NodeID="0" runat="server" Name="Root" ParentID="-1" />
        </dw:Tree>
    </dw:ModuleAdmin>
    <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions"
        ShowClose="true" HidePadding="true">
        <iframe id="permissionEditDialogIFrame" style="width: 300px; height: 510px;"></iframe>
    </dw:Dialog>
    </form>
    <dw:ContextMenu ID="CategoryContext" runat="server">
        <dw:ContextMenuButton ID="EditCategory" runat="server" Divide="None" Image="FolderEdit"
            Text="Edit category">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="AddNews" runat="server" Divide="None" Image="AddDocument"
            Text="Ny nyhed">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteCategory" runat="server" Divide="Before" ImagePath="/Admin/Module/Usermanagement/Images/folder_delete.png"
            Text="Delete category">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="Permissions" runat="server" Divide="Before" ImagePath="/Admin/Images/Icons/user1_lock.png"
            Text="Edit permissions">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="NewsContextActive" runat="server">
        <dw:ContextMenuButton ID="AddNewsAct" runat="server" Divide="None" Image="AddDocument"
            Text="Ny nyhed">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="NewsContextArc" runat="server">
        <dw:ContextMenuButton ID="AddNewsArc" runat="server" Divide="None" Image="AddDocument"
            Text="Ny nyhed">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="DefaultMenu" runat="server">
        <dw:ContextMenuButton ID="AddCategory" runat="server" Divide="None" Image="FolderAdd"
            Text="New category" OnClientClick="category.addClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <% Translate.GetEditOnlineScript()%>
</body>
</html>
