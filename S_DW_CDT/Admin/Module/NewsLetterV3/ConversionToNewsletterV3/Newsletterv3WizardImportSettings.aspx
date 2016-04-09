<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Newsletterv3WizardImportSettings.aspx.vb" Inherits="Dynamicweb.Admin.Newsletterv3WizardImportSettings" %>

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
<body>
    <form id="form1" runat="server">
    <div>
        <div class="header">
            <h3><dw:TranslateLabel runat="server" Text="Import settings" /></h3>
        </div>
        <div class="mainArea">                        
            <div class="cbText">
                <dw:CheckBox ID="cbAddCategoryToUsers" runat="server" Checked="true" />
                <dw:TranslateLabel runat="server" Text="Add category to users that are already in the system" />
            </div>
            <div class="cbDescription">
                <dw:TranslateLabel runat="server" Text="Select this field to add imported recipients that are already in the system to the selected categories." /><br />
                <dw:TranslateLabel runat="server" Text="This means that existing recipients are not imported once more but only added to the category from" /><br />
                <dw:TranslateLabel runat="server" Text="within the system." />
            </div>            
            <div class="cbText">
                <dw:CheckBox ID="cbActivateImportedUsers" runat="server" Checked="true" />
                <dw:TranslateLabel runat="server" Text="Activate all imported users" CssClass="cbText" />
            </div>
            <div class="cbDescription">
                <dw:TranslateLabel runat="server" Text="An imported recipient can be marked as inactive in the import source and will not automatically" /><br />
                <dw:TranslateLabel runat="server" Text="become active after import. Only if you check the field Activate all imported users will all of the" /><br />
                <dw:TranslateLabel runat="server" Text="imported recipients become active. If an imported recipient already exists in the system as inactive," /><br />
                <dw:TranslateLabel runat="server" Text="he will also become active after the import when Activate all imported users is checked" /><br />
                <dw:TranslateLabel runat="server" Text="(activation of existing inactive recipients will be recorded in the log)." />
            </div>            
            <input type="hidden" id="goBack" runat="server" />
        </div>
        <div class="footer">
            <input type="submit" value="Previous" id="backButton" onclick="$('goBack').value = 'true';" />
            <input type="submit" value="Next" id="forwardButton" />
        </div>
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
