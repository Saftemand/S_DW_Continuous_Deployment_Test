<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditNewsletterStepTest.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStepTest" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon" TagPrefix="nl" %>
<tr> 
    <td valign="top">
        <dw:GroupBoxStart runat="server" ID="SendStart" doTranslation="true" Title="Send test e-mail" ToolTip="Send test e-mail"/>
            <table id="DateSelectorTable">
                <tr>
                    <td class="leftCol" id="EmailAddressLabel">
                        <dw:TranslateLabel runat="server" Text="E-mail address" />&nbsp;
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="Email" CssClass="std" MaxLength="255" />&nbsp;
                        <asp:RequiredFieldValidator runat="server" ID="RequiredEmailValidator" ErrorMessage="required" ControlToValidate="Email" Display="Dynamic" />
                        <nl:EmailValidator ID="EmailValidator" runat="server" ErrorMessage="incorrect email" ControlToValidate="Email" Display="Dynamic"/>
                    </td>
                </tr>
                <tr>
                    <td class="leftCol" id="EmailFormatLabel">
                        <dw:TranslateLabel runat="server" Text="E-mail format" />&nbsp;
                    </td>
                    <td>
                        <asp:Label ID="lblEmailFormat" runat="server" />
                        <asp:RadioButtonList runat="server" ID="SendType">
                            <asp:ListItem Value="1" Text="HTML" Selected="True" />
                            <asp:ListItem Value="2" Text="Text" />
                            <asp:ListItem Value="3" Text="Both" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        <dw:GroupBoxEnd runat="server" ID="SendEnd" />
        &nbsp;<dw:TranslateLabel ID="dwLabelSent" runat="server" Text="Message has been successfully sent." EnableViewState="false" Visible="false"/><dw:TranslateLabel ID="dwLabelNotSent" runat="server" Text="Unable to send message. Please check spelling of email addresses and try again." EnableViewState="false" Visible="False"/>
    </td>
</tr>
