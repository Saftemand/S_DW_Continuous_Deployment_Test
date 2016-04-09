<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="editDestination.aspx.vb" Inherits="Dynamicweb.Admin.editDestination" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>
    <script type="text/javascript" src="/Admin/Link.js"></script>

    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/editDestination.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/editDestination.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="header">
                <label id="labelProviderType" runat="server">
                </label>
                <div class="mainArea">
                    <dw:Infobar ID="errorBar" runat="server" Visible="false">
                    </dw:Infobar>
                    <asp:Literal ID="destinationSelectorScripts" runat="server"></asp:Literal>
                    <de:AddInSelector ID="DestinationSelector" runat="server" ShowOnlySelectedGroup="true" AddInGroupName="Destination" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Data.Integration.Interfaces.IDestination" AddInShowSelector="false" AddInShowFieldset="false" />
                    <asp:Literal ID="destinationSelectorLoadScript" runat="server"></asp:Literal>
                </div>
            </div>
            <div class="footer">
                <asp:Button ID="Button1" runat="server" Text="Save changes" />
            </div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
