<?xml version="1.0" encoding="UTF-8" ?>
<updates>
  <!--
	This file is a legacy update script. It is only used when a solution has been upgraded to 8.0.0.0.
    Add new update packages to the ecom.xml.aspx file instead.

    ================================
    DO NOT ADD CONTENT TO THIS FILE!
    ================================
	-->

  <current version="184" releasedate="16-11-2011" internalversion="8.0.0.0" />

  <package version="184" date="16-11-2011" internalversion="8.0.0.0">
    <file name="checkouthandler_cancel.html"  source="/Files/Templates/eCom7/CheckoutHandler/BBS/Cancel" target="/Files/Templates/eCom7/CheckoutHandler/BBS/Cancel" overwrite="false" />
    <file name="checkouthandler_error.html"   source="/Files/Templates/eCom7/CheckoutHandler/BBS/Error" target="/Files/Templates/eCom7/CheckoutHandler/BBS/Error" overwrite="false" />
  </package>

  <package version="183" date="25-10-2011" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
          <economics>
              <sql conditional="">
               UPDATE [Module] SET ModuleIsBeta = blnFalse WHERE ModuleSystemName = 'eCom_economic'
              </sql>
          </economics>
      </database>
  </package>

  <package version="182" date="25-10-2011" internalversion="8.0.0.0">
    <file name="RelayResponse.html"           source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Relay" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Relay" overwrite="false" />
  </package>

  <package version="181" date="19-10-2011" internalversion="8.0.0.0">
    <file name="checkouthandler_cancel.html"  source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Cancel" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Cancel" overwrite="false" />
    <file name="checkouthandler_error.html"   source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Error" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Error" overwrite="false" />
    <file name="Post.html"                    source="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Post" target="/Files/Templates/eCom7/CheckoutHandler/AuthorizeNet/Post" overwrite="false" />
  </package>

  <package version="180" date="05-10-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <Ecom7Tree>
        <sql conditional="SELECT COUNT(*) FROM EcomPropertyType">DELETE FROM [Ecom7Tree] WHERE [TreeUrl] IN ('Lists/EcomPropType_List.aspx')</sql>
        <sql conditional="">DELETE FROM [Ecom7Tree] WHERE [TreeUrl] IN ('/Admin/Module/MwProductSheet/MwProductSheet_TemplateList.aspx', '/Admin/Module/MwCatalog/MwCatalogList.aspx') </sql>
      </Ecom7Tree>
    </database>
  </package>
  
  <package version="179" date="04-10-2011" internalversion="8.0.0.0">
    <database file="ecom.mdb">
      <AXIntegration>
        <sql conditional="SELECT COUNT(*) FROM [Module] WHERE [ModuleSystemName] = 'eCom_AXIntegration'">
        INSERT INTO [Module] 
        (
        ModuleSystemName, 
        ModuleName, 
        ModuleAccess, 
        ModuleStandard, 
        ModuleScript, 
        ModuleParagraph, 
        ModuleHiddenMode, 
        ModuleEcomNotInstalledAccess, 
        ModuleIsBeta
        ) VALUES (
        'eCom_AXIntegration', 
        'Dynamics AX Integration', 
        0, 
        0, 
        'eCom_AXIntegration/eCom_AXIntegration_edit.aspx', 
        0, 
        0, 
        NULL, 
        0
        )
        </sql>
      </AXIntegration>
    </database>
  </package>
  
  <package version="178" date="27-09-2011" internalversion="8.0.0.0">
    <database file="ecom.mdb">
      <EcomPeriods>
        <sql conditional="">ALTER TABLE [EcomPeriods] ADD [PeriodShowProductsAfterExpiration] BIT NULL</sql>
      </EcomPeriods>
    </database>
  </package>

  <package version="177" date="30-06-2011" internalversion="8.0.0.0">
	<!--
    <database file="Ecom.mdb">
      <EcomProductCategories>
        <sql conditional="">
          ALTER TABLE [EcomGroups] DROP CONSTRAINT [EcomGroups$CategoryID];
        </sql>
        <sql conditional="SELECT COUNT(*) FROM [EcomProductCategories] WHERE [CategoryLanguageID] LIKE '%LANG%'">
          UPDATE [EcomProductCategories] SET [CategoryLanguageID] = (SELECT [LanguageID] FROM [EcomLanguages] WHERE [LanguageIsDefault] = blnTrue);
        </sql>
        <sql conditional="">
          ALTER TABLE [EcomProductCategories] ALTER COLUMN [CategoryLanguageID] NVARCHAR(50) NOT NULL;
        </sql>
        <sql conditional="SELECT COUNT(*) from INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'EcomProductCategories' AND COLUMN_NAME = 'CategoryLanguageID'">
          DECLARE @n NVARCHAR(MAX);
          DECLARE @s NVARCHAR(MAX);
          SELECT @n = name FROM sysobjects WHERE parent_obj = OBJECT_ID('EcomProductCategories') AND xtype = 'PK';
          SELECT @s = 'ALTER TABLE [EcomProductCategories] DROP CONSTRAINT [' + @n + ']';
          EXECUTE sp_sqlexec @s;
          ALTER TABLE [EcomProductCategories] ADD CONSTRAINT [EcomProductCategories$PrimaryKey] PRIMARY KEY ([CategoryID], [CategoryLanguageID]);
        </sql>
      </EcomProductCategories>
    </database>
	-->
  </package>

  <package version="176" date="22-04-2011" internalversion="8.0.0.0">
        <database file="Dynamic.mdb">
            <Ecom7Tree>
                <sql conditional="">UPDATE [Module] SET [ModuleScript] = 'Integration/Frame.aspx' WHERE [ModuleSystemName] = 'eCom_ImportExport'</sql>
            </Ecom7Tree>
        </database>
    </package>
    
    <package version="175" date="22-04-2011" internalversion="8.0.0.0">
        <!-- HAS NO EFFECT DUE TO UPDATE 176
        <database file="Dynamic.mdb">
            <Ecom7Tree>
                <sql conditional="">UPDATE [Module] SET [ModuleScript] = 'Integration/Wizard.aspx' WHERE [ModuleSystemName] = 'eCom_ImportExport'</sql>
            </Ecom7Tree>
        </database>
        -->
    </package>

    <package version="174" date="09-06-2011" internalversion="19.2.3.4">
        <file name="RangeFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    </package>

    <package version="173" date="03-06-2011" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
            <EcomGroupFilterSetting>
                <sql conditional="">
                    ALTER TABLE [EcomGroupFilterSetting] ADD
                    [EcomGroupFilterSettingLimitOptions] BIT NULL DEFAULT(0),
                    [EcomGroupFilterSettingOptionsMergeMode] NVARCHAR(50) NULL
                </sql>
            </EcomGroupFilterSetting>
        </database>
    </package>

    <package version="167" date="30-05-2011" internalversion="8.0.0.0">
        <database file="Ecom.mdb">
            <EcomGroupFilterOption>
                <sql conditional="">
                    CREATE TABLE [EcomGroupFilterOption]
                    (
                    [EcomGroupFilterOptionID] IDENTITY PRIMARY KEY NOT NULL,
                    [EcomGroupFilterOptionGroupID] NVARCHAR(255) NOT NULL,
                    [EcomGroupFilterOptionGroupLanguageID] NVARCHAR(255) NOT NULL,
                    [EcomGroupFilterOptionDefinitionID] INT NOT NULL,
                    [EcomGroupFilterOptionLabel] NVARCHAR(255) NULL,
                    [EcomGroupFilterOptionValue] NVARCHAR(255) NULL,
                    [EcomGroupFilterOptionSort] INT NULL
                    )
                </sql>
            </EcomGroupFilterOption>
        </database>
    </package>
    
  <package version="172" date="18-05-2011" internalversion="8.0.0.0">
    <database file="Dynamic.mdb">
      <EcomGroupFilterSetting>
        <sql conditional="">
          CREATE TABLE [EcomGroupFilterSetting]
          (
            [EcomGroupFilterSettingID] IDENTITY PRIMARY KEY NOT NULL,
            [EcomGroupFilterSettingGroupID] NVARCHAR(255) NOT NULL,
            [EcomGroupFilterSettingGroupLanguageID] NVARCHAR(255) NOT NULL,
            [EcomGroupFilterSettingDefinitionID] INT NOT NULL,
            [EcomGroupFilterSettingVisibility] NVARCHAR(50) NULL
          )
        </sql>
      </EcomGroupFilterSetting>
    </database>
  </package>
    
  <package version="171" date="04-05-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <AXIntegration>
        <sql conditional="">
          ALTER TABLE [EcomOrderLines] DROP [OrderLineAXDiscountAmount]
          ALTER TABLE [EcomOrderLines] DROP [OrderLineAXDiscountPercent]
        </sql>
      </AXIntegration>
    </database>
  </package>

  <package version="170" date="03-05-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <Ecom7Tree>
        <sql conditional="">
          <sql conditional="">DELETE FROM [Ecom7Tree] WHERE [TreeUrl] IN ('Lists/EcomList.aspx?type=ORDER', 'Lists/EcomList.aspx?type=IMPEXP') </sql>
        </sql>
      </Ecom7Tree>
    </database>
  </package>
  
  <package version="169" date="27-04-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <AXIntegration>
        <sql conditional="">
          EXEC sp_rename '[EcomOrders].[OrderAXOrderID]', 'OrderIntegrationOrderID', 'COLUMN'
        </sql>
      </AXIntegration>
    </database>
  </package>

  <package version="168" date="26-04-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <Ecom7Tree>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomShop_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=SHOP'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomLang_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=LANG'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomCurrency_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=CURR'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomUnit_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=UNIT'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomPeriod_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=PERIOD'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomNumber_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=NUM'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomManu_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=MANU'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomVariantGrp_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=VARIANTGRP'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomCountry_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=COUNTRY'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomPayment_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=PAYMENT'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomShipping_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=SHIPPING'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomSalesDiscount_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=SALESDISCNT'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomStockGrp_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=STOCKGRP'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomRounding_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=ROUNDING'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomVatGroup_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=VATGRP'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomRelGrp_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=RELGRP'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomField_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=FIELD'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomPropType_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=PROPTYPE'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomOrderField_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=ORDERFIELD'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomGroupField_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=GROUPFIELD'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomValidationGroup_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=VALIDATIONGROUPS'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomOrderLineField_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=ORDERLINEFIELDS'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomProductCategory_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=CATEGORIES'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomOrderFlow_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=ORDERFLOW'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeUrl] = 'Lists/EcomTrackAndTrace_List.aspx' WHERE [TreeUrl] = 'Lists/EcomList.aspx?type=TRACKANDTRACE'</sql>
      </Ecom7Tree>
    </database>
  </package>

  <package version="167" date="19-04-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <EcomTree>
        <sql conditional="">UPDATE [Ecom7Tree] SET TreeHasAccessModuleSystemName = 'eCom_Catalog' WHERE TreeChildPopulate = 'Ecom7General'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET TreeHasAccessModuleSystemName = 'eCom_Catalog' WHERE TreeChildPopulate = 'Ecom7Language'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET TreeHasAccessModuleSystemName = 'eCom_Catalog' WHERE TreeChildPopulate = 'Ecom7Priser'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET TreeHasAccessModuleSystemName = 'eCom_Catalog' WHERE TreeChildPopulate = 'Ecom7Images'</sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET TreeHasAccessModuleSystemName = 'eCom_Catalog' WHERE TreeChildPopulate = 'NUMBERS'</sql>
      </EcomTree>
    </database>
  </package>    
    
  <package version="166" date="12-04-2011" internalversion="8.0.0.0">
    <database file="Access.mdb">
      <AXIntegration>
        <sql conditional="">
          ALTER TABLE [AccessUser] ADD [AccessUserShopID] NVARCHAR(255)
        </sql>
      </AXIntegration>
    </database>
  </package>

  <package version="165" date="12-04-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <AXIntegration>
        <sql conditional="">
          ALTER TABLE [EcomOrders] ADD [OrderRequisition] NVARCHAR(255)
        </sql>
      </AXIntegration>
    </database>
  </package>

  <package version="164" date="08-04-2011" internalversion="8.0.0.0">
    <database file="Dynamic.mdb">
      <ValidationGroups>
        <sql conditional="">
          UPDATE [Ecom7Tree] SET [parentId] = 92 WHERE [TreeChildPopulate] = 'VALIDATIONGROUPS'
        </sql>
      </ValidationGroups>
    </database>
  </package>
  
  <package version="163" date="08-03-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <AXIntegration>
        <sql conditional="">
          ALTER TABLE [EcomOrderLines] ADD [OrderLineAXDiscountAmount] FLOAT
          ALTER TABLE [EcomOrderLines] ADD [OrderLineAXDiscountPercent] FLOAT
        </sql>
      </AXIntegration>
    </database>
  </package>

  <package version="162" date="02-03-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <AXIntegration>
        <sql conditional="">
          ALTER TABLE [EcomOrders] ADD [OrderAXOrderID] NVARCHAR(MAX)
        </sql>
      </AXIntegration>
    </database>
  </package>
  
  <package version="161" date="07-02-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <Salestaxgroup>
        <sql conditional="select count(isoid) from ecomglobalISO where ISOCurrencyCode=941">
          insert into EcomGlobalISO values( 'RS','SRB','Serbien','Serbia','Dinar',null,941,941,'RSD',null,null,null,0)
        </sql>
      </Salestaxgroup>
    </database>
  </package>

  <package version="160" date="07-02-2011" internalversion="8.0.0.0">
    <database file="Ecom.mdb">
      <Salestaxgroup>
        <sql conditional="">
          alter table EcomOrders alter column OrderCustomerEmail nvarchar(255)
          alter table EcomOrders alter column OrderDeliveryEmail nvarchar(255)
          alter table EcomOrders alter column OrderShippingMethod nvarchar(255)
          alter table EcomOrders alter column OrderPaymentMethod nvarchar(255)


        </sql>
      </Salestaxgroup>
    </database>
  </package>

  <package version="159" date="13-01-2011" internalversion="19.2.0.0">
      <database file="Ecom.mdb">
          <Salestaxgroup>
              <sql conditional="">
                  UPDATE [Ecom7Tree] SET [Text] = 'Sales tax groups' WHERE [id] = 37
              </sql>
          </Salestaxgroup>
      </database>
  </package>
  
  <package version="158" date="28-12-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <NAVIntegration>
        <sql conditional="SELECT ModuleID FROM [Module] WHERE ModuleSystemName = 'eCom_economic'">
          INSERT INTO [Module]
          (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta)
          VALUES
          ('eCom_economic', 'e-conomic Integration', 0, 0, 'eCom_economic/eCom_economic_edit.aspx', 0, 0, NULL, 1)
        </sql>
      </NAVIntegration>
    </database>
  </package>

  <package version="157" date="16-12-2010" internalversion="19.2.0.0">
    <database file="Dynamic.mdb">
      <MetadataDelete>
        <sql conditional="">
          DELETE FROM [Ecom7Tree] WHERE [parentId] = 94 AND [Text] = 'Metadata'
        </sql>
      </MetadataDelete>
    </database>
  </package>
  
  <package version="156" date="15-12-2010" internalversion="19.2.0.0">
    <!--
    <database file="Dynamic.mdb">
      <ProductSheetTemplates>
        <sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'PRODUCTSHEETTEMPLATES'">
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
          'Product sheet templates',
          0,
          '/Admin/Images/Icons/Module_MwProductSheet_Small.gif',
          '/Admin/Module/MwProductSheet/MwProductSheet_TemplateList.aspx',
          'PRODUCTSHEETTEMPLATES',
          120,
          'MwProductSheet'
          )
        </sql>
      </ProductSheetTemplates>
      <CatalogGenerator>
        <sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'CATALOGGENERATOR'">
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
          'Catalog Generator',
          0,
          '/Admin/Images/Icons/Module_MwCatalog_Small.gif',
          '/Admin/Module/MwCatalog/MwCatalogList.aspx',
          'CATALOGGENERATOR',
          120,
          'MwCatalog'
          )
        </sql>
      </CatalogGenerator>
    </database>
    -->
  </package>
  
  <package version="155" date="10-12-2010" internalversion="19.2.0.0">
    <file name="checkouthandler_cancel.html"  source="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Cancel" target="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Cancel" overwrite="false" />
    <file name="checkouthandler_error.html"   source="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Error" target="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Error" overwrite="false" />
    <file name="Post.html"                    source="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Post" target="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Post" overwrite="false" />
    <file name="checkouthandler_success.html" source="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Success" target="/Files/Templates/eCom7/CheckoutHandler/Buckaroo/Success" overwrite="false" />
  </package>

  <package version="154" date="03-12-2010" internalversion="19.2.0.0">
    <file name="Comment.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
    <file name="ProductAdvanced.html" source="/Files/Templates/eCom/Product" target="/Files/Templates/eCom/Product" overwrite="false" />
  </package>
  
  <package version="153" date="03-12-2010" internalversion="19.2.0.0">
    <file name="ProductFieldsFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="152" date="03-12-2010" internalversion="19.2.0.0">
    <file name="RangeFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="151" date="02-12-2010" internalversion="19.2.0.0">
    <file name="PriceFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="DelimitFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="150" date="29-11-2010" internalversion="19.2.0.0">
    <file name="SearchFormAdvanced.html" source="/Files/Templates/eCom/Search" target="/Files/Templates/eCom/Search" overwrite="false" />
    <file name="SearchFormSuggestions.html" source="/Files/Templates/eCom/Search" target="/Files/Templates/eCom/Search" overwrite="false" />
  </package>
  
  <package version="149" date="24-11-2010" internalversion="19.1.1.0">
    <database file="Ecom.mdb">
      <Details>
        <sql conditional="">
          ALTER TABLE [EcomDetails]
          ADD [DetailSortOrder] INT
        </sql>
      </Details>
    </database>
  </package>
  <package version="148" date="22-11-2010" internalversion="19.2.0.0">
    <file name="SearchFormAdvanced.html" source="/Files/Templates/eCom/Search" target="/Files/Templates/eCom/Search" overwrite="false" />
  </package>
  
    <package version="147" date="22-11-2010" internalversion="19.2.0.0">
        <database file="Ecom.mdb">
            <eComPowerPack>
                <sql conditional="">UPDATE [Module] SET [ModuleEcomStandardAccess] = '0', [ModuleEcomExtendedAccess] = '0' WHERE [ModuleSystemName] = 'eCom_SearchExtended'</sql>
            </eComPowerPack>
        </database>
    </package>
  
  <package version="146" date="19-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <eComPowerPack>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeHasAccessModuleSystemName] = 'eCom_SearchExtended' WHERE [TreeChildPopulate] = 'SEARCHFILTERS'</sql>
        <sql conditional="">UPDATE [Module] SET [ModuleName] = 'PowerPack', [ModuleDescription] = 'PowerPack' WHERE [ModuleSystemName] = 'eCom_PowerPack'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_SearchExtended'">
          INSERT INTO [Module]
          (
            [ModuleSystemName],
            [ModuleName],
            [ModuleControlPanel],
            [ModuleDescription],
            [ModuleHiddenMode],
            [ModuleParagraph],
            [ModuleIsBeta],
            [ModuleEcomNotInstalledAccess],
            [ModuleEcomStandardAccess],
            [ModuleEcomExtendedAccess],
            [ModuleEcomLightAccess]
            )
            VALUES
            (
            'eCom_SearchExtended',
            'Product search (Extended)',
            '',
            'Product search (Extended)',
            0,
            0,
            0,
            0,
            1,
            1,
            0
          )
        </sql>
      </eComPowerPack>
    </database>
  </package>
  
  <package version="145" date="16-11-2010" internalversion="19.2.0.0">
    <file name="PriceFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="ManufacturerFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="VariantFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="GroupFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="144" releasedate="12-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <EcomFilterVisibilityCondition>
        <sql conditional="">
          CREATE TABLE [EcomFilterVisibilityCondition]
          (
          [EcomFilterVisibilityConditionID] IDENTITY PRIMARY KEY NOT NULL,
          [EcomFilterVisibilityConditionDefinitionID] INT NOT NULL,
          [EcomFilterVisibilityConditionDependantDefinitionID] INT NOT NULL,
          [EcomFilterVisibilityConditionValue] NVARCHAR(MAX) NULL
          )
        </sql>
      </EcomFilterVisibilityCondition>
      <EcomFilterDefinition>
        <sql conditional="">
          ALTER TABLE [EcomFilterDefinition] ADD [EcomFilterDefinitionVisibilityRule] INT NULL DEFAULT(1)
        </sql>
      </EcomFilterDefinition>
      <Constraints>
        <sql conditional="">
          ALTER TABLE [EcomFilterVisibilityCondition] ADD CONSTRAINT [EcomFilterVisibilityCondition$DefinitionID] FOREIGN KEY ([EcomFilterVisibilityConditionDefinitionID]) REFERENCES [EcomFilterDefinition]([EcomFilterDefinitionID])
        </sql>
        <sql conditional="">
          ALTER TABLE [EcomFilterVisibilityCondition] ADD CONSTRAINT [EcomFilterVisibilityCondition$DependantDefinitionID] FOREIGN KEY ([EcomFilterVisibilityConditionDependantDefinitionID]) REFERENCES [EcomFilterDefinition]([EcomFilterDefinitionID])
        </sql>
      </Constraints>
    </database>
  </package>
  

  <package version="142" date="10-11-2010" internalversion="19.2.0.0">
    <file name="TextFilterAdvanced.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
  
  <package version="141" date="09-11-2010" internalversion="19.2.0.0">
    <file name="PriceFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="ManufacturerFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="VariantFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
    <file name="GroupFilter.html" source="/Files/Templates/Filter" target="/Files/Templates/Filter" overwrite="false" />
  </package>
   
  <package version="140" date="08-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      
      <TrackAndTrace>
        <sql conditional="">
          CREATE TABLE [EcomTrackAndTrace]
          (
          [TrackAndTraceID] IDENTITY PRIMARY KEY NOT NULL,
          [TrackAndTraceName] NVARCHAR(255) NOT NULL,
          [TrackAndTraceURL] NVARCHAR(MAX) NOT NULL,
          [TrackAndTraceParameters] NVARCHAR(MAX) NULL
          )
        </sql>
      </TrackAndTrace>
    </database>
  </package>
  
  <package version="139" date="03-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <SearchEngine>
        <sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE  [TreeUrl] IN ('Lists/EcomList.aspx?type=TRACKANDTRACE', 'Lists/EcomTrackAndTrace_List.aspx')">
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
          92,
          'Track &amp; Trace',
          7,
          'tree/btn_trace.png',
          'Lists/EcomList.aspx?type=TRACKANDTRACE',
          'TRACKANDTRACE',
          80,
          'eCom_Cart, eCom_CartV2'
          )
        </sql>
      </SearchEngine>
    </database>
  </package>
  
  <package version="138" date="02-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <TrackAndTrace>
        <sql conditional="">
          CREATE TABLE [EcomTrackAndTrace]
          (
          [TrackAndTraceID] IDENTITY PRIMARY KEY NOT NULL,
          [TrackAndTraceName] NVARCHAR(255) NOT NULL
          [TrackAndTraceURL] NVARCHAR(MAX) NOT NULL
          [TrackAndTraceParameters] NVARCHAR(MAX) NULL
          )
        </sql>
        <sql conditional="">
          ALTER TABLE [EcomOrders] ADD [OrderTrackAndTraceID] INT NULL
        </sql>
        <sql conditional="">
          ALTER TABLE [EcomOrders] ADD [OrderTrackAndTraceParameters] NVARCHAR(MAX) NULL
        </sql>
      </TrackAndTrace>
    </database>
  </package>
  
  <package version="137" date="01-11-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <FilteredSearch>
        <sql conditional="">DELETE FROM [Module] WHERE [ModuleSystemName] = 'eCom_CatalogFiltered'</sql>
        <sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_PowerPack'">
          INSERT INTO [Module]
          (
          [ModuleSystemName],
          [ModuleName],
          [ModuleControlPanel],
          [ModuleDescription],
          [ModuleHiddenMode],
          [ModuleParagraph],
          [ModuleIsBeta],
          [ModuleEcomNotInstalledAccess],
          [ModuleEcomStandardAccess],
          [ModuleEcomExtendedAccess],
          [ModuleEcomLightAccess]
          )
          VALUES
          (
          'eCom_PowerPack',
          'eCommerce PowerPack',
          '',
          'eCommerce PowerPack',
          0,
          0,
          0,
          0,
          1,
          1,
          0
          )
        </sql>
        <sql conditional="">UPDATE [Ecom7Tree] SET [TreeHasAccessModuleSystemName] = 'eCom_PowerPack' WHERE [TreeChildPopulate] = 'SEARCHFILTERS'</sql>
      </FilteredSearch>
    </database>
  </package>



  <package version="136" date="23-10-2010" internalversion="19.2.0.0">
    <database file="Ecom.mdb">
      <EcomFilterDefinition>
        <sql conditional="">ALTER TABLE [EcomFilterDefinition] ADD [EcomFilterDefinitionTagName] NVARCHAR(255) NULL</sql>
      </EcomFilterDefinition>
    </database>
  </package>

  <package version="135" date="23-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <EcomProducts>
		<sql conditional="">
		  ALTER TABLE [EcomProducts] ADD [ProductCommentcount] INT NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomProducts] ADD [ProductRating] DOUBLE NULL
		</sql>
	  </EcomProducts>
	</database>
  </package>
  <package version="134" date="01-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ConvertStatesToFlows>
		<sql conditional="SELECT * FROM [EcomOrderFlow]">
		  INSERT INTO [EcomOrderFlow]([OrderFlowIsDefault],[OrderFlowName],[OrderFlowDescription])
		  VALUES (blnTrue, 'Default order flow', '')
		</sql>
		<sql conditional="">
		  UPDATE EcomOrderStates
		  SET [OrderFlowID] = (SELECT TOP 1 [OrderFlowID] FROM [EcomOrderFlow] WHERE OrderFlowIsDefault = blnTrue)
		  WHERE [OrderFlowID] IS NULL
		</sql>
		<sql conditional="">
		  UPDATE [EcomShops]
		  SET [ShopOrderFlowID] = (SELECT TOP 1 [OrderFlowID] FROM [EcomOrderFlow] WHERE OrderFlowIsDefault = blnTrue)
		  WHERE [ShopOrderFlowID] IS NULL
		</sql>
		<sql conditional="">
		  DELETE FROM Ecom7Tree WHERE [TreeChildPopulate] = 'ORDERSTATES'
		</sql>
	  </ConvertStatesToFlows>
	</database>
  </package>

  <package version="133" date="01-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <OrderFlows>
		<sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeUrl] IN ('Lists/EcomList.aspx?type=ORDERFLOW', 'Lists/EcomOrderFlow_List.aspx')">
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
		  92,
		  'Order flows',
		  7,
		  'tree/btn_checks.png',
		  'Lists/EcomList.aspx?type=ORDERFLOW',
		  'ORDERFLOW',
		  70,
		  'eCom_Cart, eCom_CartV2'
		  )
		</sql>
		<sql conditional="">
		  CREATE TABLE [EcomOrderFlow]
		  (
		  [OrderFlowID] IDENTITY PRIMARY KEY NOT NULL,
		  [OrderFlowIsDefault] BIT NOT NULL,
		  [OrderFlowName] NVARCHAR(255) NOT NULL,
		  [OrderFlowDescription] NVARCHAR(MAX)
		  )
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomOrderStates] ADD [OrderFlowID] INT NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomOrderStates] ADD [OrderStateMailSender] NVARCHAR(255) NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomOrderStates] ADD [OrderStateMailSenderName] NVARCHAR(255) NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomOrderStates] ADD [OrderStateMailSubject] NVARCHAR(255) NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomShops] ADD [ShopOrderFlowID] INT NULL
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomShops] ADD CONSTRAINT [EcomShops_OrderFlowID] FOREIGN KEY ([ShopOrderFlowID]) REFERENCES [EcomOrderFlow]([OrderFlowID])
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomOrderStates] ADD CONSTRAINT [EcomOrderStates_OrderFlowID] FOREIGN KEY ([OrderFlowID]) REFERENCES [EcomOrderFlow]([OrderFlowID])
		</sql>
	  </OrderFlows>
	</database>
  </package>

  <package version="132" date="06-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <EcomFilterDefinitionGroup>
		<sql conditional="">
		  CREATE TABLE [EcomFilterDefinitionGroup]
		  (
		  [EcomFilterDefinitionGroupID] IDENTITY PRIMARY KEY NOT NULL,
		  [EcomFilterDefinitionGroupName] NVARCHAR(255) NOT NULL
		  )
		</sql>
	  </EcomFilterDefinitionGroup>
	  <EcomFilterDefinition>
		<sql conditional="">
		  CREATE TABLE [EcomFilterDefinition]
		  (
		  [EcomFilterDefinitionID] IDENTITY PRIMARY KEY NOT NULL,
		  [EcomFilterDefinitionGroupID] INT NOT NULL,
		  [EcomFilterDefinitionName] NVARCHAR(255) NOT NULL,
		  [EcomFilterDefinitionAddInName] NVARCHAR(255) NOT NULL,
		  [EcomFilterDefinitionTemplate] NVARCHAR(255) NULL,
		  [EcomFilterDefinitionIsActive] BIT NULL DEFAULT(1)
		  )
		</sql>
	  </EcomFilterDefinition>
	  <EcomFilterSetting>
		<sql conditional="">
		  CREATE TABLE [EcomFilterSetting]
		  (
		  [EcomFilterSettingID] IDENTITY PRIMARY KEY NOT NULL,
		  [EcomFilterSettingDefinitionID] INT NOT NULL,
		  [EcomFilterSettingName] NVARCHAR(255) NOT NULL,
		  [EcomFilterSettingValue] NVARCHAR(MAX) NULL
		  )
		</sql>
	  </EcomFilterSetting>
	  <Constraints>
		<sql conditional="">
		  ALTER TABLE [EcomFilterSetting] ADD CONSTRAINT [EcomFilterSetting$DefinitionID] FOREIGN KEY ([EcomFilterSettingDefinitionID]) REFERENCES [EcomFilterDefinition]([EcomFilterDefinitionID])
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomFilterDefinition] ADD CONSTRAINT [EcomFilterDefinition$GroupIDID] FOREIGN KEY ([EcomFilterDefinitionGroupID]) REFERENCES [EcomFilterDefinitionGroup]([EcomFilterDefinitionGroupID])
		</sql>
	  </Constraints>
	  <ManagementCenterNodes>
		<sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'SEARCHFILTERS'">
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
		  'Search filters',
		  7,
		  '/Admin/Images/Ribbon/Icons/Small/funnel.png',
		  '/Admin/Content/Management/eComFilters/GroupList.aspx',
		  'SEARCHFILTERS',
		  121,
		  'eCom_Catalog'
		  )
		</sql>
	  </ManagementCenterNodes>
	</database>
  </package>

  <package version="131" date="05-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <SearchEngine>
		<sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [parentId] = 94 AND [Text] = 'Metadata'">
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
		  94,
		  'Metadata',
		  NULL,
		  '/Admin/Images/Ribbon/Icons/Small/TextCode.png',
		  '/Admin/Module/Ecom_cpl.aspx?cmd=8',
		  NULL,
		  100,
		  'eCom_Cart, eCom_CartV2'
		  )
		</sql>
	  </SearchEngine>
	</database>
  </package>

  <package version="130" date="01-10-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <EcomGroups>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaTitle] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaKeywords] NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaDescription] NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupMetaUrl] NVARCHAR(MAX) NULL</sql>
	  </EcomGroups>
	</database>
  </package>

  <package version="129" date="30-09-2010" internalversion="19.2.0.0">
	<file name="InfoDirekt.js" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
  </package>

  <package version="128" date="16-09-2010" internalversion="19.2.0.0">
	<file name="InformationInfoDirekt.html" source="/Files/Templates/eCom7/CartV2/Step" target="/Files/Templates/eCom7/CartV2/Step" overwrite="false" />
  </package>

  <package version="127" date="16-09-2010" internalversion="19.2.0.0">
	<file name="checkouthandler_cancel.html" source="/Files/Templates/eCom7/CheckoutHandler/Docdata/Cancel" target="/Files/Templates/eCom7/CheckoutHandler/Docdata/Cancel" overwrite="false" />
	<file name="checkouthandler_error.html" source="/Files/Templates/eCom7/CheckoutHandler/Docdata/Error" target="/Files/Templates/eCom7/CheckoutHandler/Docdata/Error" overwrite="false" />
  </package>

  <package version="126" date="15-09-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <SearchEngine>
		<sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'SEARCHING'">
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
		  94,
		  'Searching',
		  7,
		  '/Admin/Images/Ribbon/Icons/Small/data_find.png',
		  '/Admin/Content/Management/SearchEngine/List.aspx?Path=Products',
		  'SEARCHING',
		  120,
		  'eCom_Catalog'
		  )
		</sql>
	  </SearchEngine>
	</database>
  </package>

  <package version="125" date="10-09-2010" internalversion="19.2.0.0">
	<file name="checkouthandler_cancel.html" source="/Files/Templates/eCom7/CheckoutHandler/Ogone/Cancel" target="/Files/Templates/eCom7/CheckoutHandler/Ogone/Cancel" overwrite="false" />
	<file name="checkouthandler_error.html" source="/Files/Templates/eCom7/CheckoutHandler/Ogone/Error" target="/Files/Templates/eCom7/CheckoutHandler/Ogone/Error" overwrite="false" />
	<file name="Post.html" source="/Files/Templates/eCom7/CheckoutHandler/Ogone/Post" target="/Files/Templates/eCom7/CheckoutHandler/Ogone/Post" overwrite="false" />
  </package>


  <package version="124" date="10-09-2010" internalversion="19.2.0.0">
	<file name="infoDirekt.gif" source="/Files/Images/Ecom/Grafik" target="/Files/Images/Ecom/Grafik" overwrite="false" />
  </package>

  <package version="123" date="02-09-2010" internalversion="19.2.0.0">
    <!--
	<database file="Dynamic.mdb">
	  <ProductFilteredCatalog>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_CatalogFiltered'">
		  INSERT INTO [Module]
		  (
		  [ModuleSystemName],
		  [ModuleName],
		  [ModuleControlPanel],
		  [ModuleDescription],
		  [ModuleHiddenMode],
		  [ModuleParagraph],
		  [ModuleIsBeta],
		  [ModuleEcomNotInstalledAccess],
		  [ModuleEcomStandardAccess],
		  [ModuleEcomExtendedAccess],
		  [ModuleEcomLightAccess]
		  )
		  VALUES
		  (
		  'eCom_CatalogFiltered',
		  'Product catalog filtered',
		  'eCom_CatalogFiltered_cpl.aspx',
		  'Product catalog filtered',
		  0,
		  1,
		  1,
		  0,
		  1,
		  1,
		  0
		  )
		</sql>
	  </ProductFilteredCatalog>
	</database>
    -->
  </package>

  <package version="122" date="02-09-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductCategories>
		<sql conditional="SELECT [parentId] FROM [Ecom7Tree] WHERE [TreeUrl] IN ('Lists/EcomList.aspx?type=CATEGORIES', 'Lists/EcomProductCategory_List.aspx')">
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
		  'Product categories',
		  7,
		  'tree/btn_properties.png',
		  'Lists/EcomList.aspx?type=CATEGORIES',
		  'CATEGORIES',
		  120,
		  'eCom_Catalog'
		  )
		</sql>
	  </ProductCategories>
	</database>
  </package>

  <package version="121" date="24-08-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <EcomProductField>
		<sql conditional="">
		  ALTER TABLE [EcomProductField] ADD [ProductFieldListPresentationType] INT NULL
		</sql>
	  </EcomProductField>
	  <EcomProductGroupField>
		<sql conditional="">
		  ALTER TABLE [EcomProductGroupField] ADD [ProductGroupFieldListPresentationType] INT NULL
		</sql>
	  </EcomProductGroupField>
	  <EcomFieldType>
		<sql conditional="SELECT TOP 1 [FieldTypeID] FROM [EcomFieldType] WHERE [FieldTypeDW] = 'List'">
		  INSERT INTO [EcomFieldType] ([FieldTypeName], [FieldTypeDW], [FieldTypeSort], [FieldTypeDB], [FieldTypeDBSQL]) VALUES ('List box', 'List', 15, 'NVARCHAR(512) NULL', 'NVARCHAR(512) NULL')
		</sql>
	  </EcomFieldType>
	  <EcomNumbers>
		<sql conditional="SELECT TOP 1 [NumberID] FROM [EcomNumbers] WHERE [NumberID] = '43'">
		  INSERT INTO [EcomNumbers] ([NumberID], [NumberType], [NumberDescription], [NumberCounter], [NumberPrefix], [NumberPostFix], [NumberAdd], [NumberEditable]) VALUES ('43', 'FIELDOPT', 'Field option', 0, 'FIELDOPT', '', 1, blnFalse)
		</sql>
	  </EcomNumbers>
	  <EcomFieldOption>
		<sql conditional="">
		  CREATE TABLE [EcomFieldOption]
		  (
		  [FieldOptionID] NVARCHAR(255) NOT NULL,
		  [FieldOptionFieldID] NVARCHAR(255) NOT NULL,
		  [FieldOptionName] NVARCHAR (255) NULL,
		  [FieldOptionValue] NVARCHAR(255) NULL,
		  [FieldOptionIsDefault] BIT NULL DEFAULT (0),
		  [FieldOptionSort] INT NULL,
		  PRIMARY KEY ([FieldOptionID])
		  )
		</sql>
	  </EcomFieldOption>
	</database>
  </package>

  <package version="120" date="18-08-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductOptimizedFor>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupManufacturerID] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupVatGroupID] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupProductType] INT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupStockGroupID] NVARCHAR(50) NULL</sql>
	  </ProductOptimizedFor>
	</database>
  </package>

  <package version="119" date="18-08-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductOptimizedFor>
		<sql conditional="">
		  ALTER TABLE [EcomGroups] ADD [GroupRelatedProducts] NVARCHAR(MAX) NULL
		</sql>
	  </ProductOptimizedFor>
	</database>
  </package>

  <package version="118" date="18-08-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductOptimizedFor>
		<sql conditional="">
		  ALTER TABLE [EcomGroups] ADD [GroupRelatedGroups] NVARCHAR(MAX) NULL
		</sql>
	  </ProductOptimizedFor>
	</database>
  </package>

  <package version="117" date="12-08-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <Ecom7Tree>
		<sql conditional="">
		  UPDATE [Ecom7Tree] SET [TreeHasAccessModuleSystemName] = 'eCom_Cart, eCom_CartV2' WHERE [TreeHasAccessModuleSystemName] = 'eCom_Cart';
		</sql>
	  </Ecom7Tree>
	</database>
  </package>

  <package version="116" date="27-07-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductOptimizedFor>
		<sql conditional="">
		  ALTER TABLE [EcomProducts] ADD [ProductOptimizedFor] NVARCHAR(255) NULL
		</sql>
	  </ProductOptimizedFor>
	</database>
  </package>

  <package version="115" date="18-06-2010" internalversion="19.2.0.0">
	<database file="Ecom.mdb">
	  <ProductType>
		<sql conditional="">DELETE FROM EcomNumbers WHERE NumberID = 41 AND NumberType = 'PRODCAT'</sql>
		<sql conditional="">DELETE FROM EcomNumbers WHERE NumberID = 42 AND NumberType = 'PRODCATFIELD'</sql>
		<!--
		<sql conditional="">DROP TABLE EcomProductCategoryFields</sql>
		<sql conditional="SELECT COUNT(CategoryID) FROM EcomProductCategories">DROP TABLE EcomProductCategories</sql>
		<sql conditional="">
		  CREATE TABLE [EcomProductCategories]
		  (
		  [CategoryID] NVARCHAR(50) NOT NULL,
		  [CategoryLanguageID] NVARCHAR(50),
		  [CategoryName] NVARCHAR(255),
		  [CategoryFields] NVARCHAR(MAX),
		  PRIMARY KEY ([CategoryID])
		  )
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomProducts] ADD [ProductCategoryFieldValues] NVARCHAR(MAX)
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomGroups] ADD [ProductCategoryID] NVARCHAR(50)
		</sql>
		<sql conditional="">
		  ALTER TABLE [EcomGroups] ADD CONSTRAINT [EcomGroups$CategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [EcomProductCategories]([CategoryID])
		</sql>
		-->
	  </ProductType>
	</database>
  </package>

  <package version="114" date="16-06-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrderStates] ADD [OrderStateNextState] NVARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrderStates] ADD [OrderStateNextStateDays] INT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrderStates] ADD [OrderStateMailTemplate] NVARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="113" date="26-04-2010" internalversion="19.1.0.0">
	<folder source="Files/Templates/eCom7/CartV2/Step" target="Files/Templates/eCom7/CartV2/" />
  </package>

  <package version="112" date="14-04-2010" internalversion="19.1.0.0">
	<folder source="Files/Templates/eCom7/CartV2/Mail" target="Files/Templates/eCom7/CartV2/" />
  </package>

  <package version="111" date="15-04-2009" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <Ecom7Tree>
		<sql conditional="">
		  UPDATE [Ecom7Tree] SET [TreeHasAccessModuleSystemName] = '' WHERE [TreeChildPopulate] IN ('CURRENCIES', 'LANGUAGES', 'COUNTRIES');
		</sql>
	  </Ecom7Tree>
	</database>
  </package>

  <package version="110" date="14-04-2010" internalversion="19.1.0.0">
	<folder source="Files/Templates/eCom7/CheckoutHandler" target="Files/Templates/eCom7/" />
  </package>

  <package version="109" date="13-04-2010" internalversion="19.1.0.0">
	<folder source="Files/Templates/eCom7/CartV2" target="Files/Templates/eCom7/" />
  </package>

  <package version="108" date="13-04-2010" internalversion="19.1.0.0">
	<!--<file name="BBSPayment.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />-->
  </package>

  <package version="106" date="06-04-2009" internalversion="19.0.1.3">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">
		  UPDATE [EcomNumbers] SET [NumberEditable] = blnTrue WHERE NumberType = 'ORDERGATEWAYUNIQUEID'
		</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderGatewayUniqueID] NVARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>


  <package version="105" date="06-04-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <Module>
		<sql conditional="">
		  UPDATE [Module] SET
		  ModuleEcomLightAccess = (CASE WHEN ModuleSystemName IN ('ecom_Pricing', 'ecom_Search', 'ecom_Units', 'ecom_Catalog') THEN 1 ELSE 0 END),
		  ModuleEcomStandardAccess = (CASE WHEN ModuleSystemName IN ('ecom_Pricing', 'ecom_Search', 'ecom_Units', 'ecom_Catalog') THEN 1 ELSE 0 END),
		  ModuleEcomExtendedAccess = (CASE WHEN ModuleSystemName IN ('ecom_Pricing', 'ecom_Search', 'ecom_Units', 'ecom_Catalog', 'eCom_Related', 'eCom_Assortments', 'eCom_Statistics', 'eCom_Variants') THEN 1 ELSE 0 END)
		</sql>
	  </Module>
	</database>
  </package>

  <package version="104" date="29-03-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderHasSetUserDetails] BIT</sql>
	  </EcomPayments>
	</database>
  </package>


  <package version="103" date="22-03-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerAccepted] BIT</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderDebuggingInfo] NVARCHAR(MAX) NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="102" date="15-03-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderSecret] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderShippingCountrySelection] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderPaymentCountrySelection] NVARCHAR(255) NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="101" date="05-03-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentAddInType] NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentCheckoutSystemName] NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentCheckoutParameters] NVARCHAR(MAX) NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="100" date="02-03-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCartV2StepIndex] INT NULL</sql>
	  </EcomOrders>
	</database>
  </package>


  <package version="99" date="24-02-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProducts>
		<sql conditional="">ALTER TABLE [EcomProducts] ADD [ProductMetaUrl] NVARCHAR(MAX) NULL</sql>
	  </EcomProducts>
	</database>
  </package>

  <package version="98" date="15-02-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <Internationalization>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 10, parentId = 91 WHERE [TreeChildPopulate] = 'COUNTRIES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 20, parentId = 91 WHERE [TreeChildPopulate] = 'LANGUAGES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 30, parentId = 91 WHERE [TreeChildPopulate] = 'CURRENCIES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 40, parentId = 91 WHERE [TreeChildPopulate] = 'VATGRP'</sql>
	  </Internationalization>
	  <Orders>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 10, parentId = 92 WHERE [TreeChildPopulate] = 'PAYMENT'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 20, parentId = 92 WHERE [TreeChildPopulate] = 'SHIPPING'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 30, parentId = 92 WHERE [TreeChildPopulate] = 'STOCKGRP'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 40, parentId = 92 WHERE [TreeChildPopulate] = 'ORDERSTATES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 50, parentId = 92 WHERE [TreeChildPopulate] = 'ORDERFIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 60, parentId = 92 WHERE [TreeChildPopulate] = 'ORDERLINEFIELDS'</sql>
	  </Orders>
	  <ProductCatalogue>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 10, parentId = 93 WHERE [TreeChildPopulate] = 'SHOPS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 20, parentId = 93 WHERE [TreeChildPopulate] = 'MANUFACTORS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 30, parentId = 93 WHERE [TreeChildPopulate] = 'PERIODS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 40, parentId = 93 WHERE [TreeChildPopulate] = 'SALESDISCNT'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 50, parentId = 93 WHERE [TreeChildPopulate] = 'VARIANTGROUPS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 60, parentId = 93 WHERE [TreeChildPopulate] = 'RELGRP'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 70, parentId = 93 WHERE [TreeChildPopulate] = 'UNITS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 80, parentId = 93 WHERE [TreeChildPopulate] = 'FIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 90, parentId = 93 WHERE [TreeChildPopulate] = 'GROUPFIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 100, parentId = 93 WHERE [TreeChildPopulate] = 'PROPTYPE'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 110, parentId = 93 WHERE [TreeChildPopulate] = 'VALIDATIONGROUPS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 120, parentId = 93 WHERE [Text] = 'Productsheet templates'</sql>
	  </ProductCatalogue>

	  <Advanced>
		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7General'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Generelt', NULL, '/Admin/Module/eCom_Catalog/images/buttons/btn_general.png', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=1', 'Ecom7General', 10, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Language'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Produkt sprogstyring', NULL, '/Admin/Images/Ribbon/Icons/Small/Font.png', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=2', 'Ecom7Language', 20, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Priser'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Priser', NULL, '/Admin/Module/eCom_Catalog/images/buttons/btn_money.gif', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=3', 'Ecom7Priser', 30, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Lager'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Lager', NULL, '/Admin/Images/Ribbon/Icons/Small/index.png', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=4', 'Ecom7Lager', 40, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Images'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Images', NULL, '/Admin/Images/eCom/eCom_Media_small.gif', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=6', 'Ecom7Images', 50, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Cart'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Cart', NULL, '/Admin/Module/eCom_Catalog/images/buttons/shoppingcart.png', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=7', 'Ecom7Cart', 60, 'eCom_Cart', NULL)
		</sql>

		<sql conditional="SELECT * FROM [Ecom7Tree] WHERE [TreeChildPopulate] = 'Ecom7Rabat'">
		  INSERT INTO [Ecom7Tree]
		  ([parentId],[Text],[Alt],[TreeIcon],[TreeIconOpen],[TreeUrl],[TreeChildPopulate],[TreeSort],
		  [TreeHasAccessModuleSystemName],[ContextMenuName])
		  VALUES
		  (94, 'Rabat', NULL, '/Admin/Module/eCom_Catalog/images/buttons/btn_discount.gif', NULL, '/Admin/Module/Ecom_cpl.aspx?cmd=5', 'Ecom7Rabat', 70, 'eCom_SalesDiscountExtended', NULL)
		</sql>

		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 80, parentId = 94 WHERE [TreeChildPopulate] = 'ROUNDING'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 90, parentId = 94 WHERE [TreeChildPopulate] = 'NUMBERS'</sql>

	  </Advanced>
	</database>
  </package>

  <package version="97" date="15-02-2010" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomProducts>
		<sql conditional="">ALTER TABLE [EcomProducts] ADD [ProductMetaTitle] NVARCHAR(255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomProducts] ADD [ProductMetaKeywords] NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomProducts] ADD [ProductMetaDescription] NVARCHAR(MAX) NULL</sql>
	  </EcomProducts>
	</database>
  </package>

  <package version="96" date="18-12-2009" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <Ecom7Tree>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 31 WHERE [TreeChildPopulate] = 'SALESDISCNT'</sql>
	  </Ecom7Tree>
	</database>
  </package>

  <package version="95" date="16-12-2009" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <Ecom7Tree>
		<sql conditional="">SELECT * INTO Ecom7Tree FROM EcomTree</sql>

		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 10 WHERE [TreeChildPopulate] = 'SHOPS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 20 WHERE [TreeChildPopulate] = 'MANUFACTORS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 30 WHERE [TreeChildPopulate] = 'PERIODS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 40 WHERE [TreeChildPopulate] = 'VARIANTGROUPS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 50 WHERE [TreeChildPopulate] = 'RELGRP'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 60 WHERE [TreeChildPopulate] = 'UNITS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 70 WHERE [TreeChildPopulate] = 'FIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 80 WHERE [TreeChildPopulate] = 'GROUPFIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 90 WHERE [TreeChildPopulate] = 'PROPTYPE'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 100 WHERE [TreeChildPopulate] = 'ORDERFIELD'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 110 WHERE [TreeChildPopulate] = 'SALESDISCNT'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 120 WHERE [TreeChildPopulate] = 'ORDERLINEFIELDS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 130 WHERE [Text] = 'Productsheet templates'</sql>

		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 10 WHERE [TreeChildPopulate] = 'COUNTRIES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 20 WHERE [TreeChildPopulate] = 'LANGUAGES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 30 WHERE [TreeChildPopulate] = 'CURRENCIES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 40 WHERE [TreeChildPopulate] = 'VATGRP'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 50 WHERE [TreeChildPopulate] = 'PAYMENT'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 60 WHERE [TreeChildPopulate] = 'SHIPPING'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 70 WHERE [TreeChildPopulate] = 'STOCKGRP'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 80 WHERE [TreeChildPopulate] = 'ORDERSTATES'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 90 WHERE [TreeChildPopulate] = 'ROUNDING'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 100 WHERE [TreeChildPopulate] = 'NUMBERS'</sql>
		<sql conditional="">UPDATE Ecom7Tree SET TreeSort = 110 WHERE [TreeChildPopulate] = 'VALIDATIONGROUPS'</sql>

		<!--<sql conditional="">UPDATE Ecom7Tree SET TreeUrl = '../../MwProductSheet/MwProductSheet_TemplateList.aspx' WHERE [Text] = 'Productsheet templates'</sql>-->

	  </Ecom7Tree>
	</database>
  </package>

  <package version="94" date="04-12-2009" internalversion="19.1.0.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCaptureInfo] NVARCHAR(MAX) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="93" date="30-11-2009" internalversion="19.0.1.4">
	<database file="Ecom.mdb">
	  <NAVIntegration>
		<sql conditional="">UPDATE [Module] SET ModuleScript='eCom_NAVIntegration/eCom_NAVIntegration_edit.aspx' WHERE ModuleSystemName='ecom_NAVIntegration'</sql>
	  </NAVIntegration>
	</database>
  </package>

  <package version="92" date="30-11-2009" internalversion="19.0.1.4">
	<!--<folder source="Files/Templates/eCom/Gateway/QuickPay 3" target="Files/Templates/eCom/Gateway" />-->
  </package>

  <package version="91" date="18-11-2009" internalversion="19.0.1.3">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="SELECT [NumberID] FROM [EcomNumbers] WHERE [NumberID] = '40'">
		  INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES ('40', 'ORDERGATEWAYUNIQUEID', 'Unique ID for orders used by payment gateways', 1000, '', '', 1, blnFalse)
		</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderGatewayUniqueID] NVARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="90" date="17-11-2009" internalversion="19.0.1.3">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderGatewayTransactionProblems] NVARCHAR(MAX) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="89" date="11-11-2009" internalversion="19.0.1.1">
	<folder source="Files/Templates/eCom7/Order" target="Files/Templates/eCom7" />
  </package>

  <package version="88" date="30-10-2009" internalversion="19.0.1.0">
	<database file="Ecom.mdb">
	  <NAVIntegration>
		<sql conditional="SELECT ModuleID FROM [Module] WHERE ModuleSystemName = 'ecom_NAVIntegration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('ecom_NAVIntegration', 'NAV Integration', 0, 0, 'NAVIntegration/eCom_NAVIntegration_edit.aspx', 0, 0)</sql>
	  </NAVIntegration>
	</database>
  </package>

  <package version="87" date="16-06-2009" internalversion="19.0.0.1">
	<database file="Ecom.mdb">
	  <EcomProductsRelated>
		<sql conditional="">ALTER TABLE [EcomProductsRelated] DROP CONSTRAINT [EcomProductsRelated$PrimaryKey]</sql>

		<sql conditional="">DROP INDEX [EcomProductsRelated$ProductID] ON [EcomProductsRelated] WITH ( ONLINE = OFF )</sql>
		<sql conditional="">DROP INDEX [EcomProductsRelated$ProductRelatedGroupID] ON [EcomProductsRelated] WITH ( ONLINE = OFF )</sql>
		<sql conditional="">DROP INDEX [EcomProductsRelated$RelatedProductID] ON [EcomProductsRelated] WITH ( ONLINE = OFF )</sql>

		<sql conditional="">ALTER TABLE [EcomProductsRelated] ALTER COLUMN [ProductRelatedProductID] NVARCHAR(50) NOT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomProductsRelated] ALTER COLUMN [ProductRelatedProductRelID] NVARCHAR(50) NOT NULL</sql>
		<sql conditional="">UPDATE [EcomProductsRelated] SET [ProductRelatedGroupID] = '' WHERE [ProductRelatedGroupID] IS NULL</sql>
		<sql conditional="">ALTER TABLE [EcomProductsRelated] ALTER COLUMN [ProductRelatedGroupID] NVARCHAR(255) NOT NULL</sql>

		<sql conditional="">CREATE NONCLUSTERED INDEX [EcomProductsRelated$ProductID] ON [EcomProductsRelated] ([ProductRelatedProductID] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]</sql>
		<sql conditional="">CREATE NONCLUSTERED INDEX [EcomProductsRelated$ProductRelatedGroupID] ON [EcomProductsRelated] ([ProductRelatedGroupID] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]</sql>
		<sql conditional="">CREATE NONCLUSTERED INDEX [EcomProductsRelated$RelatedProductID] ON [EcomProductsRelated] ([ProductRelatedProductRelID] ASC) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]</sql>

		<sql conditional="">ALTER TABLE [EcomProductsRelated] ADD CONSTRAINT [EcomProductsRelated$PrimaryKey] PRIMARY KEY NONCLUSTERED ([ProductRelatedProductID], [ProductRelatedProductRelID], [ProductRelatedGroupID])</sql>
	  </EcomProductsRelated>
	</database>
  </package>


  <package version="86" date="28-04-2009" internalversion="18.17.1.1">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomPropertyValue] ALTER COLUMN [PropValue] NVARCHAR(MAX)</sql>
		<sql conditional="">UPDATE [EcomPropertyValue] SET PropValue = PropValueMemo WHERE PropValue IS NULL</sql>
		<sql conditional="">ALTER TABLE [EcomPropertyValue] DROP [PropValueMemo]</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="85" date="06-04-2009" internalversion="18.17.1.1">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">
		  CREATE TABLE [EcomSalesDiscountLanguages] (
		  [SalesDiscountLanguagesDiscountID] NVARCHAR(50) NOT NULL,
		  [SalesDiscountLanguagesLanguageID] NVARCHAR(50) NOT NULL,
		  [SalesDiscountLanguagesName] NVARCHAR(255) NULL,
		  [SalesDiscountLanguagesDescription] NVARCHAR(MAX) NULL,
		  PRIMARY KEY (SalesDiscountLanguagesDiscountID, SalesDiscountLanguagesLanguageID)
		  )
		</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="84" date="21-11-2008" internalversion="18.16.1.2">
    <!--
	<file name="DIBS_FlexWin_Popup.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="DIBS_FlexWin_Inline.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
    -->
  </package>

  <package version="83" date="12-03-2009" internalversion="18.16.1.2">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderGatewayPaymentStatus] NVARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="82" date="19-09-2008" internalversion="18.16.0.0">
	<database file="Ecom.mdb">
	  <Group>
		<sql conditional="">ALTER TABLE [EcomValidations] ADD [ValidationFieldType] NVARCHAR(255) NULL</sql>
	  </Group>
	</database>
  </package>

  <package version="81" date="25-09-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <ShopOrderNotificationRelation>
		<sql conditional="">CREATE TABLE EcomShopOrderNotificationRelation (ShopOrderNotificationShopID NVARCHAR(255), ShopOrderNotificationAccessUserID INT, PRIMARY KEY(ShopOrderNotificationShopID, ShopOrderNotificationAccessUserID))</sql>
	  </ShopOrderNotificationRelation>
	</database>
  </package>

  <package version="80" date="19-09-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <Group>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupInheritOrderLineFields] BIT</sql>
	  </Group>
	</database>
  </package>

  <package version="79" date="15-09-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <Navigation>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupNavigationShowInMenu] BIT</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupNavigationShowInSiteMap] BIT</sql>
		<sql conditional="">ALTER TABLE [EcomGroups] ADD [GroupNavigationClickable] BIT</sql>
	  </Navigation>
	</database>
  </package>

  <package version="78" date="02-09-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <EcomValidation>
		<sql conditional="">CREATE TABLE EcomOrderLineFieldGroupRelation (OrderLineFieldGroupRelationSystemName NVARCHAR(255), OrderLineFieldGroupRelationGroupID NVARCHAR(255), PRIMARY KEY(OrderLineFieldGroupRelationSystemName, OrderLineFieldGroupRelationGroupID))</sql>
		<sql conditional="">ALTER TABLE [EcomOrderLines] ADD [OrderLineFieldValues] NVARCHAR(MAX)</sql>
		<sql conditional="">ALTER TABLE [EcomOrderLineFields] ADD [OrderLineFieldLength] INT</sql>
	  </EcomValidation>
	</database>
  </package>

  <package version="77" date="29-08-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <EcomValidation>
		<sql conditional="SELECT id FROM EcomTree WHERE ContextMenuName = 'ORDERLINEFIELDS'">INSERT INTO EcomTree (parentId, Text, Alt, TreeIcon, TreeIconOpen, TreeUrl, TreeChildPopulate, TreeSort, TreeHasAccessModuleSystemName, ContextMenuName) VALUES (13, 'Ordreliniefelter', 7, 'tree/btn_orderlinefield.png', NULL, 'Lists/EcomList.aspx?type=ORDERLINEFIELDS', 'ORDERLINEFIELDS', 20, 'eCom_Cart', 'ORDERLINEFIELDS')</sql>
		<sql conditional="">CREATE TABLE EcomOrderLineFields (OrderLineFieldSystemName NVARCHAR(255) PRIMARY KEY, OrderLineFieldName NVARCHAR(255))</sql>
	  </EcomValidation>
	</database>
  </package>

  <package version="76" date="04-08-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerNewsletterSubcribe] BIT NOT NULL DEFAULT 0</sql>
	  </EcomOrders>
	</database>
  </package>


  <package version="75" date="22-07-2008" internalversion="18.15.1.1">
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="SELECT * FROM [EcomTree] WHERE [TreeHasAccessModuleSystemName] = 'DW_Integration_ImportExport, DW_Integration_ImportExportExtended'">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = 'DW_Integration_ImportExport, DW_Integration_ImportExportExtended' WHERE TreeHasAccessModuleSystemName ='DW_Integration_ImportExport'</sql>
	  </EcomTree>
	</database>
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DW_Integration_ImportExportExtended'">UPDATE [Module] SET ModuleSystemName = 'DW_Integration_ImportExportExtended', ModuleName = 'Import/eksport udvidet' WHERE ModuleSystemName = 'DW_Integration_ImportExport'</sql>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'DW_Integration_ImportExport'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode) VALUES ('DW_Integration_ImportExport', 'Import/eksport', 0, 0, 'Integration/Frame.aspx', 0, 0)</sql>
	  </Module>
	</database>
  </package>

  <package version="74" date="14-07-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <EcomValidation>
		<sql conditional="">INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES ('37', 'VALIDATIONGROUP', 'Valideringsgruppe', 0, 'VALIDATIONGROUP', '', 1, blnTrue)</sql>
		<sql conditional="">INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES ('38', 'VALIDATION', 'Validering', 0, 'VALIDATION', '', 1, blnTrue)</sql>
		<sql conditional="">INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES ('39', 'VALIDATIONRULE', 'Valideringsregel', 0, 'VALIDATIONRULE', '', 1, blnTrue)</sql>
		<sql conditional="SELECT id FROM EcomTree WHERE ContextMenuName = 'VALIDATIONGROUPS'">INSERT INTO EcomTree (parentId, Text, Alt, TreeIcon, TreeIconOpen, TreeUrl, TreeChildPopulate, TreeSort, TreeHasAccessModuleSystemName, ContextMenuName) VALUES (15, 'Valideringsgrupper', 7, 'tree/btn_validationgroups.png', NULL, 'Lists/EcomList.aspx?type=VALIDATIONGROUPS', 'VALIDATIONGROUPS', 19, 'eCom_Cart', 'VALIDATIONGROUPS')</sql>
	  </EcomValidation>
	</database>
  </package>

  <package version="73" date="04-07-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <EcomValidation>
		<sql conditional="">CREATE TABLE EcomValidationGroups (ValidationGroupID NVARCHAR(50) PRIMARY KEY, ValidationGroupName NVARCHAR(255))</sql>
		<sql conditional="">CREATE TABLE EcomValidations (ValidationID NVARCHAR(50) PRIMARY KEY, ValidationGroupID NVARCHAR(50), ValidationFieldName NVARCHAR(255), ValidationUseAndOperator BIT)</sql>
		<sql conditional="">CREATE TABLE EcomValidationRules (ValidationRuleID NVARCHAR(50) PRIMARY KEY, ValidationRuleValidationID NVARCHAR(50), ValidationRuleType NVARCHAR(255), ValidationRuleParameters NVARCHAR(MAX))</sql>
	  </EcomValidation>
	</database>
  </package>

  <package version="72" date="04-07-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ALTER COLUMN [OrderShippingMethodDescription] NVARCHAR(MAX)</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ALTER COLUMN [OrderPaymentMethodDescription] NVARCHAR(MAX)</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="71" date="02-07-2008" internalversion="18.15.0.0">
	<!--<file name="ServiRed.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />-->
  </package>

  <package version="70" date="30-06-2008" internalversion="18.15.0.0">
	<database file="Access.mdb">
	  <AccessUser>
		<sql conditional="">ALTER TABLE [AccessUser] ADD AccessUserCartID NVARCHAR(50) NULL</sql>
	  </AccessUser>
	</database>
  </package>

  <package version="69" date="30-06-2008" internalversion="18.15.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName = 'eCom_CustomerCenter'</sql>
	  </Module>
	</database>
  </package>


  <package version="68" date="30-06-2008" internalversion="18.15.0.0">
	<file name="ProductAdvanced.html" overwrite="false" target="Files/Templates/eCom/Product" source="Files/Templates/eCom/Product" />
	<!--<file name="OrderShopEmail.html" overwrite="false" target="Files/Templates/eCom/Cart" source="Files/Templates/eCom/Cart" />-->
	<folder source="Files/Templates/eCom/Images" target="Files/Templates/eCom" />
	<folder source="Files/Templates/eCom/CustomerCenter" target="Files/Templates/eCom" />
  </package>


  <package version="67" date="02-06-2008" internalversion="18.15.0.0">
	<database file="Dynamic.mdb">
	  <module>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = 0 WHERE ModuleSystemName='eCom_C5Integration'</sql>
	  </module>
	</database>
  </package>

  <package version="66" date="16-06-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountXMLParamsBackup NVARCHAR(MAX) NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="65" date="13-06-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <Module>
		<sql conditional="">UPDATE eComTree SET TreeChildPopulate = 'FIELD' WHERE [Text] = 'Vare felter'</sql>
		<sql conditional="">UPDATE eComTree SET TreeChildPopulate = 'PROPTYPE' WHERE [Text] = 'Gruppe felter'</sql>
		<sql conditional="">UPDATE eComTree SET TreeChildPopulate = 'ORDERFIELD' WHERE [Text] = 'Ordre felter'</sql>
		<sql conditional="">UPDATE eComTree SET TreeChildPopulate = 'GROUPFIELD' WHERE [Text] = 'Varegruppe felter'</sql>
	  </Module>
	</database>
  </package>

  <package version="64" date="13-06-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <Module>
		<sql conditional="">UPDATE EComTree SET [Text] = 'Opsætning' WHERE [Text] LIKE 'Ops?tning'</sql>
	  </Module>
	</database>
  </package>

  <package version="63" date="13-04-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ROOT' WHERE [Text] LIKE 'Dynamicweb eCommerce'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SHOPS' WHERE [Text] LIKE 'Shops'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SHOPLIST' WHERE [Text] LIKE 'Varekatalog'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERS' WHERE [Text] LIKE 'Ordrer'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SETTINGS' WHERE [Text] LIKE 'Indstillinger'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'LANGUAGES' WHERE [Text] LIKE 'Sprog'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CONFIGURATION' WHERE [Text] LIKE 'Ops?tning'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'REPORTS' WHERE [Text] LIKE 'Rapporter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'STATISTICS' WHERE [Text] LIKE 'Statistik'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CURRENCY' WHERE [Text] LIKE 'Valuta'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'UNITS' WHERE [Text] LIKE 'Vareenheder'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CAMPAIGNS' WHERE [Text] LIKE 'Kampagner'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'AUTONUMBERS' WHERE [Text] LIKE 'Auto-nummerering'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'MANUFACTURERS' WHERE [Text] LIKE 'Producenter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'VARIANTGROUPS' WHERE [Text] LIKE 'Varianter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'COUNTRIES' WHERE [Text] LIKE 'Lande'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PAYMENTS' WHERE [Text] LIKE 'Betaling'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SHIPPING' WHERE [Text] LIKE 'Forsendelse'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'DISCOUNTS' WHERE [Text] LIKE 'Rabatter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'IMPORTEXPORT' WHERE [Text] LIKE 'Import/eksport'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'STOCKSTATUS' WHERE [Text] = 'Lagerstatus'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ROUNDING' WHERE [Text] LIKE 'Afrunding'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'TAXRATES' WHERE [Text] LIKE 'Moms'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'RELATEDITEMS' WHERE [Text] LIKE 'Relaterede varer'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERSTATUS' WHERE [Text] LIKE 'Ordrestatus'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PRODUCTFIELDS' WHERE [Text] LIKE 'Vare felter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'GROUPFIELDS' WHERE [Text] LIKE 'Gruppe felter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERFIELDS' WHERE [Text] LIKE 'Ordre felter'</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PRODUCTGROUPFIELDS' WHERE [Text] LIKE 'Varegruppe felter'</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="62" date="12-06-2008" internalversion="18.15.0.0">
	<database file="Ecom.mdb">
	  <Module>
		<sql conditional="">UPDATE EComTree SET ContextMenuName = 'SHOPLIST' WHERE TreeChildPopulate = 'GROUPS'</sql>
		<sql conditional="">UPDATE EComTree SET TreeUrl = 'Lists/EcomList.aspx?type=SHOP' WHERE TreeChildPopulate = 'GROUPS'</sql>
	  </Module>
	</database>
  </package>

  <package version="61" date="25-02-2008" internalversion="18.15.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_SalesDiscount'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_SalesDiscount', 'eCom salgsrabat', 0, 0, '', 0, 0, 0, 0, 2)</sql>
	  </Module>
	</database>
  </package>

  <package version="60" date="25-02-2008" internalversion="18.15.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_SalesDiscountExtended'">UPDATE [Module] SET ModuleSystemName = 'eCom_SalesDiscountExtended', ModuleName = 'eCom udvidet salgsrabat' WHERE ModuleSystemName = 'eCom_SalesDiscount'</sql>
	  </Module>
	</database>
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="SELECT * FROM [EcomTree] WHERE [TreeHasAccessModuleSystemName] = 'eCom_SalesDiscount, eCom_SalesDiscountExtended'">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = 'eCom_SalesDiscount, eCom_SalesDiscountExtended' WHERE TreeHasAccessModuleSystemName ='eCom_SalesDiscount'</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="59" date="25-05-2008" internalversion="18.15.0.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleEcomNotInstalledAccess = 0 WHERE ModuleSystemName='eCom_CustomerCenter'</sql>
	  </Module>
	</database>
  </package>

  <package version="58" date="26-05-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP CONSTRAINT [DF__EcomSales__Sales__5812160E]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP [SalesDiscountBuyLimit]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP [SalesDiscountProductID]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP [SalesDiscountReleaseCode]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountDescription NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountValueType NVARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountValueFixed FLOAT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountValuePercentage FLOAT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountValueProducts NVARCHAR(MAX) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountDateFrom BIGINT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountDateTo BIGINT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD SalesDiscountConvertedToNewFormat BIT NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="57" date="02-06-2008" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_C5Integration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_C5Integration', 'C5 Integration', 'eCom_C5Integration/eCom_C5Integration_Edit.aspx', 0, 0, 0, 0, NULL, 1)</sql>
	  </module>
	</database>
  </package>

  <package version="56" date="04-06-2008" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">ALTER TABLE [Module] ADD [ModuleEcomLightAccess] INT DEFAULT 0</sql>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_Light'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess, ModuleEcomLightAccess) VALUES ('eCom_Light', 'eCom Light', 0, 1, NULL, 0, 0, NULL, NULL, NULL, NULL)</sql>
		<sql conditional="">UPDATE [Module] SET ModuleEcomLightAccess = 1 WHERE ModuleSystemName ='eCom_Catalog'</sql>
	  </Module>
	</database>
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = 'eCom_Cart' WHERE TreeChildPopulate ='NUMBERS'</sql>
		<sql conditional="SELECT * FROM [Module] WHERE [TreeHasAccessModuleSystemName] LIKE '%, eCom_Light%' WHERE TreeChildPopulate ='CURRENCIES'">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = TreeHasAccessModuleSystemName + ', eCom_Light' WHERE TreeChildPopulate ='CURRENCIES'</sql>
		<sql conditional="SELECT * FROM [Module] WHERE [TreeHasAccessModuleSystemName] LIKE '%, eCom_Light%' WHERE TreeChildPopulate ='LANGUAGES'">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = TreeHasAccessModuleSystemName + ', eCom_Light' WHERE TreeChildPopulate ='LANGUAGES'</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="55" date="03-06-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderShippingMethodDescription] VARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderPaymentMethodDescription] VARCHAR(50) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="54" date="02-06-2008" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <module>
		<sql conditional="">DELETE [Module] WHERE [ModuleSystemName] = 'eCom_CustomerCenter'</sql> <!-- LEFT IN FOR BACKWARDS COMPATIBILITY -->
		<sql conditional="">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleDescription, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_CustomerCenter', 'Customer Center', 'Display order history, favorite products etc.', '', 0, 0, 1, 0, 0, 1)</sql>
	  </module>
	</database>
  </package>

  <package version="53" date="27-05-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomC5Setting>
		<sql conditional="">CREATE TABLE EcomC5Setting (C5SettingID INT IDENTITY(1,1) PRIMARY KEY, C5SettingMailTo NVARCHAR(255), C5SettingMailFrom NVARCHAR(255), C5SettingMailFromName NVARCHAR(255), C5SettingMailSubject NVARCHAR(255))</sql>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_C5Integration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_C5Integration', 'C5 Integration', 'eCom_C5Integration/eCom_C5Integration_Edit.aspx', 0, 0, 0, 0, NULL, 1)</sql>
	  </EcomC5Setting>
	</database>
  </package>

  <package version="52" date="30-04-2008" internalversion="18.15.1.0">
	<file name="Product.html" overwrite="false" target="Files/Templates/eCom/Product" source="Files/Templates/eCom/Product" />
	<file name="Product_Advanced.html" overwrite="false" target="Files/Templates/eCom/Product" source="Files/Templates/eCom/Product" />
	<file name="ProductList.html" overwrite="false" target="Files/Templates/eCom/ProductList" source="Files/Templates/eCom/ProductList" />
	<file name="NoProductFound.html" overwrite="false" target="Files/Templates/eCom/ProductList" source="Files/Templates/eCom/ProductList" />
	<file name="GroupList.html" overwrite="false" target="Files/Templates/eCom/GroupList" source="Files/Templates/eCom/GroupList" />
	<file name="SearchForm.html" overwrite="false" target="Files/Templates/eCom/Search" source="Files/Templates/eCom/Search" />
	<file name="ecom.css" overwrite="false" target="Files/Templates/eCom" source="Files/Templates/eCom" />
	<file name="functions.js" overwrite="false" target="Files/Templates/eCom" source="Files/Templates/eCom" />
  </package>

  <package version="51" date="25-02-2008" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleEcomNotInstalledAccess = NULL WHERE ModuleSystemName='NavIntegration'</sql>
		<sql conditional="">UPDATE [Module] SET ModuleEcomNotInstalledAccess = NULL WHERE ModuleSystemName='UrlPath'</sql>
	  </Module>
	</database>
  </package>


  <package version="50" date="15-04-2008" internalversion="18.14.1.0">
	<database file="Access.mdb">
	  <AccessUser>
		<sql conditional="">ALTER TABLE [AccessUser] ADD AccessUserCartID NVARCHAR(50) NULL</sql>
	  </AccessUser>
	</database>
  </package>


  <package version="49" date="25-02-2008" internalversion="18.14.1.0">
    <!--
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">DELETE FROM [Module] WHERE ModuleSystemName='eCom_CustomerCareCenter'</sql>
	  </Module>
	</database>
    -->
  </package>

  <package version="48" date="11-04-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">ALTER TABLE EcomTree ADD ContextMenuName nvarchar(20) NULL</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ROOT' WHERE id = 1</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SHOPS' WHERE id = 2</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'GROUPS' WHERE id = 3</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERS' WHERE id = 6</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SETTINGS' WHERE id = 13</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'LANGUAGES' WHERE id = 14</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CONFIGURATION' WHERE id = 15</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'REPORTS' WHERE id = 16</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'STATISTICS' WHERE id = 17</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CURRENCY' WHERE id = 19</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'UNITS' WHERE id = 20</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'CAMPAIGNS' WHERE id = 21</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'AUTONUMBERS' WHERE id = 25</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'MANUFACTURERS' WHERE id = 27</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'VARIANTGROUPS' WHERE id = 28</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'COUNTRIES' WHERE id = 29</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PAYMENTS' WHERE id = 30</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'SHIPPING' WHERE id = 31</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'DISCOUNTS' WHERE id = 32</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'IMPORTEXPORT' WHERE id = 33</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'STOCKSTATUS' WHERE id = 35</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ROUNDING' WHERE id = 36</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'TAXRATES' WHERE id = 37</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'RELATEDITEMS' WHERE id = 38</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERSTATUS' WHERE id = 40</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PRODUCTFIELDS' WHERE id = 41</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'GROUPFIELDS' WHERE id = 45</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'ORDERFIELDS' WHERE id = 46</sql>
		<sql conditional="">UPDATE EcomTree SET ContextMenuName = 'PRODUCTGROUPFIELDS' WHERE id = 47</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="47" date="11-04-2008" internalversion="18.14.1.0">
	<file name="Pages_Import_from_XML.pipe" overwrite="false" source="Files/Files/Integration/eCommerce/" target="Files/Files/Integration/eCommerce" />
  </package>

  <package version="46" date="07-04-2008" internalversion="18.14.1.0">
	<file name="PrintOrder.html" overwrite="false" target="files/templates/ecom/order" source="files/templates/ecom/order" />
  </package>

  <package version="45" date="13-03-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomOrderLines>
		<sql conditional="">ALTER TABLE EcomUserPermissionType DROP CONSTRAINT DF_EcomUserPermissionType_UserPermissionTypeGUID</sql>
		<sql conditional="">CREATE TABLE Tmp_EcomUserPermissionType(UserPermissionType nvarchar(50) NOT NULL, UserPermissionTypeID varchar(255) NOT NULL, UserPermissionTypeGUID uniqueidentifier NOT NULL)</sql>
		<sql conditional="">ALTER TABLE Tmp_EcomUserPermissionType ADD CONSTRAINT DF_EcomUserPermissionType_UserPermissionTypeGUID DEFAULT (newid()) FOR UserPermissionTypeGUID</sql>
		<sql conditional="">IF EXISTS(SELECT * FROM EcomUserPermissionType) EXEC('INSERT INTO Tmp_EcomUserPermissionType (UserPermissionType, UserPermissionTypeID, UserPermissionTypeGUID) SELECT CONVERT(nvarchar(50), UserPermissionType), UserPermissionTypeID, UserPermissionTypeGUID FROM EcomUserPermissionType WITH (HOLDLOCK TABLOCKX)')</sql>
		<sql conditional="">DROP TABLE EcomUserPermissionType</sql>
		<sql conditional="">EXECUTE sp_rename N'Tmp_EcomUserPermissionType', N'EcomUserPermissionType', 'OBJECT'</sql>
		<sql conditional="">ALTER TABLE EcomUserPermissionType ADD CONSTRAINT PK_EcomUserPermissionType PRIMARY KEY CLUSTERED (UserPermissionType, UserPermissionTypeID) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)</sql>
	  </EcomOrderLines>
	</database>
  </package>

  <package version="44" date="14-03-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomOrderLines>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD OrderTransactionMailSend BIT NOT NULL DEFAULT 0</sql>
	  </EcomOrderLines>
	</database>
  </package>

  <package version="43" date="13-03-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomUserPermissions>
		<sql conditional="">CREATE TABLE [EcomUserPermission]([UserPermissionTypeGUID] [uniqueidentifier] NOT NULL, [UserPermissionUserId] [int] NOT NULL, [UserPermissionRights] [int] NOT NULL, CONSTRAINT [PK_EcomUserPermission] PRIMARY KEY CLUSTERED ( [UserPermissionTypeGUID] ASC, [UserPermissionUserId] ASC ) )</sql>
		<sql conditional="">CREATE TABLE [EcomUserPermissionType]( [UserPermissionType] [nvarchar](50), [UserPermissionTypeID] [varchar](255), [UserPermissionTypeGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EcomUserPermissionType_UserPermissionTypeGUID]  DEFAULT (newid()), CONSTRAINT [PK_EcomUserPermissionType] PRIMARY KEY CLUSTERED ([UserPermissionType] ASC, [UserPermissionTypeID] ASC ) )</sql>
	  </EcomUserPermissions>
	</database>
  </package>

  <package version="42" date="13-03-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomOrderLines>
		<sql conditional="">ALTER TABLE [EcomOrderLines] ADD OrderLineDiscountID NVARCHAR(255) NULL</sql>
	  </EcomOrderLines>
	</database>
  </package>

  <package version="41" date="25-02-2008" internalversion="18.14.1.0">
    <!--
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = 1 WHERE ModuleSystemName='eCom_CustomerCareCenter'</sql>
	  </Module>
	</database>
    -->
  </package>

  <package version="40" date="11-02-2007" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'NavIntegration'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleScript, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('NavIntegration', 'NAV Integration', '', 0, 0, 0, 0, 0, 1)</sql>
	  </Module>
	</database>
  </package>

  <package version="39" date="08-02-2008" internalversion="18.14.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE EcomSalesDiscount ADD SalesDiscountProductsAndGroups NVARCHAR(MAX) NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="38" date="29-01-2008" internalversion="18.14.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleScript = 'Integration/Frame.aspx', ModuleName = 'Integration', ModuleSystemName = 'Integration', ModuleEcomNotInstalledAccess = NULL, ModuleEcomStandardAccess = NULL, ModuleEcomExtendedAccess = NULL WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
		<sql conditional="">UPDATE [Module] SET ModuleScript = 'Integration/Frame.aspx', ModuleName = 'Import/eksport', ModuleSystemName = 'DW_Integration_ImportExport', ModuleEcomNotInstalledAccess = NULL, ModuleEcomStandardAccess = NULL, ModuleEcomExtendedAccess = NULL WHERE ModuleSystemName = 'Integration'</sql>
	  </Module>
	</database>
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = 'Integration' WHERE TreeHasAccessModuleSystemName = 'eCom_ImportExport' AND TreeChildPopulate = 'IMPEXP'</sql>
		<sql conditional="">UPDATE [EcomTree] SET TreeHasAccessModuleSystemName = 'DW_Integration_ImportExport' WHERE TreeHasAccessModuleSystemName = 'Integration' AND TreeChildPopulate = 'IMPEXP'</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="37" date="24-01-2008" internalversion="18.12.1.0">
    <!--
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_CustomerCareCenter'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleIsBeta) VALUES ('eCom_CustomerCareCenter', 'CustomerCareCenter', 0, 0, 1, 0, 0, 1)</sql>
	  </Module>
	</database>
    -->
	<database file="Ecom.mdb">
	  <CustomerCenterCreate>
		<sql conditional="">CREATE TABLE EcomCustomersSettings (SettingID INT IDENTITY(1,1) PRIMARY KEY, AccessUserID INT NOT NULL, PaymentMethodID VARCHAR (50) NOT NULL, ShippingMethodID VARCHAR(50) NOT NULL, CurrencyCode VARCHAR(10) NOT NULL )</sql>
		<sql conditional="">CREATE TABLE EcomCustomerFavoriteLists (ID INT IDENTITY(1,1) PRIMARY KEY, AccessUserID INT NOT NULL, [Name] VARCHAR(255) NOT NULL )</sql>
		<sql conditional="">CREATE TABLE EcomCustomerFavoriteProducts (FavoriteListID INT NOT NULL, ProductID VARCHAR(30) NOT NULL, ProductLanguageID VARCHAR(50) NOT NULL, ProductVariantID VARCHAR(255) NOT NULL, [Note] MEMO NULL, ProductReferenceUrl MEMO NULL, PRIMARY KEY(FavoriteListID, ProductID, ProductLanguageID, ProductVariantID))</sql>
	  </CustomerCenterCreate>
	  <CustomerCenterAddConstraints>
		<sql conditional="">ALTER TABLE [EcomCustomersSettings] ADD CONSTRAINT EcomCustomersSettings_FK00 FOREIGN KEY (AccessUserID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
		<sql conditional="">ALTER TABLE [EcomCustomerFavoriteProducts] ADD CONSTRAINT FK_EcomCustomerFavoriteProducts_EcomCustomerFavoriteLists FOREIGN KEY (FavoriteListID) REFERENCES EcomCustomerFavoriteLists (ID) ON DELETE CASCADE </sql>
		<sql conditional="">ALTER TABLE [EcomCustomerFavoriteProducts] ADD CONSTRAINT FK_EcomCustomerFavoriteProducts_EcomProducts FOREIGN KEY (ProductID, ProductLanguageID, ProductVariantID) REFERENCES EcomProducts (ProductID, ProductLanguageID, ProductVariantID) ON DELETE CASCADE </sql>
		<sql conditional="">ALTER TABLE [EcomCustomerFavoriteLists] ADD CONSTRAINT FK_EcomCustomerFavoriteLists_AccessUser FOREIGN KEY (AccessUserID) REFERENCES AccessUser (AccessUserID) ON DELETE CASCADE </sql>
	  </CustomerCenterAddConstraints>
	</database>
	<database file="Access.mdb">
	  <AccessUser>
		<sql conditional="">CREATE TABLE EcomAccessUser (EcomAccessUserID INT)</sql>
		<sql conditional="">ALTER TABLE EcomAccessUser ADD FOREIGN KEY (EcomAccessUserID) REFERENCES AccessUser(AccessUserID) ON DELETE CASCADE</sql>
	  </AccessUser>
	</database>
	<folder source="Files/Templates/eCom/CustomerCareCenter" target="Files/Templates/eCom" />
  </package>

  <package version="36" date="05-01-2008" internalversion="18.13.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleDataBase = 'Ecom.mdb', ModuleTable = 'EcomShops', ModuleFieldID = 'ShopID', ModuleFieldName = 'ShopName' WHERE ModuleSystemName = 'eCom_Catalog'</sql>
	  </Module>
	</database>
  </package>

  <package version="35" date="20-12-2007" internalversion="18.13.1.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentIconOrderList] VARCHAR(255) NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="34" date="27-12-2007" internalversion="18.11.1.0">
	<!--<folder source="Files/Filer/CustomerCareCenter/" target="Files/Filer/" />-->
  </package>

  <package version="33" date="30-11-2007" internalversion="18.13.1.0">
	<database file="Ecom.mdb">
	  <EcomProductsRelatedGroups>
		<sql conditional="">ALTER TABLE [EcomProductsRelatedGroups] ADD [RelatedGroupSortOrder] INT DEFAULT 0</sql>
	  </EcomProductsRelatedGroups>
	  <EcomProductsRelated>
		<sql conditional="">ALTER TABLE [EcomProductsRelated] ADD [ProductRelatedSortOrder] INT DEFAULT 0</sql>
	  </EcomProductsRelated>
	</database>
  </package>

  <package version="32" date="11-10-2007" internalversion="18.13.0.0">
	<database file="Ecom.mdb">
	  <EcomVariantsOptions>
		<sql conditional="">ALTER TABLE [EcomVariantsOptions] ADD [VariantOptionSortOrder] INT DEFAULT 0</sql>
		<sql conditional="">UPDATE [EcomVariantsOptions] SET VariantOptionSortOrder = 0 WHERE VariantOptionSortOrder IS NULL</sql>
	  </EcomVariantsOptions>
	</database>
  </package>

  <package version="31" date="04-09-2007" internalversion="18.13.0.0">
	<database file="Ecom.mdb">
	  <EcomNumbers>
		<sql conditional="SELECT * FROM [EcomNumbers] WHERE [NumberID] = 36 AND [NumberType] = 'GROUPFIELD'">INSERT INTO EcomNumbers (NumberID, NumberType, NumberDescription, NumberCounter, NumberPrefix, NumberPostFix, NumberAdd, NumberEditable) VALUES (36, 'GROUPFIELD', 'Varegruppe felter', 0, 'GROUPFIELD', '', 1, blnFalse)</sql>
	  </EcomNumbers>
	</database>
  </package>

  <package version="30" date="04-09-2007" internalversion="18.13.0.0">
	<database file="Ecom.mdb">
	  <EcomShippings>
		<sql conditional="">ALTER TABLE [EcomShippings] ADD [ShippingFreeFeeAmount] DOUBLE</sql>
	  </EcomShippings>
	</database>
  </package>

  <package version="29" date="21-11-2007" internalversion="18.12.1.0">
	<file name="DefaultOrder.html" overwrite="false" target="files/templates/ecom/order" source="files/templates/ecom/order" />
  </package>

  <package version="28" date="13-08-2007" internalversion="18.12.1.0">
	<database file="Ecom.mdb">
	  <EcomProductItems>
		<sql conditional="">ALTER TABLE [EcomProductItems] ADD [ProductItemBomNoProductText] VARCHAR (255) NULL</sql>
	  </EcomProductItems>
	</database>
  </package>

  <package version="27" date="12-08-2007" internalversion="18.12.1.0">
	<database file="Ecom.mdb">
	  <EcomFieldType>
		<sql conditional="">ALTER TABLE [EcomFieldType] ADD [FieldTypeAdvanced] BIT NULL</sql>
		<sql conditional="SELECT * FROM [EcomFieldType] WHERE [FieldTypeName] = 'Editor'">INSERT INTO [EcomFieldType] (FieldTypeName, FieldTypeDW, FieldTypeOption, FieldTypeSort, FieldTypeDB, FieldTypeDBSQL, FieldTypeAdvanced) VALUES ('Editor', 'EditorText', '', 14, 'MEMO NULL', 'NVARCHAR(MAX) NULL', blnTrue)</sql>
	  </EcomFieldType>
	</database>
  </package>

  <package version="26" date="03-07-2007" internalversion="18.12.1.0">
	<database file="Ecom.mdb">
	  <EcomFieldType>
		<sql conditional="">UPDATE EcomFieldType SET FieldTypeDBSQL = 'NVARCHAR(MAX) NULL' WHERE FieldTypeID = 2</sql>
	  </EcomFieldType>
	</database>
  </package>

  <package version="25" date="01-06-2007" internalversion="18.12.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnFalse WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
	  </Module>
	</database>
  </package>

  <package version="24" date="22-05-2007" internalversion="18.12.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleHiddenMode = blnTrue, ModuleAccess = blnFalse WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
	  </Module>
	</database>
  </package>

  <package version="23" date="15-05-2007" internalversion="18.12.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderLanguageID] VARCHAR (25) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="22" date="15-05-2007" internalversion="18.12.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnTrue WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnTrue WHERE ModuleSystemName = 'eCom_Statistics'</sql>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnTrue, ModuleHiddenMode = blnTrue WHERE ModuleSystemName = 'eCom_CustomerArea'</sql>
		<sql conditional="">UPDATE [Module] SET ModuleIsBeta = blnTrue, ModuleHiddenMode = blnTrue WHERE ModuleSystemName = 'eCom_Reports'</sql>
	  </Module>
	</database>
  </package>

  <package version="21" date="27-04-2007" internalversion="18.11.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<sql conditional="SELECT * FROM [Module] WHERE [ModuleSystemName] = 'eCom_SalesDiscount'">INSERT INTO [Module] (ModuleSystemName, ModuleName, ModuleAccess, ModuleStandard, ModuleScript, ModuleParagraph, ModuleHiddenMode, ModuleEcomNotInstalledAccess, ModuleEcomStandardAccess, ModuleEcomExtendedAccess) VALUES ('eCom_SalesDiscount', 'eCom salgsrabat', 0, 0, '', 0, 0, 0, 0, 2)</sql>
	  </Module>
	</database>
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE [EcomTree] SET [TreeHasAccessModuleSystemName] = 'eCom_SalesDiscount' WHERE [Text] = 'Rabatter' AND TreeChildPopulate = 'SALESDISCNT'</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="20" date="27-04-2007" internalversion="18.11.1.0">
	<database file="Dynamic.mdb">
	  <Module>
		<!--<sql conditional="">UPDATE [Module] SET ModuleScript = '' WHERE ModuleSystemName = 'eCom_Cart'</sql>-->
		<sql conditional="">UPDATE [Module] SET ModuleScript = '' WHERE ModuleSystemName = 'eCom_ImportExport'</sql>
	  </Module>
	</database>
  </package>

  <package version="19" date="28-03-2007" internalversion="18.11.1.0">
	<folder source="Files/Files/Integration/" target="Files/Files" />
  </package>

  <package version="18" date="14-03-2007" internalversion="18.11.1.0">
    <!--
	<file name="ePay.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="PBS.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="SecPay.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="Debitech.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="DIBS.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="PayPal.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
	<file name="QuickPay.html" overwrite="false" target="Files/Templates/eCom/Gateway" source="Files/Templates/eCom/Gateway" />
    -->
  </package>

  <package version="17" date="08-03-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderStepHistory] MEMO NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="16" date="26-02-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomFees>
		<sql conditional="">ALTER TABLE EcomFees ADD FeeCountryID VARCHAR (50) NULL</sql>
	  </EcomFees>
	</database>
  </package>

  <package version="15" date="26-02-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomPropertyValue>
		<sql conditional="">ALTER TABLE EcomPropertyValue ADD PropValueMemo MEMO NULL</sql>
	  </EcomPropertyValue>
	</database>
  </package>

  <package version="14" date="23-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE EcomSalesDiscount ALTER COLUMN SalesDiscountDiscountType VARCHAR (255) NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="13" date="23-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD [SalesDiscountActive] BIT NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>


  <package version="12" date="23-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomFieldType>
		<sql conditional="">UPDATE [EcomFieldType] SET FieldTypeDBSQL = 'FLOAT DEFAULT 0.0' WHERE FieldTypeID = 7</sql>
	  </EcomFieldType>
	</database>
  </package>


  <package version="11" date="23-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerCountryCode] VARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderDeliveryCountryCode] VARCHAR(50) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="10" date="23-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderStepNum] INT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderTransactionNumber] VARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>

  <package version="9" date="19-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderShippingMethodID] VARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderPaymentMethodID] VARCHAR(50) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderGatewayResult] MEMO NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderStepNum] INT NULL</sql>
	  </EcomOrders>
	</database>
  </package>


  <package version="8" date="10-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE EcomPayments ALTER COLUMN PaymentGatewayID MEMO NULL</sql>
		<sql conditional="">ALTER TABLE [EcomPayments] ADD [PaymentGatewayParameters] MEMO NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="7" date="04-01-2007" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE [EcomTree] SET [TreeHasAccessModuleSystemName]='' WHERE id=29</sql>
	  </EcomTree>
	</database>
  </package>

  <package version="6" date="15-12-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomOrders>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerAccessUserID] INT NULL</sql>
		<sql conditional="">ALTER TABLE [EcomOrders] ADD [OrderCustomerAccessUserUserName] VARCHAR(255) NULL</sql>
	  </EcomOrders>
	</database>
  </package>
  <package version="5" date="06-12-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD [SalesDiscountParameters] MEMO NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="4" date="06-12-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomGroups>
		<sql conditional="">ALTER TABLE EcomGroups ADD GroupIcon VARCHAR (255) NULL</sql>
	  </EcomGroups>
	  <EcomShops>
		<sql conditional="">ALTER TABLE EcomShops ADD ShopIcon VARCHAR (255) NULL</sql>
	  </EcomShops>
	</database>
  </package>

  <package version="3" date="16-11-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomPayments>
		<sql conditional="">ALTER TABLE EcomPayments ADD PaymentCCITemplate VARCHAR (255) NULL</sql>
	  </EcomPayments>
	</database>
  </package>

  <package version="2" date="16-11-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomSalesDiscount>
		<sql conditional="">DROP INDEX [EcomSalesDiscount$SalesDiscountReleaseCode] ON [EcomSalesDiscount]</sql>
		<sql conditional="">DROP INDEX [EcomSalesDiscount$SalesDiscountProductID] ON [EcomSalesDiscount]</sql>

		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP COLUMN [SalesDiscountBuyLimit]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP COLUMN [SalesDiscountProductID]</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] DROP COLUMN [SalesDiscountReleaseCode]</sql>

		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD [SalesDiscountDiscountType] VARCHAR (255) NULL</sql>
		<sql conditional="">ALTER TABLE [EcomSalesDiscount] ADD [SalesDiscountCustomersAndGroups] MEMO NULL</sql>
	  </EcomSalesDiscount>
	</database>
  </package>

  <package version="1" date="16-11-2006" internalversion="18.11.1.0">
	<database file="Ecom.mdb">
	  <EcomTree>
		<sql conditional="">UPDATE [EcomTree] SET TreeChildPopulate = 'STAT' WHERE id = 17</sql>
	  </EcomTree>
	</database>
  </package>

</updates>
