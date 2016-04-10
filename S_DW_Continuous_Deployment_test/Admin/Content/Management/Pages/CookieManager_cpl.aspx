<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CookieManager_cpl.aspx.vb" Inherits="Dynamicweb.Admin.CookieManager_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="Head1">
    <title>Cookie Manager</title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <style type="text/css">
        #PageContent
        {
            overflow: auto;
        }
    </style>        
    <asp:Literal ID="litImagesFolderName" runat="server" />
    <script type="text/javascript" src="/Admin/Content/Management/EntryContent.js"></script>    
    <asp:Literal ID="litScript" runat="server" />

    <link rel="Stylesheet" type="text/css" href="/Admin/Extensibility/Stylesheets/MultipleValuesEditor.css" />
    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>         
    <script type="text/javascript">
        var page = SettingsPage.getInstance();
        page.onSave = function () { return save(false); };
        page.saveAndClose = function () { return save(true); };

        function save(close) {
            document.getElementById('CookiesSelectorValue').value = SelectionBox.getElementsRightAsArray('CookiesSelector');

            var url = "CookieManager_cpl.aspx?Save=true";
            if (close)
                url += "&Close=True";
            $("MainForm").action = url;
            $("MainForm").submit();
        }
        
        function addCustomCookie() {
            var list = document.getElementById("CookiesSelector_lstLeft");
            var option = document.createElement("option");
            var value = document.getElementById('customCookieText').value;
            if (value != null && value != "") {
                option.text = value;
                document.getElementById('customCookieText').value = "";
                try {
                    // for IE earlier than version 8
                    list.add(option, list.options[null]);
                }
                catch (e) {
                    list.add(option, null);
                }
            }
        }

        function showHideTemplateSelector() {
            if (document.getElementById("rbCustomUserNotifications").checked) {
                document.getElementById("templateContainer").style.display = "none";
            } else {
                document.getElementById("templateContainer").style.display = "";
            }
        }
    </script>
</head>
<body style="overflow:hidden">
    <form runat="server" action="CookieManager_cpl.aspx" name="frmGlobalSettings" id="MainForm">        
        <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />
        <input id="hiddenCheckboxNames" type="hidden" name="CheckboxNames" />
        <dw:Overlay ID="saveOverlay" Message="Please wait"  runat="server"></dw:Overlay>    
        <div id="divToolbar" style="height:auto;min-width:600px;">
            <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">		        
		        <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save" OnClientClick="SettingsPage.getInstance().save();" ShowWait="True">
		        </dw:ToolbarButton>
		        <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="SaveAndClose" Text="Save and close" OnClientClick="SettingsPage.getInstance().saveAndClose();" ShowWait="True">
		        </dw:ToolbarButton>
		        <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="SettingsPage.getInstance().cancel()" ShowWait="True">
		        </dw:ToolbarButton>
		        <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="SettingsPage.getInstance().help();">
		        </dw:ToolbarButton>	        
	        </dw:Toolbar>    	        
            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSubTitle" Text="Cookie Manager" runat="server" />
            </h2>
        </div>
            
        <asp:Panel ID="MainContent" runat="server">            
            <div id="PageContent">    
                <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		        <tr>
			        <td valign="top">
                        <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="User notification" />				        
                            <div style="padding:20px;">
                                <input runat="server" type="checkbox" id="cbDisableTrackingCookies" name="cbDisableTrackingCookies" />
			                    <dw:TranslateLabel ID="lbDisableTrackingCookies" Text="Enable cookie manager" runat="server" /><br />
                                <div style="display:none;">
                                    <input runat="server" type="checkbox" id="cbDeleteJsTrackingCookies" name="cbDeleteJsTrackingCookies" />
                                    <dw:TranslateLabel ID="TranslateLabel1" Text="Delete js tracking cookies" runat="server" /><br />                                           
                                </div>                                
                                <br />
                                <input type="radio" runat="server" id="rbWarnings"  name="UserNotificationGroup" />                                                        
                                <label for="rbWarningTemplate"><dw:TranslateLabel ID="TranslateLabel3" Text="Template based warnings" runat="server" /></label>                                
                                <div id="templateContainer" runat="server" style="margin:10px 0px 0px 20px;">
                                    <dw:FileManager ID="templateSelector" runat="server" FixFieldName="true" ShowPreview="false" Folder="Templates/CookieWarning" ShowNothingSelectedOption="False" />
                                </div>
                                <br />                                
                                <input type="radio" runat="server" id="rbCustomUserNotifications"  name="UserNotificationGroup" />                            
                                <label for="rbCustomSet"><dw:TranslateLabel ID="TranslateLabel2" Text="Custom (set with Javascript or .Net)" runat="server" /></label>			                            			                                                    
                                <br />                                
			                </div>
				        <dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />

                        <dw:GroupBoxStart ID="GroupBoxStart1" runat="server" Title="Cookie deactivation" />	                            
                            <div style="padding:20px;">
                                <dw:SelectionBox ID="CookiesSelector" runat="server" LeftHeader="Functional cookies" RightHeader="Tracking cookies" TranslateHeaders="true" Width="250" Height="250"  />
                                <input type="hidden" name="CookiesSelectorValue" id="CookiesSelectorValue" value="" runat="server" />                            
                                <br />
                                
                                <div class="dwe dwe-values">
                                    <div class="dwe-values-add">
                                        <input type="text" id="customCookieText" value="" />
                                        <a title="Add" href="javascript:addCustomCookie();">&nbsp;</a><span style="margin-left:20px;"><dw:TranslateLabel ID="TranslateLabel4" Text="Add custom cookie to list" runat="server" /></span>                                        
                                    </div>
                                </div>
                                <br /> 

                                 <div class="dwe dwe-values">
                                    <div class="dwe-values-add">
                                        <asp:DropDownList ID="drCookieLifetime" runat="server" Width="252"></asp:DropDownList>
                                        <span style="margin-left:20px;"><dw:TranslateLabel ID="TranslateLabel5" Text="Cookie lifetime" runat="server" /></span>
                                    </div>
                                </div>
                                <br />
                            </div>
				        <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />                                                               
			        </td>
		        </tr>
            </table>            
            </div>        
        </asp:Panel>            

        <asp:Panel ID="pNoAccess" runat="server">
            <table border="0" cellpadding="6" cellspacing="6">
				<tr>
					<td>
                        <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
                        <script type="text/javascript">
                            Toolbar.setButtonIsDisabled('cmdSave', true);
                            Toolbar.setButtonIsDisabled('cmdSaveAndClose', true);
                        </script>
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <% 
        Translate.GetEditOnlineScript()
        %>        
        <asp:Literal ID="LoaderJavaScript" runat="server" />            
    </form>
</body>

<script type="text/javascript">
    SettingsPage.getInstance().initialize();
</script>

</html>
