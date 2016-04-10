<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EditNewsletter.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletter" ValidateRequest="false" %>
<%@ Register Src="EditNewsletterStep0.ascx" TagName="EditNewsletterStep0" TagPrefix="uc0" %>
<%@ Register Src="EditNewsletterStep1.ascx" TagName="EditNewsletterStep1" TagPrefix="uc1" %>
<%@ Register Src="EditNewsletterStep2.ascx" TagName="EditNewsletterStep2" TagPrefix="uc2" %>
<%@ Register Src="EditNewsletterStep3.ascx" TagName="EditNewsletterStep3" TagPrefix="uc3" %>
<%@ Register Src="EditNewsletterStep4.ascx" TagName="EditNewsletterStep4" TagPrefix="uc4" %>
<%@ Register Src="EditNewsletterStepTest.ascx" TagName="EditNewsletterStepTest" TagPrefix="ucTest" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
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
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/letters.js"></script>
    <script type="text/javascript" src="/Admin/Module/Common/Common.js"></script>
    <script type="text/javascript">
        function OnSubmit(theForm)
        {
            if ("function" == typeof(html))
            {
                var htmlEditorRow = document.getElementById('HtmlEditorRow');
                if (htmlEditorRow && htmlEditorRow.style.display != 'none')
                    html();
            }
            return true;
        }  

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.newsletter.edit")%>
	    }
    </script>

</head>
<body>
    <form target="Preview" action="PreviewMessageInBrowser.aspx" name="previewForm" method="post"
        class="formNewsletter">
        <input type="hidden" name="txtTextPreview" /><input type="hidden" name="txtHTMLPreview" />
    </form>
    <form id="TheForm" runat="server" onsubmit="OnSubmit(this)" class="formNewsletter">
            <dw:RibbonBar ID="CategoryBar" runat="server">
                <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                    <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                        <dw:RibbonBarButton ID="btnCancel" Text="Cancel" Image="Cancel" Size="Large" runat="server"
                            EnableServerClick="true" PerformValidation="false" OnClick="Cancel_Click" />
                        <dw:RibbonBarButton ID="btnSave" Text="Save as draft" Title="Save as draft" Image="Save" Size="Large" runat="server"
                            EnableServerClick="true" PerformValidation="false" OnClick="Save_Click" ShowWait="true" WaitTimeout="1000"/>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonBarGroup3" Name="Step" runat="server">
                        <dw:RibbonBarButton ID="btnBack" Text="Back" Title="Back" Image="NavigateLeft" Size="Large" runat="server"  
                            EnableServerClick="true" PerformValidation="false" OnClick="GoBack_Click" ShowWait="true" WaitTimeout="500" />
                        <dw:RibbonBarButton ID="btnNext" Text="Next" Title="Next" Image="NavigateRight" Size="Large"
                            runat="server"  EnableServerClick="true" OnClick="GoNext_Click" ShowWait="true" WaitTimeout="500" />
                        <dw:RibbonBarButton ID="btnSendNow" Text="Send" Title="Send" Image="Redo"
                            Size="Large" runat="server" EnableServerClick="true" OnClick="SendNow_Click" ShowWait="true" WaitTimeout="1000" />
                        <dw:RibbonBarButton ID="btnSendQueue" Text="Put into a queue" Title="Put into a queue" 
                            ImagePath="/Admin/Images/SendInQueue.gif" ShowWait="true" WaitTimeout="500"
                            Size="Large" runat="server" EnableServerClick="true" OnClick="SendQueue_Click" />
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
                            <%= GetBreadcrumb()%>
                        </td>
                    </tr>
                </table>
            </div>
            <dw:StretchedContainer ID="OuterContainer" Stretch="Fill" Anchor="document" runat="server">
                <table  width="100%" border="0" cellpadding="0" cellspacing="2">
                    <uc0:EditNewsletterStep0 ID="Step0" runat="server" />
                    <uc1:EditNewsletterStep1 ID="Step1" runat="server" />
                    <uc2:EditNewsletterStep2 ID="Step2" runat="server" />
                    <uc3:EditNewsletterStep3 ID="Step3" runat="server" />
                    <uc4:EditNewsletterStep4 ID="Step4" runat="server" />
                    <ucTest:EditNewsletterStepTest ID="StepTest" runat="server" />
                </table>
            </dw:StretchedContainer>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>

