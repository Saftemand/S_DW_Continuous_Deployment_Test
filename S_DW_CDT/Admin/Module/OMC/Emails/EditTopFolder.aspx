<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EditTopFolder.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.EditTopFolder" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:Overlay ID="saveForward" runat="server">
    </dw:Overlay>
    <table border="0">
        <tr>
            <td>
                <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                    <table>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel7" Text="Folder Name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtFolderName" CssClass="std field-name" runat="server" ClientIDMode="Static" MaxLength="255" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="lbSenderName" Text="From: Name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSenderName" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="lbSenderEmail" Text="From: e-mail" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSenderEmail" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel5" Text="Subject" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txSubject" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <dw:TranslateLabel ID="TranslateLabel8" Text="Domain" runat="server" />
                            </td>
                            <td>
                                <select id="DomainSelector" class="std" name="DomainSelector" style="width: 254px">
                                    <asp:Literal ID="DomainList" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </td>
        </tr>
        <tr>
            <td>
                <dw:GroupBox ID="gbContent" runat="server" Title="Content">
                    <table>
                        <tr>
                            <td style="width: 170px;">
                                 &nbsp;
                            </td>
                            <td>
                                <label>
                                    <asp:CheckBox runat="server" ID="cbRenderContent" />
                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Render content for each recipient" />
                                </label>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </td>
        </tr>
        <tr>
            <td>
                <dw:GroupBoxStart runat="server" ID="SubscriptionStart" doTranslation="true" Title="Unsubscribe" ToolTip="Unsubscribe" />
                <table cellpadding="2" cellspacing="0">
                    <tr>
                        <td style="width: 170px" id="UnsubscribeLinkLabel">
                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Unsubscribe text" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txbUnsubscribeText" CssClass="std field-name" MaxLength="255" />&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 170px;" id="UnsubscribeRedirectPageLabel">
                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Redirect after unsubscribe" />
                        </td>
                        <td>
                            <dw:LinkManager ID="lmUnsubscriptionPage" runat="server" DisableFileArchive="true" DisableParagraphSelector="true" DisableTyping="true" />
                        </td>
                    </tr>
                </table>
                <dw:GroupBoxEnd runat="server" ID="SubscriptionEnd" />
            </td>
        </tr>


        <tr>
            <td>
                <dw:GroupBox ID="gbEngagementIndex" Title="Engagement Indexes" runat="server">
                <div class="omc-control-panel-grid-container" style="width: 425px">
                    <table class="dwGrid" cellspacing="0" cellpadding="0" border="0" style="border-style:None;width:100%;border-collapse:collapse;position: static">
                        <tr class="header">
                            <th scope="col" style="width: 275px"><dw:TranslateLabel ID="lbInteractionType" Text="Conversion" runat="server" /></th>
                            <th scope="col" style="width: 150px"><dw:TranslateLabel ID="lbInteractionPointsEarned" Text="Engagement Index" runat="server" /></th>
                        </tr>
                        <tr class="row actionRow highlightRow">
                            <td>&nbsp;<dw:TranslateLabel ID="lbInteractionForm" Text="Open the e-mail" runat="server" /></td>
                            <td>
                                <omc:NumberSelector ID="numOpenMail" AllowNegativeValues="false" MinValue="0" MaxValue="100" runat="server" />
                            </td>
                        </tr>
                        <tr class="row actionRow highlightRow">
                            <td>&nbsp;<dw:TranslateLabel ID="TranslateLabel6" Text="Click a link" runat="server" /></td>
                            <td>
                                <omc:NumberSelector ID="numClickLink" AllowNegativeValues="false" MinValue="0" MaxValue="100" runat="server" />
                            </td>
                        </tr>
                        <tr class="row actionRow highlightRow">
                            <td>&nbsp;<dw:TranslateLabel ID="lbInteractionProduct" Text="Adding products to cart" runat="server" /></td>
                            <td>
                                <omc:NumberSelector ID="numAddingProductsToCart"  AllowNegativeValues="false" MinValue="0" MaxValue="100" runat="server" />
                            </td>
                        </tr>
                        <tr class="row actionRow highlightRow">
                            <td>&nbsp;<dw:TranslateLabel ID="lbInteractionFile" Text="Signing on to e-mail" runat="server" /></td>
                            <td>
                                <omc:NumberSelector ID="numSigningNewsletter" AllowNegativeValues="false" MinValue="0" MaxValue="100" runat="server" />
                            </td>
                        </tr>
                        <tr class="row actionRow highlightRow">
                            <td>&nbsp;<dw:TranslateLabel ID="lbInteractionSearch" Text="Unsubscribes the e-mail" runat="server" /></td>
                            <td>
                                <omc:NumberSelector ID="numUnsubscribesNewsletter" AllowNegativeValues="true" MinValue="-100" MaxValue="100" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
                </dw:GroupBox>
                <dw:GroupBox ID="GroupBox2" runat="server" Title="Tracking provider" >
                    <div id="ProviderAddInDiv">
                        <asp:Literal runat="server" ID="LoadTrackingProviderScript"></asp:Literal>
                        <de:AddInSelector
                            ID="TrackingProviderAddIn"
                            runat="server"
                            useNewUI="true" 
                            AddInShowNothingSelected="true"
                            AddInGroupName="Select Tracking"
                            AddInParameterName ="Settings"
                            AddInTypeName="Dynamicweb.Modules.EmailMarketing.EmailTrackingProvider"
                            AddInShowFieldset="false"
                        />
                        <asp:Literal runat="server" ID="LoadTrackingProvider"></asp:Literal>
                     </div>
                </dw:GroupBox>
                <dw:GroupBox ID="GroupBox1" runat="server" Title="Delivery provider">
                    <table>
                        <tr>
                            <td width="170" style="padding-left: 5px;">
                                <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Configuration" />
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlDeliveryProviders" CssClass="std"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <dw:GroupBox ID="GroupBox3" runat="server" Title="Recipient provider">
                    <div id="RecipientProviderAddInDiv">
                        <asp:Literal runat="server" ID="LoadRecipientProviderScript"></asp:Literal>
                        <de:AddInSelector ID="RecipientProviderAddIn" runat="server" useNewUI="true" AddInShowNothingSelected="False" AddInGroupName="Select Recipient Provider" AddInParameterName="Settings" AddInTypeName="Dynamicweb.Modules.EmailMarketing.EmailRecipientProvider" AddInShowFieldset="False" />
                        <asp:Literal runat="server" ID="LoadRecipientProvider"></asp:Literal>
                    </div>
                </dw:GroupBox>
             </td>
        </tr>
    </table>

    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="hidden" id="CloseOnSave" name="CloseOnSave" value="True" />
    <iframe name="frmPostback" src="" style="display: none"></iframe>
</asp:Content>
