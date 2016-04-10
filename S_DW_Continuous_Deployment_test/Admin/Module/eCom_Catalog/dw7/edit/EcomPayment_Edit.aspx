<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomPayment_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomPayment_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
			
		<style type="text/css">
            BODY.margin
            {
                margin: 0px;
            }
            input, select, textarea
            {
                font-size: 11px;
                font-family: verdana,arial;
            }
            .Tab1Div, .Tab2Div, .Tab3Div {}
            
            #DWRowHeadLine
            {
                background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;
                height: 20px;
            }
            .OutlookHeaderStart
            {
                font: 11px Verdana, Helvetica, Arial, Tahoma;
                border-bottom: 0px !important;
                font-weight: normal;
                padding-left: 5px;
            }
            .OutlookHeader
            {
                font: 11px Verdana, Helvetica, Arial, Tahoma;
                border-bottom: 0px !important;
                font-weight: normal;
                border-left: 2px outset white;
                padding-left: 5px;
            }
            .addInConfigurationTable input, .addInConfigurationTable select
            {
                margin-left: 6px;
            }
        </style>
		
		
		<script type="text/javascript" language="JavaScript" src="../images/functions.js"></script>
		<script type="text/javascript" language="JavaScript" src="../images/addrows.js"></script>
		<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
		
	    <script type="text/javascript">
		    strHelpTopic = 'ecom.controlpanel.payment.edit';
		    function TabHelpTopic(tabName) {
			    switch(tabName) {
				    case 'GENERAL':
					    strHelpTopic = 'ecom.controlpanel.payment.edit.general';
					    break;
				    case 'FEES':
					    strHelpTopic = 'ecom.controlpanel.payment.edit.fees';
					    break;
				    case 'COUNTYFEES':
					    strHelpTopic = 'ecom.controlpanel.payment.edit.countryfees';
					    break
				    default:
					    strHelpTopic = 'ecom.controlpanel.payment.edit';
			    }
		    }
	    </script>
	    
	    <%=cAddInControl1.Jscripts%>
	    
	    <!--should after cAddInControl1-->
	    <script type="text/javascript" language="JavaScript" src="../images/AjaxAddInParameters.js"></script>
			
		<script type="text/javascript">
		    $(document).observe('dom:loaded', function () {
		        window.focus(); // for ie8-ie9 
		        document.getElementById('NameStr').focus();
		        onBeforeUpdateSelection = "onChangeCheckouthandler()";
		        onChangeCheckouthandler();
		    }); 

		    function AddNewFee(methodType, methodId, methodCountryId) {
		        var rowCnt = document.getElementById("FEE_ROWCOUNTER" + methodCountryId);
		        var feeCnt = document.getElementById("FEE_LINECOUNTER" + methodCountryId);

		        var newRowCnt = parseInt(rowCnt.value) + 1;
		        var newFeeCnt = parseInt(feeCnt.value) + 1;

		        getFeeRowResult(methodType, methodId, methodCountryId, newRowCnt, newFeeCnt);
		    }

		    function DeleteFeeRow(divId, feeId) {
		        if (!confirm('<%=Translate.JsTranslate("Slet?")%>')) {
		            return;
		        }
		        
		        if (feeId != "") {
		            deleteFeeRowInDB(feeId, divId);
		        }
		        else if (divId != null && divId.length > 0) {
		            doDeleteFeeRow(divId);
		        }
		    }

		    function savePayment(close) {
		        document.getElementById("Close").value = close ? 1 : 0;
		        document.getElementById('Form1').SaveButton.click();
		    }

		    function SwapAddInTypePanel(radio) {
		        var isCheckout = radio.id == 'AddInTypeRadioCheckout'
		        var isGateway = radio.id == 'AddInTypeRadioGateway'
		        document.getElementById('CheckoutPanel').style.display = isCheckout ? 'block' : 'none';
		        document.getElementById('GatewayPanel').style.display = isGateway ? 'block' : 'none';

		        //HACK: Two AddinSelectors can't be on the same page when posting. When hidding a selector also delete the divs!
		        if (!isGateway) {
		            var gatewayDropDown = document.getElementById('Dynamicweb.eCommerce.Orders.Gateways.GatewayProvider_AddInTypes');
		            gatewayDropDown.selectedIndex = 0;
		            gatewayDropDown.onchange();
		        }
		        if (!isCheckout) {
		            var checkoutDropdown = document.getElementById('Dynamicweb.Ecom7.Cart.CheckoutHandler_AddInTypes');
		            checkoutDropdown.selectedIndex = 0;
		            checkoutDropdown.onchange();
		        }
		    }

		    function onChangeCheckouthandler() {
		        if ('<%=isActions %>' == 'True' && $F("Dynamicweb.eCommerce.Cart.CheckoutHandler_AddInTypes") == '<%=checkouthandlerType %>') {
		            $('panelActions').show();
		        }
		        else {
		            $('panelActions').hide();
		        }
		    }

		    function executeAction(action, callback) {
		        var payID = '<%=payId %>';
		        if (!payID || !action) return;

		        new Ajax.Request('EcomPayment_Edit.aspx', {
		            parameters: {
		                AJAX: "ExecuteAction",
		                action: action,
		                payID: payID
		            },
		            onCreate: function () {
		                $('loadingDiv').show();
		            },
		            onSuccess: function (transport) {
		                if (!!callback) {
		                    callback(transport);
		                }
		            },
		            onFailure: function () { alert('Something went wrong...'); },
		            onComplete: function () { $('loadingDiv').hide(); }
		        });
		    }

		</script>
	
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
		<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server">
			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
				<tr>
					<td valign="top">
						<div id="Tab1">
							<br />
							
								<table border="0" cellpadding="0" cellspacing="0" width='95%' style='WIDTH:95%'>
									<tr>
										<td>
											<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Metode")%></legend>
												<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
													<tr>
														<td>
															<table border="0" cellpadding="2" cellspacing="2" width="100%">
																<tr>
																	<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
																	<td>
					                                                    <div id="errNameStr" name="errNameStr" style="color: Red;"></div>
					                                                    <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
					                                                </td>
																</tr>
																<tr>
																	<td width="170"><dw:TranslateLabel id="tLabelDescription" runat="server" Text="Beskrivelse"></dw:TranslateLabel></td>
																	<td>
					                                                    <div id="errDescriptionStr" name="errDescriptionStr" style="color: Red;"></div>
					                                                    <asp:textbox id="DescriptionStr" CssClass="NewUIinput" TextMode="MultiLine" Rows="5" runat="server"></asp:textbox>
					                                                </td>
																</tr>
																<tr>
																	<td width="170"><dw:TranslateLabel id="tLabelIcon" runat="server" Text="Ikon"></dw:TranslateLabel></td>
																	<td><dw:FileArchive runat="server" CssClass="NewUIinput" id="IconStr"></dw:FileArchive></td>
																</tr>



																<tr>
																	<td width="170"><dw:TranslateLabel id="tLabelIconOrder" runat="server" Text="Ikon (orderliste)"></dw:TranslateLabel></td>
																	<td><dw:FileArchive runat="server" CssClass="NewUIinput" id="IconOrder"></dw:FileArchive></td>
																</tr>

															</table>
														</td>
													</tr>
												</table>
											</fieldset>																
													
											<asp:Panel runat="server" ID="AddInTypeRadioPanel">
											    
											    <br />
											    <dw:GroupBox runat="server" Title="Cart type" DoTranslation="true">
											
											        <input type="radio" runat="server" id="AddInTypeRadioNone" name="AddInTypeRadios" onclick="javascript:SwapAddInTypePanel(this);"/>
											        <label for="AddInTypeRadioNone"><dw:TranslateLabel runat="server" Text="None" /></label>
											        <br />

											        <input type="radio" runat="server" id="AddInTypeRadioCheckout" name="AddInTypeRadios" onclick="javascript:SwapAddInTypePanel(this);"/>
											        <label for="AddInTypeRadioCheckout"><dw:TranslateLabel runat="server" Text="Checkout Handler (Shopping Cart v2)" /></label>
											        <br />
        
											        <input type="radio" runat="server" id="AddInTypeRadioGateway" name="AddInTypeRadios" onclick="javascript:SwapAddInTypePanel(this);"/>
                                                    <%If AddInTypeRadioGateway.Disabled Then%>
											        <label for="AddInTypeRadioGateway" disabled><dw:TranslateLabel runat="server" Text="Gateway (Shopping Cart v1)" /></label>
                                                    <%Else%>
                                                    <label for="AddInTypeRadioGateway"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Gateway (Shopping Cart v1)" /></label>
    											    <%End If%>
											    </dw:GroupBox>
											</asp:Panel>
											
											<asp:Panel runat="server" ID="CheckoutPanel">
											    <br />
											    <de:AddInSelector 
											        runat="server" 
											        ID="CheckoutAddin" 
											        AddInGroupName="Checkout Handler" 
											        AddInTypeName="Dynamicweb.eCommerce.Cart.CheckoutHandler"
											     />
											</asp:Panel>
	                                        
	                                        <asp:Panel runat="server" ID="GatewayPanel">
											    <br />	
											    <de:AddInSelector 
											        runat="server" 
											        ID="cAddInControl1" 
											        AddInGroupName="Gateway" 
											        AddInTypeName="Dynamicweb.eCommerce.Orders.Gateways.GatewayProvider"
											    />
	                                        </asp:Panel>
	                                        
	                                        <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>   
                                            <div id="panelActions" style="display:none" >                                                                     
											<br />
                                            <fieldset style='width: 100%; margin: 5px;'>
                                            <legend class="gbTitle"><%=Translate.Translate("Actions")%>&nbsp;</legend>
                                                <div runat="server" id="panelActionButtons"></div>
                                                <div id="loadingDiv" style="display: none;"><img src='/Admin/Module/eCom_Catalog/images/ajaxloading_trans.gif' style='margin:5px;padding:5px;' /></div>
                                            </fieldset>
                                            </div>
                                            <br />
                                            <br />
										</td>
									</tr>
								</table>
								<br />
							
							<asp:Button id="SaveButton" style="DISPLAY:none" runat="server"></asp:Button>
							<asp:Button id="DeleteButton" style="DISPLAY:none" runat="server"></asp:Button>
                            <input id="Close" type="hidden" name="Close" value="0" />
						</div>
						<div id="Tab2" class="Tab2Div" style="DISPLAY:none">
							<asp:Literal id="feeList" runat="server"></asp:Literal>
						</div>
						<div id="Tab3" class="Tab3Div" style="DISPLAY:none">
                            <asp:Literal id="countryRelList" runat="server"></asp:Literal>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>
		<iframe frameborder="1" name="EcomUpdator" id="EcomUpdator" width="1" height="1" align="right" marginwidth="0" marginheight="0" border="0" src="EcomUpdator.aspx"></iframe>

        
    	<script type="text/javascript">
            addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
            activateValidation('Form1');
        </script>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</HTML>
