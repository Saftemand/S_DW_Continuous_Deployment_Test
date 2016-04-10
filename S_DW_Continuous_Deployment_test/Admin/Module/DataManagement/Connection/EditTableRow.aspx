<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditTableRow.aspx.vb" Inherits="Dynamicweb.Admin.EditTableRow" ValidateRequest="false"%>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
	
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
 
    <script type="text/javascript">
        var id = "<%=ItemId%>";
        var helpLang = "<%=helpLang %>";
        
        function save() {
            document.getElementById('Form1').action = "EditTableRow.aspx?ID=" + id + "&CMD=SAVE_TABLEROW&OnSave=Nothing";
            document.getElementById('Form1').submit();
        }
        function saveAndClose() {
            document.getElementById('Form1').action = "EditTableRow.aspx?ID=" + id + "&CMD=SAVE_TABLEROW&OnSave=Close";
            document.getElementById('Form1').submit();
        }
        function cancel() {
            document.getElementById('Form1').action = "EditTableRow.aspx?OnSave=Cancel";
            document.getElementById('Form1').submit();
        }
        function help() {
            window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=modules.datamanagement.general.connection.edit.row.edit&LanguageID=' + helpLang, 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes');
        }
    </script>
</head>

<body class="edit">
    <form id="Form1" runat="server">

        <dw:Ribbonbar ID="Ribbon" runat="server">
			<dw:RibbonbarTab ID="RibbonbarTab1" runat="server" Active="true" Name="Default">
			
                <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
					<dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" ID="Save" />
					<dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" ID="SaveAndClose" />
					<dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup ID="RibbonbarGroup2" runat="server" Name="Help">
					<dw:RibbonbarButton ID="HelpBut" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
				</dw:RibbonbarGroup>	
				
			</dw:RibbonbarTab>
        </dw:Ribbonbar>

        <dw:GroupBox ID="GroupBox2" runat="server" DoTranslation="true" Title="Indstillinger">
            <dw:FormGenerator ID="fg1" runat="server"></dw:FormGenerator>
        </dw:GroupBox>

    </form>
    
</body>
</html>
