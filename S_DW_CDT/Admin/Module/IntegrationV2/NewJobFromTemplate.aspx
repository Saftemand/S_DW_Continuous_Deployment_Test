<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewJobFromTemplate.aspx.vb"
    Inherits="Dynamicweb.Admin.NewJobFromTemplate" %>

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
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/NewFromTemplate.css" type="text/css" />
</head>
<body onload="if (!(window.closePopup===undefined))parent.newFromTemplate_wnd.hide();"
    style="background-color: #f0f0f0; width: 530px; border-right-width: 0px; height: auto;">
    <form id="form1" runat="server">
        <input type="hidden" id="templateName" name="templateName"/>

    <div>
        <div class="header">
            <h3>
                <%=Translate.JsTranslate("Choose template:")%>
            </h3>
        </div>
        <div class="mainArea">
            <dw:Infobar ID="errorBar" runat="server" Visible="false">
            </dw:Infobar>
            <dw:List runat="server" ID="templatesList" Title="Templates"  Personalize="true" ShowHeader="False" >
                <Columns>
                    <dw:ListColumn ID="ListColumn1" Name="Name" runat="server" />
                </Columns>
            </dw:List>
        </div>
        <div class="footer">
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: left;">
                        <input type="button" value="<%=Translate.JsTranslate("Help")%>" onclick="<%=Dynamicweb.Gui.Help("", "modules.dataintegration.activity.edit") %>" />
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="parent.newFromTemplate_wnd.hide();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
            <dw:Dialog Title="Create" ID="NewFromTemplateDialog" Width="360" runat="server" ShowCancelButton="true" ShowOkButton="true" OkAction="$('form1').submit();">
               Enter name for new activity based on "<label id="templateNameLabel">test</label>":

<br/><br/>
            <div style="float: left; width: 100px">
                Name:
            </div>
            <div style="float: left;">
                <input type="text" id="newName" runat="server" class="NewUIinput" style="width:280px" /></div>
                
                <br/><br/>
                &nbsp
        </dw:Dialog>

    </form>

</body>
<%Translate.GetEditOnlineScript()%>
</html>
