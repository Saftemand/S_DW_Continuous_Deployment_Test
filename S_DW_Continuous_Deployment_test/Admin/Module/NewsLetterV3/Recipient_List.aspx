<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Recipient_List.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.Recipient_List" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Src="/Admin/Module/Common/Pager.ascx" TagName="Pager" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Search.ascx" TagName="Search" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Header.ascx" TagName="Header" TagPrefix="list" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head >
    <title>Recipient List</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="js/recipients.js"></script>
    <script type="text/javascript" src="js/letters.js"></script>
    <script type="text/javascript">

        function DeleteConfirm(objName) {
            return confirm('<%=Translate.JSTranslate("Do you want to delete ")%>[' + objName + ']?');
        }

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general")%>
	    }

    </script>
</head>
<body style="height: 100%;">
    <form id="FormRecipientList" runat="server" class="formNewsletter">
        <dw:Toolbar ID="RecipToolBar" runat="server" ShowStart="true" ShowEnd="false">
            <dw:ToolbarButton ID="tbAddNewsletter" runat="server" OnClientClick="letters.add(0);" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" Text="New newsletter" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbAddRecipients" runat="server" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddRecipient.gif" Text="New recipient">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbImportRecipients" runat="server" ImagePath="/Admin/Module/NewsLetterV3/Img/tbImportExport.gif" Text="Import/Export recipients" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbEditCategory" runat="server" ImagePath="/Admin/Module/NewsLetterV3/Img/EditCategory_small.gif" Text="Edit category">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbCategories" runat="server" OnClientClick="category.list();"  ImagePath="/Admin/Module/NewsLetterV3/Img/Categories.gif" Text="Categories" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbCheckEmails" runat="server" OnClientClick="category.checkEmails();" ImagePath="/Admin/Module/NewsLetterV3/Img/tbCheckEmails.gif" Text="Check e-mails" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
            </dw:ToolbarButton>
        </dw:Toolbar>
    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"  runat="server">
        <dw:List ID="RecipientList" runat="server" Title="" TranslateTitle="false"  StretchContent="true"
        UseCountForPaging="true" HandlePagingManually="true" >
            <Filters>
                <dw:ListTextFilter runat="server" id="TextFilter" WaterMarkText="Search" Width="175" ShowSubmitButton="true"  Divide="None" Priority="1" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Recipients per page"
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
			    <dw:ListColumn ID="colName" runat="server" Name="Name" Width="250" EnableSorting="true" />
			    <dw:ListColumn ID="colEmail" runat="server" Name="E-mail" Width="250" EnableSorting="true" />
			    <dw:ListColumn ID="colCreated" runat="server" Name="Created" Width="90" EnableSorting="true" />
                <dw:ListColumn ID="colActive" runat="server" Name="Active" Width="50" HeaderAlign="Center" ItemAlign="Center" />
		    </Columns>
        </dw:List>
        </dw:StretchedContainer>
        <dw:ContextMenu ID="RecipientMenu"  OnClientSelectView="recipients.listControl.contextMenuView"  runat="server">
            <dw:ContextMenuButton ID="mnuEdit" runat="server" Views="group,active,unactive" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png"
                Text="Edit recipient" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuActivate" runat="server" Views="unactive" Divide="None" ImagePath="/Admin/images/Check.gif"
                Text="Activate" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuDeactivate" runat="server" Views="active" Divide="None" ImagePath="/Admin/images/Minus.gif"
                Text="Deactivate" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuStatistics" runat="server" Views="group,active,unactive" Divide="None" ImagePath="/Admin/Module/NewsLetterV3/Img/Stat_Small.gif"
                Text="Statistics" OnClientClick="recipients.statClick();">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuDelete" runat="server" Views="group,active,unactive" Divide="Before" Image="Delete"
                Text="Delete recipient" >
            </dw:ContextMenuButton>
        </dw:ContextMenu>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>