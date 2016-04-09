<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SystemSetup_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemSetup_cpl" %>

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
            <%=Gui.help("", "administration.managementcenter.system.setup") %>
        }

	</script>

</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
	<div id="PageContent">
		<table border="0" cellpadding="2" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<%	
						Response.Write(Gui.GroupBoxStart(Translate.Translate("http")))
					%><table>
						<tr>
							<td width="170"></td>
							<td>
								<input id="/Globalsettings/System/http/DisableBaseHrefPort" <%=IIf(Base.GetGs("/Globalsettings/System/http/DisableBaseHrefPort") = "True", "checked", "")%> name="/Globalsettings/System/http/DisableBaseHrefPort" type="checkbox" value="True">
								<label for="/Globalsettings/System/http/DisableBaseHrefPort">
									<%=Translate.Translate("Disable portnumber in base href and CartV2 redirects")%>
								</label>
							</td>
						</tr>
						<tr>
							<td width="170"></td>
							<td>
								<input id="/Globalsettings/System/http/AddLastModifiedHeader" <%=IIf(Base.GetGs("/Globalsettings/System/http/AddLastModifiedHeader") = "True", "checked", "")%> name="/Globalsettings/System/http/AddLastModifiedHeader" type="checkbox" value="True">
								<label for="/Globalsettings/System/http/AddLastModifiedHeader">
									<%=Translate.Translate("Add last modified header")%>
								</label>
							</td>
						</tr>
					</table>
					<%
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Mailserver")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						
						<tr>
							<td width="170">
								<%=Translate.Translate("Server")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/MailServer/Server")%>" name="/Globalsettings/System/MailServer/Server" /></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Port")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/MailServer/Port")%>" name="/Globalsettings/System/MailServer/Port" /> <small>(25)</small></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Brugernavn")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/MailServer/Username")%>" name="/Globalsettings/System/MailServer/Username" autocomplete="off" /></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Kodeord")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/MailServer/Password")%>" name="/Globalsettings/System/MailServer/Password" autocomplete="off" /></td>
						</tr>
						<tr>
							<td width="170"></td>
							<td><input id="/Globalsettings/System/MailServer/UseSll" <%=IIf(Base.GetGs("/Globalsettings/System/MailServer/UseSll") = "True", "checked", "")%> name="/Globalsettings/System/MailServer/UseSll" type="checkbox" value="True" />
							<label for="/Globalsettings/System/MailServer/UseSll"><%=Translate.Translate("SSL")%> <small></small></label>
							</td>
						</tr>
						<tr>
							<td width="170"></td>
							<td><input id="/Globalsettings/System/MailServer/DoNotUsePickup" <%=IIf(Base.GetGs("/Globalsettings/System/MailServer/DoNotUsePickup") = "True", "checked", "")%> name="/Globalsettings/System/MailServer/DoNotUsePickup" type="checkbox" value="True" />
							<label for="/Globalsettings/System/MailServer/DoNotUsePickup"><%=Translate.Translate("Do not use SMTP pickup directory")%> <small>(<%=Translate.Translate("Not newsletters")%>)</small></label>
							</td>
						</tr>
					</table>
					<%	
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Google")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Google sitemap verification token (verify-v1)")%>
							</td>
							<td>
								<input id="DWverification" class="std" maxlength="255" name="/Globalsettings/System/SEO/verifyv1" type="text" value="<%=Base.GetGs("/Globalsettings/System/SEO/verifyv1")%>" /> 
							</td>
						</tr>
					</table>
					<%	
						Response.Write(Gui.GroupBoxEnd)
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Active Directory")))
						If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" AndAlso Modules.UserManagement.License.IsUsingUserManagement Then
							Base.SetGs("/Globalsettings/Modules/Users/UseExtendedComponent", "False")
						End If
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("ADSI-Domain")%></td>
							<td>
								<input type="text" maxlength="255" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> class="std" value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/ADSI-Domain")%>" name="/Globalsettings/System/ActiveDirectory/ADSI-Domain" id="DWadsidomain"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("ADSI-Domain 2")%></td>
							<td>
								<input type="text" maxlength="255" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> class="std" value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/ADSI-Domain2")%>" name="/Globalsettings/System/ActiveDirectory/ADSI-Domain2" id="DWadsidomain2"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Brugernavn")%></td>
							<td>
								<input type="text" maxlength="255" class="std" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JSTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/UserName")%>" name="/Globalsettings/System/ActiveDirectory/UserName" id="DWadsidomainUserName"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Adgangskode")%></td>
							<td>
								<input type="password" class="std" <%If Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent") = "True" Then Response.Write("disabled Title='" & Translate.JsTranslate("Fravælg udvidet brugerstyrings komponent") &  "'")%> value="<%=Base.GetGs("/Globalsettings/System/ActiveDirectory/Password")%>" name="/Globalsettings/System/ActiveDirectory/Password" id="DWadsidomainPassword"></td>
						</tr>
					</table>
					<%	
						Response.Write(Gui.GroupBoxEnd)
					    Response.Write(Gui.GroupBoxStart(Translate.Translate("Sprog")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Domæne > 255 tegn")%></td>
							<td>
								<%=DomainMoreThan255()%></td>
						</tr>
					</table>
					<%	
						Response.Write(Gui.GroupBoxEnd)
					%>

					<%
						If Dynamicweb.Backend.User.Current.IsAngel Then
							Response.Write(Gui.GroupBoxStart("Lock solution"))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"></td>
							<td><input id="Checkbox1" <%=IIf(Base.GetGs("/Globalsettings/System/dblgnforna") = "True", "checked", "")%> name="/Globalsettings/System/dblgnforna" type="checkbox" value="True" />
							<label for="Checkbox1">Disable backend login for non-angel and warn.</label>
							</td>
						</tr>
						<tr>
							<td width="170"></td>
							<td><input id="Checkbox3" <%=IIf(Base.GetGs("/Globalsettings/System/dblgnfornafe") = "True", "checked", "")%> name="/Globalsettings/System/dblgnfornafe" type="checkbox" value="True" />
							<label for="Checkbox3">Shutdown frontend.</label>
							</td>
						</tr>
						<tr>
							<td width="170">Message (Frontend and Backend)</td>
							<td><input id="Text1" class="std" maxlength="255" name="/Globalsettings/System/dblgnfornafemsg" type="text" value="<%=Base.GetGs("/Globalsettings/System/dblgnfornafemsg")%>" />
							</td>
						</tr>
					</table>

					<%	
						Response.Write(Gui.GroupBoxEnd)
					End If
					%>

					<%
						If Not Database.IsAccess() Then
							Response.Write(Gui.GroupBoxStart(Translate.Translate("Ret DB felter")))
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Statistik, udv. nyhedsbrev")%></td>
							<td>
								<%=ExtendedNewsletterStat()%></td>
						</tr>
					</table>
					<%	
						Response.Write(Gui.GroupBoxEnd)
					End If
					%>
				</td>
			</tr>
		</table>
	</div>
        <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
        %>
</asp:Content>
