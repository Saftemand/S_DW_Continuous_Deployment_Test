<%@ Page Language="vb" AutoEventWireup="false" EnableEventValidation="false" CodeBehind="SetupWizard.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.SetupWizard" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="SetupWizard.css" />
    <script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
    <%=CheckoutAddin.Jscripts%>
	<!--should after AddInControl-->
	<!--script type="text/javascript" src="../images/AjaxAddInParameters.js"></script-->
    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
    <script type="text/javascript">

        function hideAll() {
            $("step1Introduction").hide();
            $("step2Shop").hide();
            $("step3Language").hide();
            $("step4Currency").hide();
            $("step5Country").hide();
            $("step6Payment").hide();
            $("step7Shipment").hide();

            $('PAGEEXECUTE').hide();
            $('PAGEFINISH').hide();
            $('PAGEERROR').hide();
        }

        function save() {
            showStep('PAGEEXECUTE');
            document.setupWizardForm.style.cursor = "wait";

            var d = new Date();
            ajaxLoader("RequestAjax");
        }

        function help() {
            window.open("http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=ecom.light.wizard&LanguageID=en", "dw_help_window", "location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=" + (screen.availHeight - 100) + ",resizable=yes");
        }

        function cancel(neverShowAgain) {
            if (neverShowAgain) {
                $('CMD').value = 'HideECommerceGuide';
                $('setupWizardForm').request();
            }
            parent.setupWizardHide();
        }

        function closeWizard() {
            // Update parent window to see new shops
            var src = parent.document.location.href;
            if (src.endsWith('#'))
                src = src.substr(0, src.length - 1);
            parent.document.location.href = src;
        }

        function WizardFinish() {
            document.setupWizardForm.style.cursor = "default";
            showStep('PAGEFINISH');
        }

        function WizardError(errorMsg) {
            document.setupWizardForm.style.cursor = "default";

            showStep('PAGEERROR');
            alert(errorMsg);

            window.setTimeout("showStep('step1Introduction')", 10000);
        }

        function showStep(stepid) {
            hideAll();
            $(stepid).show();
            setPageStatus(stepid);
        }

        function setPageStatus(stepid) {
            var totalPages = <%= IIf(Dynamicweb.Base.HasAccess("eCom_CartV2"), IIf(Dynamicweb.Base.HasAccess("eCom_Payment"), 8, 7), 6) %>;

            var currentStep = 1;
            switch (stepid) {
                case "step1Introduction":
                    currentStep = 1; break;
                case "step2Shop":
                    currentStep = 2; break;
                case "step3Language":
                    currentStep = 3; break;
                case "step4Currency":
                    currentStep = 4; break;
                case "step5Country":
                    currentStep = 5; break;
                case "step6Payment":
                    currentStep = 6; break;
                case "step7Shipment":
                    currentStep = totalPages - 1; break;
                default:
                    currentStep = totalPages;
            }

            $('currentPage').update(currentStep);
            $('totalPages').update(totalPages);
        }

        function initPages() {
            if ($('__VIEWSTATE')) $('__VIEWSTATE').value = '';

            setPageStatus("step1Introduction");
        }

        function ValidateShop() {
            return doInputValidation($("shopName"));
        }

        function ValidateLang() {
            return doInputValidation($("languageName"));
        }

        function ValidateCurrency() {
            var result = doInputValidation($("currencyName"));
            result &= doInputValidation($("currencyRate"));
            result &= doInputValidation($("currencySymbol"));
            return result;
        }

        function ValidateCountry() {
            return doInputValidation($("countryName"));
        }

        function ajaxLoader(divId) {
                $('CMD').value = 'SetupECommerceGuide';
                $('setupWizardForm').request({
                onLoading: function (request) {
                    $(divId).update("<p style='text-align:center;'><img src='/Admin/Module/eCom_Catalog/images/ajaxloading_trans.gif' style='margin:5px;padding:5px;' /></p>");
                },

                onFailure: function (request) {
                },

                onComplete: function (request) {
                    var finished = false;
                    if (request.responseText == "true") {
                        finished = true;
                    }
                    $(divId).update("<br/><span style='text-align:center;margin:5px;padding:5px;'></span>");
                    if (finished)
                        WizardFinish();
                    else
                        WizardError(request.responseText);
                },

                onSuccess: function (request) {
                },

                onException: function (request) {
                }

            });
        }

    </script>

</head>

<body onload="initPages();">
    <form id="setupWizardForm" runat="server">
        <input type="hidden" id="CMD" runat="server" />
        
        <div id="step1Introduction">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.JsTranslate("Introduction")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="currentPage">1</span> <%=Translate.JsTranslate("of")%> <span id="totalPages">6</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>                
            </div>
            
            <div class="row row-pad content">
                <%= Translate.JsTranslate("Welcome to Dynamicweb eCommerce.")%><br /><br />
	            <%= Translate.JsTranslate("This wizard would guide you through the process of initial eCommerce setting up.")%><br /><br />

	            <%=Translate.JsTranslate("Items that is needed to setup the system:")%><br />
	            <ul>
	                <li><%=Translate.JsTranslate("Shop")%></li>
	                <li><%=Translate.JsTranslate("Language")%></li>
	                <li><%=Translate.JsTranslate("Currency")%></li>
	                <li><%=Translate.JsTranslate("Country")%></li>
	            </ul>
                <asp:Literal ID="notFirstTimeAlert" runat="server"></asp:Literal>
                <p><%= Translate.JsTranslate("After the guide is finished you'll be able to use your eCommerce.")%></p>
            </div>
            
            <div class="row row-pad footer">
                <div class="col-1-2">
                    <input id="neverShowAgain" type="checkbox" />
                    <label for="neverShowAgain"><%= Translate.JsTranslate("Never show this again")%></label>
                </div>
                
                <div class="col-1-2">
                    <div class="pager">
                        <ul>
                        	<li><input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="showStep('step2Shop');" /></li>
                        	<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel(neverShowAgain.checked);" /></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="step2Shop" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Shop")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span1">2</span> <%=Translate.JsTranslate("of")%> <span id="Span2">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>
            
            <div class="row row-pad content">
                <%= Translate.JsTranslate("A ""shop"" is located at the top level of your eCommerce structure where it acts a logical container for product groups and products. In this step you will need to define the shop for your solution.")%>
                <br />
                <br />
	            <fieldset id="shopNew">
			        <p><%=Translate.JsTranslate("Enter the shop name")%></p>
	                <div id="errshopName"  style="color: Red;"></div>
		            <input type="text" id="shopName" runat="server" />
                </fieldset>
                <input type="hidden" id="shopID" runat="server" />
            </div>
            
            <div class="row row-pad footer">
                <div class="col-1">
                    <div class="pager">
                        <ul>
                            <li><input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step1Introduction');" /></li>
                            <li><input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="if(ValidateShop()) showStep('step3Language');" /></li>
                            <li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="step3Language" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Language")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span3">3</span> <%=Translate.JsTranslate("of")%> <span id="Span4">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>
            <div class="row row-pad content">
                <%= Translate.JsTranslate("A ""language"" allows you to control language specific settings for products, product groups and much more. In this step you will need to define the default language for your solution.")%>
                <br />
                <br />
	            <fieldset id="langNew">
			        <p><%=Translate.JsTranslate("Enter the language name")%></p>
	                
		            <input type="text" id="languageName" runat="server" />
                    <div id="errlanguageName"  style="color: Red;"></div>

                    <p><%=Translate.JsTranslate("Select country code")%></p>
                    <asp:DropDownList ID="languageCode2" runat="server" ></asp:DropDownList>
                </fieldset>
                <input type="hidden" id="languageID" runat="server" />
            </div>
            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step2Shop');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="if(ValidateLang()) showStep('step4Currency');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>
       
        <div id="step4Currency" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Currency")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span5">4</span> <%=Translate.JsTranslate("of")%> <span id="Span6">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>
            
            <div class="row row-pad content">
                <%= Translate.JsTranslate("A ""currency"" lets you manage various currency attributes, which relates to countries you do business with. In this step you will need to define the currency for your solution, which includes setting the currency rate as well as the correct currency code.")%>
                <br />
                <br />
	            <fieldset id="currencyNew">
			        <p><%=Translate.JsTranslate("Enter currency name")%></p>
		            <input type="text" id="currencyName" runat="server" />
                    <div id="errcurrencyName"  style="color: Red;"></div>
                    <p><%=Translate.JsTranslate("Enter currency rate")%></p>
		            <input type="text" id="currencyRate" runat="server" />
                    <div id="errcurrencyRate"  style="color: Red;"></div>
                    <p><%=Translate.JsTranslate("Enter currency symbol")%></p>
		            <input type="text" id="currencySymbol"  runat="server" />
                    <div id="errcurrencySymbol"  style="color: Red;"></div>
                    <p><%=Translate.JsTranslate("Select currency code")%></p>
                    <asp:DropDownList ID="currencyCode" runat="server"></asp:DropDownList>
                </fieldset>
                <input type="hidden" id="currencySymbolPlace" runat="server" />
            </div>
            
            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step3Language');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="if(ValidateCurrency()) showStep('step5Country');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>
        
        <div id="step5Country" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Country")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span7">5</span> <%=Translate.JsTranslate("of")%> <span id="Span8">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>
            
            <div class="row row-pad content">
                <%= Translate.JsTranslate("A ""country"" lets you manage various attributes related to countries you do business with. In this step you will need to define the default country for your solution which includes setting the correct country code.")%>
                <br />
                <br />
	            <fieldset id="countryNew">
			        <p><%= Translate.JsTranslate("Enter country name")%></p>
		            <input type="text" id="countryName" runat="server" />
                    <div id="errcountryName"  style="color: Red;"></div>
                    <p><%= Translate.JsTranslate("Select country code")%></p>
                    <asp:DropDownList ID="countryCode" runat="server"></asp:DropDownList>
                </fieldset>
            </div>
            
            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step4Currency');" /></li>
                			<li>                    
                                <%  If Dynamicweb.Base.HasAccess("eCom_CartV2") Then%>
                                    <%  If Dynamicweb.Base.HasAccess("eCom_Payment") Then%>
                                        <input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="if(ValidateCountry()) showStep('step6Payment');" />        
                                    <%  Else%> 
                                        <input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="if(ValidateCountry()) showStep('step7Shipment');" />        
                                    <%  End If%>
                                <%  Else%>                       
                                    <input type="button" value="<%=Translate.JsTranslate("Save")%>" onclick="if(ValidateCountry()) save();" />        
                                <%  End If%>
                			</li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>
        
        <div id="step6Payment" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Payment")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span9">6</span> <%=Translate.JsTranslate("of")%> <span id="Span10">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>

            <div class="row row-pad content">
                <%= Translate.JsTranslate("This step allows to set up a method of payment for your Ecommerce. The wizard only support the basic functions of each gateway. For advanced setup use the Management Center.")%>
                <br />
                <br />
                <fieldset><legend class="gbTitle"><%= Translate.Translate("Method")%></legend>
                    <div class="space-bottom">
                        <table width="100%" cellspacing="2" cellpadding="2" border="0">
                            <tr>
                                <td>
                                    <label for="paymentName"><%= Translate.JsTranslate("Name")%></label>
                                </td>
                                <td>
                                    <input id="paymentName" type="text" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="paymentDescription"><%= Translate.JsTranslate("Description")%></label>
                                </td>
                                <td>
                                    <input id="paymentDescription" type="text" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="paymentFee"><%= Translate.JsTranslate("Fee")%></label>
                                </td>
                                <td>
                                    <input id="paymentFee" type="text" value="0.00" runat="server" />
                                    <input id="paymentFeeTypeVal" name="paymentFeeType" value="0" type="radio" checked="checked" />
                                    <label for="paymentFeeTypeVal"><%= Translate.JsTranslate("$")%></label>
                                    <input id="paymentFeeTypeProc" name="paymentFeeType" value="1" type="radio" />
                                    <label for="paymentFeeTypeProc"><%= Translate.JsTranslate("%")%></label>                           
                                </td>
                            </tr>
                        </table>   
                    </div>                 
                </fieldset>
                <br />
				<asp:Panel runat="server" ID="CheckoutPanel">
					<de:AddInSelector  
						runat="server" 
						ID="CheckoutAddin" 
						AddInGroupName="Checkout Handler" 
						AddInTypeName="Dynamicweb.eCommerce.Cart.CheckoutHandler"
						/>
				</asp:Panel>              
	            <asp:Literal runat="server" ID="paymentLoadScript"></asp:Literal>   
            </div>
           
            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step5Country');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Next")%>" onclick="showStep('step7Shipment');" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>

        <div id="step7Shipment" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-4">
                    <h1><%= Translate.Translate("Delivery")%></h1>
                </div>
                <div class="col-1-2">
                    <div class="pager-status text-center">
                        <%=Translate.JsTranslate("Page")%>
                        <span id="Span11">7</span> <%=Translate.JsTranslate("of")%> <span id="Span12">8</span>  
                    </div>
                </div>
                <div class="col-1-4">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>

            <div class="row row-pad content">
                <%= Translate.JsTranslate("This step sets up a delivery option. Only flat fees are support. For full weight/volume matrix setup use the Management Center.")%>
                <br /><br />  
                <fieldset><legend class="gbTitle"><%= Translate.Translate("Method")%></legend>
                    <div class="space-bottom">                
                        <table width="100%" cellspacing="2" cellpadding="2" border="0">
                            <tr>
                                <td>
                                    <label for="shipmentName"><%= Translate.JsTranslate("Name")%></label>
                                </td>
                                <td>
                                    <input id="shipmentName" type="text" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="shipmentDescription"><%= Translate.JsTranslate("Description")%></label>
                                </td>
                                <td>
                                    <input id="shipmentDescription" type="text" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="shipmentFee"><%= Translate.JsTranslate("Default fee")%></label>
                                </td>
                                <td>
                                    <input id="shipmentFee" type="text" value="0.00" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="shipmentFreeFee"><%= Translate.JsTranslate("No fee for purchases over")%></label>
                                </td>
                                <td>
                                    <input id="shipmentFreeFee" type="text" value="0.00" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
			    <br />
				<asp:Panel runat="server" ID="ServicePanel">
					<de:AddInSelector  
						runat="server" 
						ID="ServiceAddin" 
						AddInGroupName="Shipping Provider" 
						AddInTypeName="Dynamicweb.eCommerce.Cart.ShippingProvider"
						/>
				</asp:Panel>

	            <asp:Literal runat="server" ID="shipmentLoadScript"></asp:Literal>                  
                
            </div>

            <div class="row row-pad footer">

                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li>
                                <%  If Dynamicweb.Base.HasAccess("eCom_Payment") Then %>
                                    <input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step6Payment');" />
                                <%  Else%>
                                    <input type="button" value="<%=Translate.JsTranslate("Previous")%>" onclick="showStep('step5Country');" />
                                <%  End If %>
                			</li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Save")%>" onclick="save();" /></li>
                			<li><input type="button" value="<%=Translate.JsTranslate("Cancel")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
        </div>

        <div id="PAGEEXECUTE" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-2">
                    <h1><%= Translate.JsTranslate("Guide is setting up eCommerce")%></h1>
                </div>
                <div class="col-1-2">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>

		    <div class="row row-pad content">
                <%= Translate.JsTranslate("The guide is now finisned and the eCommerce is now being setup.")%>	
                        
                <div class="subContent" id="RequestAjax"></div>
    	    </div>  

            <div class="row row-pad footer">
            </div>
	    </div>  	      
	            
        <div id="PAGEFINISH" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-2">
                    <h1><%= Translate.JsTranslate("Guide is now finished")%></h1>
                </div>
                <div class="col-1-2">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>

		    <div class="row row-pad content">
                <%= Translate.JsTranslate("You can now use your eCommerce.")%><br />
                <%= Translate.JsTranslate("This guide will not appear again. If you need to change your settings please use the Management Center to edit settings.")%><br /><br />
                <%= Translate.JsTranslate("Advanced features such as variants and product categories must be set up in the Management Center.")%><br />
                <%= Translate.JsTranslate("Remember to go the websites / frontpage module and select the language, country and currency you have set up for the appropriate website")%>
    	    </div>  

            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Close")%>" onclick="closeWizard();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
	    </div>  		            
	            
        <div id="PAGEERROR" style="display: none;">
            <div class="row row-pad header">
                <div class="col-1-2">
                    <h1><%= Translate.JsTranslate("An error has accord in the eCommece Guide")%></h1>
                </div>
                <div class="col-1-2">
                    <a class="pull-right icon" href="#" onclick="help();"><img src="/Admin/Images/Ribbon/Icons/Help.png" alt="<%=Translate.JsTranslate("Help")%>" title="<%=Translate.JsTranslate("Help")%>" class="icon" /></a>
                </div>  
            </div>

		    <div class="row row-pad content">
                <%= Translate.JsTranslate("The guide will restart in 10 sec.")%>
    	    </div>  
            <div class="row row-pad footer">
                <div class="col-1">
                	<div class="pager">
                		<ul>
                			<li><input type="button" value="<%=Translate.JsTranslate("Close")%>" onclick="cancel();" /></li>
                		</ul>
                	</div>
                </div>
            </div>
	    </div>  	
    </form>

	<script type="text/javascript">
	    addMinLengthRestriction('shopName', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    addMinLengthRestriction('languageName', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    addMinLengthRestriction('currencyName', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    addValueNonNegativeOrZeroRestriction('currencyRate', '<%=Translate.JsTranslate("Exchange rate must be larger than 0.")%>');
	    addMinLengthRestriction('currencySymbol', 1, '<%=Translate.JsTranslate("Please enter a currency symbol")%>');
	    addMinLengthRestriction('countryName', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    //activateValidation('setupWizardForm');
    </script>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
