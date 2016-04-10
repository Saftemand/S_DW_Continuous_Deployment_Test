<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Content/Management/EntryContent.Master" CodeBehind="Reports.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Management.Reports" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" TagName="ReportSelector" Src="~/Admin/Module/OMC/Controls/ReportSelector.ascx" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <%=Dynamicweb.Gui.WriteFolderManagerScript()%>

     <script type="text/javascript">
         var page = SettingsPage.getInstance();

         page.onSave = function () {
             document.frmGlobalSettings.submit();
         }
    </script>

    <!--[if IE]>
    <style type="text/css">
        .omc-account select
        {
            width: 254px;
        }
    </style>
    <![endif]-->

    <style type="text/css">
        .popup-dialog-buttons button
        {
            display: block;
            margin: 5px;
        }
    </style>
</asp:Content>
<asp:Content  ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent" class="omc-control-panel">
        <dw:GroupBox ID="gbExportedReportsEmailNotifications" Title="E-mail notifications - Reports" runat="server">
             <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2" class="omc-cpl-hint">
                        <dw:TranslateLabel ID="lbExportedReportsEmailNotifications" Text="Here you can define when to send email notifications containing report data." runat="server" />
                    </td>
                </tr>
            </table>

            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td style="width: 170px">
                        <dw:TranslateLabel ID="lbSendEvery" Text="Send interval (days)" runat="server" />
                    </td>
                    <td>
                        <omc:NumberSelector ID="numReportsSendInterval" RequestKey="/Globalsettings/Modules/OMC/Notifications/ReportsSendInterval"
                            SelectedValue="<%$ GS: (System.Int32) /Globalsettings/Modules/OMC/Notifications/ReportsSendInterval  %>" 
                            AllowNegativeValues="false" MinValue="1" MaxValue="365" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="lbSendFrame" Text="Send between (hours)" runat="server" />
                    </td>
                    <td>
                        <div class="omc-cpl-numrange">
                            <div class="omc-cpl-numrange-selector">
                                <omc:NumberSelector ID="numSendFrameFrom" RequestKey="/Globalsettings/Modules/OMC/Notifications/ReportsSendFrom"
                                    SelectedValue="<%$ GS: (System.Int32) /Globalsettings/Modules/OMC/Notifications/ReportsSendFrom  %>" 
                                    AllowNegativeValues="false" MinValue="1" MaxValue="24" runat="server" />
                            </div>

                            <div class="omc-cpl-numrange-separator">
                                <dw:TranslateLabel ID="lbAnd" Text="and" runat="server" />
                            </div>

                            <div class="omc-cpl-numrange-selector">
                                <omc:NumberSelector ID="numSendFrameTo" RequestKey="/Globalsettings/Modules/OMC/Notifications/ReportsSendTo"
                                    SelectedValue="<%$ GS: (System.Int32) /Globalsettings/Modules/OMC/Notifications/ReportsSendTo  %>" 
                                    AllowNegativeValues="false" MinValue="1" MaxValue="24" runat="server" />
                            </div>

                            <div class="omc-clear"></div>
                        </div>
                    </td>
                </tr>
            </table>

            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2" class="omc-cpl-hint" style="padding-top: 20px">
                        <dw:TranslateLabel ID="lbSchemeAndRecipients" Text="Here you can specify whom to send notifications and what notification scheme to use." runat="server" />
                    </td>
                </tr>
            </table>

            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td style="width: 170px">
                        <dw:TranslateLabel ID="lbScheme" Text="Scheme" runat="server" />
                    </td>
                    <td>
                        <asp:Literal ID="litNotificationProfile" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="padding-top: 4px">
                        <dw:TranslateLabel ID="lbRecipients" Text="Recipients" runat="server" />
                    </td>
                    <td>
                        <omc:EditableListBox id="editRecipients" RequestKey="/Globalsettings/Modules/OMC/Notifications/ReportsRecipients"
                            SelectedItems="<%$ GS: (System.String[]) /Globalsettings/Modules/OMC/Notifications/ReportsRecipients  %>" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px">
                        <dw:TranslateLabel ID="lbReports" Text="Reports to send" runat="server" />
                    </td>
                    <td>
                        <div class="omc-reports-field">
                            <input type="button" id="cmdSelectReports" class="newUIbutton" value="<%=Dynamicweb.Backend.Translate.Translate("Select reports")%>" onclick="dialog.show('dglSelectReports');" />

                            <dw:Dialog ID="dglSelectReports" Title="Select reports" UseTabularLayout="true" TranslateTitle="true" Width="350" ShowOkButton="true" ShowCancelButton="false" ShowHelpButton="false" HidePadding="true" runat="server">
                                <omc:ReportSelector id="repSelector" Height="400" RequestKey="/Globalsettings/Modules/OMC/Notifications/ReportsDefinitions" runat="server" />
                            </dw:Dialog>
                        <div class="omc-reports-field">
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <!-- Reseting "Last sent" time when saving the settings -->
        <input type="hidden" name="/Globalsettings/Modules/OMC/Notifications/ReportsLastSent" value="" />

        <br />

        <dw:GroupBox ID="gbGoogleAnalytics" Title="Integration with Google Analytics" runat="server">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2" class="omc-cpl-hint">
                        <dw:TranslateLabel ID="lbGoogleAnalyticsDescription" Text="Provide your Google Analytics account credentials." runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px">
                        <dw:TranslateLabel ID="lbGoogleAnalyticsUsername" Text="Username" runat="server" />
                    </td>
                    <td>
                        <input type="text" id="txGoogleAnalyticsUsername" class="std" name="/Globalsettings/Modules/OMC/GoogleAnalyticsUsername" 
                            value="<%=Dynamicweb.Base.GetGs("/Globalsettings/Modules/OMC/GoogleAnalyticsUsername")%>" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="lbGoogleAnalyticsPassword" Text="Password" runat="server" />
                    </td>
                    <td>
                        <input type="password" id="txGoogleAnalyticsPassword" class="std" name="/Globalsettings/Modules/OMC/GoogleAnalyticsPassword" 
                            value="<%=Dynamicweb.Base.GetGs("/Globalsettings/Modules/OMC/GoogleAnalyticsPassword")%>" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="omc-cpl-hint" style="padding-top: 20px">
                        <dw:TranslateLabel ID="lbGoogleAnalyticsProfileDescription" Text="Select Google Analytics profile to query data from." runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel ID="lbGoogleAnalyticsAccount" Text="Profile" runat="server" />
                    </td>
                    <td>
                        <div class="omc-account">
                            <asp:Literal ID="litAccountSelector" runat="server" />&nbsp;
                            <input type="button" id="cmdAccountDiscovery" class="newUIbutton" value="<%=Dynamicweb.Backend.Translate.Translate("Refresh")%>" />
                        </div>

                        <div class="omc-clear" />

                        <input type="hidden" id="ddAccountIDHidden" name="/Globalsettings/Modules/OMC/GoogleAnalyticsTableID" 
                            value="<%=Dynamicweb.Base.GetGs("/Globalsettings/Modules/OMC/GoogleAnalyticsTableID")%>" />

                        <input type="hidden" id="ddAccountTitleHidden" name="/Globalsettings/Modules/OMC/GoogleAnalyticsTableTitle" 
                            value="<%=Dynamicweb.Base.GetGs("/Globalsettings/Modules/OMC/GoogleAnalyticsTableTitle")%>" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </div>

    <script type="text/javascript">
        <asp:Literal id="litScript" runat="server" />
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

</asp:Content>
