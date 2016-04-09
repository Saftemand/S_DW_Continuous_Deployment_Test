<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Ecom_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Ecom_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
		<link rel="Stylesheet" type="text/css" href="../Stylesheet.css" />
		<title><%=title%></title>
		<script src="/Admin/Link.js" type="text/javascript"></script>
		<script type="text/javascript">
			function OK_OnClick() {
				document.getElementById('frmGlobalSettings').submit();
			}

			function findCheckboxNames(form) {
				var _names="";
				for(var i=0; i < form.length ; i++) {
					if(form[i].name!=undefined) {
						if(form[i].type=="checkbox") {
							_names = _names + form[i].name + "@"
						}
					}
				}
				form.CheckboxNames.value=_names;
			}
		</script>		
	</head>
    <body>

        <%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%", "%%", Translate.Translate(header)), tabHeader, "all")%>

	        <form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
        		<input type="hidden" name="CheckboxNames" />

                <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            		<tr>
			            <td valign="top">
			                <%If cmd = "1" Then%>
				                <%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
				
				                <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				                <table cellpadding="2" cellspacing="0" border="0">
					                <colgroup>
						                <col width="300px" />
						                <col />
					                </colgroup>
                					<tr>
				                		<td><%=Translate.Translate("Antal dage kurven gemmes")%></td>
						                <td><input type="text" onkeyup="ChkValidDays();" value="<%=Base.GetGs("/Globalsettings/Ecom/Cookie/DaysToSave")%>" id="/Globalsettings/Ecom/Cookie/DaysToSave" name="/Globalsettings/Ecom/Cookie/DaysToSave" class="stdNoWidth" size="4"></td>
					                </tr>
					                <tr>
						                <td><%=Translate.Translate("Enhed for vægt")%></td>
						                <td><input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/Unit/Weight") = "", "kg", Base.GetGs("/Globalsettings/Ecom/Unit/Weight"))%>" id="/Globalsettings/Ecom/Unit/Weight" name="/Globalsettings/Ecom/Unit/Weight" class="stdNoWidth" size="10"></td>
					                </tr>
					                <tr>
						                <td><%=Translate.Translate("Enhed for rumfang")%></td>
						                <td><input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/Unit/Volume") = "", "m³",Base.GetGs("/Globalsettings/Ecom/Unit/Volume"))%>" id="/Globalsettings/Ecom/Unit/Volume" name="/Globalsettings/Ecom/Unit/Volume" class="stdNoWidth" size="10"></td>
					                </tr>
					                <tr>
						                <td><%=Translate.Translate("Gem sidst brugte kunde data")%></td>
						                <td>
							                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData" name="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData">
							                <input type="hidden" name="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerChoicesMade" id="/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerChoicesMade" value="True">							
						                </td>
					                </tr>
				                </table>
			                    <%=Gui.GroupBoxEnd%>
			    
				
			    
				<%= Gui.GroupBoxStart(Translate.Translate("Only show products"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%= Translate.Translate("That are in stock")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" name="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" /></td>
					</tr>
					<tr>
						<td><%= Translate.Translate("That have a price")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice" name="/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice" /></td>
					</tr>
   					<tr>
    					<td><%= Translate.Translate("That are active")%></td>
	    				<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive" name="/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive" /></td>
		    		</tr>				    	
   					<tr>
    					<td><%= Translate.Translate("Show this page for inactive products")%></td>
	    				<td>
	    				<%=Dynamicweb.Gui.LinkManager(Base.GetGs("/Globalsettings/Ecom/Product/ProductNotActivePage"), "/Globalsettings/Ecom/Product/ProductNotActivePage", "", "0", "", False, "off", True)%>
	    				</td>
		    		</tr>				    			
				</table>
			    <%=Gui.GroupBoxEnd%>
			    
				<%= Gui.GroupBoxStart(Translate.Translate("Only show variants"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%= Translate.Translate("That are in stock")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock") = "True", "checked=""checked""", ""))%> id="Checkbox2" name="/Globalsettings/Ecom/Product/DontShowVariantIfNotOnStock" /></td>
					</tr>
					<tr>
						<td><%= Translate.Translate("That have a price")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfHasNoPrice") = "True", "checked=""checked""", ""))%> id="Checkbox3" name="/Globalsettings/Ecom/Product/DontShowVariantIfHasNoPrice" /></td>
					</tr>
   					<tr>
    					<td><%= Translate.Translate("That are active")%></td>
	    				<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive") = "True", "checked=""checked""", IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive") = "" AndAlso Base.GetGs("/Globalsettings/Ecom/Product/DontAllowLinksToProductIfNotActive") = "True", "checked=""checked""", ""))%> id="Checkbox4" name="/Globalsettings/Ecom/Product/DontAllowLinksToVariantIfNotActive" /></td>
		    		</tr>				    	
				</table>
			    <%=Gui.GroupBoxEnd%>
			    
				<%=Gui.GroupBoxStart(Translate.Translate("Produkt - Gruppevisnings cache"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Aktiver")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollection") = "True", "CHECKED", "")%> id="Checkbox1" name="/Globalsettings/Ecom/ProductGroup/CacheProductCollection"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Antal minuter")%></td>
						<td><input type="text" value="<%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes") = "", "1",Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes"))%>" id="Text1" name="/Globalsettings/Ecom/ProductGroup/CacheProductCollectionMinutes" class="stdNoWidth" size="4"></td>
					</tr>
				</table>
			    <%=Gui.GroupBoxEnd%>	
			    
				<%=Gui.GroupBoxStart(Translate.Translate("Afsnits cache"))%>
				<table border="0" cellpadding="2" cellspacing="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Aktiver")%></td>
						<td>
							<input id="/Globalsettings/Ecom/ProductGroup/CacheParagraph" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductGroup/CacheParagraph") = "True", "CHECKED", "")%>="" name="/Globalsettings/Ecom/ProductGroup/CacheParagraph" type="checkbox" value="True" />
						</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				
                <%=Gui.GroupBoxStart(Translate.Translate("Udregning af gebyr"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td colspan="2"><strong><%=Translate.Translate("Forsendelse")%></strong></td>
					</tr>				
					<tr>
						<td><%=Translate.Translate("Brug alt. leveringsland")%></td>
						<td>
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShippingFee/UseDeliveryCountryOnShippingFee") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/Order/ShippingFee/UseDeliveryCountryOnShippingFee" />
						</td>
					</tr>	
					<tr>
						<td colspan="2"><strong><%=Translate.Translate("Betaling")%></strong></td>
					</tr>	
					<tr>
						<td><%=Translate.Translate("Brug alt. leveringsland")%></td>
						<td>
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/PaymentFee/UseDeliveryCountryOnPaymentFee") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/Order/PaymentFee/UseDeliveryCountryOnPaymentFee" />
						</td>
					</tr>				
				</table>
			    <%=Gui.GroupBoxEnd%>	
			    
                <%=Gui.GroupBoxStart(Translate.Translate("Træstruktur"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Vis produkt antal")%></td>
						<td>
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Group/ShowProductCountInTree") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/Group/ShowProductCountInTree" />
						</td>
					</tr>	
				</table>
			    <%=Gui.GroupBoxEnd%>			    		    

                <%= Gui.GroupBoxStart(Translate.Translate("Track & Trace"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%= Translate.Translate("Show old track and trace field")%></td>
						<td>
							<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShowOldTrackAndTraceField") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/Order/ShowOldTrackAndTraceField" />
						</td>
					</tr>	
				</table>
			    <%=Gui.GroupBoxEnd%>		

			    <%=Gui.GroupBoxStart(Translate.Translate("Mail Afsendelse"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
                <tr>
						<td><%=Translate.Translate("Ordre Mail metode")%></td>
					<td>
						<select class="std" name="/Globalsettings/Ecom/Order/ConfirmMail/Method" id="/Globalsettings/Ecom/Order/ConfirmMail/Method">
							<option value=""><%=Translate.JsTranslate("Default")%></option>
							<option <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ConfirmMail/Method") = "dropbox", "selected", "")%> value="dropbox"><%=Translate.JsTranslate("Drop Box")%></option>
						</select>
					</td>
				</tr>	
				</table>
			    <%=Gui.GroupBoxEnd%>		    		    
			<%End If%>
			
			<%If cmd = "2" Then%>
				<input type="hidden" name="/Globalsettings/Ecom/ProductLanguageControl/ChoicesMade" id="/Globalsettings/Ecom/ProductLanguageControl/ChoicesMade" value="True" />

				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstilliger"))%>
					<table cellpadding="2" cellspacing="0" border="0">
						<colgroup>
							<col />
							<col width="100%" />
							<col />
						</colgroup>
						<!--<%=Translate.Translate("Vis ikke produkter for standard sproget, hvis ikke varen kan findes")%>-->
						<tr>
							<td nowrap="nowrap"><strong><%= Translate.Translate("Only show translated elements")%></strong></td>
							<td align="right"><img alt="" src="/x.gif" height="1" width="100%" border="0" /></td>
							<td><img alt="" src="/x.gif" height="1" width="16" border="0" /></td>						
						</tr>						
						<tr>
							<td nowrap><label for="DontUseDefaultLanguageIsNoProductExists"><%=Translate.Translate("Produkter og grupper")%> <small class="disableText">(<%=Translate.Translate("Enheder, varianter, relaterede varer, mm.")%>)</small></label></td>
							<td align="right"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists") = "True" OrElse String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists")), "CHECKED", "")%> id="/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists" name="/Globalsettings/Ecom/Product/DontUseDefaultLanguageIsNoProductExists" /></td>
							<td><img alt="" src="/x.gif" height="1" width="16" border="0" /></td>
						</tr>
					</table>	
				<%=Gui.GroupBoxEnd%>
						  				
				<%=Gui.GroupBoxStart(Translate.Translate("Language and variant field differentiation"))%>
					<table cellpadding="5" cellspacing="0" border="0" width="100%">
						<colgroup>
							<col />
							<col width="30px" />
							<col width="30px" />
						</colgroup>
						<tr>
							<td align="left" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><strong><%=Translate.Translate("Felt")%></strong>&nbsp;</td>
							<td align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><strong><%=Translate.Translate("Sprog")%></strong>&nbsp;</td>
							<td align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><strong><%=Translate.Translate("Variant")%></strong>&nbsp;</td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Navn")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductName") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductName" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductName" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductName") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductName" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductName" /></td>
						</tr>					
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Nummer")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductNumber") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductNumber" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductNumber" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductNumber") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductNumber" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductNumber" /></td>
						</tr>					
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><%= Translate.Translate("Teaser text")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductShortDescription") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductShortDescription" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductShortDescription" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductShortDescription") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductShortDescription" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductShortDescription" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%= Translate.Translate("Description")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLongDescription") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLongDescription" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLongDescription" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLongDescription") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLongDescription" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLongDescription" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Billede - Lille")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageSmall") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageSmall" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageSmall" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageSmall") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageSmall" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageSmall" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><%=Translate.Translate("Billede - Mellem")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageMedium") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageMedium" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageMedium" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageMedium") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageMedium" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageMedium" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Billede - Stor")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageLarge") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageLarge" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductImageLarge" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageLarge") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageLarge" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductImageLarge" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Link 1")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink1") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink1" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink1" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink1") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink1" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink1" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Link 2")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink2") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink2" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductLink2" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink2") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink2" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductLink2" /></td>
						</tr>						
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Lager",1)%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStock") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStock" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStock" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStock") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStock" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStock" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Lagergruppe")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStockGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStockGroup" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductStockGroup" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStockGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStockGroup" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductStockGroup" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Standard pris")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPrice") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPrice" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPrice" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPrice") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPrice" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPrice" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Vægt")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductWeight") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductWeight" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductWeight" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductWeight") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductWeight" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductWeight" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Rumfang")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVolume") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVolume" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVolume" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVolume") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVolume" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVolume" /></td>
						</tr>					
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Momsgruppe")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVATGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVATGroup" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductVATGroup" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVATGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVATGroup" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductVATGroup" /></td>
						</tr>					
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Producent")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductManufacturer") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductManufacturer" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductManufacturer" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductManufacturer") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductManufacturer" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductManufacturer" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Aktiv")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductActive") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductActive" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductActive" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px;border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductActive") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductActive" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductActive" /></td>
						</tr>
						<tr>
							<td valign="top" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><%=Translate.Translate("Periode")%></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPeriod") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPeriod" name="/Globalsettings/Ecom/ProductLanguageControl/Language/ProductPeriod" /></td>
							<td valign="top" align="center" style="border-bottom: #efefef solid 1px; border-right: #efefef solid 1px;"><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPeriod") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPeriod" name="/Globalsettings/Ecom/ProductLanguageControl/Variant/ProductPeriod" /></td>
						</tr>					
						<%=GetCustomProductField()%>
					</table>
				<%=Gui.GroupBoxEnd%>
			<%End If%>				

			<%If cmd = "3" Then%>
				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table cellpadding="2" cellspacing="0" border="0">
						<colgroup>
							<col width="300px" />
							<col />
						</colgroup>
						<tr>
							<td><%= Translate.Translate("System moms")%></TD>
							<td><input type="text" name="/Globalsettings/Ecom/Price/PricesInDbVAT" id="/Globalsettings/Ecom/Price/PricesInDbVAT" value="<%=Base.GetGs("/Globalsettings/Ecom/Price/PricesInDbVAT")%>" maxlength="255" size=4 class="stdNoWidth" /> %</td>
						</tr>

						<tr>
							<td><%= Translate.Translate("Use VAT group rate as system tax")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax" name="/Globalsettings/Ecom/Price/UseSalesTaxGroupRateAsSystemTax" /></td>
						</tr>

						<tr>
							<td><%=Translate.Translate("Priser i DB inkl. moms")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/PricesInDbIncludesVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/PricesInDbIncludesVAT" name="/Globalsettings/Ecom/Price/PricesInDbIncludesVAT" /></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Afrund priser med moms")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/RoundPricesWithVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/RoundPricesWithVAT" name="/Globalsettings/Ecom/Price/RoundPricesWithVAT" /></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Beregn % forsendelsesgebyr inkl. moms")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT" name="/Globalsettings/Ecom/Price/CalculatePercentShippingFeeInclVAT" /></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Brug alt. leveringsland ved moms")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry" name="/Globalsettings/Ecom/Order/VAT/UseDeliveryCountry" /></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
				
                <%=Gui.GroupBoxStart(Translate.Translate("Calculate VAT on fees"))%>
					<table cellpadding="2" cellspacing="0" border="0">
						<colgroup>
							<col width="300px" />
							<col />
						</colgroup>
						<tr>
							<td><%=Translate.Translate("Payment")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee" name="/Globalsettings/Ecom/Order/PaymentFee/IncludeVATOnPaymentFee" /></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Shipment")%></td>
							<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee" name="/Globalsettings/Ecom/Order/ShippingFee/IncludeVATOnShippingFee" /></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>				
			<%End If%>		
			
			<%If cmd = "4" Then%>
				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table cellpadding="2" cellspacing="0" border="0" width="100%">
						<colgroup>
							<col width="170" />
							<col />
							<col />
						</colgroup>
						<tr>
							<td><label for="DontShowProductIfNotOnStock"><%=Translate.Translate("Vis ikke, hvis ikke på lager")%></label></td>
							<td><input type="checkbox" value="True" id="DontShowProductIfNotOnStock" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" name="/Globalsettings/Ecom/Product/DontShowProductIfNotOnStock" /></td>
							<td><img alt="" src="/x.gif" height="1" width="16" border="0" /></td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
			<%End If%>						

			<%If cmd = "5" Then%>
				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
					<colgroup>
						<col width="200px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Differentiate on VAT Groups")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup" name="/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup" /></td>
					</tr>
					<tr><td colspan="2"><hr size="1" color="#efefef" /></td></tr>
					<tr>
				    	<td><%=Translate.Translate("Valg af rabat")%></td>
						<td>
							<select class="std" name="/Globalsettings/Ecom/Discount/DiscountSelection" id="/Globalsettings/Ecom/Discount/DiscountSelection">

							<%	
							    Dim selA As String = ""
							    Dim selB As String = ""
							    Dim selC As String = ""
							
							    If Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "acc" Then
							        selA = "SELECTED"
							    ElseIf Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "high" Then
							        selB = "SELECTED"
							    ElseIf Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "low" Then
							        selC = "SELECTED"
							    End If

							    Response.Write("<option value=""acc"" " & selA & ">" & Translate.JsTranslate("Akkumuleret") & "</option>")
							    Response.Write("<option value=""high"" " & selB & ">" & Translate.JsTranslate("Højest") & "</option>")
							    Response.Write("<option value=""low"" " & selC & ">" & Translate.JsTranslate("Lavest") & "</option>")
							%>
							</select>
						</td>
					</tr>
						
					<tr>
					    <td colspan="2">
				            <div style="color:Gray">
				                <p>
				                    <%
				                        Response.Write(Translate.Translate( _
				                         "This setting does not effect the product discounts, as they are always accumulated." _
				                        ))
				                    %>
				                </p>
					        </div>		
					    </td>
					</tr>	
			    </table>

				<%=Gui.GroupBoxEnd%>

				<!--					
				<%=Gui.GroupBoxStart(Translate.Translate("Afrunding af individuelle produktrabatter"))%>
				<table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
					<colgroup>
						<col width="200px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Afrund individuelle rabatter") %></td>
						<td>
							<input type="checkbox" id="discountRoundingIndividualAmount" />
						</td>
						<td>
							<label for="discountRoundingIndividualAmount"><%=Translate.Translate("Faste rabatbeløb") %></label>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="checkbox" id="discountRoundingIndividualPercent" /></td>
						<td><label for="discountRoundingIndividualPercent"><%=Translate.Translate("Rabatter i procent") %></label></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Afrund samlede rabat per produkt") %></td>
						<td><input type="checkbox" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Afrund produktpris efter rabat") %></td>
						<td><input type="checkbox" /></td>
						<td></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
				-->
			<%End If%>	
				
				
            <%If cmd = "6" Then%>
            <%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
                
	        <%=Gui.GroupBoxStart(Translate.Translate("Product default images"))%>
		        <table cellpadding="2" cellspacing="0" border="0">
			        <colgroup>
				        <col width="170px" />
				        <col />
			        </colgroup>
			        <tr>
				        <td><%=Translate.Translate("Lille")%></td>
				        <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Small"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Small", "", True, "std", True)%></td>
			        </tr>
			        <tr>
				        <td><%=Translate.Translate("Medium")%></td>
				        <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Medium"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Medium", "", True, "std", True)%></td>
			        </tr>
			        <tr>
				        <td><%=Translate.Translate("Stor")%></td>
				        <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Large"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Large", "", True, "std", True)%></td>
			        </tr>
		        </table>
	            <%=Gui.GroupBoxEnd%>
                            	
                <%=Gui.GroupBoxStart(Translate.Translate("Group default images"))%>
		                <table cellpadding="2" cellspacing="0" border="0">
			                <colgroup>
				                <col width="170px" />
				                <col />
			                </colgroup>
			                <tr>
				                <td><%=Translate.Translate("Lille")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/Group/NoPicture/Small"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/Group/NoPicture/Small", "", True, "std", True)%></td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Stor")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/Group/NoPicture/Large"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/Group/NoPicture/Large", "", True, "std", True)%></td>
			                </tr>
		                </table>
	            <%=Gui.GroupBoxEnd%>	
		            
	            <%=Gui.GroupBoxStart(Translate.Translate("Image pattern"))%>
	             <table cellpadding="2" cellspacing="0" border="0">
			        <colgroup>
				        <col width="170px" />
				        <col />
			        </colgroup>
			        <tr>
				        <td><%=Translate.Translate("Pattern")%></td>
				        <td>
				        <input type="text" name="/Globalsettings/Ecom/Picture/ImagePattern" id="/Globalsettings/Ecom/Picture/ImagePattern" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/ImagePattern")%>" class="std" /> 
				        </td>
			        </tr>
		        </table>
	            <%=Gui.GroupBoxEnd%>	
		            
		        <%=Gui.GroupBoxStart(Translate.Translate("Autoscale"))%>
		        <table cellpadding="2" cellspacing="0" border="0">
			        <colgroup>
				        <col width="170px" />
				        <col width="50px" />
				        <col />
			        </colgroup>
                    <tr>
						<td></td>
						<td><strong><%=Translate.JsTranslate("Active")%></strong></td>
						<td><strong><%=Translate.JsTranslate("Width")%>&nbsp;&nbsp;&nbsp;<%=Translate.JsTranslate("Height")%></strong></td>
					</tr>				        
			        <tr>
				        <td><%=Translate.Translate("Lille")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Small/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Active" Onclick="ChkAutoScaleOn();" /></td>
				        <td id="as_Small">
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Small/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray">x</span>
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Small/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				        </td>
			        </tr>
			        <tr>
				        <td><%=Translate.Translate("Medium")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Active" Onclick="ChkAutoScaleOn();" /></td>
                        <td id="as_Medium">
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray">x</span>
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				        </td>
			        </tr>
			        <tr>
				        <td><%=Translate.Translate("Stor")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Large/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Active" Onclick="ChkAutoScaleOn();" /></td>
                           <td id="as_Large">
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Large/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray">x</span>
				            <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Large/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				            <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				        </td>
			        </tr>
		        </table>
	            <%=Gui.GroupBoxEnd%>			            				    
				
			<%End If%>	
			
		    <%If cmd = "7" Then%>
   				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
   				
				<dw:GroupBox runat="server" Title="Indstillinger" DoTranslation="true">
				    <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
			            <colgroup>
				            <col width="450px" />
				            <col width="20px" />
			            </colgroup>
					    <tr>
				    	    <td><dw:TranslateLabel runat="server" Text="Skip payment and shipping step if only one method exists" /></td>
						    <td>
						        <input type="checkbox" name="/Globalsettings/Ecom/Cart/SkipMethodStep" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/SkipMethodStep")), "checked", "")%> />
						    </td>
					    </tr>
					    <tr>
				    	    <td><dw:TranslateLabel runat="server" Text="Enable step validation" /></td>
						    <td>
						        <input type="checkbox" name="/Globalsettings/Ecom/Cart/StepValidate" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/StepValidate")), "checked", "")%> />
						    </td>
					    </tr>
					    <tr>
					        <td colspan="2">
				                <div style="color:Gray">
				                    <p>
				                        <dw:TranslateLabel runat="server" Text="Notice that step validation requires changes to the AcceptCart.html template. Click ´Help´ for further information." />
				                    </p>
					            </div>		
					        </td>
					    </tr>
					    <tr>
					        <td>
					            <dw:TranslateLabel runat="server" Text="Create new cart when current cart is an order and is manipulated" />
					        </td>
					        <td>
					            <input type="checkbox" name="/Globalsettings/Ecom/Cart/MakeNewCartWhenCartIsOrderAndIsManipulated" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/MakeNewCartWhenCartIsOrderAndIsManipulated")), "checked=""checked""", "")%> />
					        </td>
					    </tr>
			        </table>
                </dw:GroupBox>
                
                <dw:GroupBox runat="server" Title="Default methods" DoTranslation="true">
				    <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
			            <colgroup>
				            <col width="450px" />
				            <col width="20px" />
			            </colgroup>
					    <tr>
					        <td colspan="2">
				                <div style="color:Gray">
				                    <p>
				                        <dw:TranslateLabel runat="server" Text="Use default methods before the user selects them" />
				                    </p>
					            </div>		
					        </td>
					    </tr>
					    <tr>
				    	    <td><dw:TranslateLabel runat="server" Text="Payment" /></td>
						    <td>
						        <input type="checkbox" name="/Globalsettings/Ecom/Cart/UseDefaultPayment" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/UseDefaultPayment")), "checked", "")%> />
						    </td>
					    </tr>
					    <tr>
				    	    <td><dw:TranslateLabel runat="server" Text="Shipping" /></td>
						    <td>
						        <input type="checkbox" name="/Globalsettings/Ecom/Cart/UseDefaultShipping" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/UseDefaultShipping")), "checked", "")%> />
						    </td>
					    </tr>
                    </table>
                </dw:GroupBox>
		    <%End If%>
			
            <%If cmd = 8 Then%>						
   				<%=Gui.MakeModuleHeader(ModuleIcon, header, False)%>
				<%= Gui.GroupBoxStart(Translate.Translate("Automatic metadata"))%>
				<table cellpadding="2" cellspacing="0" border="0">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Aktiver")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/PageTitle/ChangeTitle") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/PageTitle/ChangeTitle" /></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Vis produkt navn")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/PageTitle/ShowProductName") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/PageTitle/ShowProductName" /></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Seperator")%></td>
    					<td><input type="text" name="/Globalsettings/Ecom/PageTitle/Seperator" value="<%=Base.GetGs("/Globalsettings/Ecom/PageTitle/Seperator")%>" maxlength="255" size=1 class="stdNoWidth" /></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Placering")%></td>
						<td>
							<select class="std" name="/Globalsettings/Ecom/PageTitle/Fix">
							<%	
								Dim selA As String = ""
								Dim selB As String = ""
							
								If Base.GetGs("/Globalsettings/Ecom/PageTitle/Fix") = "" Or Base.GetGs("/Globalsettings/Ecom/PageTitle/Fix") = "PRE" Then
									selA = "SELECTED"
								ElseIf Base.GetGs("/Globalsettings/Ecom/PageTitle/Fix") = "POST" Then
									selB = "SELECTED"
								End If

								Response.Write("<option value=""PRE"" " & selA & ">" & Translate.JsTranslate("Foran") & "</option>")
								Response.Write("<option value=""POST"" " & selB & ">" & Translate.JsTranslate("Bagved") & "</option>")
							%>
							</select>						
						</td>
					</tr>	
					<tr>
						<td><%=Translate.Translate("Remove manually added title and description")%></td>
						<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/PageTitle/RemoveOldTitle") = "True", "CHECKED", "")%> name="/Globalsettings/Ecom/PageTitle/RemoveOldTitle" /></td>
					</tr>			
				</table>
			    <%=Gui.GroupBoxEnd%>	
            <%End If%>
		</td>
	</tr>		
	<tr>
		<td align="right" valign="bottom">
			<table>
				<tr>
					<td><%=Gui.Button(Translate.JSTranslate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%></td>
					<%=Gui.HelpButton("", helpUrl)%>
					<td width="2"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>

<%  If cmd = "1" Or cmd = "8" Then%>
<script language="javascript" type="text/javascript">
function ChkValidDays(){
	var field = document.getElementById('/Globalsettings/Ecom/Cookie/DaysToSave');
	var newValue = '';
	for(i = 0; i < field.value.length; i++){
		if(!isNaN(field.value.charAt(i))){
		//if(field.value.charAt(i) >= 0 && field.value.charAt(i) <= 9){
			newValue = newValue + '' + field.value.charAt(i);
		}
	}
	field.value = newValue;
}
</script>

<script language="javascript" type="text/javascript">
var CheckAll = false; //<%=IIf(Base.GetGs("/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerChoicesMade") = "True", "false", "true")%>;
if (CheckAll) {
	for (i=0; i<document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "checkbox") {
			if (document.forms[0].elements[i].name.indexOf("/Globalsettings/Ecom/Cookie/SaveLastUsedCustomerData") != -1) {
				document.forms[0].elements[i].checked = true;
			}	
		}
	}
}
</script>
<%End If%>

<%If cmd = "2" Then%>
<script language="javascript" type="text/javascript">
var CheckAll = false;  //<%=IIf(Base.GetGs("/Globalsettings/Ecom/ProductLanguageControl/ChoicesMade") = "True", "false", "true")%>;
if (CheckAll) {
	for (i=0; i<document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "checkbox") {
			if (document.forms[0].elements[i].name.indexOf("/Globalsettings/Ecom/ProductLanguageControl/") != -1) {
				document.forms[0].elements[i].checked = true;
			}	
		}
	}

}
</script>
<%End If%>

<%  If cmd = "6" Then%>
<script language="javascript" type="text/javascript">
function ChkAutoScaleOn() {
    //SMALL
    var as_sm = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Small/Active");
    if (as_sm.checked) {
        document.getElementById("as_Small").style.filter = "";
    } else {
		document.getElementById('as_Small').style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
    }  

    //MEDIUM
    var as_me = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Medium/Active");
    if (as_me.checked) {
        document.getElementById("as_Medium").style.filter = "";
    } else {
        document.getElementById("as_Medium").style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
    }  

    //LARGE
    var as_lr = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Large/Active");
    if (as_lr.checked) {
        document.getElementById("as_Large").style.filter = "";
    } else {
        document.getElementById("as_Large").style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
    }  
}
ChkAutoScaleOn();
</script>
<%End If%>

<%
Translate.GetEditOnlineScript()
%>
