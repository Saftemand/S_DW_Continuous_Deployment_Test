<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="Ban_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Ban_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HTML>
	<HEAD>
		<script src="Navigation.js" language="javascript"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body style="MARGIN-LEFT: 20px;">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Edit ban" runat="server" Headers="Edit"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0" height="184">
					<TR>
						<TD vAlign="top">
							<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
					</TR>
					<tr>
						<td vAlign="top" height="82">
							<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<%=Translate.Translate("Adresse")%></td>
									<td><asp:TextBox MaxLength="100" ID="txAddress" Runat="server" CssClass="std"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<%=Translate.Translate("Aktiv")%></td>
									<td><asp:CheckBox ID="txActive" Runat="server"></asp:CheckBox></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="20">&nbsp;</td>
								</tr>
								<tr>
									<td height="20"><asp:Button ID="btnSubmit" CausesValidation="True" Runat="server" Text="OK" CssClass="ButtonSubmit"></asp:Button></td>
									<td height="20">&nbsp;</td>
									<td width="20" height="23"><%=Gui.Button(Translate.Translate("Annuller"), "location='Settings.aspx?Tab=5'", 0)%></td>
									<td>&nbsp;</td>
									<td height="20">&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>