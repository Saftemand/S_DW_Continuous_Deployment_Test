<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectDestination.aspx.vb" Inherits="Dynamicweb.Admin.SelectDestination" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
    <script type="text/javascript" src="/Admin/Link.js"></script>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/SelectDestination.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/SelectDestination.css" type="text/css" />
</head>
<body style="background-color: #f0f0f0; width: 530px; border-right-width: 0px; height: auto;" onload="if (!(window.doMapping===undefined)) {parent.changeUrl('DoMapping.aspx'); document.getElementById('content').innerHTML='Please Wait';} else document.getElementById('Dynamicweb.Data.Integration.Interfaces.IDestination_AddInTypes').focus()">
    <div id="content">
        <dw:Overlay ID="forward" Message="Please wait" runat="server">
        </dw:Overlay>
        <form id="form1" runat="server">
            <div>
                <div class="header">
                    <h3>
                        <%=Translate.JsTranslate("Choose a destination:")%></h3>
                </div>
                <div class="mainArea">
                    <dw:Infobar ID="errorBar" runat="server" Visible="false">
                    </dw:Infobar>
                    <input type="hidden" id="goBack" runat="server" />
                    <asp:Literal ID="destinationSelectorScripts" runat="server"></asp:Literal>
                    <de:AddInSelector ID="destinationSelector" runat="server" ShowOnlySelectedGroup="true" AddInGroupName="Destination" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Data.Integration.Interfaces.IDestination" AddInIgnoreTypeName="Dynamicweb.Data.Integration.Interfaces.INotDestination" AddInShowFieldset="false" useNewUI="True" onBeforeUpdateSelection='deactivateButtons();' onafterUpdateSelection='activateButtons()' />
                    <asp:Literal ID="destinationSelectorLoadScript" runat="server"></asp:Literal>
                </div>
                <div class="footer">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: left;">
                                <input type="button" value="<%=Translate.JsTranslate("Help")%>" onclick="<%=Dynamicweb.Gui.Help("", "modules.dataintegration.activity.edit") %>" />
                            </td>
                            <td style="text-align: right;">
                                <input type="submit" id="forwardButton" value="<%=Translate.JsTranslate("Previous")%>" onclick="$('goBack').value = 'true';" />
                                <input type="submit" id="backButton" value="<%=Translate.JsTranslate("Next")%>" onclick="var o = new overlay('forward');o.show();" />
                                <input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="parent.newWizard_wnd.hide();" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
    </div>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
