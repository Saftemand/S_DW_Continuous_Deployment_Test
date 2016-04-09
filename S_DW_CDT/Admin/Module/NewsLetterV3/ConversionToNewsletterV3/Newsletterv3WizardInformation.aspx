<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Newsletterv3WizardInformation.aspx.vb" Inherits="Dynamicweb.Admin.Newsletterv3WizardInformation" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" />    
    <link rel="StyleSheet" href="/Admin/Module/NewsLetterV3/ConversionToNewsletterV3/css/wizard.css" type="text/css" />
</head>
<body style="background-color: #f0f0f0; width: 530px; border-right-width: 0px; height: auto;">
    <form id="form1" runat="server">    
    <div>
        <div class="header">            
            <h3><dw:TranslateLabel runat="server" Text="Information" /></h3>
        </div>
        <div class="mainArea">
            <p>
                <dw:TranslateLabel runat="server" Text="This wizard will help you make the import of groups and users from the" /><br />
                <dw:TranslateLabel runat="server" Text="Newsletter Extended module to the Newsletter v3 module." />            
            </p>
            <p>
                <dw:TranslateLabel runat="server" Text="WARNING: You cannot change back to the previous Newsletter Extended module." />
            </p>            
            <asp:Panel runat="server" ID="pnlWarning" Visible="false" CssClass="cbText">
                <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align:middle;" />
		        <dw:TranslateLabel runat="server" Text="This solution has more than 25.000 users in Newsletter Extended." /><br />
                <dw:TranslateLabel runat="server" Text="We recommend you to contact the Dynamicweb Service Desk, that can help you " /><br />
                <dw:TranslateLabel runat="server" Text="with the conversion of your Newsletter module." />
            </asp:Panel>            
        </div>
        <div class="footer">
            <input type="submit" disabled="disabled" value="Previous" />
            <input type="submit" value="Next" id="forwardButton" /></div>
    </div>    
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
