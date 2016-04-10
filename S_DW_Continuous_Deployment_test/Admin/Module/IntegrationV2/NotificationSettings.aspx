<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NotificationSettings.aspx.vb" Inherits="Dynamicweb.Admin.NotificationSettings" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true">
    </dw:ControlResources>

    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>

    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/notificationSettings.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="header">
                <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="The notification is sent after the activity has been executed, notifying the recipients about the status of the activity execution including an activity log" />
            </div>
            <div class="mainArea">
                <div style="margin-right: 40px;">
                    <dw:Infobar runat="server" ID="errorInfoBar" Visible="false">
                    </dw:Infobar>
                </div>
                <table width="100%" cellspacing="2" cellpadding="2" border="0">
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sender name" />
                        </td>
                        <td>
                            <input type="text" runat="server" id="txtSenderDisplayName" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Sender e-mail" />
                        </td>
                        <td>
                            <input type="text" runat="server" id="txtSenderEmail" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Recipients list (separate e-mails by semicolon)" />
                        </td>
                        <td>
                            <input type="text" runat="server" id="txtRecipients" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Notification e-mail template" />
                        </td>
                        <td>
                            <dw:FileManager ID="templateSelector" runat="server" FixFieldName="true" ShowPreview="false" Folder="Templates/DataIntegration/Notifications" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="On failure only" />
                        </td>
                        <td>
                            <input type="checkbox" runat="server" id="chkOnFailure" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <button type="submit"><%= Translate.Translate("Save changes")%></button>                
            </div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
