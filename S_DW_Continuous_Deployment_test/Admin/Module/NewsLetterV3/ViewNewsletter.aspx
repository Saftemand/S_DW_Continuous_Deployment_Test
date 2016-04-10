<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ViewNewsletter.aspx.vb"  Inherits="Dynamicweb.Admin.NewsLetterV3.ViewNewsletter" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="/Admin/Module/Common/Pager.ascx" TagName="Pager" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Header.ascx" TagName="Header" TagPrefix="list" %>
<%@ Register Src="EditNewsletterStep3.ascx" TagName="EditNewsletterStep3" TagPrefix="uc3" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html>
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript" >
    
    function tab(aciveID) {
        for (var i = 1; i < 5; i++) {
            if ($("Tab" + i)) {
                $("Tab" + i).style.display = "none";
            }
        }
        if ($("Tab" + aciveID)) {
            $("Tab" + aciveID).style.display = "";
        }
    }

    function help() {
		<%=Gui.Help("newsletterv3", "modules.newsletterv3")%>
	}

    </script>
</head>
<body>
    <div id="containerNewsletter">
    <form id="TheForm" runat="server"  class="formNewsletter">
            <dw:RibbonBar ID="SearchBar" runat="server">
                <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                    <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                        <dw:RibbonBarButton ID="btnBack" Text="Back" Image="NavigateLeft" Size="Large" runat="server"
                            PerformValidation="false" OnClientClick="history.back();" />
                        <dw:RibbonBarButton ID="btnCopy" Text="Copy" Title="Copy" Image="Copy" Size="Large"
                            runat="server" EnableServerClick="true" OnClick="Copy_Click" ShowWait="true" WaitTimeout="500" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonBarGroup5" Name="Information" runat="server">
                        <dw:RibbonBarRadioButton ID="DetailsRibbon" Text="Details" OnClientClick="tab(1);"
                            Checked="true" Group="recGroup" Image="DocumentProperties" Size="Small" runat="server" />
                        <dw:RibbonBarRadioButton ID="CategoriesRibbon" Text="Tilmeldte" OnClientClick="tab(2);"
                            Group="recGroup" ImagePath="/Admin/Module/NewsLetterV3/Img/Recipients.gif" Size="Small" runat="server" />
                        <dw:RibbonBarRadioButton ID="RibbonBarRadioButton1" Text="Links" OnClientClick="tab(3);"
                            Group="recGroup" ImagePath="/Admin/Module/NewsLetterV3/Img/Link.gif" Size="Small" runat="server" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Help" runat="server">
                        <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large"
                            runat="server" OnClientClick="help();"/>
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
        <dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="Auto" Anchor="document"  runat="server">
            <div id="Tab1" runat="server" style="width: 100%; height: 100%;">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <uc3:EditNewsletterStep3 ID="Step3" runat="server" />
                                    </table>
                                    <dw:GroupBoxStart runat="server" ID="DetailsStart" doTranslation="true" Title="Details"
                                        ToolTip="Details" />
                                    <table>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Distribution date: " />
                                            </td>
                                            <td>                                                
                                                <asp:Label ID=NewsletterDate runat=server></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Distribution method: " />
                                            </td>
                                            <td>
                                                <dw:TranslateLabel runat="server" ID="NewsletterType" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Distribution server: " />
                                            </td>
                                            <td>
                                                <asp:Label ID=NewsletterServer runat=server></asp:Label>                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Subscribed recipients: " />
                                            </td>
                                            <td>
                                                <asp:Label ID=NewsletterSubscribersCount runat=server></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Recived HTML: " />
                                            </td>
                                            <td>
                                                <asp:Label ID=ReciviedHTML runat=server></asp:Label>                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Recived Text: " />
                                            </td>
                                            <td>
                                                <asp:Label ID=ReciviedText runat=server></asp:Label>                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="leftCol">
                                                <dw:TranslateLabel runat="server" Text="Opened: " />
                                            </td>
                                            <td>
                                                <asp:Label ID=NewsletterReadedCount runat=server></asp:Label>                                                
                                            </td>
                                        </tr>
                                    </table>
                                    <dw:GroupBoxEnd runat="server" ID="DetailsEnd" />
                                    <div runat="server" id="HtmlBody" visible="false">
                                        <dw:GroupBoxStart runat="server" ID="HtmlStart" Title="HTML" />
                                        <iframe id="frmHtmlSource" frameborder="0" style="width: 100%; height: 200px; border: 1px solid #c3c3c3" runat="server" />
                                        <dw:GroupBoxEnd runat="server" ID="HtmlEnd" />
                                    </div>
                                    <div runat="server" id="TextBody" visible="false">
                                        <dw:GroupBoxStart runat="server" ID="TextStart" doTranslation="true" Title="Text" />
                                        <iframe id="frmTextSource" frameborder="0" style="width: 100%; height: 200px; border: 1px solid #c3c3c3" runat="server" />
                                        <dw:GroupBoxEnd runat="server" ID="TextEnd" />
                                    </div>
                                </div>
            <div id="Tab2" style="display: none; width: 100%; height: 100%; padding-left: 5px;" runat="server">
                                    <table class="cleantable" border="0" cellpadding="0" cellspacing="0" width="100%"
                                        style="margin: 0px; height: 100%; border: 1px solid #FCFCFC;">
                                        <tr>
                                            <td style="height: 20px;">
                                                <table cellpadding="0" cellspacing="0" border="0" style="width: 592; height: 20px;
                                                    border-bottom: 1px solid #ccc;">
                                                    <tr>
                                                        <list:Header ID="SubscribersHeader" runat="server" OnSortChange="SubscribersSortingChangeHandler">
                                                            <list:HeaderCell runat="server" Width="331px" IsSorting="true" Caption="Name" SortingFilter="1" />
                                                            <list:HeaderCell runat="server" Width="78px" IsSorting="true" Caption="Format" SortingFilter="2" />
                                                            <list:HeaderCell runat="server" Width="183px" IsSorting="true" Caption="Opened" SortingFilter="3" />
                                                        </list:Header>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%; height: 100%;">
                                                <iframe id="SubscribersList" name="SubscribersList" runat="server" marginwidth="0" marginheight="0"
                                                    scrolling="auto" frameborder="0" height="100%" width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px;">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right">
                                                            <list:Pager ID="SubscribersPager" runat="server" ShowComment="false" OnCurrentPageChange="SubscribersCurrentPageChangeHandler" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
            <div id="Tab3" style="display: none; width: 100%; height: 100%; padding-left: 5px;" runat="server">
                                    <table class="cleantable" border="0" cellpadding="0" cellspacing="0" width="100%"
                                        style="margin: 0px; height: 100%;">
                                        <tr>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" border="0" style="width: 592px; height: 20px;
                                                    border-bottom: 1px solid #ccc;">
                                                    <tr>
                                                        <list:Header ID="LinksHeader" runat="server" OnSortChange="ListSortingChangeHandler">
                                                            <list:HeaderCell runat="server" Width="525px" Caption="Url" SortingFilter="0" />
                                                            <list:HeaderCell runat="server" Width="67px" Caption="Clicks" SortingFilter="1" />
                                                        </list:Header>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 100%;">
                                                <iframe id="LinksList" name="LinksList" runat="server" marginwidth="0" marginheight="0"
                                                    scrolling="auto" frameborder="0" height="100%" width="100%" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px;">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right">
                                                            <list:Pager ID="LinksPager" runat="server" ShowComment="false" OnCurrentPageChange="LinksCurrentPageChangeHandler" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
        </dw:StretchedContainer>
        <% Translate.GetEditOnlineScript() %>
    </form>
    </div>
</body>
</html>

