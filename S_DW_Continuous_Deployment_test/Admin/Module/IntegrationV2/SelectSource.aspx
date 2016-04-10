<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectSource.aspx.vb" Inherits="Dynamicweb.Admin.SelectSource" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>

    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/SelectSource.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/SelectSource.css" type="text/css" />
    <style type="text/css">
        
    </style>
</head>
<body onload="document.getElementById('Dynamicweb.Data.Integration.Interfaces.ISource_AddInTypes').focus()" style="background-color: #f0f0f0; width: 530px; border-right-width: 0px; height: auto;">
    <form id="form1" runat="server">
        <div>
            <div class="header">
                <h3>
                    <%=Translate.JsTranslate("Choose data source:")%>
                </h3>
            </div>
            <div class="mainArea">
                <dw:Infobar ID="errorBar" runat="server" Visible="false">
                </dw:Infobar>
                <asp:Literal ID="sourceSelectorScripts" runat="server"></asp:Literal>
                <de:AddInSelector ID="sourceSelector" runat="server" ShowOnlySelectedGroup="true" AddInGroupName="Source" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Data.Integration.Interfaces.ISource" AddInShowFieldset="false" AddInIgnoreTypeName="Dynamicweb.Data.Integration.Interfaces.INotSource" useNewUI="True" onBeforeUpdateSelection='deactivateButtons();' onafterUpdateSelection='activateButtons()' />
                <asp:Literal ID="sourceSelectorLoadScript" runat="server"></asp:Literal>
            </div>
            <div class="footer">
                <table style="width: 100%;">
                    <tr>
                        <td style="text-align: left;">
                            <input type="button" value="<%=Translate.JsTranslate("Help")%>" onclick="<%=Dynamicweb.Gui.Help("", "modules.dataintegration.activity.edit") %>" />
                        </td>
                        <td style="text-align: right;">
                            <input type="submit" disabled="disabled" value="<%=Translate.JsTranslate("Previous")%>" />
                            <input type="submit" value="<%=Translate.JsTranslate("Next")%>" id="forwardButton" disabled="true" />
                            <input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="parent.newWizard_wnd.hide();" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
