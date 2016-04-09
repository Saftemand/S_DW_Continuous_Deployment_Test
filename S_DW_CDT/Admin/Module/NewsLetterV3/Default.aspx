<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3._Default" %>

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
    <script type="text/javascript" src="js/letters.js"></script>
    <script type="text/javascript" src="js/recipients.js"></script>
    <script type="text/javascript" src="js/rules.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin ID="ModuleAdmin1" runat="server">
        <dw:Tree ID="Tree1" runat="server" SubTitle="Mail folders" Title="Navigation" ShowRoot="false"
            OpenAll="false" UseSelection="true" UseCookies="false" LoadOnDemand="true" UseLines="true"  ClientNodeComparator="function() {return 0;}" >
            <dw:TreeNode ID="Root" NodeID="0" runat="server" Name="Root" ParentID="-1" />
            <dw:TreeNode ID="AllRecipients" NodeID="1"  ItemID="6"  runat="server" Name="All recipients" ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/Recipients.gif" Href="javascript:recipients.listAll();" ContextMenuID="MenuAllRecipients" />
            <dw:TreeNode ID="Categories" NodeID="2"  ItemID="5"  runat="server" Name="Categories"  ParentID="0" 
                ImagePath="/Admin/Module/NewsLetterV3/Img/Categories.gif" ImageOpenPath="/Admin/Module/NewsLetterV3/Img/Categories.gif" ImageClosePath="/Admin/Module/NewsLetterV3/Img/Categories.gif" Href="javascript:category.list();" ContextMenuID="MenuCategories" />
            <dw:TreeNode ID="SentItems" NodeID="3"  ItemID="3"  runat="server" Name="Sent Items"  ParentID="0" HasChildren="true"
                ImageOpenPath="/Admin/Module/NewsLetterV3/Img/SentItems.gif" ImageClosePath="/Admin/Module/NewsLetterV3/Img/SentItems.gif" Href="javascript:letters.listSentItems();" ContextMenuID="MenuSearch" />
            <dw:TreeNode ID="Integration" NodeID="4"  ItemID="7"  runat="server" Name="Integration"  ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/Integration.gif" ImageOpenPath="/Admin/Module/NewsLetterV3/Img/Integration.gif" ImageClosePath="/Admin/Module/NewsLetterV3/Img/Integration.gif" Href="javascript:rules.list();" ContextMenuID="MenuIntegration" />
            <dw:TreeNode ID="Drafts" NodeID="5" ItemID="1" runat="server" Name="Drafts"  ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/Drafts.gif" Href="javascript:letters.listDrafts();" ContextMenuID="MenuSearch" />
            <dw:TreeNode ID="Outbox" NodeID="6" ItemID="2"  runat="server" Name="Outbox"  ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/Outbox.gif" Href="javascript:letters.listOutbox();" ContextMenuID="MenuSearch" />
            <dw:TreeNode ID="Search" NodeID="7" runat="server" Name="Search" ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/Search.gif" Href="javascript:main.openSearch('');" />
            <dw:TreeNode ID="DeletedItems" NodeID="8"  ItemID="4"  runat="server" Name="Deleted Items"  ParentID="0"
                ImagePath="/Admin/Module/NewsLetterV3/Img/DeletedItems.gif" ImageOpenPath="/Admin/Module/NewsLetterV3/Img/DeletedItems.gif" ImageClosePath="/Admin/Module/NewsLetterV3/Img/DeletedItems.gif" Href="javascript:letters.listDeletedItems();" ContextMenuID="MenuDeleted" />
        </dw:Tree>
    </dw:ModuleAdmin>
    <dw:Overlay ID="PleaseWait" runat="server" />
    </form>

    <dw:ContextMenu ID="MenuMailsContext" runat="server">
        <dw:ContextMenuButton ID="AddNewsAct" runat="server" Divide="None" Image="AddDocument"
            Text="Ny nyhed">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuSearch" runat="server">
        <dw:ContextMenuButton ID="mnuSearch" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="main.searchClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuCategories" runat="server">
        <dw:ContextMenuButton ID="mnuCatAddCategory" runat="server" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/AddCategory_small.gif"
            Text="Add category" OnClientClick="category.add();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="main.searchClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuCategoryItem" runat="server">
        <dw:ContextMenuButton ID="mnuCIEditCategory" runat="server" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/EditCategory_small.gif"
            Text="Edit category" OnClientClick="category.editClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="MnuSIAddNewsletter" runat="server" Divide="Before" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif"
            Text="Add newsletter" OnClientClick="letters.addClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuCIAddRecipient" runat="server" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/AddRecipient_small.gif"
            Text="Add recipient" OnClientClick="recipients.add();" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuCISearch" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="category.searchClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuCIDeleteCategory" runat="server" Divide="Before" Image="Delete"
            Text="Delete category" OnClientClick="category.deleteClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuSentItem" runat="server">
        <dw:ContextMenuButton ID="mnuSISearch" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="letters.searchClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuDeleted" runat="server">
        <dw:ContextMenuButton ID="mnuDelSearch" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="main.searchClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuDelEmpty" runat="server" Divide="Before" ImagePath="/Admin/Module/NewsLetterV3/Img/DeletedItems_small.gif"
            Text="Empty" OnClientClick="category.emptyBin();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuDeletedItem" runat="server">
        <dw:ContextMenuButton ID="mnuDIRestoreCategory" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Page_edit.gif"
            Text="Restore category" OnClientClick="category.restoreClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuDIDeleteCategory" runat="server" Divide="Before" ImagePath="/Admin/Images/Icons/Page_delete.gif"
            Text="Delete category" OnClientClick="category.deleteClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>


    <dw:ContextMenu ID="MenuAllRecipients" runat="server">
        <dw:ContextMenuButton ID="mnuARAddRecipient" runat="server" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/AddRecipient_small.gif"
            Text="Add recipient" OnClientClick="recipients.add();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuARSearch" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
            Text="Search" OnClientClick="main.searchClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuIntegration" runat="server">
        <dw:ContextMenuButton ID="mnuIntAddRule" runat="server" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/Integration_News.gif"
            Text="Add news rule" OnClientClick="rules.add();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="MenuIntegrationItem" runat="server">
        <dw:ContextMenuButton ID="mnuIIEditRule" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Page_edit.gif"
            Text="Edit rule" OnClientClick="rules.editClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuIIDeleteRule" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Page_delete.gif"
            Text="Delete rule" OnClientClick="rules.deleteClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
                

    <script type="text/javascript">
        category.list();
        // forced open category node
        main.reloadCategories();
    </script>
     <% Translate.GetEditOnlineScript()%>
</body>
</html>
