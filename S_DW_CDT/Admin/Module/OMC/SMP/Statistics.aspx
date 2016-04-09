<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Statistics.aspx.vb" Inherits="Dynamicweb.Admin.OMC.SMP.Statistics" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.Charts" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <div class="content-main smp-stats">
        <dw:Infobar ID="infError" runat="server" Type="Error" Visible="False" TranslateMessage="False"></dw:Infobar>
        <h2>
            <dw:TranslateLabel ID="lbMessageName" Text="Message name:" runat="server" />
            <asp:Label ID="lbMessageText"  runat="server"  Text="" ></asp:Label> 
            <span class="text" style="display:none;">
                <asp:Literal ID="litReportDate" runat="server" /></span><div class="dashboard-clear"></div>
        </h2>
        <h3>
            <span class="text">
                <dw:TranslateLabel ID="lbAccuracy" Text="Data is displayed with approximately 15 minutes delay." runat="server" />
            </span>
            <div class="dashboard-clear"></div>
        </h3>
        <div class="factbox-split">
            <div class="factbox-left">
                <dw:RoundedFrame ID="frmHighlights" Title="Highlights" TranslateTitle="true" Width="275" runat="server">
                    <asp:Panel ID="pHighlights" CssClass="highlights tab-switch" runat="server">
                        <asp:Repeater ID="repHighlightsTabs" runat="server">
                            <HeaderTemplate>
                                <ul class="tabs">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <input type="radio" name="highlights" id="h:<%#Eval("Id")%>" <%#If(CType(Eval("IsActive"), Boolean), " checked=""checked""", String.Empty)%> />
                                    <label for="h:<%#Eval("Id")%>"><%#Eval("Name")%></label>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul>
                                <div class="dashboard-clear"></div>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div class="dashboard-separator"></div>

                        <asp:Repeater ID="repHighlightsTabContainer" OnItemDataBound="repHighlightsTabContainer_ItemDataBound" runat="server">
                            <ItemTemplate>
                                <div class="tab-contents<%#If(CType(Eval("IsActive"), Boolean), " active", String.Empty)%>" data-adapter="h:<%#Eval("Id")%>">
                                    <asp:Panel ID="pEmpty" CssClass="empty label" runat="server">
                                        <dw:TranslateLabel ID="lbNoHighlightsAdapter" Text="No data" runat="server" />
                                    </asp:Panel>

                                    <asp:Repeater ID="repHighlightsTabContents" runat="server">
                                        <HeaderTemplate>
                                            <ul class="values-big">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li class="dashboard-clear">
                                                <span class="value"><%#Eval("Value")%></span>
                                                <span class="label separator">-</span>
                                                <span class="label"><%#Eval("Label")%></span>
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </asp:Panel>

                    <asp:Panel ID="pNoHighlights" CssClass="empty label highlights-empty" runat="server">
                        <dw:TranslateLabel ID="lbNoHighlights" Text="No data" runat="server" />
                    </asp:Panel>
                </dw:RoundedFrame>
            </div>

            <div class="factbox-right">
                <dw:RoundedFrame ID="frmDynamics" Title="Reactions over time" TranslateTitle="true" Width="575" runat="server">
                    <asp:Panel ID="pLegend" CssClass="graph-legend-wrapper" runat="server">
                        <asp:Repeater ID="repLegend" runat="server">
                            <HeaderTemplate>
                                <ul class="graph-legend">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <span class="color" style="background-color: <%#Eval("Color")%>"></span>
                                    <span class="label"><%#Eval("Name")%></span>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul>
                                <div class="dashboard-clear"></div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </asp:Panel>

                    <dw:Chart ID="chDynamics" Height="136" Width="545" Type="Line" AutoDraw="true" runat="server" />
                </dw:RoundedFrame>
            </div>

            <div class="dashboard-clear"></div>
        </div>
        
        <div class="factbox-full">
            <dw:RoundedFrame ID="frmLinks" Title="Links" TranslateTitle="true" Width="853" runat="server">
                <asp:Panel ID="pLinks" CssClass="links tab-switch" runat="server">
                     <asp:Repeater ID="repLinksTabs" runat="server">
                        <HeaderTemplate>
                            <ul class="tabs">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li>
                                <input type="radio" name="links" id="l:<%#Eval("Id")%>" <%#If(CType(Eval("IsActive"), Boolean), " checked=""checked""", String.Empty)%> />
                                <label for="l:<%#Eval("Id")%>"><%#Eval("Name")%></label>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                            <div class="dashboard-clear"></div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <div class="dashboard-separator"></div>

                    <asp:Repeater ID="repLinksTabContainer" OnItemDataBound="repLinksTabContainer_ItemDataBound" runat="server">
                        <ItemTemplate>
                            <div class="tab-contents list-container<%#If(CType(Eval("IsActive"), Boolean), " active", String.Empty)%><%#If(CType(Eval("HasLinks"), Boolean), " list-container-has-records", String.Empty)%>" data-adapter="l:<%#Eval("Id")%>">
                                <dw:List ID="lstLinks" ShowTitle="false" NoItemsMessage="No data" ShowPaging="false" runat="server">
                                    <Columns>
                                        <dw:ListColumn Name="Url" TranslateName="true" runat="server" />
                                        <dw:ListColumn Name="Link clicks" TranslateName="true" HeaderAlign="Center" ItemAlign="Center" runat="server" />
                                    </Columns>
                                </dw:List>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>
                <asp:Panel ID="pNoLinks" CssClass="empty label links-empty" runat="server">
                    <dw:TranslateLabel ID="lbNoLinks" Text="No data" runat="server" />
                </asp:Panel>
            </dw:RoundedFrame>

            <div class="export">
                <a href="javascript:void(0);" class="export-to-csv">
                    <dw:TranslateLabel ID="lbExportToCsv" Text="Export to CSV" runat="server" />
                </a>
                <div class="dashboard-clear"></div>
            </div>
        </div>
        
        <div class="factbox-full" style="margin-top :5px;">
            <dw:RoundedFrame ID="frmContent" Title="Message" TranslateTitle="true" Width="853" runat="server">
                <asp:Panel ID="pContent" CssClass="links tab-switch"  runat="server">
                     <asp:Repeater ID="repContentTabs" runat="server">
                        <HeaderTemplate>
                            <ul class="tabs">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li>
                                <input type="radio" name="content" id='c:<%#Eval("Id")%>'<%#If(CType(Eval("IsActive"), Boolean), " checked=""checked""", String.Empty)%> />
                                <label for="c:<%#Eval("Id")%>"><%#Eval("Name")%></label>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                            <div class="dashboard-clear"></div>
                        </FooterTemplate>
                    </asp:Repeater>


                <div class="dashboard-separator"></div>

                <asp:Repeater ID="repContentTabContainer" OnItemDataBound="repContentTabContainer_ItemDataBound" runat="server">
                    <ItemTemplate>
                            <div class="tab-contents<%#If(CType(Eval("IsActive"), Boolean), " active", String.Empty)%>" data-adapter="c:<%#Eval("Id")%>">
                            <asp:Panel ID="pEmpty" CssClass="empty label" runat="server">
                                <dw:TranslateLabel ID="lbNoContentAdapter" Text="No data" runat="server" />
                            </asp:Panel>

                            <asp:Repeater ID="repContentTabContents" runat="server">
                                <HeaderTemplate>
                                    <ul class="values-big">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <span class="adapterName"><%#Eval("Name")%></span>
                                    <p><%#Eval("Text")%></p>
                                    <div class="post" style="display:<%#Eval("IsShowPost")%>;">
                                        <div id="postedImage<%#Eval("Name").ToString().Replace(" ", "")%>" style="display:<%#Eval("ShowImage")%>;">
                                            <img src="<%#Eval("Image")%>" alt="">
                                        </div>
                                        <div id="postedLink<%#Eval("Name").ToString().Replace(" ", "")%>" style="display:<%#Eval("ShowLink")%>;">
                                            <a class="postTitle" href="<%#Eval("Link")%>"><%#Eval("Title")%></a>
                                            <p class="postDescription"><%#Eval("Description")%></p>
                                        </div>
                                    </div><p></p>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                </asp:Panel>

                <asp:Panel ID="pNoContent" CssClass="empty label links-empty" runat="server">
                    <dw:TranslateLabel ID="lbNoContent" Text="No data" runat="server" />
                </asp:Panel>
            </dw:RoundedFrame>
        </div>
    </div>

    <dw:Dialog ID="dlgExport" UseTabularLayout="true" Title="Export to CSV" TranslateTitle="true" Width="500" ShowOkButton="true" ShowCancelButton="true" ShowClose="true" OkText="Export" OkAction="OMC.SMP.Statistics.exportToCsv();" runat="server">
        <div class="export-to-csv">
            <p>
                <dw:TranslateLabel ID="lbChooseDatasource" Text="Please select the part of the report you would like to export to CSV format:" runat="server" />
            </p>
            <ul class="csv-source">
                <li>
                    <input data-expandable="true" type="radio" id="rbCsvSourceHighlights" name="CsvSource" value="Highlights" />
                    <label data-expandable="true" for="rbCsvSourceHighlights">
                        <dw:TranslateLabel ID="lbCsvSourceHighlights" Text="Highlights" runat="server" />
                    </label>
                    <div class="dashboard-clear"></div>
                    <asp:Literal ID="litSubCategoriesHighlights" runat="server" />
                </li>
                <li>
                    <input type="radio" id="rbCsvSourceDynamics" name="CsvSource" value="ReactionsOverTime" />
                    <label for="rbCsvSourceDynamics">
                        <dw:TranslateLabel ID="lbCsvSourceDynamics" Text="Reactions over time" runat="server" />
                    </label>
                </li>
                <li>
                    <input data-expandable="true" type="radio" id="rbCsvSourceLinks" name="CsvSource" value="Links" />
                    <label data-expandable="true" for="rbCsvSourceLinks">
                        <dw:TranslateLabel ID="lbCsvSourceLinks" Text="Links" runat="server" />
                    </label>
                    <div class="dashboard-clear"></div>
                    <asp:Literal ID="litSubCategoriesLinks" runat="server" />
                </li>
                <li class="separator">
                    <input type="radio" id="rbCsvSourceAll" name="CsvSource" value="All" />
                    <label for="rbCsvSourceAll">
                        <dw:TranslateLabel ID="lbCsvSourceAll" Text="Everything (zip archive)" runat="server" />
                    </label>
                </li>
            </ul>
        </div>
    </dw:Dialog>

    <dw:Overlay ID="WaitSpinner" runat="server" />

    <script type="text/javascript">
        OMC.SMP.Statistics.terminology.selectExportSource = '<%=Dynamicweb.Backend.Translate.Translate("Please select the data to be exported.")%>';
        OMC.SMP.Statistics.initialize();
    </script>

</asp:Content>

