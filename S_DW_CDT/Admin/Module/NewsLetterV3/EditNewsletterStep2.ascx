<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditNewsletterStep2.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStep2" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<tr> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="PropertiesStart" doTranslation="true" Title="Properties" ToolTip="Properties"/>
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td class="leftCol" id="ToLabel" >
                    <dw:TranslateLabel runat="server" Text="To" />:
                </td>
                <td>
                    <asp:Label ID="SendTo" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="FromLabel">
                    <dw:TranslateLabel runat="server" Text="From" />:
                </td>
                <td>
                    <asp:Label ID="From" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="SubjectLabel">
                    <dw:TranslateLabel runat="server" Text="Subject" />:
                </td>
                <td>
                    <asp:Label ID="Subject" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="EncodingLabel">
                    <dw:TranslateLabel runat="server" Text="Encoding" />:
                </td>
                <td>
                    <asp:Label ID="Encoding" runat="server" />
                </td>
            </tr>
        </table>
      <dw:GroupBoxEnd runat="server" ID="PropertiesEnd" />
  </td>
</tr>
<tr> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="AttachStart" doTranslation="true" Title="Attach file" ToolTip="Attach file"/>
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td class="leftCol" id="ChooseFileLabel">
                    <dw:TranslateLabel runat="server" Text="Choose file" />
                </td>
                <td>
                    <dw:FileManager runat="server" ID="File" />&nbsp;
                    <asp:Button runat="server" ID="Attach" CssClass="buttonSubmit" Text="Attach" ValidationGroup="Attach" />
                </td>
            </tr>
            <tr>
                <td />
                <td>
                    <asp:CustomValidator ID="FileTypeValidator" runat="server" ValidationGroup="Attach" ErrorMessage="this file type is not allowed for attachments" OnServerValidate="ValidateAttachment" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Repeater runat="server" ID="Attachments">
                        <HeaderTemplate>
                            <table width="100%" cellpadding="0" cellspacing="0" class="border_bot">
                                <tr>
                                    <td id="AttachedFileLabel" class="border_bot">
                                        <strong><dw:TranslateLabel runat="server" Text="Attached File" /></strong></td>
                                    <td align="right" id="AttachedFileSizeLabel" class="border_bot">
                                        <strong><dw:TranslateLabel runat="server" Text="Size" /></strong></td>
                                    <td align="right" id="AttachedFileDeleteLabel" class="border_bot">
                                        <strong><dw:TranslateLabel runat="server" Text="Delete" /></strong>
                                    </td>
                                </tr>
                            </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td id='Attach_<%#Eval("PathEncoded")%>'><%#Eval("Path")%></td>
                                <td align="right"><%#Eval("Size")%></td>
                                <td align="right"><asp:ImageButton runat="server" CausesValidation="false" CommandName="DelFile" OnCommand="DelFile" CommandArgument='<%# Eval("Path")%>' ImageUrl="/Admin/Images/Delete.gif" ToolTip='<%#Translate.Translate("Slet")%>'></asp:ImageButton></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </td>
            </tr>
        </table>
      <dw:GroupBoxEnd runat="server" ID="AttachEnd" />
  </td>
</tr>
<tr>
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="SubscriptionStart" doTranslation="true" Title="Subscription" ToolTip="Subscription"/>
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td class="leftCol" id="LinkLabel">
                    <dw:TranslateLabel runat="server" Text="Link to subscription page" />
                </td>
                <td>
                    <%=Gui.LinkManager(SubsPageText, "SubscriptionPage", "", "0", "0", False, "on", True)%>&nbsp;
                    <asp:CustomValidator runat="server" ID="SubscriptionPageValidator" OnServerValidate="ValidateSubscriptionPage" ErrorMessage="required" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="SubscribeLinkLabel">
                    <dw:TranslateLabel runat="server" Text="Subscribe link text" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="SubscribeLink" CssClass="std" MaxLength="255" />&nbsp;
                    <asp:CustomValidator runat="server" ID="SubscribeTextValidator" OnServerValidate="ValidateSubscribeText" ErrorMessage="required" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="UnsubscribeRedirectPageLabel">
                    <dw:TranslateLabel runat="server" Text="Link to unsubscription page" />
                </td>
                <td>
                    <%=Gui.LinkManager(UnsubscribeRedirectPage, "UnsubscribeRedirectPage", "", "0", "0", False, "on", True)%>&nbsp;
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="UnsubscribeLinkLabel">
                    <dw:TranslateLabel runat="server" Text="Unsubscribe link text" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="UnsubscribeLink" CssClass="std" MaxLength="255"/>&nbsp;
                    <asp:CustomValidator runat="server" ID="UnsubscribeTextValidator" OnServerValidate="ValidateUnsubscribeText" ErrorMessage="required" />
                </td>
            </tr>
        </table>
      <dw:GroupBoxEnd runat="server" ID="SubscriptionEnd" />
  </td>
</tr>