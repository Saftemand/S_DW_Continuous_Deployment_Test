<%@ Control Language="vb" AutoEventWireup="false" Codebehind="IntegrationControl.ascx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.IntegrationControl" %>
<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon" TagPrefix="cc1" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register Src="/Admin/Module/Common/ComboRepeater.ascx" TagName="ComboRepeater" TagPrefix="cc" %>

<%@ Import Namespace="Dynamicweb" %>

<dw:GroupBoxStart ID="GroupBoxStart3" runat="server" Title="Newsletter properties" />
<table cellpadding="2" cellspacing="0" border="0">
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Subject" />
        </td>
        <td>
            <asp:TextBox ID="TxtSubject" runat="server" CssClass="std" MaxLength="255"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="required"
                ControlToValidate="txtSubject"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Sender name" />
        </td>
        <td>
            <asp:TextBox ID="TxtSenderName" runat="server" CssClass="std" MaxLength="255"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator runat="server" ErrorMessage="required"
                ControlToValidate="TxtSenderName"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Sender e-mail" />
        </td>
        <td>
            <asp:TextBox ID="TxtSenderEmail" runat="server" CssClass="std" MaxLength="255"></asp:TextBox>
        </td>
        <td>
         <asp:RequiredFieldValidator runat="server" ErrorMessage="required" Display="Dynamic"
                ControlToValidate="TxtSenderEmail"></asp:RequiredFieldValidator>
            <cc1:EmailValidator ID="EmailValidator1" runat="server" ErrorMessage="invalid e-mail"
                ControlToValidate="TxtSenderEmail"></cc1:EmailValidator>
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Encoding" />
        </td>
        <td colspan="2">
            <asp:DropDownList ID="Encoding" runat="server" DataTextField="Text" DataValueField="Value">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Stylesheet" />
        </td>
        <td colspan="2">
            <%=Gui.StylesheetList(_styleSheetID, "Stylesheet")%>
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Template" />
        </td>
        <td colspan="2">
            <dw:FileManager runat="server" ID="FmBodyTemplate" Name="FmBodyTemplate" Folder="Templates/NewsLetterV3/Integration" />
        </td>
    </tr>
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel runat="server" Text="Link to module page" />
        </td>
        <td colspan="2">
            <asp:Literal ID="litModulePage" runat="server" />
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="select page" ClientValidationFunction="ValidateLinks"></asp:CustomValidator>
        </td>
    </tr>
</table>
<dw:GroupBoxEnd ID="GroupBoxEnd3" runat="server" />

<dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="Distribution type" />
<table border="0" cellpadding="0" cellspacing="2" width="100%" style="table-layout:fixed;">
    <tr>
        <td class="mainTableLeftCol">
            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Automatic distribution" />
        </td>
        <td style="white-space:nowrap;" colspan="3" align="left"> 
            <asp:RadioButton ID="RadioByEvent" GroupName="DistrType" runat="server" Text="By event" />&nbsp;
            <asp:RadioButton ID="RadioByTime" GroupName="DistrType" runat="server" Text="By time" Checked="true" />&nbsp;
            <asp:RadioButton ID="RadioAtOnce" GroupName="DistrType" runat="server" Text="At once" />            
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <table cellpadding="2" cellspacing="0" id="Table_Time" style="display: none; width: 100%;" border="0">
                <tr>
                    <td class="mainTableLeftCol">
                        <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Distribution period" />
                    </td>
                    <td>
                        <asp:TextBox ID="TxtDistrDays" Text="3" runat="server" MaxLength="3" Width="58" CssClass="std"></asp:TextBox>
                        <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="days" />
                    </td>
                </tr>
                <tr>
                    <td class="mainTableLeftCol">
                        <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Rule start date" />
                    </td>
                    <td style="white-space:nowrap;">
                        <dw:DateSelector ID="DsNewsActiveFrom" runat="server" SetNeverExpire="false" />
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="0" id="Table_AtOnce" style="display: none; width: 100%;" border="0">
                <tr>
                    <td class="mainTableLeftCol">
                        <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="News items from" />
                    </td>
                    <td>
                        <%=Dates.DateSelect(_dateAtOnceFrom, False, False, True, "DsNewsAtOnceFrom", True)%>
                    </td>
                </tr>
                <tr>
                    <td class="mainTableLeftCol">
                        <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="To" />
                    </td>
                    <td>
                        <%=Dates.DateSelect(_dateAtOnceTo, False, False, True, "DsNewsAtOnceTo", True)%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />

<dw:GroupBoxStart ID="GroupBoxStart1" runat="server" Title="To:" />
<cc:ComboRepeater ID="CcCategory" runat="server" DataTextField="Name" DataValueField="ID"
    DropDownLabel="category" RequiredMessage="add at least one category, please" />
<dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
