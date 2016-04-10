<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//Product">
	  <Products>
      <Product>
		    <ProductID />
		    <ProductLanguageID />
		    <ProductDefaultShopID />
		    <ProductNumber>
			    <xsl:value-of select="ProductNumber"/>
		    </ProductNumber>
		    <ProductName>
			    <xsl:value-of select="ProductName"/>
		    </ProductName>
		    <ProductShortDescription>
			    <xsl:value-of select="ProductShortDescription"/>
		    </ProductShortDescription>
		    <ProductLongDescription>
          <xsl:value-of select="ProductLongDescription"/>
        </ProductLongDescription>
        <ProductStock>
          <xsl:value-of select="ProductStock"/>
        </ProductStock>
        <ProductStockGroupID />
        <ProductWeight>
          <xsl:value-of select="ProductWeight"/>
        </ProductWeight>
        <ProductVolume />
        <ProductVatGroupID />
        <ProductManufacturerID />
		    <ProductActive>1</ProductActive>
        <ProductPeriodID />
		    <ProductCreated />
		    <ProductUpdated />
		    <ProductType />
		    <ProductPriceType />
        <ProductVariantID />
        <ProductImageSmall>
          <xsl:value-of select="ProductImageSmall"/>
        </ProductImageSmall>
        <ProductImageMedium />
        <ProductImageLarge />
        <ProductLink1 />
        <ProductLink2 />
		    <ProductPrice>
			    <xsl:value-of select="ProductPrice"/>
		    </ProductPrice>
		    <ProductDefaultUnitID />
		    <ProductDefaultVariantComboID />
		    <ProductPriceMatrixUnit />
		    <ProductPriceMatrixVariant />
        <ProductPriceMatrixPeriod />
		    <ProductPriceMatrixMultiplePrices />
		    <ProductPriceMatrixQuantitySpecification />
        <ProductPriceCnt />
        <ProductVariantCnt />
        <ProductVariantProductCnt />
        <ProductVariantGroupCnt />
        <ProductRelatedCnt />
        <ProductUnitCnt />
        
        <ProductGroups>
          <GroupID>
            <xsl:value-of select="ProductGroupID"/>
          </GroupID>
        </ProductGroups>
        
      </Product>
    </Products>
  </xsl:template>
</xsl:stylesheet>
