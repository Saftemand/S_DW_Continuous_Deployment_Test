<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" Codebehind="EditingMeta_cpl.aspx.vb" Inherits="Dynamicweb.Admin.EditingMeta_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
	<script type="text/javascript">
	    var page = SettingsPage.getInstance();
        
        page.onSave = function() {
	        page.submit();
        }
</script>

</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
	    <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		    <tr>
			    <td valign="top">
				    <dw:GroupBox ID="GroupBox2" runat="server" Title="Meta" DoTranslation="true">
				        <table cellpadding='2' cellspacing='0' border='0' width='100%'>
							<tr>
								<td width="170"></td>
								<td>
									<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateDublinCore") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateDublinCore" name="/Globalsettings/Settings/Performance/ActivateDublinCore"><label for="/Globalsettings/Settings/Performance/ActivateDublinCore"><%=Translate.Translate("Aktiver Dublin Core")%></label></td>
							</tr>
						</table>		
				    </dw:GroupBox>
			    </td>
		    <tr>
	    </table>
    </div>
    <%
        Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</asp:Content>