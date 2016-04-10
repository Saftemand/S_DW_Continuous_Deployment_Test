<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EditSmsNewsletter.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.EditSmsNewsletter" ValidateRequest="false" %>

<%@ Register Src="Control/NewsletterProperties.ascx" TagName="NewsletterProperties"
    TagPrefix="np" %>
<%@ Register Src="/Admin/Module/Common/ComboRepeater.ascx" TagName="ComboRepeater" TagPrefix="cc" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Src="EditNewsletterStep4.ascx" TagName="EditNewsletterStep4" TagPrefix="uc4" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/letters.js"></script>
    <script type="text/javascript" src="/Admin/Module/Common/Common.js"></script>
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <script type="text/javascript">

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.newsletter.edit")%>
	    }
    </script>
</head>
<body>
    <form id="TheForm" runat="server" class="formNewsletter">
        <div id="containerNewsletter">
            <dw:RibbonBar ID="CategoryBar" runat="server">
                <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                    <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                        <dw:RibbonBarButton ID="btnCancel" Text="Cancel" Image="Cancel" Size="Large" runat="server"
                            EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click"  ShowWait="true"  WaitTimeout="1000" />
                        <dw:RibbonBarButton ID="btnSave" Text="Save as draft" Title="Save as draft" Image="Save" Size="Large" runat="server"
                            EnableServerClick="true" OnClick="Save_Click"  ShowWait="true"  WaitTimeout="1000" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonBarGroup3" Name="Step" runat="server">
                        <dw:RibbonBarButton ID="btnSendNow" Text="Send" Title="Send" Image="Redo"
                            Size="Large" runat="server" EnableServerClick="true" OnClick="SendNow_Click" ShowWait="true"  WaitTimeout="500" />
                        <dw:RibbonBarButton ID="btnSendQueue" Text="Put into a queue" Title="Put into a queue" 
                            ImagePath="/Admin/Images/SendInQueue.gif"
                            Size="Large" runat="server" EnableServerClick="true" OnClick="SendQueue_Click" ShowWait="true"  WaitTimeout="500" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Help" runat="server">
                        <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                            runat="server" OnClientClick="help();" />
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>
            <div class="list">
                <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="title">
                            <%=GetBreadcrumb() %>
                        </td>
                    </tr>
                </table>
            </div>
            <table border="0" cellpadding="0" cellspacing="2" class="tabTable">
                <tbody>
                    <tr>
                        <td valign="top">
                            <dw:GroupBoxStart runat="server" ID="PropertiesStart" doTranslation="true" Title="Properties"
                                ToolTip="Properties" />
                            <np:NewsletterProperties ID="NewsletterProperties1" runat="server" />
                            <dw:GroupBoxEnd runat="server" ID="PropertiesEnd" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <dw:GroupBoxStart runat="server" ID="ToStart" doTranslation="true" Title="To" ToolTip="To" />
                            <cc:ComboRepeater ID="Categories" runat="server" DataTextField="Name" DataValueField="ID"
                                DropDownLabel="Category" RequiredMessage="add at least one category, please" />
                            <dw:GroupBoxEnd runat="server" ID="ToEnd" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <dw:GroupBoxStart runat="server" ID="MessageStart" doTranslation="true" Title="Message"
                                ToolTip="Message" />
                            <asp:TextBox runat="server" ID="TextEditor" CssClass="std" Columns="25" Width="560"
                                Rows="5" TextMode="MultiLine" />
                            <dw:GroupBoxEnd runat="server" ID="MessageBoxEnd" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <dw:GroupBoxStart runat="server" ID="TestStart" doTranslation="true" Title="Test"
                                ToolTip="Test" />
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td class="leftCol" id="SenderNameLabel" valign="top">
                                        <dw:TranslateLabel runat="server" Text="Mobile" />
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="TestMobile" CssClass="std" MaxLength="255"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="SendTest" CssClass="buttonSubmit" Text="Send test" /></td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <span style="color: Red">
                                            <dw:TranslateLabel runat="server" ID="InvalidPhoneNumber" Text="Invalid phone number"
                                                Visible="false" />
                                        </span>
                                        <dw:TranslateLabel runat="server" ID="TestSendSuccess" Text="Message was sent successfully"
                                            Visible="false" />
                                        <dw:TranslateLabel runat="server" ID="TestSendFailure" Text="Message was not sent."
                                            Visible="false" />
                                        &nbsp;<asp:Label ID="SendError" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <dw:GroupBoxEnd runat="server" ID="TestEnd" />
                        </td>
                    </tr>
                    <uc4:EditNewsletterStep4 ID="StepSend" runat="server" />
                </tbody>
            </table>
        </div>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>

