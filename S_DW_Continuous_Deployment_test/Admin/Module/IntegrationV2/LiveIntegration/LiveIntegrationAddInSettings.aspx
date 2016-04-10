<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LiveIntegrationAddInSettings.aspx.vb" Inherits="Dynamicweb.Admin.LiveIntegrationAddInSettings" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Live Integration Add-In Settings</title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
    </dw:ControlResources>
    <script type="text/javascript" src="/Admin/Module/IntegrationV2/js/LiveIntegrationAddInSettings.js"></script>
    <script type="text/javascript" src="/Admin/Link.js"></script>
    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>
    <style type="text/css">
        #PageContent
        {
            width:600px;
            overflow: auto;                        
            margin: 0px 0px 0px 10px;
        }
    </style>
    <asp:Literal ID="litImagesFolderName" runat="server" />
    <asp:Literal ID="litScript" runat="server" />
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        page.onSave = function () { return save(false); };
        page.saveAndClose = function () { return save(true); };
        
        function save(close) {            
            var o = new overlay('saveOverlay');
            o.show();
            var url = "/Admin/Module/IntegrationV2/LiveIntegration/LiveIntegrationAddInSettings.aspx?Save=True";
            if (close)
                url += "&Close=True";
            $("MainForm").action = url;
            $("MainForm").submit();
        }        
    </script>
</head>
<body>
    <form id="MainForm" runat="server" action="LiveIntegrationAddInSettings.aspx" name="frmGlobalSettings">
    <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />
    <input id="hiddenCheckboxNames" type="hidden" name="CheckboxNames" />
    <dw:Overlay ID="saveOverlay" Message="Please wait"  runat="server"></dw:Overlay>
    <div id="divToolbar" style="height:auto;min-width:600px;">
        <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
		    <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save" OnClientClick="SettingsPage.getInstance().save();" ShowWait="False">
		    </dw:ToolbarButton>
		    <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="SaveAndClose" Text="Save and close" OnClientClick="SettingsPage.getInstance().saveAndClose();" ShowWait="False">
		    </dw:ToolbarButton>
		    <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="SettingsPage.getInstance().cancel()" ShowWait="True">
		    </dw:ToolbarButton>
            <dw:ToolbarButton ID="showHistoryLog" runat="server" Divide="None" Image="Information" Text="Show log">
		    </dw:ToolbarButton>
            <dw:ToolbarButton ID="downloadLog" runat="server" Divide="None" Image="Download" Text="Download log">
		    </dw:ToolbarButton>
            <dw:ToolbarButton ID="cmdTestConnection" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_LanguageManagement_small.png"  Text="Test connection" OnClientClick="window.location.href = '/Admin/Module/IntegrationV2/TestConnection.aspx';">
		    </dw:ToolbarButton>
		    <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="SettingsPage.getInstance().help();">
		    </dw:ToolbarButton>                        
	    </dw:Toolbar>    	        
        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSubTitle" Text="Live Integration Add-In Settings" runat="server" />
        </h2>
    </div>

    <div id="PageContent">    
        <dw:GroupBox ID="GroupBox1" runat="server">        
            
            <asp:Literal ID="checkWebServiceConnectionStatus" runat="server"></asp:Literal>
            
            <dw:Infobar ID="errorBar" runat="server" Visible="false"></dw:Infobar>
            <asp:Literal ID="addInSelectorScripts" runat="server"></asp:Literal>
            <de:AddInSelector ID="addInSelector" runat="server" UseLabelAsName="True" AddInShowNothingSelected="false" 
                AddInTypeName="Dynamicweb.eCommerce.Integration.BaseLiveIntegrationAddIn" AddInShowSelector="false" AddInShowFieldset="false" />
            <asp:Literal ID="addInSelectorLoadScript" runat="server"></asp:Literal>
        </dw:GroupBox>        
    </div>

    <dw:PopUpWindow ID="historyLogPopup" AutoReload="true" Width="800" Height="560" ShowCancelButton="false" ShowOkButton="false" ShowClose="True" Title="Live Integration add-in log" runat="server" IsModal="False" AutoCenterProgress="True" />

    <% 
        Translate.GetEditOnlineScript()
    %>    
    </form>
</body>
<script type="text/javascript">
    SettingsPage.getInstance().initialize();
</script>
</html>
