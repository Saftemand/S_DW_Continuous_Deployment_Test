<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EditNewsletterStep0.ascx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStep0" %>
<%@ Register Src="/Admin/Module/Common/ComboRepeater.ascx" TagName="ComboRepeater"
    TagPrefix="cc" %>
<%@ Register Src="Control/SelectNewsItems.ascx" TagName="SelectNewsItems" TagPrefix="ns" %>
<%@ Register Src="Control/NewsletterProperties.ascx" TagName="NewsletterProperties"
    TagPrefix="np" %>
<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon"
    TagPrefix="nl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<script type="text/javascript">
    
    function ShowTemplateRow(show)
    {
        document.getElementById('TemplateRow').style.display = show ? '' : 'none';
    }

    function ShowStylesheetRow(show)
    {
        document.getElementById('StylesheetRow').style.display = show ? '' : 'none';
    }
    
    var childWnd = null;
    function openCategoriesWindow() {
        childWnd = window.open('CategorySelector.aspx',
            'catSelector',
            'toolbar=0,menubar=0,resizable=0,scrollbars=0,height=400,width=300,directories=0,location=0');            
    }
    
    function showCategorySelector() {
        var openNew = (childWnd == null);
        if(!openNew) {
            try {
                var frm = childWnd.document.getElementById('form1')
            }
            catch(ex) { openNew = true; }
            if(!openNew) {
                childWnd.focus();
            }
            else {
                openCategoriesWindow();    
            }
        }
        else {
            openCategoriesWindow();
        }
    }
</script>

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
        <asp:Button ID="cmdSubmitCategories" Style="display: none;" CausesValidation="False"
            runat="server" />
        <asp:Repeater ID="repCategories" runat="server">
            <HeaderTemplate>
                <table cellspacing="0" cellpadding="2" border="0" width="560">
                    <tr>
                        <td width="100%">
                            <strong>
                                <%=Translate.Translate("Category")%>
                            </strong>
                        </td>
                        <td width="32" align="center">
                            <strong>
                                <%=Translate.Translate("Delete") %>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" height="1" bgcolor="#c4c4c4">
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("Name") %>
                    </td>
                    <td align="center">
                        <a runat="server" causesvalidation="False" onclick="return true;" onserverclick="OnDeleteCommand"
                            commandargument='<%# Eval("ID")%>' id="A1">
                            <img src="/Admin/Images/Delete.gif" alt='<%=Translate.translate("Slet")%>' border="0"></a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <table cellspacing="0" cellpadding="2" border="0" width="560">
            <tr id="rowNoCategories" runat="server">
                <td width="100%">
                    <dw:TranslateLabel ID="lbNoCategories" Text="Intet_valgt" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="button" onclick="showCategorySelector();" class="buttonSubmit" value="<%=Translate.Translate("Add") %>" />
                </td>
            </tr>
        </table>
        <asp:CustomValidator ID="cvCategories" runat="server" />
        <dw:GroupBoxEnd runat="server" ID="ToEnd" />
    </td>
</tr>
<tr>
    <td valign="top">
        <dw:GroupBoxStart runat="server" ID="FromStart" doTranslation="true" Title="From"
            ToolTip="From" />
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td class="leftCol" id="SenderNameLabel">
                    <dw:TranslateLabel runat="server" Text="Sender name" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="SenderName" CssClass="std" MaxLength="255" />&nbsp;
                    <asp:RequiredFieldValidator runat="server" ID="SenderValidator" ErrorMessage="required"
                        ControlToValidate="SenderName" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="SenderEmailLabel">
                    <dw:TranslateLabel runat="server" Text="Sender e-mail" />
                </td>
                <td>
                    <asp:TextBox runat="server" ID="SenderEmail" CssClass="std" MaxLength="255" />&nbsp;
                    <asp:RequiredFieldValidator runat="server" ID="RequiredEmailValidator" ErrorMessage="required"
                        ControlToValidate="SenderEmail" Display="Dynamic" />
                    <nl:EmailValidator ID="EmailValidator" runat="server" ErrorMessage="incorrect email"
                        ControlToValidate="SenderEmail" Display="Dynamic" />
                </td>
            </tr>
        </table>
        <dw:GroupBoxEnd runat="server" ID="FromEnd" />
    </td>
</tr>
<tr>
    <td valign="top">
        <dw:GroupBoxStart runat="server" ID="TypeStart" doTranslation="true" Title="Newsletter type"
            ToolTip="Newsletter type" />
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td class="leftCol" id="TypeLabel">
                    <dw:TranslateLabel runat="server" Text="Choose type" />
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="NewsletterType" DataTextField="Name" DataValueField="ID"
                        AutoPostBack="true" />
                </td>
            </tr>
            <tr>
                <td class="leftCol" id="EncodingLabel">
                    <dw:TranslateLabel runat="server" Text="Encoding" />
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="Encoding" DataTextField="Text" DataValueField="Value" />
                </td>
            </tr>
            <tr id="NewsletterPageRow" runat="server">
                <td class="leftCol" id="PageLabel">
                    <dw:TranslateLabel runat="server" Text="Link to source page" />
                </td>
                <td>
                    <%=Gui.LinkManager(InternalPageURL, "NewsletterPage", "", "0", "", False, True, True, "", False, True)%>
                </td>
            </tr>
            <tr id="StylesheetRow">
                <td id="StylesheetLabel">
                    <dw:TranslateLabel runat="server" Text="Stylesheet" />
                </td>
                <td>
                    <%=Gui.StylesheetList(StyleSheetID, "Stylesheet") %>
                </td>
            </tr>
         </table>
         <table cellpadding="2" cellspacing="0">
            <tr id="TemplateRow">
                <td class="leftColHigh" id="TemplateLabel">
                    <dw:TranslateLabel runat="server" Text="Template" />
                </td>
                <%=Gui.TemplatePreview(TemplateID, "newsletters")%>
                <td>
                </td>
            </tr>
            <tr id="NewsSelectionRow">
                <td colspan="3">
                    <ns:SelectNewsItems ID="NewsSelection" runat="server" Visible="false" />
                </td>
            </tr>
        </table>
        <dw:GroupBoxEnd runat="server" ID="TypeEnd" />
    </td>
</tr>
<asp:Literal ID="TemplatePreviewScript" runat="server" />
