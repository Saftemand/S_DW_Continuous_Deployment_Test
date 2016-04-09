<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="EcomField_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomFieldEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ecom" TagName="FieldOptionsList" Src="~/Admin/Module/eCom_Catalog/dw7/controls/FieldOptionsList/FieldOptionsList.ascx" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
        <title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
		
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		<script type="text/javascript" src="/Admin/FormValidation.js"></script>

		<style type="text/css">
		    BODY.margin { MARGIN: 0px }
		    INPUT { FONT-SIZE: 11px; FONT-FAMILY: verdana,arial }
		    SELECT { FONT-SIZE: 11px; FONT-FAMILY: verdana,arial }
		    TEXTAREA { FONT-SIZE: 11px; FONT-FAMILY: verdana,arial }
        
            /* Styles for "Display as" drop-down list */

            .p-row, .p-row tbody, .p-row tr { width: 290px; }
            .p-row { padding-top: 2px; padding-bottom: 2px; table-layout: fixed; }
            .p-title { font-weight: bold; padding-bottom: 2px; }
            .p-icon { width: 30px; height: 30px; padding-right: 5px; padding-left: 2px; vertical-align: top; border: none; }
            .p-row td.p-icon-cell { width: 37px; }
            .p-row td.p-description-cell, .p-row td.p-description-cell div { width: 245px; white-space: normal; }

            /* End: styles for "Display as" drop-down list */

		</style>

        <!-- IE-specific styles to align drop-down lists with other fields -->

        <!--[if gt IE 6]>
        <style type="text/css">
            a.dropDown
            {
                width: 252px !important;
            }
        </style>
        <![endif]-->

        <!-- End: IE-specific styles to align drop-down lists with other fields -->

		<script type="text/javascript">
            var listTypeID = <%=ListTypeID %>;

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('NameStr').focus();
            });

	        function checkfield(field){
		        var result		= true;
		        var fieldTmp	= field.toLowerCase();
                var validChars 	= "0123456789abcdefghijklmnopqrstuvwxyz";

                for (var i = 0; i < fieldTmp.length; i++) {
			        if (validChars.indexOf(fieldTmp.charAt(i)) == -1) {
				        result = false;
			        }
                }
        
                return result;
            }

            function ddTypes_selectedIndexChanged(sender, args) {
                var input = null;
                var displayStyleValue = '';

                if(args.item) {
                    input = args.item.select('input');
                    if(input != null && input.length > 0) {
                        displayStyleValue = parseInt(input[0].value) == listTypeID ? '' : 'none';

                        $$('tr.row-presentation-type')[0].setStyle({display: displayStyleValue});
                        $$('tr.row-options')[0].setStyle({display: displayStyleValue});

                        if(displayStyleValue.length == 0) {
                            setTimeout(function() {
                                TemplatedDropDownList.createInstance('ddPresentations').initializeInstance(true);
                            }, 50);
                        }
                    }
                }
            }

            function ddPresentations_dataExchange(sender, args) {
                if(args.dataSource && args.dataDestination) {
                    args.dataDestination.innerHTML = $(args.dataSource).select('.p-title')[0].innerHTML;
                }
            }

            function save(close) {
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }

            var deleteMsg = '<%= DeleteMessage %>';
		    function deleteProductField() {
                <%If FieldType = Admin.eComBackend.EcomFieldEdit.RequestFieldType.Products Then %>
		            if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click(); 
		        <% Else%>
		            document.getElementById('Form1').DeleteButton.click();
		        <% End If%>
            }
		</script>
	</head>
	<body style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
		<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server">
            <input id="Close" type="hidden" name="Close" value="0" />
			<asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
            <asp:Literal ID="NoFieldsExistsForLanguageBlock" runat="server"></asp:Literal>
			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="background: none; background-color: #ffffff" id="DW_Ecom_tableTab">
				<tr>
					<td valign="top">
						<div id="Tab1">
							<br />
							
							<table border="0" cellpadding="2" cellspacing="2" width='95%' style='WIDTH:95%'>
								<tr>
									<td>
										<fieldset style='MARGIN: 0px; padding: 0px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
											<table border="0" cellpadding="2" cellspacing="2" width='100%' style='WIDTH:100%'>
												<tr>
													<td>
														<table border="0" cellpadding="2" cellspacing="2" width="100%">
															<tr>
																<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
																<td>
				                                                    <div id="errNameStr" style="color: Red;"></div>
				                                                    <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server" />
				                                                </td>
															</tr>
															<tr>
																<td width="170"><dw:TranslateLabel id="tLabelSystemName" runat="server" Text="Systemnavn" /></td>
																<td>
				                                                    <div id="errSystemNameStr" style="color: Red;"></div>
				                                                    <asp:textbox id="SystemNameStr" CssClass="NewUIinput" runat="server" />
				                                                </td>
															</tr>
															<tr>
																<td width="170"><dw:TranslateLabel id="tLabelTemplatName" runat="server" Text="Template tag" /></td>
																<td>
				                                                    <div id="errTemplateNameStr" style="color: Red;"></div>
				                                                    <asp:textbox id="TemplateNameStr" CssClass="NewUIinput" runat="server" />
				                                                </td>
															</tr>
															<tr>
																<td width="170" valign="top"><dw:TranslateLabel id="tLabelType" runat="server" Text="Felttype" /></td>
                                                                <td valign="top">
                                                                    <dw:TemplatedDropDownList ID="ddTypes" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="150" 
                                                                        OnClientSelectedIndexChanged="ddTypes_selectedIndexChanged" runat="server">
                                                                        <ItemTemplate>
                                                                            <%# Eval("Title")%>
                                                                            <input type="hidden" value="<%#Eval("Value") %>" />
                                                                        </ItemTemplate>
                                                                    </dw:TemplatedDropDownList>
                                                                </td>
															</tr>
															<tr  id="requiredRow" runat="server">
																<td width="170" valign="top"><dw:TranslateLabel id="ValidationLabel" runat="server" Text="Validation" /></td>
                                                                <td valign="top">
                                                                    <dw:CheckBox runat="server" ID="ValidationRequiredCheckBox" />
                                                                    <dw:TranslateLabel id="RequiredCheckBoxLabel" runat="server" Text="Required" />
                                                                </td>
															</tr>
															<tr style="display:none;">
																<td width="170"><dw:TranslateLabel id="tLabelLocked" runat="server" Text="Lås felt" /></td>
																<td><asp:CheckBox id="Locked" runat="server"></asp:CheckBox></td>
															</tr>
                                                            <tr id="rowPresentationType" class="row-presentation-type" style="display:none" runat="server">
                                                                <td valign="top">
                                                                    <dw:TranslateLabel ID="lbDisplayAs" Text="Visning_som" runat="server" />
                                                                </td>
                                                                <td valign="top">
                                                                    <dw:TemplatedDropDownList ID="ddPresentations" Width="250" ExpandableAreaWidth="300" ExpandableAreaHeight="150" 
                                                                            OnClientDataExchange="ddPresentations_dataExchange" runat="server">
                                                                        <BoxTemplate>
                                                                            <%# Eval("Title")%>
                                                                        </BoxTemplate>
                                                                        <ItemTemplate>
                                                                            <table class="p-row" cellspacing="0" cellpadding="0" border="0">
                                                                                <tr>
                                                                                    <td class="p-icon-cell" valign="top">
                                                                                        <img class="p-icon" src="<%#System.Web.HttpUtility.HtmlAttributeEncode(Eval("Icon"))%>" alt="" />
                                                                                    </td>
                                                                                    <td class="p-description-cell" valign="top">
                                                                                        <div class="p-title"><%#Eval("Title")%></div>
                                                                                        <div class="p-description"><%#Eval("Description")%></div>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </dw:TemplatedDropDownList>
                                                                </td>
                                                            </tr>
														</table>
													</td>
												</tr>
											</table>
										</fieldset>
										<br />
									</td>
								</tr>
                                <tr id="rowOptions" class="row-options" style="display: none" runat="server">
                                    <td>
                                        <fieldset style='MARGIN: 0px; padding: 0px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Options")%></legend>
											<table border="0" cellpadding="4" cellspacing="4" width='100%' style='WIDTH:100%'>
												<tr>
													<td>
                                                        <ecom:FieldOptionsList ID="optionsList" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
							</table>
							<br />
							
							<asp:Button id="SaveButton" style="DISPLAY:none" runat="server"></asp:Button>
							<asp:Button id="DeleteButton" style="DISPLAY:none" runat="server"></asp:Button>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	<script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        addMinLengthRestriction('SystemNameStr', 1, '<%=Translate.JsTranslate("A system name is needed")%>');
        addMinLengthRestriction('TemplateNameStr', 1, '<%=Translate.JsTranslate("A templatetag-name is needed")%>');
	    activateValidation('Form1');
    </script>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>
