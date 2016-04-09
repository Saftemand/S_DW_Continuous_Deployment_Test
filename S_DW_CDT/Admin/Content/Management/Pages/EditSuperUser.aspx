<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditSuperUser.aspx.vb" Inherits="Dynamicweb.Admin.EditSuperUser" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <script type="text/javascript">
        function resetEncryptedPassword() {
            if (confirm('<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to reset the password?") %>')) {
                document.getElementById('EditUserForm').Password.value = '';
                document.getElementById('textPassword').style.display = '';
                document.getElementById('encryptedPasswordDiv').style.display = 'none';
                document.getElementById('EditUserForm').Password.focus();
                $('DoSavePassword').value = 'True';
            }
        }

        function generatePassword() {
            if (document.getElementById('EditUserForm').Password.value == '' || confirm('<%=Dynamicweb.Backend.Translate.JsTranslate("Do you want to overwrite the existing password?")%>')) {
                // Excluded: 0Oo lI1
                var passwordChars = '23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';

                var password = '';
                while (password.length < 8)
                    password += passwordChars.charAt(Math.floor(Math.random() * passwordChars.length))
                document.getElementById('EditUserForm').Password.value = password;
            }
        }

        function saveAndClose() {
            $('DoSaveAndClose').value = 'True';
            document.getElementById('EditUserForm').submit();
        }

        function save() {
            $('DoSave').value = 'True';
            document.getElementById('EditUserForm').submit();
        }
        function showStartFrame() {
            location = '/Admin/Content/Management/Start.aspx';
        }
    </script>
</head>
<body>
    <form runat="server" id="EditUserForm" name="EditUserForm" >
        <input type="hidden" id="DoSave" name="DoSave"  />
        <input type="hidden" id="DoSaveAndClose" name="DoSaveAndClose"  />
    
        <dw:Toolbar ID="Toolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="ButtonSave" runat="server" Image="Save" Text="Save" OnClientClick="save();" />
            <dw:ToolbarButton ID="ButtonSaveAndClose" runat="server" Image="SaveAndClose" Text="Save and close" OnClientClick="saveAndClose();" />
            <dw:ToolbarButton ID="ButtonCancel" runat="server" Image="Cancel" Text="Cancel" OnClientClick="javascript:showStartFrame();" />
        </dw:Toolbar>
        <h2 class="subtitle">
	        <dw:TranslateLabel Text="Edit super user" runat="server" />
        </h2>

        <dw:GroupBox runat="server" Title="Edit" DoTranslation="true">
            <table>
                <colgroup>
                    <col style="width:170px;white-space:nowrap" />
                    <col />    
                </colgroup>
                
                <!-- Username -->
                <tr>
                    <td>
                        <dw:TranslateLabel runat="server" Text="Username" />
                    </td>
                    <td>
                        <input type="text" runat="server" ID="Username" disabled="true" class="NewUIinput" />
                    </td>
                </tr>
                
                <!-- Password -->
                <tr>
	                <td style="vertical-align:top;">
		                <dw:TranslateLabel runat="server" Text="Password" />
	                </td>
	                <td>
	                    <div id="textPassword" style="display:none;">
	                        <table cellpadding="0" cellspacing="0">
	                            <tr>
	                                <td>
	            	                    <input type="text" runat="server" id="Password" maxlength="255" class="NewUIinput" />
	            	                    <input type="hidden" runat="server" id="DoSavePassword" />
	                                </td>
	                                <td>
    				                    <a href="javascript:generatePassword();"><img src="/Admin/Images/passwordGen.gif" style="border-width:0px; vertical-align:middle; margin-left: 4px;" alt="<%=Dynamicweb.Backend.Translate.JsTranslate("Generate password") %>" /></a>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <label for="DoEncryptPassword"><dw:TranslateLabel runat="server" Text="Encrypt" /></label>
	            	                    <input type="checkbox" runat="server" id="DoEncryptPassword" />
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
	            
	            <!-- Email -->
	            <tr>
	                <td>
	                    <dw:TranslateLabel runat="server" Text="Email" />
	                </td>
	                <td>
	                    <input type="text" runat="server" ID="Email" class="NewUIinput" />
	                </td>
	            </tr>
	            
	            <asp:Repeater runat="server" ID="ErrorRepeater">
	                <ItemTemplate>
	                    <tr>
	                        <td />
	                        <td>
	                            <span style="color:Red;">
	                                <%#Container.DataItem %>
	                            </span>
	                        </td>
	                    </tr>
	                </ItemTemplate>
	            </asp:Repeater>
            </table>
        </dw:GroupBox>
    </form>
    
    <script type="text/javascript">
        // Do close?
        if ('<%=DoClose %>' == 'True')
            showStartFrame();
    
        // Init password
        var passwordIsEncrypted = '<%=PasswordIsEncrypted %>' == 'True';
        $('textPassword').style.display = passwordIsEncrypted ? 'none' : 'block';
        $('encryptedPasswordDiv').style.display = passwordIsEncrypted ? 'block' : 'none';
        $('DoSavePassword').value = passwordIsEncrypted ? 'False' : 'True';

        // Init the save-flag
        $('DoSaveAndClose').value = 'False';
        
    </script>
</body>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

</html>