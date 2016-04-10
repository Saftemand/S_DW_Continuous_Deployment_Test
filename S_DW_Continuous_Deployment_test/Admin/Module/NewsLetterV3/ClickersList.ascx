<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ClickersList.ascx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.ClickersList" %>
<%@ Register src="/Admin/Module/Common/Pager.ascx" TagName="Pager" TagPrefix="list" %>
<%@ Register src="/Admin/Module/Common/Search.ascx" TagName="Search" TagPrefix="list" %>
<%@ Register src="/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>
<%@ Register src="/Admin/Module/Common/Header.ascx" TagName="Header" TagPrefix="list" %>
<%@ Register src="/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<table class="cleantable" border="0" cellpadding="0" cellspacing="0" width="100%"
    style="margin: 0px; padding:0; height: 100%;">
    <tr>
        <td>
            <table cellpadding="0" cellspacing="0" style="width: 520px; height: 20px; margin-left: 15px;">
                <tr>
                    <list:Header ID="ClickersHeader" runat="server">
                        <list:HeaderCell runat="server" Width="380px" IsSorting="true" Caption="Recipient"
                            SortingFilter="0" />
                        <list:HeaderCell runat="server" Width="140px" IsSorting="true" Caption="Followed"
                            SortingFilter="1" />
                    </list:Header>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height: 100%;">
            <dw:TranslateLabel ID="NoRecordsFoundLabel" runat="server" Text="No recipients found"
                Visible="false" />
            <asp:Repeater ID="List" runat="server">
                <HeaderTemplate>
                    <table cellspacing="0" cellpadding="0" style="overflow: scroll; width: 520px; 
                        margin-left: 15px;">
                </HeaderTemplate>
                <ItemTemplate>
                    <tr onmouseout="ccb(this);" onmouseover="cc(this);">
                        <list:Record runat="server" ID="RecordName" Width="380px" Checked="true" IsBoolean="true"
                            ImgSrc="/Admin/Module/NewsLetterV3/Img/InactiveRecipients.gif" ImgCheckedSrc="/Admin/Module/NewsLetterV3/Img/Recipients.gif"
                            Text='<%# DataBinder.Eval(Container.DataItem, "UserName") %>' />
                        <list:Record runat="server" Width="140px" ID="RecordClickDate" Text='<%# DataBinder.Eval(Container.DataItem, "UserLinkDate") %>' />
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="2" class="DividerRows">
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr>
        <td style="height: 20px;">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right">
                        <list:Pager ID="DownPager" runat="server" ShowComment="false" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="DividerRows">
        </td>
    </tr>
</table>
