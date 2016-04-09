<?xml version="1.0" encoding="UTF-8" ?>
<updates>
  <!--
	Remember to update the internalversion number on all releases of Dynamicweb, and update the corresponding versionnumber
	in AssemblyInfo.vb (AssemblyInformationalVersionAttribute). Rules for version number can be found there as well.
	Internal Version number in updates.xml and ecom.xml has to be the same.
	-->      

    <current version="473" releasedate="26-08-2015" internalversion="8.7.0.1" />

    <package version="473" releasedate="26-08-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <EcomOrders>
		        <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderSavedCardID] INT NULL                                       
		        </sql>
            </EcomOrders>
        </database>
        <file name="InformationSavedCards.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step"  overwrite="false"/>
        <file name="Payment_confirmation.html" source="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Payment" target="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Payment"  overwrite="false"/>
    </package>

    <package version="472" date="24-08-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <AccessUserCard>
		        <sql conditional="">
                    ALTER TABLE [AccessUserCard] ALTER COLUMN AccessUserCardCheckSum NVARCHAR(128)
                </sql>
	        </AccessUserCard>
	    </database>
    </package>

    <package version="471" date="24-08-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <AccessUserCard>
		        <sql conditional="">
                    ALTER TABLE [AccessUserCard] ADD [AccessUserCardCheckSum] NVARCHAR(50) NULL
                </sql>
	        </AccessUserCard>
	    </database>
    </package>

    <package version="470" date="24-08-2015" internalversion="8.7.0.0">
        <file name="SavedCardList.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="NavigationSavedCards.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
    </package>

    <package version="469" date="13-08-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <EcomProductsRelated>
		        <sql conditional="">
                    ALTER TABLE [EcomProductsRelated]  ADD [ProductRelatedLimitVariant] NVARCHAR(MAX) NULL                        
                </sql>
	        </EcomProductsRelated>
	    </database>
    </package>

    <package version="468" releasedate="10-08-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <AccessUserCard>
		        <sql conditional="">   
                    ALTER TABLE [AccessUserCard] ADD [AccessUserCardUsedDate] DATETIME NOT NULL DEFAULT GETDATE()  
		        </sql>
            </AccessUserCard>
        </database>
    </package>

    <package version="467" date="20-07-2015" internalversion="8.7.0.0">
        <file name="OrderListRecurring.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="PrintOrderRecurring.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="RecurringOrderList.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="RecurringOrderDetails.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="NavigationRecurringOrders.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>        
        <file name="recurringOrder.png" source="/Files/Templates/eCom/CustomerCenter/Images" target="/Files/Templates/eCom/CustomerCenter/Images" overwrite="false" />
    </package>

    <package version="466" releasedate="13-07-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <EcomRecurringOrders>
		        <sql conditional="">   
                    ALTER TABLE [EcomRecurringOrder] ADD [RecurringOrderLastDelivery] DATETIME NULL    
		        </sql>
            </EcomRecurringOrders>
        </database>
    </package>

    <package version="465" releasedate="13-17-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <EcomFees>
		        <sql conditional="">
                    update [EcomFees] set [FeeOrderPrice] = 0 where [FeeOrderPrice] &lt; 0 and [FeeMethod] = 'SHIP'
		        </sql>
            </EcomFees>
        </database>
    </package>

    <package version="464" releasedate="08-07-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <EcomRecurringOrders>
		        <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderPaymentRecurringInfo] NVARCHAR(MAX) NULL    
                    ALTER TABLE [EcomRecurringOrder] DROP [RecurringOrderPaymentRecurringInfo], [RecurringOrderPaymentID], [RecurringOrderLanguageID]                                    
		        </sql>
            </EcomRecurringOrders>
        </database>
    </package>

    <package version="463" date="07-07-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
	        <EcomRecurringOrders>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomRecurringOrder' ) )
                        CREATE TABLE EcomRecurringOrder
                        (
                            RecurringOrderId INT NOT NULL IDENTITY(1,1),
                            RecurringOrderUserID INT NOT NULL,
                            RecurringOrderBaseOrderID NVARCHAR(50) NULL,
                            RecurringOrderStartDate DATETIME NULL,
                            RecurringOrderEndDate DATETIME NULL,
                            RecurringOrderInterval INT NOT NULL,
                            RecurringOrderIntervalUnit INT NOT NULL,
                            RecurringOrderCanceledDeliveries NVARCHAR(MAX) NULL,
                            RecurringOrderPaymentRecurringInfo NVARCHAR(MAX) NULL,
                            RecurringOrderPaymentID NVARCHAR(50) NULL,
                            RecurringOrderLanguageID NVARCHAR(50) NULL,
                            CONSTRAINT DW_PK_RecurringOrders PRIMARY KEY CLUSTERED (RecurringOrderId ASC)
                        )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_RecurringOrder_UserID] ON [EcomRecurringOrder] ([RecurringOrderUserID] ASC)
                    CREATE NONCLUSTERED INDEX [DW_IX_RecurringOrder_BaseOrderID] ON [EcomRecurringOrder] ([RecurringOrderBaseOrderID] ASC)
                </sql>
            </EcomRecurringOrders>
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderRecurringOrderId] INT NULL
                </sql>
            </EcomOrders>
        </database>
        <file name="InformationRecurringOrders.html" target="/Files/Templates/eCom7/CartV2/Step" source="/Files/Templates/eCom7/CartV2/Step" />
        <file name="ReceiptRecurringOrders.html" target="/Files/Templates/eCom7/CartV2/Step" source="/Files/Templates/eCom7/CartV2/Step" />
    </package>
    
    <package version="462" releasedate="02-07-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <ProductCategories>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomProductCategoryFieldValue_FieldValue_ProductId_VariantId_LanguageId]
                    ON [EcomProductCategoryFieldValue] ([FieldValueProductId], [FieldValueProductVariantId], [FieldValueProductLanguageId])
                    INCLUDE ([FieldValueFieldId], [FieldValueFieldCategoryId], [FieldValueValue])
                </sql>
            </ProductCategories>
        </database>
    </package>

    <package version="461" date="30-06-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomCustomerFavoriteLists>
                <sql conditional="">ALTER TABLE [EcomCustomerFavoriteLists] ADD 
                                                [IsPublished] BIT NOT NULL DEFAULT 0,
                                                [PublishedToDate] DATETIME NULL,
                                                [Type] NVARCHAR(255),
                                                [IsDefault] BIT NOT NULL DEFAULT 0,
                                                [Description] NVARCHAR(MAX),
                                                [PublishedId] NVARCHAR(255)
                </sql>
            </EcomCustomerFavoriteLists>
            <EcomCustomerFavoriteProducts>
                <sql conditional="">ALTER TABLE [EcomCustomerFavoriteProducts] ADD 
                                                [Quantity] INT NULL,
                                                [SortOrder] INT NULL
                </sql>
            </EcomCustomerFavoriteProducts>
        </database>
    </package>

    <package version="460" releasedate="30-06-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomProducts_ExcludeFromIndex] ON [EcomProducts] ([ProductExcludeFromIndex]) INCLUDE ([ProductID])
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomProductCategoryFieldValue_CategoryId_ProductId] ON [EcomProductCategoryFieldValue] ([FieldValueFieldCategoryId], [FieldValueProductId]) 
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="459" releasedate="29-06-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomShippings>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderShippingFeeRuleName] NVARCHAR(255) NULL
                </sql>
            </EcomShippings>
        </database>
    </package>

    <package version="458" date="23-06-2015" internalversion="8.7.0.0">
    </package>

    <package version="457" date="19-06-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <AccessUserCard>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'AccessUserCard' ) )
                        CREATE TABLE AccessUserCard
                        (
                            AccessUserCardId INT NOT NULL IDENTITY(1,1),
                            AccessUserCardUserID INT NOT NULL ,
                            AccessUserCardName NVARCHAR(50) NOT NULL,
                            AccessUserCardType NVARCHAR(20) NOT NULL,
                            AccessUserCardIdentifier NVARCHAR(20) NOT NULL,
                            AccessUserCardToken NVARCHAR(MAX) NOT NULL,
                            AccessUserCardPaymentID NVARCHAR(50) NOT NULL,
                            AccessUserCardLanguageID NVARCHAR(50) NOT NULL,
                            AccessUserCardUsedDate DATETIME NOT NULL DEFAULT GETDATE(),
                            CONSTRAINT DW_PK_AccessUserCard PRIMARY KEY CLUSTERED (AccessUserCardId ASC)
                        )
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_AccessUserCard_UserID] ON [AccessUserCard] ([AccessUserCardUserID] ASC)
                </sql>
            </AccessUserCard>            
        </database>
    </package>

    <package version="456" releasedate="11-06-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomGiftCardTransaction>
                <sql conditional="">
                    ALTER TABLE [EcomGiftCardTransaction] ADD [GiftCardTransactionOrderLineId] NVARCHAR(50) NOT NULL DEFAULT ''
                </sql>
            </EcomGiftCardTransaction>
        </database>
    </package>

    <package version="455" date="03-06-2015" internalversion="8.7.0.0">
        <file name="InformationWithStatesGiftCards.html" target="/Files/Templates/eCom7/CartV2/Step" source="/Files/Templates/eCom7/CartV2/Step" />
    </package>

    <package version="454" releasedate="03-06-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomOrders_CustomerAccessUserID] 
                    ON [EcomOrders] ([OrderCustomerAccessUserID] ASC)
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomOrders_CompletedDate] 
                    ON [EcomOrders] ([OrderCompletedDate] ASC)
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="453" date="01-06-2014" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
            <EcomShippings>
                <sql conditional="">
                    ALTER TABLE [EcomShippings] ADD 
                    [ShippingFeeSelection] NVARCHAR(10) NULL
                </sql>
            </EcomShippings>
	        <EcomFees>
		        <sql conditional="">
                    ALTER TABLE EcomFees ADD
                     [FeeName] NVARCHAR(255) NULL,
                     [FeeActive] BIT NOT NULL CONSTRAINT DW_DF_Fee_Active DEFAULT 1,
	                 [FeeValidFrom] DATETIME NULL,
	                 [FeeValidTo] DATETIME NULL,
	                 [FeeAccessUserId] INT NULL,
	                 [FeeAccessUserGroupId] INT NULL,
                     [FeeAccessUserCustomerNumber] NVARCHAR(255) NULL,
                     [FeeShopId]  NVARCHAR(255) NULL, 
                     [FeeProductsAndGroups] NVARCHAR(MAX) NOT NULL CONSTRAINT DW_DF_Fee_ProductsAndGroups DEFAULT '[all]',
	                 [FeeOrderContextId] NVARCHAR(50) NULL,
                     [FeeCurrencyCode] NVARCHAR(3) NULL,
                     [FeeZip] NVARCHAR(MAX) NULL
		        </sql>
	        </EcomFees>
        </database>
    </package>
    
   <package version="452" date="21-05-2015" internalversion="8.7.0.0">
    <database file="Ecom.mdb">
        <Ecom7Tree>
                <sql conditional="SELECT TOP 1 [id] FROM [Ecom7Tree] WHERE [Text] = 'GiftCards'">                    
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        92,
                        'GiftCards',
                        NULL,
                        '/Admin/Module/eCom_Catalog/images/buttons/btn_giftcard.gif',
                        '/Admin/Module/eCom_Catalog/dw7/GiftCards/GiftCardsList.aspx',
                        'GIFTCARDS',
                        43,
                        'eCom_CartV2'
                    ),
                    (
                        94,
                        'GiftCards',
                        NULL,
                        '/Admin/Module/eCom_Catalog/images/buttons/btn_giftcard.gif',
                        '/Admin/Module/eCom_Catalog/dw7/GiftCards/GiftCardsAdvancedSettings.aspx',
                        'GIFTCARDS',
                        74,
                        'eCom_CartV2'
                    )
                </sql>
        </Ecom7Tree>
        <Module>
            <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'GiftCards'">
                INSERT INTO [Module] (ModuleSystemName,  ModuleName, ModuleIsBeta, ModuleAccess, ModuleParagraph, ModuleEcomNotInstalledAccess)
                VALUES               ('GiftCards'     , 'GiftCards',            0,            1,               1,                            0)
            </sql>
        </Module>
    </database>
   </package>

    <package version="451" releasedate="20-05-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrderDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ALTER COLUMN [OrderVoucherCode] [nvarchar(max)] NULL
                </sql>
            </EcomOrderDiscount>
        </database>
    </package>

    <package version="450" releasedate="19-05-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderGiftcardTransactionFailed] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="449" releasedate="19-05-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrderLines>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLineGiftCardCode] NVARCHAR(MAX) NULL
                </sql>
            </EcomOrderLines>
        </database>
    </package>

    <package version="448" releasedate="14-05-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomProducts>
                <sql conditional="">
                     ALTER TABLE [EcomProductCategoryFieldGroupValue] DROP CONSTRAINT [EcomProductCategoryFieldGroupValue$GroupForeignKey]
                </sql>
                <sql conditional="">
                     ALTER TABLE [EcomProductCategoryFieldGroupValue] DROP CONSTRAINT [EcomProductCategoryFieldGroupValue$CategoryFieldForeignKey]
                </sql>
            </EcomProducts>
        </database>
    </package>
    
    <package version="447" date="14-05-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <EcomGiftCard>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomGiftCard' ) )
                        CREATE TABLE EcomGiftCard
                        (
                            GiftCardAutoId BIGINT NOT NULL IDENTITY(1,1),
                            GiftCardId NVARCHAR(50) NOT NULL ,
                            GiftCardName NVARCHAR(MAX) NOT NULL,
                            GiftCardCode NVARCHAR(MAX) NOT NULL,
                            GiftCardExpiryDate DATETIME NOT NULL DEFAULT GETDATE(),
                            GiftCardCurrency NVARCHAR(10) NULL DEFAULT NULL,
                            CONSTRAINT DW_PK_EcomGiftCard PRIMARY KEY CLUSTERED (GiftCardId ASC),
                        )
                </sql>
            </EcomGiftCard>            
            <EcomNumbers>
                <sql conditional="">
                    IF NOT EXISTS( SELECT NumberID FROM EcomNumbers WHERE ( NumberType = 'GIFTCARD' ) )
	                    INSERT INTO EcomNumbers ( NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable )
	                    VALUES ( '51', 'GIFTCARD', 'Gift Cards', 0, 'GIFTCARD', '', 1, 0 )
                </sql>
            </EcomNumbers>           
            <EcomGiftCardTransaction>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomGiftCardTransaction' ) )
                        CREATE TABLE EcomGiftCardTransaction
                        (
                            GiftCardTransactionId BIGINT NOT NULL IDENTITY(1,1),
                            GiftCardTransactionAmount FLOAT NOT NULL,
                            GiftCardTransactionOrderId NVARCHAR(50) NOT NULL,
                            GiftCardTransactionGiftCardId NVARCHAR(50) NULL DEFAULT NULL,
                            GiftCardTransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
                            CONSTRAINT DW_PK_EcomGiftCardTransaction PRIMARY KEY CLUSTERED (GiftCardTransactionId ASC),
                        )
                </sql>
            </EcomGiftCardTransaction> 
        </database>
        <file name="ProductGiftCard.html" target="/Files/Templates/eCom/Product" source="/Files/Templates/eCom/Product" />
        <file name="ProductListGiftCard.html" target="/Files/Templates/eCom/ProductList" source="/Files/Templates/eCom/ProductList" />
        <file name="ReceiptGiftCard.html" target="/Files/Templates/eCom7/CartV2/Step" source="/Files/Templates/eCom7/CartV2/Step" />
    </package>

    <package version="446" releasedate="23-04-2015" internalversion="8.7.0.0">
	    <database file="Ecom.mdb">
	        <EcomProducts>
                <sql conditional="">
                    CREATE TABLE [EcomProductCategoryFieldGroupValue](
	                    [FieldValueFieldId] [nvarchar](255) NOT NULL,
	                    [FieldValueFieldCategoryId] [nvarchar](50) NOT NULL,
	                    [FieldValueGroupId] [nvarchar](255) NOT NULL,
	                    [FieldValueGroupLanguageId] [nvarchar](50) NOT NULL,
	                    [FieldValueValue] [nvarchar](max) NULL,
                     CONSTRAINT [EcomProductCategoryFieldGroupValue$PrimaryKey] PRIMARY KEY CLUSTERED 
                    (
	                    [FieldValueFieldId] ASC,
	                    [FieldValueFieldCategoryId] ASC,
	                    [FieldValueGroupId] ASC,
	                    [FieldValueGroupLanguageId] ASC
                    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
                    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomProductCategoryFieldGroupValue]  WITH CHECK ADD  CONSTRAINT [EcomProductCategoryFieldGroupValue$CategoryFieldForeignKey] FOREIGN KEY([FieldValueFieldId], [FieldValueFieldCategoryId])
                    REFERENCES [EcomProductCategoryField] ([FieldId], [FieldCategoryId])
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomProductCategoryFieldGroupValue]  WITH CHECK ADD  CONSTRAINT [EcomProductCategoryFieldGroupValue$GroupForeignKey] FOREIGN KEY([FieldValueGroupId], [FieldValueGroupLanguageId])
                    REFERENCES [EcomGroups] ([GroupID], [GroupLanguageID])
                </sql>
                <sql conditional="">
                    ALTER TABLE EcomGroupRelations ADD GroupRelationsInheritCategories bit NOT NULL CONSTRAINT DF_EcomGroupRelations_GroupRelationsInheritCategories DEFAULT 0
                </sql>
	        </EcomProducts>
        </database>
    </package>

    <package version="445" date="21-04-2015" internalversion="8.7.0.0">
    <database file="Ecom.mdb">
        <EcomGlobalISO>
            <sql conditional="">
                UPDATE EcomGlobalISO SET [ISOCode3] = 'ROU' WHERE ISOID = '171' AND [ISOCode3] = 'ROM'
            </sql>
        </EcomGlobalISO>
    </database>
    </package>

    <package version="444" releasedate="10-04-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrderDiscount>
                <sql conditional="">
                    update [EcomDiscount] set DiscountOrderContextId = NULL where DiscountOrderContextId not in (select d.DiscountOrderContextId from [EcomDiscount] d
                        join [EcomOrderContexts] c on c.OrderContextID = d.DiscountOrderContextId)
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD CONSTRAINT
	                    FK_EcomDiscount_EcomOrderContexts FOREIGN KEY ([DiscountOrderContextId]) REFERENCES [EcomOrderContexts] ([OrderContextID])
                         ON UPDATE  NO ACTION 
	                     ON DELETE  SET NULL 
                </sql>
            </EcomOrderDiscount>
        </database>
    </package>

    <package version="443" releasedate="10-04-2015" internalversion="8.7.0.0">
        <file name="Payment.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="Payment_AddressUpdating.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="Payment_AddressUpdating_SE.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="Payment_DateOfBirth.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="invoice.css" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="invoice.js" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Payment" />
        <file name="PaymentMethods.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_AT.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_DE.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_DK.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_FI.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_NL.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_NO.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="PaymentMethods_SE.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/SelectPaymentMethod" />
        <file name="checkouthandler_cancel.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Cancel" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Cancel" />
        <file name="checkouthandler_error.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Error" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaInvoice/Error" />
    </package>

    <package version="442" releasedate="26-03-2015" internalversion="8.7.0.0">
        <database file="Ecom.mdb">
            <EcomOrderDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD [DiscountOrderContextId] [nvarchar](50) NULL
                </sql>
            </EcomOrderDiscount>
        </database>
    </package>

    <package version="441" releasedate="20-03-2015" internalversion="8.7.0.0">
        <file name="Payment.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Payment" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Payment" />
        <file name="Confirmation.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Confirmation" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Confirmation" />
        <file name="checkouthandler_cancel.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Cancel" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Cancel" />
        <file name="checkouthandler_error.html" target="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Error" source="/Files/Templates/eCom7/CheckoutHandler/KlarnaCheckout/Error" />
    </package>

    <package version="440" releasedate="19-03-2015" internalversion="8.7.0.0">
        <file name="Payment.html" target="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Payment" source="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Payment" />
        <file name="checkouthandler_cancel.html" target="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Cancel" source="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Cancel" />
        <file name="checkouthandler_error.html" target="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Error" source="/Files/Templates/eCom7/CheckoutHandler/ChargeLogic/Error" />
    </package>
    
    <package version="439" releasedate="18-03-2015" internalversion="8.6.1.0">
        <file name="Post.html" target="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Post" source="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Post" />
        <file name="Post_iframe.html" target="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Post" source="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Post" />
        <file name="checkouthandler_cancel.html" target="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Cancel" source="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Cancel" />
        <file name="checkouthandler_error.html" target="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Error" source="/Files/Templates/eCom7/CheckoutHandler/Beanstream/Error" />
    </package>

    <package version="438" releasedate="16-03-2015" internalversion="8.6.1.0">
        <database file="Dynamic.mdb">
            <Module>                
                <sql conditional="">UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_MultiShopAdvanced'</sql>                
                <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'eCom_Center'</sql>
            </Module>
        </database>        
    </package>

    <package version="437" releasedate="13-03-2015" internalversion="8.6.1.0">
        <file name="checkouthandler_cancel.html" target="/Files/Templates/eCom7/CheckoutHandler/CyberSource/Cancel" source="/Files/Templates/eCom7/CheckoutHandler/CyberSource/Cancel" />
        <file name="checkouthandler_error.html" target="/Files/Templates/eCom7/CheckoutHandler/CyberSource/Error" source="/Files/Templates/eCom7/CheckoutHandler/CyberSource/Error" />
    </package>

    <package version="436" releasedate="11-03-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomProductsRelated] ADD [ProductRelatedProductRelVariantID] [nvarchar](255) NOT NULL DEFAULT '';
                    ALTER TABLE [EcomProductsRelated] DROP CONSTRAINT [EcomProductsRelated$PrimaryKey];
                    ALTER TABLE [EcomProductsRelated] ADD CONSTRAINT [EcomProductsRelated$PrimaryKey] PRIMARY KEY NONCLUSTERED ([ProductRelatedProductID], [ProductRelatedProductRelID], [ProductRelatedGroupID], [ProductRelatedProductRelVariantID]);
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="435" date="11-03-2015" internalversion="8.6.1.0">
	    <database file="Ecom.mdb">
	        <EcomAssortments>
		        <sql conditional="">
                    UPDATE [Ecom7Tree] SET [Text] = 'Order discounts' WHERE [id]=93 or [id]=94
                </sql>
            </EcomAssortments>
        </database>
    </package>  
    
    <package version="434" date="10-03-2015" internalversion="8.6.1.0">
	    <database file="Ecom.mdb">
	        <EcomAssortments>
		        <sql conditional="">
                    ALTER TABLE [EcomOrderStates] ADD [OrderStateAllowOrder] BIT NOT NULL DEFAULT 1
                </sql>
            </EcomAssortments>
        </database>
    </package>  

    <package version="433" date="02-03-2015" internalversion="8.6.1.0">
	    <database file="Ecom.mdb">
	        <EcomAssortments>
		        <sql conditional="">
                    ALTER TABLE [EcomAssortments] ADD [AssortmentAllowAnonymousUsers] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomAssortments>
        </database>
    </package>  

    <package version="432" releasedate="27-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderContextID] [nvarchar](50) NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="431" releasedate="12-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomProductVatGroups] ADD [ProductVatGroupProductVariantID] [nvarchar](255) NOT NULL DEFAULT ''
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="430" releasedate="11-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomProductFieldTranslation>
                <sql conditional="">
                    IF (NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EcomProductVatGroups'))
                    BEGIN
                        CREATE TABLE [EcomProductVatGroups](
	                        [ProductVatGroupID] [int] IDENTITY(1,1) NOT NULL,
	                        [ProductVatGroupProductID] [nvarchar](30) NOT NULL,
	                        [ProductVatGroupProductVariantID] [nvarchar](255) NOT NULL,
	                        [ProductVatGroupVatGroupID] [nvarchar](50) NOT NULL,
	                        [ProductVatGroupCountryID] [nvarchar](2) NULL
                        CONSTRAINT [PK_EcomProductVatGroups] PRIMARY KEY CLUSTERED ([ProductVatGroupID] ASC)) 
                    END
                </sql>
                <sql conditional="">
                        CREATE NONCLUSTERED INDEX [DW_IX_EcomProductVatGroups_ProductID_ProductVariantID] 
                        ON [EcomProductVatGroups] (
                            [ProductVatGroupProductID] ASC,
                            [ProductVatGroupProductVariantID] ASC
                        )
                </sql>
            </EcomProductFieldTranslation>
        </database>
    </package>      
        
    <package version="429" releasedate="06-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderVoucherUseType] INT NOT NULL DEFAULT 0
                </sql>
            </EcomOrders>
        </database>
    </package>
        
    <package version="428" releasedate="05-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomPrices] ADD [PriceIsInformative] BIT NULL
                </sql>
            </EcomDiscount>
        </database>
    </package>
        
    <package version="427" releasedate="03-02-2015" internalversion="8.6.1.0">
        <database file="Ecom.mdb">
            <EcomDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD [DiscountDescription] NVARCHAR(MAX) NULL
                </sql>
            </EcomDiscount>
        </database>
    </package>

    <package version="426" releasedate="26-01-2015" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD 
                        [OrderTaxTransactionNumber] NVARCHAR(50) NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="425" releasedate="22-01-2015" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomRmas>
                <sql conditional="">
                    ALTER TABLE [EcomRmas] ADD 
                        [RmaCustomerCountryCode] NVARCHAR(50) NULL,
                        [RmaDeliveryCountryCode] NVARCHAR(50) NULL
                </sql>
            </EcomRmas>
        </database>
    </package>

    <package version="423" releasedate="19-01-2015" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD [DiscountAssignableFromProducts] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomDiscount>
        </database>
    </package>

    <package version="422" date="16-01-2015" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomLoyaltyRewardRule>
		        <sql conditional="">
                    ALTER TABLE [EcomLoyaltyRewardRule] ADD
	                    [LoyaltyRewardRuleOrderLineFieldName] NVARCHAR(255) NULL
                </sql>
            </EcomLoyaltyRewardRule>
        </database>
    </package>
    <package version="421" date="15-01-2015" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomLoyaltyRewardRule>
		        <sql conditional="">
                    ALTER TABLE [EcomLoyaltyRewardRule] ADD
	                    [LoyaltyRewardRuleOrderFieldName] NVARCHAR(255) NULL,
	                    [LoyaltyRewardRuleOrderFieldValue] NVARCHAR(MAX) NULL,
	                    [LoyaltyRewardRuleVoucherListId] INT NULL
                </sql>
            </EcomLoyaltyRewardRule>
        </database>
    </package>

    <package version="420" releasedate="14-01-2015" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomProductFieldTranslation>
                <sql conditional="">
                    IF (NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EcomFieldOptionTranslation'))
                    BEGIN
                        CREATE TABLE [EcomFieldOptionTranslation](
	                        [EcomFieldOptionTranslationID] [int] IDENTITY(1,1) NOT NULL,
	                        [EcomFieldOptionTranslationOptionID] [nvarchar](255) NOT NULL,
	                        [EcomFieldOptionTranslationLanguageID] [nvarchar](50) NOT NULL,
	                        [EcomFieldOptionTranslationName] [nvarchar](255) NULL,
                        CONSTRAINT [PK_EcomFieldOptionTranslation] PRIMARY KEY CLUSTERED ([EcomFieldOptionTranslationID] ASC)) 
                    END
                </sql>
            </EcomProductFieldTranslation>
        </database>
    </package>  

    <package version="419" date="30-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
	        <EcomOrders>
		        <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderPriceCalculatedByProvider] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="418" date="30-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
	        <EcomAssortments>
		        <sql conditional="">
                    ALTER TABLE [EcomAssortments] ADD [AssortmentIncludeSubgroups] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomAssortments>
        </database>
    </package>    

    <package version="417" date="30-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomLoyaltyRewardRule>
		        <sql conditional="">
                    ALTER TABLE [EcomLoyaltyRewardRule] ADD
                     [LoyaltyRewardRuleName] NVARCHAR(255) NULL,
                     [LoyaltyRewardRuleActive] BIT NOT NULL CONSTRAINT DW_DF_LoyaltyRewardRule_Active DEFAULT 1,
	                 [LoyaltyRewardRuleValidFrom] DATETIME NULL,
	                 [LoyaltyRewardRuleValidTo] DATETIME NULL,
	                 [LoyaltyRewardRuleAccessUserId] INT NULL,
	                 [LoyaltyRewardRuleAccessUserGroupId] INT NULL,
                     [LoyaltyRewardRuleAccessUserCustomerNumber] NVARCHAR(255) NULL,
                     [LoyaltyRewardRuleProductsAndGroups] NVARCHAR(MAX) NOT NULL DEFAULT '[all]',
	                 [LoyaltyRewardRuleCountryCode2] NVARCHAR(2) NULL,
	                 [LoyaltyRewardRuleShippingId] NVARCHAR(50) NULL,
	                 [LoyaltyRewardRulePaymentId] NVARCHAR(50) NULL,
	                 [LoyaltyRewardRuleProductQuantification] INT NOT NULL CONSTRAINT DW_DF_EcomLoyaltyRewardRule_ProductQuantification DEFAULT 0, 
	                 [LoyaltyRewardRuleProductQuantity] FLOAT NULL,
                     [LoyaltyRewardRuleOrderTotalPriceCondition] INT NOT NULL CONSTRAINT DW_DF_EcomLoyaltyRewardRule_OrderTotalPriceCondition DEFAULT 5,
	                 [LoyaltyRewardRuleOrderTotalPrice] FLOAT NULL
                </sql>
		        <sql conditional="">
                    update [EcomLoyaltyRewardRule] set LoyaltyRewardRuleProductsAndGroups = '[some]' + IIF(LoyaltyRewardRuleGroupId &lt;&gt; '',IIF(LoyaltyRewardRuleGroupId LIKE REPLACE('00000000-0000-0000-0000-000000000000', '0', '[0-9a-fA-F]'), '[ss:' + LoyaltyRewardRuleGroupId + ']', '[g:' + LoyaltyRewardRuleGroupId + ']'), '') + IIF(LoyaltyRewardRuleProductId &lt;&gt; '', '[p:' + LoyaltyRewardRuleProductId + ',' + isnull(LoyaltyRewardRuleProductVariantId, '') + ']', '')
                </sql>
                <sql conditional="">
                    update [EcomLoyaltyRewardRule] set LoyaltyRewardRuleName = 'Rule_' + CONVERT(nvarchar(Max), LoyaltyRewardRuleId) Where LoyaltyRewardRuleName is null
                </sql>
                <sql conditional="">
                    update [EcomLoyaltyRewardRule] set LoyaltyRewardRuleValidFrom = GETDATE() Where LoyaltyRewardRuleValidFrom is null
                </sql>
                <sql conditional="">
                    update [EcomLoyaltyRewardRule] set LoyaltyRewardRuleValidTo = DATEADD (year, 1, GETDATE()) Where LoyaltyRewardRuleValidTo is null
                </sql>
            </EcomLoyaltyRewardRule>
        </database>
    </package>

    <package version="416" date="24-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
	        <EcomAssortments>
		        <sql conditional="">
                    ALTER TABLE [EcomAssortments] ADD [AssortmentActive] BIT NOT NULL DEFAULT 1
                </sql>
            </EcomAssortments>
        </database>
    </package>

    <package version="415" releasedate="19-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomProducts>
		        <sql conditional="">ALTER TABLE [EcomProducts] DROP [ProductPeriodIdOfProduct]</sql>
            </EcomProducts>
        </database>
    </package>

    <package version="414" releasedate="18-12-2014" internalversion="8.6.0.0">
        <invoke type="Dynamicweb.Content.Management.UpdateScripts, Dynamicweb" method="CreateEcomProductsRelatedGroupsIndexes" />
    </package>

    <package version="413" date="4-12-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomOrderDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD [DiscountProductsAndGroups] NVARCHAR(MAX) NOT NULL DEFAULT '[some]'
                </sql>
                <sql conditional="">
                    update EcomDiscount set DiscountProductsAndGroups = '[some]' + IIF(DiscountGroupId &lt;&gt; '',IIF(DiscountGroupId LIKE REPLACE('00000000-0000-0000-0000-000000000000', '0', '[0-9a-fA-F]'), '[ss:' + DiscountGroupId + ']', '[g:' + DiscountGroupId + ']'), '') + IIF(DiscountProductId &lt;&gt; '', '[p:' + DiscountProductId + ',' + DiscountProductVariantId + ']', '')
                    where DiscountProductsAndGroups is null
                </sql>
            </EcomOrderDiscount>
	    </database>
    </package>


    <package version="412" date="21-11-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
	        <EcomOrders>
		        <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderVisitorSessionDate] DATETIME NULL
                </sql>
		        <sql conditional="">
                    UPDATE [EcomOrders] SET [OrderVisitorSessionDate] = [OrderDate] WHERE [OrderVisitorSessionDate] IS NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="411" releasedate="20-11-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
            <EcomOrderDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD [DiscountExcludedProductsAndGroups] NVARCHAR(MAX) NOT NULL DEFAULT '[some]'
                </sql>
            </EcomOrderDiscount>
        </database>
    </package>

    <package version="410" date="17-11-2014" internalversion="8.6.0.0">
	    <database file="Ecom.mdb">
	        <EcomLoyaltyReward>
		        <sql conditional="">
                    ALTER TABLE [EcomLoyaltyReward] ADD [LoyaltyRewardArchived] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomLoyaltyReward>
        </database>
    </package>

    <package version="409" releasedate="30-10-2014" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomProductFieldTranslation>
                <sql conditional="">
                    IF (NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EcomProductFieldTranslation'))
                    BEGIN
                        CREATE TABLE [EcomProductFieldTranslation](
	                        [ProductFieldTranslationID] [int] IDENTITY(1,1) NOT NULL,
	                        [ProductFieldTranslationFieldID] [nvarchar](255) NOT NULL,
	                        [ProductFieldTranslationLanguageID] [nvarchar](50) NOT NULL,
	                        [ProductFieldTranslationName] [nvarchar](255) NULL,
                        CONSTRAINT [PK_EcomProductFieldTranslation] PRIMARY KEY CLUSTERED ([ProductFieldTranslationID] ASC)) 
                    END
                </sql>
            </EcomProductFieldTranslation>
        </database>
    </package>
      
    <package version="408" releasedate="08-10-2014" internalversion="8.6.0.0">
        <database file="Ecom.mdb">
            <EcomCurrencies>
                <sql conditional="">
                    ALTER TABLE [EcomCurrencies] ADD [CurrencyPositivePattern] INT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomCurrencies] ADD [CurrencyNegativePattern] INT NULL
                </sql>
            </EcomCurrencies>
        </database>
    </package>

    <package version="407" releasedate="02-10-2014" internalversion="8.6.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
	            <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCheckoutPageID] INT NOT NULL DEFAULT 0</sql>
            </EcomOrder>
        </database>
    </package>

    <package version="406" releasedate="26-09-2014" internalversion="8.5.1.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">
                    UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_ContextOrderRenderer'
                </sql>
            </Module>
        </database>
    </package>

    <package version="405" releasedate="25-09-2014" internalversion="8.5.1.0">
        <database file="Ecom.mdb">
            <ScheduledTask>
                <sql conditional="">
                    UPDATE ScheduledTask SET TaskMinute = 1440 WHERE TaskAssembly = 'Dynamicweb.eCommerce.Loyalty.PointExpirationScheduledTaskAddIn' AND TaskMinute = 1
                </sql>
            </ScheduledTask>
        </database>
    </package>

    <package version="404" releasedate="25-09-2014" internalversion="8.5.1.0">
        <database file="Ecom.mdb">
            <ScheduledTask>
                <sql conditional="">
                    UPDATE ScheduledTask SET TaskType = 6 WHERE TaskAssembly = 'Dynamicweb.eCommerce.Assortments.AssortmentItemBuilderScheduledTaskAddIn'
                </sql>
            </ScheduledTask>
        </database>
    </package>

    <package version="403" releasedate="25-09-2014" internalversion="8.5.1.0">
        <database file="Ecom.mdb">
            <ScheduledTask>
                <sql conditional="">
                    UPDATE ScheduledTask SET TaskType = 6 WHERE TaskAssembly = 'Dynamicweb.eCommerce.Loyalty.PointExpirationScheduledTaskAddIn'
                </sql>
            </ScheduledTask>
        </database>
    </package>

    <package version="402" releasedate="18-09-2014" internalversion="8.5.1.0">
        <file name="details.html" source="/Files/Templates/eCom/LoyaltyPoints/" target="/Files/Templates/eCom/LoyaltyPoints/" overwrite="false"/>
        <file name="list.html" source="/Files/Templates/eCom/LoyaltyPoints/" target="/Files/Templates/eCom/LoyaltyPoints/" overwrite="false"/>
    </package>

    <package version="401" releasedate="18-09-2014" internalversion="8.5.1.0">
        <file name="ProductLoyaltyPoints.html" target="/Files/Templates/eCom/Product" source="/Files/Templates/eCom/Product" />
        <file name="ProductListLoyaltyPoints.html" target="/Files/Templates/eCom/ProductList" source="/Files/Templates/eCom/ProductList" />
    </package>

    <package version="400" releasedate="16-09-2014" internalversion="8.5.1.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeChildPopulate = 'LOYALTYPOINTS' AND TreeHasAccessModuleSystemName Like '%LoyaltyPoints%'">
                    UPDATE Ecom7Tree SET TreeHasAccessModuleSystemName = 'LoyaltyPoints' WHERE TreeChildPopulate = 'LOYALTYPOINTS'
                </sql>
            </Ecom7Tree>
        </database>
    </package>


    <package version="399" releasedate="08-09-2014" internalversion="8.5.1.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
	            <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderTransactionCardNumber] NVARCHAR(50) NULL</sql>
            </EcomOrder>
        </database>
    </package>

    <package version="398" releasedate="05-09-2014" internalversion="8.5.1.0" >
        <database file="Ecom.mdb">
            <EcomDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomDiscount] ADD DiscountApplyOnce BIT NULL
                </sql>
	        </EcomDiscount>
        </database>
    </package>

    <package version="397" releasedate="05-09-2014" internalversion="8.5.1.0">
        <invoke type="Dynamicweb.Content.Management.UpdateScripts, Dynamicweb" method="AddDefaultQuoteStates" />
    </package>

    <package version="396" releasedate="04-09-2014" internalversion="8.5.1.0">
        <database file="Ecom.mdb">
            <EcomNumbers>
                <sql conditional="">
                    IF NOT EXISTS( SELECT NumberID FROM EcomNumbers WHERE ( NumberType = 'QUOTE' ) )
	                    INSERT INTO EcomNumbers ( NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable )
	                    VALUES ( '50', 'QUOTE', 'Quote', 0, 'QUOTE', '', 1, 0 )
                </sql>
            </EcomNumbers>
        </database>
    </package>

    <package version="395" releasedate="22-08-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_DiscountMatrix'">
                    INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleEcomNotInstalledAccess)
                    VALUES ('eCom_DiscountMatrix', 'Discount matrix', 0, 0)
                </sql>
            </Module>
        </database>
    </package>

    <package version="394" date="19-08-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="">
                    UPDATE [Ecom7Tree] SET [parentId] = 92 WHERE [parentId] = 93 and [TreeChildPopulate] in ('SALESDISCNT','ECOMVOUCHERSMANAGER','LOYALTYPOINTS')
                </sql>
                <sql conditional="">
                    UPDATE [Ecom7Tree] SET [TreeSort] = 41 WHERE [parentId] = 92 and [TreeChildPopulate] = 'LOYALTYPOINTS'
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="393" releasedate="19-08-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'LoyaltyPoints'">
                    INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleIsBeta, ModuleAccess, ModuleParagraph, ModuleEcomNotInstalledAccess)
                    VALUES ('LoyaltyPoints', 'Loyalty points', 0, 1,1, 0)
                </sql>
            </Module>
        </database>
    </package>


    <package version="392" releasedate="18-08-2014" internalversion="8.5.0.0">
        <file name="ProductListCustomerCenterList.html" target="/Files/Templates/eCom/ProductList" source="/Files/Templates/eCom/ProductList" />
    </package>

    <package version="391" releasedate="15-08-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
                <Module>
                <sql conditional="">
                    UPDATE [Module] SET [ModuleIsBeta] = 0 WHERE [ModuleSystemName] = 'eCom_Quotes'
                </sql>
            </Module>
        </database>
    </package>

    <package version="390" date="14-08-2014" internalversion="8.5.0.0">
        <database file="Access.mdb">
            <AccessUser>
		        <sql conditional="">
                    ALTER TABLE [AccessUser] ADD AccessUserPointBalance FLOAT NULL
                </sql>
	        </AccessUser>
        </database>
    </package>

    <package version="389" date="07-08-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE [TreeUrl] = '/Admin/Module/Recommendation/ModelList.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        96,
		                'Models',
		                7,
		                '/Admin/Module/Recommendation/images/tree/recommendation_models.jpg',
		                '/Admin/Module/Recommendation/ModelList.aspx',
		                'RECOMMENDATIONMODELS',
		                10,
		                'Recommendation'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="388" releasedate="05-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_Quotes'">
                    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleIsBeta], [ModuleAccess])
                    VALUES ('eCom_Quotes', 'Quotes', 1, 0)
                </sql>
            </Module>
            <EcomTree>
                <sql conditional="SELECT COUNT(*) FROM EcomTree WHERE TreeChildPopulate = 'QUOTES'">
                    INSERT INTO EcomTree (parentId, Text, Alt, TreeIcon, TreeIconOpen, TreeUrl, TreeChildPopulate, TreeSort, TreeHasAccessModuleSystemName)
                    VALUES(1, 'Quotes', NULL, NULL, NULL, NULL, 'QUOTES', 4, 'eCom_Quotes')
                </sql>
                <sql conditional="">
                  UPDATE [EcomTree] SET [TreeSort] = 5 WHERE [TreeUrl] = 'RmaList.aspx'
                </sql>
            </EcomTree>
        </database>
    </package>

    <package version="387" date="31-07-2014" internalversion="8.5.0.0">
        <file name="QuoteList.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="QuoteDetail.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
        <file name="NavigationQuotes.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter"  overwrite="false"/>
    </package>

    <package version="386" releasedate="25-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Quotes>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderIsQuote] BIT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomOrderFlow] ADD [OrderFlowOrderType] INT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomOrderStates] ADD [OrderStateOrderType] INT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    CREATE TABLE [EcomOrderStateRules]
                    (
	                    OrderStateRuleId INT IDENTITY(1,1) NOT NULL,
	                    OrderStateRuleFromState NVARCHAR(50) NOT NULL,
	                    OrderStateRuleToState NVARCHAR(50) NOT NULL,
	                    CONSTRAINT DW_PK_EcomOrderStateRules PRIMARY KEY CLUSTERED (OrderStateRuleId ASC)
                    ) 
                </sql>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = 'Lists/EcomOrderFlow_List.aspx?OrderType=quotes'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        92,
		                'Quote flows',
		                7,
		                'tree/btn_quotes.png',
		                'Lists/EcomOrderFlow_List.aspx?OrderType=quotes',
		                'QUOTESFLOW',
		                72,
		                'eCom_CartV2'
                    )
                </sql>
            </Quotes>
        </database>
    </package>
    
    <package version="385" releasedate="25-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/Module/eCom_Catalog/dw7/lists/EcomOrderDiscount_List.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        92,
                        'Discount matrix',
                        NULL,
                        '/Admin/Module/eCom_Catalog/images/buttons/btn_discount.gif',
                        '/Admin/Module/eCom_Catalog/dw7/lists/EcomOrderDiscount_List.aspx',
                        'ORDERDISCOUNTSLIST',
                        31,
                        ''
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="384" releasedate="11-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <TotalDiscount>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderTotalDiscountWithVAT] FLOAT NULL,
                                                 [OrderTotalDiscountWithoutVAT] FLOAT NULL,
                                                 [OrderTotalDiscountVAT] FLOAT NULL,
                                                 [OrderTotalDiscountVATPercent] FLOAT NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLineTotalDiscountWithVAT] FLOAT NULL,
                                                     [OrderLineTotalDiscountWithoutVAT] FLOAT NULL,
                                                     [OrderLineTotalDiscountVAT] FLOAT NULL,
                                                     [OrderLineTotalDiscountVATPercent] FLOAT NULL
                </sql>
            </TotalDiscount>
        </database>
    </package>

    <package version="383" releasedate="11-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigOrderDiscounts_Edit.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        94,
                        'Discount matrix',
                        NULL,
                        '/Admin/Module/eCom_Catalog/images/buttons/btn_discount.gif',
                        '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigOrderDiscounts_Edit.aspx',
                        'ORDERDISCOUNTS',
                        72,
                        ''
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="382" releasedate="11-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomOrderDiscount>
                <sql conditional="">
                    CREATE TABLE [EcomDiscount]
                    (
	                    DiscountId BIGINT IDENTITY(1,1) NOT NULL,
	                    DiscountType INT NOT NULL CONSTRAINT DW_DF_EcomDiscount_Type DEFAULT 0,
	                    DiscountName NVARCHAR(255) NULL,
	                    DiscountActive BIT NOT NULL CONSTRAINT DW_DF_EcomDiscount_Active DEFAULT 1,
	                    DiscountValidFrom DATETIME NULL,
	                    DiscountValidTo DATETIME NULL,
	                    DiscountDiscountType INT NOT NULL CONSTRAINT DW_DF_EcomDiscount_DiscountType DEFAULT 0,
	                    DiscountAmount FLOAT NULL,
	                    DiscountCurrencyCode NVARCHAR(3) NULL,
	                    DiscountPercentage FLOAT NULL,
	                    DiscountProductId NVARCHAR(30) NULL,
	                    DiscountProductVariantId NVARCHAR(255) NULL,
	                    DiscountGroupId NVARCHAR(50) NULL,
	                    DiscountShopId  NVARCHAR(255) NULL,                           
	                    DiscountLanguageId NVARCHAR(50) NULL,
	                    DiscountProductQuantification INT NOT NULL CONSTRAINT DW_DF_EcomDiscount_ProductQuantification DEFAULT 0, 
	                    DiscountProductQuantity FLOAT NULL,
	                    DiscountAccessUserId INT NULL,
	                    DiscountAccessUserGroupId INT NULL,
	                    DiscountAccessUserCustomerNumber NVARCHAR(255) NULL,
	                    DiscountCountryCode2 NVARCHAR(2) NULL,
	                    DiscountShippingId NVARCHAR(50) NULL,
	                    DiscountPaymentId NVARCHAR(50) NULL,
	                    DiscountOrderFieldName NVARCHAR(255) NULL,
	                    DiscountOrderFieldValue NVARCHAR(MAX) NULL,
	                    DiscountVoucherListId INT NULL,
	                    DiscountOrderTotalPriceCondition INT NOT NULL CONSTRAINT DW_DF_EcomDiscount_OrderTotalPriceCondition DEFAULT 5,
	                    DiscountOrderTotalPrice FLOAT NULL,
	                    CONSTRAINT DW_PK_EcomDiscount PRIMARY KEY CLUSTERED (DiscountId ASC)
                    ) 
                </sql>
                <sql conditional="">
                        CREATE NONCLUSTERED INDEX [DW_IX_EcomDiscount_Type] 
                        ON [EcomDiscount] (
                            [DiscountType] ASC
                        )
                        INCLUDE 
                            ([DiscountId])
                </sql>
            </EcomOrderDiscount>
            <EcomOrderDiscountTranslation>
                <sql conditional="">
                        CREATE TABLE [EcomDiscountTranslation]
                        (
	                        DiscountTranslationAutoId BIGINT IDENTITY(1,1) NOT NULL,
	                        DiscountTranslationDiscountId BIGINT NOT NULL,
	                        DiscountTranslationLanguageId NVARCHAR(255) NOT NULL,
	                        DiscountTranslationName NVARCHAR(255) NOT NULL,
	                        CONSTRAINT DW_PK_EcomDiscountTranslation PRIMARY KEY (DiscountTranslationDiscountId ASC, DiscountTranslationLanguageId ASC)
                        )
                </sql>
                <sql conditional="">
                        CREATE UNIQUE CLUSTERED INDEX DW_IX_EcomDiscountTranslation_AutoId
                        ON [EcomDiscountTranslation]
                        (
                                [DiscountTranslationAutoId] ASC
                        )
                </sql>
                <sql conditional="">
                        CREATE NONCLUSTERED INDEX [DW_IX_EcomDiscountTranslation_LanguageId] 
                        ON [EcomDiscountTranslation] (
                            [DiscountTranslationLanguageId] ASC
                        )
                        INCLUDE 
                            ([DiscountTranslationAutoId])
                </sql>
                 <sql conditional="">
                        CREATE NONCLUSTERED INDEX [DW_IX_EcomDiscountTranslation_DiscountId] 
                        ON [EcomDiscountTranslation] (
                            [DiscountTranslationDiscountId] ASC
                        )
                        INCLUDE 
                            ([DiscountTranslationAutoId]) 
                </sql>
            </EcomOrderDiscountTranslation>
        </database>
    </package>

    <package version="381" releasedate="11-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <TotalDiscount>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_OrderDebuggingInfo_OrderId] 
                    ON [EcomOrderDebuggingInfo] (
                        [OrderDebuggingInfoOrderId] ASC
                    )
                    INCLUDE 
                        ([OrderDebuggingInfoId])    
                </sql>
            </TotalDiscount>
        </database>
    </package>

    <package version="380" releasedate="10-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/module/eCom_Catalog/dw7/Lists/EcomReward_List.aspx?update=true'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        93,
                        'Loyalty points',
                        NULL,
                        '/Admin/Module/eCom_Catalog/dw7/images/tree/eCom_LoyaltyPoints_Settings_small.png',
                        '/Admin/module/eCom_Catalog/dw7/Lists/EcomReward_List.aspx?update=true',
                        'LOYALTYPOINTS',
                        43,
                        'LoyaltyPoints'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="379" releasedate="03-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomOrderStates>
                <sql conditional="">
                    ALTER TABLE [EcomOrderStates] ADD [OrderStateSortOrder] INT NULL
                </sql>
            </EcomOrderStates>
        </database>
    </package>

    <package version="378" releasedate="02-07-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <ReverseChargeForVat>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLineReverseChargeForVat] BIT
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomVatCountryRelations] ADD [VatCountryRelReverseChargeForVat] BIT
                </sql>
            </ReverseChargeForVat>
        </database>
    </package>

        <package version="377" releasedate="02-07-2014" internalversion="8.5.0.0">
            <database file="ecom.mdb">
                <EcomOrders>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderTotalPoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrders] ALTER COLUMN [OrderTotalPoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderTotalPoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrders] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderTotalRewardPoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrders] ALTER COLUMN [OrderTotalRewardPoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderTotalRewardPoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrders] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                </EcomOrders>
                <EcomOrderLines>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderLineUnitPoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrderLines] ALTER COLUMN [OrderLineUnitPoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderLineUnitPoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrderLines] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderLineUnitRewardPoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrderLines] ALTER COLUMN [OrderLineUnitRewardPoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderLineUnitRewardPoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrderLines] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderLinePoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrderLines] ALTER COLUMN [OrderLinePoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderLinePoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrderLines] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderLineRewardPoints' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrderLines] ALTER COLUMN [OrderLineRewardPoints] FLOAT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderLineRewardPoints' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrderLines] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                    <sql conditional="">
                        IF EXISTS( SELECT object_id FROM sys.columns WHERE ( name = 'OrderLineRewardId' ) AND ( is_nullable = 0 ) )
	                        BEGIN
		                        ALTER TABLE [EcomOrderLines] ALTER COLUMN [OrderLineRewardId] INT NULL
		                        DECLARE @defaultName NVARCHAR(100) 
		                        SELECT @defaultName = OBJECT_NAME(default_object_id) FROM sys.columns WHERE ( name = 'OrderLineRewardId' )
		                        IF NOT @defaultName = ''
			                        EXEC('ALTER TABLE [EcomOrderLines] DROP CONSTRAINT ' + @defaultName)
	                        END
                    </sql>
                </EcomOrderLines>
            </database>
        </package>

        <package version="376" releasedate="02-07-2014" intervalversion="8.5.0.0">
            <database file="Dynamic.mdb">
                <Module>
                    <sql conditional="SELECT ModuleId FROM [Module] WHERE ModuleSystemName = 'eCom_ContextVoucherRenderer'">
                        INSERT INTO Module (
                             [ModuleSystemName]
                            ,[ModuleName]
                            ,[ModuleAccess]
                            ,[ModuleParagraph]
                            ,[ModuleEcomNotInstalledAccess]
                        )
                        VALUES
                        (
                            'eCom_ContextVoucherRenderer'
                            ,'Context Voucher Renderer'
                            ,1
                            ,1
                            ,0
                        )
                    </sql>
                </Module>
            </database>
        </package>

        <package version="375" releasedate="11-06-2014" internalversion="8.5.0.0">
            <database file="Ecom.mdb">
                <Ecom7Tree>
                    <sql conditional="">
                        UPDATE [Ecom7Tree] SET [TreeHasAccessModuleSystemName] = 'eCom_Assortments' WHERE [TreeUrl] = '/Admin/Module/Ecom_cpl.aspx?cmd=9'
                    </sql>
                </Ecom7Tree>
            </database>
        </package>

        <package version="374" releasedate="11-06-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigBoosting_Edit.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        94,
                        'Boosting',
                        7,
                        '/Admin/Images/Ribbon/Icons/Small/data_find.png',
                        '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigBoosting_Edit.aspx',
                        'BOOSTING',
                        130,
                        ''
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>
    
        

        <package version="373" releasedate="03-06-2014" internalversion="8.5.0.0">
            <database file="Dynamic.mdb">
                <Module>
                    <sql conditional="">
                        UPDATE Module SET [ModuleParagraph] = 1 WHERE [ModuleSystemName] = 'eCom_ContextVoucherRenderer'
                    </sql>
                </Module>
            </database>
        </package>

        <package version="372" releasedate="03-06-2014" internalversion="8.5.0.0">        
        </package>


        <package version="371" releasedate="02-06-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigLoyaltyPoints_Edit.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        94,
                        'Loyalty points',
                        NULL,
                        '/Admin/Module/eCom_Catalog/dw7/images/tree/eCom_LoyaltyPoints_Settings_small.png',
                        '/Admin/Module/eCom_Catalog/dw7/edit/EcomAdvConfigLoyaltyPoints_Edit.aspx',
                        'LOYALTYPOINTS',
                        73,
                        'LoyaltyPoints'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>


    <package version="370" date="26-05-2014" internalversion="8.5.0.0">
	    <database file="Ecom.mdb">
	        <EcomLoyaltyUserTransaction>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomLoyaltyUserTransaction' ) )
                        CREATE TABLE EcomLoyaltyUserTransaction
                        (
                            LoyaltyUserTransactionId BIGINT NOT NULL IDENTITY(1,1),
                            LoyaltyUserTransactionUserId INT NOT NULL ,
                            LoyaltyUserTransactionRewardId INT NULL,
                            LoyaltyUserTransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
                            LoyaltyUserTransactionPoints FLOAT NOT NULL,
                            LoyaltyUserTransactionObjectType NVARCHAR(255) NULL DEFAULT NULL,
                            LoyaltyUserTransactionObjectElement NVARCHAR(255) NULL DEFAULT NULL,
                            LoyaltyUserTransactionComment NVARCHAR(255) NULL DEFAULT NULL,
                            CONSTRAINT DW_PK_EcomLoyaltyUserTransaction PRIMARY KEY CLUSTERED (LoyaltyUserTransactionId ASC),
                        )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyUserTransaction_UserId] 
                    ON [EcomLoyaltyUserTransaction] 
                        ([LoyaltyUserTransactionUserId] ASC)
                    INCLUDE 
                        ([LoyaltyUserTransactionId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyUserTransaction_RewardId] 
                    ON [EcomLoyaltyUserTransaction] 
                        ([LoyaltyUserTransactionRewardId] ASC)
                    INCLUDE 
                        ([LoyaltyUserTransactionId])
                </sql>
	        </EcomLoyaltyUserTransaction>
	        <EcomLoyaltyReward>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomLoyaltyReward' ) )
                        CREATE TABLE EcomLoyaltyReward
                        (
                            LoyaltyRewardId INT NOT NULL IDENTITY(1,1) ,
                            LoyaltyRewardName NVARCHAR(50) NOT NULL ,
                            LoyaltyRewardType INT NOT NULL ,
                            LoyaltyRewardActive BIT NOT NULL DEFAULT 1,
                            LoyaltyRewardPoints FLOAT NULL DEFAULT NULL,
                            LoyaltyRewardCurrencyCode NVARCHAR(3) NULL DEFAULT NULL,
                            LoyaltyRewardRoundingId NVARCHAR(50) NULL DEFAULT NULL,
                            LoyaltyRewardPercentage FLOAT NULL DEFAULT NULL,
                            CONSTRAINT DW_PK_EcomLoyaltyReward PRIMARY KEY CLUSTERED (LoyaltyRewardId ASC),
                        )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyReward_Active] 
                    ON [EcomLoyaltyReward] 
                        ([LoyaltyRewardActive] ASC)
                    INCLUDE 
                        ([LoyaltyRewardId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyReward_CurrencyCode] 
                    ON [EcomLoyaltyReward] 
                        ([LoyaltyRewardCurrencyCode] ASC)
                    INCLUDE 
                        ([LoyaltyRewardId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyReward_RoundingId] 
                    ON [EcomLoyaltyReward] 
                        ([LoyaltyRewardRoundingId] ASC)
                    INCLUDE 
                        ([LoyaltyRewardId])                    
                </sql>
	        </EcomLoyaltyReward>
	        <EcomLoyaltyRewardTranslation>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomLoyaltyRewardTranslation' ) )
                        CREATE TABLE EcomLoyaltyRewardTranslation
                        (
                            LoyaltyRewardTranslationAutoId INT NOT NULL IDENTITY(1,1),
                            LoyaltyRewardTranslationRewardId INT NOT NULL,
                            LoyaltyRewardTranslationLanguageId NVARCHAR(50) NOT NULL,
                            LoyaltyRewardTranslationName NVARCHAR(50) NOT NULL,
                            CONSTRAINT DW_PK_EcomLoyaltyRewardTranslation PRIMARY KEY NONCLUSTERED (LoyaltyRewardTranslationLanguageId ASC, LoyaltyRewardTranslationRewardId ASC)
                        )
                </sql>
		        <sql conditional="">
                    CREATE CLUSTERED INDEX [DW_IX_EcomLoyaltyRewardTranslation_AutoId] 
                    ON [EcomLoyaltyRewardTranslation] 
                        ([LoyaltyRewardTranslationAutoId] ASC)
                </sql>
	        </EcomLoyaltyRewardTranslation>
	        <EcomLoyaltyRewardRule>
		        <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomLoyaltyRewardRule' ) )
                        CREATE TABLE EcomLoyaltyRewardRule
                        (
                            LoyaltyRewardRuleId INT NOT NULL IDENTITY(1,1),
                            LoyaltyRewardRuleRewardId INT NOT NULL, 
                            LoyaltyRewardRuleShopId NVARCHAR(255) NULL DEFAULT NULL,
                            LoyaltyRewardRuleGroupId NVARCHAR(50) NULL DEFAULT NULL,
                            LoyaltyRewardRuleProductId NVARCHAR(30) NULL DEFAULT NULL,
                            LoyaltyRewardRuleProductVariantId NVARCHAR(255) NULL DEFAULT NULL,
                            LoyaltyRewardRuleProductLanguageId NVARCHAR(255) NULL DEFAULT NULL,
                            CONSTRAINT DW_PK_EcomLoyaltyRewardRule PRIMARY KEY CLUSTERED (LoyaltyRewardRuleId ASC),
                        )
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyRewardRule_RewardId] 
                    ON [EcomLoyaltyRewardRule] 
                        ([LoyaltyRewardRuleRewardId] ASC)
                    INCLUDE 
                        ([LoyaltyRewardRuleId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyRewardRule_ShopId] 
                    ON [EcomLoyaltyRewardRule] 
                        ([LoyaltyRewardRuleShopId] ASC)
                    INCLUDE 
                        ([LoyaltyRewardRuleId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyRewardRule_GroupId] 
                    ON [EcomLoyaltyRewardRule] 
                        ([LoyaltyRewardRuleGroupId] ASC)
                    INCLUDE 
                        ([LoyaltyRewardRuleId])                    
                </sql>
		        <sql conditional="">
                    CREATE NONCLUSTERED INDEX [DW_IX_EcomLoyaltyRewardRule_ProductLanguageId_ProductVariantId_ProductId] 
                    ON [EcomLoyaltyRewardRule] 
                        ([LoyaltyRewardRuleProductLanguageId] ASC,
                        [LoyaltyRewardRuleProductVariantId] ASC,
                        [LoyaltyRewardRuleProductId] ASC)
                    INCLUDE 
                        ([LoyaltyRewardRuleId])                    
                </sql>
	        </EcomLoyaltyRewardRule>
	        <EcomProducts>
		        <sql conditional="">
                    ALTER TABLE [EcomProducts]  ADD ProductPoints FLOAT NULL DEFAULT NULL
                </sql>
	        </EcomProducts>
	        <EcomOrders>
		        <sql conditional="">
                    ALTER TABLE [EcomOrders]  ADD OrderTotalPoints FLOAT NULL DEFAULT NULL, 
                                                  OrderTotalRewardPoints FLOAT NULL DEFAULT NULL
                </sql>
	        </EcomOrders>
	        <EcomOrderLines>
		        <sql conditional="">
                    ALTER TABLE [EcomOrderLines]  ADD OrderLineUnitPoints FLOAT NULL DEFAULT NULL, 
                                                      OrderLineUnitRewardPoints FLOAT NULL DEFAULT NULL,
                                                      OrderLinePoints FLOAT NULL DEFAULT NULL,
                                                      OrderLineRewardPoints FLOAT NULL DEFAULT NULL,
                                                      OrderLineRewardId INT NULL DEFAULT NULL
                </sql>
	        </EcomOrderLines>
	    </database>
    </package>

    <package version="369" date="14-05-2014" internalversion="8.5.0.0">
	    <database file="Ecom.mdb">
	        <EcomSalesDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomSalesDiscount]  ADD SalesDiscountMinimumBasketSize FLOAT NULL
                </sql>
	        </EcomSalesDiscount>
	    </database>
    </package>

    <package version="368" releasedate="07-05-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomOrderLines>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLinePriceCalculationReference] NVARCHAR(255) NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLineUnitPriceCalculationReference] NVARCHAR(255) NULL
                </sql>
            </EcomOrderLines>
        </database>
    </package>

    <package version="367" releasedate="08-05-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <ProductUnitCounter>
                <sql conditional="">
                    UPDATE EcomProducts
                    SET ProductUnitCounter = (SELECT DISTINCT COUNT(StockUnitID) FROM EcomStockUnit WHERE StockUnitProductID=ProductID)
                    WHERE ProductUnitCounter = 0
                </sql>
            </ProductUnitCounter>
        </database>
    </package>

    <package version="366" releasedate="05-05-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomFilterDefinition>
                <sql conditional="">
                    ALTER TABLE [EcomFilterDefinition] ADD [EcomFilterDefinitionSorting] INT NULL
                </sql>
            </EcomFilterDefinition>
        </database>
    </package>

    <package version="365" date="28-04-2014" internalversion="8.4.1.0">
        <file name="PostDanmarkServicePoints.html" source="/Files/Templates/eCom7/ShippingProvider/" target="/Files/Templates/eCom7/ShippingProvider/" overwrite="false"/>
        <file name="PostDanmarkServicePoints_Ajax.html" source="/Files/Templates/eCom7/ShippingProvider/" target="/Files/Templates/eCom7/ShippingProvider/" overwrite="false"/>
    </package>

    <package version="364" releasedate="09-04-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomProductGroupField>
                <sql conditional="">
                    ALTER TABLE [EcomProductGroupField] ADD [ProductGroupFieldRequired] BIT NULL
                </sql>
            </EcomProductGroupField>
        </database>
    </package>


    <package version="363" releasedate="03-02-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'OrderPriceCalculationDate' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EcomOrders' ) ) ) )
                        ALTER TABLE [EcomOrders] ADD OrderPriceCalculationDate DATETIME NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EcomOrders] ADD OrderPriceCalculationDate DATETIME NULL
                </sql>
            </EcomOrders>
        </database>

        <file name="PaymentWindowPostTemplate.html" target="/Files/Templates/eCom7/CheckoutHandler/DIBS/Post" source="/Files/Templates/eCom7/CheckoutHandler/DIBS/Post" />
    </package>

    <package version="362" releasedate="04-04-2014" internalversion="8.4.1.0">        
    </package>

    <package version="361" releasedate="03-04-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomFilters>
                <sql conditional="SELECT CASE WHEN COUNT(*) > 0 THEN 0 ELSE 1 END AS [AllowClean] FROM [EcomProductCategory]">
                    SELECT [EcomFilterSettingDefinitionID]
                    INTO #OldCategories
                      FROM [EcomFilterSetting]
                      WHERE
                      [EcomFilterSettingName] = 'Field'
                      AND [EcomFilterSettingValue] LIKE 'CF_[[]%'
                      AND CHARINDEX(']', [EcomFilterSettingValue], 5) > 5
                      AND NOT SUBSTRING([EcomFilterSettingValue], 5, CHARINDEX(']', [EcomFilterSettingValue], 5) - 5) IN (SELECT CategoryId  FROM [EcomProductCategory]);

                    DELETE FROM [EcomFilterDefinitionTranslation] WHERE [EcomFilterDefinitionTranslationFilterDefinitionID] IN (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DELETE FROM [EcomGroupFilterSetting] WHERE [EcomGroupFilterSettingDefinitionID] IN (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DELETE FROM [EcomGroupFilterOption] WHERE [EcomGroupFilterOptionDefinitionID]  IN (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DELETE FROM [EcomFilterSetting] WHERE [EcomFilterSettingDefinitionID] IN (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DELETE FROM [EcomFilterVisibilityCondition] WHERE [EcomFilterVisibilityConditionDefinitionID] IN  (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DELETE FROM [EcomFilterDefinition] WHERE [EcomFilterDefinitionID] IN (SELECT [EcomFilterSettingDefinitionID] FROM  #OldCategories);
                    DROP TABLE #OldCategories;
                </sql>
            </EcomFilters>
        </database>
    </package>

    <package version="360" releasedate="30-04-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [ParentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = '/Admin/Module/Ecom_cpl.aspx?cmd=9'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [ParentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        94,
                        'Assortments',
                        NULL,
                        '/Admin/Images/eCom/Module_eCom_Assortments_small.gif',
                        '/Admin/Module/Ecom_cpl.aspx?cmd=9',
                        'ASSORTMENTS',
                        75,
                        'eCom_Catalog'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>
        
    <package version="359" releasedate="22-04-2014" internalversion="8.5.0.0">
        <file name="ReceiptTaxes.html" target="Files/Templates/eCom7/CartV2/Step" source="Files/Templates/eCom7/CartV2/Step" />
    </package>

    <package version="358" releasedate="27-03-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomPrices>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EcomPrices_ProductId_ProductVariantId_ProductLanguageId' ) )
	                    CREATE NONCLUSTERED INDEX [DW_IX_EcomPrices_ProductId_ProductVariantId_ProductLanguageId] 
	                    ON [EcomPrices] 
	                    (
		                    [PriceProductID] ASC,
		                    [PriceProductVariantID] ASC,
		                    [PriceProductLanguageID] ASC
	                    )
	                    INCLUDE 
	                    (
		                    [PriceCurrency],
		                    [PriceQuantity],
		                    [PriceUnitID],
		                    [PricePeriodID],
		                    [PriceUserCustomerNumber],
		                    [PriceCountry],
		                    [PriceShopId],
		                    [PriceValidFrom],
		                    [PriceValidTo],
		                    [PriceUserId],
		                    [PriceUserGroupId],
		                    [PriceAmount]
	                    )
                </sql>
            </EcomPrices>
        </database>
    </package>

    <package version="357" releasedate="27-03-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomPrices>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE ( name = N'DW_IX_EcomPrices_AutoId' ) )
	                    CREATE UNIQUE CLUSTERED INDEX [DW_IX_EcomPrices_AutoId]
	                    ON [EcomPrices]([PriceAutoId] ASC)
                </sql>
            </EcomPrices>
        </database>
    </package>

    <package version="356" releasedate="27-03-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomPrices>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'PriceAutoId' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EcomPrices' ) ) ) )
	                    ALTER TABLE [EcomPrices] ADD [PriceAutoId] INT NOT NULL IDENTITY(1,1)
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EcomPrices] ADD [PriceAutoId] INT NOT NULL IDENTITY(1,1)
                </sql>
            </EcomPrices>
        </database>
    </package>

    <package version="355" releasedate="24-03-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomProducts>
                <sql conditional="">
                    IF EXISTS (SELECT * FROM sys.indexes WHERE name = N'EverythingIndex_on_EcomProducts')
	                    DROP INDEX EverythingIndex_on_EcomProducts 
	                    ON EcomProducts
                </sql>
                <sql conditional="">
                    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'DW_IX_EcomProducts_AutoId' )
	                    CREATE UNIQUE CLUSTERED INDEX DW_IX_EcomProducts_AutoId 
	                    ON EcomProducts
	                    (
		                    ProductAutoId ASC
	                    )
                </sql>
            </EcomProducts>
        </database>
    </package>

    <package version="354" releasedate="19-03-2014" internalversion="8.4.1.0">
        <file name="Navigation.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
        <file name="NavigationFull.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
        <file name="NavigationRMA.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
    </package>

    <package version="353" releasedate="28-02-2014" internalversion="8.4.1.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_BackCatalog' AND [ModuleEcomNotInstalledAccess] = 0">
                    UPDATE Module SET [ModuleEcomNotInstalledAccess] = 0 WHERE [ModuleSystemName] = 'eCom_ShowList'
                </sql>
            </Module>
        </database>
    </package>

     <package version="352" date="25-02-2014" internalversion="8.4.1.0">
		<database file="Dynamic.mdb">
			<EcomPeriods>
				<sql conditional="">
                    ALTER TABLE EcomPeriods ADD PeriodHidden BIT NOT NULL DEFAULT blnFalse
				</sql>     		
          	</EcomPeriods>
            <EcomTree>
                <sql conditional="">
                    UPDATE EcomTree SET [Text] = 'Publication periods' WHERE [Text] LIKE 'Kampagner'
                </sql>
          	</EcomTree>		
            <Ecom7Tree>
                <sql conditional="">
                    UPDATE Ecom7Tree SET [Text] = 'Publication periods' WHERE [Text] LIKE 'Kampagner'
                </sql>
          	</Ecom7Tree>			  
		</database>
    </package>

    <package version="351" releasedate="07-02-2014" internalversion="8.4.1.0">
        <file name="ProductListCustomerCenterList.html" target="/Files/Templates/eCom/ProductList" source="/Files/Templates/eCom/ProductList" />
        <file name="FavoritesList.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
        <file name="MyList.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
    </package>

    <package version="350" releasedate="06-02-2014" internalversion="8.4.1.0">
        <file name="Post.html" target="Files/Templates/eCom7/CheckoutHandler/ePay/Post" source="Files/Templates/eCom7/CheckoutHandler/ePay/Post" />
        <file name="Post_simple.html" target="Files/Templates/eCom7/CheckoutHandler/ePay/Post" source="Files/Templates/eCom7/CheckoutHandler/ePay/Post" />
        <file name="Cancel.html" target="Files/Templates/eCom7/CheckoutHandler/ePay/Cancel" source="Files/Templates/eCom7/CheckoutHandler/ePay/Cancel" />
        <file name="Error.html" target="Files/Templates/eCom7/CheckoutHandler/ePay/Error" source="Files/Templates/eCom7/CheckoutHandler/ePay/Error" />
    </package>

    <package version="349" releasedate="05-02-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomOrderLines>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'OrderLineWishListId' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EcomOrderLines' ) ) ) )
                        ALTER TABLE [EcomOrderLines] ADD OrderLineWishListId INT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EcomOrderLines] ADD OrderLineWishListId INT NOT NULL DEFAULT 0
                </sql>
            </EcomOrderLines>
        </database>
    </package>

    <package version="348" releasedate="04-02-2014" internalversion="8.4.1.0">
    </package>

    <package version="347" releasedate="04-02-2014" internalversion="8.4.1.0">        
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_Vouchers'">
                    INSERT INTO [Module]    (   [ModuleSystemName]  , [ModuleName]  , [ModuleAccess], [ModuleParagraph] , [ModuleEcomNotInstalledAccess]    , [ModuleIsBeta])
                    VALUES                  (   'eCom_Vouchers'     , 'Vouchers'    , blnFalse      , blnFalse          , blnFalse                          , blnFalse      )                    
                </sql>
            </Module>
        </database>
    </package>

    <package version="346" date="13-03-2014" internalversion="8.5.0.0">
	    <database file="Ecom.mdb">
            <EcomOrderStates>
                <sql conditional="">ALTER TABLE [EcomOrderStates] ADD 
                                        [OrderStateSendToCustomer] BIT NULL,
                                        [OrderStateOthersMailTemplate] NVARCHAR(255) NULL,
                                        [OrderStateOthersRecipients] NVARCHAR(MAX) NULL
                </sql>
                <sql conditional="">
                    UPDATE [EcomOrderStates] SET [OrderStateSendToCustomer] = blnTrue WHERE [OrderStateSendToCustomer] IS NULL AND [OrderStateMailTemplate] IS NOT NULL
                </sql>
            </EcomOrderStates>
        </database>
    </package>

    <package version="345" releasedate="04-03-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomAssortmentItems>
                <sql conditional="">
                    IF NOT EXISTS( SELECT index_id FROM sys.indexes WHERE ( name = 'DW_IX_EcomAssortmentItems_ProductID' ) )
	                    CREATE NONCLUSTERED INDEX [DW_IX_EcomAssortmentItems_ProductID] ON [dbo].[EcomAssortmentItems] 
	                    (
		                    [AssortmentItemProductID] ASC
	                    )
	                    INCLUDE ([AssortmentItemAssortmentID],[AssortmentItemProductVariantID],[AssortmentItemAutoID]) 
                </sql>
            </EcomAssortmentItems>
            <EcomProducts>
                <sql conditional="">
                    IF NOT EXISTS( SELECT index_id FROM sys.indexes WHERE ( name = 'DW_IX_EcomProducts_Active_LanguageID_VariantID_ProductID_Name' ) )
	                    CREATE UNIQUE NONCLUSTERED INDEX [DW_IX_EcomProducts_Active_LanguageID_VariantID_ProductID_Name] ON [dbo].[EcomProducts] 
	                    (
		                    [ProductActive] ASC,
		                    [ProductLanguageID] ASC,
		                    [ProductVariantID] ASC,
		                    [ProductID] ASC,
		                    [ProductName] ASC
	                    )
                </sql>
            </EcomProducts>
            <EcomGroupProductRelation>
                <sql conditional="">
                    IF NOT EXISTS( SELECT index_id FROM sys.indexes WHERE ( name = 'DW_IX_EcomGroupProductRelation_GroupID_ProductID' ) )
	                    CREATE UNIQUE NONCLUSTERED INDEX [DW_IX_EcomGroupProductRelation_GroupID_ProductID] ON [dbo].[EcomGroupProductRelation] 
	                    (
		                    [GroupProductRelationProductID] ASC,
		                    [GroupProductRelationGroupID] ASC
	                    )
	                    INCLUDE ([GroupProductRelationSorting],[GroupProductRelationId]) 
                </sql>
            </EcomGroupProductRelation>
        </database>
    </package>
    
    <package version="344" releasedate="11-02-2014" internalversion="8.5.0.0">
        <database file="Ecom.mdb">
            <EcomAssortments>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortments' ) )
                        CREATE TABLE EcomAssortments
                        (
	                        AssortmentID NVARCHAR(50) NOT NULL,
	                        AssortmentLanguageID NVARCHAR(50) NOT NULL,
	                        AssortmentName NVARCHAR(255) NULL,
	                        AssortmentNumber NVARCHAR(255) NULL,
	                        AssortmentPeriodID NVARCHAR(50) NULL,
	                        AssortmentLastBuildDate DATETIME NULL,
	                        AssortmentRebuildRequired BIT NOT NULL DEFAULT(0),
	                        AssortmentAutoID INT IDENTITY(1,1) NOT NULL,
	                        CONSTRAINT PK_EcomAssortments PRIMARY KEY NONCLUSTERED ( AssortmentID ASC, AssortmentLanguageID ASC ),
	                        CONSTRAINT FK_EcomAssortments_EcomLanguages FOREIGN KEY ( AssortmentLanguageID ) REFERENCES EcomLanguages ( LanguageID ) ON UPDATE CASCADE ON DELETE CASCADE,
	                        CONSTRAINT FK_EcomAssortments_EcomPeriods FOREIGN KEY ( AssortmentPeriodID ) REFERENCES EcomPeriods ( PeriodID ) ON UPDATE CASCADE ON DELETE SET NULL
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortments_AutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortments_AutoID
                                    ON EcomAssortments ( AssortmentAutoID ASC )
                                    WITH ( PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON ) 
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortments_AutoID
                                    ON EcomAssortments ( AssortmentAutoID ASC )
                                    WITH ( PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF ) 
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortments_LanguageID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortments_LanguageID
                                    ON EcomAssortments ( AssortmentLanguageID ASC )
                                    INCLUDE ( AssortmentAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortments_LanguageID
                                    ON EcomAssortments ( AssortmentLanguageID ASC )
                                    INCLUDE ( AssortmentAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortments_PeriodID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortments_PeriodID 
                                    ON EcomAssortments ( AssortmentPeriodID ASC )
                                    INCLUDE ( AssortmentAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortments_PeriodID 
                                    ON EcomAssortments ( AssortmentPeriodID ASC )
                                    INCLUDE ( AssortmentAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
            </EcomAssortments>
            <EcomAssortmentPermissions>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortmentPermissions' ) )
                        CREATE TABLE EcomAssortmentPermissions
                        (
	                        AssortmentPermissionAssortmentID NVARCHAR(50) NOT NULL,
	                        AssortmentPermissionAccessUserID INT NOT NULL,
	                        AssortmentPermissionAutoID INT IDENTITY(1,1) NOT NULL,
	                        CONSTRAINT PK_EcomAssortmentPermissions PRIMARY KEY NONCLUSTERED ( AssortmentPermissionAssortmentID ASC, AssortmentPermissionAccessUserID ASC ),
	                        CONSTRAINT FK_EcomAssortmentPermissions_AccessUser FOREIGN KEY( AssortmentPermissionAccessUserID ) REFERENCES AccessUser ( AccessUserID ) ON UPDATE CASCADE ON DELETE CASCADE
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentPermissions_AutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentPermissions_AutoID 
                                    ON dbo.EcomAssortmentPermissions ( AssortmentPermissionAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentPermissions_AutoID 
                                    ON dbo.EcomAssortmentPermissions ( AssortmentPermissionAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentPermissions_AssortmentID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentPermissions_AssortmentID 
                                    ON EcomAssortmentPermissions ( AssortmentPermissionAssortmentID ASC )
                                    INCLUDE ( AssortmentPermissionAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON ) 
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentPermissions_AssortmentID 
                                    ON EcomAssortmentPermissions ( AssortmentPermissionAssortmentID ASC )
                                    INCLUDE ( AssortmentPermissionAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF ) 
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentPermissions_AccessUserID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentPermissions_AccessUserID
                                    ON EcomAssortmentPermissions ( AssortmentPermissionAccessUserID ASC )
                                    INCLUDE ( AssortmentPermissionAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentPermissions_AccessUserID
                                    ON EcomAssortmentPermissions ( AssortmentPermissionAccessUserID ASC )
                                    INCLUDE ( AssortmentPermissionAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
            </EcomAssortmentPermissions>
            <EcomAssortmentShopRelations>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortmentShopRelations' ) )
	                    CREATE TABLE EcomAssortmentShopRelations
	                    (
		                    AssortmentShopRelationAssortmentID NVARCHAR(50) NOT NULL,
		                    AssortmentShopRelationShopID NVARCHAR(255) NOT NULL,
		                    AssortmentShopRelationAutoID INT NOT NULL IDENTITY(1,1)
		                    CONSTRAINT PK_EcomAssortmentShopRelations PRIMARY KEY NONCLUSTERED ( AssortmentShopRelationAssortmentID, AssortmentShopRelationShopID ),
		                    CONSTRAINT FK_EcomAssortmentShopRelations_EcomShops FOREIGN KEY ( AssortmentShopRelationShopID ) REFERENCES EcomShops ( ShopID ) ON UPDATE CASCADE ON DELETE CASCADE	
	                    )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentShopRelations_AutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentShopRelations_AutoID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON ) 
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentShopRelations_AutoID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF ) 
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentShopRelations_AssortmentID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentShopRelations_AssortmentID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentShopRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentShopRelations_AssortmentID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentShopRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentShopRelations_ShopID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentShopRelations_ShopID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationShopID ASC )
                                    INCLUDE ( AssortmentShopRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentShopRelations_ShopID 
                                    ON EcomAssortmentShopRelations ( AssortmentShopRelationShopID ASC )
                                    INCLUDE ( AssortmentShopRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
	                    END
                </sql>
            </EcomAssortmentShopRelations>
            <EcomAssortmentGroupRelations>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortmentGroupRelations' ) )
	                    CREATE TABLE EcomAssortmentGroupRelations
	                    (
		                    AssortmentGroupRelationAssortmentID NVARCHAR(50) NOT NULL,
		                    AssortmentGroupRelationGroupID NVARCHAR(255) NOT NULL,
		                    AssortmentGroupRelationAutoID INT NOT NULL IDENTITY(1,1)
		                    CONSTRAINT PK_EcomAssortmentGroupRelations PRIMARY KEY NONCLUSTERED ( AssortmentGroupRelationAssortmentID, AssortmentGroupRelationGroupID )
	                    )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentGroupRelations_AutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentGroupRelations_AutoID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentGroupRelations_AutoID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentGroupRelations_AssortmentID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentGroupRelations_AssortmentID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentGroupRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentGroupRelations_AssortmentID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentGroupRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentGroupRelations_GroupID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentGroupRelations_GroupID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationGroupID ASC )
                                    INCLUDE ( AssortmentGroupRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON ) 
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentGroupRelations_GroupID 
                                    ON EcomAssortmentGroupRelations ( AssortmentGroupRelationGroupID ASC )
                                    INCLUDE ( AssortmentGroupRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF ) 
			                    END
	                    END
                </sql>
            </EcomAssortmentGroupRelations>
            <EcomAssortmentProductRelations>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortmentProductRelations' ) )
	                    CREATE TABLE EcomAssortmentProductRelations
	                    (
		                    AssortmentProductRelationAssortmentID NVARCHAR(50) NOT NULL,
		                    AssortmentProductRelationProductID NVARCHAR(30) NOT NULL,
		                    AssortmentProductRelationProductVariantID NVARCHAR(255) NOT NULL,
		                    AssortmentProductRelationAutoID INT NOT NULL IDENTITY(1,1),
		                    AssortmentProductRelationProductNumber NVARCHAR(255) NULL
		                    CONSTRAINT PK_EcomAssortmentProductRelations PRIMARY KEY NONCLUSTERED ( AssortmentProductRelationAssortmentID, AssortmentProductRelationProductID, AssortmentProductRelationProductVariantID )
	                    )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentProductRelations_AssortmentID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentProductRelations_AssortmentID 
                                    ON EcomAssortmentProductRelations ( AssortmentProductRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentProductRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON ) 
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentProductRelations_AssortmentID 
                                    ON EcomAssortmentProductRelations ( AssortmentProductRelationAssortmentID ASC )
                                    INCLUDE ( AssortmentProductRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF ) 
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentProductRelations_ProductID_ProductVariantID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentProductRelations_ProductID_ProductVariantID 
                                    ON EcomAssortmentProductRelations ( AssortmentProductRelationProductID ASC, AssortmentProductRelationProductVariantID ASC )
                                    INCLUDE ( AssortmentProductRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentProductRelations_ProductID_ProductVariantID 
                                    ON EcomAssortmentProductRelations ( AssortmentProductRelationProductID ASC, AssortmentProductRelationProductVariantID ASC )
                                    INCLUDE ( AssortmentProductRelationAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
            </EcomAssortmentProductRelations>
            <EcomAssortmentItems>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.tables WHERE ( name = 'EcomAssortmentItems' ) )
                        CREATE TABLE EcomAssortmentItems
                        (
	                        AssortmentItemAssortmentID NVARCHAR(50) NOT NULL,
	                        AssortmentItemRelationAutoID INT NOT NULL,
	                        AssortmentItemRelationType NVARCHAR(50) NOT NULL,
	                        AssortmentItemLanguageID NVARCHAR(50) NOT NULL,
	                        AssortmentItemProductID NVARCHAR(30) NOT NULL,
	                        AssortmentItemProductVariantID NVARCHAR(255) NOT NULL,
	                        AssortmentItemAutoID INT IDENTITY(1,1) NOT NULL,
	                        CONSTRAINT PK_EcomAssortmentItems PRIMARY KEY NONCLUSTERED ( AssortmentItemAssortmentID ASC, AssortmentItemRelationAutoID ASC, AssortmentItemRelationType ASC, AssortmentItemLanguageID ASC, AssortmentItemProductID ASC, AssortmentItemProductVariantID ASC ),
	                        CONSTRAINT FK_EcomAssortmentItems_EcomAssortments FOREIGN KEY( AssortmentItemAssortmentID, AssortmentItemLanguageID ) REFERENCES EcomAssortments ( AssortmentID, AssortmentLanguageID ) ON UPDATE CASCADE ON DELETE CASCADE
                        )
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentItems_AutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentItems_AutoID 
                                    ON EcomAssortmentItems ( AssortmentItemAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE UNIQUE CLUSTERED INDEX IX_EcomAssortmentItems_AutoID 
                                    ON EcomAssortmentItems ( AssortmentItemAutoID ASC )
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentItems_AssortmentID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
                                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_AssortmentID 
                                    ON EcomAssortmentItems ( AssortmentItemAssortmentID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_AssortmentID 
                                    ON EcomAssortmentItems ( AssortmentItemAssortmentID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentItems_RelationType_RelationAutoID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_RelationType_RelationAutoID 
                                    ON EcomAssortmentItems ( AssortmentItemRelationType ASC, AssortmentItemRelationAutoID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_RelationType_RelationAutoID 
                                    ON EcomAssortmentItems ( AssortmentItemRelationType ASC, AssortmentItemRelationAutoID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
                <sql conditional="">
                    IF NOT EXISTS( SELECT object_id FROM sys.indexes WHERE ( name = 'IX_EcomAssortmentItems_LanguageID_ProductID_ProductVariantID' ) )
	                    BEGIN
		                    IF EXISTS( SELECT 'Enterprise' AS EngineEdition WHERE SERVERPROPERTY('EngineEdition') = 3 )
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_LanguageID_ProductID_ProductVariantID 
                                    ON EcomAssortmentItems ( AssortmentItemLanguageID ASC, AssortmentItemProductID ASC, AssortmentItemProductVariantID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON )
			                    END
		                    ELSE
			                    BEGIN
				                    CREATE NONCLUSTERED INDEX IX_EcomAssortmentItems_LanguageID_ProductID_ProductVariantID 
                                    ON EcomAssortmentItems ( AssortmentItemLanguageID ASC, AssortmentItemProductID ASC, AssortmentItemProductVariantID ASC )
                                    INCLUDE ( AssortmentItemAutoID ) 
                                    WITH ( PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF )
			                    END
	                    END
                </sql>
            </EcomAssortmentItems>
            <EcomNumbers>
                <sql conditional="">
                    IF NOT EXISTS( SELECT NumberID FROM EcomNumbers WHERE ( NumberType = 'ASSORTMENT' ) )
	                    INSERT INTO EcomNumbers ( NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable )
	                    VALUES ( '49', 'ASSORTMENT', 'Assortments', 0, 'ASSORTMENT', '', 1, 0 )
                </sql>
            </EcomNumbers>
        </database>
    </package>

    <package version="343" releasedate="03-02-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'OrderExternalPaymentFee' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EcomOrders' ) ) ) )
                    ALTER TABLE [EcomOrders] ADD OrderExternalPaymentFee FLOAT NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EcomOrders] ADD OrderExternalPaymentFee FLOAT NULL
                </sql>
            </EcomOrders>
        </database>

        <file name="PaymentWindowPostTemplate.html" target="/Files/Templates/eCom7/CheckoutHandler/DIBS/Post" source="/Files/Templates/eCom7/CheckoutHandler/DIBS/Post" />
    </package>

    <package version="342" releasedate="31-01-2014" internalversion="8.4.1.0">
        <file name="PublicList.html" target="/Files/Templates/eCom/CustomerCenter/ShowList" source="/Files/Templates/eCom/CustomerCenter/ShowList" />
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_ShowList'">
                    INSERT INTO [Module]    (   [ModuleSystemName]  , [ModuleName]  , [ModuleAccess], [ModuleParagraph] , [ModuleIsBeta], [ModuleEcomNotInstalledAccess])
                    VALUES                  (   'eCom_ShowList'     , 'Show List'   , blnTrue       , blnTrue           , blnFalse      , 0                             )
                </sql>
            </Module>
        </database>
    </package>

    <package version="341" releasedate="29-01-2014" internalversion="8.4.1.0">
        <database file="Ecom.mdb">
            <EcomOrderLineFields>
                <sql conditional="">
                    IF NOT EXISTS(SELECT * FROM sys.columns WHERE ( name = 'EcomOrderLineFieldsSorting' ) AND ( object_id = ( SELECT object_id FROM sys.tables WHERE ( name = 'EcomOrderLineFields' ) ) ) )
                    ALTER TABLE [EcomOrderLineFields] ADD [EcomOrderLineFieldsSorting] INT NULL
                </sql>
                <sql conditional="SELECT NOW()">
                    ALTER TABLE [EcomOrderLineFields] ADD [EcomOrderLineFieldsSorting] INT NULL
                </sql>
            </EcomOrderLineFields>
        </database>
    </package>

    <package version="340" releasedate="30-01-2014" internalversion="8.4.1.0">
        <file name="MyListEmail.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
    </package>

    <package version="339" releasedate="27-01-2014" internalversion="8.4.0.0">
        <file name="FavoritesList.html" target="/Files/Templates/eCom/CustomerCenter" source="/Files/Templates/eCom/CustomerCenter" />
    </package>

    <package  version="338" releasedate="27-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
			<Module>
				<sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_BackCatalog'">                    
					INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
					VALUES ('eCom_BackCatalog', 'Back Catalog', blnTrue, blnFalse, blnFalse)
				</sql>
			</Module>
		</database>
    </package>

    <package version="337" date="17-01-2014" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomCustomerFavoriteLists>
                <sql conditional="">ALTER TABLE [EcomCustomerFavoriteLists] ADD 
                                                [IsPublished] BIT NOT NULL DEFAULT 0,
                                                [PublishedToDate] DATETIME NULL,
                                                [Type] NVARCHAR(255),
                                                [IsDefault] BIT NOT NULL DEFAULT 0,
                                                [Description] NVARCHAR(MAX),
                                                [PublishedId] NVARCHAR(255)
                </sql>
            </EcomCustomerFavoriteLists>
            <EcomCustomerFavoriteProducts>
                <sql conditional="">ALTER TABLE [EcomCustomerFavoriteProducts] ADD 
                                                [Quantity] INT NULL,
                                                [SortOrder] INT NULL
                </sql>
            </EcomCustomerFavoriteProducts>
        </database>
    </package>

    <package version="336" releasedate="17-01-2014" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomOrderLines>
                <sql conditional="">
                    ALTER TABLE [EcomOrderLines] ADD [OrderLineAttachment] NVARCHAR(MAX) NULL
                </sql>
            </EcomOrderLines>
        </database>
    </package>

    <package version="335" releasedate="16-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
                <sql conditional="">
                    ALTER TABLE EcomOrderDebuggingInfo DROP CONSTRAINT EcomOrderDebuggingInfo$ForeignKeyOrderID‏
                </sql>
            </EcomOrder>
        </database>
    </package>

    <package version="334" releasedate="15-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
                <sql conditional="">
                    CREATE TABLE EcomOrderDebuggingInfo (
                        OrderDebuggingInfoID IDENTITY NOT NULL,
                        OrderDebuggingInfoOrderID NVARCHAR(50) NOT NULL,
                        OrderDebuggingInfoSource NVARCHAR(255) NOT NULL,
                        OrderDebuggingInfoTime DATETIME NOT NULL,
                        OrderDebuggingInfoMessage NVARCHAR(MAX) NOT NULL,
                        OrderDebuggingInfoType INT NOT NULL,
                        CONSTRAINT OrderDebuggingInfo$PrimaryKey PRIMARY KEY([OrderDebuggingInfoID])
                    )
                </sql>
            </EcomOrder>
        </database>
    </package>

    <package version="333" releasedate="10-01-2014" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
	            <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderTransactionCardType] NVARCHAR(20) NULL</sql>
            </EcomOrder>
        </database>
    </package>

    <package version="332" releasedate="29-12-2013" internalversion="8.4.0.0">
        <setting key="/Globalsettings/Ecom/Price/AllowNegativeOrderTotalPrice" value="False" overwrite="False" />
    </package>

    <package version="331" releasedate="26-12-2013" internalversion="8.4.0.0">
    </package>

    <package version="330" releasedate="23-12-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
	            <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCaptureAmount] [Float] NULL</sql>
            </EcomOrder>
        </database>
    </package>

    <package version="329" date="20-12-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomStockLocation >
                <sql conditional="">
                    ALTER TABLE EcomStockLocation ADD [StockLocationGroupID] INT NOT NULL DEFAULT 0
                </sql>
            </EcomStockLocation>
        </database>
    </package>

    <package version="328" date="12-12-2013" internalversion="8.4.0.0">
    </package>

    <package version="327" date="03-12-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomStockUnit>
                <sql conditional="">
                    IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EcomStockUnit]') AND name = N'EcomStockUnit$PrimaryKey')
                        ALTER TABLE EcomStockUnit DROP CONSTRAINT [EcomStockUnit$PrimaryKey]                
                </sql>
                <sql conditional="">
                    ALTER TABLE EcomStockUnit ADD ID IDENTITY PRIMARY KEY
                </sql>
            </EcomStockUnit>
        </database>
    </package>

    <package version="326" releasedate="28-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomStockUnit>
	            <sql conditional="">ALTER TABLE [EcomStockUnit] ADD [StockUnitStockLocationID] [INT] NULL</sql>
            </EcomStockUnit>
        </database>
    </package>

    <package version="325" releasedate="27-11-2013" internalversion="8.4.0.0">
        <file name="OrderList.html" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />
        <file name="OrderList.css" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />
        <file name="OrderDetails.html" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />
        <file name="CreditList.html" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />
        <file name="InvoiceList.html" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />
        <file name="Navigation.html" target="/Files/Templates/Ecom/IntegrationCustomerCenter" source="/Files/Templates/Ecom/IntegrationCustomerCenter" />        
    </package>

    <package version="324" date="26-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShopLanguageRelation>
                <sql conditional="">
                    IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EcomShopLanguageRelation]') AND name = N'EcomShopLanguageRelation$PrimaryKey')
                        ALTER TABLE EcomShopLanguageRelation DROP CONSTRAINT [EcomShopLanguageRelation$PrimaryKey]                
                </sql>
                <sql conditional="">
                    ALTER TABLE EcomShopLanguageRelation ADD ID IDENTITY PRIMARY KEY, IsDefault BIT NOT NULL DEFAULT 0
                </sql>
                <sql conditional="">
                    CREATE INDEX EcomShopLanguageRelationIXIsDefault ON EcomShopLanguageRelation (IsDefault)   
                </sql>
            </EcomShopLanguageRelation>
        </database>
    </package>

    <package version="323" date="26-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShopLanguageRelation>
                <sql conditional="SELECT COUNT(object_id) FROM sys.tables WHERE name = 'EcomShopLanguageRelation'">
                    CREATE TABLE EcomShopLanguageRelation 
                    (
                        ShopID NVARCHAR(255) NOT NULL,
                        LanguageID NVARCHAR(50) NOT NULL
                    )
                </sql>
                <sql conditional="SELECT COUNT(object_id) FROM sys.indexes WHERE name = 'EcomShopLanguageRelationIX'">
                    CREATE UNIQUE INDEX EcomShopLanguageRelationIX ON EcomShopLanguageRelation (ShopID, LanguageID)
                </sql>
            </EcomShopLanguageRelation>
        </database>
    </package>

    <package version="322" date="25-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <Multishop>
                <sql conditional="">
                    CREATE TABLE EcomShopStockLocationRelation (
                        ShopRelationStockLocationID INT NOT NULL,
                        ShopRelationShopID NVARCHAR(255) NOT NULL
                        CONSTRAINT EcomShopStockLocationRelation$PrimaryKey PRIMARY KEY(ShopRelationStockLocationID, ShopRelationShopID)
                    )
                </sql>
            </Multishop>
        </database>
    </package>

    <package version="321" date="25-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShops>
                <sql conditional="">ALTER TABLE [EcomShops] DROP [ShopStockLocationIDs]</sql>
            </EcomShops>
        </database>
    </package>

    <package version="320" releasedate="25-11-2013" internalversion="8.4.0.0">
    </package>
    
    <package version="319" releasedate="24-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomOrder>
	            <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderReceiptShowCount] [INT] NULL</sql>
            </EcomOrder>
        </database>
    </package>

    <package version="318" releasedate="22-11-2013" internalversion="8.4.0.0">
        <database file="Dynamic.mdb">
            <EcomPrices>
	            <sql conditional="">ALTER TABLE [EcomPrices] ADD [PriceUserCustomerNumber] [nvarchar](255) NULL</sql>
            </EcomPrices>
        </database>
    </package>

    <package version="317" date="20-11-2013" internalversion="8.4.0.0">
	<database file="Dynamic.mdb">
	  <module>		
		<sql conditional="SELECT COUNT(ModuleSystemName) FROM [Module] WHERE [ModuleSystemName] = 'eCom_ContextOrderRenderer'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_ContextOrderRenderer', 'Context Order Renderer', '', 0, 1, 0, 0, 1)</sql>
	  </module>
	</database>
  </package>

    <package version="316" date="20-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomStockLocation>
                <sql conditional="">ALTER TABLE [EcomStockLocation] WITH CHECK ADD CONSTRAINT [EcomStockLocation_PrimaryKey] PRIMARY KEY([StockLocationID]) </sql>
            </EcomStockLocation>
        </database>
    </package>

    <package version="315" date="20-11-2013" internalversion="8.4.0.0">
	<database file="Dynamic.mdb">
	  <module>		
		<sql conditional="SELECT COUNT(ModuleSystemName) FROM [Module] WHERE [ModuleSystemName] = 'eCom_IntegrationCustomerCenter'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_IntegrationCustomerCenter', 'Integration Customer Center', '', 0, 1, 0, 0, 1)</sql>
	  </module>
	</database>
  </package>

    <package version="314" date="19-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShops>
                <sql conditional="">ALTER TABLE [EcomShops] ADD [ShopStockLocationIDs] NVARCHAR(MAX) NULL </sql>
            </EcomShops>
        </database>
    </package>

    <package version="313" date="19-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomStockLocation>
                <sql conditional="">
                    CREATE TABLE EcomStockLocation (
                        StockLocationID IDENTITY NOT NULL,
                        StockLocationName NVARCHAR(255) NOT NULL,
                        StockLocationDescription NVARCHAR(MAX) NULL,
                        StockLocationLanguageID NVARCHAR(255) NULL,
                        StockSortOrder INT NULL,
                        CONSTRAINT EcomStockLocation_PrimaryKey PRIMARY KEY([StockLocationID])
                    )
                </sql>
            </EcomStockLocation>
        </database>
    </package>

    <package version="312" date="19-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = 'Lists/EcomStockLocation_List.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [parentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        93,
                        'Stock location',
                        7,
                        'tree/btn_stockgrp.png',
                        'Lists/EcomStockLocation_List.aspx',
                        'STOCKLOCATION',
                        71,
                        'eCom_Catalog'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="311" releasedate="19-11-2013" internalversion="8.4.0.0">
        <setting key="/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive" value="True" overwrite="True" />
    </package>

    <package version="310" date="18-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomProducts>
                <sql conditional="">ALTER TABLE [EcomProducts] ADD
                    [ProductExcludeFromIndex] BIT NOT NULL DEFAULT 0,
                    [ProductExcludeFromCustomizedUrls] BIT NOT NULL DEFAULT 0,
                    [ProductExcludeFromAllProducts] BIT NOT NULL DEFAULT 0
                </sql>
            </EcomProducts>
        </database>
    </package>

    <package version="309" date="14-11-2013" internalversion="8.4.0.0">
	    <database file="Ecom.mdb">
	      <EcomOrders>
		    <sql conditional="">
		      CREATE TABLE [EcomSalesDiscountCurrencies] (
		          [SalesDiscountCurrenciesDiscountID] NVARCHAR(50) NOT NULL,
		          [SalesDiscountCurrenciesCurrencyCode] NVARCHAR(3) NOT NULL,
		          [SalesDiscountCurrenciesDiscountValue] FLOAT NOT NULL,
		          PRIMARY KEY (SalesDiscountCurrenciesDiscountID, SalesDiscountCurrenciesCurrencyCode)
		      )
		    </sql>
	      </EcomOrders>
	    </database>
    </package>

    <package version="308" date="13-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShops>
                <sql conditional="">ALTER TABLE [EcomShops] ADD [ShopOrderContextID] NVARCHAR(50) NULL</sql>
            </EcomShops>
        </database>
    </package>

    <package version="307" date="07-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <Multishop>
                <sql conditional="">
                    CREATE TABLE EcomOrderContexts (
                        OrderContextID NVARCHAR(50) NOT NULL,
                        OrderContextName NVARCHAR(255) NULL,
                        CONSTRAINT EcomOrderContexts_PrimaryKey PRIMARY KEY (OrderContextID)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE EcomOrderContextShopRelation (
                        OrderContextShopRelationContextID NVARCHAR(50) NOT NULL,
                        OrderContextShopRelationShopID NVARCHAR(255) NOT NULL,
                        CONSTRAINT EcomOrderContextShopRelation_PrimaryKey PRIMARY KEY (OrderContextShopRelationContextID, OrderContextShopRelationShopID)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE [EcomOrderContextAccessUserRelation]
                    (
                        OrderContextAccessUserAccessUserID INT NOT NULL,
                        OrderContextAccessUserOrderContextID NVARCHAR(50) NOT NULL,
                        OrderContextAccessUserOrderID NVARCHAR(50) NOT NULL,
                        CONSTRAINT EcomOrderContextAccessUserRelation_PrimaryKey PRIMARY KEY (OrderContextAccessUserAccessUserID, OrderContextAccessUserOrderContextID)
                    )
                </sql>
                <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeUrl = 'Lists/EcomOrderContext_List.aspx'">
                    INSERT INTO [Ecom7Tree] ([parentId], [Text], [Alt], [TreeIcon], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) 
                    VALUES (92, 'Order contexts', 7, 'tree/btn_cart.gif', 'Lists/EcomOrderContext_List.aspx', 'ORDERCONTEXT', 75, 'eCom_MultiShopAdvanced')
                </sql>
                <sql conditional="SELECT COUNT(*) FROM EcomNumbers WHERE NumberType = 'ORDERCONTEXT'">
                    INSERT INTO EcomNumbers (
                        NumberID,
                        NumberType, 
                        NumberDescription, 
                        NumberCounter, 
                        NumberPrefix, 
                        NumberAdd,
                        NumberEditable
                    ) VALUES (
                        48,
                        'ORDERCONTEXT',
                        'Order context',
                        0,
                        'ORDERCONTEXT',
                        1,
                        blnFalse
                    )
                </sql>

            </Multishop>
        </database>
    </package>

    <package version="306" date="06-11-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <EcomShops>
                <sql conditional="">ALTER TABLE [EcomShops] ADD [ShopStockStateID] NVARCHAR(255) NULL</sql>
            </EcomShops>
        </database>
    </package>
    
    <package version="305" releasedate="21-10-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <RelatedLists>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EcomOrderLines$OrderIDProductIDVariantIDQuantity] ON [dbo].[EcomOrderLines]
                    (
	                    [OrderLineOrderID] ASC,
	                    [OrderLineProductID] ASC
                    )
                    INCLUDE 
                    (
	                    [OrderLineProductVariantID],
	                    [OrderLineQuantity]
                    ) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
            </RelatedLists>
        </database>
    </package>

    <package version="304" releasedate="15-10-2013" internalversion="8.4.0.0">
        <file name="Cancel.html" target="Files/Templates/eCom7/CheckoutHandler/PayPal/ExpressCheckout/Cancel" source="Files/Templates/eCom7/CheckoutHandler/PayPal/ExpressCheckout/Cancel" />
        <file name="Error.html" target="Files/Templates/eCom7/CheckoutHandler/PayPal/ExpressCheckout/Error" source="Files/Templates/eCom7/CheckoutHandler/PayPal/ExpressCheckout/Error" />
    </package>

    <package version="303" date="03-10-2013" internalversion="8.4.0.0">
	    <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderSecondaryUserID] INT NULL</sql>                
            </EcomOrders>
        </database>
    </package>

    <package version="302" releasedate="01-10-2013" internalversion="8.4.0.0">
        <database file="Ecom.mdb">
            <ProductCatalog>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EcomProducts$LanguageIDVariantIDActiveProductIDWithNameAutoID] ON [dbo].[EcomProducts]
                    (
	                    [ProductLanguageID] ASC,
	                    [ProductVariantID] ASC,
	                    [ProductActive] ASC,
	                    [ProductID] ASC
                    )
                    INCLUDE ([ProductName],	[ProductAutoID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
            </ProductCatalog>
        </database>
    </package>

    <package version="301" date="30-09-2013" internalversion="8.4.0.0">	    
    </package>

    <package version="300" date="30-09-2013" internalversion="8.3.1.0">
        <database file="Ecom.mdb">
            <Orders>
                <sql conditional="">
                    UPDATE EcomGlobalISO SET ISOCountryNameDK = 'Østrig' WHERE ISOID = '238'
                </sql>
            </Orders>
        </database>
    </package>

    <package version="299" releasedate="27-09-2013" internalversion="8.3.1.0">
        <database file="Ecom.mdb">
            <ProductCatalog>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EcomProducts$VariantIDLanguageIDActionProductID] ON [dbo].[EcomProducts] 
                    (
                          [ProductVariantID] ASC,
                          [ProductLanguageID] ASC,
                          [ProductActive] ASC,
                          [ProductID] ASC
                    )WITH (SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
                </sql>
                <sql conditional="">
                    CREATE NONCLUSTERED INDEX [EcomProducts$ActiveProductIDLanguageIDPriceVariantID] ON [dbo].[EcomProducts]
                    (
	                    [ProductActive] ASC,
	                    [ProductID] ASC,
	                    [ProductLanguageID] ASC,
	                    [ProductPrice] ASC,
	                    [ProductVariantID] ASC
                    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
                </sql>
            </ProductCatalog>
        </database>
    </package>

    <package version="298" releasedate="10-09-2013" internalversion="8.3.1.0">
        <database file="Ecom.mdb">
            <ProductCatalog>
                <sql conditional="">
                    UPDATE Ecom7Tree SET text = 'Relation groups' WHERE [TreeUrl] = 'Lists/EcomRelGrp_List.aspx'
                </sql>
           </ProductCatalog>
        </database>
    </package>

    <package version="297" date="23-08-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <Orders>
                <sql conditional="SELECT COUNT(object_id) FROM sys.indexes WHERE name = 'EcomOrders$OrderLanguageID'">
                    CREATE NONCLUSTERED INDEX [EcomOrders$OrderLanguageID] ON [dbo].[EcomOrders] ([OrderLanguageID])
                </sql>
            </Orders>
        </database>
    </package>

    <package version="296" date="22-08-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>                    
                    <sql conditional="">
                          delete from Ecom7Tree where TreeUrl = '/Admin/Module/Ecom_cpl.aspx?cmd=8' and TreeChildPopulate='ORDEREXPORTSETTINGS'

                    </sql>
            </EcomOrders>
        </database>
   </package>

    <package version="295" releasedate="20-08-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
            <MultiShop>
                <sql conditional="SELECT COUNT(ModuleSystemName) FROM [Module] WHERE [ModuleSystemName] = 'eCom_MultiShopAdvanced'">
				    INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				    VALUES ('eCom_MultiShopAdvanced', 'Multi Shop Advanced', blnFalse, blnFalse, blnTrue)
                </sql>
            </MultiShop>
        </database>
    </package>

    <package version="293" releasedate="15-08-2013" internalversion="8.3.0.0">
        <file name="ShowCartSavedForLater.html" target="Files/Templates/eCom7/CartV2/Step" source="Files/Templates/eCom7/CartV2/Step" />
        <file name="SavedForLater.html" target="Files/Templates/eCom/Product" source="Files/Templates/eCom/Product" />
    </package>

    <package version="292" releasedate="15-08-2013" internalversion="8.3.0.0">
        <file name="PrintOrder.html" target="Files/Templates/eCom7/Order" source="Files/Templates/eCom7/Order" />
    </package>

	<package version="291" date="01-08-2013" internalversion="8.3.0.0">
		<file name="OrderMail.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
	</package>

    <package version="290" releasedate="29-07-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <Canonical>
	            <sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaCanonical] NVARCHAR(255) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomProducts] ADD [ProductMetaCanonical] NVARCHAR(255) NULL</sql>
            </Canonical>
        </database>
    </package>

    <package version="289" date="28-07-2013" internalversion="8.3.0.0">
	    <file name="InformationCreateUser.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
	    <file name="login.js" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
	    <file name="Step.css" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
    </package>

    <package version="288" date="02-07-2013" internalversion="8.3.0.0">
	    <database file="Ecom.mdb">
	        <EcomSalesDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomProductsRelated]  ADD 
                        ProductRelatedLimitLanguage NVARCHAR(MAX) NULL,
                        ProductRelatedLimitCountry NVARCHAR(MAX) NULL,
                        ProductRelatedLimitShop NVARCHAR(MAX) NULL
                </sql>
	        </EcomSalesDiscount>
	    </database>
    </package>

    <package version="287" date="11-06-2013" internalversion="8.3.0.0">
	    <database file="Ecom.mdb">
	        <EcomSalesDiscount>
		        <sql conditional="">
                    ALTER TABLE [EcomSalesDiscount]  ADD 
                        SalesDiscountShop NVARCHAR(255) NULL,
                        SalesDiscountCountries NVARCHAR(MAX) NULL
                </sql>
	        </EcomSalesDiscount>
	    </database>
    </package>

    <package version="286" releasedate="23-05-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <EcomProducts>
                <sql conditional="">
                    DROP INDEX EcomProducts$ProductAutoID ON EcomProducts
                </sql>
                <sql conditional="">
                    ALTER TABLE EcomProducts ALTER COLUMN ProductAutoID BIGINT
                </sql>
                <sql conditional="SELECT COUNT(object_id) FROM sys.indexes WHERE name = 'EcomProducts$ProductAutoID'">
                    CREATE NONCLUSTERED INDEX [EcomProducts$ProductAutoID] ON [EcomProducts]
                    (
	                    [ProductID] ASC,
	                    [ProductLanguageID] ASC,
	                    [ProductVariantID] ASC
                    )
                    INCLUDE
                    (
	                    [ProductAutoID]
                    ) 
                    WITH 
                    (
	                    PAD_INDEX = OFF, 
	                    STATISTICS_NORECOMPUTE = OFF, 
	                    SORT_IN_TEMPDB = OFF, 
	                    DROP_EXISTING = OFF, 
	                    ONLINE = OFF, 
	                    ALLOW_ROW_LOCKS = ON, 
	                    ALLOW_PAGE_LOCKS = ON
                    )
                    ON
	                    [PRIMARY]
                </sql>
            </EcomProducts>
        </database>
    </package>

    <package version="285" releasedate="18-05-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <EcomProductItems>
                <sql conditional="">
                    ALTER TABLE EcomProductItems ADD ProductItemBomVariantID NVARCHAR(255) NOT NULL DEFAULT N''
                </sql>
            </EcomProductItems>
        </database>
    </package>


    <package version="284" releasedate="17-04-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <EcomProductCategories>
                <sql conditional="">
                    ALTER TABLE EcomProductCategoryField ADD FieldSortOrder INT NULL
                </sql>
            </EcomProductCategories>
        </database>
    </package>

    <package version="283" date="15-03-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
		    <DropConstraints>
				<sql conditional="">
					ALTER TABLE [dbo].[EcomCountryText] DROP CONSTRAINT [FK_EcomCountryText_EcomCountries];
                </sql>
		    </DropConstraints>
            <AddConstraints>
                <sql conditional="">
                    ALTER TABLE [dbo].[EcomCountryText] WITH CHECK ADD CONSTRAINT [FK_EcomCountryText_EcomCountries] FOREIGN KEY([CountryTextCode2], [CountryTextRegionCode]) 
                        REFERENCES [dbo].[EcomCountries] ([CountryCode2], [CountryRegionCode])
                        ON UPDATE CASCADE
                        ON DELETE CASCADE
                </sql>
            </AddConstraints>
        </database>
    </package>

    <package version="282" date="22-03-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <EcomGlobalISO>
                <sql conditional="SELECT COUNT(*) FROM EcomGlobalISO WHERE ISOID = 213 AND ISOCurrencyCode = 949">
                    UPDATE EcomGlobalISO SET ISOCurrencySymbol = 'TRY', ISOCurrencyCode = 949 WHERE ISOID = 213 AND ISOCurrencyCode = 792
                </sql>
            </EcomGlobalISO>
        </database>
    </package>

    <package version="281" date="01-03-2013" internalversion="8.3.0.0">
	    <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCompletedDate] DATETIME NULL</sql>
                <sql conditional="SELECT COUNT(*) FROM [EcomOrders] WHERE [OrderCompletedDate] IS NOT NULL">
                    UPDATE [EcomOrders] SET [OrderCompletedDate] = [OrderDate] WHERE [OrderCompletedDate] IS NULL AND [OrderComplete] = 1
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="280" date="25-02-2013" internalversion="8.3.0.0">
	    <database file="Ecom.mdb">
	        <EcomFees>
		        <sql conditional="">ALTER TABLE EcomFees ADD FeeOrderPrice DOUBLE NOT NULL DEFAULT 0</sql>
	        </EcomFees>
	    </database>
    </package>

    <package version="279" date="23-02-2013" internalversion="8.3.0.0">
        <database file="Ecom.mdb">
            <Products>
                <sql conditional="">
                    ALTER TABLE [EcomProducts] ADD [ProductAutoID] IDENTITY NOT NULL
                </sql>
                <sql conditional="SELECT COUNT(object_id) FROM sys.indexes WHERE name = 'EcomProducts$ProductAutoID'">
                    CREATE NONCLUSTERED INDEX [EcomProducts$ProductAutoID] ON [EcomProducts]
                    (
	                    [ProductID] ASC,
	                    [ProductLanguageID] ASC,
	                    [ProductVariantID] ASC
                    )
                    INCLUDE
                    (
	                    [ProductAutoID]
                    ) 
                    WITH 
                    (
	                    PAD_INDEX = OFF, 
	                    STATISTICS_NORECOMPUTE = OFF, 
	                    SORT_IN_TEMPDB = OFF, 
	                    DROP_EXISTING = OFF, 
	                    ONLINE = OFF, 
	                    ALLOW_ROW_LOCKS = ON, 
	                    ALLOW_PAGE_LOCKS = ON
                    )
                    ON
	                    [PRIMARY]
                </sql>
            </Products>
        </database>
    </package>

  <package version="278" date="19-02-2013" internalversion="8.3.0.0">
    <file name="Payment.html" source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment" overwrite="false" />
    <file name="Amex.gif" source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" overwrite="false" />
    <file name="Disc.gif" source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" overwrite="false" />
    <file name="MC.gif" source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" overwrite="false" />
    <file name="Visa.gif" source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Payment/img" overwrite="false" />
  </package>

	<package version="277" releasedate="18-02-2013" internalversion="8.3.0.0">
		<database file="ecom.mdb">
			<EcomSavedForLater>
				<sql conditional="">
                    CREATE TABLE EcomSavedForLater (
	                    SavedForLaterID IDENTITY NOT NULL,
	                    SavedForLaterProductID NVARCHAR(255) NOT NULL,
	                    SavedForLaterVariantID NVARCHAR(255) NOT NULL,
	                    SavedForLaterLanguageID NVARCHAR(255) NOT NULL,
	                    SavedForLaterSessionID INT NULL,
	                    SavedForLaterDateAdded DATETIME NULL DEFAULT NULL,
                        CONSTRAINT EcomSavedForLater$PrimaryKey PRIMARY KEY(SavedForLaterID)
                    )
				</sql>
			</EcomSavedForLater>
		</database>
	</package>

    <package version="276" releasedate="25-01-2013" internalversion="8.3.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_DataIntegrationERPLiveIntegration'">
				INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				VALUES ('eCom_DataIntegrationERPLiveIntegration', 'ERP Live Integration', blnFalse, blnFalse, blnTrue)
			    </sql>
		    </Module>
	    </database>
    </package>  

    <package version="275" date="23-01-2013" internalversion="8.3.0.0">
		<database file="Ecom.mdb">
			<EcomVouchers>
				<sql conditional="">
                    ALTER TABLE [EcomVoucherLists] DROP CONSTRAINT EcomVoucherLists$ForeignKeyVoucherCategoryID;
				</sql>
                <sql conditional="">
                    ALTER TABLE [EcomVoucherLists] DROP VoucherListCategoryID;
				</sql>
                <sql conditional="">
                    DROP TABLE EcomVoucherCategories;
				</sql>
			</EcomVouchers>
		</database>
	</package>

    <package version="274" date="29-11-2012" internalversion="8.2.0.0">
        <file name="ProductSmartSearchRelations.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
    </package>
	
	<package version="273" date="26-11-2012" internalversion="8.2.0.0">	
		<file name="GLS.html" source="/Files/Templates/eCom7/ShippingProvider/" target="/Files/Templates/eCom7/ShippingProvider/" overwrite="false"/>        
	</package>

    <package version="272" releasedate="21-11-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
		    <Module>
			    <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_DataIntegrationERPBatch'">
				INSERT INTO [Module] ([ModuleSystemName], [ModuleName], [ModuleAccess], [ModuleParagraph], [ModuleIsBeta])
				VALUES ('eCom_DataIntegrationERPBatch', 'Data Integration ERP Batch', blnFalse, blnFalse, blnTrue)
			    </sql>
		    </Module>
	    </database>
    </package>  

	<package version="271" releasedate="14-11-2012" internalversion="8.2.0.0">
		<database file="ecom.mdb">
			<EcomCalculatedFields>
				<sql conditional="">
					DROP TABLE [EcomCalculatedFields]
				</sql>
				<sql conditional="">
					DROP TABLE [EcomCalculatedFieldValues]
				</sql>
				<sql conditional="">
					CREATE TABLE [EcomCalculatedField]
					(
						CalculatedFieldId IDENTITY NOT NULL,
						CalculatedFieldName NVARCHAR(255) NOT NULL,
						CalculatedFieldType NVARCHAR(255) NOT NULL,
						CalculatedFieldTypeConfiguration NVARCHAR(MAX) NOT NULL,
						CalculatedFieldUpdateInterval INT NOT NULL,
						CalculatedFieldUpdateStartTime DATETIME NOT NULL,
						CalculatedFieldLastUpdateTime DATETIME NULL DEFAULT NULL,
						CONSTRAINT EcomCalculatedField$PrimaryKey PRIMARY KEY(CalculatedFieldId)
					)
				</sql>
				<sql conditional="">
					CREATE TABLE [EcomCalculatedProductFieldValue]
					(
						CalculatedProductFieldValueFieldId INT NOT NULL,
						CalculatedProductFieldValueProductId NVARCHAR(30) NOT NULL,
						CalculatedProductFieldValueProductVariantId NVARCHAR(255) NOT NULL,
						CalculatedProductFieldValueProductLanguageId NVARCHAR(50) NOT NULL,
						CalculatedProductFieldValueValue FLOAT NOT NULL,
						CONSTRAINT EcomCalculatedProductFieldValue$PrimaryKey PRIMARY KEY
							(
								CalculatedProductFieldValueFieldId, 
								CalculatedProductFieldValueProductId, 
								CalculatedProductFieldValueProductVariantId,
								CalculatedProductFieldValueProductLanguageId
							),
						CONSTRAINT EcomCalculatedProductFieldValue$ProductForeignKey FOREIGN KEY
							(
								CalculatedProductFieldValueProductId,
								CalculatedProductFieldValueProductLanguageId,
								CalculatedProductFieldValueProductVariantId
							)
							REFERENCES EcomProducts
								(
									ProductID,
									ProductLanguageID,
									ProductVariantID
								)
					)
				</sql>
			</EcomCalculatedFields>
		</database>
	</package>

    <package version="270" releasedate="13-11-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <EcomCalcFields>
                <sql conditional="">
                    DELETE FROM [Ecom7Tree] WHERE TreeUrl = 'Lists/EcomCalculatedField_List.aspx'
                </sql>
                <sql conditional="">
                    INSERT INTO Ecom7Tree
                    (
                        parentId,
                        Text,
                        Alt,
                        TreeIcon,
                        TreeIconOpen,
                        TreeUrl,
                        TreeChildPopulate,
                        TreeSort,
                        TreeHasAccessModuleSystemName                        
                    )
                    VALUES
                    (
                         93,
                         'Calculated fields',
                         7,
                         'tree/btn_roundings.png',
                         NULL,
                         'Lists/EcomCalculatedField_List.aspx',
                         'CALCFIELD',
                         120,
                         'eCom_Catalog'
                     )
                </sql>
            </EcomCalcFields>
        </database>
    </package>

	<package version="269" date="06-11-2012" internalversion="8.2.0.0">
		<database file="Ecom.mdb">
			<EcomOrders>
				<sql conditional="">
					ALTER TABLE EcomOrders ADD
						OrderShippingDocumentData NVARCHAR(MAX) NULL,
						OrderShippingProviderData NVARCHAR(MAX) NULL
				</sql>
			</EcomOrders>
		</database>
	</package>

    <package version="268" date="06-11-2012" internalversion="8.2.0.0">
        <file name="ProductSmartSearchRelations.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
    </package>

    <package version="267" date="06-11-2012" internalversion="8.2.0.0">
		<database file="Ecom.mdb">
            <EcomProductsCost>
				<sql conditional="">
					ALTER TABLE [EcomProducts] ADD [ProductCost] FLOAT NULL
				</sql>
            </EcomProductsCost>
		</database>
	</package>

    <package version="266" date="02-11-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <AddresValidatorProviders>
                <sql conditional="">
                    CREATE TABLE EcomRelatedSmartSearches (
	                    [RelatedGroupID] [nvarchar](50) NOT NULL,
	                    [RelatedProductID] [nvarchar](50) NOT NULL,
	                    [RelatedLanguageID] [nvarchar](50) NOT NULL,
	                    [RelatedSmartSearchRelID] [nvarchar](50) NOT NULL,
                        CONSTRAINT EcomRelatedSmartSearches$PrimaryKey PRIMARY KEY([RelatedGroupID],[RelatedProductID],[RelatedLanguageID],[RelatedSmartSearchRelID])
                    )
                </sql>
            </AddresValidatorProviders>
        </database>
    </package>

    <package version="265" date="12-10-2012" internalversion="8.2.0.0">
	    <database file="Ecom.mdb">
            <PrimaryInformation>
                <sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaPrimaryPage] NVARCHAR(255) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomGroupRelations] ADD [GroupRelationsIsPrimary] BIT NULL</sql>
                <sql conditional="">ALTER TABLE [EcomGroupProductRelation] ADD [GroupProductRelationIsPrimary] BIT NULL</sql>
            </PrimaryInformation>
        </database>
    </package>

    <package version="264" date="25-09-2012" internalversion="8.2.0.0">	
        <file name="InformationWithMultipleAddresses.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false"/>        
    </package>

   <package version="263" date="19-09-2012" internalversion="8.2.0.0">
        <file name="FrequentlyBoughtItemsList.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="FrequentlyBoughtItemsDetails.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="OrderListFull.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="NavigationFull.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
   </package>

   <package version="262" date="10-09-2012" internalversion="8.2.0.0">
        <file name="InformationAddressValidation.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="addressValidator.js" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />   
   </package>

    <package version="261" date="05-09-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <EcomStockStatusLine>
                <sql conditional="SELECT * FROM EcomStockStatusLine">
                    INSERT INTO EcomStockStatusLine
                               ([StockStatusLinesID]
                               ,[StockStatusLinesGroupID]
                               ,[StockStatusLinesRate]
                               ,[StockStatusLinesDefinition]
                               ,[StockStatusLinesIcon])
                    SELECT 'STOCKSTASTUSLINEID' + CAST(ROW_NUMBER() OVER (ORDER BY StockStatusID ASC) As varchar(5))
                          ,[StockStatusGroupID]
                          ,[StockStatusRate]
                          ,[StockStatusDefinition]
                          ,[StockStatusIcon]
                      FROM [EcomStockStatus]
                      WHERE StockStatusLanguageID = (SELECT [LanguageID]
								                     FROM [EcomLanguages]
								                     WHERE [LanguageIsDefault] = 1)
                </sql>
            </EcomStockStatusLine>
            <EcomStockStatusLanguageValue>
                <sql conditional="SELECT * FROM EcomStockStatusLanguageValue">
                    INSERT INTO [EcomStockStatusLanguageValue]
                               ([StockStatusLanguageValueID]
                               ,[StockStatusLanguageValueLinesID]
                               ,[StockStatusLanguageValueLanguageID]
                               ,[StockStatusLanguageValueText]
                               ,[StockStatusLanguageValueDeliveryValue]
                               ,[StockStatusLanguageValueDeliveryText])
                    SELECT [StockStatusID]
	                      , (SELECT [StockStatusLinesID] 
			                    FROM EcomStockStatusLine 
			                    WHERE  EcomStockStatusLine.StockStatusLinesGroupID = [EcomStockStatus].StockStatusGroupID AND
			                    EcomStockStatusLine.StockStatusLinesDefinition = [EcomStockStatus].StockStatusDefinition AND
			                    EcomStockStatusLine.StockStatusLinesIcon = [EcomStockStatus].StockStatusIcon AND
			                    EcomStockStatusLine.StockStatusLinesRate = [EcomStockStatus].StockStatusRate)
                          ,[StockStatusLanguageID]
                          ,[StockStatusText]
                          ,[StockStatusExpectedDeliveryValue]
                          ,[StockStatusExpectedDeliveryText]
                      FROM [EcomStockStatus]
                </sql>
            </EcomStockStatusLanguageValue>
        </database>
    </package>

    <package version="260" date="05-09-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <AddresValidatorProviders>
                <sql conditional="">
                    CREATE TABLE EcomAddressValidatorSettings (
                        AddressValidatorSettingID INT IDENTITY(1,1) NOT NULL,
                        AddressValidatorName NVARCHAR(255) NULL,
                        AddressValidatorActive BIT NOT NULL,
                        AddressValidatorProviderSettings NVARCHAR(MAX) NULL,
                        CONSTRAINT EcomAddressValidatorSettings$PrimaryKey PRIMARY KEY(AddressValidatorSettingID)
                    )
                </sql>
                <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeUrl = 'Lists/EcomAddressValidator_List.aspx'">
                    INSERT INTO [Ecom7Tree] ([parentId], [Text], [Alt], [TreeIcon], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) 
                    VALUES (92, 'Address validation', 7, 'tree/btn_address_book.png', 'Lists/EcomAddressValidator_List.aspx', 'ADDRESSVALIDATOR', 90, 'eCom_CartV2')
                </sql>
            </AddresValidatorProviders>
        </database>
    </package>

    <package version="259" date="20-08-2012" internalversion="8.2.0.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'NavIntegration'</sql>                
            </Module>
        </database>
    </package>

    <package version="258" date="13-08-2012" internalversion="8.2.0.0">
	    <database file="Ecom.mdb">
            <EcomShippings>
                <sql conditional="">
                    ALTER TABLE [EcomShippings] ADD 
                    [ShippingActive] BIT NULL DEFAULT 1,
                    [ShippingDateFrom] DATETIME NULL,
                    [ShippingDateTo] DATETIME NULL,
                    [ShippingCustomersAndGroups] NVARCHAR(MAX) NULL
                </sql>
            </EcomShippings>
        </database>
    </package>

    <package version="257" date="09-08-2012" internalversion="8.2.0.0">
	    <database file="Ecom.mdb">
            <EcomOrderStates>
                <sql conditional="">ALTER TABLE [EcomOrderStates] ADD [OrderStateIsReadyForShipping] bit NULL</sql>
            </EcomOrderStates>
        </database>
    </package>

   <package version="256" date="07-08-2012" internalversion="8.2.0.0">
        <file name="ShowCartTaxes.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
   </package>/

    <package version="255" releasedate="01-08-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomStockStatusLine>
                <sql conditional="SELECT * From EcomNumbers WHERE NumberID='46'">
                 INSERT INTO EcomNumbers
                 ([NumberID]
                 ,[NumberType]
                 ,[NumberDescription]
                 ,[NumberCounter]
                 ,[NumberPrefix]
                 ,[NumberPostFix]
                 ,[NumberAdd]
                 ,[NumberEditable])
                 VALUES(
                 '46'
                 ,'LANGUAGEVALUE'
                 ,'Language Value'
                 ,1
                 ,'LANGUAGEVALUE'
                 ,''
                 ,1
                 ,0)
                </sql>
                <sql conditional="SELECT * From EcomNumbers WHERE NumberID='47'">
                INSERT INTO [EcomNumbers]
               ([NumberID]
                ,[NumberType]
                ,[NumberDescription]
                ,[NumberCounter]
                ,[NumberPrefix]
                ,[NumberPostFix]
                ,[NumberAdd]
                ,[NumberEditable])
                VALUES(
                '47'
                ,'STOCKSTATUSLINE'
                ,'StockStatus Line'
                ,1
                ,'STOCKSTATUSLINE'
                ,''
                ,1
                ,0)
                </sql>
                <sql conditional="">
                    CREATE TABLE [EcomStockStatusLine]
                    (
                       [StockStatusLinesID] NVARCHAR(50) PRIMARY KEY,
                       [StockStatusLinesGroupID] NVARCHAR(50) NOT NULL,
                       [StockStatusLinesRate] FLOAT NOT NULL,
                       [StockStatusLinesDefinition] NVARCHAR(50) NOT NULL,
                       [StockStatusLinesIcon] NVARCHAR(255) NOT NULL
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE [EcomStockStatusLanguageValue]
                   (
                    [StockStatusLanguageValueID] NVARCHAR(50)  PRIMARY KEY,
                    [StockStatusLanguageValueLinesID] NVARCHAR(50) NOT NULL,
                    [StockStatusLanguageValueLanguageID] NVARCHAR(255) NOT NULL,
                    [StockStatusLanguageValueText] NVARCHAR(255) NOT NULL,
                    [StockStatusLanguageValueDeliveryValue] NVARCHAR(255) NOT NULL,
                    [StockStatusLanguageValueDeliveryText] NVARCHAR(255) NOT NULL
                    CONSTRAINT EcomStockStatusLanguageValue$ForeignKeyLanguageValueLines FOREIGN KEY (StockStatusLanguageValueLinesID) REFERENCES EcomStockStatusLine(StockStatusLinesID)
                   )
                </sql>
           </EcomStockStatusLine>
        </database>
    </package>


    <package version="254" date="01-08-2012" internalversion="8.2.0.0">
	    <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerSurname] NVARCHAR(255) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerInitials] NVARCHAR(50) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerPrefix] NVARCHAR(50) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderDeliverySurname] NVARCHAR(255) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderDeliveryInitials] NVARCHAR(50) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderDeliveryPrefix] NVARCHAR(50) NULL</sql>
            </EcomOrders>
        </database>
    </package>

      <package version="253" date="31-07-2012" internalversion="8.2.0.0">
	    <database file="Ecom.mdb">
	      <EcomPayments>
		    <sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentSorting] INT DEFAULT 0</sql>
	      </EcomPayments>
	      <EcomShipments>
		    <sql conditional="">ALTER TABLE [EcomShippings] ADD [ShippingSorting] INT DEFAULT 0</sql>
	      </EcomShipments>
	    </database>
      </package>

    <package version="252" date="26-07-2012" internalversion="8.2.0.0">
      <database file="Ecom.mdb">
          <EcomVouchers>
             <sql conditional="">
                 UPDATE [Ecom7Tree] SET [TreeIcon] = 'tree/btn_vouchers.png' WHERE Text = 'Vouchers'
             </sql>
          </EcomVouchers>
        </database>
    </package>

    

    <package version="251" date="05-07-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>                    
                    <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeUrl = '/Admin/Module/Ecom_cpl.aspx?cmd=8'">
                        INSERT INTO [Ecom7Tree] ([parentId], [Text], [Alt], [TreeIcon], [TreeIconOpen], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) VALUES (94, 'Order Export', NULL, '/Admin/Module/eCom_Catalog/images/tree/btn_orders.png', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=8', 'ORDEREXPORTSETTINGS', 75, 'eCom_Catalog')
                    </sql>
            </EcomOrders>
        </database>
   </package>
    
    <package version="250" date="05-07-2012" internalversion="8.2.0.0">
	    <file name="PostAfterpay.html" source="/Files/Templates/eCom7/CheckoutHandler/Ogone/Post" target="/Files/Templates/eCom7/CheckoutHandler/Ogone/Post" overwrite="false" />
    </package>

    <package version="249" releasedate="03-07-2012" internalversion="8.2.0.0">
        <database file="Ecom.mdb">
            <EcomGlobalISO>
                <sql conditional="SELECT * FROM EcomGlobalISO WHERE ISOID = 30 AND ISOCurrencySymbol = 'BRL'">
                    UPDATE EcomGlobalISO SET ISOCurrencySymbol = 'BRL' WHERE ISOID = 30 AND ISOCurrencySymbol = 'BRR'
                </sql>
           </EcomGlobalISO>
        </database>
    </package>    

    <package version="248" date="21-06-2012" internalversion="8.1.1.0">
        <file name="RmaNotificationEmail.html" source="/Files/Templates/eCom/Rma/Mail" target="/Files/Templates/eCom/RMA/Mail" overwrite="false" />
    </package>

    <package version="247" releasedate="15-06-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="">
                    CREATE TABLE EcomRmaEmailConfigurations(
                        RmaEmailConfigurationId INT NOT NULL IDENTITY(1,1),
                        RmaEmailConfigurationLanguage NVARCHAR(50) NOT NULL,
                        RmaEmailConfigurationForCustomer BIT NOT NULL,
                        RmaEmailConfigurationRecipient NVARCHAR(255) NULL,
                        RmaEmailConfigurationSubject NVARCHAR(255) NULL,
                        RmaEmailConfigurationSenderName NVARCHAR(255) NULL,
                        RmaEmailConfigurationSenderEmail NVARCHAR(255) NULL,
                        RmaEmailConfigurationTemplate NVARCHAR(MAX) NULL,
                        CONSTRAINT RmaEmailConfigurations$PrimaryKey PRIMARY KEY(RmaEmailConfigurationId),
                        CONSTRAINT RmaEmailConfigurations$ForeignKeyLanguages FOREIGN KEY(RmaEmailConfigurationLanguage)
		                    REFERENCES EcomLanguages(LanguageID)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE EcomRmaEmailConfigurationStateRelation(
                        RmaEmailConfigurationStateRelationEmailConfigurationId INT NOT NULL,
                        RmaEmailConfigurationStateRelationStateId INT NOT NULL,
                        CONSTRAINT RmaEmailConfigurationStateRelation$ForeignKeyEmailConfiguration FOREIGN KEY(RmaEmailConfigurationStateRelationEmailConfigurationId) 
                            REFERENCES EcomRmaEmailConfigurations(RmaEmailConfigurationId),
                        CONSTRAINT RmaEmailConfigurationStateRelation$ForeignKeyState FOREIGN KEY(RmaEmailConfigurationStateRelationStateId) 
                            REFERENCES EcomRmaStates(RmaStateId)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE EcomRmaEmailConfigurationEventRelation(
                        RmaEmailConfigurationEventRelationEmailConfigurationId INT NOT NULL,
                        RmaEmailConfigurationEventRelationEventType NVARCHAR(255) NOT NULL,
                        CONSTRAINT RmaEmailConfigurationEventRelation$ForeignKeyEmailConfiguration FOREIGN KEY(RmaEmailConfigurationEventRelationEmailConfigurationId) 
                            REFERENCES EcomRmaEmailConfigurations(RmaEmailConfigurationId),
                        CONSTRAINT RmaEmailConfigurationEventRelation$ForeignKeyState FOREIGN KEY(RmaEmailConfigurationEventRelationEventType) 
                            REFERENCES EcomRmaEvents(RmaEventType)
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE EcomRmaEmailConfigurationReplacementOrderProviderRelation(
                        RmaEmailConfigurationReplacementOrderProviderRelationEmailConfigurationId INT NOT NULL,
                        RmaEmailConfigurationReplacementOrderProviderRelationReplacementOrderProviderClassName NVARCHAR(260) NOT NULL,
                        CONSTRAINT RmaEmailConfigurationReplacementOrderProviderRelation$ForeignKeyEmailConfiguration FOREIGN KEY(RmaEmailConfigurationReplacementOrderProviderRelationEmailConfigurationId) 
                            REFERENCES EcomRmaEmailConfigurations(RmaEmailConfigurationId)
                    )
                </sql>                    
           </EcomRma>
        </database>
    </package>

    <package version="246" date="13-06-2012" internalversion="8.1.1.0">        
		<database file="Ecom.mdb">			 
            <EcomVouchers>
                <sql conditional="">ALTER TABLE [EcomVouchers] ADD VoucherStatus NVARCHAR(50) NULL</sql>
            </EcomVouchers>
		</database>
	</package>


   <package version="245" date="11-06-2012" internalversion="8.1.1.0">
        <file name="VoucherMail.html" source="/Files/Templates/eCom7/Vouchers" target="/Files/Templates/eCom7/Vouchers" overwrite="false" />
   </package>


   <package version="244" date="05-06-2012" internalversion="8.1.1.0">
        <file name="rma.png" source="/Files/Templates/eCom/CustomerCenter/Images" target="/Files/Templates/eCom/CustomerCenter/Images" overwrite="false" />
        <file name="OrderListRMA.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="NavigationRMA.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="RMADetails.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="RMAEmail.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="RMAList.html" source="/Files/Templates/eCom/CustomerCenter" target="/Files/Templates/eCom/CustomerCenter" overwrite="false" />
        <file name="RMAList.css" source="/Files/Templates/eCom/CustomerCenter/css" target="/Files/Templates/eCom/CustomerCenter/css" overwrite="false" />
   </package>

    <package version="243" date="01-06-2012" internalversion="8.1.1.0">
        <database file="Statisticsv2.mdb">
            <Statv2Session>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD
                    [OrderVoucherCode] NVARCHAR(36) NULL
                </sql>
            </Statv2Session>
        </database>
    </package>


   <package version="242" date="31-05-2012" internalversion="8.1.0.0">
        <file name="InformationVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="InformationInfoDirektVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="InformationWithStatesVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="ReceiptVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="ReceiptWithStatesVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="ShowCartVoucher.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
   </package>
 

   <package version="241" date="29-05-2012" internalversion="8.1.1.0">
    <database file="Ecom.mdb" version="633" date="29-05-2012" internalversion="8.1.1.0">
        <OMCEmailProfile>
                <sql conditional="SELECT TOP 1 [id] FROM [Ecom7Tree] WHERE [Text] = 'Vouchers'">
                    INSERT INTO [Ecom7Tree] ([parentId], [Text], [Alt], [TreeIcon], [TreeIconOpen], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) VALUES (93, 'Vouchers', 7, 'tree/btn_orders.png', NULL, '/Admin/Module/eCom_Catalog/dw7/Vouchers/VouchersManagerMain.aspx', 'ECOMVOUCHERSMANAGER', 42, 'eCom_Catalog')
                </sql>
        </OMCEmailProfile>
    </database>
   </package>

     <package version="240" date="29-05-2012" internalversion="8.1.1.0">
        <file name="Shopping cart.xml" source="/Files/System/OMC/Reports/Marketing reports/Conversions" target="/Files/System/OMC/Reports/Marketing reports/Conversions" overwrite="false" />
     </package>


   <package version="239" date="25-05-2012" internalversion="8.1.1.0">
      <database file="Ecom.mdb">
       <EcomVouchers>
       <sql conditional="">
        </sql>
      </EcomVouchers>
    </database>
  </package>

  <package version="238" date="18-05-2012" internalversion="8.1.0.0">        
     <database file="Ecom.mdb">
            <EcomVoucherLists>
                <sql conditional="">
                    CREATE TABLE [EcomVoucherCategories]
                    (
                        [VoucherCategoryID] INT IDENTITY(1,1) NOT NULL,                        
                        [VoucherCategoryName] NVARCHAR(255) NOT NULL UNIQUE,
                        CONSTRAINT EcomVoucherCategories$PrimaryKey PRIMARY KEY(VoucherCategoryID)
                    )
                </sql>
            </EcomVoucherLists>
			 <EcomVoucherLists>
                <sql conditional="">
                    CREATE TABLE [EcomVoucherLists]
                    (
                        [VoucherListID] INT IDENTITY(1,1) NOT NULL,                        
                        [VoucherListCategoryID] INT NOT NULL,
                        [VoucherListName] NVARCHAR(255) NOT NULL UNIQUE,
                        [VoucherListActive] BIT NOT NULL,
                        CONSTRAINT EcomVoucherLists$PrimaryKey PRIMARY KEY(VoucherListID),
                        CONSTRAINT EcomVoucherLists$ForeignKeyVoucherCategoryID FOREIGN KEY(VoucherListCategoryID)
                            REFERENCES EcomVoucherCategories(VoucherCategoryID) ON DELETE CASCADE
                    )                </sql>
            </EcomVoucherLists>
            <EcomVouchers>
                <sql conditional="">
                    CREATE TABLE [EcomVouchers]
                    (
                        [VoucherID] INT IDENTITY(1,1) NOT NULL,
                        [VoucherListID] INT NOT NULL,
	                    [VoucherCode] NVARCHAR(36) NOT NULL UNIQUE,
	                    [VoucherDateUsed] DATETIME NULL,
                        [VoucherUsedOrderID] NVARCHAR(50) NULL,
                        [VoucherAccessUserID] INT NULL,
                        CONSTRAINT EcomVouchers$PrimaryKey PRIMARY KEY(VoucherID),
                        CONSTRAINT EcomVouchers$ForeignKeyVoucherListID FOREIGN KEY(VoucherListID)
                            REFERENCES EcomVoucherLists(VoucherListID) ON DELETE CASCADE
                    )           
             </sql>
            </EcomVouchers>
		</database>
	</package>


    <package version="237" date="11-05-2012" internalversion="8.1.0.0">
        <file name="CatalogPublishingEmail.html" source="/Files/Templates/eCom/CatalogPublishing/Email" target="/Files/Templates/eCom/CatalogPublishing/Email" overwrite="false" />
        <file name="CatalogPublishingEmailForm.html" source="/Files/Templates/eCom/CatalogPublishing/Email" target="/Files/Templates/eCom/CatalogPublishing/Email" overwrite="false" />
   </package>


    <package version="236" date="07-05-2012" internalversion="8.1.0.0">
        <file name="CatalogPublishingLastPage.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
        <file name="CatalogPublishingPageHeader.html" source="/Files/Templates/eCom/CatalogPublishing" target="/Files/Templates/eCom/CatalogPublishing" overwrite="false" />
    </package>


    <package version="235" releasedate="15-06-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeUrl = 'Lists/EcomRmaEmailConfiguration_List.aspx'">
                    INSERT INTO Ecom7Tree ([parentId], [Text], [Alt], [TreeIcon], [TreeIconOpen], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) VALUES (95, 'Email configuration', 7, 'tree/btn_rma_email_configuration.png', NULL, 'Lists/EcomRmaEmailConfiguration_List.aspx', 'RMAEMAILCONFIGS', 200, NULL)
                </sql>
           </EcomRma>
        </database>
    </package>
    
    <package version="234" releasedate="15-06-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="">
                    UPDATE Ecom7Tree SET parentId = 95 WHERE [TreeUrl] ='Lists/EcomRmaEvent_List.aspx' OR [TreeUrl] = 'Lists/EcomRmaState_List.aspx'
                </sql>
           </EcomRma>
        </database>
    </package>
    
    <package version="233" date="14-06-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomRMA>
                <sql conditional="">
                  UPDATE [Ecom7Tree] SET [TreeIcon] = 'tree/btn_rma_states.png' WHERE [TreeUrl] = 'Lists/EcomRmaState_List.aspx'
                </sql>
            </EcomRMA>
        </database>
    </package>

    <package version="232" date="13-06-2012" internalversion="8.1.1.0">
    </package>

    <package version="231" date="11-06-2012" internalversion="8.1.1.0">
        <database file="Dynamic.mdb">
            <Module>
                <sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName = 'ecom_NaviconnectIntegration'</sql>
            </Module>
        </database>
    </package>

    <package version="230" date="11-06-2012" internalversion="8.1.1.0">
        <database file="Ecom.mdb">
            <EcomRMA>
                <sql conditional="">
                    UPDATE [EcomTree] SET [TreeIcon] = 'tree/btn_rma.png' WHERE TreeUrl = 'RmaList.aspx'
                </sql>
            </EcomRMA>
        </database>
    </package>

    <package version="229" date="29-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="SELECT * FROM Ecom7Tree WHERE TreeUrl='Lists/EcomRmaEvent_List.aspx'">
                    INSERT INTO Ecom7Tree ([parentId], [Text], [Alt], [TreeIcon], [TreeIconOpen], [TreeUrl], [TreeChildPopulate], [TreeSort], [TreeHasAccessModuleSystemName]) VALUES (94, 'Events', 7, 'tree/btn_rma_events.png', NULL, 'Lists/EcomRmaEvent_List.aspx', 'RMAEVENTS', 200, NULL)
                 </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="228" date="24-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    CREATE TABLE EcomRmaOrderLines (
                        RmaOrderLineId INT NOT NULL IDENTITY(1,1),
                        RmaOrderLineRmaId NVARCHAR(50) NOT NULL,
                        RmaOrderLineOrderLineId NVARCHAR(50) NOT NULL,
                        RmaOrderLineSerialNumber NVARCHAR(MAX),
                        CONSTRAINT EcomRmaOrderLines$PrimaryKey PRIMARY KEY(RmaOrderLineId),
                        CONSTRAINT EcomRmaOrderLines$ForeignKeyRmaId FOREIGN KEY(RmaOrderLineRmaId)
		                    REFERENCES EcomRmas(RmaId),
                        CONSTRAINT EcomRmaOrderLines$ForeignKeyOrderLineID FOREIGN KEY(RmaOrderLineOrderLineID)
		                    REFERENCES EcomOrderLines(OrderLineID)
                    )
                 </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="227" date="24-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomRmas] ADD [RmaType] INT NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="226" date="23-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <VatGroup>
                <sql conditional="">
                    UPDATE [Ecom7Tree] SET [Text] = 'VAT groups' WHERE [Text] = 'Sales tax groups'
                </sql>
            </VatGroup>
        </database>
    </package>
    
    <package version="225" releasedate="10-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="SELECT COUNT(*) FROM Ecom7Tree WHERE TreeUrl = 'Lists/EcomRmaState_List.aspx'">
                    INSERT INTO Ecom7Tree
                    (
                        parentId,
                        Text,
                        Alt,
                        TreeIcon,
                        TreeUrl,
                        TreeChildPopulate,
                        TreeSort
                    )
                    VALUES
                    (
                        92,
                        'States',
                        7,
                        'tree/btn_rma_orders.png',
                        'Lists/EcomRmaState_List.aspx',
                        'RMASTATES',
                        100
                    )
                </sql>
            </EcomRma>
        </database>
    </package>

    <package version="224" date="07-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="SELECT COUNT(*) FROM EcomTree WHERE TreeUrl = 'RmaList.aspx'">
                    INSERT INTO EcomTree(parentId, Text, Alt, TreeIcon, TreeIconOpen, TreeUrl, TreeChildPopulate, TreeSort, TreeHasAccessModuleSystemName) VALUES(1, 'RMA', NULL, NULL, NULL, 'RmaList.aspx', 'RMAS', 4, NULL)
                </sql>
            </EcomOrders>
        </database>
    </package>
    
    <package version="223" date="04-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderIsExported] BIT NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="222" releasedate="03-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="SELECT COUNT(RmaStateID) FROM EcomRmaStates">
                    INSERT INTO EcomRmaStates (
	                    RmaStateDefaultName,
	                    RmaStateDefaultDescription,
                        RmaStateIsDefaultStateForNewRma,
                        RmaStateTypeRelation
                    )
                    VALUES (
	                    'Waiting for product(s) from customer',
	                    'This state indicates a newly created RMA where product(s) have not been received yet.',
	                    blnTrue,
                        '1,2,3'
                    ),
                    (
	                    'Received from customer',
	                    'This state indicates that the product has been received from the customer.',
	                    blnFalse,
                        '1,2,3'
                    ),
                    (
                        'Rejected',
                        'This state indicates that the RMA has been rejected.',
	                    blnFalse,
                        '1,2,3'
                    ),
                    (
	                    'Sent for repair',
	                    'This state indicates that the product has been sent to be repaired.',
	                    blnFalse,
                        '2'
                    ),
                    (
	                    'Received from repair',
	                    'This state indicates that the product has been received from repair.',
	                    blnFalse,
                        '2'
                    ),
                    (
	                    'Returned to customer',
	                    'This state indicates that the product has been sent back to the customer.',
	                    blnFalse,
                        '1,2,3'
                    ),
                    (
	                    'Sent replacement to customer',
	                    'This state indicates that a replacement product has been sent to the customer.',
	                    blnFalse,
                        '2,3'
                    )
                </sql>
            </EcomRma>
        </database>
    </package>

    <package version="221" releasedate="03-05-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="">
                    CREATE TABLE EcomRmaCommentImages(
                        RmaCommentImageCommentId INT NOT NULL,
                        RmaCommentImagePath NVARCHAR(255) NOT NULL,
                        CONSTRAINT EcomRmaImages$ForeignKeyEcomRmaComments FOREIGN KEY(RmaCommentImageCommentId)
                            REFERENCES EcomRmaComments(RmaCommentId)
                    )
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomRmaComments] ADD [RmaCommentEvent] NVARCHAR(255) NULL
                </sql>
                <sql conditional="">
                    ALTER TABLE [EcomRmaStates] ADD [RmaStateIsDefaultStateForNewRma] BIT NULL
                </sql>
                <sql conditional="SELECT COUNT(RmaEventType) FROM EcomRmaEvents">
                    INSERT INTO  [EcomRmaEvents] VALUES ('UserInfoChanged', 'User information has been updated.'),
					                					('Created', 'RMA Created.'),
									                	('StateChanged', 'The state of the RMA has been changed.'),
                										('Closed', 'The RMA has been closed.'),
				                						('Deleted', 'The RMA has been deleted.'),
                										('CommentAdded', 'A comment has been added to the RMA.'),
                                                        ('ReplacementOrderSet', 'The replacement order has been set.')
				</sql>
           </EcomRma>
        </database>
    </package>

    <package version="220" releasedate="26-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="">
                    CREATE TABLE EcomRmaComments (
                        RmaCommentId INT IDENTITY(1,1) NOT NULL,
                        RmaCommentRmaId NVARCHAR(50) NOT NULL,
                        RmaCommentNewRmaState INT NOT NULL,
                        RmaCommentText NVARCHAR(MAX) NULL,
                        RmaCommentCreated DATETIME NOT NULL,
                        CONSTRAINT EcomRmaComments$PrimaryKey PRIMARY KEY(RmaCommentId),
                        CONSTRAINT EcomRmaComments$ForeignKeyRmaID FOREIGN KEY(RmaCommentRmaId)
                                REFERENCES EcomRmas(RmaID),
                        CONSTRAINT EcomRmaComments$ForeignKeyRmaNewStateID FOREIGN KEY(RmaCommentNewRmaState)
                                REFERENCES EcomRmaStates(RmaStateID)
                        )
                </sql>

                <sql conditional="">
                    CREATE TABLE EcomRmaEvents (
                        RmaEventType NVARCHAR(255) NOT NULL,
                        RmaEventDescription NVARCHAR(MAX) NOT NULL,
                        CONSTRAINT EcomRmaEvents$PrimaryKey PRIMARY KEY(RmaEventType)
                    )
                </sql>

                <sql conditional="">
                    CREATE TABLE EcomRmaEventTranslations (
                        RmaEventTranslationEventType NVARCHAR(255) NOT NULL,
                        RmaEventTranslationLanguageId NVARCHAR(50) NOT NULL,
                        RmaEventTranslatedDescription NVARCHAR(MAX) NOT NULL,
                        CONSTRAINT EcomRmaEventTranslations$PrimaryKey PRIMARY KEY(RmaEventTranslationEventType, RmaEventTranslationLanguageId),
                        CONSTRAINT EcomRmaEventTranslations$ForeignKeyRmaEventLanguageId FOREIGN KEY(RmaEventTranslationLanguageId) 
                            REFERENCES EcomLanguages(LanguageID),
                        CONSTRAINT EcomRmaEventTranslations$ForeignKeyRmaEvents FOREIGN KEY(RmaEventTranslationEventType) 
                            REFERENCES EcomRmaEvents(RmaEventType)
                    )                
                </sql>
           </EcomRma>
        </database>
    </package>

    <package version="219" releasedate="26-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomRma>
                <sql conditional="SELECT COUNT(*) FROM EcomNumbers WHERE NumberType = 'RMA'">
                    INSERT INTO EcomNumbers (
                        NumberID,
                        NumberType, 
                        NumberDescription, 
                        NumberCounter, 
                        NumberPrefix, 
                        NumberAdd,
                        NumberEditable
                    ) VALUES (
                        45,
                        'RMA',
                        'Return merchandise authorization',
                        0,
                        'RMA',
                        1,
                        blnFalse
                    )
                </sql>
                <sql conditional="">
                    CREATE TABLE EcomRmaStates (
	                    RmaStateID INT IDENTITY(1,1) NOT NULL,
	                    RmaStateDefaultName NVARCHAR(255) NOT NULL,
	                    RmaStateDefaultDescription NVARCHAR(MAX) NULL,
                        RmaStateTypeRelation NVARCHAR(MAX) NULL,
	                    CONSTRAINT EcomRmaStates$PrimaryKey PRIMARY KEY(RmaStateID)
                    )
                </sql>

                <sql conditional="">
                    CREATE TABLE EcomRmaStateTranslations (
	                    RmaStateID INT NOT NULL,
	                    RmaStateLanguageID NVARCHAR(50) NOT NULL,
	                    RmaStateName NVARCHAR(255) NULL,
	                    RmaStateDescription NVARCHAR(MAX) NULL,
	                    CONSTRAINT EcomRmaStateTranslations$PrimaryKey PRIMARY KEY(RmaStateID, RmaStateLanguageID),
	                    CONSTRAINT EcomRmaStateTranslations$ForeignKeyRmaStateID FOREIGN KEY(RmaStateID)
		                    REFERENCES EcomRmaStates(RmaStateID),
	                    CONSTRAINT EcomRmaStateTranslations$ForeignKeyRmaStateLanguageID FOREIGN KEY(RmaStateLanguageID)
		                    REFERENCES EcomLanguages(LanguageID)
                    )
                </sql>

                <sql conditional="">
                    CREATE TABLE EcomRmas (
	                    RmaID NVARCHAR(50) NOT NULL,
	                    RmaReplacementOrderID NVARCHAR(50) NULL,
	                    RmaEmailNotificationLanguage nvarchar(50) not null,
                        RmaStateID INT NOT NULL,
	                    RmaClosed BIT NOT NULL,
	                    RmaDeleted BIT NOT NULL,

	                    RmaCustomerNumber NVARCHAR(255) NULL,
	                    RmaCustomerCompany NVARCHAR(255) NULL,
	                    RmaCustomerName NVARCHAR(255) NULL,
	                    RmaCustomerAddress NVARCHAR(255) NULL,
	                    RmaCustomerAddress2 NVARCHAR(255) NULL,
	                    RmaCustomerZip NVARCHAR(50) NULL,
	                    RmaCustomerCity NVARCHAR(255) NULL,
	                    RmaCustomerCountry NVARCHAR(50) NULL,
	                    RmaCustomerRegion NVARCHAR(50) NULL,
	                    RmaCustomerPhone NVARCHAR(50) NULL,
	                    RmaCustomerFax NVARCHAR(50) NULL,
	                    RmaCustomerEmail NVARCHAR(255) NULL,
	                    RmaCustomerCell NVARCHAR(50) NULL,
	                    RmaCustomerRefID NVARCHAR(255) NULL,
	                    RmaCustomerEAN NVARCHAR(255) NULL,
	                    RmaCustomerVatRegNumber NVARCHAR(255) NULL,
	                    RmaDeliveryCompany NVARCHAR(255) NULL,
	                    RmaDeliveryName NVARCHAR(255) NULL,
	                    RmaDeliveryAddress NVARCHAR(255) NULL,
	                    RmaDeliveryAddress2 NVARCHAR(255) NULL,
	                    RmaDeliveryZip NVARCHAR(50) NULL,
	                    RmaDeliveryCity NVARCHAR(255) NULL,
	                    RmaDeliveryCountry NVARCHAR(50) NULL,
	                    RmaDeliveryRegion NVARCHAR(50) NULL,
	                    RmaDeliveryPhone NVARCHAR(50) NULL,
	                    RmaDeliveryFax NVARCHAR(50) NULL,
	                    RmaDeliveryEmail NVARCHAR(255) NULL,
	                    RmaDeliveryCell NVARCHAR(50) NULL,
	                    CONSTRAINT EcomRmas$PrimaryKey PRIMARY KEY(RmaID),
	                    CONSTRAINT EcomRmas$ForeignKeyReplacementOrderID FOREIGN KEY(RmaReplacementOrderID)
		                    REFERENCES EcomOrders(OrderID),
	                    CONSTRAINT EcomRmas$ForeignKeyRmaStateID FOREIGN KEY(RmaStateID)
		                    REFERENCES EcomRmaStates(RmaStateID),
                            CONSTRAINT EcomRmas$ForeignKeyLanguageId FOREIGN KEY(RmaEmailNotificationLanguage)
		                    REFERENCES EcomLanguages(LanguageID),


                    )                
                </sql>
            </EcomRma>
        </database>
    </package>

    <package version="218" date="17-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomVatGroups] ADD [VatGroupConfigurableVatProviderSettings] NVARCHAR(MAX) NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="217" date="16-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomOrders>
                <sql conditional="">
                    ALTER TABLE [EcomOrders] ADD [OrderVisitorSessionID] NVARCHAR(255) NULL
                </sql>
            </EcomOrders>
        </database>
    </package>

    <package version="216" date="12-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE  [TreeUrl] = 'Lists/EcomTaxSetting_List.aspx'">
                    INSERT INTO [Ecom7Tree]
                    (
                        [parentId],
                        [Text],
                        [Alt],
                        [TreeIcon],
                        [TreeUrl],
                        [TreeChildPopulate],
                        [TreeSort],
                        [TreeHasAccessModuleSystemName]
                    )
                    VALUES
                    (
                        93,
                        'Taxes',
                        7,
                        'tree/btn_taxsetting.png',
                        'Lists/EcomTaxSetting_List.aspx',
                        'TAXSETTING',
                        45,
                        'eCom_CartV2'
                    )
                </sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="215" date="4-04-2012" internalversion="8.1.0.0">
        <file name="InformationWithStates.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
        <file name="ReceiptWithStates.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
    </package>

    <package version="214" date="1-04-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <Regions>
                <sql conditional="">
                    ALTER TABLE EcomCountries ADD CountryRegionCode nvarchar(2) NOT NULL DEFAULT N'' WITH VALUES;
                    ALTER TABLE EcomCountryText ADD CountryTextRegionCode nvarchar(2) NOT NULL DEFAULT N'' WITH VALUES;
                    ALTER TABLE EcomMethodCountryRelation ADD MethodCountryRelRegionCode nvarchar(2) NOT NULL DEFAULT N'' WITH VALUES;
                    ALTER TABLE EcomFees ADD FeeRegionCode nvarchar(2) NOT NULL DEFAULT N'' WITH VALUES;
                    ALTER TABLE EcomCountryText DROP CONSTRAINT EcomCountryText$EcomCountriesEcomCountryText;
                    ALTER TABLE EcomCountryText DROP CONSTRAINT EcomCountryText$PrimaryKey;
                    ALTER TABLE EcomCountries DROP CONSTRAINT EcomCountries$PrimaryKey;
                    ALTER TABLE EcomCountries ADD CONSTRAINT PK_EcomCountries PRIMARY KEY (CountryCode2 ASC, CountryRegionCode ASC);
                    ALTER TABLE EcomCountryText ADD CONSTRAINT PK_EcomCountryText PRIMARY KEY (CountryTextCode2 ASC, CountryTextRegionCode ASC, CountryTextLanguageID);
                    ALTER TABLE EcomCountryText ADD CONSTRAINT FK_EcomCountryText_EcomCountries FOREIGN KEY(CountryTextCode2, CountryTextRegionCode)
                        REFERENCES EcomCountries (CountryCode2, CountryRegionCode);
                </sql>
            </Regions>
        </database>
    </package>

    <package version="213" date="30-03-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <TaxProviders>
                <sql conditional="">
                    CREATE TABLE EcomTaxSettings (
                        TaxSettingID INT IDENTITY(1,1) NOT NULL,
                        TaxSettingName NVARCHAR(255) NULL,
                        TaxSettingActive BIT NOT NULL,
                        TaxSettingProviderSettings NVARCHAR(MAX) NULL,
                        CONSTRAINT EcomTaxSettings$PrimaryKey PRIMARY KEY(TaxSettingID)
                    )
                </sql>
            </TaxProviders>
        </database>
    </package>

    <package version="212" date="27-03-2012" internalversion="8.1.0.0">
    </package>

    <package version="211" date="27-03-2012" internalversion="8.1.0.0">
    </package>

    <package version="210" date="27-03-2012" internalversion="8.1.0.0">
    </package>

    <package version="209" date="27-03-2012" internalversion="8.1.0.0">
    </package>

    <package version="208" date="27-03-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomProductItems>
                <sql conditional="">ALTER TABLE [EcomProductItems] ADD [ProductItemSortOrder] INT NULL</sql>
            </EcomProductItems>
        </database>
    </package>

    <package version="207" date="26-03-2012" internalversion="8.1.0.0">
        <setting key="/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists" value="True" overwrite="false" />
    </package>

    <package version="206" date="19-03-2012" internalversion="8.1.0.0">
    </package>

    <package version="205" date="13-03-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <EcomShippings>
                <sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupFilterPagedQueryMode] INT NULL</sql>
            </EcomShippings>
        </database>
    </package>

    <package version="204" date="11-03-2012" internalversion="8.1.0.0">
        <database file="Ecom.mdb">
            <Ecom7Tree>
                <sql conditional="">UPDATE [Ecom7Tree] SET [Text] = 'Fields' WHERE [TreeUrl] = '/Admin/Module/Ecom_cpl.aspx?cmd=2'</sql>
            </Ecom7Tree>
        </database>
    </package>

    <package version="203" date="09-03-2012" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
            <NaviconnectIntegration>
                <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'ecom_NaviconnectIntegration'">
                    INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta)
                    VALUES ('ecom_NaviconnectIntegration', 'Naviconnect Integration', 0, 'eCom_NaviconnectIntegration/eCom_NaviconnectIntegration_edit.aspx', 0, 0, NULL, 0)
                </sql>
            </NaviconnectIntegration>
        </database>
    </package>

    <package version="202" date="19-01-2012" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
            <EcomShippings>
                <sql conditional="">ALTER TABLE [EcomShippings] ADD [ShippingServiceSystemName] NVARCHAR(MAX) NULL</sql>
                <sql conditional="">ALTER TABLE [EcomShippings] ADD [ShippingServiceParameters] NVARCHAR(MAX) NULL</sql>      
            </EcomShippings>
        </database>
    </package>

    <package version="201" date="10-01-2012" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
            <EcomProductCategories>
                <sql conditional="IF OBJECT_ID(N'dbo.getVariantGroupIDsForProductAsCSV', N'FN') IS NULL BEGIN SELECT 1 END">
                    ALTER FUNCTION [dbo].[getVariantGroupIDsForProductAsCSV]
                        (@id AS NVARCHAR(255),@languageID AS NVARCHAR(255))
                        RETURNS NVARCHAR(1000)
                    AS
                    BEGIN
                        DECLARE @csv NVARCHAR(1000)
                        SELECT @csv = COALESCE(@csv+'","','') + CONVERT(nvarchar,variantGroupID)
                        FROM ecomvariantgroupproductrelation INNER JOIN ecomvariantGroups ON  variantgroupid= variantgroupproductrelationvariantgroupid AND variantgrouplanguageid=@languageID
                        WHERE variantgroupproductrelationproductid=@id   AND variantgrouplanguageid=@languageID 
                        RETURN '"'+@csv+'"'
                    END
                    </sql>
                    <sql conditional="IF OBJECT_ID(N'dbo.getVariantGroupNamesForProductAsCSV', N'FN') IS NULL BEGIN SELECT 1 END">
                    ALTER FUNCTION [dbo].[getVariantGroupNamesForProductAsCSV]
                        (@id AS NVARCHAR(255),@languageID as NVARCHAR(255))
                        RETURNS NVARCHAR(1000)
                    AS
                    BEGIN
                        DECLARE @csv NVARCHAR(1000)
                        SELECT @csv = COALESCE(@csv+'","','') + CONVERT(nvarchar,variantGroupName)
                        FROM ecomvariantgroupproductrelation JOIN ecomvariantGroups ON  variantgroupid= variantgroupproductrelationvariantgroupid AND variantgrouplanguageid=@languageID
                        WHERE variantgroupproductrelationproductid=@id AND variantgrouplanguageid=@languageID
                        RETURN '"'+@csv+'"'
                    END
                </sql>
            </EcomProductCategories>
        </database>
    </package>

</updates>
