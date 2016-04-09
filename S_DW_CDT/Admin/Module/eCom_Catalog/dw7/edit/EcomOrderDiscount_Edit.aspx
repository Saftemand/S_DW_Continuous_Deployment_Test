<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrderDiscount_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderDiscount_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
	<link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Controls/CustomSelector/CustomSelector.css" />
	<link rel="stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/ToolTip.css" />
	<link type="text/css" href="../css/EcomOrderDiscount_Edit.css" rel="stylesheet" />
	<script type="text/javascript" src="/Admin/Images/Controls/CustomSelector/CustomSelector.js"></script>
	<script type="text/javascript" src="/Admin/Images/Controls/EditableList/EditableListEditors.js"></script>
	<script type="text/javascript" src="../js/EcomOrderDiscount_Edit.js"></script>
	<script type="text/javascript">
		document.observe('dom:loaded', function () {
			Dynamicweb.eCommerce.OrderDiscounts.init();
		});
	</script>
</head>
<body>
	<form id="formOrderDiscount_edit" runat="server" defaultfocus="txName">
		<input id="Close" type="hidden" name="Close" value="0" />
		<div>
			<dw:Toolbar ID="ListBar1" runat="server" ShowEnd="false">
				<dw:ToolbarButton ID="SaveToolbarButton" runat="server" Divide="None" Image="Save"
					Text="Save" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.submit(false);">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="SaveAndCloseToolbarButton" runat="server" Divide="None" Image="SaveAndClose"
					Text="Save and Close" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.submit(true);">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="CloseToolbarButton" runat="server" Divide="None" Image="Cancel" Text="Cancel"
					OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.redirectToList();">
				</dw:ToolbarButton>
			</dw:Toolbar>
			<h2 class="subtitle"><%=Translate.Translate("Edit discount")%></h2>
		</div>
		<dw:StretchedContainer ID="OuterContainer" Stretch="Fill" Anchor="document" runat="server">
			<div class="clearfix">
				<div id="GeneralDiv">
					<dw:GroupBox ID="gbGeneral" Title="General" runat="server">
						<table>
							<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbName" Text="Name" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txName" CssClass="std field-name" runat="server" ClientIDMode="Static" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 107px; vertical-align: top;">
                                <dw:TranslateLabel ID="lbDescription" Text="Description" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txDescription" CssClass="std field-name" runat="server" TextMode="MultiLine" ClientIDMode="Static" Height="40" Rows="3" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="padding-bottom:5px;"> 
                                <dw:CheckBox ID="chkDiscountActive" FieldName="DiscountActive" runat="server"/>
                                <label for="DiscountActive">
                                    <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Active" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="padding-bottom:5px;"> 
                                <dw:CheckBox ID="chkDiscountAssignableFromProducts" FieldName="DiscountAssignableFromProducts" runat="server"/>
                                <label for="DiscountAssignableFromProducts">
                                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Assignable from product catalog" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel4" Text="Valid From" runat="server" CurrentPeriodOnly="False" />
                            </td>
                            <td colspan="2" >
                                <omc:DateSelector  runat="server" ID="dsValidFrom"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel6" Text="Valid To" runat="server" />
                            </td>
                            <td colspan="2" >
                                <omc:DateSelector  runat="server" ID="dsValidTo" AllowEmpty="False" CurrentPeriodOnly="False" />
                            </td>
                        </tr>
						</table>
					</dw:GroupBox>

					<dw:GroupBox ID="GroupBox7" Title="Discount" runat="server">
						<table>
							<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel7" Text="Apply as" runat="server" />
                                <a id="imageText" href="#" class="tooltip">
                                    <img id="applyAsImg" style="cursor: pointer;" alt="Help" src="/Admin/Images/Ribbon/Icons/Small/Help.png"/>
                                    <span>
                                        <strong>Order Discount (Inclusive):<br /> </strong> <%=Translate.Translate("This discount will be calculated after all other orderline discounts have been calculated, based on the discounted price.")%><br/>
                                        <strong>Order Discount (Exclusive):<br /> </strong><%=Translate.Translate("This discount will be calculated based on the orderprice before any other discounts have been added.")%><br/>
                                        <strong>Orderline Discount (Exclusive): <br /></strong><%=Translate.Translate("This discount will be calculated based on the the product before any other discounts have been added.")%><br/>
                                    </span>
                                </a>
                            </td>
                            <td>
                                <dw:RadioButton ID="rbOrderDiscountInclusive" runat="server" FieldName="ApplyAs" FieldValue="3"/>
                                <label for="ApplyAs3">
                                    <dw:TranslateLabel id="TranslateLabel23" Text="Order Discount (Inclusive)" runat="server" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <dw:RadioButton ID="rbOrderDiscountExcusive" runat="server" FieldName="ApplyAs" FieldValue="1"/>
                                <label for="ApplyAs1">
                                    <dw:TranslateLabel id="TranslateLabel29" Text="Order Discount (Exclusive)" runat="server" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <dw:RadioButton ID="rbOrderlineDiscount" runat="server" FieldName="ApplyAs" FieldValue="2"/>
                                <label for="ApplyAs2">
                                    <dw:TranslateLabel id="TranslateLabel30" Text="Orderline Discount (Exclusive)" runat="server" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 107px;vertical-align:top;">
                                <dw:TranslateLabel ID="TranslateLabel11" Text="Discount Type" runat="server" />
                            </td>
                            <td> 
                                <table>
                                    <tr>
                                        <td>
                                            <dw:RadioButton ID="rbAmount" runat="server" FieldName="DiscountType" FieldValue="1" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(1);" />
                                        </td>
                                        <td style="width:60px">
                                            <label for="DiscountType1">
                                                <dw:TranslateLabel id="TranslateLabel9" Text="Amount" runat="server" />
                                            </label>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr id="amountDiv" style="display:none;">
                                        <td></td>
                                        <td style="width:60px"> 
                                            <dw:TranslateLabel id="TranslateLabel26" Text="Amount" runat="server" />
                                        </td> 
                                        <td> 
                                            <omc:FloatingPointNumberSelector ID="numAmount" AllowNegativeValues="false" MinValue="0.00" MaxValue="100000000" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="currencyDiv" style="display:none;">
                                        <td></td>
                                        <td style="width:60px"> 
                                            <dw:TranslateLabel id="TranslateLabel27" Text="Currency" runat="server" />
                                        </td> 
                                        <td> 
                                            <select id="orderDiscountCurrency" class="std" name="orderDiscountCurrency" >
                                                <asp:Literal ID="ltCurrency" runat="server"></asp:Literal>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                          </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                               <table>
                                    <tr>
                                        <td>
                                            <dw:RadioButton ID="rbPercentage" runat="server" FieldName="DiscountType" FieldValue="2" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(2);" />
                                        </td>
                                        <td style="width:60px">
                                            <label for="DiscountType2">
                                                <dw:TranslateLabel id="TranslateLabel10" Text="Percentage" runat="server" />
                                            </label>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr id="percentageDiv" style="display:none;">
                                        <td></td>
                                        <td style="width:60px"> 
                                            <dw:TranslateLabel id="Percentage" Text="Percentage" runat="server" />
                                        </td>
                                        <td>
                                            <omc:FloatingPointNumberSelector ID="numPercentage" AllowNegativeValues="false" MinValue="0.00" MaxValue="100" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                 <table>
                                        <tr>
                                            <td>
                                               <dw:RadioButton ID="rbProduct" runat="server" FieldName="DiscountType" FieldValue="3" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(3);" />
                                            </td>
                                            <td style="width:60px">
                                                <label for="DiscountType3">
                                                    <dw:TranslateLabel id="TranslateLabel32" Text="Product" runat="server" />
                                                </label>
                                            </td>
                                        </tr>
                                        <tr id="productDiv" style="display:none;">
                                            <td></td>
                                            <td nowrap="nowrap">
                                                <input type="hidden" id="ID_ProductAsDiscount" runat="server" />
                                                <input type="hidden" id="VariantID_ProductAsDiscount" runat="server" />
                                                <input type="text" id="Name_ProductAsDiscount" class="std" runat="server"/>&nbsp;
                                                <img src="/Admin/images/Icons/Page_int.gif" onclick="javascript:Dynamicweb.eCommerce.OrderDiscounts.AddProduct('DW_REPLACE_ProductAsDiscount');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Produkter")%>" />
                                                <img src="/Admin/images/Icons/Page_Decline.gif" onclick="javascript:Dynamicweb.eCommerce.OrderDiscounts.RemoveProduct('ProductAsDiscount');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Slet")%>" />
                                            </td>
                                        </tr>
                                  </table>
                            </td>
                        </tr>
						<tr id="free-shiping-chb-cnt">
                            <td>
                            </td>
                            <td>
                               <table>
                                    <tr>
                                        <td>
                                            <dw:RadioButton ID="rbShipping" runat="server" FieldName="DiscountType" FieldValue="4" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showDiscountType(4);" />
                                        </td>
                                        <td>
                                            <label for="DiscountType4">
                                                <dw:TranslateLabel id="TranslateLabel35" Text="Free shipping" runat="server" />
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
						</table>
					</dw:GroupBox>
				</div>
				<% If Base.IsModuleInstalled("UserManagementFrontend") OrElse Base.IsModuleInstalled("UserManagementFrontendExtended") Then%>
				<dw:GroupBox ID="GroupBox1" Title="Users and Groups" runat="server">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel18" Text="User" runat="server" />
                            </td>
                            <td>
                                <dw:EditableListColumnUserEditor ID="UserID_CustomSelector" runat="server" ClientIDMode="Static"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel19" Text="User group" runat="server" />
                            </td>
                            <td>
                                <dw:EditableListColumnUserEditor ID="UserGroupID_CustomSelector"  runat="server" ClientIDMode="Static"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel17" Text="Customer number" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtCustomerNumber" CssClass="std field-name" runat="server" ClientIDMode="Static"/>
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>
				<%End If%>
				<dw:GroupBox ID="GroupBox5" Title="Total Price" runat="server">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel20" Text="Condition" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountPriceCondition" class="std" name="orderDiscountPriceCondition">
                                    <asp:Literal ID="ltCondition" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel21" Text="Total price" runat="server" />
                            </td>
                            <td>
                                <omc:FloatingPointNumberSelector ID="numTotalPrice" AllowNegativeValues="false"  MinValue="0.00" MaxValue="100000000" runat="server"/>
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>
				<dw:GroupBox ID="GroupBox2" Title="Product Catalog" runat="server" ClassName="product-catalog">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel2" Text="Shop" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountShop" class="std" name="orderDiscountShop">
                                    <asp:Literal ID="ltShops" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel1" Text="Language" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountLanguage" class="std" name="orderDiscountLanguage">
                                    <asp:Literal ID="ltLanguages" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 107px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel34" Text="Products and groups" runat="server" />                                
                                <a id="SmartSearchPerfomance" href="#" class="tooltip">
                                    <img id="SmartSearchWarning" style="cursor: pointer;" alt="Warning" src="/Admin/Images/Ribbon/Icons/Small/warning.png"/>
                                    <span>
                                        <strong><%=Translate.Translate("Potential performance issues!")%><br /> </strong> <%=Translate.Translate("When using smart searches, and only use cached smart searches")%><br/>
                                    </span>
                                </a>
                            </td>
                            <td class="epgs-cnt">
                                <de:ProductsAndGroupsSelector runat="server" ID="IncludedProductsAndGroupsSelector" Value = "[some]" ShowAllRadio="false" ShowNoneRadio="False" EnableSubItems="false" ShowSearches="true" CallerForm="formOrderDiscount_edit" Width="168px" Height="60px" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 107px; vertical-align: top;">
                                <dw:TranslateLabel ID="TranslateLabel33" Text="Excluded products" runat="server" />
                            </td>
                            <td class="epgs-cnt">
                                <de:ProductsAndGroupsSelector runat="server" ID="ExcludedProductsAndGroupsSelector" Value = "[some]" ShowAllRadio="false" ShowNoneRadio="False" EnableSubItems="false" CallerForm="formOrderDiscount_edit" Width="168px" Height="60px" />
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>
				<dw:GroupBox ID="GroupBox3" Title="Order" runat="server">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr id="OrderContextLine" runat="server">
                            <td style="width: 107px;">
                                <dw:TranslateLabel ID="TranslateLabel5" Text="Context" runat="server" />
                            </td>
                            <td>
                                <select id="orderContext" class="std" name="orderContext">
                                    <asp:Literal ID="ltOrderContext" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 107px;">
                                <dw:TranslateLabel ID="TranslateLabel12" Text="Country" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountCountry" class="std" name="orderDiscountCountry">
                                    <asp:Literal ID="ltCountry" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel13" Text="Shipping" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountShipping" class="std" name="orderDiscountShipping">
                                    <asp:Literal ID="ltShipping" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel14" Text="Payment" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountPayment" class="std" name="orderDiscountPayment">
                                    <asp:Literal ID="ltPayment" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>
				<dw:GroupBox ID="GroupBox4" Title="Product Quantity" runat="server">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel15" Text="Quantifier" runat="server" />
                            </td>
                            <td>
                                <select id="orderDiscountQuantifiery" class="std" name="orderDiscountQuantifier">
                                    <asp:Literal ID="ltQuantifier" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel16" Text="Product Quantity" runat="server" />
                            </td>
                            <td>
                               <omc:FloatingPointNumberSelector ID="numProductQuantity" AllowNegativeValues="false"  MinValue="1.00" MaxValue="100000000" runat="server"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="padding-bottom:5px;"> 
                                <dw:CheckBox ID="chApplyDiscountOnce" FieldName="ApplyDiscountOnce" runat="server"/>
                                <label for="ApplyDiscountOnce">
                                    <dw:TranslateLabel ID="TranslateLabel31" runat="server" Text="Apply discount only once" />
                                </label>
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>

				<dw:GroupBox ID="GroupBox6" Title="Fields and Voucher" runat="server">
					<table>
						<colgoup>
                            <col width="170px">
                            <col>
                        </colgroup>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel22" Text="Order field" runat="server" />
                            </td>
                            <td>
                                <select id="orderFields" class="std" name="orderFields" onchange="Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldsOption();">
                                    <asp:Literal ID="ltOrderField" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
                        <tr id="OrderFieldValueDiv" style="display:none;">
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel28" Text="Field value" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox ID="txOrderFieldValue" CssClass="std field-name" runat="server" ClientIDMode="Static"/>
                            </td>
                        </tr>
                        <tr id="rbOrderFieldValueDiv" style="display:none;">
                            <td>
                            </td>
                            <td>
                                <dw:RadioButton ID="rbOrderFieldValue" runat="server" FieldName="OrderFieldType" FieldValue="1" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldType(1);"/>
                                <label for="OrderFieldType1">
                                    <dw:TranslateLabel id="TranslateLabel24" Text="Order field value" runat="server" /><br />    
                                </label>                                
                                <asp:TextBox ID="txRadioOrderFieldValue" CssClass="std field-name" runat="server" ClientIDMode="Static" style="margin-left:25px"/>
                            </td>
                        </tr>
                        <tr id="VoucherListsDiv" style="display:none;">
                            <td>
                            </td>
                            <td style="padding-bottom:10px;">
                                <dw:RadioButton ID="rbVoucherLists" runat="server" FieldName="OrderFieldType" FieldValue="2" OnClientClick="Dynamicweb.eCommerce.OrderDiscounts.showOrderFieldType(2);"/>
                                <label for="OrderFieldType2">
                                    <dw:TranslateLabel id="TranslateLabel25" Text="Voucher list" runat="server" /><br />
                                </label>
                                <select id="orderDiscountVoucherList" class="std" name="orderDiscountVoucherList" style="margin-left:25px;" >
                                    <asp:Literal ID="ltVoucherLists" runat="server"></asp:Literal>
                                </select>
                            </td>
                        </tr>
					</table>
				</dw:GroupBox>
			</div>
			<input type="hidden" name="isCopy" id="isCopy" value="" runat="server" />
		</dw:StretchedContainer>
	</form>
</body>
<% 	Translate.GetEditOnlineScript()%>
</html>
