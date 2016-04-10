<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="IntranoteIntegration_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Intranote.IntranoteIntegration_Edit" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<Input Type="Hidden" Name="IntranoteIntegration_Settings" Value="NormalTemplate, LinkMasterTemplate, LinkSingleTemplate">
<%=Gui.MakeModuleHeader("Ipaper", "Ipaper")%>
	<br>
<tr>
	<td>
		<table border="0" width="600" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<%= Gui.GroupBoxStart("Post Templates") %>
					<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td width="10">&nbsp;</td>
							<td width="170">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<TR>
							<TD></TD>
							<TD>Normal template</TD>
							<TD><%=Gui.FileManager(NormalTemplate, "Templates/IntranoteIntegration", "NormalTemplate") %></TD>
						</TR>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<TR>
							<TD></TD>
							<TD>Link Master template</TD>
							<TD><%=Gui.FileManager(LinkMasterTemplate, "Templates/IntranoteIntegration", "LinkMasterTemplate") %></TD>
						</TR>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<TR>
							<TD></TD>
							<TD>Link Single template</TD>
							<TD><%=Gui.FileManager(LinkSingleTemplate, "Templates/IntranoteIntegration", "LinkSingleTemplate") %></TD>
						</TR>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
					</table>
					<%= Gui.GroupBoxEnd() %>
                </td>
			</tr>
		</table>
	</td>
</tr>
