<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="eCom_economic_edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_economic_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
    <script language="javascript" type="text/javascript" src="/Admin/Content/JsLib/dw/Ajax.js"></script>
    
    <style type="text/css">
        .disabledSelect { background-color: transparent; color: #C3C3C3; opacity: 0.4; }
    </style>

    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            $("selectList_orderlayouts").name = "/Globalsettings/Ecom/EconomicIntegration/Ordering/DebitorOrderLayout";
            $("selectList_paymentconditions").name = "/Globalsettings/Ecom/EconomicIntegration/Ordering/Paymentcondition";
            $("selectList_debitorgroup").name = "/Globalsettings/Ecom/EconomicIntegration/Ordering/DebitorGroup";

            page.submit();
        }

        function checkConnection() {
            $("economic_settings_box").show();

            Toolbar.setButtonIsDisabled('check_economic_connection', true);
            Toolbar.setButtonIsDisabled('cmdSave', true);
            Toolbar.setButtonIsDisabled('cmdSaveAndClose', true);
            Toolbar.setButtonIsDisabled('cmdCancel', true);
            Toolbar.setButtonIsDisabled('cmdHelp', true);
           
            $('selectList_orderlayouts').addClassName('disabledSelect');
            $('selectList_paymentconditions').addClassName('disabledSelect');
            $('selectList_debitorgroup').addClassName('disabledSelect');
            
            authenticate();
        }

        function authenticate() {
            var msg = "<%=Dynamicweb.eCommerce.Common.eCom7.Gui.AlertMessageBox(Translate.Translate("Please wait..."), "100%", "", "/Admin/Images/Progress/wait.gif")%>";
            var ok = "<%=Dynamicweb.eCommerce.Common.eCom7.Gui.AlertMessageBox(Translate.Translate("Connection successful"), "100%", "", "/Admin/Images/Rating/star.png")%>";
            var err = "<%=Dynamicweb.eCommerce.Common.Gui.AlertMessageBox(Translate.Translate("Could not connect"), "100%")%>";

            $("e_credential_msg").update(msg);

            var solutionNumber = $('/Globalsettings/Ecom/EconomicIntegration/Credentials/SolutionNumber').value;
            var username = $('/Globalsettings/Ecom/EconomicIntegration/Credentials/Username').value;
            var password = $('/Globalsettings/Ecom/EconomicIntegration/Credentials/Password').value;
            var encrypt = $('/Globalsettings/Ecom/EconomicIntegration/Credentials/PasswordEncrypted').value;

            new Ajax.Request('ecom_economic_edit.aspx?ajax=authentication&s=' + solutionNumber + '&u=' + username +'&p=' + password + '&e=' + encrypt, {
                method: 'get',
                onComplete: function(transport) {
                    if (200 == transport.status) {
                        Toolbar.setButtonIsDisabled('check_economic_connection', false);
                        Toolbar.setButtonIsDisabled('cmdSave', false);
                        Toolbar.setButtonIsDisabled('cmdSaveAndClose', false);
                        Toolbar.setButtonIsDisabled('cmdCancel', false);
                        Toolbar.setButtonIsDisabled('cmdHelp', false);
                    }
                },
                onSuccess: function(transport){
                    if (transport.responseText == "1") {

                        loadData("orderlayouts");
                        loadData("paymentconditions");
                        loadData("debitorgroup");

                        loadData("productgroups");

                        $("e_credential_msg").update(ok);
                    } else {
                        $("e_credential_msg").update(err);
                        $("economic_settings_box").hide();
                    }
                },
                onFailure: function(){ $("e_credential_msg").update(err); $("economic_settings_box").hide(); Toolbar.setButtonIsDisabled('check_economic_connection', false); }
            });

        }

        //get json
        function loadData(method, param) {
            if (method == "orderlayouts" || method == "paymentconditions" || method == "debitorgroup") {
                
                $('wait_' + method).visible();
                Dynamicweb.Ajax.getObject('ecom_economic_edit.aspx?ajax=' + method, {
                    onComplete: function (json) {
                    
                        for (var field in json) {
                            if (typeof(json[field]) != "function") {
                                var selectList = $('selectList_' + method);
                                AddSelectOption(selectList, json[field].Text, json[field].Value, json[field].Selected);
                            }
                        }

                        //Remove wait and enable controls
                        $('wait_' + method).hide();

                        if (method == "orderlayouts") { $('selectList_orderlayouts').removeClassName('disabledSelect'); }
                        if (method == "paymentconditions") { $('selectList_paymentconditions').removeClassName('disabledSelect'); }
                        if (method == "debitorgroup") { $('selectList_debitorgroup').removeClassName('disabledSelect'); }
                    
                    }
                });
            } else if (method == "productgroups") {
                $('wait_e_product_groups').show();
                var request = 'ecom_economic_edit.aspx?ajax=productgroups';
                if (param)
                    request += '&pageNumber=' + param;
                new Ajax.Request(request, {
                    method: 'get',
                    onComplete: function(transport) {
                        if (200 == transport.status) {
                            $('wait_e_product_groups').hide();
                        }
                    },
                    onSuccess: function(transport){
                        if (transport.responseText != "") {
                            $("e_product_groups").update(transport.responseText);
                        }
                    }
                });
            }
        }

        function AddSelectOption(selectObj, text, value, isSelected) 
        {
            if (selectObj != null && selectObj.options != null)
            {
                selectObj.options[selectObj.options.length] = 
                    new Option(text, value, false, isSelected);
            }
        }

        //Used for dw:List paging
        if (typeof __doPostBack == 'undefined') {
            __doPostBack = function (eventTarget, eventArgument) {                
                if (eventArgument && eventArgument.indexOf("PageIndexChanged:") == 0)
                    loadData("productgroups", eventArgument.replace("PageIndexChanged:", ""));
            };
        }
    </script>
</asp:Content>



<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		    <tr>
			    <td valign="top">

                    <dw:GroupBoxStart ID="GroupBoxStart1" runat="server" Title="Credentials" />
				        <table border="0" cellpadding="2" cellspacing="0" width="100%" style="table-layout: fixed">
                            <tr>
                                <td width="170">
                                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Solution number" />
                                </td>
                                <td>
                                    <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Credentials/SolutionNumber")%>" name="/Globalsettings/Ecom/EconomicIntegration/Credentials/SolutionNumber" id="/Globalsettings/Ecom/EconomicIntegration/Credentials/SolutionNumber" />
                                </td>
                            </tr>

                            <tr>
                                <td width="170">
                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Username" />
                                </td>
                                <td>
                                    <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Credentials/Username")%>" name="/Globalsettings/Ecom/EconomicIntegration/Credentials/Username" id="/Globalsettings/Ecom/EconomicIntegration/Credentials/Username" />
                                </td>
                            </tr>

                            <tr>
                                <td width="170">
                                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Password" />
                                </td>
                                <td>
                                    <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Credentials/Password")%>" name="/Globalsettings/Ecom/EconomicIntegration/Credentials/Password" id="/Globalsettings/Ecom/EconomicIntegration/Credentials/Password" />
                                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Credentials/PasswordEncrypted") = "True", "checked", "")%> id="/Globalsettings/Ecom/EconomicIntegration/Credentials/PasswordEncrypted" name="/Globalsettings/Ecom/EconomicIntegration/Credentials/PasswordEncrypted"><label for="/Globalsettings/Ecom/EconomicIntegration/Credentials/PasswordEncrypted"><%=Translate.Translate("Encrypt password")%></label>
                                </td>
                            </tr>
				       </table>
				    <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />

                    <div id="e_credential_msg" style="padding:2px 5px 2px 5px; height:50px;"></div>

                    <div id="economic_settings_box" style="display:none;">
                        <dw:GroupBoxStart ID="GroupBoxStart3" runat="server" Title="Order settings" />
				            <table border="0" cellpadding="2" cellspacing="0" width="100%" style="table-layout: fixed">
                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Complete order" />
                                    </td>
                                    <td>
                                        <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Ordering/ExportOrderOnComplete") = "True", "checked", "")%> id="Checkbox1" name="/Globalsettings/Ecom/EconomicIntegration/Ordering/ExportOrderOnComplete"><label for="/Globalsettings/Ecom/EconomicIntegration/Ordering/ExportOrderOnComplete"><%= Translate.Translate("Export to economic on complete")%></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Order number prefix" />
                                    </td>
                                    <td>
                                        <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Ordering/OrderNumberPrefix")%>" name="/Globalsettings/Ecom/EconomicIntegration/Ordering/OrderNumberPrefix" id="/Globalsettings/Ecom/EconomicIntegration/Ordering/OrderNumberPrefix" />
                                    </td>
                                </tr>

                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Fee product number" />
                                    </td>
                                    <td>
                                        <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Ordering/FeeProductNumber")%>" name="/Globalsettings/Ecom/EconomicIntegration/Ordering/FeeProductNumber" id="/Globalsettings/Ecom/EconomicIntegration/Ordering/FeeProductNumber" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Discount product number" />
                                    </td>
                                    <td>
                                        <input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Ecom/EconomicIntegration/Ordering/DiscountProductNumber")%>" name="/Globalsettings/Ecom/EconomicIntegration/Ordering/DiscountProductNumber" id="/Globalsettings/Ecom/EconomicIntegration/Ordering/DiscountProductNumber" />
                                    </td>
                                </tr>

                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Invoice Layout" />
                                    </td>
                                    <td>
                                        <select name="selectList_orderlayouts" id="selectList_orderlayouts" class="std"><option value=""><%=Translate.Translate("None")%></option></select>
                                        <img src="/Admin/Images/Progress/wait.gif" id="wait_orderlayouts" style="height:14px; width:14px;" />
                                    </td>
                                </tr>

                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Payment Condition" />
                                    </td>
                                    <td>
                                        <select name="selectList_paymentconditions" id="selectList_paymentconditions" class="std"><option value=""><%= Translate.Translate("None")%></option></select>
                                        <img src="/Admin/Images/Progress/wait.gif" id="wait_paymentconditions" style="height:14px; width:14px;" />
                                    </td>
                                </tr>

                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Debitor Group" />
                                    </td>
                                    <td>
                                        <select name="selectList_debitorgroup" id="selectList_debitorgroup" class="std"><option value=""><%= Translate.Translate("None")%></option></select>
                                        <img src="/Admin/Images/Progress/wait.gif" id="wait_debitorgroup" style="height:14px; width:14px;" />
                                    </td>
                                </tr>

				           </table>
				        <dw:GroupBoxEnd ID="GroupBoxEnd3" runat="server" />

                        <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="Product Groups" />
				            <table border="0" cellpadding="2" cellspacing="0" width="100%" style="table-layout: fixed">
                                <tr>
                                    <td width="170" colspan="2">
                                        <div id="wait_e_product_groups">
                                            <!--img src="/Admin/Images/Progress/wait.gif" id="Img1" style="height:14px; width:14px;" /-->
                                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Loading groups, please wait..." />
                                        </div>
                                        <div id="e_product_groups" style="min-height:100px;"></div>                                        
                                    </td>
                                </tr>
				           </table>
				        <dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />

                    </div>

			    </td>
		    <tr>
        </table>

    </div>

   	<%
		Translate.GetEditOnlineScript()
	%>

    <asp:Literal ID="LoaderJavaScript" runat="server" />

    <div id="hidden_List_div"" style="display:none;"><dw:List ID="hidden_List" runat="server" /></div>    
</asp:Content>

