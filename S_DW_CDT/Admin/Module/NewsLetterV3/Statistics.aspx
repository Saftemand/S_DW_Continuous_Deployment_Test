<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Statistics.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.Statistics" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>

<%@ Register Src="/Admin/Module/Common/Pager.ascx" TagName="Pager" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Header.ascx" TagName="Header" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Statistics</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
</head>
<body>
    <form id="form2" runat="server" class="formNewsletter">
        <%= Gui.MakeHeaders(Translate.Translate("Recipient statistics"), Translate.Translate("Statistics"), "all")%>
        <table id="containerTable" style="width: 100%; height: 100%; margin: 0; padding: 0;"
            cellpadding="0" cellspacing="0">
            <tr>
                <td style="height: 100%;">
                    <table class="tabTable" id="Tab1" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;"
                        border="0">
                        <tbody id="mainTable">
                            <tr>
                                <td>
                                    <dw:GroupBoxStart runat="server" ID="RecipientDetailsStart" doTranslation="true"
                                        Title="Recipient details" ToolTip="Recipient details" />
                                    <table id="Table1" cellspacing="0" cellpadding="2" width="100%" border="0" style="table-layout: fixed;">
                                        <tbody id="Recipient details">
                                            <tr>
                                                <td style="width: 100px;" id="ToLabel">
                                                    <b>
                                                        <dw:TranslateLabel ID="Name" runat="server" Text="Name" />
                                                    </b>
                                                </td>
                                                <td>
                                                    <asp:Label ID="UserNameLabel" runat="server" EnableViewState="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px;">
                                                    <b>
                                                        <dw:TranslateLabel ID="EMail" runat="server" Text="E-Mail" />
                                                    </b>
                                                </td>
                                                <td>
                                                    <asp:Label ID="UserEmailLabel" runat="server" EnableViewState="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Repeater ID="rptCat" runat="server">
                                                        <HeaderTemplate>
                                                            <table width="100%" cellpadding="2" cellspacing="0" class="border_top_bot">
                                                                <tr>
                                                                    <td style="white-space: nowrap;" class="border_top_bot">
                                                                        <b>
                                                                            <dw:TranslateLabel ID="dwTransCategory" runat="server" Text="Category" />
                                                                        </b>
                                                                    </td>
                                                                    <td class="border_top_bot">
                                                                        <b>
                                                                            <dw:TranslateLabel ID="dwTransIP" runat="server" Text="IP" />
                                                                        </b>
                                                                    </td>
                                                                    <td class="border_top_bot">
                                                                        <b>
                                                                            <dw:TranslateLabel ID="dwTransDate" runat="server" Text="Subscribed" />
                                                                        </b>
                                                                    </td>
                                                                </tr>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <%#Base.ChkString(Eval("CategoryName"))%>
                                                                </td>
                                                                <td>
                                                                    <%#Base.ChkString(Eval("IP"))%>
                                                                </td>
                                                                <td>
                                                                    <%#Common.ShowDate(Eval("Time"), True)%>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <dw:GroupBoxEnd runat="server" ID="RecipientDetailsEnd" />
                                </td>
                            </tr>
                            <tr valign="top">
                                <td style="height: 100%;">
                                    <dw:TranslateLabel ID="NoNewslettersReceived" runat="server" Visible="false" Text="There are no sent letters." />
                                    <asp:Panel ID="TableNewsletterSentToRecipient" runat="server" Width="100%" Height="100%">
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0" style="height: 100%;">
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" cellpadding="0" width="100%" style="background-color: #F2F2F2;">
                                                        <tbody id="linkHideExpand">
                                                            <tr>
                                                                <td style="height: 20px; width: 30px;">
                                                                    &nbsp;<asp:ImageButton Width="21" Height="20" runat="server" ID="HideLink" ImageUrl="/Admin/Module/NewsLetterV3/Img/Unlink.gif" />
                                                                    <asp:ImageButton Width="21" Height="20" runat="server" Visible="false" ID="ExpandLink"
                                                                        ImageUrl="/Admin/Module/NewsLetterV3/Img/Link.gif" />
                                                                </td>
                                                                <td>
                                                                    <dw:TranslateLabel ID="HideLinkText" runat="server" Text="Hide links" Visible="true" />
                                                                    <dw:TranslateLabel ID="ExpandLinkText" runat="server" Text="Expand links" Visible="false" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" style="width: 100%; padding: 0 5px; height: 100%;">
                                                    <table cellpadding="0" cellspacing="0" border="0" style="width: 585px; table-layout: fixed;
                                                        height: 100%;">
                                                        <tbody id="Newsletters">
                                                            <tr style="height: 20px;">
                                                                <list:Header ID="ListHeader" runat="server">
                                                                    <list:HeaderCell runat="server" Width="385px" IsSorting="true" SortingFilter="0"
                                                                        Caption="Newsletter name" />
                                                                    <list:HeaderCell runat="server" Width="93px" IsSorting="true" SortingFilter="1" Caption="Sent" />
                                                                    <list:HeaderCell runat="server" Width="77px" IsSorting="true" SortingFilter="2" Caption="Opened" />
                                                                    <list:HeaderCell runat="server" Width="20px" Caption="" />
                                                                </list:Header>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" class="DividerRows">
                                                                </td><td></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="height: 100%;" >
                                                                    <iframe id="StatisticPageListFrame" name="StatisticPageListFrame" runat="server"
                                                                        marginwidth="0" marginheight="0" scrolling="auto" frameborder="0" height="100%"
                                                                        width="100%" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="bottom" colspan="4">
                                                    <table width="100%" cellpadding="0" cellspacing="0" style="height: 18px; background-color: #F2F2F2;">
                                                        <tr>
                                                            <td align="right" style="padding-right: 5px;">
                                                                <list:Pager ID="DownPager" runat="server" OnCurrentPageChange="CurrentPageChangeHandler"
                                                                    ShowComment="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>
