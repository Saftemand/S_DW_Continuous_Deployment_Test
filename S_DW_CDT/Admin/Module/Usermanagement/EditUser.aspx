<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditUser.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement.EditUser" ValidateRequest="false" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="cust" Namespace="Dynamicweb.Employee" Assembly="Dynamicweb.Compatibility" %>
<%@ Register TagPrefix="emp" TagName="MultiSelect" Src="/Admin/Module/Employee/MultiSelect.ascx" %>
<%@ Register TagPrefix="emp" TagName="CompetenceLister" Src="/Admin/Module/Employee/CompetenceLister.ascx" %>
<%@ Register TagPrefix="user" Namespace="Dynamicweb.Admin.UserManagement" Assembly="Dynamicweb.Admin" %>
<%@ Register TagPrefix="omc" TagName="VisitsList" Src="~/Admin/Module/OMC/Controls/VisitsList.ascx" %>
<%@ Register Src="/Admin/Module/eCom_Catalog/dw7/UCOrderList.ascx" TagPrefix="emp" TagName="UCOrderList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Base.GetCulture() %>">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="Stylesheet" href="Css/EditUser.css" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/OrderList.css" media="screen" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/OrderListPrint.css" media="print" />

    <dw:ControlResources runat="server" IncludePrototype="true" IncludeUIStylesheet ="true">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" /> 
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/queryString.js" />
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/OrderList.js" />
            <dw:GenericResource Url="/Admin/Images/Controls/PagePermissionTree/PagePermissionTree.js" />
            <dw:GenericResource Url="EditUser.js" />
            <dw:GenericResource Url="ItemEdit.js" />
        </Items>
    </dw:ControlResources>


    <script type="text/javascript">


        function saveAndClose() {
            save(true);
        }

        function saveAndNotClose() {
            save(false);
        }
        
        function save(close, suppresItemValidation) {
            var usernameTextBox = $('Username');
            if (usernameTextBox.value.replace(/^\s+|\s+$/g, '') == '') {
                $('NoUsernameDiv').style.display = '';
                $('UsernameTakenDiv').style.display = 'none';
                usernameTextBox.focus();
                return;
            }
            Dynamicweb.UserManagement.ItemEditors.validateItemFields(suppresItemValidation, function (result) {
                if (result.isValid)
                {
                    document.getElementById('EditUserForm').action = 'EditUser.aspx' +
                        '?GroupID=' + groupID +
                        '&SmartSearchID=' + smartSearchID +
                        '&UserID=' + userID +
                        '&DoValidatePassword=True';

                    $('EditUserForm').request(
                        {
                            onSuccess: function (oXHR) {
                                // validate the form
                                if (oXHR.responseText == "OK") {
                                    // Fire event to handle saving
                                    window.document.fire("General:DocumentOnSave");

                                    var form = $('EditUserForm');
                                    (form.onsubmit || function () { })(); // Force richeditors saving

                                    form.action = 'EditUser.aspx' +
                                        '?GroupID=' + groupID +
                                        '&SmartSearchID=' + smartSearchID +
                                        '&UserID=' + userID +
                                        '&DoSave=True' +
                                        '&DoClose=' + (close ? 'True' : 'False');
                                    form.submit();
                                }
                                else {
                                    $('Password').focus();
                                    $('passwordValidation').style.display = '';
                                    $('passwordValidation').update(oXHR.responseText);
                                }
                            }
                        });
                }
            });
        }

        function cancel() {
            parent.navigateContent('ListUsers.aspx?GroupID=' + groupID + '&SmartSearchID=' + smartSearchID);
        }

        function resetEncryptedPassword() {
            if (confirm('<%=Translate.JsTranslate("Are you sure you want to reset the password?") %>')) {
                document.getElementById('EditUserForm').Password.value = '';
                document.getElementById('textPassword').style.display = '';
                document.getElementById('encryptedPasswordDiv').style.display = 'none';
                document.getElementById('EditUserForm').Password.focus();
            }
        }

        function generatePassword() {
            if (document.getElementById('EditUserForm').Password.value == '' || confirm('<%=Translate.JsTranslate("Do you want to overwrite the existing password?")%>')) {
                // Excluded: 0Oo lI1
                var passwordChars = '23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';

                var password = '';
                while(password.length < 8)
                    password += passwordChars.charAt(Math.floor(Math.random() * passwordChars.length))
                document.getElementById('EditUserForm').Password.value = password;
            }
        }

        function sendUserInfo() {
            var width 	= 640;
            var height 	= 270;
            var left 	= (screen.width-width) / 2;
            var top 	= (screen.height-height) / 2 - 150;

            var urlstr = "/Admin/Access/Access_User_SendMail.aspx?UserID=" + userID;
            window.open(urlstr, "", "displayWindow" +
                ", left=" + left +
                ", top=" + top +
                ", screenX=" + left +
                ", screenY=" + top +
                ", width=" + width +
                ", height=" + height +
                ", resizable=yes" +
                ", scrollbars=yes"
            );
        }

        /* Editor configuration */
        function popupEditorConfiguration() {
            // Set selected value
            // Have to do this everytime the dialog opens, because the user might have opened it before and hit cancel.
            var dropdown = $('ConfigurationSelector');
            var hidden = $('ConfigurationSelectorValue');
            for (i = 0; i < dropdown.length; i++)
                if (dropdown[i].value == hidden.value) {
                    dropdown.selectedIndex = i;
                    break;
                }

            // Show dialog
            dialog.show("EditorConfigurationDialog");
        }
        function setEditorConfiguration() {
            $('ConfigurationSelectorValue').value = $('ConfigurationSelector').value;
            dialog.hide('EditorConfigurationDialog');
        }
        function popupAllowBackend() {
            var checkbox = $('AllowBackendCheckbox');
            var hidden = $('AllowBackendValue');
            checkbox.checked = hidden.value == 'true' ? true : false;
            dialog.show('AllowBackendDialog');
        }
        function setAllowBackend() {
            $('AllowBackendValue').value = $('AllowBackendCheckbox').checked ? 'true' : 'false';
            if ($('AllowBackendCheckbox').checked)
                $('AllowBackendLoginButton').addClassName('active');
            else
                $('AllowBackendLoginButton').removeClassName('active');
            dialog.hide('AllowBackendDialog');
        }

        function popupStartPageDialog() {
            $('StartPage').value = $('StartPageValue').value;
            dialog.show('StartPageDialog');
        }

        function saveStartPageDialog() {
            $('StartPageValue').value = $('StartPage').value;
            dialog.hide('StartPageDialog');
        }

        function SetMainDiv(action) {
            var editUserForm = $('EditUserForm');
            editUserForm.action = 'EditUser.aspx' +
                '?GroupID=' + groupID +
                '&UserID=' + userID +
                '&' + action + "=True";
            editUserForm.submit();
        }

        function loadAjaxPermissions() {
            // Load module permissions
            new Ajax.Updater('ModulePermissionDiv', 'AjaxLoadPermission.aspx?GroupOrUser=User&ID=' + userID + '&time=' + new Date().getTime(), {
                asynchronous: true,
                evalScripts: true,
                method: 'get',

                onLoading: function(request) { },
                onFailure: function(request) {
                    document.getElementById('ModulePermissionDiv').innerHtml = '<%=Backend.Translate.JsTranslate("Error loading permissions") %>';
                },
                onComplete: function(request) { },
                onSuccess: function(request) {
                    document.getElementById('ModulePermissionDiv').innerHtml = request.responseText;
                },
                onException: function(request) { }
            });

            }

            function setHeight() {
                document.body.style.height = parent.GetContentFrameHeight() - 1 + 'px';
                $("EditUserDiv").style.height = parent.GetContentFrameHeight() - 1 - $("Ribbon").getHeight() + 'px';
                $("ViewPermissionsDiv").style.height = parent.GetContentFrameHeight() - 1 - $("Ribbon").getHeight() + 'px';
            }

            function setValidationEmail() {
                $("hiddenIsEmailValidation").value = 'true';
            }

            function ShowUserEmails(){
                <%=Me.pupRecipientDetails.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/Emails/RecipientDetails.aspx?userId=' + <%=Me.userID%> + '&UserManagement=true');
            <%=Me.pupRecipientDetails.ClientInstanceName%>.show();
        }

        function ShowUserTransactions(){
            <%=Me.pupUserTransactions.ClientInstanceName%>.set_contentUrl('/Admin/Module/eCom_Catalog/dw7/lists/EcomLoyaltyUserTransaction_List.aspx?userID=<%=userID%>');
            <%=Me.pupUserTransactions.ClientInstanceName%>.show();
        }

        function ShowUserCardTokens(){
            <%=Me.pupUserSavedCardsTokens.ClientInstanceName%>.set_contentUrl('/Admin/Module/Usermanagement/UserPaymentCardsTokensList.aspx?userId=<%=userID%>');
            <%=Me.pupUserSavedCardsTokens.ClientInstanceName%>.show();
        }

        function ShowUserRecurringOrders(){
            <%=Me.pupUserRecurringOrders.ClientInstanceName%>.set_contentUrl('/Admin/Module/Usermanagement/UserOrdersList.aspx?userId=' + <%=Me.userID%> + '&dialogMode=true&recurringOrders=true');
            <%=Me.pupUserRecurringOrders.ClientInstanceName%>.show();
        }

        function ShowVisits()
        {
            var url = '/Admin/Module/Usermanagement/ListVisits.aspx?UserId=' + <%=Me.userID%>;
            <%=Me.pupVisits.ClientInstanceName%>.set_contentUrl(url);
            <%=Me.pupVisits.ClientInstanceName%>.show();
        }

        function ShowVisitorDetails(visitorId)
        {
            var url = '/Admin/Module/OMC/Leads/Details/Default.aspx?ID=' + encodeURIComponent(visitorId) + '&Section=Visits';
            <%=Me.pupVisitorDetails.ClientInstanceName%>.set_contentUrl(url);
            <%=Me.pupVisitorDetails.ClientInstanceName%>.show();
        }

        function ShowUserOrders()
        {
            var url = '/Admin/Module/Usermanagement/UserOrdersList.aspx?userId=' + <%=Me.userID%> + '&dialogMode=true';
            <%=Me.PopUpOrders.ClientInstanceName%>.set_contentUrl(url);            
            <%=Me.PopUpOrders.ClientInstanceName%>.show();
        }

        function viewOrder(orderID) {
            parent.document.location.href = '/Admin/Module/eCom_Catalog/dw7/Edit/EcomOrder_Edit.aspx?Caller=usermanagement&ID=' + orderID;
        }

        function createRMA(orderID) {
            parent.document.location.href = "/Admin/Module/eCom_Catalog/dw7/Edit/EcomRma_Edit.aspx?OrderID=" + orderID;
        }

        function closePrintDialog() {
            <%=Me.PopUpOrders.ClientInstanceName%>.hide();
        }
    </script>

</head>
<body class="edit" style="height:100%; ">
	<form id="EditUserForm" runat="server" style="margin-bottom:0; height:100%; " >

		<dw:Ribbonbar ID="Ribbon" runat="server">

			<dw:RibbonbarTab runat="server" Active="true" Name="User" >

				<dw:RibbonbarGroup runat="server" Name="Tools">
					<dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="saveAndNotClose();" />
					<dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" />
					<dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" />
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup runat="server" Name="Show">
				    <dw:RibbonbarRadioButton runat="server" ID="ViewUserSettingsButton" Size="Large" Text="User" ImagePath="/Admin/Module/Usermanagement/Images/user_edit_32x32.png" OnClientClick="SetMainDiv('EditUser');" />
				    <dw:RibbonbarRadioButton runat="server" ID="ViewUserPermissionsButton" Size="Large" Text="Permissions" ImagePath="/Admin/Module/Usermanagement/Images/user_permission_32x32.png" OnClientClick="SetMainDiv('ViewPermissions');" />
                    <dw:RibbonbarRadioButton runat="server" ID="ViewUserAddressesButton" Size="Large" Text="Addresses" ImagePath="/Admin/Module/Usermanagement/Images/user_address.png" OnClientClick="SetMainDiv('UserAddresses');" />                    
				</dw:RibbonbarGroup>
                <dw:RibbonBarGroup runat="server" Name="Information">
                    <dw:RibbonBarButton runat="server" ID="rbbViewUserVisits" Text="Visits" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/Trace.png" OnClientClick="ShowVisits();" />
                    <dw:RibbonBarButton runat="server" ID="ViewUserOrdersButton" Text="Orders" Size="Small" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_orders.png" OnClientClick="ShowUserOrders();" />
                    <dw:RibbonBarButton runat="server" ID="ViewUserEmailButton" Text="Email Marketing" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/mail.png" OnClientClick="ShowUserEmails();" />
                    <dw:RibbonBarButton runat="server" ID="ViewUserLoyaltyPoints" Text="Loyalty points" Size="Small" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/tree/eCom_LoyaltyPoints_Settings_small.png" Visible="false" OnClientClick="ShowUserTransactions()" />
                    <dw:RibbonBarButton runat="server" ID="ViewUserPaymentCardsTokens" Text="User Saved Cards" Size="Small" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_payment.png" OnClientClick="ShowUserCardTokens()" />
                    <dw:RibbonBarButton runat="server" ID="ViewUserRecurringOrders" Text="Recurring Orders" Size="Small" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_period.png" OnClientClick="ShowUserRecurringOrders()" />
                </dw:RibbonBarGroup>
				<dw:RibbonbarGroup runat="server" Name="Settings" ID="Settings">
					<dw:RibbonbarButton runat="server" Text="Editor configuration" OnClientClick="popupEditorConfiguration();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/edit.png" />
					<dw:RibbonbarButton runat="server" Text="Send user details" OnClientClick="sendUserInfo();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/mail.png" />
					<dw:RibbonbarButton runat="server" ID="AllowBackendLoginButton" Text="Allow backend login" OnClientClick="popupAllowBackend();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/key1.png" Active="true" />
                    <dw:RibbonBarButton runat="server" ID="StartPageButton" Text="Start page" OnClientClick="popupStartPageDialog();" Size="Small" ImagePath="/Admin/Module/UserManagement/Images/redirect.png" />
                    <dw:RibbonBarButton runat="server" ID="ImpersonationButton" Text="Impersonation" OnClientClick="dialog.show('ImpersonationDialog');" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/user.png" />
                    <dw:RibbonBarButton runat="server" ID="ExternalLoginButton" Text="External accounts" Visible="false" OnClientClick="dialog.show('ExternalLoginDialog');" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" />
                    <dw:RibbonBarButton runat="server" ID="ItemTypeButton" Text="Item Type" OnClientClick="dialog.show('ItemTypeDialog');" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/cube_blue.png" />
				</dw:RibbonbarGroup>

                <dw:RibbonbarGroup ID="ViewUserAddresses" runat="server" Name="User addresses" Visible="false">
                    <dw:RibbonbarButton ID="BtnAddAddress" runat="server" Text="Add address" OnClientClick="addAddress();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/user_address_add_small.png" />
                    <dw:RibbonBarButton ID="BtnDeleteAddresses" runat="server" Text="Delete addresses" Disabled="true" OnClientClick="removeAddresses();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/user_address_delete_small.png" />
                </dw:RibbonbarGroup>                

				<dw:RibbonbarGroup runat="server" Name="Help">
					<dw:RibbonbarButton runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
				</dw:RibbonbarGroup>

			</dw:RibbonbarTab>

			<dw:RibbonbarTab runat="server" active="true" Name="Options">

				<dw:RibbonbarGroup runat="server" Name="Tools">
					<dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="saveAndNotClose();" />
					<dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" />
					<dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" />
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup runat="server" Name="User type">
					<dw:RibbonBarRadioButton ID="cmdUserStandard" runat="server" Checked="false" Group="UserType" Text="Standard" Value="5" Image="NoImage" >
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdUserAdmin" runat="server" Checked="false" Group="UserType" Text="Admin" Value="3" Image="NoImage">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdUserAdministrator" runat="server" Checked="false" Group="UserType" Text="Administrator" Value="1" Image="NoImage">
                    </dw:RibbonBarRadioButton>
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup runat="server" Name="Validity">
					<dw:RibbonbarPanel runat="server" ExcludeMarginImage="true">
                        <div class="EditUserRibbonDiv">
							<table style="height:0px; max-height:0px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
										<dw:TranslateLabel runat="server" Text="Valid from" />&nbsp;
                                    </td>
                                    <td>
										<dw:DateSelector runat="server" EnableViewState="false" ID="ValidFromDate" IncludeTime="true" AllowNeverExpire="false"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
										<dw:TranslateLabel runat="server" Text="Valid to" />&nbsp;
                                    </td>
                                    <td>
										<dw:DateSelector runat="server" EnableViewState="false" ID="ValidToDate" IncludeTime="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <dw:RibbonBarCheckbox runat="server" ID="Active" Text="Active" Size="Large" RenderAs="FormControl" />
                                    </td>
                                </tr>
                            </table>
                        </div>
					</dw:RibbonbarPanel>

				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup runat="server" Name="Help">
					<dw:RibbonbarButton runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
				</dw:RibbonbarGroup>

			</dw:RibbonbarTab>

		</dw:Ribbonbar>


		    <div id="EditUserDiv" runat="server">
            <dw:GroupBox runat="server" Title="User info" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Username" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Username" maxlength="255" class="NewUIinput" />
								<div id="UsernameTakenDiv" class="EditUserErrorDiv" style="display:none;">
                                <%=Backend.Translate.Translate("This user name is already in use. Please choose another user name")%>
                            </div>
								<div id="NoUsernameDiv" class="EditUserErrorDiv" style="display:none;">
                                <%=Backend.Translate.Translate("Please enter a user name")%>
                            </div>
                            <script type="text/javascript">
                                if (document.getElementById('Username').value.length == 0)
                                    document.getElementById('Username').focus()
                            </script>

                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Password" /></div>
                        </td>
                        <td>
								<div id="textPassword" style="display:none;">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <input type="text" runat="server" id="Password" maxlength="255" class="NewUIinput" />
                                                <div id="passwordValidation" class="EditUserErrorDiv" style="display:none;" > </div>
                                        </td>
                                        <td>
												<a href="javascript:generatePassword();"><img src="/Admin/Images/passwordGen.gif" style="border-width:0px; vertical-align:middle; margin-left: 4px;" alt="<%=Translate.JsTranslate("Generate password") %>" /></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="IllegalPasswordDiv" class="EditUserErrorDiv" style="display:none;">
                                                <%=Backend.Translate.Translate("Your password contains system reserved characters. Please choose another password")%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
												<label><input type="checkbox" runat="server" id="DoEncryptPassword" /><dw:TranslateLabel runat="server" Text="Encrypt" /></label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
								<div id="encryptedPasswordDiv" style="display:none; float:left; ">
                                <a href="javascript:resetEncryptedPassword();">
                                    <dw:TranslateLabel runat="server" Text="The password is encrypted. Click here to reset the password" />
                                </a>
                            </div>
                        </td>
                    </tr>
                        <tr ID="ShopIDRow" Visible="false" runat="server">
                        <td>
                                <div class="nobr"><dw:TranslateLabel runat="server" Text="Shop Id" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="ShopId" maxlength="255" class="NewUIinput" readonly="readonly" disabled="disabled" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <dw:GroupBox runat="server" Title="Personal" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Name" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Name" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Title" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="UserTitle" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="First name" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="UserFirstName" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Middle name" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="UserMiddleName" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Last name" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="UserLastName" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Email" /></div>
                        </td>
                        <td>
								<input type="text" runat="server" id="Email" maxlength="255" class="NewUIinput" clientidmode="Static"  />
                            &nbsp;
                                <asp:ImageButton runat="server" ID="ValidateEmail" OnClick="OnEmailValidation" style="position: inherit; top: 3px" OnClientClick="setValidationEmail();" />
                            <input type="hidden" runat="server" id="hiddenIsEmailValidation" name="hiddenIsEmailValidation" value="" />
                        </td>
                    </tr>
                    <%If Base.IsModuleInstalled("EmailMarketing") Then%>
                    <tr>
                        <td>
                            <div class="nobr">&nbsp;</div>
                        </td>
                        <td>
								<label><input type="checkbox" runat="server" id="CommunicationEmail" /><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Email permission" /></label>
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Address" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Address" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Address2" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Address2" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="House number" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="HouseNumber" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Zip" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Zip" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="City" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="City" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="State or region" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="State" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Country" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Country" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Phone" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Phone" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Phone (private)" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="PhonePrivate" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Mobile phone" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="MobilePhone" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Fax" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Fax" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Customer number" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="CustomerNumber" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                        <%If Base.HasVersion("8.6.0.0") AndAlso Base.IsModuleInstalled("eCom_DataIntegrationERPBatch") Then %>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" id="labelExternalId" Text="External Id" Visible="false"/></div>
                        </td>
                        <td>
								<input type="text" runat="server" id="ExternalId" maxlength="255" class="NewUIinput" Visible="false"/>
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Currency" /></div>
                        </td>
                        <td>
								<asp:DropDownList runat="server" id="Currency" CssClass="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel ID="lbPersonalImage" runat="server" Text="Image" /></div>
                        </td>
                        <td>
                            <nobr>
									<dw:FileManager ID="fmImage" Name="fmImage" Extensions="jpg,png,gif,jpeg,bmp" runat="server" />
								</nobr>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <dw:GroupBox runat="server" Title="Work" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Company" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Company" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Department" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Department" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="JobTitle" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="Jobtitle" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Phone (business)" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="PhoneBusiness" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="VATIN" /></div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="VatRegNumber" maxlength="20" class="NewUIinput" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <%If Base.IsModuleInstalled("Maps") Then%>
            <dw:GroupBox runat="server" Title="GeoLocation" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="GeoLocationLat" />
                            </div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="GeoLocationLat" maxlength="255" class="NewUIinput" style="width: 8em" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="GeoLocationLng" />
                            </div>
                        </td>
                        <td>
                            <input type="text" runat="server" id="GeoLocationLng" maxlength="255" class="NewUIinput" style="width: 8em" />
                        </td>
                    </tr>
                    <tr>
                        <td />
                        <td>
                            <button type="button" id="GeoLocationShowOnMap">
                                <dw:TranslateLabel runat="server" Text="Show location on map" />
                            </button>
                            <% If (True) Then%>
                            <button type="button" id="GeoLocationGetFromAPI">
                                <dw:TranslateLabel runat="server" Text="Get location from API" />
                            </button>
                            <% End If%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="GeoLocationIsCustom" />
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" runat="server" id="GeoLocationIsCustom" />
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Image" /></div>
                        </td>
                        <td>
                            <nobr>
									<dw:FileManager id="GeoLocationImage" Name="GeoLocationImage" Extensions="jpg,png" runat="server" />
								</nobr>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <script type="text/javascript" src="Maps.js"></script>
            <script type="text/javascript">
                mapsSettings.numberFormat['numberDecimalSeparator'] = '<%= Base.JSEnable(Base.GetCulture().NumberFormat.NumberDecimalSeparator) %>';
                mapsSettings.numberFormat['numberGroupSeparator'] = '<%= Base.JSEnable(Base.GetCulture().NumberFormat.NumberGroupSeparator) %>';
                mapsSettings.messages['Unable to get location for address "#{address}"'] = '<%= Base.JSEnable(Translate.Translate("Unable to get location for address ""#{address}""")) %>';
            </script>
            <%End If%>

            <dw:SystemFieldValueEdit ID="UserSystemFields" runat="server" />

            <dw:CustomFieldValueEdit ID="UserCustomFields" runat="server" />
            <%--User properties--%>
            <div id="content-item">
                <asp:Literal ID="litFields" runat="server" />
            </div>
            <%--User properties--%>
            <dw:GroupBox runat="server" Title="Groups" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Select groups" /></div>
                        </td>
                        <td>
                            <dw:UserSelector runat="server" ID="GroupsSelector" Show="Groups"></dw:UserSelector>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <%If Base.IsModuleInstalled("eCom_DataIntegrationERPLiveIntegration") Then%>
            <dw:GroupBox ID="GroupBox1" runat="server" Title="Live integration" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <div class="nobr">&nbsp;</div>
                        </td>
                        <td>
								<label><input type="checkbox" runat="server" id="DisableLivePrices" /><dw:TranslateLabel runat="server" Text="Disable live prices" /></label>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <%End If%>

            <dw:GroupBox runat="server" Title="Audit" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Created on" /></div>
                        </td>
                        <td>
                                <div class="nobr"><asp:Label ID="CreatedOn" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Updated on" /></div>
                        </td>
                        <td>
                                <div class="nobr"><asp:Label ID="UpdatedOn" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Created by" /></div>
                        </td>
                        <td>
								<div class="nobr"><asp:Label ID="CreatedBy" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Updated by" /></div>
                        </td>
                        <td>
								<div class="nobr"><asp:Label ID="UpdatedBy" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Email permission updated on" /></div>
                        </td>
                        <td>
                                <div class="nobr"><asp:Label ID="EmailPermissionsUpdatedOn" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <%If Base.HasVersion("8.4.1.0") Then%>
                    <tr>
                        <td>
								<div class="nobr"><dw:TranslateLabel runat="server" Text="Last login on" /></div>
                        </td>
                        <td>
                                <div class="nobr"><asp:Label ID="LastLoginOn" runat="server" Text="" /></div>
                        </td>
                    </tr>
                    <%End If%>
                </table>
            </dw:GroupBox>
        </div>

			<div id="ViewPermissionsDiv" runat="server" style="display:none; overflow:auto;clear:both;">

				<div style="width:240px; float:left; ">
                <dw:GroupBox runat="server" Title="Page permissions" DoTranslation="True">
						<div style="margin:10px 10px 10px 10px; height:100%; ">
							<dw:PagePermissionTree runat="server" ID="PagePermissionTree" ObjectType="User" LoadOnDemand="true"/>
                    </div>
                </dw:GroupBox>
            </div>

            <dw:GroupBox runat="server" Title="Module permissions" DoTranslation="true">
                <div id="ModulePermissionDiv">

						<div style="margin:10px 10px 10px 10px; text-align:center;">
							<img src="/Admin/Module/Usermanagement/Images/ajaxloading_trans.gif" alt="" style="margin-bottom:10px;"/><br />
							<dw:TranslateLabel runat="server" Text="Loading module permissions" /><br />
                        <dw:TranslateLabel runat="server" Text="Please wait" />
                    </div>

                </div>
            </dw:GroupBox>

        </div>
        <!-- Addresses -->
            <div id="ViewUserAddressesDiv" runat="server" style="display:none;">
            <dw:StretchedContainer ID="StretchedContainer_AddressList" Scroll="HorizontalOnly" Stretch="Fill" Anchor="document"
                runat="server">
                <dw:List ID="AddressList" runat="server" AllowMultiSelect="true" Title="Addresses" PageSize="30" StretchContent="true" OnClientSelect="addressListRowSelected();" SortColumnIndex="4">
                    <Columns>
                        <dw:ListColumn ID="ListColumn1" runat="server" Name="Title" Width="100" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn2" runat="server" Name="E-mail" Width="250" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn3" runat="server" Name="Address" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn4" runat="server" Name="Address2" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn5" runat="server" Name="Zip" Width="50" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn6" runat="server" Name="City" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn7" runat="server" Name="State or region" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn8" runat="server" Name="Country" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn9" runat="server" Name="Company" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn10" runat="server" Name="Phone number" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn11" runat="server" Name="Mobile number" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn12" runat="server" Name="Fax" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn13" runat="server" Name="Customer number" EnableSorting="true" />
                        <dw:ListColumn ID="ListColumn14" runat="server" Name="Default" Width="50" EnableSorting="true" />
                    </Columns>
                </dw:List>
                <dw:ContextMenu ID="AddressListContextMenu" runat="server">
                    <dw:ContextMenuButton ID="cmdEditAddress" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_edit.png" Text="Edit Address" OnClientClick="__context.changeAddress();"></dw:ContextMenuButton>
                    <dw:ContextMenuButton ID="cmdMakeDefault" runat="server" Divide="After" ImagePath="/Admin/images/Check.gif" Text="Make default" OnClientClick="__context.makeDefaultAddress();"></dw:ContextMenuButton>
                    <dw:ContextMenuButton ID="cmdRemoveAddress" runat="server" Divide="None" ImagePath="/Admin/Module/Usermanagement/Images/user1_delete.png" Text="Delete address" OnClientClick="__context.removeAddress();"></dw:ContextMenuButton>
                </dw:ContextMenu>
            </dw:StretchedContainer>
        </div>
        <asp:HiddenField ID="ChangeAddressDialogHidden" runat="server" Value="" />
        <!-- End Addresses -->

        <!-- Orders -->
        <dw:PopUpWindow ID="PopUpOrders" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="1000" Height="600" iframeHeight="200"
            Title="Orders" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        <!-- End Orders -->

        <dw:Dialog runat="server" ID="EditorConfigurationDialog" Title="Editor configuration" ShowCancelButton="true" ShowOkButton="true" OkAction="setEditorConfiguration();">
            <dw:GroupBox runat="server" Title="Select configuration" DoTranslation="true">
				<asp:DropDownList runat="server" id="ConfigurationSelector" />
            </dw:GroupBox>
        </dw:Dialog>
        <asp:HiddenField runat="server" ID="ConfigurationSelectorValue" />

        <dw:Dialog runat="server" ID="AllowBackendDialog" Title="Allow backend login" ShowCancelButton="true" ShowOkButton="true" OkAction="setAllowBackend();">
            <dw:GroupBox runat="server" Title="Backend login" DoTranslation="true">
				<asp:CheckBox runat="server" id="AllowBackendCheckbox" />
				<div style="margin: 5px 5px 5px 5px;"><asp:Literal runat="server" ID="AllowBackendDisabledText" Text="This option is disabled because the user is a backend user inherited from these groups:"></asp:Literal></div>
				<div style="margin:10px 10px 10px 10px;"><asp:Literal runat="server" ID="AllowBackendGroups" ></asp:Literal></div>
            </dw:GroupBox>
        </dw:Dialog>
        <asp:HiddenField runat="server" ID="AllowBackendValue" />

        <!-- Start Page Dialog -->
        <dw:Dialog runat="server" ID="StartPageDialog" Title="Start page" ShowCancelButton="true" ShowOkButton="true" OkAction="javascript:saveStartPageDialog();">
            <dw:GroupBox runat="server" Title="Frontend Start page" DoTranslation="true">
				<div style="margin:10px 10px 10px 10px;">
                    <dw:LinkManager runat="server" ID="StartPage" DisableFileArchive="true" />
                    <asp:HiddenField runat="server" ID="StartPageValue" />
                </div>
            </dw:GroupBox>
        </dw:Dialog>

        <!-- Change address Dialog -->
        <dw:Dialog runat="server" ID="ChangeAddressDialog" Title="Add address" ShowCancelButton="true" ShowOkButton="true" OkAction="saveAndCloseChangeAddressDlg();">
            <asp:HiddenField runat="server" ID="changeAddressID" />
            <br />
            <table class="EditUserTable" cellpadding="1" cellspacing="1">
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Title" /></div></td>
			        <td><input type="text" runat="server" id="txtTitle" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="E-mail" /></div></td>
			        <td><input type="text" runat="server" id="txtEmail" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Address" /></div></td>
			        <td><input type="text" runat="server" id="txtAddress" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Address2" /></div></td>
			        <td><input type="text" runat="server" id="txtAddress2" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Zip" /></div></td>
			        <td><input type="text" runat="server" id="txtZip" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="City" /></div></td>
			        <td><input type="text" runat="server" id="txtCity" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel ID="lblState" runat="server" Text="State or region" /></div></td>
			        <td><input type="text" runat="server" id="txtState" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Country" /></div></td>
			        <td><input type="text" runat="server" id="txtCountry" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Company" /></div></td>
			        <td><input type="text" runat="server" id="txtCompany" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Phone number" /></div></td>
			        <td><input type="text" runat="server" id="txtPhone" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Mobile number" /></div></td>
			        <td><input type="text" runat="server" id="txtCell" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Fax" /></div></td>
			        <td><input type="text" runat="server" id="txtFax" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
			        <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Customer number" /></div></td>
			        <td><input type="text" runat="server" id="txtCustomerNumber" maxlength="255" class="NewUIinput" /></td>
                </tr>
                <tr>
                    <td><div class="nobr"><dw:TranslateLabel runat="server" Text="Default" /></div></td>
			        <td><input type="checkbox" runat="server" id="chkIsDefault" /></td>
                </tr>
            </table>
        </dw:Dialog>
        <!-- Impersonation Dialog -->
        <dw:Dialog runat="server" ID="ImpersonationDialog" Title="Impersonation" ShowCancelButton="true" ShowOkButton="true" OkAction="__impersonationContext.saveImpersonationDialog();">
            <dw:GroupBox ID="GroupBox2" runat="server" Title="I can impersonate" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <dw:UserSelector runat="server" ID="ICanImpersonateUserSelector" Show="Both" HideAdmins="true"></dw:UserSelector>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="GroupBox4" runat="server" Title="Can impersonate me" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <dw:UserSelector runat="server" ID="CanImpersonateMeUserSelector" Show="Both" HideAdmins="true"></dw:UserSelector>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <!-- ExternalLogin Dialog -->
        <dw:Dialog runat="server" ID="ExternalLoginDialog" Title="External accounts" ShowCancelButton="false" ShowOkButton="false" AdditionalStyle="background-color: #FFFFFF;" HidePadding="true">
            <dw:Overlay ID="waitExternalLoginsList" runat="server" Message="Please wait" />
            <div id="externalLoginsListDiv">
                <dw:List ID="ExternalLoginsList" Title="" PageSize="10" ShowPaging="true" runat="server" NoItemsMessage="You have no external login accounts">
                    <Columns>
                        <dw:ListColumn Name="Provider type" runat="server" />
                        <dw:ListColumn Name="Provider name" runat="server" />
                        <dw:ListColumn Name="Provider user name" runat="server" />
                        <dw:ListColumn ID="colRemove" Name="Remove" Width="50" runat="server" ItemAlign="Center" />
                    </Columns>
                </dw:List>
            </div>
        </dw:Dialog>
        <!-- Email Marketing pop up window -->
        <dw:PopUpWindow ID="pupRecipientDetails" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="800" Height="500" iframeHeight="200"
            Title="User emails" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        <dw:PopUpWindow ID="pupUserTransactions" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="800" Height="620" iframeHeight="200"
            Title="Loyalty points" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        <dw:PopUpWindow ID="pupUserSavedCardsTokens" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="800" Height="620" iframeHeight="200"
            Title="Saved Cards" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        <dw:PopUpWindow ID="pupUserRecurringOrders" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="1000" Height="600" iframeHeight="200"
            Title="Recurring Orders" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
        <dw:PopUpWindow ID="pupVisits" runat="server" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" IsModal="True" HidePadding="True" Title="Visits" AutoCenterProgress="True" Width="800" ShowCancelButton="False" ShowClose="True" ShowOkButton="False" />
        <dw:PopUpWindow ID="pupVisitorDetails" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="850" Height="510" iframeHeight="200"
            Title="Visitor details" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" IsModal="True" />

        <dw:Dialog runat="server" ID="ItemTypeDialog" Width="480" Title="Item type" ShowOkButton="true" ShowCancelButton="true" CancelAction="closeChangeItemTypeDialog();" OkAction="changeItemType();">
            <dw:GroupBox ID="GroupBox11" runat="server" Title="Item type">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="User properties" />
                        </td>
                        <td>
                            <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
    </form>

    <script type="text/javascript">

        var groupID = <%=groupID %>;
        var smartSearchID = '<%=smartSearchID %>';
        var userID = <%=userID %>;
        var errorCmd = '<%=errorCmd %>';
        var doEncrypt = '<%=doEncryptPassword %>' == 'True';
        var deleteSingleMsg = '<%=Translate.Translate("Delete address?") %>';
        var deleteMultipleMsg = '<%=Translate.Translate("Delete addresses?") %>';
        var deleteMainAddressMsg = '<%=Translate.Translate("Main address can not be deleted") %>';
        var deleteDefaultAddressMsg = '<%=Translate.Translate("You can’t delete a default address. Set another address as default before delete this address.") %>';
        var __impersonationContext = new ImpersonationContext(userID, groupID);
        
        var __context = new AddressContext(userID, groupID, deleteSingleMsg, deleteMultipleMsg, deleteMainAddressMsg, deleteDefaultAddressMsg);
        /* Creating new row context menu */
        var __menu = new RowContextMenu({
            menuID: 'AddressListContextMenu',
            onSelectContext: function(row, itemID) {
                var ret = '';
                var activeCount = 0;
                var mainAddressSelected = false;
                var selectedRows = List.getSelectedRows('AddressList');
                /* Determining whether the target row is part of selection (and more that one row is selected) */
                if(List.rowIsSelected(row) && selectedRows.length > 1) {
                    for(var i = 0; i < selectedRows.length; i++) {
                        if(selectedRows[i].readAttribute('__isMainAddress') == 'true'){
                            mainAddressSelected = true;
                            break;
                        }
                    }
                    if(mainAddressSelected){
                        ret = 'multipleAddressesSelectionWithMainAddress';
                    }
                    else{
                        ret = 'multipleAddressesSelection';
                    }
                } else {
                    if(row.readAttribute('__isMainAddress') == 'true'){
                        ret = 'singleMainAddressSelected';
                    }
                    else{
                        ret = 'singleAddressSelected';
                    }
                }
                return ret;
            }
        });

        function removeAddresses(){
            var rows = List.getSelectedRows('AddressList');
            var isMainAddressSelected = false;
            var isDefaultAddressSelected = false;
            if(rows && rows.length > 0){
                var ids = '', userID = '';
                for (var i = 0; i < rows.length; i++) {
                    userID = rows[i].id;
                    if (userID != null && userID.length > 0) {
                        ids += (userID.replace(/row/gi, '') + ',')
                    }
                    if(rows[i].readAttribute('__isMainAddress') == 'true' && !isMainAddressSelected)
                        isMainAddressSelected = true;
                    if(rows[i].readAttribute('__isDefault') == 'true' && !isDefaultAddressSelected)
                        isDefaultAddressSelected = true;
                }
                if (ids.length > 0) {
                    ids = ids.substring(0, ids.length - 1);
                    if(isMainAddressSelected){
                        alert(deleteMainAddressMsg);
                    }else if(isDefaultAddressSelected){
                        alert(deleteDefaultAddressMsg);
                    }else{
                        var deleteMsg = deleteSingleMsg
                        if (rows.length > 1) {
                            deleteMsg = deleteMultipleMsg;
                        }
                        if(confirm(deleteMsg)){
                            document.location = 'EditUser.aspx?RemoveAddress=True&userID=' + <%=userID %> + '&groupID=' + <%=groupID %> + '&RemoveAddressID=' + ids;
                    }
                }
        }
    }
}

function saveAndCloseChangeAddressDlg(){
    if(isValidAddressDlg()){
        dialog.hide('ChangeAddressDialog');
        document.getElementById('EditUserForm').action = 'EditUser.aspx' +
            '?GroupID=' + groupID +
            '&UserID=' + userID +
            '&DoChangeAddress=true';
        document.getElementById('EditUserForm').submit();
    }
}

function removeExternalLogin(id){
    var o = new overlay('waitExternalLoginsList');
    o.show();
	        
    var request = 'EditUser.aspx?RemoveExternalLogin=True&userID=' + <%=userID %> + '&groupID=' + <%=groupID %> + '&RemoveExternalLoginID=' + id;	        
	        new Ajax.Request(request, {
	            method: 'get',
	            onComplete: function(transport) {
	                if (200 == transport.status) {
	                    o.hide();
	                }
	            },
	            onSuccess: function(transport){
	                if (transport.responseText != "") {
	                    $("externalLoginsListDiv").update(transport.responseText);	                    
	                }
	            }
	        });
        }

        function help() {
	        <%=Dynamicweb.Gui.Help("", "modules.usermanagement.general", _
				Dynamicweb.Backend.Translate.GetLanguageLocale(0)) %>
	    }

        document.observe("dom:loaded", function() {
            __menu.registerContext('multipleAddressesSelection', [ 'cmdRemoveAddress' ]);
            __menu.registerContext('singleAddressSelected', [ 'cmdEditAddress', 'cmdMakeDefault', 'cmdRemoveAddress' ]);
            __menu.registerContext('multipleAddressesSelectionWithMainAddress', []);
            __menu.registerContext('singleMainAddressSelected', [ 'cmdEditAddress']);

            // Init password
            if (document.getElementById("EditUserForm").Password.value.length == 32 || document.getElementById("EditUserForm").Password.value.length == 128) {
                document.getElementById('textPassword').style.display = 'none';
                document.getElementById('encryptedPasswordDiv').style.display = '';
            } else {
                document.getElementById('textPassword').style.display = '';
                document.getElementById('encryptedPasswordDiv').style.display = 'none';
            }

            //Notify on username dublicate
            if (errorCmd == 'UsernameTaken') {
                $('UsernameTakenDiv').style.display = '';
                var usernameTextBox = $('Username');
                usernameTextBox.select();
            }

            if(errorCmd == 'IllegalPassword'){
                $('IllegalPasswordDiv').style.display = '';
                $('Password').select();
            }

            // Init permission page
            loadAjaxPermissions();

            setHeight();

            if ($("ChangeAddressDialogHidden").value == "true"){
                popupChangeAddressDialog();
            }

            document.body.onresize = setHeight;
        });
    </script>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
