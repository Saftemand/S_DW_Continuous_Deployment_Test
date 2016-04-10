<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Metadata_options_edit.aspx.vb" Inherits="Dynamicweb.Admin.Metadata.Metadata_options_edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title><%=translate.translate("Metadata")%></title>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<%=Gui.MakeHeaders(translate.translate("Metadata"), translate.translate("Rediger"),"all")%>
		<table class="TabTable" style="HEIGHT: 180px" cellSpacing="0" cellPadding="0" border="0">
				<TBODY>
					<tr>
						<td>
							<%=Gui.GroupBoxStart(translate.translate("Valgmulighed"))%>
							<table border="0" cellpadding="0" width="570">
								<tr>
									<td width="170">
										&nbsp;
									</td>
									<td>
										<asp:TextBox id="txValue" MaxLength="255" Runat="server" CssClass="std"></asp:TextBox>
										<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txValue"></asp:RequiredFieldValidator>
									</td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right">
						    <table><tr><td>
							<input type="submit" id="btnOk" class="buttonSubmit" value="Ok" runat="server" NAME="Submit1" />
							<input type="button" id="btnCancel" class="buttonSubmit" value="<%=translate.translate("Annuller")%>" onclick="location.href='<%=String.Format("{0}Metadata_options.aspx?{1}", Dynamicweb.Metadata.Consts.ModulePath, Dynamicweb.Admin.Metadata.Metadata_options.GetPrfx())%>'" />
							</td>
                            <%=Gui.HelpButton("form", "modules.metadata.general.field.edit.option.edit")%>
                            </tr></table>
						</td>
					</tr>
				</TBODY>
		</table>
	</form>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
