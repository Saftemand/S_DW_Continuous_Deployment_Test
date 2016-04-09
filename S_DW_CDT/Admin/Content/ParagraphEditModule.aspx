<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="ParagraphEditModule.aspx.vb" Inherits="Dynamicweb.Admin.ParagraphEditModule" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="modules" TagName="ModulesList" Src="ParagraphListModules.ascx" %>
<%@ Register TagPrefix="modules" TagName="ModuleSettings" Src="ParagraphLoadModule.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title><dw:TranslateLabel Text="Settings" /></title>
		<dw:ControlResources runat="server" IncludePrototype="true">
		</dw:ControlResources>
		
		<link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="ParagraphEditModule.css" />
		<script src="ParagraphEvents.js" type="text/javascript"></script>
		<script src="ParagraphEditModule.js" type="text/javascript"></script>
    </head>
    <body onload="initForm();">
        <form id="paragraph_edit" runat="server" enableviewstate="false">
        
            <dw:Overlay ID="ParagraphEditModuleOverlay" runat="server"></dw:Overlay>

            <!-- 'Choose module' step: modules list -->
        
            <asp:PlaceHolder ID="phChooseModule" runat="server" Visible="false">
                <div class="content">
                    <dw:TabHeader ID="moduleTabs" ReturnWhat="all" runat="server" />
                    <table border="0" cellpadding="2" cellspacing="0" class="tabTable" style="cursor: default;">
                        <tr>
                            <td>
                                <br />
                                <div id="Tab1" style="display:">
                                    <table width="100%" border="0">
                                        <tr style="height: 500px; vertical-align: top">
                                            <td>
                                                <modules:ModulesList id="lstModules" runat="server" Columns="2" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <div id="Tab2" style="display:none">
                                    <table width="100%" border="0">
                                        <tr style="height: 500px; vertical-align: top">
                                            <td>
                                                <modules:ModulesList ID="lstModuleseCom" runat="server" Columns="2" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:PlaceHolder>
            
            <!-- End: 'Choose module' step -->
            
            <!-- 'Configure module' step: change module setting -->
            
            <asp:PlaceHolder ID="phConfigureModule" runat="server" Visible="false" EnableViewState="false">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td>
                            <dw:Toolbar ID="Toolbar" ShowStart="false" ShowEnd="false" runat="server">
                                <dw:ToolbarButton ID="cmdSaveAndClose" Image="SaveAndClose" Text="Gem og luk" 
                                    OnClientClick="submitForm(); return false;" runat="server" />
                                <dw:ToolbarButton ID="cmdRemoveModule" Image="DeleteGear" Text="Remove"
                                    OnClientClick="removeModule(); return false;" runat="server" />
                                <dw:ToolbarButton ID="cmdClose" Image="Delete" Text="Close" 
                                    OnClientClick="closeForm(); return false;" runat="server" />
                            </dw:Toolbar>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="innerContent" class="settingsContent" style="padding: 0px; display: none; height: 100px">
                                <modules:ModuleSettings id="mSettings" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>
            </asp:PlaceHolder>
            
            <!-- End: 'Configure module' step -->
            
            <input type="hidden" ID="ParagraphPageID" name="ParagraphPageID" value="" runat="server" />
            <input type="hidden" ID="PageID" name="PageID" value="" runat="server" />
            <input type="hidden" ID="ParagraphID" name="ParagraphID" value="" runat="server" />
            <input type="hidden" ID="ParagraphID2" name="ID" value="" runat="server" />
            <input type="hidden" ID="ModuleSystemName" name="ModuleSystemName" value="" runat="server" />
            
            <!-- Stores module settings passed from the external source (and to be loaded by module) -->
            <input type="hidden" ID="ExternalModuleSettings" name="ExternalModuleSettings" value="" runat="server" />
            
            <!-- Stores module system name for which external settings are loaded -->
            <input type="hidden" ID="ExternalModuleSettingsFor" name="ExternalModuleSettingsFor" value="" runat="server" />
            
            <!-- Parent window functions to be called after settings are saved (or module removed)  -->
            <input type="hidden" ID="OnSettingsSaved" name="OnSettingsSaved" value="moduleSaved" runat="server" />
            <input type="hidden" ID="OnModuleRemoved" name="OnModuleRemoved" value="" runat="server" />
            <input type="hidden" ID="OnLoaded" name="OnLoaded" value="" runat="server" />
            
            <!-- 'Remove module' confirmation message text -->
            <span id="mConfirmRemove" style="display: none">
		        <dw:TranslateLabel ID="lbConfirmDelete" Text="Fjern modul?" runat="server" />
		    </span>
            
        </form>
    </body>
</html>

<%Translate.GetEditOnlineScript()%>


