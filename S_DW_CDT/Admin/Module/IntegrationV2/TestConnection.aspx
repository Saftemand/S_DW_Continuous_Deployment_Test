<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestConnection.aspx.vb" Inherits="Dynamicweb.Admin.TestConnection" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Test connection</title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
    </dw:ControlResources>    
    <script type="text/javascript" src="/Admin/Module/IntegrationV2/js/TestConnection.js"></script>
    <style type="text/css">
        #PageContent
        {
            overflow: auto;
        }
    </style>    
    <asp:Literal ID="litImagesFolderName" runat="server" />
    <asp:Literal ID="litScript" runat="server" />    
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onCancel = function () {
            document.location = '<%= UrlReferrer.Value%>';             
        }

        // Open trace route dialog 
        function tracertOpen() {
            var host = document.getElementById("txtUrl").value
            var timeout = document.getElementById("traceTimeout").value
            var hops = document.getElementById("traceHops").value
            var timeoutIsNum = /^\d+$/.test(timeout);
            var hopsIsNum = /^\d+$/.test(hops);

            // Hops and timeout only digits
            if (host !== "") {
                if (timeout === "" || hops === "" || timeoutIsNum === false || hopsIsNum === false) {
                    alert('<%=Translate.JsTranslate("Hops count and trace timeout should be only digits")%>')
                } else {
                    window.open("/Admin/Module/IntegrationV2/TraceRt.aspx?host=" + host + "&timeout=" + timeout + "&hops=" + hops, '<%=Translate.JsTranslate("Test route")%>', 'resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,minimize=no,location=no,width=900,height=600,left=200,top=120')
                }
            } else {
                    alert('<%=Translate.JsTranslate("Enter host name or IP Address")%>')
            }
        }
    </script>     	
</head>
<body style="overflow:hidden">
    <form id="MainForm" action="TestConnection.aspx" runat="server">        
        <asp:HiddenField ID="UrlReferrer" runat="server" />
        <div id="divToolbar" style="height:auto;min-width:600px;">
            <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">		        
		        <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="SettingsPage.getInstance().cancel()" ShowWait="True">
		        </dw:ToolbarButton>                
	        </dw:Toolbar>    	        
            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSubTitle" Text="Test connection" runat="server" />
            </h2>
        </div>
        <div style="width:600px;">
            <div id="PageContent">
            <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="Settings" />				        
            <table>
                <tr>
                    <td width="100">
                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Web service url" />
                    </td>
                    <td>
                        <input type="text" runat="server" id="txtUrl" class="NewUIinput" />                                
                    </td>
                </tr>
                <tr>
                    <td width="100">
                        <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Service secret" />
                    </td>
                    <td>
                        <input type="text" runat="server" id="txtSecret" class="NewUIinput" />                                
                    </td>
                </tr>
                <tr>
                    <td width="100">
                        <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Xml request" />
                    </td>
                    <td>
                        <textarea class="NewUIinput" id="XmlRequest" rows="10" cols="10"  runat="server"></textarea>                      
                    </td>
                </tr>
                <tr>
                    <td width="100">
                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Xml response" />
                    </td>
                    <td>
                        <textarea class="NewUIinput" id="XmlResponse" rows="10" cols="10"  runat="server"></textarea>                                
                    </td>
                </tr>
                <tr>
                    <td  width="100">
                        <input type="submit" value="<%=Translate.JsTranslate("Check connection")%>"  />    
                    </td>
                </tr>
                <tr>                    
                    <td>                    
                        <input type="button" value="<%=Translate.JsTranslate("Show trace information")%>" onclick="tracertOpen()"/>
                    </td>
                    <td>
                        <input type="text" runat="server" id="traceTimeout" class="NewUIinput" value="1000" maxlength="4" style="width:50px;" />
                        <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Trace hop time out (in ms)" />
                        <br />
                        <input type="text" runat="server" id="traceHops" class="NewUIinput" value="20" maxlength="2" style="width:50px;" />
                        <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Trace hops number" />
                    </td>
                    <td>
                        
                    </td>
                </tr>
            </table>       
            <dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />                                                
            </div>
        </div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
<script type="text/javascript">
    SettingsPage.getInstance().initialize();
</script>
</html>
