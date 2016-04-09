<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="historyList.aspx.vb" Inherits="Dynamicweb.Admin.historyList" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="/Admin/Images/Ribbon/UI/Tab/TabQS.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <script type="text/javascript">

        function GotoToList() {
            document.getElementById('opType').value = 'GotoToList';
            document.getElementById('historyListForm').submit();
        }
        function GotoToConfig() {
            document.getElementById('opType').value = 'GotoToConfig';
            document.getElementById('historyListForm').submit();
        }

        function SaveLastActive() {
            document.getElementById('tabActive').value = 1;
            SetActiveTab(1);
        }

        function SaveHistoryActive() {
            document.getElementById('tabActive').value = 2;
            SetActiveTab(2);
        }

        function SetActiveTab(activeID) {
            for(var i = 1; i < 15; i++) {
                if(document.getElementById("Tab" + i)) {
                    document.getElementById("Tab" + i).style.display = "none";
                }
                if(document.getElementById("Tab" + i + "_head")) {
                    document.getElementById("Tab" + i + "_head").className = "";
                }

            }
            if(document.getElementById("Tab" + activeID)) {
                document.getElementById("Tab" + activeID).style.display = "";
            }
            if(document.getElementById("Tab" + activeID + "_head")) {
                document.getElementById("Tab" + activeID + "_head").className = "activeitem";
            }
        }
    </script>

    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/DoMapping.css" type="text/css" />
    <%If Request("logType") = "live" Then%>
    <meta http-equiv="refresh" content="5" />
    <%End If%>
</head>
<body>
    <form id="historyListForm" runat="server">
        <input type="hidden" name="jobName" id="jobName" value="<%=Request("jobName")%>" />
        <input type="hidden" name="opType" id="opType" value="1" />
        <input type="hidden" name="tabActive" id="tabActive" value="<%=Request("tabActive")%>" />
        <%If Request("logType") = "live" Then%>
        <dw:Toolbar ID="historyListBar" runat="server" ShowStart="False" ShowEnd="False">
            <dw:ToolbarButton ID="historyBarOkButton" runat="server" Text="OK" OnClientClick="GotoToList();" ImagePath="/Admin/Images/Ribbon/Icons/Small/Check.png">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="historyBarReconfBtn" runat="server" Text="Reconfigure" OnClientClick="GotoToConfig();" ImagePath="/Admin/Images/Ribbon/Icons/Small/EditGear.png">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <%Else%>
        <dw:TabHeader ID="logTabs" ReturnWhat="all" runat="server" Tabs="Last" />
        <%End If%>
        <div id="Tab1">
            <dw:List ID="lastCtrl" runat="server" Height="512" ShowTitle="False" TranslateTitle="False" PageSize="22" Width="782">
                <Columns>
                    <dw:ListColumn ID="clmLastTime" runat="server" Name="Time" Width="160" EnableSorting="True" WidthPercent="10"></dw:ListColumn>
                    <dw:ListColumn ID="clmLastMessage" runat="server" Name="Message" Width="360"></dw:ListColumn>
                </Columns>
            </dw:List>
        </div>
        <div id="Tab2" style="display: none;">
            <dw:List ID="historyCtrl" runat="server" Height="512" ShowTitle="False" TranslateTitle="False" PageSize="22" Width="782">
                <Columns>
                    <dw:ListColumn ID="clmHistoryTime" runat="server" Name="Time" Width="160" EnableSorting="True" WidthPercent="10"></dw:ListColumn>
                    <dw:ListColumn ID="clmHistoryMessage" runat="server" Name="Message" Width="360"></dw:ListColumn>
                </Columns>
            </dw:List>
        </div>
        <dw:Infobar runat="server" Visible="false" ID="logFilesWarning" TranslateMessage="true" UseInlineStyles="true" Message="Showing the 5 newest logs. Older logs can be found in the file archive"></dw:Infobar>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
