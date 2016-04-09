<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Category_List.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.Category_List" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head runat="server">
    <title>Category_List</title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/letters.js"></script>
    <script type="text/javascript">
        function DeleteConfirm(objName) {
            return confirm('<%=Translate.JSTranslate("Do you want to delete ")%>[' + objName + ']?');
        }

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.categories")%>
	    }

    </script>
</head>
<body style="height: 100%;">
    <form id="Form1" runat="server" class="formNewsletter">
        <dw:Toolbar ID="RulesToolBar" runat="server" ShowStart="true" ShowEnd="false">
            <dw:ToolbarButton ID="tbAddNewsletter" runat="server" OnClientClick="letters.add(0);" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" Text="New newsletter" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbAddCategory" runat="server" OnClientClick="category.add();" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddCategory.gif" Text="Ny kategori" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbCheckEmails" runat="server" OnClientClick="category.checkEmails();" ImagePath="/Admin/Module/NewsLetterV3/Img/tbCheckEmails.gif" Text="Check e-mails" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <dw:Overlay ID="PleaseWait" runat="server" />
    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
        <dw:List ID="CategoryList" runat="server" TranslateTitle="false" StretchContent="true" UseCountForPaging="true" HandlePagingManually="true" >
            <Filters>
                <dw:ListTextFilter runat="server" id="TextFilter" Width="175" WaterMarkText="Search" ShowSubmitButton="true" Divide="none" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Cat. per page"
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
			    <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true" />
			    <dw:ListColumn ID="colDescription" runat="server" Name="Description" />
            </Columns>
        </dw:List> 
    </dw:StretchedContainer>
    <dw:ContextMenu ID="CategoryMenu" runat="server">
        <dw:ContextMenuButton ID="mnuEditCategory" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png"
            Text="Edit category" OnClientClick="category.editListClick();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="mnuDeleteCategory" runat="server" Divide="Before" Image="Delete"
            Text="Delete category" OnClientClick="category.deleteListClick();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
       <%  Translate.GetEditOnlineScript() %>
    </form>
    <script type="text/javascript">
       <%= _customJS %>
    </script>
</body>
</html>
