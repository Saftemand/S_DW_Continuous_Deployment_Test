<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SearchPageResults.aspx.vb" 
    Inherits="Dynamicweb.Admin.NewsLetterV3.SearchPageResults" %>
    
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head runat="server">
    <title>SearchPageResults</title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">


        function back() {
		    main.searchClick();
	    }

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.search")%>
	    }

        function DeleteConfirm(objName) {
            return confirm('<%=Translate.JSTranslate("WARNING: Selected item will be deleted absolutely. It will not be restored back!")%>');
        }
    </script>
</head>
<body style="margin: 0px; height: 100%;">
    <form id="Form1" runat="server" style="margin: 0; padding: 0;">
            <dw:Toolbar ID="SearchToolBar" runat="server" ShowStart="true" ShowEnd="false">
                <dw:ToolbarButton ID="tbBack" runat="server" OnClientClick="back();" Image="NavigateLeft" Text="Back" >
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
                </dw:ToolbarButton>
            </dw:Toolbar>
        <dw:List ID="ResultsList" runat="server"
             Title="Search results"
             UseCountForPaging="true" 
             HandlePagingManually="true" >
            <Columns>
			    <dw:ListColumn ID="colName" runat="server" Name="Name" Width="250" EnableSorting="true" />
			    <dw:ListColumn ID="colEmail" runat="server" Name="E-mail" Width="250" EnableSorting="true" />
			    <dw:ListColumn ID="colCreated" runat="server" Name="Created" Width="90" EnableSorting="true" />
                <dw:ListColumn ID="colActive" runat="server" Name="Active" Width="50" HeaderAlign="Center" ItemAlign="Center" />
                <dw:ListColumn ID="colStatistic" runat="server" Name="Statistic" Width="50" HeaderAlign="Center" ItemAlign="Center" />
                <dw:ListColumn ID="colDelete" runat="server" Name="Delete" Width="50" HeaderAlign="Center" ItemAlign="Center" />
		    </Columns>
        </dw:List>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>