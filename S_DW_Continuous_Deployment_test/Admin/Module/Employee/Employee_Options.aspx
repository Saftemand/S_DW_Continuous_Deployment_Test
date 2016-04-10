<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Employee_Options.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Employee_Options" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<%=Gui.MakeHeaders("", Translate.Translate("Valgmuligheder"), "all")%>
			<TABLE class="TabTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<div id="Tab1" style="DISPLAY:"/>
				<tr valign="top">
					<td>&nbsp;</td>
					<td>
						<%=Gui.GroupBoxStart(Translate.Translate("Webservice"))%>
						<table>
							<tr>
								<td width="5">&nbsp;</td>
								<td width="170"><%=Translate.Translate("Krypteringsnøgle")%></td>
								<td><asp:textbox id=_encryptionKey runat="server" Text='<%# Field("EncryptionKey") %>' CssClass="std" maxLength = "50"></asp:textbox></td>
								<td></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.Translate("obligatoriske felter"))%>
						<table>
							<tr>
								<td width="5">&nbsp;</td>
								<td width="70"><%=Translate.Translate("Brugernavn")%></td>
								<td><asp:checkbox id="_reqUsername" runat="server"></asp:checkbox></td>
								<td width="50">&nbsp;</td>

								<td width="5">&nbsp;</td>
								<td width="70"><%=Translate.Translate("Password")%></td>
								<td><asp:checkbox id="_reqPassword" runat="server"></asp:checkbox></td>
								<td></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><%=Translate.Translate("Fornavn")%></td>
								<td><asp:checkbox id="_reqFName" runat="server"></asp:checkbox></td>
								<td></td>

								<td>&nbsp;</td>
								<td><%=Translate.Translate("Efternavn")%></td>
								<td><asp:checkbox id="_reqLName" runat="server"></asp:checkbox></td>
								<td></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><%=Translate.Translate("Stillingsbetegnelse")%></td>
								<td><asp:checkbox id="_reqJTitle" runat="server"></asp:checkbox></td>
								<td></td>

								<td>&nbsp;</td>
								<td><%=Translate.Translate("Initialer")%></td>
								<td><asp:checkbox id="_reqInitials" runat="server"></asp:checkbox></td>
								<td></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.Translate("Modul") & " " & Translate.Translate("lister"))%>
						<table>
							<tr>
								<td width="5">&nbsp;</td>
								<td width="170">
									<a href="Status_List.aspx"><u><%=Translate.Translate("Medarbejder")%> <%=Translate.Translate("status")%></u></a>
								</td>
								<td width="50"></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr valign="bottom">
					<td colspan="2" align="right">
						<table width="100%">
							<tr>
								<td colSpan="2">&nbsp;</td>
								<td vAlign="bottom" colSpan="3" align="right">
									<table id="Table3">
										<tr>
											<td align="right">
												<asp:Button id="_ok" runat="server" CssClass="buttonSubmit" Text="OK" OnCommand="OnSubmit"></asp:Button>
												<INPUT type="button" class="buttonSubmit" onclick="parent.document.location.href='Menu.aspx'" value="Cancel" id="cancelbutton" name="cancelbutton">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</TABLE>
		</form>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
