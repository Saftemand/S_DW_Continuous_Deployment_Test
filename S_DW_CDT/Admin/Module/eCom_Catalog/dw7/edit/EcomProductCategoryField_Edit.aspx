<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="EcomProductCategoryField_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomProductCategoryField_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ecom" TagName="FieldOptionsList" Src="~/Admin/Module/eCom_Catalog/dw7/controls/FieldOptionsList/FieldOptionsList.ascx" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
		
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />

		<style type="text/css">
		    body.margin { margin: 0px }
		    input { font-size: 11px; font-family: verdana,arial }
		    select { font-size: 11px; font-family: verdana,arial }
		    textarea { font-size: 11px; font-family: verdana,arial }
        
            /* Styles for "Display as" drop-down list */

            .p-row, .p-row tbody, .p-row tr { width: 290px; }
            .p-row { padding-top: 2px; padding-bottom: 2px; table-layout: fixed; }
            .p-title { font-weight: bold; padding-bottom: 2px; }
            .p-icon { width: 30px; height: 30px; padding-right: 5px; padding-left: 2px; vertical-align: top; border: none; }
            .p-row td.p-icon-cell { width: 37px; }
            .p-row td.p-description-cell, .p-row td.p-description-cell div { width: 245px; white-space: normal; }

            /* End: styles for "Display as" drop-down list */
		</style>

		<script type="text/javascript">
            var listTypeID = <%= ListTypeID %>;
            var checkBoxTypeID = <%= CheckBoxTypeID %>;

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('NameStr').focus();
            });

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

                        displayStyleValue = parseInt(input[0].value) == checkBoxTypeID ? '' : 'none';
                        $$('tr.row-checkbox')[0].setStyle({display: displayStyleValue});
                    }
                }
            }

            function ddPresentations_dataExchange(sender, args) {
                if(args.dataSource && args.dataDestination) {
                    args.dataDestination.innerHTML = $(args.dataSource).select('.p-title')[0].innerHTML;
                }
            }

		</script>

</head>
<body>
    <form id="fieldForm" runat="server">
		<table border="0">
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
                                                        <input type="hidden" id="ddTypeValue" value="<%#Eval("Value") %>" />
                                                    </ItemTemplate>
                                                </dw:TemplatedDropDownList>
                                            </td>
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
                                        <tr id="rowCheckbox" class="row-checkbox" style="display: none" runat="server">
                                            <td valign="top"><dw:TranslateLabel id="lblCheckBoxDefault" runat="server" Text="Default value" /></td>
										    <td valign="top"><asp:CheckBox id="chkDefaultValue" runat="server"></asp:CheckBox></td>
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
                        <div id="errFieldOptions" style="color: Red;"></div>
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
    </form>

		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
