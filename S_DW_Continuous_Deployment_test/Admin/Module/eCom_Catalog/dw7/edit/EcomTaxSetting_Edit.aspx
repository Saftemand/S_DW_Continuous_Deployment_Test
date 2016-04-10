<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomTaxSetting_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomTaxSetting_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		<script type="text/javascript" src="../images/functions.js"></script>
		<script type="text/javascript" src="../images/addrows.js"></script>
        <%= TaxProviderAddin.Jscripts%>
		<script type="text/javascript" src="../images/AjaxAddInParameters.js"></script>
        <script type="text/javascript" src="/Admin/Extensibility/JavaScripts/ProductsAndGroupsSelector.js"></script>
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>

        <script type="text/javascript">

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('NameStr').focus(); 
            });

            function deleteTax() {
                if (confirm('<%= Translate.JsTranslate("Do you want to delete this setting?") %>')) {
                    document.getElementById('Form1').DeleteButton.click();
                }
            }

            function save(close) {
                if (!verifyCountryRelations())
                    return;

                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }

            function verifyCountryRelations() {
                var countryBoxes = $$("input:checkbox[name='CR_CountryRel']"); // $$("input#CR_CountryRel");

                var result = false;
                for (var i = 0; i < countryBoxes.length; i++) {
                    if (countryBoxes[i].checked) {
                        result = true;
                        break;
                    }
                }

                if (!result) {
                    alert('<%= Translate.JsTranslate("No country relation is set. Please select at least 1 country.") %>');
                    // TODO: Switch to country tab
                    Tabs.tab(2);
                }

                return result;
            }

            function isReadyForTest() {
                var msg = '<%= Translate.JsTranslate("Do you want to continue? All unsaved data will be lost.") %>'
                if (confirm(msg)){
                    $('loadingDiv').show();
                    return true;
                }
                else return false;
            }

        </script>

</head>
<body>
    <asp:Literal ID="BoxStart" runat="server" />
    <form id="Form1" method="post" runat="server">
        <dw:TabHeader runat="server" ID="Tabs"></dw:TabHeader>
        <div id="Tab1">
            <div>
                <br />
                <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%;'>
                    <tr>
                        <td>
                            <fieldset style='width: 100%; margin: 5px;'>
                                <legend class="gbTitle"><%=Translate.Translate("Indstillinger")%>&nbsp;</legend>
                                <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <tr>
                                                    <td width="170">
                                                        <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn" />
                                                    </td>
                                                    <td>
                                                        <div id="errNameStr" style="color: Red;">
                                                        </div>
                                                        <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="170">
                                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Active" />
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="ActiveChk" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <br />
                            <asp:Panel runat="server" ID="ConfigurableTaxProviders">
							    <br />
                                <div id="err<%=TaxProviderAddin.AddInTypeName %>_AddInTypes" style="color: Red;width: 100%; margin: 5px;"></div>
                                <de:AddInSelector 
								    runat="server" 
								    ID="TaxProviderAddin" 
                                    useNewUI="true" 
                                    AddInShowNothingSelected="false" 
								    AddInGroupName="Configurable tax Provider" 
								    AddInTypeName="Dynamicweb.eCommerce.Products.Taxes.TaxProvider"
								    />
                            </asp:Panel>

                            <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>  
                            <br />
                            <fieldset style='width: 100%; margin: 5px;'>
                            <legend class="gbTitle"><%=Translate.Translate("Test connection")%>&nbsp;</legend>
                                <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                    <tr>
                                        <td>
                                            <asp:Button ID="TestConnectionButton" CssClass="button" OnClientClick="return isReadyForTest();" runat="server" Enabled="false" />
                                            <div id="loadingDiv" style="display: none;"><img src='/Admin/Module/eCom_Catalog/images/ajaxloading_trans.gif' style='margin:5px;padding:5px;' /></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Literal runat="server" ID="TestResult"></asp:Literal>  
                                        </td>                                        
                                    </tr>
                                </table>
                            </fieldset>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
                <br />
            </div>
        </div>             
            
        <div id="Tab2" style="display: none;">
            <asp:Literal runat="server" ID="CountryRelations" />
        </div>

        <asp:Button ID="SaveButton" Style="display: none;" runat="server" />
        <asp:Button ID="DeleteButton" Style="display: none;" runat="server" />
        <input type="hidden" name="Close" id="Close" value="0" />
    </form>
    <asp:Literal ID="BoxEnd" runat="server" />

	<script type="text/javascript">
	    addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    addMinLengthRestriction('<%=TaxProviderAddin.AddInTypeName %>_AddInTypes', 1, '<%=Translate.JsTranslate("Tax provider is needed")%>');
	    activateValidation('Form1');
    </script>

	<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

</body>
</html>
