<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sitemap_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Sitemap_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><%=Translate.JsTranslate("Sitemap")%></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="false" ></dw:ControlResources>
	<script type="text/javascript" language="javascript">
	    function doApplySitemap() {
	        new Ajax.Updater({ success: "sitemapAction" },
	                    "/Admin/Module/Sitemap_cpl.aspx",
	                    { method: "post", parameters: { applySiteMap: 1} });
	        return false;
	    }
	</script>
</head>

<body>
<div id="PageContent" style="min-width:600px;" >

    <form id="Form1" name="Form1" runat="server" >
        
        <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
            <dw:ToolbarButton ID="cmdCancel" runat="server" Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
        </dw:Toolbar>

        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="Sitemap V2" runat="server" />
        </h2>

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tbody>	
		    <tr>
			    <td height="95%" valign="top">			
			    <%=Gui.MakeModuleHeader("SitemapV2", "Sitemap V2", False)%>		
		        <%=Gui.GroupBoxStart(Translate.Translate("Advanced settings"))%>
                <div id="sitemapAction" class="buttonsRow">
                    <input type="button" value="<%=Translate.Translate("Apply Sitemap to all pages") %>" onclick="doApplySitemap(); return false;" />
                </div>
		        <%=Gui.GroupBoxEnd()%>
			    </td>
		    </tr>
            </tbody>
        </table>
    </form>

</div>
<%  Translate.GetEditOnlineScript()%>
</body>
</html>
