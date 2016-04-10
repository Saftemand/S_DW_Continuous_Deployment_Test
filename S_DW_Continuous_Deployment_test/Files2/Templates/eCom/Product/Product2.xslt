<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE stylesheet [
  <!ENTITY nbsp '&#160;'>
]>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />
  <xsl:param name="html-content-type" />
  <xsl:variable name="availableloops" select="'Details,VariantCombinations,BOMProducts,ProductRelatedGroups,RelatedProducts'" />
  <xsl:template match="/Template">
	<div id="showproduct">
	  <form   method="get">
		<xsl:attribute name="name">
		  <xsl:value-of select="Ecom.Product.ID" disable-output-escaping="yes"/>
		</xsl:attribute>

		<xsl:attribute name="id">
		  <xsl:value-of select="Ecom.Product.ID" disable-output-escaping="yes"/>
		</xsl:attribute>

		<xsl:value-of select="Ecom.Product.Form.Clean" disable-output-escaping="yes"/>
		<h1>
		  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
		  <xsl:value-of select="Ecom.Product.DefaultVariantComboName" disable-output-escaping="yes"/>
		</h1>

		<div id="leftcolumn">
		  <a  rel="lightbox"  id="productimage" >
			<xsl:attribute name="href">
			  <xsl:value-of select="Ecom.Product.ImageLarge.Default.Clean" disable-output-escaping="yes"/>
			</xsl:attribute>

			<xsl:attribute name="title">
			  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
			</xsl:attribute>

			<xsl:attribute name="style">
			  <xsl:text></xsl:text>background: url('<xsl:value-of select="Ecom.Product.ImageMedium.Default.Clean" disable-output-escaping="yes"/>') no-repeat center;
			</xsl:attribute>

			<img src="/x.gif"  >
			  <xsl:attribute name="alt">
				<xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
			  </xsl:attribute>
			</img>

		  </a>
		  <xsl:for-each select="loop[@name='Details']/item">
			<!--@HeaderStart-->
			<div id="detailimages">
			  <ul>
				<!--@HeaderEnd-->
				<li>
				  <a >
					<xsl:attribute name="href">
					  <xsl:value-of select="Ecom.Product.Detail.Image.Clean" disable-output-escaping="yes"/>
					</xsl:attribute>

					<img  alt="" border="" >
					  <xsl:attribute name="src">
						<xsl:text></xsl:text>/admin/public/getimage.aspx?width=130&amp;height=40&amp;image=<xsl:value-of select="Ecom.Product.Detail.Image.Clean" disable-output-escaping="yes"/>
					  </xsl:attribute>
					</img>

				  </a>
				</li>
				<!--@FooterStart-->
			  </ul>
			</div>
			<!--@FooterEnd-->
		  </xsl:for-each>
		</div>

		<div id="rightcolumn">
		  <small>
			Product number: <xsl:value-of select="Ecom.Product.Number" disable-output-escaping="yes"/>
		  </small>
		  <div class="productprice">
			<xsl:value-of select="Ecom.Product.Discount.Price" disable-output-escaping="yes"/>
		  </div>
		  <div class="discountprice">
			<xsl:value-of select="Ecom.Product.Discount.Price" disable-output-escaping="yes"/>
		  </div>

		  <a   class="addtobasket" title="Add to cart">
			<xsl:attribute name="href">
			  <xsl:text></xsl:text>javascript:document.getElementById('<xsl:value-of select="Ecom.Product.ID" disable-output-escaping="yes"/>').submit();
			</xsl:attribute>

			<xsl:attribute name="onclick">
			  <xsl:text></xsl:text>return checkstock('<xsl:value-of select="Ecom.Product.Stock" disable-output-escaping="yes"/>', '1');
			</xsl:attribute>
			<span class="plus">
			  + <span>Add to cart</span>
			</span>
		  </a>
		  <br />
		  <br />

		  <xsl:for-each select="loop[@name='VariantCombinations']/item">
			<!--@HeaderStart-->
			<div id="productvariants">
			  <h2>
				Product variants
			  </h2>
			  <label >
				<xsl:attribute name="for">
				  <xsl:value-of select="Ecom.VariantGroup.ID" disable-output-escaping="yes"/>
				</xsl:attribute>

				<xsl:value-of select="Ecom.VariantGroup.Label" disable-output-escaping="yes"/>
			  </label>
			  <select   onchange="setVariant(this.options[this.selectedIndex].value);">
				<xsl:attribute name="id">
				  <xsl:value-of select="Ecom.VariantGroup.ID" disable-output-escaping="yes"/>
				</xsl:attribute>

				<xsl:attribute name="name">
				  <xsl:value-of select="Ecom.VariantGroup.Name" disable-output-escaping="yes"/>
				</xsl:attribute>

				<option>Select variant</option>
				<!--@HeaderEnd-->
				<option >
				  <xsl:attribute name="value">
					<xsl:text></xsl:text>/default.aspx?id=<xsl:value-of select="Global.Page.ID" disable-output-escaping="yes"/>&amp;productid=<xsl:value-of select="Ecom.VariantCombination.Product.ID" disable-output-escaping="yes"/>&amp;variantid=<xsl:value-of select="Ecom.VariantCombination.VariantID" disable-output-escaping="yes"/>&amp;groupid=<xsl:value-of select="Server.Request.groupid" disable-output-escaping="yes"/>
				  </xsl:attribute>

				  <xsl:value-of select="Ecom.VariantCombination.VariantText" disable-output-escaping="yes"/>
				</option>
				<!--@FooterStart-->
			  </select>
			</div>
			<br />
			<!--@FooterEnd-->
		  </xsl:for-each>

		  <xsl:if test="Ecom.Product.Stock.Text != ''">
			<div  id="productstock">
			  <xsl:attribute name="class">
				<xsl:value-of select="Ecom.Product.Stock.ID" disable-output-escaping="yes"/>
			  </xsl:attribute>

			  <strong>Stock status</strong>
			  <span class="stocktext">
				<xsl:value-of select="Ecom.Product.Stock.Text" disable-output-escaping="yes"/>:
				<img   border="0" >
				  <xsl:attribute name="src">
					<xsl:value-of select="Ecom.Product.Stock.Image.Clean" disable-output-escaping="yes"/>
				  </xsl:attribute>

				  <xsl:attribute name="alt">
					<xsl:value-of select="Ecom.Product.Stock.Text" disable-output-escaping="yes"/>
				  </xsl:attribute>
				</img>

			  </span>
			  <span class="stockdeliverytext">
				Delivery within: <xsl:value-of select="Ecom.Product.Stock.DeliveryText" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="Ecom.Product.Stock.DeliveryUnit" disable-output-escaping="yes"/>
			  </span>
			</div>
		  </xsl:if>

		</div>

		<div id="includingproducts">
		  <xsl:for-each select="loop[@name='BOMProducts']/item">
			<!--@HeaderStart-->
			<h2>
			  Including products
			</h2>
			<ul>
			  <!--@HeaderEnd-->
			  <li >
				<xsl:attribute name="class">
				  <xsl:text></xsl:text>listitem<xsl:value-of select="BOMProducts.LoopMod2" disable-output-escaping="yes"/>
				</xsl:attribute>
				<a >
				  <xsl:attribute name="href">
					<xsl:value-of select="Ecom.Product.Link.Clean.PID" disable-output-escaping="yes"/>
				  </xsl:attribute>

				  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
				</a>
			  </li>
			  <!--@FooterStart-->
			</ul>
			<!--@FooterEnd-->
		  </xsl:for-each>
		</div>

		<div id="description">
		  <br />
		  <h2 class="productdesc">
			<xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
		  </h2>
		  <span class="shortdesc">
			<xsl:value-of select="Ecom.Product.ShortDescription" disable-output-escaping="yes"/>
		  </span>
		  <span class="longdesc">
			<xsl:value-of select="Ecom.Product.LongDescription" disable-output-escaping="yes"/>
		  </span>
		</div>

		<div id="productlist">
		  <xsl:for-each select="loop[@name='ProductRelatedGroups']/item">
			<h2>
			  <xsl:value-of select="Ecom.Product.RelatedGroup.Name" disable-output-escaping="yes"/>
			</h2>
			<xsl:for-each select="./loop[@name='RelatedProducts']/item">
			  <!--@HeaderStart-->

			  <ul>
				<!--@HeaderEnd-->
				<li>
				  <a   class="productName">
					<xsl:attribute name="href">
					  <xsl:value-of select="Ecom.Product.Link.Clean.PID" disable-output-escaping="yes"/>&amp;groupid=<xsl:value-of select="Server.Request.groupid" disable-output-escaping="yes"/>
					</xsl:attribute>

					<xsl:attribute name="title">
					  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
					</xsl:attribute>
					<h2>
					  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
					</h2>
				  </a>
				  <xsl:if test="Ecom.Product.ImageSmall.Default.Clean != ''">
					<a   class="GroupLink">
					  <xsl:attribute name="href">
						<xsl:value-of select="Ecom.Product.Link.Clean.PID" disable-output-escaping="yes"/>&amp;groupid=<xsl:value-of select="Server.Request.groupid" disable-output-escaping="yes"/>
					  </xsl:attribute>

					  <xsl:attribute name="title">
						<xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
					  </xsl:attribute>

					  <img class="productimage"   border="0" >
						<xsl:attribute name="src">
						  <xsl:value-of select="Ecom.Product.ImageSmall.Default.Clean" disable-output-escaping="yes"/>
						</xsl:attribute>

						<xsl:attribute name="alt">
						  <xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes"/>
						</xsl:attribute>
					  </img>

					</a>
				  </xsl:if>

				  <br />

				  <div class="price">
					<xsl:value-of select="Ecom.Product.Price" disable-output-escaping="yes"/>
				  </div>

				  <a  class="addtobasket" title="Add to cart">
					<xsl:attribute name="href">
					  <xsl:value-of select="Ecom.Product.Link.Clean.PID" disable-output-escaping="yes"/>&amp;cartcmd=add
					</xsl:attribute>
					<span class="plus">
					  + <span>Add to cart</span>
					</span>
				  </a>
				</li>
				<!--@FooterStart-->
			  </ul>
			  <!--@FooterEnd-->
			</xsl:for-each>
		  </xsl:for-each>
		</div>

	  </form>
	</div>


  </xsl:template>
</xsl:stylesheet>
