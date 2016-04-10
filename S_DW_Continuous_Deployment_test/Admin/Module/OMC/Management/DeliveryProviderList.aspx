<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DeliveryProviderList.aspx.vb" Inherits="Dynamicweb.Admin.DeliveryProviderList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
</head>
<body>
    <dw:Toolbar runat="server" ID="tlbMenu" ShowEnd="false">
        <dw:ToolbarButton runat="server" ID="btnCancel" Image="Cancel" Text="Cancel" OnClientClick="location.href = '/Admin/Content/Management/Start.aspx';" Divide="After" />
        <dw:ToolbarButton runat="server" ID="btnNew" Image="WindowNew" Text="New" OnClientClick="location.href = '/Admin/Module/OMC/Management/DeliveryProviderEdit.aspx';" Divide="After" />
        <dw:ToolbarButton runat="server" ID="btnHelp" Image="Help" Text="Help" OnClientClick="GetHelp();" />
    </dw:Toolbar>
    <dw:List runat="server" ID="lstDeliveryProviders" StretchContent="true" PageSize="25" ShowCount="true" Title="Delivery providers">
        <Columns>
            <dw:ListColumn runat="server" ID="clmName" Name="Name" EnableSorting="true" WidthPercent="80" />
            <dw:ListColumn runat="server" ID="clmSupportsBounced" Name="Shows bounced" EnableSorting="true" WidthPercent="5" />
            <dw:ListColumn runat="server" ID="clmSupportsSpam" Name="Shows spam" EnableSorting="true" WidthPercent="5" />
            <dw:ListColumn runat="server" ID="clmSupportsBlocked" Name="Shows blocked" EnableSorting="true" WidthPercent="5" />
            <dw:ListColumn runat="server" ID="clmSupportsInvalid" Name="Shows invalid" EnableSorting="true" WidthPercent="5" />
        </Columns>
    </dw:List>

    <script type="text/javascript">
        function GetHelp() {
            <%=Gui.Help("emailmarketing", "omc.management.emailmarketing.deliveryproviders")%>
        }
    </script>

    <% Translate.GetEditOnlineScript()%>
</body>
</html>
