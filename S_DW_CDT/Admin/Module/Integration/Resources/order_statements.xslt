<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<Order>
			<xsl:apply-templates select="Orders/Order | Orders/Order/OrderLines/OrderLine" />
		</Order>	
	</xsl:template>
	<xsl:template match="/Orders/Order">
			<id>
				<xsl:value-of select="OrderID"/>
			</id>
			<shopid>
				<xsl:value-of select="OrderShopID"/>
			</shopid>

			<xsl:choose>
				<xsl:when test="@delete = true">
					<insert />
					<update />
					<delete>
					       DELETE FROM EcomOrders WHERE OrderLineID  = '<xsl:value-of select="OrderID"/>' ;
				        </delete>
				</xsl:when>
			<xsl:otherwise>
			<insert>
			            INSERT INTO
			            EcomOrders
			            (
			            [OrderID]
			           ,[OrderShopID]
			           ,[OrderDate]
			           ,[OrderModified]
			           ,[OrderComplete]
			           ,[OrderDeleted]
			           ,[OrderStateID]
			           ,[OrderVAT]
			           ,[OrderIP]
			           ,[OrderReferrer]
			           ,[OrderTransactionValue]
			           ,[OrderTransactionType]
			           ,[OrderTransactionStatus]
			           ,[OrderTransactionAmount]
			           ,[OrderTransactionPayGatewayCode]
			           ,[OrderTrackTraceNumber]
			           ,[OrderShippingMethod]
			           ,[OrderShippingMethodFee]
			           ,[OrderPaymentMethod]
			           ,[OrderPaymentMethodFee]
			           ,[OrderSalesDiscount]
			           ,[OrderCurrencyName]
			           ,[OrderCurrencyRate]
			           ,[OrderCurrencyCode]
			           ,[OrderCart]
			           ,[OrderFieldsXML]
			           ,[OrderReSendEmail]
			           ,[OrderCustomerNumber]
			           ,[OrderCustomerCompany]
			           ,[OrderCustomerName]
			           ,[OrderCustomerAddress]
			           ,[OrderCustomerAddress2]
			           ,[OrderCustomerZip]
			           ,[OrderCustomerCity]
			           ,[OrderCustomerCountry]
			           ,[OrderCustomerRegion]
			           ,[OrderCustomerPhone]
			           ,[OrderCustomerFax]
			           ,[OrderCustomerEmail]
			           ,[OrderCustomerCell]
			           ,[OrderCustomerRefID]
			           ,[OrderCustomerEAN]
			           ,[OrderCustomerVatRegNumber]
			           ,[OrderDeliveryCompany]
			           ,[OrderDeliveryName]
			           ,[OrderDeliveryAddress]
			           ,[OrderDeliveryAddress2]
			           ,[OrderDeliveryZip]
			           ,[OrderDeliveryCity]
			           ,[OrderDeliveryCountry]
			           ,[OrderDeliveryRegion]
			           ,[OrderDeliveryPhone]
			           ,[OrderDeliveryFax]
			           ,[OrderDeliveryEmail]
			           ,[OrderDeliveryCell]
			           ,[OrderTotalPrice]
			           ,[OrderComment]
			           ,[OrderCustomerComment]
			           ,[OrderWeight]
			           ,[OrderVolume]
			           ,[OrderPriceWithVAT]
			           ,[OrderPriceWithoutVAT]
			           ,[OrderPriceVAT]
			           ,[OrderPriceVATPercent]
			           ,[OrderShippingFeeWithVAT]
			           ,[OrderShippingFeeWithoutVAT]
			           ,[OrderShippingFeeVAT]
			           ,[OrderShippingFeeVATPercent]
			           ,[OrderPaymentFeeWithVAT]
			           ,[OrderPaymentFeeWithoutVAT]
			           ,[OrderPaymentFeeVAT]
			           ,[OrderPaymentFeeVATPercent]
			           ,[OrderPriceBeforeFeesWithVAT]
			           ,[OrderPriceBeforeFeesWithoutVAT]
			           ,[OrderPriceBeforeFeesVAT]
			           ,[OrderPriceBeforeFeesVATPercent]
			           ,[OrderCustomerAccessUserID]
			           ,[OrderCustomerAccessUserUserName]
			           ,[OrderShippingMethodID]
			           ,[OrderPaymentMethodID]
			           ,[OrderGatewayResult]
			           ,[OrderStepNum]
			           ,[OrderTransactionNumber]
			           ,[OrderCustomerCountryCode]
			           ,[OrderDeliveryCountryCode]
			           ,[OrderStepHistory]
			           ,[OrderLanguageID]
				    )
				    VALUES(
			            '<xsl:value-of select="OrderID"/>',
			           '<xsl:value-of select="OrderShopID"/>',
			           '<xsl:value-of select="OrderDate"/>',
			           '<xsl:value-of select="OrderModified"/>',
			           '<xsl:value-of select="OrderComplete"/>',
			           '<xsl:value-of select="OrderDeleted"/>',
			           '<xsl:value-of select="OrderStateID"/>',
			           '<xsl:value-of select="OrderVAT"/>',
			           '<xsl:value-of select="OrderIP"/>',
			           '<xsl:value-of select="OrderReferrer"/>',
			           '<xsl:value-of select="OrderTransactionValue"/>',
			           '<xsl:value-of select="OrderTransactionType"/>',
			           '<xsl:value-of select="OrderTransactionStatus"/>',
			           '<xsl:value-of select="OrderTransactionAmount"/>',
			           '<xsl:value-of select="OrderTransactionPayGatewayCode"/>',
			           '<xsl:value-of select="OrderTrackTraceNumber"/>',
			           '<xsl:value-of select="OrderShippingMethod"/>',
			           '<xsl:value-of select="OrderShippingMethodFee"/>',
			           '<xsl:value-of select="OrderPaymentMethod"/>',
			           '<xsl:value-of select="OrderPaymentMethodFee"/>',
			           '<xsl:value-of select="OrderSalesDiscount"/>',
			           '<xsl:value-of select="OrderCurrencyName"/>',
			           '<xsl:value-of select="OrderCurrencyRate"/>',
			           '<xsl:value-of select="OrderCurrencyCode"/>',
			           '<xsl:value-of select="OrderCart"/>',
			           '<xsl:value-of select="OrderFieldsXML"/>',
			           '<xsl:value-of select="OrderReSendEmail"/>',
			           '<xsl:value-of select="OrderCustomerNumber"/>',
			           '<xsl:value-of select="OrderCustomerCompany"/>',
			           '<xsl:value-of select="OrderCustomerName"/>',
			           '<xsl:value-of select="OrderCustomerAddress"/>',
			           '<xsl:value-of select="OrderCustomerAddress2"/>',
			           '<xsl:value-of select="OrderCustomerZip"/>',
			           '<xsl:value-of select="OrderCustomerCity"/>',
			           '<xsl:value-of select="OrderCustomerCountry"/>',
			           '<xsl:value-of select="OrderCustomerRegion"/>',
			           '<xsl:value-of select="OrderCustomerPhone"/>',
			           '<xsl:value-of select="OrderCustomerFax"/>',
			           '<xsl:value-of select="OrderCustomerEmail"/>',
			           '<xsl:value-of select="OrderCustomerCell"/>',
			           '<xsl:value-of select="OrderCustomerRefID"/>',
			           '<xsl:value-of select="OrderCustomerEAN"/>',
			           '<xsl:value-of select="OrderCustomerVatRegNumber"/>',
			           '<xsl:value-of select="OrderDeliveryCompany"/>',
			           '<xsl:value-of select="OrderDeliveryName"/>',
			           '<xsl:value-of select="OrderDeliveryAddress"/>',
			           '<xsl:value-of select="OrderDeliveryAddress2"/>',
			           '<xsl:value-of select="OrderDeliveryZip"/>',
			           '<xsl:value-of select="OrderDeliveryCity"/>',
			           '<xsl:value-of select="OrderDeliveryCountry"/>',
			           '<xsl:value-of select="OrderDeliveryRegion"/>',
			           '<xsl:value-of select="OrderDeliveryPhone"/>',
			           '<xsl:value-of select="OrderDeliveryFax"/>',
			           '<xsl:value-of select="OrderDeliveryEmail"/>',
			           '<xsl:value-of select="OrderDeliveryCell"/>',
			           '<xsl:value-of select="OrderTotalPrice"/>',
			           '<xsl:value-of select="OrderComment"/>',
			           '<xsl:value-of select="OrderCustomerComment"/>',
			           '<xsl:value-of select="OrderWeight"/>',
			           '<xsl:value-of select="OrderVolume"/>',
			           '<xsl:value-of select="OrderPriceWithVAT"/>',
			           '<xsl:value-of select="OrderPriceWithoutVAT"/>',
			           '<xsl:value-of select="OrderPriceVAT"/>',
			           '<xsl:value-of select="OrderPriceVATPercent"/>',
			           '<xsl:value-of select="OrderShippingFeeWithVAT"/>',
			           '<xsl:value-of select="OrderShippingFeeWithoutVAT"/>',
			           '<xsl:value-of select="OrderShippingFeeVAT"/>',
			           '<xsl:value-of select="OrderShippingFeeVATPercent"/>',
			           '<xsl:value-of select="OrderPaymentFeeWithVAT"/>',
			           '<xsl:value-of select="OrderPaymentFeeWithoutVAT"/>',
			           '<xsl:value-of select="OrderPaymentFeeVAT"/>',
			           '<xsl:value-of select="OrderPaymentFeeVATPercent"/>',
			           '<xsl:value-of select="OrderPriceBeforeFeesWithVAT"/>',
			           '<xsl:value-of select="OrderPriceBeforeFeesWithoutVAT"/>',
			           '<xsl:value-of select="OrderPriceBeforeFeesVAT"/>',
			           '<xsl:value-of select="OrderPriceBeforeFeesVATPercent"/>',
			           '<xsl:value-of select="OrderCustomerAccessUserID"/>',
			           '<xsl:value-of select="OrderCustomerAccessUserUserName"/>',
			           '<xsl:value-of select="OrderShippingMethodID"/>',
			           '<xsl:value-of select="OrderPaymentMethodID"/>',
			           '<xsl:value-of select="OrderGatewayResult"/>',
			           '<xsl:value-of select="OrderStepNum"/>',
			           '<xsl:value-of select="OrderTransactionNumber"/>',
			           '<xsl:value-of select="OrderCustomerCountryCode"/>',
			           '<xsl:value-of select="OrderDeliveryCountryCode"/>',
			           '<xsl:value-of select="OrderStepHistory"/>',
			           '<xsl:value-of select="OrderLanguageID"/>'
			            );
		         </insert>
		        <update>
		
				UPDATE EcomOrders
				  SET 
				      [OrderID] ='<xsl:value-of select="OrderID"/>',
				      [OrderShopID] ='<xsl:value-of select="OrderShopID"/>',
				      [OrderDate] ='<xsl:value-of select="OrderDate"/>',
				      [OrderModified] ='<xsl:value-of select="OrderModified"/>',
				      [OrderComplete] ='<xsl:value-of select="OrderComplete"/>',
				      [OrderDeleted] ='<xsl:value-of select="OrderDeleted"/>',
				      [OrderStateID] ='<xsl:value-of select="OrderStateID"/>',
				      [OrderVAT] ='<xsl:value-of select="OrderVAT"/>',
				      [OrderIP] ='<xsl:value-of select="OrderIP"/>',
				      [OrderReferrer] ='<xsl:value-of select="OrderReferrer"/>',
				      [OrderTransactionValue] ='<xsl:value-of select="OrderTransactionValue"/>',
				      [OrderTransactionType] ='<xsl:value-of select="OrderTransactionType"/>',
				      [OrderTransactionStatus] ='<xsl:value-of select="OrderTransactionStatus"/>',
				      [OrderTransactionAmount] ='<xsl:value-of select="OrderTransactionAmount"/>',
				      [OrderTransactionPayGatewayCode] ='<xsl:value-of select="OrderTransactionPayGatewayCode"/>',
				      [OrderTrackTraceNumber] ='<xsl:value-of select="OrderTrackTraceNumber"/>',
				      [OrderShippingMethod] ='<xsl:value-of select="OrderShippingMethod"/>',
				      [OrderShippingMethodFee] ='<xsl:value-of select="OrderShippingMethodFee"/>',
				      [OrderPaymentMethod] ='<xsl:value-of select="OrderPaymentMethod"/>',
				      [OrderPaymentMethodFee] ='<xsl:value-of select="OrderPaymentMethodFee"/>',
				      [OrderSalesDiscount] ='<xsl:value-of select="OrderSalesDiscount"/>',
				      [OrderCurrencyName] ='<xsl:value-of select="OrderCurrencyName"/>',
				      [OrderCurrencyRate] ='<xsl:value-of select="OrderCurrencyRate"/>',
				      [OrderCurrencyCode] ='<xsl:value-of select="OrderCurrencyCode"/>',
				      [OrderCart] ='<xsl:value-of select="OrderCart"/>',
				      [OrderFieldsXML] ='<xsl:value-of select="OrderFieldsXML"/>',
				      [OrderReSendEmail] ='<xsl:value-of select="OrderReSendEmail"/>',
				      [OrderCustomerNumber] ='<xsl:value-of select="OrderCustomerNumber"/>',
				      [OrderCustomerCompany] ='<xsl:value-of select="OrderCustomerCompany"/>',
				      [OrderCustomerName] ='<xsl:value-of select="OrderCustomerName"/>',
				      [OrderCustomerAddress] ='<xsl:value-of select="OrderCustomerAddress"/>',
				      [OrderCustomerAddress2] ='<xsl:value-of select="OrderCustomerAddress2"/>',
				      [OrderCustomerZip] ='<xsl:value-of select="OrderCustomerZip"/>',
				      [OrderCustomerCity] ='<xsl:value-of select="OrderCustomerCity"/>',
				      [OrderCustomerCountry] ='<xsl:value-of select="OrderCustomerCountry"/>',
				      [OrderCustomerRegion] ='<xsl:value-of select="OrderCustomerRegion"/>',
				      [OrderCustomerPhone] ='<xsl:value-of select="OrderCustomerPhone"/>',
				      [OrderCustomerFax] ='<xsl:value-of select="OrderCustomerFax"/>',
				      [OrderCustomerEmail] ='<xsl:value-of select="OrderCustomerEmail"/>',
				      [OrderCustomerCell] ='<xsl:value-of select="OrderCustomerCell"/>',
				      [OrderCustomerRefID] ='<xsl:value-of select="OrderCustomerRefID"/>',
				      [OrderCustomerEAN] ='<xsl:value-of select="OrderCustomerEAN"/>',
				      [OrderCustomerVatRegNumber] ='<xsl:value-of select="OrderCustomerVatRegNumber"/>',
				      [OrderDeliveryCompany] ='<xsl:value-of select="OrderDeliveryCompany"/>',
				      [OrderDeliveryName] ='<xsl:value-of select="OrderDeliveryName"/>',
				      [OrderDeliveryAddress] ='<xsl:value-of select="OrderDeliveryAddress"/>',
				      [OrderDeliveryAddress2] ='<xsl:value-of select="OrderDeliveryAddress2"/>',
				      [OrderDeliveryZip] ='<xsl:value-of select="OrderDeliveryZip"/>',
				      [OrderDeliveryCity] ='<xsl:value-of select="OrderDeliveryCity"/>',
				      [OrderDeliveryCountry] ='<xsl:value-of select="OrderDeliveryCountry"/>',
				      [OrderDeliveryRegion] ='<xsl:value-of select="OrderDeliveryRegion"/>',
				      [OrderDeliveryPhone] ='<xsl:value-of select="OrderDeliveryPhone"/>',
				      [OrderDeliveryFax] ='<xsl:value-of select="OrderDeliveryFax"/>',
				      [OrderDeliveryEmail] ='<xsl:value-of select="OrderDeliveryEmail"/>',
				      [OrderDeliveryCell] ='<xsl:value-of select="OrderDeliveryCell"/>',
				      [OrderTotalPrice] ='<xsl:value-of select="OrderTotalPrice"/>',
				      [OrderComment] ='<xsl:value-of select="OrderComment"/>',
				      [OrderCustomerComment] ='<xsl:value-of select="OrderCustomerComment"/>',
				      [OrderWeight] ='<xsl:value-of select="OrderWeight"/>',
				      [OrderVolume] ='<xsl:value-of select="OrderVolume"/>',
				      [OrderPriceWithVAT] ='<xsl:value-of select="OrderPriceWithVAT"/>',
				      [OrderPriceWithoutVAT] ='<xsl:value-of select="OrderPriceWithoutVAT"/>',
				      [OrderPriceVAT] ='<xsl:value-of select="OrderPriceVAT"/>',
				      [OrderPriceVATPercent] ='<xsl:value-of select="OrderPriceVATPercent"/>',
				      [OrderShippingFeeWithVAT] ='<xsl:value-of select="OrderShippingFeeWithVAT"/>',
				      [OrderShippingFeeWithoutVAT] ='<xsl:value-of select="OrderShippingFeeWithoutVAT"/>',
				      [OrderShippingFeeVAT] ='<xsl:value-of select="OrderShippingFeeVAT"/>',
				      [OrderShippingFeeVATPercent] ='<xsl:value-of select="OrderShippingFeeVATPercent"/>',
				      [OrderPaymentFeeWithVAT] ='<xsl:value-of select="OrderPaymentFeeWithVAT"/>',
				      [OrderPaymentFeeWithoutVAT] ='<xsl:value-of select="OrderPaymentFeeWithoutVAT"/>',
				      [OrderPaymentFeeVAT] ='<xsl:value-of select="OrderPaymentFeeVAT"/>',
				      [OrderPaymentFeeVATPercent] ='<xsl:value-of select="OrderPaymentFeeVATPercent"/>',
				      [OrderPriceBeforeFeesWithVAT] ='<xsl:value-of select="OrderPriceBeforeFeesWithVAT"/>',
				      [OrderPriceBeforeFeesWithoutVAT] ='<xsl:value-of select="OrderPriceBeforeFeesWithoutVAT"/>',
				      [OrderPriceBeforeFeesVAT] ='<xsl:value-of select="OrderPriceBeforeFeesVAT"/>',
				      [OrderPriceBeforeFeesVATPercent] ='<xsl:value-of select="OrderPriceBeforeFeesVATPercent"/>',
				      [OrderCustomerAccessUserID] ='<xsl:value-of select="OrderCustomerAccessUserID"/>',
				      [OrderCustomerAccessUserUserName] ='<xsl:value-of select="OrderCustomerAccessUserUserName"/>',
				      [OrderShippingMethodID] ='<xsl:value-of select="OrderShippingMethodID"/>',
				      [OrderPaymentMethodID] ='<xsl:value-of select="OrderPaymentMethodID"/>',
				      [OrderGatewayResult] ='<xsl:value-of select="OrderGatewayResult"/>',
				      [OrderStepNum] ='<xsl:value-of select="OrderStepNum"/>',
				      [OrderTransactionNumber] ='<xsl:value-of select="OrderTransactionNumber"/>',
				      [OrderCustomerCountryCode] ='<xsl:value-of select="OrderCustomerCountryCode"/>',
				      [OrderDeliveryCountryCode] ='<xsl:value-of select="OrderDeliveryCountryCode"/>',
				      [OrderStepHistory] ='<xsl:value-of select="OrderStepHistory"/>',
				      [OrderLanguageID] ='<xsl:value-of select="OrderLanguageID"/>'
	  			      WHERE OrderID = '<xsl:value-of select="OrderID"/>';
			  	</update>
				<delete />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	<xsl:template match="/Orders/Order/OrderLines/OrderLine">
		<orderline>
		<xsl:choose>
			<xsl:when test="@delete = true">
				DELETE FROM EcomOrderLines WHERE OrderLineID='<xsl:value-of select="OrderLineID"/>'
			</xsl:when>
			<xsl:otherwise>
	 			     INSERT INTO EcomOrderLines
	 			                      (     [OrderLineID]
						           ,[OrderLineOrderID]
						           ,[OrderLineParentLineID]
						           ,[OrderLineBOM]
						           ,[OrderLineDate]
						           ,[OrderLineModified]
						           ,[OrderLineProductNumber]
						           ,[OrderLineProductID]
						           ,[OrderLineProductVariantID]
						           ,[OrderLineProductName]
						           ,[OrderLineProductVariantText]
						           ,[OrderLineUnitPrice]
						           ,[OrderLineVatPercent]
						           ,[OrderLineVatPrice]
						           ,[OrderLineQuantity]
						           ,[OrderLineType]
						           ,[OrderLineReference]
						           ,[OrderLineBOMItemID]
						           ,[OrderLineUnitID]
						           ,[OrderLineWeight]
						           ,[OrderLineVolume]
						           ,[OrderLinePriceWithVAT]
						           ,[OrderLinePriceWithoutVAT]
						           ,[OrderLinePriceVAT]
						           ,[OrderLinePriceVATPercent]
						           ,[OrderLineUnitPriceWithVAT]
						           ,[OrderLineUnitPriceWithoutVAT]
						           ,[OrderLineUnitPriceVAT]
						           ,[OrderLineUnitPriceVATPercent]
						           ,[OrderLinePageId]
						    )	
						    VALUES
		 			            (
						           '<xsl:value-of select="OrderLineID"/>',
						           '<xsl:value-of select="OrderLineOrderID"/>',
						           '<xsl:value-of select="OrderLineParentLineID"/>',
						           '<xsl:value-of select="OrderLineBOM"/>',
						           '<xsl:value-of select="OrderLineDate"/>',
						           '<xsl:value-of select="OrderLineModified"/>',
						           '<xsl:value-of select="OrderLineProductNumber"/>',
						           '<xsl:value-of select="OrderLineProductID"/>',
						           '<xsl:value-of select="OrderLineProductVariantID"/>',
						           '<xsl:value-of select="OrderLineProductName"/>',
						           '<xsl:value-of select="OrderLineProductVariantText"/>',
						           '<xsl:value-of select="OrderLineUnitPrice"/>',
						           '<xsl:value-of select="OrderLineVatPercent"/>',
						           '<xsl:value-of select="OrderLineVatPrice"/>',
						           '<xsl:value-of select="OrderLineQuantity"/>',
						           '<xsl:value-of select="OrderLineType"/>',
						           '<xsl:value-of select="OrderLineReference"/>',
						           '<xsl:value-of select="OrderLineBOMItemID"/>',
						           '<xsl:value-of select="OrderLineUnitID"/>',
						           '<xsl:value-of select="OrderLineWeight"/>',
						           '<xsl:value-of select="OrderLineVolume"/>',
						           '<xsl:value-of select="OrderLinePriceWithVAT"/>',
						           '<xsl:value-of select="OrderLinePriceWithoutVAT"/>',
						           '<xsl:value-of select="OrderLinePriceVAT"/>',
						           '<xsl:value-of select="OrderLinePriceVATPercent"/>',
						           '<xsl:value-of select="OrderLineUnitPriceWithVAT"/>',
						           '<xsl:value-of select="OrderLineUnitPriceWithoutVAT"/>',
						           '<xsl:value-of select="OrderLineUnitPriceVAT"/>',
						           '<xsl:value-of select="OrderLineUnitPriceVATPercent"/>',
						           '<xsl:value-of select="OrderLinePageId"/>'
     						    );

			</xsl:otherwise>
		</xsl:choose>
		</orderline>
	</xsl:template>

</xsl:stylesheet>


