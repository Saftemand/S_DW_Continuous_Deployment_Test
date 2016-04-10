<%@ Control Language="vb" AutoEventWireup="false" Codebehind="NewsletterProperties.ascx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.NewsletterProperties" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<table cellpadding="2" cellspacing="0">
    <tr runat=server visible=false id=TypeSelector>
        <td class="leftCol">
            <dw:TranslateLabel runat="server" Text="Type" />
        </td>
        <td>
            <asp:RadioButtonList ID="NewsLetterType" runat="server" AutoPostBack="true" RepeatDirection="Horizontal" >
                <asp:ListItem Text="e-mail" Value="0" Selected=True></asp:ListItem>
                <asp:ListItem Text="sms" Value="4"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="leftCol" id="SubjectLabel">
            <dw:TranslateLabel runat="server" Text="Subject" />
        </td>
        <td>
            <asp:TextBox runat="server" ID="Subject" CssClass="std" MaxLength="255" />&nbsp;
            <asp:RequiredFieldValidator runat="server" ID="SubjectValidator" ControlToValidate="Subject"
                ErrorMessage="required" />
        </td>
    </tr>
</table>