<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GoogleServicesSetup.aspx.vb" Inherits="Dynamicweb.Admin.GoogleServicesSetup" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title>WebDAV setup</title>
        <dw:ControlResources ID="ctlResource" IncludePrototype="false" IncludeScriptaculous="false" 
            IncludeUIStylesheet="true" runat="server" />
        <script src="GoogleServicesSetup.js" type="text/javascript"></script>
        <link rel="Stylesheet" href="ServicesSetup.css" />
        <script type="text/javascript" language="javascript">
        function help(){
		    <%=Dynamicweb.Gui.Help("", "system.externalservices.google", "en") %>
	    }
        </script>
    </head>
    <body>
        <form id="googleSetupForm" runat="server" >
            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false" >
	            <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save" ShowWait="True" />
                <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="SaveAndClose" Text="Save & Close" ShowWait="True" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="cancel();" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Google Setup" runat="server" />
	        </h2>
            <dw:GroupBoxStart ID="gbGoogleAdwordsSetup" Title="Google Adwords setup" runat="server" />
                <table cellspacing="0" cellpadding="2" border="0">
                    <tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbEmail" Text="Email" runat="server" />
                        </td>
                        <td width="200">
                            <asp:TextBox ID="txEmail" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbPassword" Text="Password" runat="server" />
                        </td>
                        <td width="200">
                            <asp:TextBox ID="txPassword" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbUserAgent" Text="User agent" runat="server" />
                        </td>
                        <td width="200">
                            <asp:TextBox ID="txUserAgent" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbDeveloperToken" Text="Developer Token" runat="server" />
                        </td>
                        <td width="200">
                            <asp:TextBox ID="txDeveloperToken" Width="200" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="lbApplicationToken" Text="Application Token" runat="server" />
                        </td>
                        <td width="200">
                            <asp:TextBox ID="txApplicationToken" Width="200" runat="server" />
                        </td>
                    </tr>
                </table>
            <dw:GroupBoxEnd ID="gbSettingsEnd" runat="server" />
            <dw:GroupBoxStart ID="gbTestStart" runat="server" />
            <div id="TestContainer">
                <div id="Test">
                    <input type="text" id="textTest" value="Test" /><input type="button" id="buttonTEstBing" Value="<%=Dynamicweb.Backend.Translate.Translate("Test Google")%>" onclick="googleTest();" >
                </div>
                <div id="divTestResult" >
                    <dw:TranslateLabel ID="testResultslbl" Text="Test Results: " runat="server" />
                    <div id="TestResult"></div>
                </div>
            </div>
            <dw:GroupBoxEnd ID="gbTestEnd" runat="server" />

        </form>
    </body>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
