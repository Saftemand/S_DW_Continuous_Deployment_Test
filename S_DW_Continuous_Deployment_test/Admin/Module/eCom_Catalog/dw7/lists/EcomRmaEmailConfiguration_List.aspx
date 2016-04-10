<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomRmaEmailConfiguration_List.aspx.vb"
    Inherits="Dynamicweb.Admin.EcomRmaEmailConfiguration_List" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/layermenu.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar runat="server" ID="Toolbar" ShowStart="true" ShowEnd="false">
    </dw:Toolbar>
    <!-- table to show emails in -->
    <dw:List runat="server" ID="StateEmailConfigurations" ShowTitle="false" ShowPaging="false">
        <Columns>
            <dw:ListColumn runat="server" ID="stateColumn" Name="State email notifications" WidthPercent="45" />
            <dw:ListColumn runat="server" ID="stateNotificationCountColumn" Name="Notifications"
                WidthPercent="45" />
            <dw:ListColumn runat="server" ID="stateNewNotificationColumn" Name="New" WidthPercent="10" />
        </Columns>
    </dw:List>
    <br />
    <div style="height: 5px;">
        &nbsp;</div>
    <!-- table to show emails in -->
    <dw:List runat="server" ID="EventEmailConfigurations" ShowTitle="false" ShowPaging="false">
        <Columns>
            <dw:ListColumn runat="server" ID="eventcolumn" Name="Event email notifications" WidthPercent="45" />
            <dw:ListColumn runat="server" ID="eventNotificationCountColumn" Name="Notifications"
                WidthPercent="45" />
            <dw:ListColumn runat="server" ID="ListColumn1" Name="New" WidthPercent="10" />
        </Columns>
    </dw:List>
    <br />
    <div style="height: 5px;">
        &nbsp;</div>
    <!-- table to show emails in -->
    <dw:List runat="server" ID="replacementOrderProviderEmailConfigurations" ShowTitle="false"
        ShowPaging="false">
        <Columns>
            <dw:ListColumn runat="server" ID="replacementOrderProviderColumn" Name="Replacement order provider email notifications"
                WidthPercent="45" />
            <dw:ListColumn runat="server" ID="replacementOrderProviderNotificationCounColumn"
                Name="Notifications" WidthPercent="45" />
            <dw:ListColumn runat="server" ID="ListColumn2" Name="New" WidthPercent="10" />
        </Columns>
    </dw:List>
    <div style="height: 5px;">
        &nbsp;</div>
    <%--    <!-- Add button -->
        <div style="margin: 5px 5px 5px 5px;">
            <a onclick="addNewMail();" title="<%=Dynamicweb.Backend.Translate.JsTranslate("Add new notification e-mail") %>">
                <span style="font-style: italic; color: Gray;" onmouseover="this.style.textDecoration = 'underline';"
                    onmouseout="this.style.textDecoration = 'none';">
                    <img src="/Admin/Module/eCom_CartV2/images/mail_add.png" alt="" style="vertical-align: top;" />
                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Add notification" />
                </span></a>
        </div>--%>
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>