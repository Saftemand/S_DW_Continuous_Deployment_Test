<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"  encoding="utf-8" />

	<xsl:variable name="availableloops" select="'CustomGroupFields'" />

	<xsl:template match="/">
		<xsl:apply-templates select="Template" />
	</xsl:template>
	
	<xsl:template match="Template[loop[@name='Products']]">
		<div id="productlist">
			<xsl:apply-templates select="loop[@name='Products']" />
		</div>
	</xsl:template>
	
	<xsl:template match="loop[item]">
		<xsl:apply-templates select="../Ecom.Group.Name" />
		<ul>
			<xsl:apply-templates select="item" />
		</ul>
	</xsl:template>
	
	<xsl:template match="Ecom.Group.Name">
		<h2>
			<xsl:value-of select="." />
		</h2>
	</xsl:template>
	
	<xsl:template match="item">
		<li class="listitem{position() mod 3}">
			<a href="{Ecom.Product.Link.Clean.PID}&amp;{GroupID=Server.Request.groupid}&amp;{PageTitle=Server.Request.pagetitle}%20-%20{Ecom.Product.Name}&amp;groupname={Server.Request.groupname}&amp;productname={Ecom.Product.Name}" class="productname">
				<xsl:value-of select="Ecom.Product.Name" disable-output-escaping="yes" />
			</a>
			<a href="{Ecom.Product.Link.Clean.PID}&amp;GroupID={Server.Request.groupid}&amp;PageTitle={Server.Request.pagetitle}%20-%20{Ecom.Product.Name}&amp;groupname={Server.Request.groupname}&amp;productname={Ecom.Product.Name}">
		        <img class="productimage" src="{Ecom.Product.ImageSmall.Default.Clean}&amp;crop={Ecom.Product.Field.croporigin.Value}" alt="{Ecom.Product.Name}" border="0" />    
		    </a>	
	      
	        <a href="{Ecom.Product.Link.Clean.PID}&amp;cartcmd=add" class="productprice">
	        	<xsl:value-of select="Ecom.Product.Price" disable-output-escaping="yes" />
	        </a>
	        <a href="{Ecom.Product.Link.Clean.PID}&amp;cartcmd=add" class="addtobasket">Add to basket</a>
	    </li>
	</xsl:template>

</xsl:stylesheet>