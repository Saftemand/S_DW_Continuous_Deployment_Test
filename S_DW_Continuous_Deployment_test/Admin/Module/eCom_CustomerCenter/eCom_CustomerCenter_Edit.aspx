<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="eCom_CustomerCenter_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_CustomerCenter_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>

<script type="text/javascript">

    $(document).observe('dom:loaded', function () {
        toggleShops();
    });

    function toggleShops() {
        if ($('ShopRadioAll').checked) {
            $("ShopID").value = "";
            $('ShopSelectorRow').hide();
        }
        else {
            serializeShops();
            $('ShopSelectorRow').show();
        }
    }

    function serializeShops() {
        var fields = SelectionBox.getElementsRightAsArray("ShopSelector");
        $("ShopID").value = fields.join(); //  fieldsJSON;
    }

</script>


<input type="hidden" name="eCom_CustomerCenter_settings" value="DefaultMailAddress, DefaultView, specialMenu, specialOrderList, specialOrderDetail,specialOrderSearch, specialFavoritesList, specialSingleFavoritesList, LinkToMyOrders, LinkToFrequentlyItems, LinkToMyFavorites, LinkToPublicFavorites, LinkToSearch, LinkToRMA, LinkToRMADirectUrl, TextMyFavorites, TextMyFavoritesPicture, TextMyFavoritesText, TextSearch, TextSearchPicture, TextSearchText, TextMyOrders, TextMyOrdersPicture, TextMyOrdersText, TextFrequentlyItems, TextFrequentlyItemsPicture, TextFrequentlyItemsText, TextRMA, TextRMAPicture, TextRMAText, ItemsPerPage, PagerNextButtonType, PagerPrevButtonType, PagerNextButtonTypeText, PagerNextButtonTypePicture, PagerPrevButtonTypeText, PagerPrevButtonTypePicture, SpecifyMailTemplate, OrderMailTemplate, MenuLayoutTemplate, FrequentlyItemsTemplate, FrequentlyItemsDetailsTemplate, OrderListTemplate, OrderDetailsTemplate, FavoritesListTemplate, OrderSearchTemplate, RMAListTemplate, RMADetailsTemplate, BoughtFromDate_month, BoughtFromDate_day, BoughtFromDate_year, ShopID, FavListEmailTemplate, FavListEmailSubject, FavListEmailSenderName, FavListEmailSenderEmail, TextMyQuotes, TextMyQuotesPicture, TextMyQuotesText, LinkToMyQuotes, QuoteListTemplate, QuoteDetailsTemplate, ImagePatternProductCatalog, TextCardTokens, TextCardTokensPicture, TextCardTokensText, LinkToCardTokens, CardTokenListTemplate, TextRecurringOrders, TextRecurringOrdersPicture, TextRecurringOrdersText, LinkToRecurringOrders, RecurringOrderListTemplate, RecurringOrderDetailsTemplate" />
<dw:ModuleHeader ID="dwHeaderModule" runat="server" ModuleSystemName="eCom_CustomerCenter" />

<!-- Limitation -->
<dw:GroupBox runat="server" Title="Shop" ID="LimitationGroupBox">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
        <!-- Shops -->
        <tr>
            <td valign="top">
                <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Show" />
            </td>
            <td>
                <input type="radio" runat="server" id="ShopRadioAll" name="ShopRadio" onclick="toggleShops();" />
                <label for="ShopRadioAll"><dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="All" /></label>
                <input type="radio" runat="server" id="ShopRadioSelected" name="ShopRadio" onclick="toggleShops();" />
                <label for="ShopRadioSelected"><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Selected" /></label>
            </td>
        </tr>
        <tr id="ShopSelectorRow">
            <td colspan="2">
                <dw:SelectionBox ID="ShopSelector" runat="server"  CssClass="std" />
                <span class="disableText"><dw:TranslateLabel runat="server" Text="At least one shop should be selected" /></span>
                <input type="hidden" name="ShopID" id="ShopID" value="" runat="server" />
            </td>
        </tr>
        <!-- Image pattern settings -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="Use image pattern settings from product catalog" />
            </td>
            <td>
                <dw:LinkManager runat="server" id="ImagePatternProductCatalog" EnablePageSelector="False" DisableFileArchive="True"></dw:LinkManager>
            </td>
        </tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxPaging" Title="Paging" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="dwTransPaging" runat="server" Text="Items per page" /></td>
			<td style="padding-left: 2px;"><%=Gui.SpacListExt(_intItemsPerPage, "ItemsPerPage", 1, 100, 1, "")%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="transPagingNext" Text="Next button" runat="server" /></td>
			<td><%=Gui.ButtonText("PagerNextButtonType", _pagerNextSelectedType, _pagerNextImage, _pagerNextText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="transPagingBack" Text="Prev button" runat="server" /></td>
			<td><%= Gui.ButtonText("PagerPrevButtonType", _pagerPrevSelectedType, _pagerPrevImage, _pagerPrevText)%></td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxOthers" Title="Bought from date settings" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><dw:TranslateLabel ID="labelBoughtFromDate" runat="server" Text="Bought from date" /></td>
			<td><dw:DateSelector runat="server" ID="BoughtFromDate" Name="BoughtFromDate" EnableViewState="false" AllowNeverExpire="false" IncludeTime="false" /></td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxDefaultView" Title="Default view" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><dw:TranslateLabel ID="labelDefaultView" runat="server" Text="Default View" /></td>
			<td>
				<select class="std" runat="server" id="DefaultView" name="DefaultView"></select>
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxDefaultMailAddress" Title="E-mail" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><dw:TranslateLabel ID="labelDefaultMailAddress" runat="server" Text="Afsender e-mail" /></td>
			<td><input runat="server" class="std" type="text" id="DefaultMailAddress" name="DefaultMailAddress" /></td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxMenuTexts" Title="Menu texts" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsMyOrders" runat="server" Text="My Orders" /></td>
			<td><%= Gui.ButtonText("TextMyOrders", _textMyOrdersType, _textMyOrdersImage, _textMyOrdersText)%></td>
		</tr>
		<tr id="rowTextMyQuotes" runat="server" style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="My Quotes" /></td>
			<td><%= Gui.ButtonText("TextMyQuotes", _textMyQuotesType, _textMyQuotesImage, _textMyQuotesText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsFrequentlyItems" runat="server" Text="Frequently bought items" /></td>
			<td><%= Gui.ButtonText("TextFrequentlyItems", _textFrequentlyItemsType, _textFrequentlyItemsImage, _textFrequentlyItemsText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsMyFavorites" runat="server" Text="My Lists" /></td>
			<td><%= Gui.ButtonText("TextMyFavorites", _textMyFavoritesType, _textMyFavoritesImage, _textMyFavoritesText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsSearch" runat="server" Text="Search" /></td>
			<td><%=Gui.ButtonText("TextSearch", _textSearchType, _textSearchImage, _textSearchText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsRMA" runat="server" Text="RMA" /></td>
			<td><%= Gui.ButtonText("TextRMA", _textRMAType, _textRMAImage, _textRMAText)%></td>
        </tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Saved cards" /></td>
			<td><%= Gui.ButtonText("TextCardTokens", _textCardTokensType, _textCardTokensImage, _textCardTokensText)%></td>
		</tr>
		<tr style="padding-top: 10px;">
			<td valign="top"><dw:TranslateLabel ID="labelTextsRecurringOrders" runat="server" Text="Recurring Orders" /></td>
			<td><%= Gui.ButtonText("TextRecurringOrders", _textRecurringOrdersType, _textRecurringOrdersImage, _textRecurringOrdersText)%></td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxLinks" Title="Links" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><% =Backend.Translate.Translate("Link")%></td>
			<td><% =Backend.Translate.Translate("Specific page")%></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("My Orders")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToMyOrders" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
		<tr id="rowLinkToMyQuotes" runat="server">
			<td><% =Backend.Translate.Translate("My Quotes")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToMyQuotes" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("Frequently bought items")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToFrequentlyItems" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("My Lists")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToMyFavorites" DisableFileArchive="true" DisableParagraphSelector="true" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("Public List")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToPublicFavorites" DisableFileArchive="true" EnablePageSelector="False"/></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("Search")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToSearch" DisableFileArchive="true" DisableParagraphSelector="true" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("RMA")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToRMA" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("RMA direct url")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToRMADirectUrl" DisableFileArchive="true" DisableParagraphSelector="true" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("Saved cards")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToCardTokens" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
		<tr>
			<td><% =Backend.Translate.Translate("Recurring orders")%></td>
			<td><dw:LinkManager runat="server" ID="LinkToRecurringorders" DisableFileArchive="true" DisableParagraphSelector="false" /></td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxTemplates" Title="Templates" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
			<!--<col width="100px" align="center" />-->
		</colgroup>
		<!--
		<tr>
			<td colspan="2">&nbsp;</td>
			<td>
				<% =Backend.Translate.Translate("Allow special")%>
			</td>
		</tr>
		-->
		<tr>
			<td><dw:TranslateLabel ID="labelMenuLayoutTemplate" runat="server" Text="Menu Layout" /></td>
			<td><dw:FileManager ID="fileMenuLayoutTemplate" runat="server" Name="MenuLayoutTemplate" /></td>
		</tr>				
		<tr>
			<td><dw:TranslateLabel ID="labelOrderListTemplate" runat="server" Text="Order List" /></td>
			<td><dw:FileManager ID="fileOrderListTemplate" runat="server" Name="OrderListTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelOrderDetailsTemplate" runat="server" Text="Order Details" /></td>
			<td><dw:FileManager ID="fileOrderDetailsTemplate" runat="server" Name="OrderDetailsTemplate" /></td>
		</tr>
		<tr id="rowQuoteListTemplate" runat="server">
			<td><dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Quote List" /></td>
			<td><dw:FileManager ID="fileQuoteListTemplate" runat="server" Name="QuoteListTemplate" /></td>
		</tr>
		<tr id="rowQuoteDetailsTemplate" runat="server">
			<td><dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Quote Details" /></td>
			<td><dw:FileManager ID="fileQuoteDetailsTemplate" runat="server" Name="QuoteDetailsTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelFrequentlyItemsTemplate" runat="server" Text="Frequently bought items" /></td>
			<td><dw:FileManager ID="fileFrequentlyItemsTemplate" runat="server" Name="FrequentlyItemsTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelFrequentlyItemsDetailsTemplate" runat="server" Text="Frequently bought items details" /></td>
			<td><dw:FileManager ID="fileFrequentlyItemsDetailsTemplate" runat="server" Name="FrequentlyItemsDetailsTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelOrderSearchTemplate" runat="server" Text="Order Search" /></td>
			<td><dw:FileManager ID="fileOrderSearchTemplate" runat="server" Name="OrderSearchTemplate" /></td>
			<!--<td><input runat="server" type="checkbox" name="specialOrderSearch" id="specialOrderSearch" /></td>-->
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelRMAListTemplate" runat="server" Text="RMA List" /></td>
			<td><dw:FileManager ID="fileRMAListTemplate" runat="server" Name="RMAListTemplate" /></td>
			<!--<td><input runat="server" type="checkbox" name="specialRMAList" id="specialRMAList" /></td>-->
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelRMADetailsTemplate" runat="server" Text="RMA Details" /></td>
			<td><dw:FileManager ID="fileRMADetailsTemplate" runat="server" Name="RMADetailsTemplate" /></td>
			<!--<td><input runat="server" type="checkbox" name="specialRMAEmail" id="specialRMAEmail" /></td>-->
		</tr>
		<!--<tr>
			<td><dw:TranslateLabel ID="labelRMAEmailTemplate" runat="server" Text="RMA E-mail" /></td>
			<td><dw:FileManager ID="fileRMAEmailTemplate" runat="server" Name="RMAEmailTemplate" /></td>
			<td><input runat="server" type="checkbox" name="specialRMADetail" id="specialRMADetail" /></td>
		</tr>-->
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Saved card List" /></td>
			<td><dw:FileManager ID="fileCardTokenListTemplate" runat="server" Name="CardTokenListTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelRecurringOrderListTemplate" runat="server" Text="Recurring order List" /></td>
			<td><dw:FileManager ID="fileRecurringOrderListTemplate" runat="server" Name="RecurringOrderListTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelRecurringOrderDetailsTemplate" runat="server" Text="Recurring order Details" /></td>
			<td><dw:FileManager ID="fileRecurringOrderDetailsTemplate" runat="server" Name="RecurringOrderDetailsTemplate" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelFavoritesListTemplate" runat="server" Text="My List" /></td>
			<td><dw:FileManager ID="fileFavoritesListTemplate" runat="server" Name="FavoritesListTemplate" /></td>
			<!--<td><input runat="server" type="checkbox" name="specialFavoritesList" id="specialFavoritesList" /></td>-->
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="labelSpecifyMailTemplate" runat="server" Text="Specify Mail" /></td>
			<td><dw:FileManager ID="fileSpecifyMailTemplate" Name="SpecifyMailTemplate" runat="server" /></td>
		</tr>		
		<tr>
			<td><dw:TranslateLabel ID="labelOrderMailTemplate" runat="server" Text="Order Mail" /></td>
			<td><dw:FileManager ID="fileOrderMailTemplate" Name="OrderMailTemplate" runat="server" /></td>
		</tr>		
	</table>
</dw:GroupBox>

<dw:GroupBox ID="grpboxEmailSettings" Title="My list email settings" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Email template" /></td>
			<td><dw:FileManager ID="fileFavListEmailTemplate" Name="FavListEmailTemplate" runat="server" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Subject" /></td>
			<td><input runat="server" class="std" type="text" id="FavListEmailSubject" name="FavListEmailSubject" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Sender name" /></td>
			<td><input runat="server" class="std" type="text" id="FavListEmailSenderName" name="FavListEmailSenderName" /></td>
		</tr>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Sender email" /></td>
			<td><input runat="server" class="std" type="text" id="FavListEmailSenderEmail" name="FavListEmailSenderEmail" /></td>
		</tr>
	</table>
</dw:GroupBox>
