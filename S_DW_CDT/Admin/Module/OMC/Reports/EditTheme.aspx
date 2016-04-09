<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EditTheme.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Reports.EditTheme" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
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
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            <tr>
                <td>
                    <dw:GroupBox ID="gbGraph" Title="Graph" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <table border="0">
                                        <tr>
                                            <td style="width: 170px">
                                                <dw:TranslateLabel ID="lbCurveType" Text="Curve type" runat="server" />
                                            </td>
                                            <td>
                                                <dw:TemplatedDropDownList ID="ddCurveType" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="50" 
                                                    OnClientDataExchange="OMC.EditTheme._listDataExchange" runat="server">
                                                    <BoxTemplate>
                                                        <span class="p-selected"><%#Eval("Item2")%></span>
                                                    </BoxTemplate>
                                                    <ItemTemplate>
                                                        <span class="p-selected"><%#Eval("Item2")%></span>
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbLineWidth" Text="Line width" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txLineWidth" CssClass="std field-linewidth" Width="50" runat="server" />&nbsp;px
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbPointSize" Text="Point size" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txPointSize" CssClass="std field-pointsize" Width="50" runat="server" />&nbsp;px
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
                    <dw:GroupBox ID="gbFont" Title="Font" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <omc:FontSelector id="fontSelector" runat="server" /> 
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            <tr>
                <td>
                    <dw:GroupBox ID="gbColors" Title="Colors" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <table border="0">
                                         <tr>
                                            <td style="width: 170px" valign="top">
                                                <dw:TranslateLabel ID="lbElementColors" Text="Element colors" runat="server" />
                                            </td>
                                            <td>
                                                <omc:EditableListBox id="colorsSelector" OnClientItemAdding="OMC.EditTheme._onColorsItemAdding" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="lbGridlineColors" Text="Gridline color" runat="server" />
                                            </td>
                                            <td>
                                                <omc:ColorSelector id="gridlineColorSelector" runat="server" />
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
                    <dw:GroupBox ID="gbMisc" Title="Miscellaneous" runat="server">
                        <table border="0" class="tabTable">
                            <tr>
                                <td>
                                    <table border="0">
                                         <tr>
                                            <td style="width: 170px">
                                                <dw:TranslateLabel ID="lbLegendPosition" Text="Legend position" runat="server" />
                                            </td>
                                            <td>
                                                <dw:TemplatedDropDownList ID="ddLegendPosition" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="85" 
                                                    OnClientDataExchange="OMC.EditTheme._listDataExchange" runat="server">
                                                    <BoxTemplate>
                                                        <span class="p-selected"><%#Eval("Item2")%></span>
                                                    </BoxTemplate>
                                                    <ItemTemplate>
                                                        <span class="p-selected"><%#Eval("Item2")%></span>
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
                                        </tr>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                         <tr>
                                            <td>&nbsp;</td>
                                            <td>
                                                <a id="lnkSettings" class="omc-manage-settings omc-link-noselect" href="javascript:void(0);" runat="server"><dw:TranslateLabel ID="lbAdvancedSettings" Text="Manage advanced settings" runat="server" /><asp:Literal ID="litAdvancedSettingsCount" runat="server" /></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
            </tr>
        </table>
    </div>

    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="hidden" id="OriginalThemeID" name="OriginalThemeID" value="<%=Request("ID")%>" />

    <dw:Dialog ID="dlgAdvancedSettings" Title="Advanced settings" ShowClose="false" ShowOkButton="true" SnapToScreen="true" HidePadding="true"
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

</asp:Content>


