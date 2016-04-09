<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="EcomAdvConfigPrices_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigPrices_Edit" EnableViewState="false" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="Stylesheet" type="text/css" href="../css/EcomAdvConfigPricesEdit.css" media="screen" />
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeScriptaculous="true"></dw:ControlResources>
    <script type="text/javascript" src="../js/EcomAdvConfigPricesEdit.js"></script>

    <script language="javascript" type="text/javascript">
        document.observe("dom:loaded", function () {
            var trans = {};
            trans['CustomColumnsEmpty'] = '<%=Translate.Translate("Custom columns list must be filled!")%>';
            trans['CustomOrderEmpty'] = '<%=Translate.Translate("Custom order list must be filled!")%>';
            trans['RequestError'] = '<%=Translate.Translate("Something went wrong! Try again.")%>';

            new Dynamicweb.Managment.Ecom.AdvConfig.Prices.Forms.Main({
                help: function () {
                    <%=Gui.help("", "administration.controlpanel.ecom.prices") %>
                },
                translations: trans
            });
        });
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >

    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
				    <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					    <table cellpadding="2" cellspacing="0" border="0">
						    <colgroup>
							    <col width="300px" />
							    <col />
						    </colgroup>
						    <tr>
							    <td><%= Translate.Translate("System moms")%></td>
							    <td><input type="text" name="/Globalsettings/Ecom/Price/PricesInDbVAT" id="/Globalsettings/Ecom/Price/PricesInDbVAT" value="<%=Base.GetGs("/Globalsettings/Ecom/Price/PricesInDbVAT")%>" maxlength="255" size=4 class="stdNoWidth" /> %</td>
						    </tr>

						    <tr>
							    <td><%= Translate.Translate("Use VAT group rate as system tax")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax" name="/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax" /></td>
						    </tr>

						    <tr>
							    <td><%=Translate.Translate("Priser i DB inkl. moms")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/PricesInDbIncludesVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/PricesInDbIncludesVAT" name="/Globalsettings/Ecom/Price/PricesInDbIncludesVAT" /></td>
						    </tr>
						    <tr>
							    <td><%=Translate.Translate("Afrund priser med moms")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/RoundPricesWithVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/RoundPricesWithVAT" name="/Globalsettings/Ecom/Price/RoundPricesWithVAT" /></td>
						    </tr>
						    <tr>
							    <td><%=Translate.Translate("Beregn % forsendelsesgebyr inkl. moms")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT" name="/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT" /></td>
						    </tr>
						    <tr>
							    <td><%=Translate.Translate("Brug alt. leveringsland ved moms")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry" name="/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry" /></td>
						    </tr>
						    <tr>
							    <td><%=Translate.Translate("Calculate payment fee from price including shipping fee")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/CalculatePaymentFeeInclShippingFee") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/CalculatePaymentFeeInclShippingFee" name="/Globalsettings/Ecom/Price/CalculatePaymentFeeInclShippingFee" /></td>
						    </tr>
                            <tr>
							    <td><%=Translate.Translate("Allow negative total order price")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/AllowNegativeOrderTotalPrice") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/AllowNegativeOrderTotalPrice" name="/Globalsettings/Ecom/Price/AllowNegativeOrderTotalPrice" /></td>
						    </tr>                            
					    </table>
				    <%=Gui.GroupBoxEnd%>
				
                    <%=Gui.GroupBoxStart(Translate.Translate("Calculate VAT on fees"))%>
					    <table cellpadding="2" cellspacing="0" border="0">
						    <colgroup>
							    <col width="300px" />
							    <col />
						    </colgroup>
						    <tr>
							    <td><%=Translate.Translate("Payment")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee" name="/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee" /></td>
						    </tr>
						    <tr>
							    <td><%=Translate.Translate("Shipment")%></td>
							    <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee" name="/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee" /></td>
						    </tr>
					    </table>
				    <%=Gui.GroupBoxEnd%>
                    
                    <%=Gui.GroupBoxStart(Translate.Translate("List"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
							<col width="300px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td><%=Translate.Translate("Use custom columns")%></td>
                            <td><input type="checkbox" data-action="toggleList" data-source="customColumnsList" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/List/UseCustomColumns") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/List/UseCustomColumns" name="/Globalsettings/Ecom/Price/List/UseCustomColumns" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <table class="list-wrapper">
                                    <tr>
                                        <td class="list-content">
                                            <ul data-sortable="true" id="custom-columns">
                                            </ul>
                                        </td>
                                        <td class="list-toolbar">
                                            <ul>
                                                <li>
                                                    <a href="#" data-action="openDialog" data-source="customColumnsList"><img src="/Admin/Images/eCom/eCom_Product_add_small.gif"/></a>
                                                </li>
                                                <li>
                                                    <a href="#" data-action="removeItem" data-source="customColumnsList"><img src="/Admin/Images/eCom/eCom_Product_delete_small.gif"/></a>
                                                </li>
                                            </ul>                                            
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td><%=Translate.Translate("Use custom order")%></td>
                            <td><input type="checkbox" data-action="toggleList" data-source="customOrderList" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/List/UseCustomOrder") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/List/UseCustomOrder" name="/Globalsettings/Ecom/Price/List/UseCustomOrder" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <table class="list-wrapper">
                                    <tr>
                                        <td class="list-content">
                                            <ul data-sortable="true" id="custom-order">
                                            </ul>
                                        </td>
                                        <td class="list-toolbar">
                                            <ul>
                                                <li>
                                                    <a href="#" data-action="openDialog" data-source="customOrderList"><img src="/Admin/Images/eCom/eCom_Product_add_small.gif"/></a>
                                                </li>
                                                <li>
                                                    <a href="#" data-action="removeItem" data-source="customOrderList"><img src="/Admin/Images/eCom/eCom_Product_delete_small.gif"/></a>
                                                </li>
                                            </ul>                                            
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd()%>

                    <%=Gui.GroupBoxStart(Translate.Translate("Advanced settings"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
							<col width="300px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td><%=Translate.Translate("Use Price Matrix in Product Catalog filtering")%></td>
                            <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/AdvancedSettings/ProductCatalogFilteringByPriceMatrix") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/AdvancedSettings/ProductCatalogFilteringByPriceMatrix" name="/Globalsettings/Ecom/Price/AdvancedSettings/ProductCatalogFilteringByPriceMatrix" /></td>
                        </tr>
                        <tr>
                            <td colspan="2"><small class="disableText">(<%=Translate.Translate("Requires a custom PriceProvider Add-In with caching and use of filters on Product Catalog")%>)</small></td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd()%>
                </td>
            </tr>
        </table>
    </div>
    
    <dw:Dialog ID="ColumnsSelector" Title="Select columns" TranslateTitle="True" ShowCancelButton="True" ShowOkButton="True" runat="server">
        <div class="list-wrapper">
            <div class="list-header">
                <ul>
                    <li>
                        <input type="checkbox"/>
                    </li>
                </ul>
            </div>
            <div class="list-content">
                <ul class="enabled"></ul>
            </div>
        </div>
    </dw:Dialog>
    
    <%-- Postback data --%>
    <input type="hidden"  id="/Globalsettings/Ecom/Price/List/CustomColumns" name="/Globalsettings/Ecom/Price/List/CustomColumns" />
    <input type="hidden" id="/Globalsettings/Ecom/Price/List/CustomOrder" name="/Globalsettings/Ecom/Price/List/CustomOrder" />

    <% Translate.GetEditOnlineScript() %>

</asp:Content>
