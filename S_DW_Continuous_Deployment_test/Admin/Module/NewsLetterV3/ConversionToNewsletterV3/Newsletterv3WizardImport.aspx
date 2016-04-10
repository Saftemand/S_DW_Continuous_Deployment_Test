<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Newsletterv3WizardImport.aspx.vb" Inherits="Dynamicweb.Admin.Newsletterv3WizardImport" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" />    
    <link rel="StyleSheet" href="/Admin/Module/NewsLetterV3/ConversionToNewsletterV3/css/wizard.css" type="text/css" />
    <script type="text/javascript">
        function refreshModules() {
            if (top != null && top.document != null) {
                top.document.getElementById("MainFrame").cols = "0,*";
                if (document.getElementById("treeContainer")) {
                    document.getElementById("treeContainer").style.display = "";
                }
                top.right.location = '/Admin/Content/Moduletree/Default.aspx?treeMode=ALL';                
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="header">
            <h3><dw:TranslateLabel runat="server" Text="Import" /></h3>
        </div>
        <div class="mainArea">
            <p>
                <dw:TranslateLabel runat="server" Text="You are now ready to import your newsletter groups and users from Newsletter Extended to " /><br />
                <dw:TranslateLabel runat="server" Text="Newsletter v3." />
            </p>
            <p>
                <dw:TranslateLabel runat="server" Text="- The Newsletter statistics will be reset." /><br />
                <dw:TranslateLabel runat="server" Text="- The previous newsletters will not be available" />
            </p>
            <p>
                <dw:TranslateLabel runat="server" Text="WARNING: You cannot change back to the previous Newsletter Extended module." />
            </p>
            <input type="hidden" id="goBack" runat="server" />
        </div>
        <div class="footer">
            <input type="submit" value="Previous" id="backButton" onclick="$('goBack').value = 'true';" />
            <input type="submit" value="Import" id="forwardButton" />
        </div>
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
