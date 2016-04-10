<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCButtons.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.UCButtons" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.NewsLetterV3" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<script type="text/javascript">
    var recipientCustomFieldContext = '<%=Consts.RecipientCustomFieldContext%>'
</script>
<script type="text/javascript" src="UCButtons.js"></script>

    <script type="text/javascript">
        function help() {
		           <%=Gui.Help("newsletterv3", "modules.newsletterv3.general")%>
	            }
	</script>

        <dw:RibbonBar ID="NewsBar" runat="server">
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="RibbonBarButton1" ImagePath="/Admin/Images/Icons/Module_Newsletter_NewLetter.gif" Size="Large" Text="New newsletter" Title="New newsletter" 
                        runat="server" OnClientClick="NewNewsletter();" />
                    <dw:RibbonBarButton ID="RibbonBarButton2" ImagePath="/Admin/Images/Icons/Module_NewsLetterV3_NR.gif" Size="Large" Text="New recipient" Title="New recipient"
                        runat="server" OnClientClick="NewRecipient();" />
                    <dw:RibbonBarButton ID="RibbonBarButton3" ImagePath="/Admin/Images/Icons/Module_Newsletter_NewList.gif" Size="Large" Text="New category" Title="New category" 
                        runat="server" OnClientClick="NewCategory();" />
                    <dw:RibbonBarButton ID="RibbonBarButton4" ImagePath="/Admin/Images/Icons/Module_Newsletter_UserFields.gif" Size="Large" Text="Custom fields" Title="Custom fields"
                        runat="server" OnClientClick="CustomFields();" />
                    <dw:RibbonBarButton ID="RibbonBarButton5" ImagePath="/Admin/Images/Icons/Module_NewsletterV3_CE.gif" Size="Large" Text="Check Emails" Title="Check Emails" 
                        runat="server" OnClientClick="CheckEmails();" />
                    <dw:RibbonBarButton ID="RibbonBarButton6" ImagePath="/Admin/Images/Icons/Module_NewsletterV3_Import.gif" Size="Large" Text="Import\Export" Title="Import\Export"
                        runat="server" OnClientClick="ImportRecipient();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Edit" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                        runat="server" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>

<%Translate.GetEditOnlineScript()%>