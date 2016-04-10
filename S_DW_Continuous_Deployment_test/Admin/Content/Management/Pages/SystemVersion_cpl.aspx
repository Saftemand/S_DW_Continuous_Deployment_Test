<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SystemVersion_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemVersion_cpl" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

	<script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
             document.getElementById('MainForm').submit();
        }

        page.onHelp = function() {
            <%=Gui.help("", "administration.managementcenter.system.version") %>
        }
	</script>

</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div id="PageContent">
		<table border="0" cellpadding="2" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<dw:GroupBoxStart ID="gbVersionStart" Title="Version" runat="server" />
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Version")%>
							</td>
							<td>
                                <% If Modules.UserManagement.User.GetCurrentUser.IsAngel Then%>
								<input id="DWCurrentVersion" class="std" maxlength="255" name="/Globalsettings/System/Version/CurrentVersion" type="text" value="<%=Base.GetGs("/Globalsettings/System/Version/CurrentVersion")%>" />
                                <% Else%>
                                <input id="DWCurrentVersion" class="std" maxlength="255" name="/Globalsettings/System/Version/CurrentVersion" disabled="disabled" type="text" value="<%=Base.GetGs("/Globalsettings/System/Version/CurrentVersion")%>" />
                                <% End If%>
							</td>
						</tr>
						<% If Modules.UserManagement.User.GetCurrentUser.IsAngel Then%>
						<tr>
							<td width="170"></td>
							<td>
								<%=Gui.CheckBox(Base.GetGs("/Globalsettings/System/Version/Oem"), "/Globalsettings/System/Version/Oem")%>
								<label for="/Globalsettings/System/Version/Oem">
									<dw:TranslateLabel ID="lbOEM" Text="OEM" runat="server" />
								</label>
							</td>
						</tr>                        
						<%	End If%>                        
                        <tr>
                            <td colspan="2">
                                <dw:List ID="lstVersions" ShowPaging="false" NoItemsMessage="" ShowTitle="false" ShowCollapseButton="false" runat="server">
                                    <Columns>
                                        <dw:ListColumn ID="colLimit" Name="Limit" Width="200" runat="server"/>
                                        <dw:ListColumn ID="colMaxAllowed" Name="Max allowed" Width="80" runat="server" ItemAlign="Center" />
                                        <dw:ListColumn ID="colCount" Name="Current count" Width="110" runat="server" ItemAlign="Center"/>
                                        <dw:ListColumn ID="colCanCreate" Name="Editor can create" runat="server" ItemAlign="Center"/>
                                    </Columns>
                                </dw:List>
                            </td>
                        </tr>
					</table>
					<dw:GroupBoxEnd ID="gbVersionEnd" runat="server" />
				</td>
			</tr>
		</table>
	</div>
	<%  				Dynamicweb.Backend.Translate.GetEditOnlineScript()
	%>
</asp:Content>
