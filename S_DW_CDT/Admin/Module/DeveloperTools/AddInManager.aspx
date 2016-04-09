<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddInManager.aspx.vb" Inherits="Dynamicweb.Admin.NotificationsManager" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dw:List runat="server" ID="lstNotificationSubscribers" StretchContent="true" Title="Notification subscribers" PageSize="25" ShowCount="true">
            <Filters>
                <dw:ListAutomatedSearchFilter runat="server" ID="fSearch" Width="300" EnableQueryExpressions="true" />
                <dw:ListFlagFilter runat="server" ID="fShowDynamicwebDLLs" AutoPostBack="true" Label="Show default solution assemblies" IsSet="true" Width="200" />
            </Filters>
            <Columns>
                <dw:ListColumn runat="server" ID="clmName" HeaderAlign="Left" Name="Name" EnableSorting="true" />
                <dw:ListColumn runat="server" ID="clmFullyQualifiedName" HeaderAlign="Left" Name="Fully qualified name" EnableSorting="true" />
                <dw:ListColumn runat="server" ID="clmAssemblyName" HeaderAlign="Left" Name="Assembly name" EnableSorting="true" />
                <dw:ListColumn runat="server" ID="clmEnabled" HeaderAlign="Left" Name="Enabled" EnableSorting="true" />
            </Columns>
        </dw:List>
    </div>
    </form>

    <script type="text/javascript">
        function saveTypeConfiguration() {
            var url = "AddInManager.aspx?Cmd=EditType&Type=" + encodeURIComponent($('type').innerText) + "&disabled=" + $('chkDisabled').checked;
            new Ajax.Request(url, {
                asynchronous: true,
                method: 'get',
                onSuccess: function (response) {
                    location.href = location.href;
                }
            });
        }
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>