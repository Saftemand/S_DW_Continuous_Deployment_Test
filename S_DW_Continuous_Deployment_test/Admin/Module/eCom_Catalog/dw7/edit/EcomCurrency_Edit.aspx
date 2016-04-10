<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomCurrency_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomCurrency_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name=vs_defaultClientScript content="JavaScript" />
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
	<style type="text/css">
	    BODY.margin { MARGIN: 0px }
	    input,select,textarea {font-size: 11px; font-family: verdana,arial;}
	</style>		

	<script type="text/javascript">

	    $(document).observe('dom:loaded', function () {
	        window.focus(); // for ie8-ie9 
	        $('NameStr').focus();
	        var regionInfo = $('RegionalInfo');
	        if (!regionInfo.disabled) {
	            regionInfo.onchange = onChangeCultureInfo;
	            regionInfo.onchange();
	        }
	    }); 

	    function SaveCurrency(close) {
		    var save = false;
    		
		    var field;
		    if (document.getElementById('Form1').IsDefaultStr) {
			    field = document.getElementById('Form1').IsDefaultStr;
		    } else {
			    if (document.getElementById('Form1').IsDefaultTmp) {
				    field = document.getElementById('Form1').IsDefaultTmp;
			    }	
		    }	

		    if (field.checked) {
			    var txt =  '<%=Translate.JsTranslate("Du har valgt et denne valuta er standard.\nDette vil slå igennem på alle sprog!")%>';
			    if (confirm(txt)) {		
				    save = true;
			    }	   
		    } else {
			    save = true;
		    }
    			
		    if (save) {
		        document.getElementById('Close').value = close ? 1 : 0;
		        document.getElementById('Form1').SaveButton.click();
		    }	
	    }

	    function onChangeCultureInfo() {
	        var info = this.options[this.selectedIndex].value;
	        if (!!info) {
	            $('fieldsetSettings').disabled = true;
	            $('fieldsetRegionalSettings').disabled = false;

	            var url = "/Admin/Module/eCom_Catalog/dw7/edit/EcomCurrency_Edit.aspx?AJAX=LoadCultureInfo";
	            new Ajax.Request(url, {
	                parameters: {
	                    CultureInfo: info
	                },
	                onSuccess: function (transport) {
	                    if (transport && transport.responseJSON ){
	                        var json = transport.responseJSON;
	                        $('CurrencyCode').value = json.CurrencyCode;
	                        $('SymbolStr').value = json.CurrencySymbol;
	                        $('PayGatewayCodeStr').value = json.PaymentCode;

	                        var positiveOptions = $('<%= ddlCurrencyPositivePattern.ClientID%>').options;
	                        for (var i = 0; i < positiveOptions.length; i++) {
	                            if (positiveOptions[i].value == json.PositivePattern) {
	                                $('spanDefaultPositivePattern').innerHTML = positiveOptions[i].text;
	                            }
	                        }
	                        var negativeOptions = $('<%= ddlCurrencyNegativePattern.ClientID%>').options;
	                        for (var i = 0; i < negativeOptions.length; i++) {
	                            if (negativeOptions[i].value == json.NegativePattern) {
	                                $('spanDefaultNegativePattern').innerHTML = negativeOptions[i].text;
	                            }
	                        }
	                    }
	                    else {
	                        $('fieldsetSettings').disabled = false;
	                        $('fieldsetRegionalSettings').disabled = true;
	                        alert('This country is absent in [EcomGlobalISO]!');
	                    }
	                },
	                onFailure: function () {
	                    alert('Something went wrong!');
	                }
	            });
	        }
	        else {
	            $('fieldsetSettings').disabled = false;
	            $('fieldsetRegionalSettings').disabled = true;
            }
	    }
    	
	</script>
    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
    
  </head>
  <body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">

	<asp:Literal id="BoxStart" runat="server"></asp:Literal>

		<form id="Form1" method="post" runat="server">
			<input type="hidden" name="Close" id="Close" value="0" />
			
			<asp:Literal id="CurrencyExists" runat="server"></asp:Literal>
			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>

			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
			<tr>
			<td valign="top">
		
			<div id="Tab1">
				<br />

				<table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
				<tr><td>

				<fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Currency")%>&nbsp;</legend>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
					<td>
				        <div id="errNameStr" style="color: Red;"></div>
				        <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox>
				    </td>
					</tr>
					<tr>
                    <td width="170"><dw:TranslateLabel ID="tLabelCulture" runat="server" Text="Regional info" /></td>
                    <td>
                        <asp:DropDownList id="RegionalInfo" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
				    </td>
					</tr>				
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelRate" runat="server" Text="Valutakurs"></dw:TranslateLabel></td>
					<td>
				        <div id="errRateStr" style="color: Red;"></div>
					    <asp:textbox id="RateStr" CssClass="NewUIinput" runat="server"></asp:textbox>
					</td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelIsDefault" runat="server" Text="Default"></dw:TranslateLabel></td>
					<td><asp:CheckBox id="IsDefaultStr" runat="server"></asp:CheckBox><asp:CheckBox id="IsDefaultTmp" runat="server" disabled></asp:CheckBox></td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelRoundingID" runat="server"	Text="Afrunding"></dw:TranslateLabel></td>
					<td><asp:DropDownList id="RoundingIDStr" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
					</tr>	
					</table>
				</fieldset>
				</td></tr>
				<tr><td>
				<fieldset id="fieldsetRegionalSettings" style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Regional settings")%>&nbsp;</legend>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="170"><dw:TranslateLabel runat="server" Text="Positive pattern"></dw:TranslateLabel></td>
					<td>
				        <div id="errCurrencyPositivePattern" style="color: Red;"></div>
				        <asp:DropDownList id="ddlCurrencyPositivePattern" CssClass="NewUIinput" runat="server" ></asp:DropDownList>
                        <dw:TranslateLabel runat="server" Text="Regional default" />:&nbsp;<span id="spanDefaultPositivePattern"></span>
				    </td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel runat="server" Text="Negative pattern"></dw:TranslateLabel></td>
					<td>
				        <div id="errCurrencyNegativePattern" style="color: Red;"></div>
				        <asp:DropDownList id="ddlCurrencyNegativePattern" CssClass="NewUIinput" runat="server" ></asp:DropDownList>
                        <dw:TranslateLabel runat="server" Text="Regional default" />:&nbsp;<span id="spanDefaultNegativePattern"></span>
				    </td>
					</tr>
					</table>
				</fieldset>
				</td></tr>
				<tr><td>
				<fieldset id="fieldsetSettings" style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Settings")%>&nbsp;</legend>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCode" runat="server" Text="Valutakode"></dw:TranslateLabel></td>
					<td>
				        <div id="errCurrencyCode" style="color: Red;"></div>
				        <asp:DropDownList id="CurrencyCode" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelSymbol" runat="server" Text="Valutasymbol"></dw:TranslateLabel></td>
					<td>
				        <div id="errSymbolStr" style="color: Red;"></div>
				        <asp:textbox id="SymbolStr" CssClass="NewUIinput" runat="server" MaxLength="5"></asp:textbox>
				    </td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelSymbolPlace" runat="server" Text="Valutaformat"></dw:TranslateLabel></td>
					<td><asp:DropDownList id="SymbolPlace" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelPayGatewayCode" runat="server" Text="Betalingskode"></dw:TranslateLabel></td>
					<td>
				        <div id="errPayGatewayCodeStr" style="color: Red;"></div>
				        <asp:DropDownList id="PayGatewayCodeStr" CssClass="NewUIinput" runat="server" ></asp:DropDownList>
				    </td>
					</tr>
					</table>
				</fieldset><br /><br />

				</td></tr>
				</table>

				<br />	
							
				<asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
				<asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>
				
			</div>
			
			</td>
			</tr>
			</table>			


		</form>
	
	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	<asp:Literal id="removeDelete" runat="server"></asp:Literal>
	<script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        addMinLengthRestriction('CurrencyCode', 1, '<%=Translate.JsTranslate("A currency code has to be selected")%>');
        addMinLengthRestriction('SymbolStr', 1, '<%=Translate.JsTranslate("A symbol string is needed")%>');
        addMinLengthRestriction('PayGatewayCodeStr', 1, '<%=Translate.JsTranslate("A payment gateway country code has to be selected")%>');
        addValueNonNegativeOrZeroRestriction('RateStr', '<%=Translate.JsTranslate("Exchange rate must be larger than 0.")%>');
        activateValidation('Form1');
    </script>

  </body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>