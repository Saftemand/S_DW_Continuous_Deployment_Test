<%@ Page Language="vb" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" CodeBehind="eCom_CartV2_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_CartV2_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<input type="hidden" name="eCom_CartV2_settings" id="eCom_CartV2_settings" value="SelectedValidations,ValidationGroups,UseNewsletterSubscription,NewsletterSubscribers,EmptyCartRadio,EmptyCartRedirectPage,EmptyCartTemplate,OnReEnterRadio,CountryForShippingRadio,CountryForPaymentRadio,ShopSelector,CartSelector,CustomerAcceptedErrorMessage,DoValidateCustomerAccepted,RemoveNoneExistingProductsRadio,SetUserDetailsRadio,ImagePatternProductCatalog,SelectAllPayments,PaymetTypes,SelectAllDeliveries,DeliveryTypes,DoCreateUserInCheckout,CreateNewUserGroupsHidden,ErrorEmtyUsername,ErrorUsernameTaken,ErrorEmtyPassword,ErrorPasswordsNotMatch,ErrorPasswordLength,ErrorIllegalPasswordCharacters,DoValidateStockStatus,StockStatusErrorMessage,DoValidateInfoDirect,InfoDirectErrorMessage,CheckoutToQuote" />
<input type="hidden" runat="server" id="StepsJSON" value="[]" />
<input type="hidden" runat="server" id="MailsJSON" value="[]" />
<input type="hidden" runat="server" id="ValidationJSON" value="[]" />
<input type="hidden" runat="server" id="NewsletterCategoriesJSON" value="[]" />

<script type="text/javascript" src="/Admin/Module/eCom_CartV2/javascript/tablednd.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_CartV2/javascript/Step.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_CartV2/javascript/Mail.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_CartV2/javascript/Validation.js"></script>
       
<dw:ModuleHeader runat="server" ModuleSystemName="eCom_CartV2" />

<!-- Shop -->
<dw:GroupBox runat="server" Title="Settings" DoTranslation="true">
    <table>
        <tr>
            <td style="width:170px;">
                <dw:TranslateLabel runat="server" Text="Shop" />
            </td>
            <td>
                <select id="ShopSelector" name="ShopSelector" runat="server" size="1" class="std"></select>
            </td>
        </tr>
        <tr>
            <td style="width:170px;">
                <dw:TranslateLabel runat="server" Text="Context cart" />
            </td>
            <td>
                <select id="CartSelector" name="CartSelector" runat="server" size="1" class="std"></select>
            </td>
        </tr>
        <tr runat="server" id="StepQuoteRow">
            <td style="width:170px;"></td>
            <td style="white-space:nowrap;">
                <input type="checkbox" runat="server" id="CheckoutToQuote" name="CheckoutToQuote"/>
                <dw:TranslateLabel runat="server" Text="Checkout to quote" />
            </td>
        </tr>
    </table>

</dw:GroupBox>

<!-- Steps -->
<dw:GroupBox runat="server" Title="Steps" DoTranslation="true">
    <!-- table to show steps in -->
    <table id="StepsTable">
    </table>
    
    <!-- Add button -->
    <div style="margin:5px 5px 5px 5px;">
        <a onclick="addNewStep();" title="<%=Dynamicweb.Backend.Translate.JsTranslate("Add new step") %>" >
            <span 
                style="font-style:italic; color:Gray;" 
                onmouseover="this.style.textDecoration = 'underline';" 
                onmouseout="this.style.textDecoration = 'none';"
            >
                <img src="/Admin/Module/eCom_CartV2/images/notebook_add.png" alt="" style="vertical-align:top;" />
                <dw:TranslateLabel runat="server" Text="Add step" />
            </span>
        </a>
    </div>
</dw:GroupBox>

<!-- Emails -->
<dw:GroupBox runat="server" Title="Notification e-mails" DoTranslation="true">
    <!-- table to show emails in -->
    <table id="MailsTable">
    </table>

    <div style="height: 5px;" >&nbsp;</div>

    <!-- Add button -->
    <div style="margin:5px 5px 5px 5px;">
        <a onclick="addNewMail();" title="<%=Dynamicweb.Backend.Translate.JsTranslate("Add new notification e-mail") %>" >
            <span 
                style="font-style:italic; color:Gray;" 
                onmouseover="this.style.textDecoration = 'underline';" 
                onmouseout="this.style.textDecoration = 'none';"
            >
                <img src="/Admin/Module/eCom_CartV2/images/mail_add.png" alt="" style="vertical-align:top;" />
                <dw:TranslateLabel runat="server" Text="Add notification" />
            </span>
        </a>
    </div>
</dw:GroupBox>

<!-- Validations -->
<dw:GroupBox runat="server" Title="Field validation" DoTranslation="true">
    
    <table>
        <tr>
            <td style="width:170px;">
                <dw:TranslateLabel runat="server" Text="Customer acceptance" />
            </td>
            <td>
                <input type="checkbox" runat="server" id="DoValidateCustomerAccepted" />
                <label for="DoValidateCustomerAccepted"><dw:TranslateLabel runat="server" Text="Validate that customer has accepted" /></label>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Error message" />
            </td>
            <td>
                <input type="text" runat="server" id="CustomerAcceptedErrorMessage" size="60" />
            </td>
        </tr>
        <tr>
            <td>
                <label for="DoValidateStockStatus"><dw:TranslateLabel runat="server" Text="A check for stock status" /></label>
            </td>
            <td>
                <input type="checkbox" runat="server" id="DoValidateStockStatus" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Error message" />
            </td>
            <td>
                <input type="text" runat="server" id="StockStatusErrorMessage" size="60" />
            </td>
        </tr>
        <tr>
            <td>
                <label for="DoValidateInfoDirect"><dw:TranslateLabel runat="server" Text="Check for Info Direct" /></label>
            </td>
            <td>
                <input type="checkbox" runat="server" id="DoValidateInfoDirect" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Error message" />
            </td>
            <td>
                <input type="text" runat="server" id="InfoDirectErrorMessage" size="60" />
            </td>
        </tr>
    </table>
    
    <div style="height:5px;">&nbsp;</div>
    
    <div id="ValidationContainer">
        <span style="font-weight:bold;"><%=Dynamicweb.Backend.Translate.JsTranslate("Custom validation groups") %></span>
    </div>
    <select runat="server" id="ValidationGroupSelector" class="NewUIinput" style="vertical-align:middle;"></select>
    
    <button 
        onclick="var selector = document.getElementById('ValidationGroupSelector'); addNewValidationGroup(selector.value); selector.selectedIndex = 0; return false" 
        title="<%=Dynamicweb.Backend.Translate.JsTranslate("Add new validation group") %>"
        style="vertical-align:middle;"
    >
        <dw:TranslateLabel runat="server" Text="Add" />
    </button>
</dw:GroupBox>

<!-- Newsletter settings -->
<%  If Dynamicweb.Base.HasAccess("NewsLetterV3", "") OrElse Base.IsModuleInstalled("EmailMarketing") Then%>
<dw:GroupBox runat="server" Title="Newsletter" DoTranslation="true">
    
    <input runat="server" type="checkbox" id="UseNewsletterSubscription" value="True" />
    <label for="UseNewsletterSubscription">
        <%=Dynamicweb.Backend.Translate.JsTranslate(String.Format("Use {0} subscription", If(Base.IsModuleInstalled("EmailMarketing"), "email", "newsletter"))) %>
    </label>
    <% If Base.HasAccess("NewsLetterV3", "") Then%>
    <br />
    <br />
    
    <table>
        <tr>
            <td style="width:170px; vertical-align: top; font-weight:bold;">
                <dw:TranslateLabel runat="server" Text="Subscribed categories" />
            </td>
            <td>
                <asp:Literal runat="server" ID="NewsletterCategories" />
                
                <button 
                    onclick="addNewNewsletterCategory(); return false" 
                    title="<%=Dynamicweb.Backend.Translate.JsTranslate("Add new category") %>"
                    style="vertical-align:middle; margin-top:4px;"
                >
                    <dw:TranslateLabel runat="server" Text="Add category" />
                </button>
            </td>
        </tr>
    </table>
    <% End If%>
</dw:GroupBox>
<%End If%>

<!-- Empty cart settings -->
<dw:GroupBox runat="server" Title="Empty cart" DoTranslation="true">
    
    <table>
        <tr>
            <td style="width:170px; vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="When cart is empty" />
            </td>
            <td>
                <!-- Radios -->
                <input type="radio" runat="server" id="EmptyCartRadioRedirect" name="EmptyCartRadio" onclick="SwitchEmptyCartPanel(this);" />
                <label for="EmptyCartRadioRedirect"><dw:TranslateLabel runat="server" Text="Redirect to internal page" /></label>
                <br />
                
                <input type="radio" runat="server" id="EmptyCartRadioTemplate" name="EmptyCartRadio" onclick="SwitchEmptyCartPanel(this);" />
                <label for="EmptyCartRadioTemplate"><dw:TranslateLabel runat="server" text="Show template" /></label>
                <br />
                
                <input type="radio" runat="server" id="EmptyCartRadioNothing" name="EmptyCartRadio" onclick="SwitchEmptyCartPanel(this);" />
                <label for="EmptyCartRadioNothing"><dw:TranslateLabel runat="server" Text="Take no special action" /></label>
                <br />
                
                <!-- Setting for redirect -->
                <asp:Panel runat="server" id="EmptyCartPanelRedirect" style="display:none; margin:10px 10px 10px 10px;">
                    <table>
                        <tr>
                            <td>
                                <dw:TranslateLabel runat="server" Text="Redirect to internal page" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:LinkManager runat="server" id="EmptyCartRedirectPage" DisableFileArchive="true"></dw:LinkManager>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                
                <!-- Settings for template -->
                <asp:Panel runat="server" id="EmptyCartPanelTemplate" style="display:none; margin:10px 10px 10px 10px;">
                    <table>
                        <tr>
                            <td>
                                <dw:TranslateLabel runat="server" Text="Show template" />
                            </td>
                        </tr>
                        <tr>    
                            <td>
                                <dw:FileManager runat="server" id="EmptyCartTemplate" Folder="Templates/eCom7/CartV2/Step" FullPath="false" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                
                <script type="text/javascript">
                    function SwitchEmptyCartPanel(radio) {
                        document.getElementById("EmptyCartPanelRedirect").style.display = radio.id == 'EmptyCartRadioRedirect' ? 'block' : 'none'
                        document.getElementById("EmptyCartPanelTemplate").style.display = radio.id == 'EmptyCartRadioTemplate' ? 'block' : 'none'
                    }
                </script>            
            </td>
        </tr>
    </table>
    
    

    
</dw:GroupBox>

<!-- UserManagement -->
<asp:Panel runat="server" ID="UserManagementSettingsPanel">
    <dw:GroupBox runat="server" Title="UserManagement" DoTranslation="true">
        <table>
            <tr>
                <td style="width:170px;vertical-align:top;">
                    <dw:TranslateLabel runat="server" Text="Apply user details to order" />
                </td>
                <td>
                    <input type="radio" runat="server" id="SetUserDetailsRadioTrue" name="SetUserDetailsRadio" />
                    <label for="SetUserDetailsRadioTrue"><dw:TranslateLabel runat="server" Text="Enable" /></label>
                    <br />
                    
                    <input type="radio" runat="server" id="SetUserDetailsRadioFalse" name="SetUserDetailsRadio" />
                    <label for="SetUserDetailsRadioFalse"><dw:TranslateLabel runat="server" Text="Disable" /></label>
                    <br />
                </td>
            </tr>
            <%If Base.HasVersion("8.3.0.0") Then%>
            <tr>
                <td>
                    <label for="DoCreateUserInCheckout"><dw:TranslateLabel runat="server" Text="Create user in checkout" /></label>
                </td>
                <td style="padding-left:2px">
                    <input type="checkbox" runat="server" id="DoCreateUserInCheckout" onclick="Toggle_UserGroups();"/>
                </td>
            </tr>
            <%End If%>
            <tr id="CreateNewUserGroupsRow" style="vertical-align: top;">
                <td><dw:TranslateLabel runat="server" Text="Groups for new users" /></td>
                <td style="padding-left:5px"><dw:UserSelector runat="server" ID="CreateNewUserGroups" NoneSelectedText="No group selected" Show="Groups" HeightInRows="3"/></td>
            </tr>
        </table>
        <div id="ErrorMessagesDiv">
            <dw:GroupBox ID="GroupBox19" runat="server" Title="Error messages" DoTranslation="true">
            <div style="margin:10px 10px 10px 10px;">
                <table cellpadding="3">
                    <colgroup width="170px" />
                    <colgroup width="300px" />
                    <tr>
                        <td>
                        <label for="ErrorEmtyUsername"><dw:TranslateLabel runat="server" Text="Empty username" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorEmtyUsername" id="ErrorEmtyUsername" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="ErrorUsernameTaken"><dw:TranslateLabel runat="server" Text="Username is taken" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorUsernameTaken" id="ErrorUsernameTaken" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="ErrorEmtyPassword"><dw:TranslateLabel runat="server" Text="Empty password" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorEmtyPassword" id="ErrorEmtyPassword" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="ErrorPasswordsNotMatch"><dw:TranslateLabel runat="server" Text="Passwords do not match" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorPasswordsNotMatch" id="ErrorPasswordsNotMatch" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="ErrorPasswordLength"><dw:TranslateLabel runat="server" Text="Password length = 32" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorPasswordLength" id="ErrorPasswordLength" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="ErrorIllegalPasswordCharacters"><dw:TranslateLabel runat="server" Text="Illegal password characters" /></label>
                        </td>
                        <td>
                        <input type="text" class="std" runat="server" name="ErrorIllegalPasswordCharacters" id="ErrorIllegalPasswordCharacters" value="" />
                        </td>
                    </tr>                    
                </table>
            </div>
        </dw:GroupBox>
    </div>

    </dw:GroupBox>
</asp:Panel>

<!-- Payment & delivery -->
<dw:GroupBox ID="grpPaymentAndDelivery" runat="server" Title="Payment & delivery" DoTranslation="true">
    <table cellpadding="1" cellspacing="1" border="0">
        <tr>
            <td style="width:170px;vertical-align:top;font-weight:bold;">
                <dw:TranslateLabel runat="server" Text="Show" />
            </td>
            <td>
                <input type="radio" runat="server" id="PaymentRadioAll" name="PaymentSelectionType" onclick="Toggle_Payments();" />
                <label for="PaymentRadioAll"><dw:TranslateLabel runat="server" Text="All" /></label>
                <input type="radio" runat="server" id="PaymentRadioSelected" name="PaymentSelectionType" onclick="Toggle_Payments();" />
                <label for="PaymentRadioSelected"><dw:TranslateLabel runat="server" Text="Selected" /></label>
            </td>
        </tr>
        <tr id="PaymentsSelectorRow">
            <td colspan="2">
                <!-- Payment types -->
                <dw:SelectionBox ID="PaymentsSelector" runat="server" CssClass="std" />
                <input type="hidden" name="SelectAllPayments" id="SelectAllPayments" value="" runat="server" />
                <input type="hidden" name="PaymetTypes" id="PaymetTypes" value="" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td style="width:170px;vertical-align:top;font-weight:bold;">
                <dw:TranslateLabel runat="server" Text="Show" />
            </td>
            <td>
                <input type="radio" runat="server" id="DeliveryRadioAll" name="DeliverySelectionType" onclick="Toggle_Deliveries();" />
                <label for="DeliveryRadioAll"><dw:TranslateLabel runat="server" Text="All" /></label>
                <input type="radio" runat="server" id="DeliveryRadioSelected" name="DeliverySelectionType" onclick="Toggle_Deliveries();" />
                <label for="DeliveryRadioSelected"><dw:TranslateLabel runat="server" Text="Selected" /></label>
            </td>
        </tr>
        <tr id="DeliveriesSelectorRow">
            <td colspan="2">
                <!--  Delivery types -->
                <dw:SelectionBox ID="DeliveriesSelector" runat="server" CssClass="std" />
                <input type="hidden" name="SelectAllDeliveries" id="SelectAllDeliveries" value="" runat="server" />
                <input type="hidden" name="DeliveryTypes" id="DeliveryTypes" value="" runat="server" />
            </td>
        </tr>
    </table>
</dw:GroupBox>

<!-- Other settings -->
<dw:GroupBox runat="server" Title="Settings" DoTranslation="true">
    <table>
        <colgroup>
            <col style="width:170px;" />
            <col />
        </colgroup>
        
        <!-- On re-entering cart -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="When re-entering cart" />
            </td>
            <td>
                <input type="radio" runat="server" id="OnReEnterRadioFirstStep" name="OnReEnterRadio"/>
                <label for="OnReEnterRadioFirstStep"><dw:TranslateLabel runat="server" Text="Show first step" /></label>
                <br />
                
                <input type="radio" runat="server" id="OnReEnterRadioLastStepVisited" name="OnReEnterRadio" />
                <label for="OnReEnterRadioLastStepVisited"><dw:TranslateLabel runat="server" Text="Show last visited step" /></label>
                <br />
                <br />
                
            </td>
        </tr>
        
        <!-- Shipping method selection -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="Country for shipping method" />
            </td>
            <td>
                <input type="radio" runat="server" id="CountryForShippingRadioCustomer" name="CountryForShippingRadio" />
                <label for="CountryForShippingRadioCustomer"><dw:TranslateLabel runat="server" Text="Always use customer country" /></label>
                <br />
                
                <input type="radio" runat="server" id="CountryForShippingRadioDelivery" name="CountryForShippingRadio" />
                <label for="CountryForShippingRadioDelivery"><dw:TranslateLabel runat="server" Text="Always use delivery country" /></label>
                <br />
                
                <input type="radio" runat="server" id="CountryForShippingRadioBoth" name="CountryForShippingRadio" />
                <label for="CountryForShippingRadioBoth"><dw:TranslateLabel runat="server" Text="Use delivery country if delivery address is set" /></label>
                <br />
                <br />
            </td>
        </tr>
        
        <!-- Payment method selection -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="Country for payment method" />
            </td>
            <td>
                <input type="radio" runat="server" id="CountryForPaymentRadioCustomer" name="CountryForPaymentRadio" />
                <label for="CountryForPaymentRadioCustomer"><dw:TranslateLabel runat="server" Text="Always use customer country" /></label>
                <br />
                
                <input type="radio" runat="server" id="CountryForPaymentRadioDelivery" name="CountryForPaymentRadio" />
                <label for="CountryForPaymentRadioDelivery"><dw:TranslateLabel runat="server" Text="Always use delivery country" /></label>
                <br />
                
                <input type="radio" runat="server" id="CountryForPaymentRadioBoth" name="CountryForPaymentRadio" />
                <label for="CountryForPaymentRadioBoth"><dw:TranslateLabel runat="server" Text="Use delivery country if delivery address is set" /></label>
                <br />
                <br />
                
            </td>
        </tr>
        
        <!-- Unavailable products -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="Unavailable products" />
            </td>
            <td>
                <input type="radio" runat="server" id="RemoveNoneExistingProductsRadioTrue" name="RemoveNoneExistingProductsRadio" />
                <label for="RemoveNoneExistingProductsRadioTrue"><dw:TranslateLabel runat="server" Text="Remove" /></label>
                <br />
                
                <input type="radio" runat="server" id="RemoveNoneExistingProductsRadioFalse" name="RemoveNoneExistingProductsRadio" />
                <label for="RemoveNoneExistingProductsRadioFalse"><dw:TranslateLabel runat="server" Text="Ignore" /></label>
                <br />
            </td>
        </tr>

        <!-- Image pattern settings -->
        <tr>
            <td style="vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="Use image pattern settings from product catalog" />
            </td>
            <td>
                <dw:LinkManager runat="server" id="ImagePatternProductCatalog" EnablePageSelector="False" DisableFileArchive="True"></dw:LinkManager>
            </td>
        </tr>
        
    </table>
</dw:GroupBox>

<!-- Edit step dialog -->
<dw:Dialog runat="server" ID="EditStepDialog" Title="Edit step" TranslateTitle="true" ShowCancelButton="true" ShowOkButton="true" OkAction="saveStepEdit();">
    <input type="hidden" id="StepIndex" />
    <table>
        <colgroup>
            <col style="width:170px" />
            <col />
        </colgroup>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Name" />
            </td>
            <td>
                <input type="text" id="StepName" class="NewUIinput" />
            </td>
        </tr>
        <tr id="StepEditTemplateRow">
            <td>
                <dw:TranslateLabel runat="server" Text="Template" />
            </td>
            <td style="white-space:nowrap;">
                <dw:FileManager runat="server" id="StepTemplate" Folder="Templates/eCom7/CartV2/Step" FullPath="true" />
            </td>
        </tr>
    </table>
    <br /><br />
</dw:Dialog>

<!-- Edit mail dialog -->
<dw:Dialog runat="server" ID="EditMailDialog" Title="Edit e-mail" Width="420" TranslateTitle="true" ShowCancelButton="true" ShowOkButton="true" OkAction="saveMailEdit();">
    <input type="hidden" id="MailIndex" />
    <table>
        <colgroup>
            <col style="width:170px" />
            <col style="width:358px" />
        </colgroup>
        <tr>
            <td>
            </td>
            <td>
                <input type="checkbox" id="MailIsCustomer" onchange="document.getElementById('MailRecipient').disabled = this.checked;"/>
                <label for="MailIsCustomer"><dw:TranslateLabel runat="server" Text="For customer" /></label>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Recipient e-mail" />
            </td>
            <td>
                <input type="text" id="MailRecipient" class="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Subject" />
            </td>
            <td>
                <input type="text" id="MailSubject" class="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Template" />
            </td>
            <td style="white-space:nowrap;">
                <dw:FileManager runat="server" id="MailTemplate" Folder="Templates/eCom7/CartV2/Mail" FullPath="true" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Sender name" />
            </td>
            <td>
                <input type="text" id="MailSenderName" class="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Sender e-mail" />
            </td>
            <td>
                <input type="text" id="MailSenderEmail" class="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Encoding" />
            </td>
            <td>
                <select runat="server" id="MailEncoding" class="NewUIinput" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel runat="server" Text="Attachment" />
            </td>
            <td style="white-space:nowrap;">
                <dw:FileManager runat="server" id="MailAttachment" FullPath="false" />
            </td>
        </tr>
    </table>
    <br /><br />
</dw:Dialog>

<!-- Div containing the step values -->
<div id="HiddensSteps"></div>
<!-- Div containing the mail values -->
<div id="HiddensMails"></div>

<div id="RuleBox" style="display:none;">
    <dw:GroupBox runat="server" Title="Rules" DoTranslation="true">
        <span style="color:Gray;">
        </span>
    </dw:GroupBox>
</div>

<!-- Translated names -->
<div id="Translate_Unnamed" style="display:none;"><dw:TranslateLabel runat="server" Text="Unnamed" /></div>
<div id="Translate_Edit" style="display:none;"><dw:TranslateLabel runat="server" Text="Edit" /></div>
<div id="Translate_Delete" style="display:none;"><dw:TranslateLabel runat="server" Text="Delete" /></div>
<div id="Translate_Customer" style="display:none;"><dw:TranslateLabel runat="server" Text="Customer" /></div>
<div id="Translate_No_recipient" style="display:none;"><dw:TranslateLabel runat="server" Text="No recipient" /></div>
<div id="Translate_Please_select_a_validation_group" style="display:none;"><dw:TranslateLabel runat="server" Text="Please select a validation group" /></div>
<div id="Translate_The_selected_validation_group_is_already_added" style="display:none;"><dw:TranslateLabel runat="server" Text="The selected validation group is already added" /></div>
<div id="Translate_Field" style="display:none;"><dw:TranslateLabel runat="server" Text="Field" /></div>
<div id="Translate_ErrorMessage" style="display:none;"><dw:TranslateLabel runat="server" Text="Error message" /></div>
<div id="Translate_Remove" style="display:none;"><dw:TranslateLabel runat="server" Text="Remove" /></div>
<div id="Translate_Check_all_fields" style="display:none;"><dw:TranslateLabel runat="server" Text="Select all fields" /></div>


<script type="text/javascript">
    var hiddenSettingNames = new Object;
    hiddenSettingNames.Steps = new Array();
    hiddenSettingNames.Mails = new Array();

    function addHidden(settingName, name, value, excludeInSettings, excludeInHiddens) {
        // Add to hiddens
        if (!excludeInHiddens) {
            var hiddenDiv = document.getElementById('Hiddens' + settingName);
            var hidden = document.createElement('input');
            hidden.type = 'hidden';
            hidden.value = value;
            hidden.name = name;
            hiddenDiv.appendChild(hidden);
        }
        
        // Add to settings
        if (!excludeInSettings) {
            var settings = document.getElementById('eCom_CartV2_settings');
            settings.value = settings.value + (settings.value.toString().length > 0 ? ',' : '') + name;
            hiddenSettingNames[settingName].push(name);
        }
    }
    
    function clearHidden(settingName) {
        // Clear the hidden inputs
        if (document.getElementById('Hiddens' + settingName))
            document.getElementById('Hiddens' + settingName).innerHTML = '';
        
        // Remove previously inserted settings
        var settings = $('eCom_CartV2_settings');
        var settingsValues = settings.value.split(',');
        var newSettings = '';
        for (var j = 0; j < settingsValues.length; j++) {
            var found = false;
            for (var i = 0; i < hiddenSettingNames[settingName].length; i++) {
                if (hiddenSettingNames[settingName][i] == settingsValues[j]) {
                    found = true;
                    break;
                }
            }
            if (!found)
                newSettings += (newSettings.length > 0 ? ',' : '') + settingsValues[j];
        }
        settings.value = newSettings;
        hiddenSettingNames[settingName].length = 0;
    }
    
    function createImage(url, onclick, titleName) {
        var image = document.createElement('img');
        image.src = url;
        image.alt = '';
        image.onclick = new Function(onclick);
        image.width = 16;
        image.height = 16;
        image.style.cursor = 'pointer';
        image.title = document.getElementById('Translate_' + titleName).innerHTML;
        image.style.verticalAlign = 'top';
        return image;
    }

    function addNewNewsletterCategory() {
        window.open('/Admin/module/NewsLetterV3/CategorySelector.aspx?paragraph=true&SelectionRequired=False', 'catSelector', 'toolbar=0,menubar=0,resizable=0,scrollbars=0,height=400,width=300,directories=0,location=0');
    }

    function CartNewsletterSubcription() {
        var divId = "NewsletterCategories";
        var url = "/Admin/Module/eCom_Cart/GetNewsletterCategories.aspx?ajax=getCats&Time=" + (new Date()).getMilliseconds();

        $(divId).update('<img src=\'/Admin/Module/eCom_Catalog/images/ajaxloading.gif\' style=\'text-align:center;margin:5px;padding:5px;\' /> <span class=\'disableText\'><%=Dynamicweb.Backend.Translate.JsTranslate("Requesting content...")%></span>');

        new Ajax.Updater(divId, url, {
            asynchronous: true,
            evalScripts: false,
            method: 'get'

        });
    }

    
    // init
    steps = eval(document.getElementById('StepsJSON').value);
    mails = eval(document.getElementById('MailsJSON').value);
    updateSteps();
    updateMails();
    var validationGroupsToInsert = eval(document.getElementById('ValidationJSON').value);
    for (var i = 0; i < validationGroupsToInsert.length; i++)
        addValidationGroup(validationGroupsToInsert[i]);
    
    
    function SetFileOption(dropDownName, optionName) {
        var pathName = '/Files/' + optionName;

        var dropDown = document.getElementById('FM_' + dropDownName);
        dropDown.options.length++;
        var option = dropDown.options[dropDown.options.length - 1];
		option.value = optionName;
		option.text = optionName;
		option.setAttribute('fullPath', pathName);
		dropDown.selectedIndex = dropDown.options.length - 1;

		document.getElementById(dropDownName + '_path').value = pathName;
    }

    // Set stylesheet
    if ('<%=styleSheet %>' != '')
        SetFileOption('ParagraphModuleCSS', '<%=styleSheet %>');
    
    // Set javascript
    if ('<%=javascript %>' != '')
        SetFileOption('ParagraphModuleJS', '<%=javascript %>');

    Event.observe(window, "load", function () {
        Toggle_UserGroups();
        Toggle_Payments();
        Toggle_Deliveries();
        SelectionBox.setNoDataLeft("PaymentsSelector");
        SelectionBox.setNoDataRight("PaymentsSelector");
        SelectionBox.setNoDataLeft("DeliveriesSelector");
        SelectionBox.setNoDataRight("DeliveriesSelector");

        window["paragraphEvents"].setValidator(function () {
            if ($('DoCreateUserInCheckout').checked) {
                if ($('CreateNewUserGroupshidden').value.length == 0) {
                    alert('<%= Dynamicweb.Backend.Translate.JsTranslate("Created user should be assigned to any user group!") %>');
                    return false;
                }
            }
            return true;
        });
    });

    function serializePayments() {
        var fields = SelectionBox.getElementsRightAsArray("PaymentsSelector");
        //var fieldsJSON = JSON.stringify(fields);
        $("PaymetTypes").value = fields.join(); //  fieldsJSON;
    }
    
    function Toggle_Payments() {
        if ($('PaymentRadioAll').checked) {
            $('SelectAllPayments').value = true;
            $('PaymentsSelectorRow').hide();
        } else {
            $('SelectAllPayments').value = false;
            $('PaymentsSelectorRow').show();
        }
    }

    function serializeDeliveries() {
        var fields = SelectionBox.getElementsRightAsArray("DeliveriesSelector");
        $("DeliveryTypes").value = fields.join();
    }

    function Toggle_Deliveries() {
        if ($('DeliveryRadioAll').checked) {
            $('SelectAllDeliveries').value = true;
            $('DeliveriesSelectorRow').hide();
        } else {
            $('SelectAllDeliveries').value = false;
            $('DeliveriesSelectorRow').show();
        }
    }

    function Toggle_UserGroups() {
        if ($('DoCreateUserInCheckout').checked) {
            $('CreateNewUserGroupsRow').show();
            $('ErrorMessagesDiv').show();            
        } else {
            $('CreateNewUserGroupsRow').hide();
            $('ErrorMessagesDiv').hide();
        }
    }
   
</script>