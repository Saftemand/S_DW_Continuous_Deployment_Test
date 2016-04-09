<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb"
    AutoEventWireup="false" CodeBehind="EcomAdvConfigGeneral_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigGeneral_Edit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function () {
            /*
            var url = "EcomAdvConfigGeneral_Edit.aspx?action=onsave"

            new Ajax.Request(FileManagerPage.makeUrlUnique(url), {
                method: 'get',
                parameters: {
                    ActualFolder: sourceFolder,
                    ActualFile: file
                },
                onSuccess: function (transport) {
                    var refCnt = transport.responseText.evalJSON();
                    if (refCnt == '0') {
                        FileManagerPage.DoMove(destinationFolder, file);
                    }
                    else {
                        var checkingAction = FileManagerPage.CheckFileReferences(sourceFolder, file, "move", refCnt);
                        if (checkingAction == "move_rename") {
                            FileManagerPage.DoMove(destinationFolder, file);
                        }
                        else if (checkingAction == "update_move_rename") {
                            FileManagerPage.DoUpdateMoveWithLinkManagement(sourceFolder, destinationFolder, file);
                        }
                    }
                }
            });
*/
            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.general") %>
        }

        function ChkValidNum(field) {
	        var newValue = '';
	        for(i = 0; i < field.value.length; i++){
		        if(!isNaN(field.value.charAt(i))){
			        newValue = newValue + '' + field.value.charAt(i);
		        }
	        }
	        field.value = newValue;
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
                    <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Antal dage kurven gemmes")%>
                            </td>
                            <td>
                                <input type="text" onkeyup="ChkValidNum(this);" value="<%=Base.GetGs("/Globalsettings/Ecom/Cookie/DaysToSave")%>"
                                    id="/Globalsettings/Ecom/Cookie/DaysToSave" name="/Globalsettings/Ecom/Cookie/DaysToSave"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Minutes the products in cart are reserved")%>
                            </td>
                            <td>
                                <input type="text" onkeyup="ChkValidNum(this);" value="<%=Base.GetGs("/Globalsettings/Ecom/Product/MinutesReserved")%>"
                                    id="/Globalsettings/Ecom/Product/MinutesReserved" name="/Globalsettings/Ecom/Product/MinutesReserved"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="radio" value="modeCheckout" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ReserveMode") = "modeCheckout", "checked", "")%>
                                    id="Mode1" name="/Globalsettings/Ecom/Product/ReserveMode"><label for="Mode1"><%=Translate.Translate("Reserve at checkout step")%></label><br />
                                <input type="radio" value="modeAddToCart" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ReserveMode") = "modeAddToCart", "checked", "")%>
                                    id="Mode2" name="/Globalsettings/Ecom/Product/ReserveMode"><label for="Mode2"><%=Translate.Translate("Reserve when product is added to cart")%></label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Enhed for vægt")%>
                            </td>
                            <td>
                                <input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/Unit/Weight") = "", "kg", Base.GetGs("/Globalsettings/Ecom/Unit/Weight"))%>"
                                    id="/Globalsettings/Ecom/Unit/Weight" name="/Globalsettings/Ecom/Unit/Weight"
                                    class="stdNoWidth" size="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Enhed for rumfang")%>
                            </td>
                            <td>
                                <input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/Unit/Volume") = "", "m³",Base.GetGs("/Globalsettings/Ecom/Unit/Volume"))%>"
                                    id="/Globalsettings/Ecom/Unit/Volume" name="/Globalsettings/Ecom/Unit/Volume"
                                    class="stdNoWidth" size="10" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Gem sidst brugte kunde data")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData" name="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData" />
                                <input type="hidden" name="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerChoicesMade"
                                    id="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerChoicesMade" value="True" />
                            </td>
                        </tr>                        
                        <tr>
                            <td>
                                <%= Translate.Translate("Allow different context dates")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Cart/AllowDifferentContextDates") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Cart/AllowDifferentContextDates" name="/Globalsettings/Ecom/Cart/AllowDifferentContextDates" />
                            </td>
                        </tr>                                  
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Navigation"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="100%" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%= Translate.Translate("Only apply eCommerce navigation if page is in path")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Navigation/ApplyOnliyIfPageIsInPath") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Navigation/ApplyOnliyIfPageIsInPath" name="/Globalsettings/Ecom/Navigation/ApplyOnliyIfPageIsInPath" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Enable navigation group sorting")%>
                            </td>
                            <td>
                            <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting" name="/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Sort products by name")%>
                            </td>
                            <td>
                            <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Navigation/SortProductsByName") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Navigation/SortProductsByName" name="/Globalsettings/Ecom/Navigation/SortProductsByName" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Apply startlevel and endlevel to navigation")%>
                            </td>
                            <td>
                            <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Navigation/ApplyStartAndEndLevelToNavigation") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Navigation/ApplyStartAndEndLevelToNavigation" name="/Globalsettings/Ecom/Navigation/ApplyStartAndEndLevelToNavigation" />
                            </td>
                        </tr>
                        <%If Dynamicweb.Frontend.XmlNavigation.GetCustomNavigationProviders().Count > 0 Then%>
                        <tr>
                            <td>
                                <%= Translate.Translate("Use only custom navigation provider")%><br />
                                <small class="disableText">(<%= Translate.Translate("If selected only custom navigation provider will be used, otherwise all existing navigation providers will be used")%>)</small>
                            </td>
                            <td>
                            <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Navigation/UseOnlyCustomNavigationProvider") = "True", "CHECKED", "")%>=""
                                    id="/Globalsettings/Ecom/Navigation/UseOnlyCustomNavigationProvider" name="/Globalsettings/Ecom/Navigation/UseOnlyCustomNavigationProvider" />
                            </td>
                        </tr>
                        <%End If%>                        
                        <tr>
                            <td>
                                <%= Translate.Translate("Max number of products included in each group")%>
                            </td>
                            <td>
                            <input type="text" value="<%=Base.GetGs("/Globalsettings/Ecom/Navigation/MaxNumberOfProducts")%>"
                                    id="/Globalsettings/Ecom/Navigation/MaxNumberOfProducts" name="/Globalsettings/Ecom/Navigation/MaxNumberOfProducts"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Products cache, minutes")%>
                            </td>
                            <td>
                            <input type="text" value="<%=Base.GetGs("/Globalsettings/Ecom/Navigation/CacheProductsMinutes")%>"
                                    id="/Globalsettings/Ecom/Navigation/CacheProductsMinutes" name="/Globalsettings/Ecom/Navigation/CacheProductsMinutes"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Language"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="100%" />
                            <col />
                        </colgroup>
                        <tr>
                            <td nowrap="nowrap">
                                <%= Translate.Translate("Only show translated elements")%>
                                <small class="disableText">(<%= Translate.Translate("Groups, products and related products")%>)</small>
                            </td>
                            <td align="right">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists" name="/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists" />
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <%= Translate.Translate("Activate products on all language versions on create")%>
                            </td>
                            <td align="right">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ActivateProductsOnAllLanguageVersions") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/ActivateProductsOnAllLanguageVersions" name="/Globalsettings/Ecom/Product/ActivateProductsOnAllLanguageVersions"/>
                            </td>                        
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Only show products"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%= Translate.Translate("That are in stock")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" name="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("That have a price")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice" name="/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("That are active")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive" name="/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Show this page for inactive products")%>
                            </td>
                            <td>
                                <%=Dynamicweb.Gui.LinkManager(Base.GetGs("/Globalsettings/Ecom/Product/ProductNotActivePage"), "/Globalsettings/Ecom/Product/ProductNotActivePage", "", "0", "", False, "off", True)%>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Only show variants"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%= Translate.Translate("That are in stock")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock") = "True", "checked=""checked""", ""))%>
                                    id="Checkbox2" name="/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("That have a price")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice") = "True", "checked=""checked""", ""))%>
                                    id="Checkbox3" name="/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("That are active")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive") = "True", "checked=""checked""", ""))%>
                                    id="Checkbox4" name="/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Show default variant in product list")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ShowVariantDefault") = "True", "CHECKED", "")%>
                                    id="/Globalsettings/Ecom/Product/ShowVariantDefault" name="/Globalsettings/Ecom/Product/ShowVariantDefault" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Produkt - Gruppevisnings cache"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Aktiver")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollection") = "True", "CHECKED", "")%>
                                    id="Checkbox1" name="/Globalsettings/Ecom/ProductGroup/CacheProductCollection" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Antal minuter")%>
                            </td>
                            <td>
                                <input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes") = "", "1",Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes"))%>"
                                    id="Text1" name="/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Afsnits cache"))%>
                    <table border="0" cellpadding="2" cellspacing="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Aktiver")%>
                            </td>
                            <td>
                                <input id="/Globalsettings/Ecom/ProductGroup/CacheParagraph" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheParagraph") = "True", "CHECKED", "")%>=""
                                    name="/Globalsettings/Ecom/ProductGroup/CacheParagraph" type="checkbox" value="True" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Udregning af gebyr"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td colspan="2">
                                <strong>
                                    <%=Translate.Translate("Forsendelse")%></strong>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Brug alt. leveringsland")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShippingFee/UseDeliveryCountryOnShippingFee") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Order/ShippingFee/UseDeliveryCountryOnShippingFee" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <strong>
                                    <%=Translate.Translate("Betaling")%></strong>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Brug alt. leveringsland")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/PaymentFee/UseDeliveryCountryOnPaymentFee") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Order/PaymentFee/UseDeliveryCountryOnPaymentFee" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Træstruktur"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Vis produkt antal")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Group/ShowProductCountInTree") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Group/ShowProductCountInTree" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Include product number in product selector")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Group/ShowProductNumberInTree") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Group/ShowProductNumberInTree" />
                            </td>
                        </tr>
                        <td>
                            <%=Translate.Translate("Show shop name for related groups")%>
                        </td>
                        <td>
                            <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Group/ShowShopNameForRelatedGroups") = "True", "CHECKED", "")%>
                                name="/Globalsettings/Ecom/Group/ShowShopNameForRelatedGroups" />
                        </td>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Additional fields"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Show cost field on products")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ShowProductCostField") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Product/ShowProductCostField" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Include variants in Bulk Edit")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/BulkEditForProductVariant") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Product/BulkEditForProductVariant" />
                            </td>
                        </tr>
                        <%If Base.IsModuleInstalled("eCom_BackCatalog") Then%>
                        <tr>
                            <td>
                                <%=Translate.Translate("Show back catalog fields on products")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/ShowBackCatalogFields") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Product/ShowBackCatalogFields" />
                            </td>
                        </tr>
                        <%End If%>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Track & Trace"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%= Translate.Translate("Show old track and trace field")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShowOldTrackAndTraceField") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Order/ShowOldTrackAndTraceField" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Taxes in the backend"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%= Translate.Translate("Consolidate taxes for each product")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ConsolidateTaxesForProducts") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Order/ConsolidateTaxesForProducts" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%= Translate.Translate("Consolidate taxes for the order")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ConsolidateTaxesForOrder") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Order/ConsolidateTaxesForOrder" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Mail Afsendelse"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Ordre Mail metode")%>
                            </td>
                            <td>
                                <select class="std" name="/Globalsettings/Ecom/Order/ConfirmMail/Method" id="/Globalsettings/Ecom/Order/ConfirmMail/Method">
                                    <option value="">
                                        <%=Translate.JsTranslate("Default")%></option>
                                    <option <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ConfirmMail/Method") = "dropbox", "selected", "")%>
                                        value="dropbox">
                                        <%=Translate.JsTranslate("Drop Box")%></option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Power pack"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Number of links needed to appear on Customer who saw also saw list")%>
                            </td>
                            <td>
                                <input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/RelatedProducts/LimitOfLinksToAppearOnTheList") = "", "5",Base.GetGs("/Globalsettings/Ecom/RelatedProducts/LimitOfLinksToAppearOnTheList"))%>"
                                    id="/Globalsettings/Ecom/RelatedProducts/LimitOfLinksToAppearOnTheList" name="/Globalsettings/Ecom/RelatedProducts/LimitOfLinksToAppearOnTheList"
                                    class="stdNoWidth" size="4" />
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <colgroup>
                            <col width="170px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td>
                                <%=Translate.Translate("Use long description if short description is empty")%>
                            </td>
                            <td>
                                                           <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/UseLongDescriptionIfShortDescriptionIsEmpty") = "True", "CHECKED", "")%>
                                    name="/Globalsettings/Ecom/Product/UseLongDescriptionIfShortDescriptionIsEmpty" />

                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <dw:GroupBox ID="GroupBox3" runat="server" Title="Orders" DoTranslation="true">
				        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
			                <colgroup>
				                <col width="170px" />
				                <col width="20px" />
			                </colgroup>
					        <tr>
				    	        <td><dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Allow edit order for all users" /></td>
						        <td>

						            <input type="checkbox" name="/Globalsettings/Ecom/Order/AllowEditOrderForUsers" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Order/AllowEditOrderForUsers")), "checked", "")%> />
						        </td>
					        </tr>
                            <tr>
				    	        <td>
                                    <%= Translate.Translate("Allow edit order price to exceed original order price")%>
				    	        </td>
						        <td>
						            <input type="checkbox" name="/Globalsettings/Ecom/Order/AllowExceedOriginalOrderPrice" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Order/AllowExceedOriginalOrderPrice")), "checked", "")%> />
						        </td>
					        </tr>
                            <%If Base.HasVersion("8.4.1.0") Then%>
					        <tr>
				    	        <td><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Disable delete button for orders" /></td>
						        <td>

						            <input type="checkbox" name="/Globalsettings/Ecom/Order/DisableDeleteButtonForOrders" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Order/DisableDeleteButtonForOrders")), "checked", "")%> />
						        </td>
					        </tr>
                            <%End If%>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBox ID="GroupBox1" runat="server" Title="Integration" DoTranslation="true">
				        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
			                <colgroup>
				                <col width="170px" />
				                <col width="20px" />
			                </colgroup>
					        <tr>
				    	        <td><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Disable creation of new product/variant" /></td>
						        <td>
						            <input type="checkbox" name="/Globalsettings/Ecom/Integration/DisableCreationNewProductVariant" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Integration/DisableCreationNewProductVariant")), "checked", "")%> />
						        </td>
					        </tr>
                            <tr>
				    	        <td><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Disable creation of new groups" /></td>
						        <td>
						            <input type="checkbox" name="/Globalsettings/Ecom/Integration/DisableCreationNewGroups" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Integration/DisableCreationNewGroups")), "checked", "")%> />
						        </td>
					        </tr>
                            <tr>
				    	        <td><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Edit group id" /></td>
						        <td>
						            <input type="checkbox" name="/Globalsettings/Ecom/Integration/EditGroupId" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Integration/EditGroupId")), "checked", "")%> />
						        </td>
					        </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
        </table>
    </div>
    <% Translate.GetEditOnlineScript()%>
</asp:Content>
