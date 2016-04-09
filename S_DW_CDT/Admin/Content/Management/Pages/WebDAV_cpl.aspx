<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebDAV_cpl.aspx.vb" Inherits="Dynamicweb.Admin.WebDAV_cpl" %>
<%@ Register TagPrefix="management" TagName="ImpersonationDialog" Src="/Admin/Content/Management/ImpersonationDialog/ImpersonationDialog.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>WebDAV setup</title>
        <dw:ControlResources ID="ctlResource" IncludePrototype="false" IncludeScriptaculous="false" 
            IncludeUIStylesheet="true" runat="server" />
        
        <script type="text/javascript" language="javascript">
            function validateVirtualPath(sender, e) {
                var tx = document.getElementById('txVirtualPath');
                
                if(tx) {
                    e.IsValid = (tx.value.length > 0);
                } else {
                    e.IsValid = false;
                }
            }
            
            function help() {
		        <%=Dynamicweb.Gui.help("","administration.managementcenter.webdav") %>
	        }
            
        </script>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdSave" Disabled="true" runat="server" Divide="None" Image="Save" Text="Save" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location='/Admin/Content/Management/Start.aspx';" />
	            <dw:ToolbarButton ID="cmdImpersonate" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/user_preferences.png" Text="Impersonation" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Setup" runat="server" />
	        </h2>
	        
	        <asp:Panel ID="pNoAccess" runat="server">
	            <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
	        </asp:Panel>
	        
	        <asp:Panel ID="pHasAccess" runat="server">
                <table cellspacing="0" cellpadding="2" border="0" class="tabTable">
                    <tr valign="top">
                        <td colspan="2">
                            <dw:GroupBoxStart ID="gbSettingsStart" Title="Settings" runat="server" />
                                <table cellspacing="0" cellpadding="2" border="0">
                                    <tr>
                                        <td width="150">
                                            <dw:TranslateLabel ID="lbVirtualPath" Text="Virtual path" runat="server" />
                                        </td>
                                        <td width="200">
                                            <asp:TextBox ID="txVirtualPath" Enabled="false" Width="200" runat="server" />
                                        </td>
                                        <td width="100">
                                            <asp:CustomValidator ID="valCustomVirtualPath" ClientValidationFunction="validateVirtualPath" 
                                                ValidateEmptyText="true" ControlToValidate="txVirtualPath" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <dw:Infobar ID="infoResult" Visible="false" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            <dw:GroupBoxEnd ID="gbSettingsEnd" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            
            <management:ImpersonationDialog id="dlgImpersonation" DefaultType="BackendUser" runat="server" />
            <input type="hidden" id="PreviousBindingPath" runat="server" />
        </form>
    </body>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>


