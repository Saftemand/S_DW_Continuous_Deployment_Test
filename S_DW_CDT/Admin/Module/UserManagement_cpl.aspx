<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserManagement_cpl.aspx.vb" Inherits="Dynamicweb.Admin.UserManagement_cpl" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Translate.JsTranslate("UserManagement")%></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />

    <script type="text/javascript">
        function encryptAllPasswords() {
            if(confirmEncryption()){
                if (confirm('<%=Translate.JsTranslate("This will encrypt all existing passwords. Encrypted passwords cannot be recovered. Do you want to continue?") %>'))
                    location = 'UserManagement_cpl.aspx?encryptAllPasswords=True';
            }
        }

        function findCheckboxNames() {
            var form = document.getElementById('frmGlobalSettings');
            var _names = "";
            for (var i = 0; i < form.length; i++) {
                if (form[i].name != undefined) {
                    if (form[i].type == "checkbox") {
                        _names = _names + form[i].name + "@"
                    }
                }
            }
            form.CheckboxNames.value = _names;
        }

        function toggleUploadedImagesDiv() {
            if (document.getElementById('UploadedImagesDefineOnParagraph').checked)
                document.getElementById('UploadedImagesDiv').style.display = 'none';
            else
                document.getElementById('UploadedImagesDiv').style.display = 'block';
        }

        // Removes the '/Filer/' prefix of
        function fixSecureFolder() {
            var removeString = '/' + '<%=Dynamicweb.Content.Management.Installation.FilesFolderName%>' + '/';
            var secureFolder = document.getElementById('FLDM_/Globalsettings/Modules/Users/SecureFolderName');
            if (secureFolder.value.substring(0, removeString.length).toLowerCase() == removeString.toLowerCase()) {
                secureFolder.value = secureFolder.value.substring(removeString.length, secureFolder.value.length);
            }
            else {
                secureFolder.value = '';
            }
        }
        function help() {
		        <%=Dynamicweb.Gui.help("","administration.controlpanel.usermanagement") %>
		}

        function EncryptPaswords(backend) {
            if (!confirmEncryption())
                return false;

            var usersLocation = "frontend";
            if (backend) {
                usersLocation = "backend";
            }

            new Ajax.Request('/Admin/Module/UserManagement_cpl.aspx?EncodePasswords=' + usersLocation + '&rnd=' + Math.random(), {
                method: 'get',
                onSuccess: function (transport) {
                    alert('<%= Translate.Translate("Passwords were encrypted") %>');
                },
                onFailure: function () {
                    alert('<%= Translate.Translate("Something went wrong") %>');
                }
            });
        }

        function checkBlockingPeriod() {
            var blockingPeriod = parseInt(document.getElementById('BlockingPeriod').value);
            if (isNaN(blockingPeriod)) {
                alert('<%= Translate.Translate("Blocking period has incorrect value") %>');
                document.getElementById('BlockingPeriod').focus();
                return false;
            } else if (blockingPeriod <= 0) {
                alert('<%= Translate.Translate("Blocking period must be at least 1 min") %>');
                    document.getElementById('BlockingPeriod').focus();
                    return false;
                }
            return true;
        }

        function showSHA512prompt()
        {
            if (prompt('<%=Translate.JsTranslate("Using SHA512 password encryption is only supported on later versions of DW 8.5.1 and DW 8.6.\r\nDowngrading to earlier versions will require users to change password.\r\n\r\nDo you wish to continue?\r\nEnter SHA512 to confirm.")%>', '') == 'SHA512') {
                return true;
            } else {
                return false;
            }
        }

        function confirmEncryption()
        {
            return confirm('<%=Translate.JsTranslate("Please save your settings before encrypting passwords. Do you want to continue?")%>');
        }


    </script>
</head>

<body>
    <form method="post" action="ControlPanel_Save.aspx" id="frmGlobalSettings" name="frmGlobalSettings">
        <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />
        <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save" OnClientClick="if(checkBlockingPeriod()){ findCheckboxNames(); fixSecureFolder(); document.getElementById('hiddenSource').value='ManagementCenterSave'; document.getElementById('frmGlobalSettings').submit();}" />
            <dw:ToolbarButton ID="cmdOk" runat="server" Divide="None" Image="SaveAndClose" Text="Gem og luk" OnClientClick="if(checkBlockingPeriod()){checkBlockingPeriod(); findCheckboxNames(); fixSecureFolder(); document.getElementById('frmGlobalSettings').submit();}" />
            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
        </dw:Toolbar>
        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="UserManagement" runat="server" />
        </h2>
        <input type="hidden" name="CheckboxNames" />
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">

            <tr>
                <td valign="top">

                    <dw:GroupBox runat="server" Title="Passwords" DoTranslation="true">
                        <table>
                            <tr style="display:none;"> <!-- hidden from UI see TFS #18249 -->
                                <td style="width: 170px;">
                                    <label for="EncryptNewPasswords">
                                        <dw:TranslateLabel runat="server" Text="Encrypt new passwords as default" />
                                    </label>
                                </td>
                                <td>
                                    <input type="checkbox" id="EncryptNewPasswords" name="/Globalsettings/Modules/UserManagement/EncryptNewPasswords" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/UserManagement/EncryptNewPasswords")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="button" value="<%=Translate.JsTranslate("Encrypt all existing passwords") %>" onclick="encryptAllPasswords();" class="std" />

                                    <div id="encryptSuccess" style="display: none; float: left;">
                                        <span>
                                            <dw:TranslateLabel runat="server" Text="All passwords were encrypted successfully" />
                                        </span>
                                    </div>

                                    <div id="encryptFailure" style="display: none; float: left;">
                                        <span style="color: Red;">
                                            <dw:TranslateLabel runat="server" Text="Errors occured when encrypting the passwords!" />
                                        </span>
                                    </div>

                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                      
                    <dw:GroupBox runat="server" Title="Recalculate User SmartSearches every" DoTranslation="true">  
                        <table>                
					        <tr>
						        <td>
							        <div class="nobr">
							            <dw:TranslateLabel Text="Recalculate user SmartSearches every" runat="server"/>
							        </div>
						        </td>
						        <td>
                                    <select class="std" name="/Globalsettings/Modules/UserManagement/UserSmartSearchesCahceRecalculatingInterval">
                                        <asp:Literal ID="userSSCacheintervalsLtl" runat="server" />
                                    </select>
						        </td>
					        </tr>
				        </table>  
                    </dw:GroupBox>

                    <dw:GroupBox runat="server" Title="Uploaded images" DoTranslation="true">
                        <table>
                            <colgroup>
                                <col style="width: 170px; vertical-align: top;" />
                                <col style="vertical-align: top;" />
                            </colgroup>
                            <tr>
                                <td>
                                    <dw:TranslateLabel runat="server" Text="Define upload folder" />
                                </td>
                                <td>
                                    <input type="radio" name="/Globalsettings/Modules/UserManagement/UploadedImages/DefineWhere" id="UploadedImagesDefineGlobally" value="Globally" <%=IIf(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/DefineWhere") <> "OnParagraph", "checked", "")%> onclick="javascript: toggleUploadedImagesDiv();" />
                                    <label for="UploadedImagesDefineGlobally">
                                        <dw:TranslateLabel runat="server" Text="Globally" />
                                    </label>
                                    <br />

                                    <input type="radio" name="/Globalsettings/Modules/UserManagement/UploadedImages/DefineWhere" id="UploadedImagesDefineOnParagraph" value="OnParagraph" <%=IIf(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/DefineWhere") = "OnParagraph", "checked", "")%> onclick="javascript: toggleUploadedImagesDiv();" />
                                    <label for="UploadedImagesDefineOnParagraph">
                                        <dw:TranslateLabel runat="server" Text="On each paragraph" />
                                    </label>
                                    <br />
                                </td>
                            </tr>
                        </table>

                        <div id="UploadedImagesDiv">
                            <table>
                                <colgroup>
                                    <col style="width: 170px; vertical-align: top;" />
                                    <col style="vertical-align: top;" />
                                </colgroup>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="Folder" />
                                    </td>
                                    <td>
                                        <dw:FolderManager runat="server" Name="/Globalsettings/Modules/UserManagement/UploadedImages/ImagesFolder" ID="UploadedImagesFolder" />
                                    </td>
                                </tr>
                                <tr>
                                    <td />
                                    <td>
                                        <input type="checkbox" name="/Globalsettings/Modules/UserManagement/UploadedImages/EnableMaxWidth" id="EnableMaxWidth" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/EnableMaxWidth")), "checked", "")%> />
                                        <label for="EnableMaxWidth">
                                            <dw:TranslateLabel runat="server" Text="Resize - Max width" />
                                        </label>
                                        <input type="text" name="/Globalsettings/Modules/UserManagement/UploadedImages/MaxWidth" id="MaxWidth" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/MaxWidth")%>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td />
                                    <td>
                                        <input type="checkbox" name="/Globalsettings/Modules/UserManagement/UploadedImages/EnableMaxHeight" id="EnableMaxHeight" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/EnableMaxHeight")), "checked", "")%> />
                                        <label for="EnableMaxHeight">
                                            <dw:TranslateLabel runat="server" Text="Resize - Max height" />
                                        </label>
                                        <input type="text" name="/Globalsettings/Modules/UserManagement/UploadedImages/MaxHeight" id="MaxHeight" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedImages/MaxHeight")%>" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dw:GroupBox>

                    <dw:GroupBox DoTranslation="true" Title="System Fields" runat="server">
                        <input type="button" id="EditSystemFields" onclick="<%=String.Format("javascript:document.location = '/Admin/Module/SystemFields/SystemFieldEdit.aspx?TableName={0}&ModuleName={1}&RedirectUrl={2}'", "AccessUser", "UserManagement", HttpContext.Current.Request.Url.ToString()) %>" value="<%=Translate.JsTranslate("View system fields") %>" class="std" />
                    </dw:GroupBox>

                    <dw:GroupBox DoTranslation="true" Title="Custom Fields" runat="server">
                        <input type="button" id="EditCustomFields" onclick="<%=String.Format("javascript:document.location = '/Admin/Module/CustomField/Default.aspx?TableName={0}&DatabaseName={3}&ModuleName={1}&RedirectUrl={2}'", "AccessUser", "UserManagement", HttpContext.Current.Request.Url.ToString(), "Access.mdb") %>" value="<%=Translate.JsTranslate("Edit custom fields") %>" class="std" />
                    </dw:GroupBox>

                    <div id="CustomFilesDiv">
                        <dw:GroupBox runat="server" Title="Custom files folder" DoTranslation="True">
                            <table>
                                <colgroup>
                                    <col style="width: 170px; vertical-align: top;" />
                                    <col style="vertical-align: top;" />
                                </colgroup>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Define upload folder" />
                                    </td>
                                    <td>
                                        <input type="radio" name="/Globalsettings/Modules/UserManagement/UploadedCustomFiles/DefineWhere" id="UploadedCustomFilesGlobally" value="Globally" <%=IIf(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedCustomFiles/DefineWhere") <> "OnUser", "checked", "")%> />
                                        <label for="UploadedCustomFilesGlobally">
                                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Globally" />
                                        </label>
                                        <br />

                                        <input type="radio" name="/Globalsettings/Modules/UserManagement/UploadedCustomFiles/DefineWhere" id="UploadedCustomFilesOnUser" value="OnUser" <%=IIf(Base.GetGs("/Globalsettings/Modules/UserManagement/UploadedCustomFiles/DefineWhere") = "OnUser", "checked", "")%> />
                                        <label for="UploadedCustomFilesOnUser">
                                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="For each user" />
                                        </label>
                                        <br />
                                    </td>
                                </tr>
                            </table>

                            <table>
                                <colgroup>
                                    <col style="width: 170px; vertical-align: top;" />
                                    <col style="vertical-align: top;" />
                                </colgroup>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Folder" />
                                    </td>
                                    <td>
                                        <dw:FolderManager runat="server" Name="/Globalsettings/Modules/UserManagement/UploadedCustomFiles/FilesFolder" ID="UploadedCustomFiles" />
                                    </td>
                                </tr>
                            </table>
                        </dw:GroupBox>
                    </div>

                    <div id="SecureFolderDiv">
                        <dw:GroupBox runat="server" Title="Extranet secure folder" DoTranslation="true">
                            <dw:TranslateLabel runat="server" Text="The secure folder must be located in /Files" />
                            <table>
                                <colgroup>
                                    <col width="170px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="Sikker mappe" />
                                    </td>
                                    <td>
                                        <dw:FolderManager runat="server" ID="SecureFolder" Name="/Globalsettings/Modules/Users/SecureFolderName" />
                                    </td>
                                </tr>
                            </table>
                        </dw:GroupBox>
                    </div>
                    <%If Base.HasVersion("8.4.1.0") Then%>

                    <div id="PasswordSecurityDiv">
                        <dw:GroupBox runat="server" Title="Extranet login limitations" DoTranslation="true">
                            <table>
                                <tr>
                                    <td style="width: 170px;">
                                        <label for="PasswordSecurityEnable">
                                            <dw:TranslateLabel Text="Enable login limitations" runat="server" />
                                        </label>
                                    </td>
                                    <td>
                                        <input style="margin-left: 3px;" type="checkbox" name="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/SecurityEnable" id="PasswordSecurityEnable" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/SecurityEnable")), "checked", "")%> />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="Period for failed login attempts" />
                                    </td>
                                    <td>
                                        <input type="text" id="PeriodLoginFailure" name="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/PeriodLoginFailure" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/PeriodLoginFailure")%>" />
                                        <dw:TranslateLabel runat="server" Text="(minutes)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 170px;">
                                        <label for="PasswordSecurityEnable">
                                            <dw:TranslateLabel Text="Login attempts" runat="server" />
                                        </label>
                                    </td>
                                    <td>
                                        <input type="text" id="LoginAttempts" name="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/LoginAttempts" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/LoginAttempts")%>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel runat="server" Text="Blocking period" />
                                    </td>
                                    <td>
                                        <input type="text" id="BlockingPeriod" onchange="checkBlockingPeriod();" name="/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/BlockingPeriod" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/UserManagement/ExtranetPasswordSecurity/BlockingPeriod")%>" />
                                        <dw:TranslateLabel runat="server" Text="(minutes)" />
                                    </td>
                                </tr>
                            </table>
                        </dw:GroupBox>
                    </div>
                    <%End If%>

                    <div id="PasswordSecurityDWAdmin">
                        <%	
                            If Dynamicweb.Modules.UserManagement.License.IsUsingOldUserModules Or Dynamicweb.Modules.UserManagement.License.IsUsingUserManagement Then
                                Response.Write(Gui.GroupBoxStart("<INPUT type=""checkbox"" value=""show"" onclick=""if(this.checked==true) document.getElementById('tr_SecureAdmin').style.display=''; else document.getElementById('tr_SecureAdmin').style.display='none';""" & IIf(Base.GetGs("/Globalsettings/Modules/Users/UseInAdministration") = "show", "checked", "") & " id=""SecureAdmin"" name=""/Globalsettings/Modules/Users/UseInAdministration"">&nbsp;" & Translate.Translate("Adgangskodesikkerhed - %%", "%%", Translate.Translate("Dynamicweb administration"))))
                        %>
                        <table border="0" cellpadding="2" cellspacing="0" id="tr_SecureAdmin" style="display: <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/UseInAdministration") = "show", "", "None")%>;">
                            <tr>
                                <td width="170">
                                    <label for="/Globalsettings/Modules/Users/EncryptPassword">
                                        <%=Translate.Translate("Krypter")%></label></td>
                                <td>
                                    <input type="checkbox" value="encrypt" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/EncryptPassword") = "encrypt", "checked", "")%> id="SecureAdminEncrypt" name="/Globalsettings/Modules/Users/EncryptPassword" onclick="if (this.checked == true) { document.getElementById('tr_SecureAdminPasswordHash_MD5').style.display = ''; document.getElementById('tr_SecureAdminPasswordHash_SHA512').style.display = ''; } else { document.getElementById('tr_SecureAdminPasswordHash_MD5').style.display = 'none'; document.getElementById('tr_SecureAdminPasswordHash_SHA512').style.display = 'none'; }" /></td>
                            </tr>
                            <%
                                Dim hashAlgorithm As Modules.UserManagement.UserPasswordHashAlgorithm = Modules.UserManagement.UserPasswordHashAlgorithm.MD5
                                [Enum].TryParse(Of Modules.UserManagement.UserPasswordHashAlgorithm)(Base.GetGs("/Globalsettings/Modules/Users/EncryptPasswordHash"), hashAlgorithm)
                            %>
                            <tr id="tr_SecureAdminPasswordHash_MD5" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/EncryptPassword") = "encrypt", "", " style=""display:none""")%>>
                                <td width="170"><label for="/Globalsettings/Modules/Users/EncryptPasswordHash"><%=Translate.Translate("Hashing Algorithm")%></label></td>
                                <td>
                                    
                                    <input type="radio" name="/Globalsettings/Modules/Users/EncryptPasswordHash" value="<%=Modules.UserManagement.UserPasswordHashAlgorithm.MD5.ToString() %>" id="/Globalsettings/Modules/Users/EncryptPasswordHash_MD5" <%=IIf(hashAlgorithm=Modules.UserManagement.UserPasswordHashAlgorithm.MD5,"checked=""checked""","") %> /><label for="/Globalsettings/Modules/Users/EncryptPasswordHash_MD5"><%=Translate.Translate("MD5")%></label><br />
                                    
                                </td>
                            </tr>
                            <tr id="tr_SecureAdminPasswordHash_SHA512" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/EncryptPassword") = "encrypt", "", " style=""display:none""")%>>
                                <td width="170">&nbsp;</td>
                                <td>
                                    <input type="radio" name="/Globalsettings/Modules/Users/EncryptPasswordHash" value="<%=Modules.UserManagement.UserPasswordHashAlgorithm.SHA512.ToString() %>" id="/Globalsettings/Modules/Users/EncryptPasswordHash_SHA512" <%=IIf(hashAlgorithm=Modules.UserManagement.UserPasswordHashAlgorithm.SHA512,"checked=""checked""","") %> onclick="return showSHA512prompt();" /><label for="/Globalsettings/Modules/Users/EncryptPasswordHash_SHA512"><%=Translate.Translate("SHA512")%></label><img style="vertical-align: middle; margin-left: 3px" src="/Admin/Images/Ribbon/Icons/Small/warning.png" title="<%=Translate.Translate("Using SHA512 password encryption is only supported on later versions of DW 8.5.1 and DW 8.6.") %>" alt="SHA512 Warning" />
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Udløbsfrist")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Users/PasswordExpireDays" id="SecureAdminPasswordExpires">
                                        <option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "never", "selected", "")%>>
                                            <%=Translate.Translate("aldrig")%></option>
                                        <option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "30", "selected", "")%>>
                                            <%=Translate.JSTranslate("%% dage", "%%", "30")%></option>
                                        <option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "60", "selected", "")%>>
                                            <%=Translate.JSTranslate("%% dage", "%%", "60")%></option>
                                        <option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "90", "selected", "")%>>
                                            <%=Translate.JSTranslate("%% dage", "%%", "90")%></option>
                                        <option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "180", "selected", "")%>>
                                            <%=Translate.JSTranslate("%% dage", "%%", "180")%></option>
                                        <option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordExpireDays") = "360", "selected", "")%>>
                                            <%=Translate.JSTranslate("%% dage", "%%", "360")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Kodeord genbrug")%></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter antal gange")%></td>
                                <td>
                                    <%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfTimes"), "/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfTimes", 0, 50, 1, "")%>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter Antal dage")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays" id="SecureAdminPasswordReuseDate">
                                        <option value="allways" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "allways", "selected", "")%>>0</option>
                                        <option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "30", "selected", "")%>>30</option>
                                        <option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "60", "selected", "")%>>60</option>
                                        <option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "90", "selected", "")%>>90</option>
                                        <option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "180", "selected", "")%>>180</option>
                                        <option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "360", "selected", "")%>>360</option>
                                        <option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/ReusePassword/AfterNumberOfDays") = "never", "selected", "")%>>
                                            <%=Translate.Translate("aldrig")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Kompleksitet")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Users/PasswordSecurity" id="SecureAdminPasswordSecurity">
                                        <option value="low" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "low", "selected", "")%>>
                                            <%=Translate.Translate("lav")%></option>
                                        <option value="medium" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "medium", "selected", "")%>>
                                            <%=Translate.Translate("mellem")%></option>
                                        <option value="high" <%=IIf(Base.GetGs("/Globalsettings/Modules/Users/PasswordSecurity") = "high", "selected", "")%>>
                                            <%=Translate.Translate("høj")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170"></td>
                                <td>
                                    <div style="height: 16px; background-image: url('/Admin/Images/Ribbon/Icons/Small/information.png'); background-repeat: no-repeat; width: 16px; float: left;"></div>
                                    <div style="float: left; width: 370px; color: gray;" id="usersPasswordComplexity">
                                        <div><%=Translate.Translate("low - No restrictions")%></div>
                                        <div><%=Translate.Translate("medium - Password must contain numbers and characters.")%></div>
                                        <div><%=Translate.Translate("high - Password must contain numbers, upperand lower case characters and special characters.")%></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Min. antal karakterer")%></td>
                                <td>
                                    <%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Users/MinimumOfCharacters"), "/Globalsettings/Modules/Users/MinimumOfCharacters", 0, 15, 1, "")%>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <br />
                                    <%=Gui.Button(Translate.Translate("Krypter %%", "%%", Translate.Translate("brugere")), "EncryptPaswords(true);", 0)%>
                                </td>
                            </tr>
                        </table>
                        &nbsp;
					<%
					    Response.Write(Gui.GroupBoxEnd)
					    Response.Write(Gui.GroupBoxStart("<INPUT type=""checkbox"" value=""show"" onclick=""if(this.checked==true) document.getElementById('tr_SecureExtranet').style.display=''; else document.getElementById('tr_SecureExtranet').style.display='none';""" & IIf(Base.GetGs("/Globalsettings/Modules/Extranet/UseWithExtranet") = "show", "checked", "") & " id=""Checkbox1"" name=""/Globalsettings/Modules/Extranet/UseWithExtranet"">&nbsp;" & Translate.Translate("Adgangskodesikkerhed - %%", "%%", Translate.Translate("Extranet"))))
                    %>
                        <table border="0" cellpadding="2" cellspacing="0" id="tr_SecureExtranet" style="display: <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/UseWithExtranet") = "show", "", "None")%>;">
                            <tr>
                                <td width="170">
                                    <label for="/Globalsettings/Modules/Extranet/EncryptPassword">
                                        <%=Translate.Translate("Krypter")%></label></td>
                                <td>
                                    <input type="checkbox" value="encrypt" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/EncryptPassword") = "encrypt", "checked", "")%> id="Checkbox2" name="/Globalsettings/Modules/Extranet/EncryptPassword" onclick="if (this.checked == true) { document.getElementById('tr_SecureExtranetPasswordHash_MD5').style.display = ''; document.getElementById('tr_SecureExtranetPasswordHash_SHA512').style.display = ''; } else { document.getElementById('tr_SecureExtranetPasswordHash_MD5').style.display = 'none'; document.getElementById('tr_SecureExtranetPasswordHash_SHA512').style.display = 'none'; }" /></td>
                            </tr>
                            <%
                                hashAlgorithm = Modules.UserManagement.UserPasswordHashAlgorithm.MD5
                                [Enum].TryParse(Of Modules.UserManagement.UserPasswordHashAlgorithm)(Base.GetGs("/Globalsettings/Modules/Extranet/EncryptPasswordHash"), hashAlgorithm)
                            %>
                            <tr id="tr_SecureExtranetPasswordHash_MD5" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/EncryptPassword") = "encrypt", "", " style=""display:none""")%>>
                                <td width="170"><label for="/Globalsettings/Modules/Extranet/EncryptPasswordHash"><%=Translate.Translate("Hashing Algorithm")%></label></td>
                                <td>
                                    
                                    <input type="radio" name="/Globalsettings/Modules/Extranet/EncryptPasswordHash" value="<%=Modules.UserManagement.UserPasswordHashAlgorithm.MD5.ToString() %>" id="/Globalsettings/Modules/Extranet/EncryptPasswordHash_MD5" <%=IIf(hashAlgorithm=Modules.UserManagement.UserPasswordHashAlgorithm.MD5,"checked=""checked""","") %> /><label for="/Globalsettings/Modules/Extranet/EncryptPasswordHash_MD5"><%=Translate.Translate("MD5")%></label><br />
                                    
                                </td>
                            </tr>
                            <tr id="tr_SecureExtranetPasswordHash_SHA512" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/EncryptPassword") = "encrypt", "", " style=""display:none""")%>>
                                <td width="170">&nbsp;</td>
                                <td>
                                    <input type="radio" name="/Globalsettings/Modules/Extranet/EncryptPasswordHash" value="<%=Modules.UserManagement.UserPasswordHashAlgorithm.SHA512.ToString() %>" id="/Globalsettings/Modules/Extranet/EncryptPasswordHash_SHA512" <%=IIf(hashAlgorithm=Modules.UserManagement.UserPasswordHashAlgorithm.SHA512,"checked=""checked""","") %> onclick="return showSHA512prompt();" /><label for="/Globalsettings/Modules/Extranet/EncryptPasswordHash_SHA512"><%=Translate.Translate("SHA512")%></label><img style="vertical-align: middle; margin-left: 3px" src="/Admin/Images/Ribbon/Icons/Small/warning.png" title="<%=Translate.Translate("Using SHA512 password encryption is only supported on later versions of DW 8.5.1 and DW 8.6.") %>" alt="SHA512 Warning" />
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Udløbsfrist")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Extranet/PasswordExpireDays" id="Select1">
                                        <option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "encrypt", "selected", "")%>>
                                            <%=Translate.Translate("aldrig")%></option>
                                        <option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "30", "selected", "")%>>
                                            <%=Translate.Translate("%% dage", "%%", "30")%></option>
                                        <option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "60", "selected", "")%>>
                                            <%=Translate.Translate("%% dage", "%%", "60")%></option>
                                        <option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "90", "selected", "")%>>
                                            <%=Translate.Translate("%% dage", "%%", "90")%></option>
                                        <option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "180", "selected", "")%>>
                                            <%=Translate.Translate("%% dage", "%%", "180")%></option>
                                        <option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordExpireDays") = "360", "selected", "")%>>
                                            <%=Translate.Translate("%% dage", "%%", "360")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Kodeord genbrug")%></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter antal gange")%></td>
                                <td>
                                    <%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfTimes"), "/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfTimes", 0, 50, 1, "")%>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">&nbsp;&nbsp;<%=Translate.Translate("Efter Antal dage")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays" id="SecureExtranetPasswordReuseDate">
                                        <option value="allways" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "allways", "selected", "")%>>0</option>
                                        <option value="30" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "30", "selected", "")%>>30</option>
                                        <option value="60" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "60", "selected", "")%>>60</option>
                                        <option value="90" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "90", "selected", "")%>>90</option>
                                        <option value="180" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "180", "selected", "")%>>180</option>
                                        <option value="360" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "360", "selected", "")%>>360</option>
                                        <option value="never" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/ReusePassword/AfterNumberOfDays") = "never", "selected", "")%>>
                                            <%=Translate.Translate("aldrig")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Kompleksitet")%></td>
                                <td>
                                    <select class="std" name="/Globalsettings/Modules/Extranet/PasswordSecurity" id="Select2">
                                        <option value="low" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "", "selected", "")%><%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "low", "selected", "")%>>
                                            <%=Translate.Translate("lav")%></option>
                                        <option value="medium" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "medium", "selected", "")%>>
                                            <%=Translate.Translate("mellem")%></option>
                                        <option value="high" <%=IIf(Base.GetGs("/Globalsettings/Modules/Extranet/PasswordSecurity") = "high", "selected", "")%>>
                                            <%=Translate.Translate("høj")%></option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170"></td>
                                <td>
                                    <div style="height: 16px; background-image: url('/Admin/Images/Ribbon/Icons/Small/information.png'); background-repeat: no-repeat; width: 16px; float: left;"></div>
                                    <div style="float: left; width: 370px; color: gray;" id="Div1">
                                        <div><%=Translate.Translate("low - No restrictions")%></div>
                                        <div><%=Translate.Translate("medium - Password must contain numbers and characters.")%></div>
                                        <div><%=Translate.Translate("high - Password must contain numbers, upperand lower case characters and special characters.")%></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">
                                    <%=Translate.Translate("Min. antal karakterer")%></td>
                                <td>
                                    <%=Gui.SpacListExt(Base.GetGs("/Globalsettings/Modules/Extranet/MinimumOfCharacters"), "/Globalsettings/Modules/Extranet/MinimumOfCharacters", 0, 15, 1, "")%>
                                </td>
                            </tr>
                            <tr>
                                <td width="170"></td>
                                <td>
                                    <br />
                                    <%=Gui.Button(Translate.Translate("Krypter %%", "%%", Translate.Translate("extranet")), "EncryptPaswords(false);", 0)%>
                                </td>
                            </tr>
                        </table>
                        &nbsp;
					<%
					    Response.Write(Gui.GroupBoxEnd())
					End If
                    %>
                    </div>

                    <dw:GroupBox runat="server" Title="Login cookie" DoTranslation="true">
                        <table>
                            <tr>
                                <td style="width: 170px;">
                                    <label for="ValideForDays">
                                        <dw:TranslateLabel runat="server" Text="Valid for (days)" />
                                    </label>
                                </td>
                                <td>
                                    <input type="text" id="ValideForDays" name="/Globalsettings/Modules/Users/AutoLoginCookie/ValideForDays" class="std" size="5" value="<%=Base.GetGs("/Globalsettings/Modules/Users/AutoLoginCookie/ValideForDays")%>" />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBox runat="server" ID="EcomSettings" Title="Ecom" DoTranslation="true" Visible="false">
                        <table>
                            <tr>
                                <td style="width: 167px;">
                                    <label for="IncludeShopId">
                                        <dw:TranslateLabel Text="Include shop id in extranet log in" runat="server" />
                                    </label>
                                </td>
                                <td>
                                    <input style="margin-left: 3px;" type="checkbox" name="/Globalsettings/Ecom/Users/IncludeShopIdInExtranetLogIn" id="IncludeShopId" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Users/IncludeShopIdInExtranetLogIn")), "checked", "")%> />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
        </table>
    </form>

    <script type="text/javascript">
        if ('<%=Base.ChkString(Base.Request("didEncrypt")) %>'.length > 0) {
            if ('<%=Base.ChkString(Base.Request("didEncrypt")) %>' == 'True')
	            document.getElementById('encryptSuccess').style.display = '';
	        else
	            document.getElementById('encryptFailure').style.display = '';
	    }

	    var hasExtranetExtended = '<%=Base.IsModuleInstalled("UserManagementFrontend") %>' == 'True'
        if (!hasExtranetExtended)
            document.getElementById('SecureFolderDiv').style.display = 'none';

        toggleUploadedImagesDiv();
    </script>
</body>
</html>

<%  Translate.GetEditOnlineScript()%>
