<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PagePerformanceReport.aspx.vb" Inherits="Dynamicweb.Admin.PagePerformanceReport" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Webpage analysis</title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <link rel="Stylesheet" href="/Admin/Content/Reports/PagePerformanceReport.css" type="text/css" />
    <script type="text/javascript">
        function help() {
            <%=Gui.Help("page.optimizeexpress")%>
            }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="pHasAccess" runat="server">
            <dw:Toolbar ID="TopTools" ShowStart="false" ShowEnd="false" runat="server">
                <dw:ToolbarButton ID="cmdHelp" Image="Help" Text="Help" OnClientClick="help();" runat="server" />
            </dw:Toolbar>
            <h2 class="subtitle"><%=Dynamicweb.Admin.ParagraphList1.GetPath(Base.ChkInteger(Base.Request("PageID")), True)%></h2>
            <dw:List ID="lstWebPageAnalyzeReport" ShowPaging="false" NoItemsMessage="No data to show" ShowTitle="false" runat="server" pagesize="25" OnRowExpand="OnRowExpand" Personalize="true">
                <Columns>
                    <dw:ListColumn ID="colName" Name="Parameter Name" Width="250" runat="server" />
                    <dw:ListColumn ID="colValue" Name="Value" Width="75" runat="server" />
                    <dw:ListColumn ID="colStatus" Name="Status" Width="75" runat="server" />
                </Columns>
            </dw:List>
	    </asp:Panel>
    </form>
</body>
<span id="jsHelp" style="display: none"><%=Gui.Help("page.optimizeexpress")%></span>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
