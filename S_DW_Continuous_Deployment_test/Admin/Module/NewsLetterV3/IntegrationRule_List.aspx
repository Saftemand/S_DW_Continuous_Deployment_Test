<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IntegrationRule_List.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.IntegrationRule_List" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head runat="server">
    <title>IntegrationItem_List</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/rules.js"></script>
    <script type="text/javascript">
        function DeleteConfirm() {
            return confirm('<%=Translate.JSTranslate("Slet")%>?');
        }

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general")%>
	    }
    </script>
</head>
<body style="height: 100%;">
    <form id="Form1" runat="server" class="formNewsletter">
        <dw:Toolbar ID="RulesToolBar" runat="server" ShowStart="true" ShowEnd="false">
            <dw:ToolbarButton ID="tbAddRule" runat="server" OnClientClick="rules.add();" ImagePath="/Admin/Module/NewsLetterV3/Img/Integration_News.gif" Text="New rule">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
        <dw:List ID="IntegrationList" runat="server" Title="" TranslateTitle="false"  StretchContent="true" 
             UseCountForPaging="true" HandlePagingManually="true" >
            <Filters>
                <dw:ListTextFilter runat="server" id="TextFilter" WaterMarkText="Search" Width="175" ShowSubmitButton="true"  Divide="None" Priority="1"  />
                <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Rules per page"
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
			    <dw:ListColumn ID="colType" runat="server" Name="Type" Width="80" />
			</Columns>
        </dw:List> 
        </dw:StretchedContainer>
        <dw:ContextMenu ID="IntegrationMenu" runat="server">
            <dw:ContextMenuButton ID="mnuEdit" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png"
                Text="Edit rule" OnClientClick="rules.editClick();">
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="mnuDelete" runat="server" Divide="Before" Image="Delete"
                Text="Delete rule" OnClientClick="rules.deleteClick();">
            </dw:ContextMenuButton>
        </dw:ContextMenu>
        <%  Translate.GetEditOnlineScript() %>
    </form>
    <script type="text/javascript">
       <%= _customJS %>
    </script>
</body>
</html>

