<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CategoryList.aspx.vb" Inherits="Dynamicweb.Admin.BasicForum.CategoryList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CategoryList</title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" language="javascript" src="js/message.js"></script>
    <script type="text/javascript" language="javascript" src="js/tree.js"></script>
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
    <script type="text/javascript" language="javascript" src="js/category.js"></script>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("", "modules.dw8.forum.general") %>
	    }
        message.filters = '<% = GetFilters() %>';
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar ID="CategoryBar1" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="AddCategory1" runat="server" Divide="None" Image="FolderAdd"
                Text="Ny kategori">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Help" Text="Help"
                OnClientClick="help();">
            </dw:ToolbarButton>
        </dw:Toolbar>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"
        runat="server">
        <dw:List ID="categoriesList" runat="server" TranslateTitle="false" StretchContent="true"
            UseCountForPaging="true" HandlePagingManually="true" PageSize="25" >
            <Filters>
                <dw:ListTextFilter runat="server" ID="TextFilter" WaterMarkText="Search" Width="175"
                    ShowSubmitButton="True" Divide="None" Priority="1" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Categories per page"
                    AutoPostBack="true" Priority="2" runat="server">
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
                <dw:ListColumn ID="ListColumn4" EnableSorting="false" runat="server" Name="" Width="5">
                </dw:ListColumn>
                <dw:ListColumn ID="NameColumn" EnableSorting="true" runat="server" Name="Name" Width="400">
                </dw:ListColumn>
                <dw:ListColumn ID="CategoryActiveColumn" EnableSorting="true" runat="server" Name="Active" HeaderAlign="Center" ItemAlign="Center" Width="60">
                </dw:ListColumn>
                <dw:ListColumn ID="ThreadsColumn" EnableSorting="true" runat="server" Name="Threads">
                </dw:ListColumn>
                <dw:ListColumn ID="RepliesColumn" EnableSorting="true" runat="server" Name="Replies">
                </dw:ListColumn>
                <dw:ListColumn ID="DescriptionColumn" runat="server" Name="Description"></dw:ListColumn>
            </Columns>
        </dw:List>
    </dw:StretchedContainer>
    <dw:ContextMenu ID="CategoryContextMenu" runat="server" OnClientSelectView="forumCategory.listControl.contextMenuView" >
        <dw:ContextMenuButton ID="NewThreadContextMenuButton" runat="server" Divide="After" Image="AddDocument" Text="New Thread" OnClientClick="message.addThread();" Views="activate_cat,deactivate_cat" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="EditCategoryContextMenuButton" runat="server" Divide="None" Image="EditDocument" Text="Edit category" OnClientClick="forumCategory.editCategory();" Views="activate_cat,deactivate_cat" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ActivateCategoryContextMenuButton" runat="server" Divide="None" Image="Check" Text="Activate category" Views="activate_cat" OnClientClick="forumCategory.activateCategoryMenu(true)" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeactivateCAtegoryContextMenuButton" runat="server" Divide="None" Image="Delete" Text="Deactivate category" Views="deactivate_cat" OnClientClick="forumCategory.activateCategoryMenu(false)" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteCategoryContextMenuButton" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete category" Views="activate_cat,deactivate_cat" OnClientClick="forumCategory.deleteCategoryMenu();" >
        </dw:ContextMenuButton>
    </dw:ContextMenu>
        <%Translate.GetEditOnlineScript()%>
    </form>

</body>
</html>

