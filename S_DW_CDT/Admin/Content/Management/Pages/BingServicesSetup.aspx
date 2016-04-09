<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BingServicesSetup.aspx.vb" Inherits="Dynamicweb.Admin.BingServicesSetup" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title>Bing setup</title>
        <dw:ControlResources ID="ctlResource" IncludePrototype="false" IncludeScriptaculous="false" IncludeUIStylesheet="true" runat="server" />
        <link rel="Stylesheet" href="ServicesSetup.css" />
        <script src="BingServicesSetup.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
        function help(){
		    <%=Dynamicweb.Gui.Help("", "system.externalservices.bing", "en") %>
	    }
        </script>
        
    </head>
    <body>
        <form id="bingSetupForm" runat="server">
            <dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" >
	            <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save" Text="Save"  ShowWait="True" />
                <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="SaveAndClose" Text="Save & Close" ShowWait="True" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="cancel();" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="TranslateLabel1" Text="Bing Setup" runat="server" />
	        </h2>
            <dw:GroupBoxStart ID="gbBingSetup" Title="Bing Keywords Suggestion setup" runat="server" />
            <table cellspacing="0" cellpadding="2" border="0" class="tabTable">
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lbAppToken" Text="Application Token" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txAppToken" Width="200" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lbCustomerAccID" Text="Customer Account ID" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txCustomerAccID" Width="200" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lbCustomerID" Text="Customer ID" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txCustomerID" Width="200" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lblDeveloperToken" Text="Developer Token" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txDeveloperToken" Width="200" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lblUsername" Text="Username" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txUsername" Width="200" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td width="150">
                        <dw:TranslateLabel ID="lblPassword" Text="Password" runat="server" />
                    </td>
                    <td width="200">
                        <asp:TextBox ID="txPassword" Width="200" runat="server" />
                    </td>
                </tr>
            </table>
            <dw:GroupBoxEnd ID="gbBingSetupEnd" runat="server" />
            <dw:GroupBoxStart ID="gbTestStart" runat="server" />
            <div id="TestContainer">
                <div id="Test">
                    <input type="text" id="textTest" value="Test" /><input type="button" id="buttonTEstBing" Value="<%=Dynamicweb.Backend.Translate.Translate("Test Bing")%>" onclick="bingTest();" >
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
