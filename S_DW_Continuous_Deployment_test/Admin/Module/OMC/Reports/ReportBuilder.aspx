<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="ReportBuilder.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Reports.ReportBuilder" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <!-- IE-specific styles to align drop-down lists with other fields -->

    <!--[if gt IE 6]>
    <style type="text/css">
        a.dropDown
        {
            width: 252px !important;
        }
    </style>
    <![endif]-->

    <!-- End: IE-specific styles to align drop-down lists with other fields -->
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div class="content-main"> 
        <table border="0">
            <tr>
                <td>
                    <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <table border="0">
                                         <tr>
                                            <td style="width: 170px">
                                                <dw:TranslateLabel ID="lbName" Text="Name" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txName" CssClass="std field-name" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbCategory" Text="Category" runat="server" />
                                            </td>
                                            <td>
                                                <dw:TemplatedDropDownList ID="ddCategories" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="150" 
                                                    OnClientDataExchange="OMC.ReportBuilder._categoriesDataExchange" runat="server">
                                                    <ItemTemplate>
                                                        <div class="p-selected">
                                                            <%# MutatePath(Eval("UniqueID"))%>
                                                        </div>
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <dw:TranslateLabel ID="lbDescription" Text="Description" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txDescription" TextMode="MultiLine" CssClass="std" style="height: 64px" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            <tr>
                <td>
                    <dw:GroupBox ID="gbChart" Title="Chart settings" runat="server">
                        <table border="0" class="tabTable">
                            <tr class="reporttype reporttype-page">
                                <td>
                                    <div class="content-info">
                                        <dw:TranslateLabel ID="lbOverriddenSettings" Text="Note that any of the following settings might be overridden by the target report page." runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0">
                                        <tr>
                                            <td style="width: 170px">
                                                <dw:TranslateLabel ID="lbChartType" Text="Type" runat="server" />
                                            </td>
                                            <td valign="top">
                                                <dw:TemplatedDropDownList ID="ddChartTypes" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="250" 
                                                        OnClientDataExchange="OMC.ReportBuilder._chartTypesDataExchange" runat="server">
                                                    <BoxTemplate>
                                                        <div class="p-selected">
                                                            <%# Eval("Name")%>
                                                        </div>
                                                    </BoxTemplate>
                                                    <ItemTemplate>
                                                        <table class="p-row" cellspacing="0" cellpadding="0" border="0">
                                                            <tr>
                                                                <td class="p-icon-cell" valign="top">
                                                                    <img class="p-icon" src="<%#System.Web.HttpUtility.HtmlAttributeEncode(Eval("Icon"))%>" alt="" />
                                                                </td>
                                                                <td class="p-description-cell" valign="top">
                                                                    <div class="p-name"><%#Eval("Name")%></div>
                                                                    <div class="p-description"><%#Eval("Description")%></div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbTheme" Text="Theme" runat="server" />
                                            </td>
                                            <td>
                                                <dw:TemplatedDropDownList ID="ddThemes" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="150"
                                                    OnClientDataExchange="OMC.ReportBuilder._categoriesDataExchange" runat="server">
                                                    <ItemTemplate>
                                                        <div class="p-selected">
                                                            <%#Eval("Label")%>
                                                        </div>
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbChartData" Text="Chart data" runat="server" />
                                            </td>
                                            <td>
                                                <div class="field-show-chart-data">
                                                    <asp:CheckBox ID="chkShowChartData" runat="server" />
                                                    <asp:Label ID="lbShowChartData" AssociatedControlID="chkShowChartData" Text="Show" runat="server" />
                                                    <div class="omc-clear"></div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbWidth" Text="Width" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txWidth" CssClass="std field-width" Width="50" Text="500" runat="server" />&nbsp;px
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbHeight" Text="Height" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txHeight" CssClass="std field-height" Width="50" Text="400" runat="server" />&nbsp;px
                                            </td>
                                        </tr>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <a id="lnkChartSettings" class="omc-manage-settings omc-link-noselect" href="javascript:void(0);" runat="server"><dw:TranslateLabel ID="lbAdvancedSettings" Text="Manage advanced settings" runat="server" /><asp:Literal ID="litAdvancedSettingsCount" runat="server" /></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            <tr id="rManual" class="reporttype reporttype-default" runat="server">
                <td>
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <td>
                                <dw:GroupBox ID="gbData" Title="Data" runat="server">
                                    <table border="0" class="tabTable">
                                        <tr>
                                            <td>
                                                <div class="content-info">
                                                    <dw:TranslateLabel ID="lbInfo" Text="Choose facts to be presented in the report by dragging items from the list on the left to corresponding areas on the right." runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:FactSelector ID="fSelector" AutoLoad="true" Height="400" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </dw:GroupBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="rLink" class="reporttype reporttype-page" runat="server" style="display: none">
                <td>
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <td>
                                <dw:GroupBox ID="gbLink" Title="Link to page" runat="server">
                                    <table border="0" class="tabTable">
                                        <tr>
                                            <td>
                                                <table border="0">
                                                    <tr>
                                                        <td style="width: 170px">
                                                            <dw:TranslateLabel ID="lbURL" Text="URL" runat="server" />
                                                        </td>
                                                        <td valign="top">
                                                            <asp:TextBox ID="txURL" CssClass="std field-url" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </dw:GroupBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="hidden" id="ReportType" name="ReportType" value="<%=ReportType%>" />
    <input type="hidden" id="CloseOnSave" name="CloseOnSave" value="True" />
    <input type="hidden" id="OriginalReportID" name="OriginalReportID" value="<%=Request("ID")%>" />
    <input type="hidden" id="OriginalReportCategoryID" name="OriginalReportCategoryID" value="<%=Request("CategoryID")%>" />

    <dw:Dialog ID="dlgAdvancedSettings" Title="Advanced chart settings" ShowClose="false" ShowOkButton="true" SnapToScreen="true" HidePadding="true"
        ShowHelpButton="false" ShowCancelButton="false" UseTabularLayout="true" TranslateTitle="true" Width="516" runat="server">
        <div class="omc-chart-settings">
            <dw:EditableGrid ID="gridAdvancedSettings" AllowAddingRows="true" AddNewRowMessage="Click here to add new setting..." 
                NoRowsMessage="No settings found" AllowDeletingRows="true" AllowSortingRows="false" runat="server">

                <Columns>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="215">
                    <ItemTemplate>
                        <div style="white-space: nowrap">
                            &nbsp;<asp:TextBox ID="txName" CssClass="std" Width="200" Text='<%#Eval("Key")%>' runat="server" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Value" HeaderStyle-Width="215">
                    <ItemTemplate>
                        <asp:TextBox ID="txValue" CssClass="std" Width="200" Text='<%#Eval("Value")%>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="70">
                    <ItemTemplate>
                        <span class="omc-chart-settings-field-offset">
                            <a id="lnkDelete" class="omc-link-noselect" href="javascript:void(0);" runat="server">
                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" border="0" />
                            </a>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                </Columns>
            </dw:EditableGrid>
        </div>
    </dw:Dialog>

    <iframe name="frmPostback" src="" style="display: none"></iframe>
</asp:Content>
