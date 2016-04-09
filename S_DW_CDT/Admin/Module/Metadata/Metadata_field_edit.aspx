<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Metadata_field_edit.aspx.vb" Inherits="Dynamicweb.Admin.Metadata.Metadata_field_edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Metadata module</title>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<%=Gui.MakeHeaders("Metadata module", "Edit","all")%>
		<table class="TabTable" style="HEIGHT: 180px" cellSpacing="0" cellPadding="0" border="0">
			<form id="Form1" method="post" runat="server">
				<TBODY>
					<tr>
						<td>
							<%=Gui.GroupBoxStart("Field edit")%>
							<table border="0" cellpadding="0" width="580">
								<tr>
									<td width="170">
										&nbsp;
									</td>
									<td>
										<asp:TextBox id="txValue" Runat="server" CssClass="std"></asp:TextBox>
										<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="*"
											ControlToValidate="txValue"></asp:RequiredFieldValidator>
									</td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right">
						    <table><tr><td>
							<input type="submit" id="btnOk" class="buttonSubmit" value="Ok" runat="server" />
							<input type="button" id="btnCancel" class="buttonSubmit" value="Cancel" onclick="location.href='Metadata_module.aspx'" />
							</td>
                            <%=Gui.HelpButton("form", "modules.metadata.general.field.edit")%>
                            </tr>
                            </table>
                        </td>
					</tr>
				</TBODY>
			</form>
		</table>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
