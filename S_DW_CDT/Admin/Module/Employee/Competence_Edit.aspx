<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Competence_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Competence_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(_header, _tab_header, "all")%>
		<table class="tabTable" cellSpacing="0" cellPadding="0" border="0">
			<div id="Tab1" style="DISPLAY:"/>
			<form id="Form1" method="post" runat="server">
				<TBODY>
					<tr>
						<td vAlign="top">
							<%=Gui.GroupBoxStart("General")%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td width="170"><%=Translate.Translate("Navn")%></td>
									<td><asp:TextBox ID="_txName" CssClass="std" MaxLength="100" Runat="server"></asp:TextBox></td>
									<td align="left"><asp:RequiredFieldValidator ID="_NameValidator" Display="Dynamic" Runat="server" ErrorMessage="- Required field"
											ControlToValidate="_txName"></asp:RequiredFieldValidator>
									</td>
								</tr>
								<tr>
									<td></td>
									<td><asp:CheckBox ID="_chkActive" runat="server"></asp:CheckBox><label for="_chkActive"><%=Translate.Translate("Aktiv")%></label></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
						</td>
					</tr>
					<tr valign="bottom">
						<td colspan="2" align="right">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td align="right"><asp:Button ID="_btnSubmit" Text="OK" CssClass="buttonSubmit" Runat="server"></asp:Button></td>
									<td width="5"></td>
									<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "javascript:history.back(1);", 0)%></td>
									<td width="10"></td>
								</tr>
								<tr>
									<td colspan="2" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
			</form>
			</TBODY>
		</table>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
