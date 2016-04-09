<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<statements>
 		    <shopid>
		      <xsl:value-of select="Orders/Order/OrderShopID"/>	
 		    </shopid>
		    <use>		
		        <xsl:apply-templates select="Orders/Order/Shop | Orders/Order/OrderState " />
		    </use>		
		</statements>

	</xsl:template>
	<xsl:template match="Orders/Order/Shop">
		<xsl:choose>
			<xsl:when test="@delete = true">
				DELETE FROM EcomShops WHERE ShopID='<xsl:value-of select="ShopID"/>'
			</xsl:when>
			<xsl:otherwise>
				INSERT INTO EcomShops
				           ([ShopID]
				           ,[ShopName]
				           ,[ShopCreated]
				           ,[ShopDefault]
				           ,[ShopIcon])
				VALUES
				           (
					    '<xsl:value-of select="../OrderShopID"/>',
  					    <xsl:choose>
  						<xsl:when test="ShopName">
  							     '<xsl:value-of select="ShopName"/>',
  						</xsl:when>
  						<xsl:otherwise>
  							     '<xsl:value-of select="../OrderShopID"/>',
  						</xsl:otherwise>
  					    </xsl:choose>
					    '<xsl:value-of select="ShopCreated"/>',
					    '<xsl:value-of select="ShopDefault"/>',
					    '<xsl:value-of select="ShopIcon"/>'
					   );
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="Orders/Order/OrderState">
		<xsl:choose>
			<xsl:when test="@delete = true">
				DELETE FROM EcomOrderStates WHERE OrderStateID='<xsl:value-of select="OrderStateID"/>'
			</xsl:when>
			<xsl:otherwise>
	 			     INSERT INTO EcomOrderStates
	 			           ([OrderStateID]
	 			           ,[OrderStateName]
	 			           ,[OrderStateDescription]
	 			           ,[OrderStateIsDefault]
	 			           ,[OrderStateDontUseInstatistics]
	 			           ,[OrderStateIsDeleted])
	 			     VALUES
	 			           (
 			  	                '<xsl:value-of select="OrderStateID"/>',
						'<xsl:value-of select="OrderStateName"/>',
						'<xsl:value-of select="OrderStateDescription"/>',
						'<xsl:value-of select="OrderStateIsDefault"/>',
						'<xsl:value-of select="OrderStateDontUseInstatistics"/>',
						'<xsl:value-of select="OrderStateIsDeleted"/>'
					    );

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



</xsl:stylesheet>
