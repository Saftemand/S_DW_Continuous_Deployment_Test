<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UCOrderEdit.ascx.vb" Inherits="Dynamicweb.Admin.eComBackend.UCOrderEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register Assembly="Dynamicweb" Namespace="Dynamicweb.Extensibility" TagPrefix="de" %>


<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
    
    <style type="text/css">
        #ctl00_ContentHolder_UCOrderEdit_ProductEditScroll
        {
            background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;
        } 
    </style>    

    <dw:ControlResources runat ="server" IncludeUIStylesheet="true" MergeOutput="True">
        <Items>
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/orderEdit.js" />
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/css/orderEdit.css" />
        </Items>
    </dw:ControlResources>
    <input type="hidden" id="Cancel" name="Cancel"/>
    <input type="hidden" id="showEdit" name="showEdit"/>
    <input type="hidden" id="deleteOrderlineId" name="deleteOrderlineId"/>
    <input type="hidden" id="deletePartItemId" name="deletePartItemId"/>
    <input type="hidden" id="CurrencySymbol" runat="server"/>
    <input type="hidden" id="saveOrder" name="saveOrder"/>
    <input type="hidden" id="IsQuote" name="IsQuote" value="<%=IsQuote%>"/>
    <div style="min-width:1000px;overflow:hidden;">
    <span id="ProductWasDeletedAlert" style="display:none;"><%=Translate.JsTranslate("Product was deleted.")%></span> 

    <div onclick="CloseAllMenu();" id="CloseRightMenu" style="left: 0px; width: 0px;
        position: absolute; top: 0px; height: 0px;">
    </div>
    <dw:RibbonBar ID="RibbonBar" runat="server">
        <dw:RibbonBarTab ID="RibbonBarTab1" Name="Order" runat="server">
            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="btnSaveOrder" Text="Save" Image="Save" Size="Small" runat="server" ShowWait="true"
                    EnableServerClick="true" OnClientClick="$('saveOrder').value='true'" OnClick="Ribbon_Save">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="btnSaveAndCloseOrder" Text="Save and close" Image="SaveAndClose"
                    Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClientClick="$('saveOrder').value='true'" OnClick="Ribbon_SaveAndClose">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="btnResetSortOrder" Text="Close" Image="Cancel" Size="Small"
                    runat="server" OnClientClick="cancel();">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="btnDeleteDocument" Text="Delete" Image="DeleteDocument" Size="Small"
                    runat="server" EnableServerClick="true" OnClientClick=" if(!confirm(_deleteQuestion)) {return false;} " OnClick="Ribbon_Delete">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="ButtonCreateShippingDocuments" ImagePath="/Admin/Images/eCom/eCom_ShippingDocument_small.png" Size="Small"
                    Text="Create shipping documents" OnClientClick="createShippingDocuments();" runat="server">
                </dw:RibbonBarButton>

            </dw:RibbonBarGroup>
            
             <dw:RibbonBarGroup ID="RibbonBarGroup6" Name="View" runat="server">
                <dw:RibbonBarRadioButton ID="DetailsButton" Group="viewMode" Checked="true" Text="Details" Image="EditDocument"
                    Size="Small" runat="server" OnClientClick="changeViewToDetails();">
                </dw:RibbonBarRadioButton>
                 <dw:RibbonBarRadioButton ID="MiscellaneousButton" Group="viewMode" Text="Miscellaneous" Image="Module"
                    Size="Small" runat="server"  OnClientClick="changeView(2);">
                </dw:RibbonBarRadioButton>
                
                <dw:RibbonBarRadioButton runat="server" ID="LogButton" Group="viewMode" Text="Log" Image="Information" Size="Small" OnClientClick="changeView(3);" />
                                
                <dw:RibbonBarRadioButton runat="server" ID="EditOrderButton" Group="viewMode" Text="Edit" Image="EditGear" Size="Small" OnClientClick="changeViewToEdit();" />

                <dw:RibbonBarButton runat="server" ID="ShowHistory" Text="Show History" Image="Document" Size="Small" OnClientClick="showHistory();" />

            </dw:RibbonBarGroup>
            
            <dw:RibbonBarGroup ID="RibbonBarGroupNavigation" Name="Navigate orders" runat="server">
                <dw:RibbonBarButton ID="PreviousButton" Text="Previous" Image="NavigateLeft" Size="Large"
                    runat="server">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="NextButton" Text="Next" Image="NavigateRight" Size="Large"
                    runat="server">
                </dw:RibbonBarButton>
            </dw:RibbonBarGroup>
            
            <dw:RibbonBarGroup ID="RibbonBarGroup8" Name="State" runat="server">
                <dw:RibbonBarPanel ID="RibbonStatePanel" runat="server">
                    <dw:GroupDropDownList ID="OrderStateList" CssClass="NewUIinput" style="width: auto; margin-top: 3px;" runat="server" />
                </dw:RibbonBarPanel>
            </dw:RibbonBarGroup>
            
            <dw:RibbonBarGroup ID="RibbonBarGroupSettings" Name="Order settings" runat="server">
                <dw:RibbonBarButton ID="RibbonBarButton7" Text="Track & Trace" Image="Trace"
                    Size="Small" runat="server" OnClientClick="openTNTDialog('TrackAndTraceDialog', 'ctl00_ContentHolder_UCOrderEdit');" />
                    
                <dw:RibbonBarButton ID="RibbonBarButton8" Text="Transaction" Image="DocumentProperties"
                    Size="Small" runat="server" OnClientClick="openOrderDialog('PaymentDialog');" />
                    
            </dw:RibbonBarGroup>
          
            <dw:RibbonBarGroup ID="RibbonBarGroupCapture" Name="Capture" runat="server">
                <dw:RibbonBarButton ID="RibbonBarButton2" Text="Capture" ImagePath="/Admin/Images/eCom/eCom_Payment.gif"
                    Size="Large" runat="server" OnClientClick="openCaptureDialog();">
                </dw:RibbonBarButton>
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="RibbonBarGroup4" Name="Print" runat="server">
                <dw:RibbonBarButton ID="ButtonPrint" Image="Print" Size="Large" Text="Print" OnClientClick="printOrder();"
                    runat="server" />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="RibbonbarGroup5" runat="server" Name="Help">
                <dw:RibbonBarButton ID="btnHelp" runat="server" Text="Help" Image="Help" Size="Large"
                    OnClientClick="help();" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
        <dw:RibbonBarTab ID="RibbonBarTab2" Name="RMA" runat="server">
            <dw:RibbonBarGroup ID="RibbonBarGroup9" Name="RMA" runat="server">
                <dw:RibbonBarButton ID="btnRegisterNewRMA" runat="server" Text="Register new RMA" ImagePath="/Admin/Images/eCom/eCom_RMA_add.png" OnClientClick="registerNewRMA();" />
                <dw:RibbonBarButton ID="btnExistingRMAs" runat="server" Text="View existing RMAs" ImagePath="/Admin/Images/eCom/eCom_RMA_view.png" OnClientClick="dialog.show('ExistingRMAsDialog');" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
        <dw:RibbonBarTab ID="RibbonBarTab3" Name="Recurring" runat="server" Visible="false">
            <dw:RibbonBarGroup ID="RibbonBarGroup10" Name="Recurring" runat="server">
                <dw:RibbonBarButton runat="server" ID="PreviousDeliveries" Text="Previous deliveries" ImagePath="/Admin/Images/Ribbon/Icons/clock.png" Size="Large" />
                <dw:RibbonBarButton runat="server" ID="FutureDeliveries" Text="Future deliveries" ImagePath="/Admin/Images/Ribbon/Icons/clock_run.png" Size="Large" />
                <dw:RibbonBarButton runat="server" ID="CancelRecurringOrder" Text="Cancel recurring" ImagePath="/Admin/Images/Ribbon/Icons/clock_stop.png" Size="Large" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
    </dw:RibbonBar>
    </div>
     <dw:Infobar ID="errorBar" runat="server" Visible="false" TranslateMessage="False">
            </dw:Infobar>
     <dw:Infobar ID="GiftCardTransactionFailedInfo" runat="server" Visible="false" TranslateMessage="True" Type="Error" Message="Giftcard transaction failed"></dw:Infobar>
    <dw:Dialog 
        ID="ExistingRMAsDialog" 
        runat="server" 
        Title="Existing RMAs" 
        ShowCancelButton="false" 
        ShowClose="true" 
        ShowOkButton="true"
        OkAction="dialog.hide('ExistingRMAsDialog');" 
        UseTabularLayout="true" 
        HidePadding="true"
        Width="500">
        
        <dw:List runat="server" ID="ExistingRMAsList" ShowTitle="false" ShowPaging="false">
        </dw:List>
    </dw:Dialog>

    <dw:Dialog ID="ShowHistoryDialog" runat="server" IsIFrame="true" Title="Versioner" HidePadding="true" Width="600">
    </dw:Dialog>

    <dw:Dialog ID="ShowCompareDialog" runat="server" IsIFrame="true" Title="Compare" HidePadding="true" Width="800" iframeHeight="400">
    </dw:Dialog>

    <!-- Capture Start -->
    <dw:PopUpWindow ID="dlgCapture" Title="Capture order" AutoCenterProgress="true" TranslateTitle="true" ShowOkButton="false" ShowCancelButton="true" CancelText="Close" ShowHelpButton="false" 
                ShowClose="true" Width="450" Height="300" AutoReload="true" UseTabularLayout="true" runat="server" />
    <!-- Capture End -->
    
    <dw:Dialog ID="TrackAndTraceDialog" runat="server" Title="Delivery" ShowOkButton="true"
        ShowClose="true" OkAction="updateTNTDialog('TrackAndTraceDialog','ctl00_ContentHolder_UCOrderEdit');" Width="450"
        ShowCancelButton="true" CancelAction="cancelOrderDialog('TrackAndTraceDialog');">
        <dw:GroupBox ID="otntOldBox" runat="server" DoTranslation="true" Title="General" >
            <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                <tr>
                    <td width="170">
                        <%=Translate.Translate("Track & Trace number")%>
                    </td>
                    <td>
                        <asp:TextBox ID="OrderTrackTrace" CssClass="NewUIinput" Width="170" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <dw:GroupBox ID="GroupBox1" runat="server" DoTranslation="true" Title="Track & Trace">
            <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                <tr>
                    <td width="100">
                        <%=Translate.Translate("Track & Trace")%>
                    </td>
                    <td width="170">
                        <asp:DropDownList ID="otntSelectBox" CssClass="NewUIinput" DataValueField="ID" DataTextField="Name" onchange="otntSelectBox_selectedIndexChanged(this.value, false)" clientidmode="AutoID" Width="170" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td nowrap="nowrap" style="padding-left:5px">
                        <a onclick="showTNTUrlScheme()">
                        <img src="/Admin/Images/Ribbon/Icons/Small/information.png" alt=""></img>
                        <%= Translate.Translate("URL Scheme")%>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%= Translate.Translate("Parameters")%>
                        <br />
                        <input type='button' value='<%= Translate.Translate("Look up")%>' onclick='checkTNT()' style='width: 60px;' class='NewUIinput' />
                    </td>
                    <td colspan="2"> 
                        <div id="otntParametersDiv"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="otntLoadingDiv">
                            <img src="/Admin/Module/eCom_Catalog/images/ajaxloading_trans.gif" alt=""/><br /><br />
                        </div>
                    </td>
                    <td colspan="2"></td>
                </tr>
            </table>
        </dw:GroupBox>
    </dw:Dialog>
    
    <dw:Dialog ID="TNTUrlSchemeDialog" runat="server" Title="URL Scheme" 
        ShowClose="true" Width="400" ShowOkButton="true">
        <div id="otntURLDiv"></div>
    </dw:Dialog>

    <dw:Dialog ID="PaymentDialog" runat="server" Title="Payment" ShowOkButton="true"
        ShowClose="true" OkAction="updateOrderDialog('PaymentDialog');" Width="450" ShowCancelButton="true"
        CancelAction="cancelOrderDialog('PaymentDialog');">
        <asp:Literal ID="GatewayStatusOutput" runat="server"></asp:Literal>
        <div style='display: block;' id='OrderTransactionSection'>
            <dw:GroupBox ID="GroupBox3" runat="server" DoTranslation="true" Title="Transaktion">
                <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                    <tr>
                        <td>
                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                <colgroup>
                                    <col width="170" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaktions nummer")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransNumber" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaktions værdi")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransValue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaktions type")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransType" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaktions status")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaktions beløb")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransAmount" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td onclick="GetGatewayResult();">
                                        <%=Translate.Translate("Transaktions gateway")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransGateWay" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaction card type")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransCardType" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Transaction card number")%>
                                    </td>
                                    <td>
                                        <asp:Label ID="OrderTransCardNumber" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </dw:Dialog>
    
     <dw:Dialog 
        ID="addDiscountDialog" 
        runat="server" 
        Title="Add discount" 
        ShowCancelButton="true" 
        ShowClose="true" 
        ShowOkButton="true"
        OkAction="dialog.hide('addDiscountDialog');AddProductOrDiscount();" 
        UseTabularLayout="true" 
        HidePadding="true"
        Width="500">
         <br/>


			<div style="width:150px;float:left;">
				<%=translate.Translate("Discount description")%>
			</div>
			<div style="float:left;">
				<input type="text" style="width:200px" id="discountDescriptionTextField" name="discountDescriptionTextField" class="NewUIinput" value="<%=Translate.Translate("Discount") %>"/>
			</div>

			<br/>
			<br/>

			<div style="width:150px;float:left;">
				<%=translate.Translate("Discount amount")%>
			</div>
			<div style="float:left;">
				<input type="text" style="width:200px" id="discountAmountTextField" name="discountAmountTextField" class="NewUIinput"/>
			</div>

			<br/>
    </dw:Dialog>
  	<dw:Dialog
		runat="server"
		ID="EditProductDialog"
		Title="Add product / discount"
		ShowCancelButton="true"
		ShowClose="true"
		ShowOkButton="true"
		UseTabularLayout="true"
		IsModal="true"
		HidePadding="false"
		Width="500"
		CancelAction="dialog.hide('EditProductDialog');"
		OkAction="AddProductOrDiscount();"
		>

		<dw:GroupBox ID="GroupBox4" runat="server" DoTranslation="true" Title="Product">		
			<table>
				<tr>
					<td width="170"><dw:TranslateLabel runat="server" Text="Product" /></td>
					<td>
						<input type="hidden" id="ProductID" name="ProductId" />
						<input type="hidden" id="ID_ProductID" name="ID_ProductID" />
						<input type="hidden" id="VariantID_ProductID" name="VariantId_ProductID"/>
						<input type="text" id="Name_ProductID" class="NewUIinput" />
						<img src="/admin/images/ecom/eCom_Product_add_small.gif" onclick="window.open('/Admin/Module/eCom_Catalog/dw7/Edit/EcomGroupTree.aspx?CMD=ShowProd&AddCaller=1&caller=opener.document.forms.Form1.DW_REPLACE_ProductID&invokeOnChangeOnID=true', '', 'displayWindow,width=460,height=400,scrollbars=no');" alt="<%=Translate.JSTranslate("Add product")%>" />&nbsp;
					</td>
				</tr>
			</table>
		</dw:GroupBox>

		<dw:GroupBox ID="GroupBox2" runat="server" DoTranslation="true" Title="Discount">		
			<table>
				<tr>
					<td width="170"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Orderline text" /></td>
					<td>
						<input type="text" id="productDiscountDescriptionTextField" name="productDiscountDescriptionTextField" class="NewUIinput" />
					</td>
				</tr>
				<tr>
					<td width="170"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Amount" /></td>
					<td>
						<input type="text" id="productDiscountAmountTextField" name="productDiscountAmountTextField" class="NewUIinput" />
					</td>
				</tr>
			</table>
		</dw:GroupBox>

		<input type="hidden" id="DiscountParentOrderlineId" name="DiscountParentOrderlineId" />
		<input type="hidden" id="DiscountOrderLineId" name="DiscountOrderLineId" />

	</dw:Dialog>

    <dw:PopUpWindow ID="pwDialog" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" Title="Visitor details"
            ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="true" IsModal="True"
            ShowHelpButton="false" SnapToScreen="true" Width="1020" AutoCenterProgress="true" Height="510" runat="server" /> 

    <dw:PopUpWindow ID="giftCardTransactions" UseTabularLayout="true" TranslateTitle="true" Title="GiftCard Transactions"
            ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="True"
            ShowHelpButton="false" SnapToScreen="true" Width="620" AutoCenterProgress="true" Height="400" runat="server" /> 

    <dw:PopUpWindow ID="pwFutureDeliveries" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="800" 
            Height="530" iframeHeight="200" Title="Recurring Orders" TranslateTitle="true" ContentUrl="" HidePadding="true" 
            runat="server" AutoCenterProgress="true" ShowOkButton="true" ShowCancelButton="true" ShowClose="true" />

    <dw:PopUpWindow ID="pwPreviousDeliveries" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="1000" Height="600" iframeHeight="200"
            Title="Previous deliveries" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        
        
 
	<input type="hidden" id="AddingProductOrDiscount" name="AddingProductOrDiscount" value="false" />

    <asp:Panel runat="server" ID="TransactionWarnings" />
    
    <dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="VerticalOnly"
        Anchor="document" runat="server">
    

                    <div id="OrderEditTab1" class="tabDiv">
                        <div class="order_wr">
			                <fieldset class="order_field">
				                <legend class="gbTitle"><dw:TranslateLabel ID="lblGroupDetails" Text="Order details" runat="server" /></legend>
				                <div class="order_l">  <%=Translate.Translate("Order ID")%></div> 
				                <div class="order_rWidth"><strong><asp:Label ID="OrderID" runat="server"></asp:Label></strong> <asp:Label ID="OrderRecurringReference" runat="server" /> </div>                                
                                <div class="order_l" <%= HideEmpty(OrderIntegrationOrderID)%>> <%=Translate.Translate("Integration Order ID")%></div>
				                <div class="order_r" <%= HideEmpty(OrderIntegrationOrderID)%>> <asp:Label ID="OrderIntegrationOrderID" runat="server"></asp:Label></div>
				                <div class="order_l"> <%=Translate.Translate("Oprettet")%></div>  
				                <div class="order_r"> <asp:Label ID="OrderCreated" runat="server"></asp:Label></div>
                                <div id="PriceCalcDateDiv" runat="server">
				                    <div class="order_l"> <%=Translate.Translate("Price calculation date")%></div>  
				                    <div class="order_r"> <asp:Label ID="OrderPriceCalculationDate" runat="server"></asp:Label></div>                              
                                </div>
				                <div class="order_l" <%= HideEmpty(OrderCompleted)%>>  <%=Translate.Translate("Completed")%></div>
				                <div class="order_r" <%= HideEmpty(OrderCompleted)%>> <asp:Label ID="OrderCompleted" runat="server"></asp:Label></div>
				                <div class="order_l" <%= HideEmpty(OrderCreatedUserID)%>> <%=Translate.Translate("Created by user")%></div>
				                <div class="order_r" <%= HideEmpty(OrderCreatedUserID)%>> <asp:Label ID="OrderCreatedUserID" runat="server"></asp:Label></div>
                                <div class="order_l" <%= HideEmpty(OrderSecondaryUserID)%>> <%=Translate.Translate("On behalf of")%></div>
                                <div class="order_r" <%= HideEmpty(OrderSecondaryUserID)%>> <asp:Label ID="OrderSecondaryUserID" runat="server"></asp:Label></div>
				                <div class="order_l" <%= HideEmpty(ReplacementRmaId)%>> <%=Translate.Translate("Replacement for RMA")%></div>
				                <div class="order_r" <%= HideEmpty(ReplacementRmaId)%>> <asp:Label ID="ReplacementRmaId" runat="server"></asp:Label></div>
                                <div class="order_l" <%= HideEmpty(OrderRecurring)%>> <%=Translate.Translate("Recurring")%></div>  
                                <div class="order_rWidth" <%= HideEmpty(OrderRecurring)%>> <asp:Label ID="OrderRecurring" runat="server" /></div>                                                                 
			                </fieldset>
                            <div class="bill_wr" id="orderInfoEdit" style="display:none">
				                <fieldset class="order_field order_bill">
                                    <legend class="gbTitle"> <%=Translate.Translate("Billing")%></legend>
                                    <div class="order_l"> <%=Translate.Translate("Kunde nr.")%></div> 
				                    <div class="order_r"> <input type="text" ID="CustNumEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Navn")%></div> 
				                    <div class="order_r"> <input type="text" ID="CustFirmEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Title")%></div> 
                                    <div class="order_r">
                                        <input type="text" ID="CustPrefixEdit" runat="server" class="NewUIinput editInput" maxlength="255" />
                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("Name")%></div> 
                                    <div class="order_r">
                                        <input type="text" ID="CustNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" />
                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("Title")%></div> 
                                    <div class="order_r"> <input type="text" ID="CustTitleEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("First name")%></div> 
                                    <div class="order_r"> <input type="text" ID="CustFirstNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Middle name")%></div> 
                                    <div class="order_r"><input type="text" ID="CustMiddleNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Surname")%></div> 
                                    <div class="order_r"> <input type="text" ID="CustSurnameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Initials")%></div> 
                                    <div class="order_r">
                                        <input type="text" ID="CustInitialsEdit" runat="server" class="NewUIinput editInput" maxlength="255" />

                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("House number")%></div> 
                                    <div class="order_r"> <input type="text" ID="CustHouseNumberEdit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Adresse")%></div>
				                    <div class="order_r"> <input type="text" ID="CustAdr1Edit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Sec. adresse")%></div>
				                    <div class="order_r"> <input type="text" ID="CustAdr2Edit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Post nr.")%> & <%=Translate.Translate("By")%></div>
				                    <div class="order_r"> <input type="text" ID="CustZipEdit" runat="server" class="halfWidth NewUIinput"  maxlength="50"/>&nbsp;<input type="text" ID="CustCityEdit" runat="server" Class="halfWidth NewUIinput"  maxlength="255"/></div>
                                    <div class="order_l"> <%=Translate.Translate("Land")%></div>
				                    <div class="order_r"> <input type="text" ID="CustCountryEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%= Translate.Translate("Region")%></div>
				                    <div class="order_r"> <input type="text" ID="CustRegionEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Telefon")%></div>
				                    <div class="order_r"> <input type="text" ID="CustPhoneEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Fax")%></div>
				                    <div class="order_r"> <input type="text" ID="CustFaxEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Mobil")%></div>
				                    <div class="order_r"> <input type="text" ID="CustCellEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Email")%></div>
				                    <div class="order_r"> <input type="text" ID="CustEmailEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Reference nr.")%></div>
				                    <div class="order_r"> <input type="text" ID="CustRefIDEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("EAN nr.")%></div>
				                    <div class="order_r"> <input type="text" ID="CustEANEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("CVR nr.")%></div>
                                    <div class="order_r"> <input type="text" ID="CustVatRegEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                </fieldset>
				               <fieldset class="order_field order_bill2">
                                    <legend class="gbTitle"><%=Translate.Translate("Shipping")%></legend>
                                    <div class="order_l"> <%=Translate.Translate("Navn")%></div> 
				                   <div class="order_r"> <input type="text" ID="DelvFirmEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Title")%></div>
                                    <div class="order_r">
                                        <input type="text" ID="DelvPrefixEdit" runat="server" class="NewUIinput editInput" maxlength="255" />
                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("Att.")%></div>
                                    <div class="order_r">
                                        <input type="text" ID="DelvNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" />
                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("Title")%></div> 
                                    <div class="order_r"> <input type="text" ID="DelvTitleEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("First name")%></div> 
                                    <div class="order_r"> <input type="text" ID="DelvFirstNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Middle name")%></div> 
                                    <div class="order_r"><input type="text" ID="DelvMiddleNameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Surname")%></div>
                                    <div class="order_r"> <input type="text" ID="DelvSurnameEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Initials")%></div>
                                    <div class="order_r">
                                        <input type="text" ID="DelvInitialsEdit" runat="server" class="NewUIinput editInput" maxlength="255" />
                                    </div>
                                    <div class="order_l"> <%=Translate.Translate("House number")%></div> 
                                    <div class="order_r"> <input type="text" ID="DelvHouseNumberEdit" runat="server" class="NewUIinput editInput" maxlength="255" /> </div>
                                    <div class="order_l"> <%=Translate.Translate("Adresse")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvAdr1Edit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Sec. adresse")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvAdr2Edit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Post nr.")%> & <%=Translate.Translate("By")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvZipEdit" Class="halfWidth NewUIinput" runat="server"  maxlength="50"/>&nbsp;<input type="text" Class="halfWidth NewUIinput" ID="DelvCityEdit" runat="server" maxlength="255"/></div>
                                    <div class="order_l"> <%=Translate.Translate("Land")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvCountryEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%= Translate.Translate("Region")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvRegionEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Telefon")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvPhoneEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Fax")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvFaxEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Mobil")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvCellEdit" runat="server" class="NewUIinput editInput" maxlength="50" /></div>
                                    <div class="order_l"> <%=Translate.Translate("Email")%></div>
				                   <div class="order_r"> <input type="text" ID="DelvEmailEdit" runat="server" class="NewUIinput editInput" maxlength="255" /></div>
                                </fieldset>
                            </div>
                            <div class="bill_wrwr">
                                <div class="bill_wr" id="orderInfoShow">
				                    <fieldset class="order_field order_bill">
					                    <legend class="gbTitle"> <%=Translate.Translate("Billing")%></legend>
					                    <div class="order_l CustNum" <%= HideEmpty(CustNum) %> ><%=Translate.Translate("Kunde nr.")%></div> 
					                    <div class="order_r CustNum" <%= HideEmpty(CustNum) %> ><asp:Label ID="CustNum" runat="server"></asp:Label></div>
                                        <div class="order_l CustFirm" <%= HideEmpty(CustFirm) %> ><%=Translate.Translate("Navn")%></div> 
					                    <div class="order_r CustFirm" <%= HideEmpty(CustFirm)%> ><asp:Label ID="CustFirm" runat="server"></asp:Label></div>
                                        <div class="order_l CustAtt" <%= HideEmpty(CustAtt)%>><%=Translate.Translate("Att.")%></div> 
					                    <div class="order_r CustAtt" <%= HideEmpty(CustAtt)%>><asp:Label ID="CustAtt" runat="server"></asp:Label></div>

                                        <div class="order_l CustTitle" <%= HideEmpty(CustTitle)%>><%=Translate.Translate("Title")%></div> 
					                    <div class="order_r CustTitle" <%= HideEmpty(CustTitle)%>><asp:Label ID="CustTitle" runat="server"></asp:Label></div>
                                        <div class="order_l CustFirstName" <%= HideEmpty(CustFirstName)%>><%=Translate.Translate("First name")%></div> 
					                    <div class="order_r CustFirstName" <%= HideEmpty(CustFirstName)%>><asp:Label ID="CustFirstName" runat="server"></asp:Label></div>
                                        <div class="order_l CustMiddleName" <%= HideEmpty(CustMiddleName)%>><%=Translate.Translate("Middle name")%></div> 
					                    <div class="order_r CustMiddleName" <%= HideEmpty(CustMiddleName)%>><asp:Label ID="CustMiddleName" runat="server"></asp:Label></div>
                                        <div class="order_l CustSurnameName" <%= HideEmpty(CustSurnameName)%>><%=Translate.Translate("Surname")%></div> 
					                    <div class="order_r CustSurnameName" <%= HideEmpty(CustSurnameName)%>><asp:Label ID="CustSurnameName" runat="server"></asp:Label></div>

					                    <div class="order_l CustAdr1" <%= HideEmpty(CustAdr1)%>><%=Translate.Translate("Adresse")%></div>
					                    <div class="order_r CustAdr1" <%= HideEmpty(CustAdr1)%> ><asp:Label ID="CustAdr1" runat="server"></asp:Label></div>
                                        <div class="order_l CustAdr2" <%= HideEmpty(CustAdr2)%> ><%=Translate.Translate("Sec. adresse")%></div>
					                    <div class="order_r CustAdr2" <%= HideEmpty(CustAdr2)%> ><asp:Label ID="CustAdr2" runat="server"></asp:Label></div>
                                        <div class="order_l CustHouseNumber" <%= HideEmpty(CustHouseNumber)%>><%=Translate.Translate("House number")%></div> 
					                    <div class="order_r CustHouseNumber" <%= HideEmpty(CustHouseNumber)%>><asp:Label ID="CustHouseNumber" runat="server"></asp:Label></div>
					                    <div class="order_l CustZip" <%= HideEmpty(CustZip,CustCity)%> > <%=Translate.Translate("Post nr.")%> & <%=Translate.Translate("By")%></div>
					                    <div class="order_r CustZip" <%= HideEmpty(CustZip,CustCity)%> > <asp:Label ID="CustZip" runat="server"></asp:Label>&nbsp;<asp:Label ID="CustCity" runat="server"></asp:Label></div>
					                    <div class="order_l CustCountry" <%= HideEmpty(CustCountry)%> > <%=Translate.Translate("Land")%></div>
					                    <div class="order_r CustCountry" <%= HideEmpty(CustCountry)%> > <asp:Label ID="CustCountry" runat="server"></asp:Label></div>
					                    <div class="order_l CustRegion" <%= HideEmpty(CustRegion)%> > <%= Translate.Translate("Region")%></div>
					                    <div class="order_r CustRegion" <%= HideEmpty(CustRegion)%> > <asp:Label ID="CustRegion" runat="server"></asp:Label></div>
                                        <div class="order_l CustPhone" <%= HideEmpty(CustPhone)%> > <%=Translate.Translate("Telefon")%></div>
					                    <div class="order_r CustPhone" <%= HideEmpty(CustPhone)%> > <asp:Label ID="CustPhone" runat="server"></asp:Label></div>
                                        <div class="order_l CustFax" <%= HideEmpty(CustFax)%> > <%=Translate.Translate("Fax")%></div>
					                    <div class="order_r CustFax" <%= HideEmpty(CustFax)%> ><asp:Label ID="CustFax" runat="server"></asp:Label></div>
                                        <div class="order_l CustCell" <%= HideEmpty(CustCell)%> ><%=Translate.Translate("Mobil")%></div>
					                    <div class="order_r CustCell" <%= HideEmpty(CustCell)%> > <asp:Label ID="CustCell" runat="server"></asp:Label></div>
                                        <div class="order_l CusteMail" <%= HideEmpty(CustEmail)%> > <%=Translate.Translate("Email")%></div>
					                    <div class="order_r CusteMail" <%= HideEmpty(CustEmail)%> > <asp:Label ID="CustEmail" runat="server"></asp:Label></div>
                                        <div class="order_l CustRefId" <%= HideEmpty(CustRefID)%> > <%=Translate.Translate("Reference nr.")%></div>
					                    <div class="order_r CustRefId" <%= HideEmpty(CustRefID)%> > <asp:Label ID="CustRefID" runat="server"></asp:Label></div>
                                        <div class="order_l CustEan" <%= HideEmpty(CustEAN)%> > <%=Translate.Translate("EAN nr.")%></div>
					                    <div class="order_r CustEan" <%= HideEmpty(CustEAN)%> ><asp:Label ID="CustEAN" runat="server"></asp:Label></div>
                                        <div class="order_l CustVatReg" <%= HideEmpty(CustVatReg)%> ><%=Translate.Translate("CVR nr.")%></div>
					                    <div class="order_r CustVatReg" <%= HideEmpty(CustVatReg)%> > <asp:Label ID="CustVatReg" runat="server"></asp:Label></div>
				                    </fieldset>
				                    <fieldset class="order_field order_bill2">
					                    <legend class="gbTitle"><%=Translate.Translate("Shipping")%></legend>
					                    <div class="order_l DelvFirm" <%= HideEmpty(DelvFirm)%> > <%=Translate.Translate("Navn")%></div> 
					                    <div class="order_r DelvFirm" <%= HideEmpty(DelvFirm)%> > <asp:Label ID="DelvFirm" runat="server"></asp:Label></div>
					                    <div class="order_l DelvAtt" <%= HideEmpty(DelvAtt)%> > <%=Translate.Translate("Att.")%></div>
					                    <div class="order_r DelvAtt" <%= HideEmpty(DelvAtt)%> > <asp:Label ID="DelvAtt" runat="server"></asp:Label></div>

                                        <div class="order_l DelvTitle" <%= HideEmpty(DelvTitle)%>><%=Translate.Translate("Title")%></div> 
					                    <div class="order_r DelvTitle" <%= HideEmpty(DelvTitle)%>><asp:Label ID="DelvTitle" runat="server"></asp:Label></div>
                                        <div class="order_l DelvFirstName" <%= HideEmpty(DelvFirstName)%>><%=Translate.Translate("First name")%></div> 
					                    <div class="order_r DelvFirstName" <%= HideEmpty(DelvFirstName)%>><asp:Label ID="DelvFirstName" runat="server"></asp:Label></div>
                                        <div class="order_l DelvMiddleName" <%= HideEmpty(DelvMiddleName)%>><%=Translate.Translate("Middle name")%></div> 
					                    <div class="order_r DelvMiddleName" <%= HideEmpty(DelvMiddleName)%>><asp:Label ID="DelvMiddleName" runat="server"></asp:Label></div>
                                        <div class="order_l DelvSurnameName" <%= HideEmpty(DelvSurnameName)%>><%=Translate.Translate("Surname")%></div> 
					                    <div class="order_r DelvSurnameName" <%= HideEmpty(DelvSurnameName)%>><asp:Label ID="DelvSurnameName" runat="server"></asp:Label></div>

					                    <div class="order_l DelvAdr1" <%= HideEmpty(DelvAdr1)%> > <%=Translate.Translate("Adresse")%></div>
					                    <div class="order_r DelvAdr1" <%= HideEmpty(DelvAdr1)%> > <asp:Label ID="DelvAdr1" runat="server"></asp:Label></div>
					                    <div class="order_l DelvAdr2" <%= HideEmpty(DelvAdr2)%> > <%=Translate.Translate("Sec. adresse")%></div>
					                    <div class="order_r DelvAdr2" <%= HideEmpty(DelvAdr2)%> > <asp:Label ID="DelvAdr2" runat="server"></asp:Label></div>
                                        <div class="order_l DelvHouseNumber" <%= HideEmpty(DelvHouseNumber)%>><%=Translate.Translate("House number")%></div> 
					                    <div class="order_r DelvHouseNumber" <%= HideEmpty(DelvHouseNumber)%>><asp:Label ID="DelvHouseNumber" runat="server"></asp:Label></div>
					                    <div class="order_l DelvZip" <%= HideEmpty(DelvZip,DelvCity)%> > <%=Translate.Translate("Post nr.")%> & <%=Translate.Translate("By")%></div>
					                    <div class="order_r DelvZip" <%= HideEmpty(DelvZip,DelvCity)%> > <asp:Label ID="DelvZip" runat="server"></asp:Label>&nbsp;<asp:Label ID="DelvCity" runat="server"></asp:Label></div>
					                    <div class="order_l DelvCountry" <%= HideEmpty(DelvCountry)%> > <%=Translate.Translate("Land")%></div>
					                    <div class="order_r DelvCountry" <%= HideEmpty(DelvCountry)%> > <asp:Label ID="DelvCountry" runat="server"></asp:Label></div>
					                    <div class="order_l DelvRegion" <%= HideEmpty(DelvRegion)%> > <%= Translate.Translate("Region")%></div>
					                    <div class="order_r DelvRegion" <%= HideEmpty(DelvRegion)%> > <asp:Label ID="DelvRegion" runat="server"></asp:Label></div>
					                    <div class="order_l DelvPhone" <%= HideEmpty(DelvPhone)%> ><%=Translate.Translate("Telefon")%></div>
					                    <div class="order_r DelvPhone" <%= HideEmpty(DelvPhone)%> ><asp:Label ID="DelvPhone" runat="server"></asp:Label></div>
					                    <div class="order_l DelvFax" <%= HideEmpty(DelvFax)%> ><%=Translate.Translate("Fax")%></div>
					                    <div class="order_r DelvFax" <%= HideEmpty(DelvFax)%> > <asp:Label ID="DelvFax" runat="server"></asp:Label></div>
					                    <div class="order_l DelvCell" <%= HideEmpty(DelvCell)%> > <%=Translate.Translate("Mobil")%></div>
					                    <div class="order_r DelvCell" <%= HideEmpty(DelvCell)%> > <asp:Label ID="DelvCell" runat="server"></asp:Label></div>
					                    <div class="order_l DelvEmail" <%= HideEmpty(DelvEmail)%> ><%=Translate.Translate("Email")%></div>
					                    <div class="order_r DelvEmail" <%= HideEmpty(DelvEmail)%> > <asp:Label ID="DelvEmail" runat="server"></asp:Label></div>
				                    </fieldset>
                                </div>
                            </div>
                                                       

                          <fieldset class="order_field" style="display:inline-block;">
            				<legend class="gbTitle"><dw:TranslateLabel ID="lblGroupItems" Text="Order items" runat="server" /></legend>
                              <div class="order_items" id="OrderItemsShow">
                                  <dw:List runat="server" OnRowExpand="OnRowExpand" ID="OrderLines" ShowTitle="false" ShowPaging="true">
                                      <Columns>
                                          <dw:ListColumn ID="colnum" runat="server" Name="Number" Width="120" />
                                          <dw:ListColumn ID="colname" runat="server" Name="Name" Width="341" />
                                          <dw:ListColumn ID="colqty" runat="server" Name="Quantity" HeaderAlign="Center" ItemAlign="Center" Width="50" />
                                          <dw:ListColumn ID="colunit" runat="server" Name="Unit price" HeaderAlign="Right" ItemAlign="Right" Width="90" />
                                          <dw:ListColumn ID="colamount" runat="server" Name="Total price" HeaderAlign="Right" ItemAlign="Right" Width="90" />
                                          <dw:ListColumn runat="server" ID="colremove" ClientIDMode="AutoID" HeaderAlign="Right" ItemAlign="Right" Width="15" />
                                      </Columns>
                                </dw:List>
                                                            <div class="editControls" style="display:none;width:100%; " align="right">
                            <img src="/admin/images/ecom/eCom_Discounts_add_small.gif" ID="addDiscountButton" OnClick="dialog.show('addDiscountDialog');" alt="<%=Translate.JSTranslate("Add discount")%>"/>
									<img src="/admin/images/ecom/eCom_Product_add_small.gif" onclick="dialog.show('EditProductDialog');" />&nbsp;
                            </div>

                                <dw:ContextMenu ID="OrderLineContext" runat="server">
                                    <dw:ContextMenuButton ID="editProductButton" runat="server" ImagePath="/Admin/Images/eCom/eCom_Product_small.gif"
                                                            Text="Go to product" OnClientClick="showProduct();" />
                                    <dw:ContextMenuButton ID="pageButton" runat="server" ImagePath="/Admin/Images/Icons/Page_open.gif"
                                                            Text="Vis side" OnClientClick="showPage();" />
                                </dw:ContextMenu>

                                <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"><%=Translate.Translate("Total purchase price excluding VAT and taxes")%></div>								
					    	        <div class="order_item3"></div>								
					         	    <div class="order_item4"></div>								
					        	    <div class="order_item5 ">
					        	         <asp:label ID="totalBeforePriceWithoutVATAndTax" runat="server"></asp:label>
					        	    </div>
				        	    </div>
                                <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"><%=Translate.Translate("Total purchase price excluding taxes")%></div>								
					    	        <div class="order_item3"></div>								
					         	    <div class="order_item4"></div>								
					        	    <div class="order_item5 ">
					        	         <asp:label ID="totalBeforePriceWithoutTax" runat="server"></asp:label>
					        	    </div>
				        	    </div>                                                    
                                <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"><%=Translate.Translate("Total purchase price excluding VAT")%></div>								
					    	        <div class="order_item3"></div>								
					         	    <div class="order_item4"></div>								
					        	    <div class="order_item5 ">
					        	         <asp:label ID="totalBeforePriceWithoutVAT" runat="server"></asp:label>
					        	    </div>
				        	    </div>
				          	    <div class="order_item_foot">
				        		    <div class="order_item1"></div>		
					    	        <div class="order_item2"> <%=Translate.Translate("Betaling")%>
                                                                    <%  If Not IsNothing(order) andalso Not String.IsNullOrEmpty(order.PaymentMethod) Then%>
                                                                    :&nbsp;<span class="disableText" style="font-size: 9px;">(<%=order.PaymentMethod%>)</span>
                                                                    <%End If%></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <asp:label ID="totalPaymentFeePrice" runat="server"></asp:label>
                                    </div>
					            </div>
				    	            <div class="order_item_foot">
				    		        <div class="order_item1"></div>		
				    		        <div class="order_item2"><%=Translate.Translate("Forsendelse")%>
                                                                    <%  If Not IsNothing(order) AndAlso Not String.IsNullOrEmpty(order.ShippingMethod) Then%>
                                                                    :&nbsp;<span class="disableText" style="font-size: 9px;">(<%=order.ShippingMethod%>)</span>
                                                                    <%End If%></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <asp:label ID="totalShippingFeePrice" runat="server"></asp:label>
                                    </div>
				    	        </div>
				    	        <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"> <%=Translate.Translate("Subtotal ex. moms")%></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
    				    	        <div class="order_item5">
					    	            <asp:label ID="totalPriceWithoutVAT" runat="server"></asp:label>
                                    </div>
				    	        </div>
				    	        <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"> <%=Translate.Translate("Moms")%></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <asp:label ID="totalPriceVAT" runat="server"></asp:label>
                                    </div>
					            </div>
					            <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"><strong> <%=Translate.Translate("Total inkl. moms")%></strong></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <strong><asp:label ID="totalPriceFormatted" runat="server"></asp:label></strong>
                                    </div>
				    	        </div>
                                <%If Not IsNothing(order) AndAlso order.ExternalPaymentFee > 0 Then%>
				          	    <div class="order_item_foot">
				        		    <div class="order_item1"></div>		
					    	        <div class="order_item2"> <%=Translate.Translate("External payment fee")%></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <asp:label ID="externalPaymentFee" runat="server"></asp:label>
                                    </div>
					            </div>
					            <div class="order_item_foot">
					    	        <div class="order_item1"></div>		
					    	        <div class="order_item2"><strong> <%=Translate.Translate("Total price including VAT and external fees")%></strong></div>								
					    	        <div class="order_item3"></div>								
					    	        <div class="order_item4"></div>								
					    	        <div class="order_item5">
					    	            <strong><asp:label ID="totalPriceWithExternalFees" runat="server"></asp:label></strong>
                                    </div>
				    	        </div>
                                <%End If%>
			    	        </div>
		    	        </fieldset>

                        <fieldset class="order_field" id="AdditionalInfoFld_set" style="width: 738px; display:inline-block;" runat="server">
            				<legend class="gbTitle"><dw:TranslateLabel Text="Additional information" runat="server" /></legend>
                            <div id="orderFieldsContainer">
                                <asp:Literal ID="OrderFieldList" runat="server"></asp:Literal>
                            </div>
                        </fieldset>
                        </div>

                        <br />
                    </div>
                    <div id="OrderEditTab2" style="display: none;">
                        <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%;'>
                            <tr>
                                <td>
                                    <fieldset style='width: 100%; margin: 5px;'>
                                        <legend class="gbTitle"><dw:TranslateLabel ID="lblGroupData" Text="Ordre data" runat="server" /></legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Standard moms")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderVAT" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                     
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Køb i shop")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderShop" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("IP")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderIp" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="OrderReferrerTD" runat="server">
                                                            <td width="170">
                                                                <%=Translate.Translate("Reference")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderReferrer" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Step")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderStep" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
														<tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Eksporteret")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderIsExported" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Order context name")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderContextName" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>

                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset style='width: 100%; margin: 5px;'>
                                        <legend class="gbTitle"><dw:TranslateLabel Text="Kommentar" runat="server" /></legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td width="170" valign="top">
                                                                <%=Translate.Translate("Ordre kommentar")%>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="OrderComment" runat="server" CssClass="NewUIinput" TextMode="MultiLine"
                                                                    Columns="120" Rows="6" style="width:450px;"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170" valign="top">
                                                                <%=Translate.Translate("Kunde kommentar")%>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="OrderCustomerComment" CssClass="NewUIinput" runat="server" TextMode="MultiLine"
                                                                    Columns="120" Rows="6" style="width:450px;"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset style='width: 100%; margin: 5px;'>
                                        <legend class="gbTitle"><dw:TranslateLabel Text="Valuta" runat="server" /></legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Navn")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderCurrName" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Faktor")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderCurrFactor" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <%=Translate.Translate("Kode")%>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="OrderCurrCode" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                        <br>
                    </div>
                    <div id="OrderEditTab3" style="display:none">
                        <dw:List runat="server" ID="OrderLogList" 
                                 NoItemsMessage="There are no entries. Only cart v2 uses this log system"
                                 PageSize="15"
                                 Title="Order log"
                                 >
                                 
                            <Columns>
                                <dw:ListColumn ID="OrderLogTimeColumn" runat="server" Name="Time" EnableSorting="true" TranslateName="true" Width="170" DateFormat="ddd',' dd MMM yyyy HH':'mm':'ss"  />
                                <dw:ListColumn ID="OrderLogMessageColumn" runat="server" Name="Message" EnableSorting="true" TranslateName="true" />
                            </Columns>
                        </dw:List>
                    
                    </div>
                   
        
    </dw:StretchedContainer>
    <iframe name="EcomUpdator" id="EcomUpdator" width="1" height="1" tabindex="-1" align="right"
        marginwidth="0" marginheight="0" frameborder="0" src="/Admin/Module/eCom_Catalog/dw7/edit/EcomUpdator.aspx" border="0">
    </iframe>
    <asp:Literal ID="OrderLineMenuBlock" runat="server"></asp:Literal>
    <asp:Literal ID="GatewayResultBlock" runat="server"></asp:Literal>
    <input type="hidden" id="BackUrl" runat="server" />
    <input type="hidden" id="BackUserID" runat="server" />
    <input type="hidden" id="SelectedShopID" runat="server" clientidmode="Static" />
    <input type="hidden" name="OrderListPageNumber" value="<%=orderListPageNumber %>" />
    <input type="hidden" id="otntParameters" runat="server" clientidmode="AutoID" />

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>