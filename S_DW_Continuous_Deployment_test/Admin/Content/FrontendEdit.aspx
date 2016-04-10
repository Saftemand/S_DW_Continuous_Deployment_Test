<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="FrontendEdit.aspx.vb" Inherits="Dynamicweb.Admin.FrontendEdit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>

	<dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="true">
	</dw:ControlResources>
	<link href="FrontendEdit.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="FrontendEdit.js"></script>

	<script type="text/javascript">
		function help() {
		    eval($('jsHelp').innerHTML);	
		}
	</script>

</head>
<body onload="init(<%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.Request("PageID"))%>);" style="overflow:hidden;">
<dw:Ribbonbar runat="server" ID="myribbon" HelpKeyword="page.paragraph.frontendEditNEW">
		<%--<dw:RibbonbarTab ID="RibbonbarTab1" Active="false" Name="Indhold" OnClientClick="content();" runat="server">
			<dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Indsæt">
					
				</dw:RibbonbarGroup>
				<dw:RibbonbarGroup ID="RibbonbarGroup2" runat="server" Name="Afsnit">
					
				</dw:RibbonbarGroup>
				<dw:RibbonbarGroup ID="RibbonbarGroup3" runat="server" Name="Side">
					
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup4" runat="server" Name="Optimering">
					
				</dw:RibbonbarGroup>
				<dw:RibbonbarGroup ID="RibbonbarGroup5" runat="server" Name="Help">
					
				</dw:RibbonbarGroup>
		</dw:RibbonbarTab>
		<dw:RibbonbarTab ID="RibbonbarTab2" Active="false" Name="Funktioner" runat="server" OnClientClick="content();">
		</dw:RibbonbarTab>--%>
		<dw:RibbonbarTab Active="true" Name="Rediger" runat="server">
			<dw:RibbonbarGroup runat="server" Name="Funktioner">
				<dw:RibbonbarButton runat="server" Text="Gem" Image="Save" OnClientClick="Save();" ID="Save">
				</dw:RibbonbarButton>
			</dw:RibbonbarGroup>
			<dw:RibbonbarGroup runat="server" Name="Edit">
				<dw:RibbonbarPanel runat="server">
				<div id="xToolbar" style="height:auto;width:570px;min-width:570px;"></div>
				</dw:RibbonbarPanel>
			</dw:RibbonbarGroup>
			<%--<dw:RibbonbarGroup ID="groupHelp" runat="server" Name="Help">
				<dw:RibbonbarButton ID="cmdHelp" runat="server" Text="Help" Image="Help" OnClientClick="help();">
				</dw:RibbonbarButton>
			</dw:RibbonbarGroup>--%>
		</dw:RibbonbarTab>
		
	</dw:Ribbonbar>
	
	<iframe src="/Default.aspx?ID=<%=Dynamicweb.Base.Request("PageID") %>&FrontendEdit=True" id="EditorFrame" width="100%" height="450" style="border: 0px;" frameborder="0"></iframe>
	
	<span id="mSaveChanges" style="display: none">
	    <dw:TranslateLabel ID="lbSaveChanges" Text="Save changes before reloading?" runat="server" />
	</span>
	
	<span id="jsHelp" style="display: none">
	    <%=Dynamicweb.Gui.Help("", "page.paragraph.frontendEditNEW")%>
	</span>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
