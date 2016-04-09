<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Task.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.Task" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scheduler task</title>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" style="height:100%;">
                <tr>
                    <td valign="top" style="height:20px;">
                        <dw:TranslateLabel runat="server" ID="NewNewsletterLabel" Text="Send e-mails log." />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <dw:TranslateLabel runat="server" ID="TranslateLabel2" Text="Sent count" />
                        :<asp:Label ID="lblSentCount" runat="server"></asp:Label>
                        <br />
                        <dw:TranslateLabel runat="server" ID="TranslateLabel3" Text="Errors count" />
                        :<asp:Label ID="lblErrorsCount" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblLog" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>                  
                        <dw:TranslateLabel runat="server" ID="TranslateLabel1" Text="There were deleted " />
                        <asp:Label ID="lblObsoletedUnconfirmedSubscriptionChanges" runat="server"></asp:Label>
                        <dw:TranslateLabel runat="server" ID="TranslateLabel4" Text="obsoleted unconfirmed subscription changes and registrations." />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
