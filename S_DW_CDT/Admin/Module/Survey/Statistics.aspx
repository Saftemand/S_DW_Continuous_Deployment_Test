<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Statistics.aspx.vb" Inherits="Dynamicweb.Admin.Survey.Statistics" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Statistic</title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
    </dw:ControlResources>
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
    <script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
    <script type="text/javascript" language="javascript" src="js/Survey.js" ></script>
    <script type="text/javascript">
        function help() {
            <%=Gui.Help("Survey", "modules.survey.general")%>
        }
    </script>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
</head>
<body style="overflow:hidden; ">
        <dw:Toolbar ID="SurveyToolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="listActions.home();" Image="Home" Text="Start" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbNewQuestion" runat="server" OnClientClick="listActions.newQuestion();" Image="AddGear" Text="Nyt spørgsmål" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbExtranetParticipants" runat="server" OnClientClick="listActions.showParticipants(2);" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Extranet participants">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbEmailParticipants" runat="server" OnClientClick="listActions.showParticipants(1);"  ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Email participants" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Hjælp">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <div class="list">
            <table width="100%" cellspacing="2" cellpadding="0" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #9faec2;">
                <tr>
                    <td>
                        <%=GetBreadcrumb() %>
                    </td>
                </tr>
            </table>
        </div>
        <div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
        <table cellpadding="5" cellspacing="0" border="0" class="clean" width="100%" height="100%" >
            <tr>
                <td>
                    <asp:Panel id="_panel" runat="server" width="100%" height="100%"></asp:Panel>
                    <asp:Panel id="_panelNoDataFound" runat="server" width="100%" height="100%" visible="false" cellpadding="0" cellspacing="0" border="0">
                        <%=Translate.Translate("Ingen data fundet")%>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>

<%Translate.GetEditOnlineScript()%>
</body>
</html>
