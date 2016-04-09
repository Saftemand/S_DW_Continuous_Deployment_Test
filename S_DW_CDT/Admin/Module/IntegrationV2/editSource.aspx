<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="editSource.aspx.vb" Inherits="Dynamicweb.Admin.editSource" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>

    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/editSource.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="header">
                <label id="labelProviderType" runat="server">
                </label>
            </div>
        </div>
        <div class="mainArea">
            <dw:Infobar ID="errorBar" runat="server" Visible="false">
            </dw:Infobar>
            <asp:Literal ID="sourceSelectorScripts" runat="server"></asp:Literal>
            <de:AddInSelector ID="SourceSelector" runat="server" ShowOnlySelectedGroup="true" AddInGroupName="Source" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Data.Integration.Interfaces.ISource" AddInShowSelector="false" AddInShowFieldset="false" />
            <asp:Literal ID="sourceSelectorLoadScript" runat="server"></asp:Literal>
        </div>
        </div>
        <div class="footer">
            <asp:Button runat="server" Text="Save changes" /></div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
