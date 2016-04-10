<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="EcomTrackAndTrace_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomTrackAndTrace_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>

    	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		<script type="text/javascript" src="/Admin/FormValidation.js"></script>

        <script type="text/javascript">

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('NameStr').focus();
            }); 

            function showUsage() {
                dialog.show("UsageDialog");
            }
            
            function checkUsage() {
                if (<%= UsageCount %> > 0 ) {
                    alert('<%= Translate.JsTranslate("Cannot delete this track & trace as it is used in %% orders.", "%%", UsageOrders) %>');
                }
                else {
                    if (confirm('<%= Translate.JsTranslate("Do you want to delete this track & trace?") %>')) {
                        document.getElementById('Form1').DeleteButton.click(); 
                    }
                }
            }

            //  Delete row
            function delParameter(link) {
                var row = dwGrid_PropertiesGrid.findContainingRow(link);
                if (row) {
                    if (confirm('<%= Translate.JsTranslate("Do you want to delete this parameter?") %>')) {
                        dwGrid_PropertiesGrid.deleteRows([row]);
                    }
                }
            }
            function saveTrackAndTrace(close) {
		        document.getElementById("Close").value = close ? 1 : 0;
		        document.getElementById('Form1').SaveButton.click();
            }
        </script>


    </head>

    <body>
	    <asp:Literal id="BoxStart" runat="server"></asp:Literal>
        <form id="Form1" runat="server">
            <input id="Close" type="hidden" name="Close" value="0" />
		    <asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
		    <table border="0" cellpadding="2" cellspacing="2" width='95%' style='width:95%; background-color: #FFFFFF;'>
			    <tr>
				    <td>
					    <fieldset style='width: 100%; margin: 5px;'>
                            <legend class="gbTitle"><%= Translate.Translate("Track & trace")%></legend>
						    <table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%'>
							    <tr>
								    <td>
									    <table border="0" cellpadding="2" cellspacing="2" width="100%">
										    <tr>
											    <td width="100"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
											    <td>
				                                    <div id="errNameStr" style="color: Red;"></div>
				                                    <asp:textbox width="170" id="NameStr" CssClass="NewUIinput" runat="server" />
				                                </td>
										    </tr>
										    <tr>
											    <td width="100"><dw:TranslateLabel id="tLabelURL" runat="server" Text="URL schema" /></td>
											    <td>
                                                    <div id="errURLStr" style="color: Red;"></div>
				                                    <asp:textbox width="800" id="URLStr" CssClass="NewUIinput" runat="server" />
				                                </td>
										    </tr>
                                            <tr>
                                                <td colspan="2"><%= Translate.Translate("Example URL:")%>&nbsp;http://www.YourTrackAndTraceService.com?First={0}&Next={1}&Last={2}</td>
                                            </tr>
									    </table>
								    </td>
							    </tr>
						    </table>
					    </fieldset>
					    <fieldset style='width: 100%; margin: 5px;'>
                            <legend class="gbTitle"><%= Translate.Translate("Parameters")%></legend>
						    <table border="0" cellpadding="2" cellspacing="2" width='600'>
							    <tr>
								    <td>
                                        <div id="errPropertiesGrid" runat="server" style="color: Red;"></div>
                                        <div style="border: 1px solid #6593cf">
                                        <dw:EditableGrid runat="server" ID="PropertiesGrid" ClientIDMode="AutoID" AllowAddingRows="True">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="Name" Text="" CssClass="NewUIinput" style="margin-left: 5px;" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="DefaultValue" Text="" CssClass="NewUIinput" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="Description" Text="" CssClass="NewUIinput" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="20px">
                                                    <ItemTemplate>
                                                        <span class="option-field-offset">
                                                            <a href="javascript:void(0);" onclick="javascript:delParameter(this);">
                                                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" title="<%= Translate.Translate("Delete")%>" border="0" />
                                                            </a>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </dw:EditableGrid>
                                        </div>
								    </td>
							    </tr>
						    </table>
					    </fieldset>
				    </td>
			    </tr>
		    </table>
		    <br />

    	    <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
		    <asp:Button id="DeleteButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>

            <dw:Dialog runat="server" ID="UsageDialog" AllowDrag="true" OkAction="dialog.hide('UsageDialog');" ShowCancelButton="false" ShowClose="false" ShowOkButton="true" Title="Usage" TranslateTitle="true">
                <div>
                    <asp:Literal runat="server" ID="UsageContent" />
                </div>
            </dw:Dialog>

            <dw:Dialog runat="server" ID="DeleteDialog" AllowDrag="true" OkAction="dialog.hide('DeleteDialog');" ShowCancelButton="false" ShowClose="false" ShowOkButton="true" Title="Cannot delete" TranslateTitle="true">
                <div>
                    <asp:Literal runat="server" ID="DeleteContent" />
                </div>
            </dw:Dialog>
        </form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	    <script type="text/javascript">
	        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	        addMinLengthRestriction('URLStr', 1, '<%=Translate.JsTranslate("A URL schema is needed")%>');
	        activateValidation('Form1');
        </script>

		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
