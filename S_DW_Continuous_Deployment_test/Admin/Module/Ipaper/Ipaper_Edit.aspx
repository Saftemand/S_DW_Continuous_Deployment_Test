<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="Ipaper_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Ipaper.Backend.Ipaper_Edit" %>
<%@Import namespace="Dynamicweb"%>
<%@Import namespace="Dynamicweb.Backend"%>	

<input type="hidden" name="Ipaper_Settings" value="IpaperLinkTemplate, IpaperID">

<%=Gui.MakeModuleHeader("Ipaper", "Ipaper")%>
	<br>
<table border="0"cellpadding="0"cellspacing="0"width="598">
	<tr>
		<td>
			<%=Gui.GroupBoxStart("Templates")%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width="170"><%= Translate.Translate("Link") %></td>
						<td><%=Gui.FileManager(prop.Value("IpaperLinkTemplate"),"Templates/Ipaper","IpaperLinkTemplate")%></td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
			<br />
			<%=Gui.GroupBoxStart("iPaper")%>
				<table cellpadding=2 cellspacing=0 border=0>
					<tr>
						<td width="170"><%= Translate.Translate("Vælg iPaper") %></td>
						<td>
							<select name="IpaperID" class="std">
								<%=getIpaperOptions()%>
							</select>
						</td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
		</td>
	</tr>
</table>
<%
Translate.GetEditOnlineScript()
%>