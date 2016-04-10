<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectTableMappings.aspx.vb" Inherits="Dynamicweb.Admin.SelectTableMappings" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.AjaxTest" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/SelectTableMappings.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/SelectTableMappings.css" type="text/css" />
    <title></title>
    <style type="text/css">
        
    </style>
</head>
<body onload="if (!(window.doMapping===undefined)) {parent.changeUrl('DoMapping.aspx'); var o = new overlay('waitForNewJob'); o.show();}" style="background-color: #f0f0f0; width: 530px; border-right-width: 0px; height: auto;">
    <form id="form1" runat="server">
        <dw:Overlay ID="waitForNewJob" Message="Please wait" runat="server">
        </dw:Overlay>
        <div id="content">
            <div class="header">
                <h3>
                    <%=Translate.JsTranslate("Select source tables")%></h3>
            </div>
            <div class="mainArea">
                <dw:Infobar runat="server" ID="errorInfoBar" Visible="false">
                </dw:Infobar>
                <table class="mappings">
                    <tr>
                        <th class="mappingsth">
                            <input type="checkbox" id="checkAll" onclick="toggleAll()" style="float: left; padding-left: 3px" />
                            <label title="source" style="display: inline-block; width: 150px; float: left;">
                                <%=Translate.JsTranslate("Source")%></label>
                            <label title="destination" style="display: inline-block; width: 300px; float: left; padding-left: 50px">
                                <%=Translate.JsTranslate("Destination")%></label>
                        </th>
                    </tr>
                    <tr>
                        <td class="mappingstd">
                            <div id="tableMappings" runat="server" style="width: 550px; height: 250px; overflow: auto; overflow-x: hidden">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <table style="width: 100%;">
                    <tr>
                        <td style="text-align: left;">
                            <input type="button" value="<%=Translate.JsTranslate("Help")%>" onclick="<%=Dynamicweb.Gui.Help("", "modules.dataintegration.activity.edit") %>" />
                        </td>
                        <td style="text-align: right;">
                            <input type="hidden" id="goBack" runat="server" />
                            <input type="submit" value="<%=Translate.JsTranslate("Previous")%>" onclick="$('goBack').value = 'true';" />
                            <input type="submit" value="<%=Translate.JsTranslate("Finish")%>" onclick="dialog.show('newJob'); return false;" />
                            <input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="parent.newWizard_wnd.hide();" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <dw:Dialog Title="New activity" ID="newJob" Width="390" runat="server" ShowCancelButton="true" ShowOkButton="true" OkOnEnter="true" OkAction="$('form1').submit();">
            <div style="float: left; width: 100px">
                <%=Translate.JsTranslate("Activity name")%>
            </div>
            <div style="float: left;">
                <input type="text" id="newJobName" name="newJobName" runat="server" class="NewUIinput" />
            </div>
            <br />
            <div style="float: left; width: 100px; margin-top: 5px;">
                <%=Translate.JsTranslate("Activity description")%>
            </div>
            <div style="float: left; margin-top: 5px;">
                <textarea id="newJobDesc" name="newJobDesc" runat="server" rows="3" cols="30"></textarea>
            </div>
            <br />
            <input style="margin-top: 5px;" type="checkbox" id="newJobAutomatedMapping" name="newJobAutomatedMapping" runat="server" />
            <label for="newJobAutomatedMapping">
                <%=Translate.JsTranslate("Perform mapping automatically on run")%></label>
        </dw:Dialog>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
