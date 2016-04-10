<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//Product">
	  <Products>
      <Product>
		    <ProductID>
			    <xsl:value-of select="ProductID"/>
		    </ProductID>
		    <ProductLanguageID>
          <xsl:value-of select="ProductLanguageID"/>
        </ProductLanguageID>
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
        <ProductVolume>
          <xsl:value-of select="ProductVolume"/>
        </ProductVolume>
        <ProductVatGroupID />
        <ProductManufacturerID>
          <xsl:value-of select="ProductManufacturerID"/>
        </ProductManufacturerID>
		    <ProductActive>
          <xsl:value-of select="ProductActive"/>
        </ProductActive>
        <ProductPeriodID>
          <xsl:value-of select="ProductPeriodID"/>
        </ProductPeriodID>
		    <ProductCreated />
		    <ProductUpdated />
		    <ProductType />
		    <ProductPriceType />
        <ProductVariantID>
          <xsl:value-of select="ProductVariantID"/>
        </ProductVariantID>
        <ProductImageSmall>
          <xsl:value-of select="ProductImageSmall"/>
        </ProductImageSmall>
        <ProductImageMedium>
          <xsl:value-of select="ProductImageMedium"/>
        </ProductImageMedium>
        <ProductImageLarge>
          <xsl:value-of select="ProductImageLarge"/>
        </ProductImageLarge>
        <ProductLink1>
          <xsl:value-of select="ProductLink1"/>
        </ProductLink1>
        <ProductLink2>
          <xsl:value-of select="ProductLink2"/>
        </ProductLink2>
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
