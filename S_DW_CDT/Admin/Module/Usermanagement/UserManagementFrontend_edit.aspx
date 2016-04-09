<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserManagementFrontendExtended_edit.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement_edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<style type="text/css">

    #ShowProfileUserID_CustomSelector input {
        font-size: 11px;
        padding-left: 2px;
    }

    .chb-list {
        max-height: 140px;
        overflow: auto;
        border-radius: 3px;
        border: 1px solid #ABADB3;
    }

    .chb-list .chb-item:hover {
        background-color: rgb(173, 216, 230);
    }

    .row > label,
    label.row {
        display:block;
    }
    
    label.row input[type=radio],
    label.row input[type=checkbox] {
        vertical-align: -2px;
    }
    
    .send-restore-pwd-link-options {
        display:none;
    }

    .SendRestoreLink .send-restore-pwd-link-options {
        display:block;
        margin:4px 25px;
    }

    .pr-email-settings .row {
        padding-bottom: 4px;
    }

    .pr-email-settings .row label {
        margin-bottom: 2px;
    }
</style>

<script type="text/javascript" src="/Admin/Images/Controls/EditableList/EditableListEditors.js"></script>

<script type="text/javascript">

    var showImageSettings = '<%=Dynamicweb.Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/DefineWhere")%>' == "OnParagraph";

    function toggleIncludeSubsDiv() {
        document.getElementById('IncludeSubsDiv').style.display = $('ListIncludeSubs').checked ? 'block' : 'none';
    }

    function toggleShow() {
        if ($('ShowRadioList').checked) {
            $('ShowListDiv').style.display = 'block';
            $('ShowProfileDiv').style.display = 'none';

            $('CreateProfileDiv').style.display = 'none';
            $('AdminNotificationEmailGroup').style.display = 'none';
            $('RedirectionDiv').style.display = 'none';
            $('ViewProfileManageAddressesDiv').style.display = 'none';
            $('ViewProfileViewAddressesDiv').style.display = 'none';
            $('VCardDiv').style.display = 'block';
            $('UploadedImagesDiv').style.display = showImageSettings ? 'block' : 'none';
            $('ErrorMessagesDIV').style.display = 'none';
            showLoginSettingsPane(false);
            displayAddressMessages(false);
        } else if ($('ShowRadioProfile').checked) {
            $('ShowListDiv').style.display = 'none';
            $('ShowProfileDiv').style.display = 'block';
            $('CreateProfileDiv').style.display = 'none';
            $('AdminNotificationEmailGroup').style.display = 'none';
            $('RedirectionDiv').style.display = 'none';
            $('ViewProfileDiv').style.display = 'block';
            $('ViewProfileEditProfileDiv').style.display = $('ShowProfileAllowEdit').checked ? 'block' : 'none';
            $('ViewProfileManageAddressesDiv').style.display = $('ShowProfileAllowEdit').checked ? 'block' : 'none';
            $('ViewProfileViewAddressesDiv').style.display = $('ShowProfileAllowEdit').checked ? 'none' : 'block';
            $('VCardDiv').style.display = 'block';
            $('UploadedImagesDiv').style.display = $('ShowProfileAllowEdit').checked && showImageSettings ? 'block' : 'none';
            $('ErrorMessagesDIV').style.display = $('ShowProfileAllowEdit').checked ? 'block' : 'none';
            showLoginSettingsPane(false);
            displayAddressMessages(true);
        } else if ($('ShowRadioCreate').checked) {
            $('ShowListDiv').style.display = 'none';
            $('ShowProfileDiv').style.display = 'none';
            $('CreateProfileDiv').style.display = 'block';
            $('AdminNotificationEmailGroup').style.display = 'block';
            $('RedirectionDiv').style.display = 'block';
            $('ViewProfileManageAddressesDiv').style.display = 'none';
            $('ViewProfileViewAddressesDiv').style.display = 'none';
            $('VCardDiv').style.display = 'none';
            $('UploadedImagesDiv').style.display = showImageSettings ? 'block' : 'none';
            $('ErrorMessagesDIV').style.display = 'block';
            showLoginSettingsPane(false);
            displayAddressMessages(false);
        } else if ($('ShowRadioEdit').checked) {
            $('ShowListDiv').style.display = 'none';
            $('ShowProfileDiv').style.display = 'block';
            $('CreateProfileDiv').style.display = 'none';
            $('AdminNotificationEmailGroup').style.display = 'none';
            $('RedirectionDiv').style.display = 'none';
            $('ViewProfileDiv').style.display = 'none';
            $('ViewProfileEditProfileDiv').style.display = 'block';
            $('ViewProfileManageAddressesDiv').style.display = 'none';
            $('ViewProfileViewAddressesDiv').style.display = 'none';
            $('VCardDiv').style.display = 'none';
            $('UploadedImagesDiv').style.display = 'none';
            $('ErrorMessagesDIV').style.display = 'block';
            showLoginSettingsPane(false);
            displayAddressMessages(false);
        } else if ($('ShowRadioLogin').checked) {
            $('ShowListDiv').style.display = 'none';
            $('ShowProfileDiv').style.display = 'none';
            $('CreateProfileDiv').style.display = 'none';
            $('AdminNotificationEmailGroup').style.display = 'none';
            $('RedirectionDiv').style.display = 'none';
            $('ViewProfileManageAddressesDiv').style.display = 'none';
            $('ViewProfileViewAddressesDiv').style.display = 'none';
            $('VCardDiv').style.display = 'none';
            $('UploadedImagesDiv').style.display = 'none';
            $('ErrorMessagesDIV').style.display = 'none';
            showLoginSettingsPane(true);
            displayAddressMessages(false);
        }
        toggleCreateProfileRedirect();
    }

    function showLoginSettingsPane(show) {
        $('login-settings-pane').style.display = show ? 'block' : 'none';
        if (show) {
            $('ErrorMessagesDIV').style.display = 'block';
        }
    }

    function displayAddressMessages(show) {
        $('DeleteAddressMessageRow').style.display = show ? 'table-row' : 'none';
        $('DeleteMainAddressMessageRow').style.display = show ? 'table-row' : 'none';
        $('DeleteDefaultAddressMessageRow').style.display = show ? 'table-row' : 'none';
    }

    function toggleCreateProfileRedirect() {
        if ($('CreateProfileRedirectTypePage').checked) {
            $('CreateProfileRedirectPageDiv').style.display = 'block';
            $('CreateProfileRedirectTemplateDiv').style.display = 'none';
        } else {
            $('CreateProfileRedirectPageDiv').style.display = 'none';
            $('CreateProfileRedirectTemplateDiv').style.display = 'block';
        }
    }

    function toggleAutoLogin() {
        $('CreateProfileAutoLoginDiv').style.display = $('CreateProfileApprovalRadioNone').checked ? 'block' : 'none';
        $('UserConfirmationEmailGroup').style.display = $('CreateProfileApprovalRadioNone').checked || $('CreateProfileApprovalRadioByAdmin').checked ? 'none' : 'block';
        $('UserConfirmationEmailGroup').style.display = $('CreateProfileApprovalRadioByUser').checked ? 'block' : 'none';
    }

    function toggleProfileUserMode() {
        var userSelector = $('ShowProfileUserSelectorContainer');
        var allowEdit = $('ShowProfileAllowEdit');
        var allowEditDiv = $('ShowProfileAllowEditDiv');

        if ($('ShowProfileUserSelected').checked) {

            allowEdit.checked = false;
            allowEditDiv.style.display = "none";

            userSelector.style.display = "table-row";
        }
        else {
            allowEditDiv.style.display = "block";
            userSelector.style.display = "none";
        }

        toggleShow();
    }



    function userManagementValidate() {
        if ($('ListUserSelectorhidden').value.split(",").length > 1
            && $('ListSortByRadioSorting').checked
            && $('ShowRadioList').checked) {
            alert('<%=Translate.JsTranslate("The paragraph was not saved because you have selected several user groups and orderign by Backend sorting. Leave please one user group or choose another ordering.") %>');
            return false;
        } else if ($('ShowRadioCreate').checked
            && $('CreateProfileNewUserGroupshidden').value.length == 0
            && $('CreateProfileSelectableGroupshidden').value.length == 0) {
            alert('<%=Translate.JsTranslate("Created user should be assigned to any user group!") %>');
                return false;
            }
        return true;
    }
    window["paragraphEvents"].setValidator(userManagementValidate);
</script>

<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="UserManagementFrontendExtended" />

<input type="hidden" name="UserManagementFrontend_settings"
    value="ShowRadio,ListTemplate,ListUserSelectorHidden,ListIncludeSubs,ListIncludeSubsRadio,ListIncludeSubsLevels,DetailUserTemplate,DetailGroupTemplate,ListEditUserTemplate,ShowProfileTemplate,CreateProfileTemplate,CreateProfileApprovalRadio,CreateProfileNewUserGroupsHidden,ConfirmationEmailTemplate,ConfirmationEmailFromAddress,ConfirmationEmailSubject,NotificationEmailTemplate,NotificationEmailFromAddress,NotificationEmailSubject,NotificationEmailRecipientsHidden,CreateProfileSelectableGroupsHidden,ListEditUserSelectableGroupsHidden,ShowProfileAllowEdit,CreateProfileRedirectType,CreateProfileRedirectPage,CreateProfileRedirectTemplate,CreateProfileAutoLogin,ApprovalRedirectPage,ListSortByRadio,ListSortOrderRadio,ShowProfileEditUserTemplate,ShowProfileEditAddressesTemplate,ShowProfileViewAddressesTemplate,ShowProfileAddAddressTemplate,ShowProfileSelectableGroupsHidden,UploadedImagesFolder,UploadedImagesEnableMaxWidth,UploadedImagesMaxWidth,UploadedImagesEnableMaxHeight,UploadedImagesMaxHeight,PagingSettings,ErrorEmtyPassword,ErrorPasswordsNotMatch,ErrorWrongPassword,ErrorPasswordLength,ErrorEmtyUsername,ErrorEmtyEmail,ErrorEmailNotFound,IncorrectEmailFormat,SearchTemplate,SearchResultTemplate,LoggedInRedirectPage,VCardFeildsString, ErrorUsernameTaken,DeleteMainAddressMessage,DeleteDefaultAddressMessage,DeleteAddressMessage,ErrorIllegalPasswordCharacters,ErrorPasswordSmallLength,ErrorPasswordComplexity,ErrorPasswordReuse,ShowProfileUser,ShowProfileUserID_CustomSelector,LoginTemplate,PasswordResetTemplate,PasswordRecoveryTemplate,PasswordRecoveryUserFields,PasswordRecoveryMethod, PasswordRecoveryLinkLifeTime, PasswordRecoveryEmailTemplate,PasswordRecoveryEmailFrom, PasswordRecoveryEmailSubject,ErrorEmptyField,LoginSuccessRedirectToPage" />

<dw:GroupBox ID="GroupBox1" runat="server" Title="Show" DoTranslation="true">
    <div style="margin:10px 10px 10px 10px;">
        <table cellpadding="3">
            <colgroup>
                <col width="170px"/>
            </colgroup>
            <tr>
                <td />
                <td>
                    <input type="radio" runat="server" name="ShowRadio" id="ShowRadioList" value="ShowRadioList" onclick="javascript:toggleShow();"/>
                    <label for="ShowRadioList"><dw:TranslateLabel runat="server" Text="List" /></label><br />

                    <input type="radio" runat="server" name="ShowRadio" id="ShowRadioProfile" value="ShowRadioProfile" onclick="javascript:toggleShow();"/>
                    <label for="ShowRadioProfile"><dw:TranslateLabel runat="server" Text="View profile" /></label><br />

                    <input type="radio" runat="server" name="ShowRadio" id="ShowRadioCreate" value="ShowRadioCreate" onclick="javascript:toggleShow();"/>
                    <label for="ShowRadioCreate"><dw:TranslateLabel runat="server" Text="Create profile" /> / <dw:TranslateLabel runat="server" Text="Manage subscription" /></label><br />                                                           

                    <input type="radio" runat="server" name="ShowRadio" id="ShowRadioEdit" value="ShowRadioEdit" onclick="javascript:toggleShow();"/>
                    <label for="ShowRadioEdit"><dw:TranslateLabel runat="server" Text="Edit profile" /></label><br />                                                           
                    
                    <input type="radio" runat="server" name="ShowRadio" id="ShowRadioLogin" value="ShowRadioLogin" onclick="javascript:toggleShow();"/>
                    <label for="ShowRadioLogin"><dw:TranslateLabel runat="server" Text="Login" /></label><br />
                </td>
            </tr>
        </table>
    </div>
</dw:GroupBox>

<div id="ShowListDiv">

    <dw:GroupBox ID="GroupBox2" runat="server" Title="List" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px;">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px"/>
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="ListTemplate" Name="ListTemplate" Folder="Templates/UserManagement/List" /></td>
                </tr>
                <tr>
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="Users and groups" /></td>
                    <td><dw:UserSelector runat="server" ID="ListUserSelector" NoneSelectedText="No users or groups selected" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Hierarchy" /></td>
                    <td>
                        <input type="checkbox" runat="server" ID="ListIncludeSubs" onclick="javascript:toggleIncludeSubsDiv();" />
                        <label for="ListIncludeSubs"><dw:TranslateLabel runat="server" Text="Include subgroups and users from the selected group(s)" /></label>
                        <div id="IncludeSubsDiv" style="display:none; margin-left:10px; ">
                            <input type="radio" runat="server" name="ListIncludeSubsRadio" id="ListIncludeSubsRadioAll" value="ListIncludeSubsRadioAll" />
                            <label for="ListIncludeSubsRadioAll"><dw:TranslateLabel runat="server" Text="All" /></label><br />
                            
                            <input type="radio" runat="server" name="ListIncludeSubsRadio" id="ListIncludeSubsRadioLevels" value="ListIncludeSubsRadioLevels"/>
                            <label for="ListIncludeSubsRadioLevels">
                                <input type="text" runat="server" id="ListIncludeSubsLevels" size="2" onclick="javascript:$(ListIncludeSubsRadioLevels).checked = true;" />
                                <dw:TranslateLabel runat="server" Text="levels" />
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
					<td><dw:TranslateLabel runat="server" Text="Sort users" /></td>
					<td>
						<span id="ListSortingLabel"></span>&nbsp;&nbsp;&nbsp;
						<dw:Button runat="server" Name="Change sorting" OnClick="dialog.show('ListEditSortingDialog');" />
					</td>
                </tr>
            </table>
        </div>
    </dw:GroupBox>

    <dw:PagingSettings runat="server" ID="PagingSettings" />

    <dw:Dialog runat="server" Title="Edit sorting" ID="ListEditSortingDialog" ShowOkButton="true">
		<table>
			<colgroup>
				<col style="width:170px; vertical-align:top;" />
				<col style="vertical-align:top;" />
			</colgroup>
			<tr>
				<td><dw:TranslateLabel runat="server" Text="Sort users by" /></td>
				<td>
					<input runat="server" type="radio" name="ListSortByRadio" id="ListSortByRadioName" value="ListSortByRadioName" onclick="UpdateSortLabel();" />
					<label for="ListSortByRadioName"><span id="ListSortByRadioNameLabel"><dw:TranslateLabel runat="server" Text="Name" /></span></label><br />
					<input runat="server" type="radio" name="ListSortByRadio" id="ListSortByRadioUsername" value="ListSortByRadioUsername" onclick="UpdateSortLabel();" />
					<label for="ListSortByRadioUsername"><span id="ListSortByRadioUsernameLabel"><dw:TranslateLabel runat="server" Text="Username" /></span></label>
                    <br />
					<input runat="server" type="radio" name="ListSortByRadio" id="ListSortByRadioSorting" value="ListSortByRadioSorting" onclick="UpdateSortLabel();" />
					<label for="ListSortByRadioSorting"><span id="ListSortByRadioSortingLabel"><dw:TranslateLabel runat="server" Text="Backend order (possible only with one user group)" /></span></label>
				</td>
			</tr>
			<tr>
				<td><dw:TranslateLabel runat="server" Text="Sort order" /></td>
				<td>
					<input runat="server" type="radio" name="ListSortOrderRadio" id="ListSortOrderRadioAsc" value="ListSortOrderRadioAsc" onclick="UpdateSortLabel();" />
					<label for="ListSortOrderRadioAsc"><span id="ListSortOrderRadioAscLabel"><dw:TranslateLabel runat="server" Text="Ascending" /></span></label><br />
					<input runat="server" type="radio" name="ListSortOrderRadio" id="ListSortOrderRadioDesc" value="ListSortOrderRadioDesc" onclick="UpdateSortLabel();" />
					<label for="ListSortOrderRadioDesc"><span id="ListSortOrderRadioDescLabel"><dw:TranslateLabel runat="server" Text="Descending" /></span></label>
				</td>
			</tr>
			
		</table>
    </dw:Dialog>
    <script type="text/javascript">
        function UpdateSortLabel() {
            var label = '<%=Dynamicweb.Backend.Translate.JsTranslate("Sort by") %> ';
            if ($('ListSortByRadioName').checked)
                label += text($('ListSortByRadioNameLabel'));
            else if ($('ListSortByRadioUsername').checked)
                label += text($('ListSortByRadioUsernameLabel'));
            else if ($('ListSortByRadioSorting').checked)
                label += text($('ListSortByRadioSortingLabel'));

            label += ', ';

            if ($('ListSortOrderRadioAsc').checked)
                label += text($('ListSortOrderRadioAscLabel'));
            else if ($('ListSortOrderRadioDesc').checked)
                label += text($('ListSortOrderRadioDescLabel'));

            $('ListSortingLabel').innerHTML = label;

        }

        function text(elm) {
            return elm.innerText ? elm.innerText : elm.textContent;
        }
    </script>
 
    <dw:GroupBox ID="GroupBox3" runat="server" Title="Details - User" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="DetailUserTemplate" Name="DetailUserTemplate" Folder="Templates/UserManagement/List" /></td>
                </tr>
            </table>
        </div>
    </dw:GroupBox>
    
    <dw:GroupBox ID="GroupBox4" runat="server" Title="Details - Group" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="DetailGroupTemplate" Name="DetailGroupTemplate" Folder="Templates/UserManagement/List" /></td>
                </tr>
            </table>
        </div>
    </dw:GroupBox>  

    <div id="SearchDiv">
        <dw:GroupBox ID="GroupBox6" Title="Search" DoTranslation="true" runat="server">
            <div style="margin:10px 10px 10px 10px; ">
				<table cellpadding="3">
					<colgroup>
						<col width="170px" />
					</colgroup>
					<tr>
						<td><dw:TranslateLabel id="lbSearchTemplate" Text="Template" runat="server" /></td>
						<td><dw:FileManager runat="server" ID="SearchTemplate" Name="SearchTemplate" Folder="Templates/UserManagement/Search" /></td>
					</tr>
                    <tr>
						<td><dw:TranslateLabel id="lbSearchResultTemplate" Text="Results template" runat="server" /></td>
						<td><dw:FileManager runat="server" ID="SearchResultTemplate" Name="SearchResultTemplate" Folder="Templates/UserManagement/List" /></td>
					</tr>
                </table>
            </div>
        </dw:GroupBox>
    </div> 
    
</div>

<div id="ShowProfileDiv">
    <div id="ViewProfileDiv">
        <dw:GroupBox ID="GroupBox7" runat="server" Title="Details - User" DoTranslation="true">
            <div style="margin:10px 10px 10px 10px; ">
                <table cellpadding="3">
                    <colgroup>
                        <col width="170px" />
                    </colgroup>                
                    <tr>
                        <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                        <td><dw:FileManager runat="server" ID="ShowProfileTemplate" Name="ShowProfileTemplate" Folder="Templates/UserManagement/ViewProfile" /></td>
                    </tr>

                    <tr>
                        <td><dw:TranslateLabel runat="server" Text="Show profile" /></td>
                        <td>
                            
                            <input runat="server" type="radio" name="ShowProfileUser" id="ShowProfileUserLoggedIn" value="ShowProfileUserLoggedIn" onclick="toggleProfileUserMode()" />
                            <label for="ShowProfileUserLoggedIn"><dw:TranslateLabel runat="server" Text="Logged in user" /></label><br />
                        
                            <input runat="server" type="radio" name="ShowProfileUser" id="ShowProfileUserSelected" value="ShowProfileUserSelected" onclick="toggleProfileUserMode()" />
                            <label for="ShowProfileUserSelected"><dw:TranslateLabel runat="server" Text="Selected user" /></label>

                        </td>
                    </tr>

                    <tr id="ShowProfileUserSelectorContainer">
                        <td>
                            <dw:TranslateLabel runat="server" Text="Select user" />
                        </td>
                        <td>
                            <dw:EditableListColumnUserEditor ID="ShowProfileUserID_CustomSelector" runat="server" ClientIDMode="Static"  Width="190" />
                        </td>
                    </tr>

                    <tr>
                        <td />
                        <td>
                            <div id="ShowProfileAllowEditDiv">
                                <input type="checkbox" runat="server" ID="ShowProfileAllowEdit" onclick="javascript:toggleShow();" />
                                <label for="ShowProfileAllowEdit"><dw:TranslateLabel runat="server" Text="Allow editing" /></label>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </dw:GroupBox>
    </div>
    <div id="ViewProfileEditProfileDiv">
		<dw:GroupBox ID="GroupBox8" runat="server" Title="Edit profile" DoTranslation="true">
			<div style="margin:10px 10px 10px 10px; ">
				<table cellpadding="3">
					<colgroup>
						<col width="170px" />
					</colgroup>
					<tr>
						<td><dw:TranslateLabel runat="server" Text="Template" /></td>
						<td><dw:FileManager runat="server" ID="ShowProfileEditUserTemplate" Name="ShowProfileEditUserTemplate" Folder="Templates/UserManagement/ViewProfile" /></td>
					</tr>
					<tr>
						<td style="vertical-align:top;"><dw:TranslateLabel runat="server" text="User selectable groups" /></td>
						<td><dw:UserSelector runat="server" ID="ShowProfileSelectableGroups" Show="Groups" HeightInRows="5" /></td>
					</tr>                    
				</table>
	            
			</div>
		</dw:GroupBox>
    </div>
</div>

<div id="CreateProfileDiv">
    <dw:GroupBox ID="GroupBox13" runat="server" Title="Create user" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="CreateProfileTemplate" Name="CreateProfileTemplate" Folder="Templates/UserManagement/CreateProfile" /></td>
                </tr>
                <tr>
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="Approval" /></td>
                    <td>
                        <input runat="server" type="radio" name="CreateProfileApprovalRadio" id="CreateProfileApprovalRadioNone" value="CreateProfileApprovalRadioNone" onclick="javascript:toggleAutoLogin();"/>
                        <label for="CreateProfileApprovalRadioNone"><dw:TranslateLabel runat="server" Text="None" /></label><br />
                        
                        <div id="CreateProfileAutoLoginDiv" style="margin-left:10px;">
                            <input runat="server" type="checkbox" id="CreateProfileAutoLogin" name="CreateProfileAutoLogin"/>
                            <label for="CreateProfileAutoLogin"><dw:TranslateLabel runat="server" Text="Auto login after creation" /></label>
                        </div>
                        
                        <input runat="server" type="radio" name="CreateProfileApprovalRadio" id="CreateProfileApprovalRadioByAdmin" value="CreateProfileApprovalRadioByAdmin" onclick="javascript:toggleAutoLogin();" />
                        <label for="CreateProfileApprovalRadioByAdmin"><dw:TranslateLabel runat="server" Text="By admin" /></label><br />
                        
                        <input runat="server" type="radio" name="CreateProfileApprovalRadio" id="CreateProfileApprovalRadioByUser" value="CreateProfileApprovalRadioByUser" onclick="javascript:toggleAutoLogin();" />
                        <label for="CreateProfileApprovalRadioByUser"><dw:TranslateLabel runat="server" Text="By user" /></label>
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td><dw:TranslateLabel runat="server" Text="Groups for new users" /></td>
                    <td><dw:UserSelector runat="server" ID="CreateProfileNewUserGroups" NoneSelectedText="No group selected" Show="Groups" HeightInRows="3"/></td>
                </tr>
                <tr>
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" text="User selectable groups" /></td>
                    <td><dw:UserSelector runat="server" ID="CreateProfileSelectableGroups" Show="Groups" HeightInRows="5" /></td>
                </tr>
             </table>
        </div>        
    </dw:GroupBox>

<div id="UserConfirmationEmailGroup">
    <dw:GroupBox ID="GroupBox14" runat="server" Title="User confirmation e-mail" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="ConfirmationEmailTemplate" Name="ConfirmationEmailTemplate" Folder="Templates/UserManagement/CreateProfile" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="From address" /></td>
                    <td><input type="text" runat="server" id="ConfirmationEmailFromAddress" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Subject" /></td>
                    <td><input type="text" runat="server" id="ConfirmationEmailSubject" /></td>
                </tr>
             </table>
        </div>        
    </dw:GroupBox>
</div>
</div>
<div id="AdminNotificationEmailGroup">
    <dw:GroupBox ID="GroupBox15" runat="server" Title="Admin notification e-mail" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Template" /></td>
                    <td><dw:FileManager runat="server" ID="NotificationEmailTemplate" Name="NotificationEmailTemplate" Folder="Templates/UserManagement/CreateProfile" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="From address" /></td>
                    <td><input type="text" runat="server" id="NotificationEmailFromAddress" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Subject" /></td>
                    <td><input type="text" runat="server" id="NotificationEmailSubject" /></td>
                </tr>
                <tr>
                    <td><dw:TranslateLabel runat="server" Text="Recipients" /></td>       
                    <td><dw:UserSelector runat="server" Show="Users" HeightInRows="3" ID="NotificationEmailRecipients" /></td>
                </tr>
             </table>
        </div>            
    </dw:GroupBox>
</div>
 <div id="RedirectionDiv">
    <dw:GroupBox ID="GroupBox16" runat="server" Title="Redirection" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="After creation, redirect to" /></td>
                    <td>
                        <input type="radio" runat="server" name="CreateProfileRedirectType" id="CreateProfileRedirectTypePage" onclick="javascript:toggleCreateProfileRedirect();" />
                        <label for="CreateProfileRedirectTypePage"><dw:TranslateLabel runat="server" Text="Page" /></label><br />
                        <input type="radio" runat="server" name="CreateProfileRedirectType" id="CreateProfileRedirectTypeTemplate" onclick="javascript:toggleCreateProfileRedirect();" />
                        <label for="CreateProfileRedirectTypeTemplate"><dw:TranslateLabel runat="server" Text="Template" /></label><br />
                        
                        <div id="CreateProfileRedirectPageDiv">
                            <dw:LinkManager runat="server" ID="CreateProfileRedirectPage" />
                        </div>
                        <div id="CreateProfileRedirectTemplateDiv">
                            <dw:FileManager runat="server" ID="CreateProfileRedirectTemplate" Name="CreateProfileRedirectTemplate" Folder="Templates/UserManagement/CreateProfile" />
                        </div>                        
                    </td>
                </tr>
                <tr id="AfterApprovalRedirectToRow">
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="After approval, redirect to" /></td>
                    <td><dw:LinkManager runat="server" ID="ApprovalRedirectPage" /></td>
                </tr>
                <tr id="IfLoggedInRedirectToRow">
                    <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="If logged in, redirect to" /></td>
                    <td><dw:LinkManager runat="server" ID="LoggedInRedirectPage" DisableFileArchive="True" /></td>
                </tr>
            </table>
        </div>        
    </dw:GroupBox>
 </div>    

 <div id="ViewProfileManageAddressesDiv">
	<dw:GroupBox ID="GroupBox9" runat="server" Title="Manage addresses" DoTranslation="true">
		<div style="margin:10px 10px 10px 10px; ">
			<table cellpadding="3">
				<colgroup>
					<col width="170px" />
				</colgroup>					
                <tr>
					<td><dw:TranslateLabel runat="server" Text="Template - Address list" /></td>
					<td><dw:FileManager runat="server" ID="ShowProfileEditAddressesTemplate" Name="ShowProfileEditAddressesTemplate" Folder="Templates/UserManagement/Addresses" /></td>
				</tr>
                <tr>
					<td><dw:TranslateLabel runat="server" Text="Template - Create address" /></td>
					<td><dw:FileManager runat="server" ID="ShowProfileAddAddressTemplate" Name="ShowProfileAddAddressTemplate" Folder="Templates/UserManagement/Addresses" /></td>
				</tr>                    
			</table>
	            
		</div>
	</dw:GroupBox>
</div>

<div id="ViewProfileViewAddressesDiv">
	<dw:GroupBox ID="GroupBox20" runat="server" Title="View addresses" DoTranslation="true">
		<div style="margin:10px 10px 10px 10px; ">
			<table cellpadding="3">
				<colgroup>
					<col width="170px" />
				</colgroup>					
                <tr>
					<td><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Template - Address list" /></td>
					<td><dw:FileManager runat="server" ID="ShowProfileViewAddressesTemplate" Name="ShowProfileViewAddressesTemplate" Folder="Templates/UserManagement/Addresses" /></td>
                </tr>
			</table>
		</div>
	</dw:GroupBox>
</div>              

<div id="VCardDiv">
    <dw:GroupBox ID="GroupBox17" runat="server" Title="vCard" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px; ">
            <table cellpadding="3">
                <colgroup>
                    <col width="170px" />
                </colgroup>
                <tr>
					<td valign="top"><dw:TranslateLabel runat="server" Text="Insert into vCard" /></td>
					<td><fieldset style="width: 350px"><table width='100%' align='center'><%= VCardBoxes%></table></fieldset></td>
				</tr>
            </table>
        </div>
    </dw:GroupBox>
</div>

<div id="UploadedImagesDiv">
	<dw:GroupBox ID="GroupBox18" runat="server" Title="Uploaded images" DoTranslation="true">
		<table>
			<tr>
				<td style="width:170px;">
					<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Folder" />
				</td>
				<td>
					<dw:FolderManager runat="server" name="UploadedImagesFolder" id="UploadedImagesFolder" />
				</td>
			</tr>
			<tr>
				<td style="width:170px;">
				</td>
				<td>
					<input runat="server" type="checkbox" name="UploadedImagesEnableMaxWidth" id="UploadedImagesEnableMaxWidth" />
					<label for="UploadedImagesEnableMaxWidth"><dw:TranslateLabel runat="server" Text="Resize - Max width" /></label>
					<input runat="server" type="text" name="UploadedImagesMaxWidth" id="UploadedImagesMaxWidth" size="5" />
				</td>
			</tr>
			<tr>
				<td style="width:170px;">
				</td>
				<td>
					<input runat="server" type="checkbox" name="UploadedImagesEnableMaxHeight" id="UploadedImagesEnableMaxHeight" />
					<label for="UploadedImagesEnableMaxHeight"><dw:TranslateLabel runat="server" Text="Resize - Max height" /></label>
					<input runat="server" type="text" name="UploadedImagesMaxHeight" id="UploadedImagesMaxHeight" size="5" />
				</td>
			</tr>
		</table>
	</dw:GroupBox>
</div>

<div id="login-settings-pane">
<dw:GroupBox ID="GroupBox5" runat="server" Title="Login settings" DoTranslation="true" ClassName="login-settings">
    <table cellpadding="3">
        <colgroup>
            <col width="170px" />
        </colgroup>
        <tr>
            <td><dw:TranslateLabel runat="server" Text="Login Template" /></td>
            <td><dw:FileManager runat="server" ID="LoginTemplate" Name="LoginTemplate" Folder="Templates/UserManagement/Login" /></td>
        </tr>
        <tr>
            <td><dw:TranslateLabel runat="server" Text="Password Recovery Template" /></td>
            <td><dw:FileManager runat="server" ID="PasswordRecoveryTemplate" Name="PasswordRecoveryTemplate" Folder="Templates/UserManagement/Login" /></td>
        </tr>
        <tr>
            <td><dw:TranslateLabel runat="server" Text="Password Reset Template" /></td>
            <td><dw:FileManager runat="server" ID="PasswordResetTemplate" Name="PasswordResetTemplate" Folder="Templates/UserManagement/Login" /></td>
        </tr>
        <tr>
            <td style="vertical-align:top;"><dw:TranslateLabel runat="server" Text="On login, redirect to" /></td>
            <td><dw:LinkManager runat="server" ID="LoginSuccessRedirectToPage" DisableFileArchive="True" DisableParagraphSelector="True" /></td>
        </tr>
        <tr>
            <td style="" valign="top"><dw:TranslateLabel runat="server" Text="User fields" /></td>
            <td>
                <div class="chb-list">
                    <% For Each item As ListItem In GetUserFields("PasswordRecoveryUserFields")%>
                    <label class="row chb-item" for="item_<%= item.Value%>">
                        <input type="checkbox" name="PasswordRecoveryUserFields" value="<%= item.Value%>" <%= If(item.Selected, "checked=""checked""", "")%> id="item_<%= item.Value%>" />
                        <span class="lbl-text"><%= item.Text%></span>
                    </label>
                    <% Next%>
                </div>
            </td>
        </tr>
        <tr>
            <td style="" valign="top">
                <dw:TranslateLabel runat="server" Text="Restore password method" />
            </td>
            <td id="restore-method-pane">
                <label class="row" for="SendExistingPassword">
                    <input class="rpm" type="radio" runat="server" name="PasswordRecoveryMethod" id="SendExistingPassword" value="SendExistingPassword" />
                    <span class="lbl-text"><dw:TranslateLabel runat="server" Text="Send existing password" /></span>
                </label>
                <label class="row" for="SendNewPassword">
                    <input class="rpm" type="radio" runat="server" name="PasswordRecoveryMethod" id="SendNewPassword" value="SendNewPassword" />
                    <span class="lbl-text"><dw:TranslateLabel runat="server" Text="Send new password" /></span>
                </label>
                <label class="row" for="SendRestoreLink">
                    <input class="rpm" type="radio" runat="server" name="PasswordRecoveryMethod" id="SendRestoreLink" value="SendRestoreLink" />
                    <span class="lbl-text"><dw:TranslateLabel runat="server" Text="Send link to reset page" /></span>
                </label>
                <div class="send-restore-pwd-link-options">
                    <label for="PasswordRecoveryLinkLifeTime">
                        <dw:TranslateLabel runat="server" Text="Link active in" />
                    </label>
                    <input type="text" runat="server" name="PasswordRecoveryLinkLifeTime" id="PasswordRecoveryLinkLifeTime" size="2" /> hrs
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">Email settings</td>
            <td class="pr-email-settings">
                <div class="row">
                    <label><dw:TranslateLabel runat="server" Text="Template" /></label>
                    <dw:FileManager runat="server" ID="PasswordRecoveryEmailTemplate" Name="PasswordRecoveryEmailTemplate" Folder="Templates/UserManagement/Login" />
                </div>
                <div class="row">
                    <label><dw:TranslateLabel runat="server" Text="From address" /></label>
                    <input type="text" runat="server" id="PasswordRecoveryEmailFrom" class="std" />
                </div>
                <div class="row">
                    <label><dw:TranslateLabel runat="server" Text="Subject" /></label>
                    <input type="text" runat="server" id="PasswordRecoveryEmailSubject" class="std" />
                </div>
            </td>
        </tr>
    </table>
</dw:GroupBox>
</div>
<div id="ErrorMessagesDIV">
    <dw:GroupBox ID="GroupBox19" runat="server" Title="Error messages" DoTranslation="true">
        <div style="margin:10px 10px 10px 10px;">
            <table cellpadding="3">
                <colgroup width="170px" />
                <colgroup width="300px" />
                <tr>
                    <td>
                    <label for="IncorrectEmailFormat"><dw:TranslateLabel runat="server" Text="Incorrect e-mail format" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="IncorrectEmailFormat" id="IncorrectEmailFormat" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorEmtyEmail"><dw:TranslateLabel runat="server" Text="Empty e-mail" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorEmtyEmail" id="ErrorEmtyEmail" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorEmailNotFound"><dw:TranslateLabel runat="server" Text="E-mail is not found" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorEmailNotFound" id="ErrorEmailNotFound" value="" />
                    </td>
                </tr>
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
                    <label for="ErrorWrongPassword"><dw:TranslateLabel runat="server" Text="Wrong password" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorWrongPassword" id="ErrorWrongPassword" value="" />
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
                <tr id="DeleteAddressMessageRow">
                    <td>
                    <label for="DeleteAddressMessage"><dw:TranslateLabel runat="server" Text="Delete address message" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="DeleteAddressMessage" id="DeleteAddressMessage" value="" />
                    </td>
                </tr>
                <tr id="DeleteMainAddressMessageRow">
                    <td>
                    <label for="DeleteMainAddressMessage"><dw:TranslateLabel runat="server" Text="Delete main address message" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="DeleteMainAddressMessage" id="DeleteMainAddressMessage" value="" />
                    </td>
                </tr>
                <tr id="DeleteDefaultAddressMessageRow">
                    <td>
                    <label for="DeleteDefaultAddressMessage"><dw:TranslateLabel runat="server" Text="Delete default address message" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="DeleteDefaultAddressMessage" id="DeleteDefaultAddressMessage" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorPasswordSmallLength"><dw:TranslateLabel runat="server" Text="Min. number of characters" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorPasswordSmallLength" id="ErrorPasswordSmallLength" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorPasswordComplexity"><dw:TranslateLabel runat="server" Text="Password complexity" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorPasswordComplexity" id="ErrorPasswordComplexity" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorPasswordReuse"><dw:TranslateLabel runat="server" Text="Password reuse" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorPasswordReuse" id="ErrorPasswordReuse" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <label for="ErrorEmptyField"><dw:TranslateLabel runat="server" Text="Empty field" /></label>
                    </td>
                    <td>
                    <input type="text" class="std" runat="server" name="ErrorEmptyField" id="ErrorEmptyField" value="" />
                    </td>
                </tr>                
            </table>
        </div>
    </dw:GroupBox>
</div>

<script type="text/javascript">
    function initPasswordRecoverPane() {
        var cnt = $("restore-method-pane");
        var selOptions = cnt.select(".rpm:radio:checked");
        var fn = function (e, el) {
            cnt.className = el.value;
        };
        if (selOptions.length > 0) {
            fn(null, selOptions[0]);
        }
        cnt.on("change", " .rpm", fn);
    }

    <%=RegisterAjaxControlScripts()%>

    toggleIncludeSubsDiv();
    toggleShow();
    toggleCreateProfileRedirect();
    toggleAutoLogin();
    UpdateSortLabel();
    toggleProfileUserMode();

    initPasswordRecoverPane();
</script>