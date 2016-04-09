<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Ban_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Ban_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Ban_Edit</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" Headers="Rediger IP" ToolTip="Rediger IP"></dw:tabheader>
			<table cellspacing="0" class="tabtable" cellpadding="0" border="0" width="598">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td valign="top">
						<dw:groupboxstart id="SettingsStart" runat="server" title="Indstillinger"></dw:groupboxstart>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="Addresslabel" runat="server" Text="IP"></dw:translatelabel></td>
								<td><asp:TextBox ID="txAddress" CssClass="std" MaxLength="100" Runat="server"></asp:TextBox></td>
								<td>
									<asp:RequiredFieldValidator ID="AddressValidator" ControlToValidate="txAddress" ErrorMessage="- required field"
										Display="Dynamic" Runat="server"></asp:RequiredFieldValidator>
									<asp:CustomValidator id="cusAddressValidator" OnServerValidate="ValidateAddress" ControlToValidate="txAddress" ErrorMessage=" - invalid value"
										Display="Dynamic" Runat="server"></asp:CustomValidator>
								</td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="ActiveLabel" runat="server" Text="Aktiv"></dw:translatelabel></td>
								<td><asp:CheckBox Style="align: abstop" ID="chkActive" Checked="True" Runat="server"></asp:CheckBox></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;<dw:translatelabel id="HintLabel" Runat="server" Text="(Brug [*] som wildcard)"></dw:translatelabel></td>
							</tr>
							<tr><td>&nbsp;</td></tr>
						</table>
						<dw:groupboxend id="SettingsEnd" runat="server"></dw:groupboxend>
						<br>
					</td>
				</tr>
				<tr>
					<td align="right" valign="bottom">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><asp:Button ID="btnOK" CausesValidation="True" Text="OK" CssClass="buttonsubmit" Runat="server"></asp:Button></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.translate("Annuller"), "location='Blog_List.aspx?Tab=2'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>