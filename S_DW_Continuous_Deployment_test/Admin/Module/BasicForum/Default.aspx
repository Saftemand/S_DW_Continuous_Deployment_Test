<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.BasicForum._Default" %>

<%@ Import Namespace="Dynamicweb" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" language="javascript" src="js/tree.js"></script>
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin runat="server">
        <dw:Tree ID="Tree1" runat="server" SubTitle="All categories" Title="Forum" ShowRoot="false"
            OpenAll="false" UseSelection="true" UseCookies="false" LoadOnDemand="true" UseLines="true">
            <dw:TreeNode NodeID="0" runat="server" Name="Root" ParentID="-1">
            </dw:TreeNode>
        </dw:Tree>
    </dw:ModuleAdmin>
    <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions" ShowClose="true" HidePadding="true" >
        <iframe id="permissionEditDialogIFrame" style="width: 300px; height:240px; overflow:hidden" scrolling="no"></iframe>
    </dw:Dialog>
    </form>
    <dw:ContextMenu ID="CategoryContext" runat="server" OnClientSelectView="menuActions.contextMenuView" >
        <dw:ContextMenuButton ID="NewThreadContextMenuButton" runat="server" Divide="After" Image="AddDocument" Text="New Thread" OnClientClick="menuActions.addThread();" Views="activate_cat,deactivate_cat" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="EditCategoryContextMenuButton" runat="server" Divide="None" Image="EditDocument" Text="Edit category" OnClientClick="menuActions.editCategory();" Views="activate_cat,deactivate_cat" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ActivateCategoryContextMenuButton" runat="server" Divide="None" Image="Check" Text="Activate category" Views="activate_cat" OnClientClick="menuActions.activateCategoryMenu(true)" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeactivateCAtegoryContextMenuButton" runat="server" Divide="None" Image="Delete" Text="Deactivate category" Views="deactivate_cat" OnClientClick="menuActions.activateCategoryMenu(false)" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteCategoryContextMenuButton" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete category" Views="activate_cat,deactivate_cat" OnClientClick="menuActions.deleteCategory();" > </dw:ContextMenuButton>
    </dw:ContextMenu>

     <dw:ContextMenu ID="AreaContext" runat="server">
        <dw:ContextMenuButton ID="ContextMenuButton2" runat="server" Divide="None" Image="AddDocument" Text="New category" OnClientClick="menuActions.addCategory();"> </dw:ContextMenuButton>
    </dw:ContextMenu>
    <script type="text/javascript">
        <% If Base.ChkString(Base.Request("CMD")) = "EditCategory" Then%>
            menuActions.editCategory(<%=Base.ChkInteger(Base.Request("CategoryID"))%>);
        <% Else%>
            menuActions.listCategory();
        <% End If%>
    </script>
    <% Translate.GetEditOnlineScript()%>
</body>
</html>
