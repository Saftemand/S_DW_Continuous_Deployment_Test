<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditGroup.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement.EditGroup" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Base.GetCulture() %>">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
    <link rel="Stylesheet" href="Css/EditUser.css" />
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" /> 
            <dw:GenericResource Url="EditGroup.js" />
            <dw:GenericResource Url="ItemEdit.js" />
        </Items>
    </dw:ControlResources>
</head>
<body class="edit">
    <form id="EditGroupForm" runat="server">
        <dw:RibbonBar ID="Ribbon" runat="server">
            <dw:RibbonBarTab ID="RibbonbarTab1" runat="server" Active="true" Name="Default">
                <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" ID="cmdSave" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" />
                    <dw:RibbonBarButton runat="server" ID="cmdSaveAndClose" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" />
                    <dw:RibbonBarButton runat="server" ID="cmdClose" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="closeForm();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup2" runat="server" Name="Show">
                    <dw:RibbonBarRadioButton runat="server" ID="ViewGroupSettingsButton" Size="Large" Text="Group" ImagePath="/Admin/Module/Usermanagement/Images/folder_edit_32x32.png" OnClientClick="SetMainDiv('EditGroup');" />
                    <dw:RibbonBarRadioButton runat="server" ID="ViewGroupPermissionsButton" Size="Large" Text="Permissions" ImagePath="/Admin/Module/Usermanagement/Images/lock_view_32x32.png" OnClientClick="SetMainDiv('ViewPermissions');" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup3" runat="server" Name="Settings">
                    <dw:RibbonBarButton ID="RibbonbarButton1" runat="server" Text="Editor configuration" OnClientClick="popupEditorConfiguration();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/edit.png" />
                    <dw:RibbonBarButton runat="server" ID="AllowBackendLoginButton" Text="Allow backend login" OnClientClick="popupAllowBackend();" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/key1.png" />
                    <dw:RibbonBarButton runat="server" ID="StartPageButton" Text="Start page" OnClientClick="popupStartPageDialog();" Size="Small" ImagePath="/Admin/Module/UserManagement/Images/redirect.png" />
                    <dw:RibbonBarButton runat="server" ID="CommPermissionsButton" Visible="False" Text="Permissions" OnClientClick="popupCommPermissions(true);" Size="Small" ImagePath="/Admin/Module/UserManagement/Images/mail.png" />
                    <dw:RibbonBarButton runat="server" ID="ImpersonationButton" Text="Impersonation" OnClientClick="dialog.show('ImpersonationDialog');" Size="Small" ImagePath="/Admin/Module/Usermanagement/Images/user.png" />
                    <dw:RibbonBarButton runat="server" ID="AdministratorsButton" Text="Group admins" OnClientClick="dialog.show('AdministratorsDialog');" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_preferences.png" />
                    <dw:RibbonBarButton runat="server" ID="ItemTypeButton" Text="Item Type" OnClientClick="dialog.show('ItemTypeDialog');" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/cube_blue.png" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup7" runat="server" Name="Validate">
                    <dw:RibbonBarButton ID="cmdValidateEmail" runat="server" Text="Validate e-mails" Image="Check" Size="Small" OnClientClick="validateEmails();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="groupHelp" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="cmdHelp" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
            <dw:RibbonBarTab ID="RibbonbarTab2" runat="server" Visible="false" Active="false" Name="Options">
                <dw:RibbonBarGroup ID="RibbonbarGroup4" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" ID="cmdSave2" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" />
                    <dw:RibbonBarButton runat="server" ID="cmdSaveAndClose2" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" />
                    <dw:RibbonBarButton runat="server" ID="cmdClose2" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="closeForm();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup5" runat="server" Name="Validity">
                    <dw:RibbonBarPanel ID="RibbonbarPanel1" runat="server" ExcludeMarginImage="true">
                        <div class="EditUserRibbonDiv">
                            <table style="height: 0px; max-height: 0px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Valid from" />
                                        &nbsp;
                                    </td>
                                    <td>
                                        <dw:DateSelector runat="server" EnableViewState="false" ID="ValidFromDate" IncludeTime="true" AllowNeverExpire="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Valid to" />
                                        &nbsp;
                                    </td>
                                    <td>
                                        <dw:DateSelector runat="server" EnableViewState="false" ID="ValidToDate" IncludeTime="true" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup6" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton2" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <!-- End: Toolbar -->

        <div id="scrollDiv">
            <!-- 'Settings' group box -->
            <div id="EditGroupDiv">
                <dw:GroupBox ID="GB_Setting" runat="server" Title="Indstillinger">
                    <table class="EditUserTable" cellpadding="1" cellspacing="1">
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Name" />
                                </div>
                            </td>
                            <td>
                                <input type="text" name="GroupName" id="GroupName" onkeyup="groupNameChanged(this);" runat="server" maxlength="255" class="NewUIinput groupNameField" />
                                <script type="text/javascript">
                                    if (document.getElementById('GroupName').value.length == 0) {
                                        document.getElementById('GroupName').focus();
                                    }
                                </script>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <!-- End: 'Settings' group box -->
                <!-- 'Users' group box -->
                <dw:GroupBox ID="GroupBox1" runat="server" Title="Users" DoTranslation="true">
                    <table class="EditUserTable" id="UserSelectorTable" cellpadding="1" cellspacing="1" runat="server">
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Select users" />
                                </div>
                            </td>
                            <td>
                                <dw:UserSelector runat="server" ID="UserSelector" Show="Users">
                                </dw:UserSelector>
                            </td>
                        </tr>
                    </table>
                    <div id="UsersProviderChangedWarning" style="display: none;">
                        <dw:Infobar TranslateMessage="false" runat="server" Type="Warning" Title="" Action="" ID="UsersProviderChangedInfo"></dw:Infobar>
                    </div>
                    <table class="EditUserTable" cellpadding="1" cellspacing="1">
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="SelectSmartSearchLbl" runat="server" Text="Select SmartSearch" />
                                </div>
                            </td>
                            <td>
                                <select class="std" id="UserSmartSearchSelector" runat="server" onchange="handleUserSelectorTableVisibility(this)">
                                    <option value="0" label="None" />
                                </select>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <!-- End: 'Users' group box -->

                <!-- 'Information' group box -->
                <dw:GroupBox ID="GroupBox2" runat="server" Title="Information" DoTranslation="true">
                    <table class="EditUserTable" cellpadding="1" cellspacing="1">
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Customer number" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="CustomerNumber" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Job title" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="JobTitle" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Company name" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="CompanyName" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Address" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Address" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Address 2" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Address2" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Zip code" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="ZipCode" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="City" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="City" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="State or region" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="State" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Country" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Country" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Phone" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Telephone" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Phone (private)" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="TelephoneHome" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Fax" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Telefax" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="Mobile phone" />
                                </div>
                            </td>
                            <td>
                                <input type="text" runat="server" id="Cellular" maxlength="255" class="NewUIinput" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <!-- End: 'Information' group box -->


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
                                <div class="nobr">
                                    <dw:TranslateLabel runat="server" Text="Image" />
                                </div>
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
                    mapsSettings.fieldMap['zip'] = 'ZipCode';
                </script>
                <%End If%>
                <%--Group properties--%>
                <div id="content-item">
                    <asp:Literal ID="litFields" runat="server" />
                </div>
                <%--Group properties--%>
            </div>
            <!-- 'Configuration' dialog -->
            <dw:Dialog runat="server" ID="EditorConfigurationDialog" Title="Editor configuration" ShowCancelButton="true" ShowOkButton="true" OkAction="setEditorConfiguration();">
                <dw:GroupBox ID="GroupBox3" runat="server" Title="Select configuration" DoTranslation="true">
                    <asp:DropDownList runat="server" ID="ConfigurationSelector" />
                </dw:GroupBox>
            </dw:Dialog>
            <asp:HiddenField runat="server" ID="ConfigurationSelectorValue" />
            <!-- End: 'Configuration' dialog -->
            <!-- 'AllowBackend' dialog -->
            <dw:Dialog runat="server" ID="AllowBackendDialog" Title="Allow backend login" ShowCancelButton="true" ShowOkButton="true" OkAction="setAllowBackend();">
                <dw:GroupBox ID="GroupBox4" runat="server" Title="Backend login" DoTranslation="true">
                    <asp:CheckBox runat="server" ID="AllowBackendCheckbox" />
                    <div style="margin: 5px 5px 5px 5px;">
                        <asp:Literal runat="server" ID="AllowBackendDisabledText" Text="This option is disabled because the group inherits backend login from this group:"></asp:Literal>
                    </div>
                    <div style="margin: 10px 10px 10px 10px;">
                        <asp:Literal runat="server" ID="AllowBackendGroups"></asp:Literal>
                    </div>
                </dw:GroupBox>
            </dw:Dialog>
            <asp:HiddenField runat="server" ID="AllowBackendValue" />
            <!-- End: 'AllowBackend' dialog -->
            <!-- Communication permissions dialog -->
            <dw:Dialog runat="server" ID="CommPermissionsDialog" Title="Permissions" ShowCancelButton="True" ShowOkButton="True" OkAction="updateCommPermissions();" CancelAction="revertCommPermissions();" OkText="Update">
                <dw:GroupBox ID="GroupBox8" runat="server" Title="Update permissions for all users in the group" DoTranslation="true">
                    <div class="EditCommPermissions">
                        <label>
                            <input type="checkbox" runat="server" id="CommunicationEmail" /><dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Email" />
                        </label>
                        <input type="hidden" runat="server" id="CommunicationEmailValue" name="CommunicationEmailValue" value="" />
                    </div>
                    <script type="text/javascript">
                        confirmationMsgSelect = '<%= Translate.JsTranslate("This will overwrite existing values. Continue?") %>';
                        confirmationMsgUnSelect = '<%= Translate.JsTranslate("This will overwrite existing values. Continue?") %>';
                    </script>
                </dw:GroupBox>
            </dw:Dialog>
            <!-- End: Communication permissions dialog -->
            <!-- Start Page Dialog -->
            <dw:Dialog runat="server" ID="StartPageDialog" Title="Start page" ShowCancelButton="true" ShowOkButton="true" OkAction="javascript:saveStartPageDialog();">
                <dw:GroupBox ID="GroupBox5" runat="server" Title="Frontend Start page" DoTranslation="true">
                    <div style="margin: 10px 10px 10px 10px;">
                        <dw:LinkManager runat="server" ID="StartPage" DisableFileArchive="true" />
                        <asp:HiddenField runat="server" ID="StartPageValue" />
                    </div>
                </dw:GroupBox>
            </dw:Dialog>
            <input type="hidden" id="GroupID" name="GroupID" value="" runat="server" />
            <input type="hidden" id="ParentGroupID" name="ParentGroupID" value="" runat="server" />
            <input type="hidden" id="IsRootGroup" name="IsRootGroup" value="false" runat="server" />
            <div id="ViewPermissionsDiv" style="display: none;">
                <div style="width: 315px; float: left;">
                    <dw:GroupBox ID="GroupBox6" runat="server" Title="Page permissions" DoTranslation="True">
                        <div style="margin: 10px 10px 10px 10px;">
                            <dw:PagePermissionTree runat="server" ID="PagePermissionTree" ObjectType="Group" />
                        </div>
                    </dw:GroupBox>
                </div>

                <dw:GroupBox ID="GroupBox7" runat="server" Title="Module permissions" DoTranslation="true">
                    <div id="ModulePermissionDiv">
                        <div style="margin: 10px 10px 10px 10px; text-align: center;">
                            <img src="/Admin/Module/Usermanagement/Images/ajaxloading_trans.gif" alt="" style="margin-bottom: 10px;" /><br />
                            <dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Loading module permissions" />
                            <br />
                            <dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Please wait" />
                        </div>
                    </div>
                </dw:GroupBox>
            </div>
        </div>

        <!-- Impersonation Dialog -->
        <dw:Dialog runat="server" ID="ImpersonationDialog" Title="Impersonation" ShowCancelButton="true" ShowOkButton="true" OkAction="__impersonationContext.saveImpersonationDialog();">
            <dw:GroupBox ID="GroupBox9" runat="server" Title="I can impersonate" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <dw:UserSelector runat="server" ID="ICanImpersonateUserSelector" Show="Both" HideAdmins="true"></dw:UserSelector>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="GroupBox10" runat="server" Title="Can impersonate me" DoTranslation="true">
                <table class="EditUserTable" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <dw:UserSelector runat="server" ID="CanImpersonateMeUserSelector" Show="Both" HideAdmins="true"></dw:UserSelector>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <!-- Group administrators Dialog -->
        <dw:Dialog runat="server" ID="AdministratorsDialog" Title="Group admins" ShowCancelButton="False" ShowOkButton="true">
            <dw:UserSelector runat="server" ID="Administrators" Show="Users" HideAdmins="true"></dw:UserSelector>
        </dw:Dialog>

        <dw:PopUpWindow ID="ValidationEmailPopUp" runat="server" AutoReload="True" IsModal="True" AutoCenterProgress="True" ShowOkButton="False" TranslateTitle="True" ShowCancelButton="False" ShowClose="True" Height="420" HidePadding="True" iframeHeight="200" Width="800" UseTabularLayout="True" Title="Invalid email addresses"></dw:PopUpWindow>

        <dw:Dialog runat="server" ID="ItemTypeDialog" Width="480" Title="Item type" ShowOkButton="true" ShowCancelButton="true" CancelAction="closeChangeItemTypeDialog();" OkAction="changeItemType();">
            <dw:GroupBox ID="GroupBox11" runat="server" Title="Item type">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Group properties" />
                        </td>
                        <td>
                            <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="User default properties" />
                        </td>
                        <td>
                            <dw:Richselect ID="ItemTypeUserDefaultSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Overlay ID="UpdatingOverlay" runat="server"></dw:Overlay>
    </form>
    <span id="jsHelp" style="display: none">
        <%=Gui.Help("", "modules.usermanagement.general")%>
    </span>
    <script type="text/javascript">
        var id = <%=_id %>;
        var parentID = <%= _parentID%>;
        var __impersonationContext = new ImpersonationContext(id, parentID);
        loadAjaxPermissions();

        $$('input.groupNameField').each(function(elm) {
            groupNameChanged(elm);
        });        
    </script>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
