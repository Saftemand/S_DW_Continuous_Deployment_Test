<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="LicenseConfiguration_cpl.aspx.vb" Inherits="Dynamicweb.Admin.LicenseConfiguration_cpl" EnableEventValidation="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
     <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>

    <style type="text/css">

        select:disabled{
            background-color: lightgray;
        }

    </style>

    <script type="text/javascript">
        var prevLicenseName = "";
        function save(cmd) {
            var confirmMsg = "<%=Translate.JsTranslate("Your changes will now be saved. After re-login your solution will be configured as you have selected and an invoice will be sent to you - for any questions please contant your sales representative.")%>";
            if (confirm(confirmMsg)) {
                $('cmdSave').value = cmd;
                $('form1').submit();
            } else {
                return false;
            }
        }

        function cancel() {
            window.location = "/Admin/Content/Management/Start.aspx";
        }

        function onChangeLicense(radio) {
            var licenseName = radio.value;

            if (licenseName == "Professional") {
                $("UpgradeProducts").disabled = false;
            } else {
                $("UpgradeProducts").disabled = true;
                $("UpgradeProducts").checked = false;
            }

            var select = document.getElementById("drEmailMarketingSubscribers");
            if (select.selectedIndex == 0 && (licenseName == "Free" || licenseName == "Express")) {
                select.options[select.selectedIndex].value = "250";
            } else if (select.selectedIndex == 0) {
                select.options[select.selectedIndex].value = "500";
            }

            if (licenseName == "Free" || licenseName == "Express" || licenseName == "Standard") {
                $("PersonalizationLicense").checked = false;
                $("PersonalizationLicense").disabled = true;
                $("drAdditionalWebsites").disabled = false;
                $("drExtraShops").disabled = true;
                $("drIntegrationFW").disabled = true;
                $("drExtraShops").value = "0";
                $("drIntegrationFW").value = "0";
            } else if (licenseName == "Professional" || licenseName == "Premium" || licenseName == "Corporate") {
                $("PersonalizationLicense").disabled = false;
                if (prevLicenseName != "Professional" && prevLicenseName != "Premium" && prevLicenseName != "Corporate") {
                    $("PersonalizationLicense").checked = false;
                }
                $("drAdditionalWebsites").disabled = true;
                $("drExtraShops").disabled = false;
                $("drIntegrationFW").disabled = false;
            } else if (licenseName == "Enterprise") {
                $("PersonalizationLicense").disabled = true;
                $("PersonalizationLicense").checked = true;
                $("drAdditionalWebsites").disabled = true;
                $("drExtraShops").disabled = true;
                $("drIntegrationFW").disabled = false;
            }

            prevLicenseName = licenseName;
        }

        document.observe('dom:loaded', function () {
            var licenses = document.getElementsByName('LicenseSelect');
            for(var i = 0; i < licenses.length; i++){
                if (licenses[i].checked == true) {
                    prevLicenseName = licenses[i].value;
                    onChangeLicense(licenses[i]);
                    break;
                }
            }
        });
    </script>
</head>

<body style="overflow:auto;">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
	    <dw:ToolbarButton runat="server" Text="Save" Image="Save" OnClientClick="return save('cmdSave');" ID="btnSave" ShowWait="true" />
        <dw:ToolbarButton runat="server" Text="Save And Close" Image="SaveAndClose" OnClientClick="return save('cmdSaveAndClose');" ID="btnSaveAndClose" ShowWait="true" />
	    <dw:ToolbarButton runat="server" Text="Cancel" Image="Cancel" OnClientClick="cancel();" ID="btnCancel" ShowWait="true" />
    </dw:Toolbar>
    <h2 class="subtitle"><%= Translate.Translate("License configuration")%></h2>
    <form id="form1" runat="server">
        <input type="hidden" id="cmdSave" name="cmdSave" value="" />
        <div id="content" style="overflow:auto;">
             <dw:GroupBox ID="gbLicense" runat="server" Title="License">
               <table  Width="600" style="border:1px solid #BDCCE0; border-collapse:collapse;">
                   <tr>
                       <td>
                           <dw:List ID="lstLicense" ShowPaging="false" NoItemsMessage="" ShowTitle="false" ShowCollapseButton="false" runat="server">
                                <Columns>
                                    <dw:ListColumn ID="colNames" Name="" Width="250" runat="server" TranslateName="false" />
                                    <dw:ListColumn ID="colFree" Name="Free" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                    <dw:ListColumn ID="colExpress" Name="Express" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                    <dw:ListColumn ID="colStandard" Name="Standard" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />                                    
                                    <dw:ListColumn ID="colProfessional" Name="Professional" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                    <dw:ListColumn ID="colPremium" Name="Premium" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                    <dw:ListColumn ID="colCorporate" Name="Corporate" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                    <dw:ListColumn ID="colEnterprise" Name="Enterprise" Width="100" runat="server" HeaderAlign="Center" ItemAlign="Center" TranslateName="false" />
                                </Columns>
                            </dw:List>
                       </td>
                   </tr>
               </table>
            </dw:GroupBox>

             <dw:GroupBox ID="gbAddOns" runat="server" Title="Add-ons">
                <table border="0" cellpadding="2" cellspacing="0">
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel6" Text="Additional websites/languages" runat="server" />
                        </td>
                        <td>
                           <asp:DropDownList runat="server" ID="drAdditionalWebsites" CssClass="std" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="lbExtraShops" Text="Extra Ecommerce shops" runat="server" />
                        </td>
                        <td>
                           <asp:DropDownList runat="server" ID="drExtraShops" CssClass="std" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel1" Text="Integration Framwork license" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="drIntegrationFW" CssClass="std" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel5" Text="Personalization license" runat="server" />
                        </td>
                        <td>
                            <dw:CheckBox ID="chkPersonalizationLicense" FieldName="PersonalizationLicense" runat="server" ClientIDMode="Static"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel2" Text="Upgrade to 5.000 products" runat="server" />
                        </td>
                        <td>
                            <dw:CheckBox ID="chkUpgradeProducts" FieldName="UpgradeProducts" runat="server" ClientIDMode="Static"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel3" Text="Email Marketing subscribers" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="drEmailMarketingSubscribers" CssClass="std" ClientIDMode="Static"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel4" Text="Currently in DB:" runat="server" />
                        </td>
                        <td>
                            <asp:Literal id="emailAllowedUsersCount" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                           <dw:TranslateLabel ID="TranslateLabel7" Text="Staging/Test license" runat="server" />
                        </td>
                        <td>
                            <dw:CheckBox ID="chkStagingTestLicense" FieldName="StagingTestLicense" runat="server" ClientIDMode="Static"/>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
         </div>
    </form> 
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html> 
