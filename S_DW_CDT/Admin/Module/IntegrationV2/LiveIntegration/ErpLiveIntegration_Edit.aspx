<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="1ErpLiveIntegration_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ErpLiveIntegration_Edit" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Live Integration Add-ins</title>
    <dw:ControlResources ID="ctrlResources" runat="server" IncludePrototype="true" IncludeUIStylesheet="true" />
    <script type="text/javascript">
        function redirectToSettingsPage(typeName) {
            var url = '/Admin/Module/IntegrationV2/LiveIntegration/LiveIntegrationAddInSettings.aspx';
            if (typeName != null) {
                url += '?addInFullName=' + typeName;
            }
            window.location.href = url;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
        <dw:List ID="addInList" Title="Live Integration Add-Ins list" AllowMultiSelect="false" TranslateTitle="True" runat="server">
            <Columns>
                <dw:ListColumn ID="addInName" Name="Add-In Name" runat="server" Width="200" />
                <dw:ListColumn ID="addInType" Name="Add-In Label" runat="server" Width="200" />                    
            </Columns>
        </dw:List>
        <dw:ContextMenu ID="addInListContextMenu" runat="server">
            <dw:ContextMenuButton runat="server" ID="addInLogButton" Text="Show log" Image="Information"></dw:ContextMenuButton>
            <dw:ContextMenuButton runat="server" ID="addInDownloadLogButton" Text="Download log" Image="Download"></dw:ContextMenuButton>
        </dw:ContextMenu>
        <dw:PopUpWindow ID="historyLogPopup" AutoReload="true" Width="800" Height="560" ShowCancelButton="false" ShowOkButton="false" ShowClose="True" Title="Live Integration add-in log" runat="server" IsModal="False" AutoCenterProgress="True" />
        <% 
        Translate.GetEditOnlineScript()
        %>
    </form>
</body>
</html>
