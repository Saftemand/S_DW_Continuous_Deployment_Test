<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCButtons.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.UCButtons" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<script type="text/javascript" src="UCButtons.js"></script>
<%  If Not Dynamicweb.Gui.NewUI Then%>
    <table cellspacing="0" cellpadding="0" border="0" height="50" width="100%">
	    <tr width="100%" height="100%">
		    <td align="center" width="75" valign="top">
			    <a href="javascript:Configuration();"><img src="/Admin/images/ControlPanel.gif" alt="" width="32" height="32" border="0"><br>
				    <%=Translate.Translate("Indstillinger")%>
			    </a>
		    </td>
		    <%If Base.HasAccess("StatisticsExtended", "") Then%>
		    <td align="center" width="75" valign="top">
			    <a href="javascript:ExportCSV();"><img src="/Admin/images/Icons/Statistics_export.gif" alt="" width="32" height="32" border="0"><br>
				    <%=Translate.Translate("Eksporter")%>
			    </a>
		    </td>
		    <%End If%>
		    <td align="right" valign="top">
			    <a href="#" onClick="<%=Gui.Help("statv2", "modules.statistics")%>;"><img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" width="32" height="32" border="0"><br>
				    <%=Translate.Translate("Hjælp")%>
			    </a>
		    </td>
    </tr>
    </table>
<%else %>
    <script type="text/javascript">
        function help() {
		           <%=Gui.Help("statv2", "modules.statistics")%>
	            }
	</script>
    <dw:Toolbar ID="Toolbar1" runat="server" ShowStart="true" ShowEnd="false">
	    <dw:ToolbarButton ID="ToolbarButton1" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/preferences.png" Text="Indstillinger" ShowText="true" OnClientClick="Configuration();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton5" runat="server" Image="DocumentUp" Text="Eksporter" ShowText="true" OnClientClick="ExportCSV();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton6" runat="server" Image="Help" Text="Hjælp" ShowText="true" OnClientClick="help();">
	    </dw:ToolbarButton>
    </dw:Toolbar>
<%End If%>
<%Translate.GetEditOnlineScript()%>