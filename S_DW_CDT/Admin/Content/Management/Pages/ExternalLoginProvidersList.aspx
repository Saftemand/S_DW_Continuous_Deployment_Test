<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExternalLoginProvidersList.aspx.vb" Inherits="Dynamicweb.Admin.ExternalLoginProvidersList" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript">
        function Add() {
            if (!Toolbar.buttonIsDisabled('cmdAdd')) { { location.href = 'ExternalLoginProviderEdit.aspx'; } }
        }

        function GetHelp() {
            //Gui.Help("", "")
        }

        function SelectItem(id) {
            var url = 'ExternalLoginProviderEdit.aspx?id=' + id;            
            location.href = url;
        }
        function ChangeStatus(id) {
            location.href = 'ExternalLoginProvidersList.aspx?id=' + id + '&cmd=ChangeStatus';
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="cmdAdd" runat="server" Disabled="false" Divide="None" ImagePath="/admin/images/ribbon/icons/small/funnel_add.png" OnClientClick="Add()" Text="Add" />
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="GetHelp()" />
        </dw:Toolbar>
        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="External Login" runat="server" />
        </h2>        
        <dw:List ID="lstProviders" ShowPaging="true" ShowTitle="false" runat="server" PageSize="25">
            <Filters></Filters>
            <Columns>
                <dw:ListColumn ID="colIcon" EnableSorting="false" Width="25" runat="server" ItemAlign="Center" />
                <dw:ListColumn ID="colName" EnableSorting="true" Name="Login Provider Name" Width="175" runat="server" />
                <dw:ListColumn ID="colEnabled" ItemAlign="left" EnableSorting="false" Name="Active" Width="75" runat="server" />
            </Columns>
        </dw:List>

    </form>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
