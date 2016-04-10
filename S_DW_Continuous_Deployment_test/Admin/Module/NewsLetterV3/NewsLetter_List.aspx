<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewsLetter_List.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.NewsLetter_List" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

    
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head runat="server">
    <title>NewsLetter_List</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/letters.js"></script>
    <style type="text/css">
        .filterLabel
        {
            width: 130px !important;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function DeleteConfirm() {
            return confirm('<%=Translate.JSTranslate("Slet")%>?');
        }

        function help(status) {
            switch(status){
                case 1:
		            <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.drafts")%>;
                    break;
                case 2:
		            <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.outbox")%>;
                    break;
                case 3:
		            <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.sent")%>;
                    break;
                case 4:
		            <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.deleted")%>;
                    break;
                default:
		            <%=Gui.Help("newsletterv3", "modules.newsletterv3.general")%>;
            }


	    }
    </script>
</head>
<body style="height: 100%;">
    <form id="Form1" runat="server" class="formNewsletter">
        <dw:Toolbar ID="NewslettersToolBar" runat="server" ShowStart="true" ShowEnd="false">
            <dw:ToolbarButton ID="tbAddNewsletter" runat="server" OnClientClick="letters.add(0);" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" Text="New newsletter">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
        <dw:List ID="LettersList" runat="server" ShowTitle="true" StretchContent="true" TranslateTitle="false"  UseCountForPaging="true" HandlePagingManually="true" >
            <Filters>
                <dw:ListTextFilter runat="server" id="TextFilter" WaterMarkText="Search" Width="175" ShowSubmitButton="true"  Divide="None" Priority="1" />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Newsletters per page"
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
			    <dw:ListColumn ID="colCreated" runat="server" Name="Created" Width="80" EnableSorting="true" />
			    <dw:ListColumn ID="colSend" runat="server" Name="Send date" Width="80" EnableSorting="true" />
			</Columns>
        </dw:List> 
        </dw:StretchedContainer>
        <dw:ContextMenu ID="LettersMenu" runat="server">
            <dw:ContextMenuButton ID="mnuEdit" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuCopy" runat="server" Divide="None" Image="Copy"
                Text="Copy newsletter" OnClientClick="letters.copyClick();">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuDelete" runat="server" Divide="Before" Image="Delete"
                Text="Delete newsletter">
            </dw:ContextMenuButton>
        </dw:ContextMenu>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>

