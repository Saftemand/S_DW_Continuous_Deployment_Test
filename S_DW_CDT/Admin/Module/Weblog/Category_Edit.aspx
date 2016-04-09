<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Category_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Category_Edit"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Category_Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" Headers="New category" ToolTip="New category"></dw:tabheader>
			<table cellspacing="0" class="tabTable" cellpadding="0" border="0" width="598">
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
								<td width="150">&nbsp;<dw:translatelabel id="Namelabel" runat="server" Text="Name"></dw:translatelabel></td>
								<td><asp:TextBox ID="txName" CssClass="std" MaxLength="100" Runat="server"></asp:TextBox></td>
								<td>
									<asp:RequiredFieldValidator ID="NameValidator" ControlToValidate="txName" ErrorMessage="- required field" Display="Dynamic"
										Runat="server"></asp:RequiredFieldValidator>
									<asp:CustomValidator id="cusNameValidator" OnServerValidate="ValidateName" ControlToValidate="txName"
										ErrorMessage=" - already exists" Display="Dynamic" Runat="server"></asp:CustomValidator>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
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
								<td><%=Gui.Button(Translate.translate("Annuller"), "location='Blog_List.aspx?Tab=3'", 0)%></td>
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
		<%
Translate.GetEditOnlineScript()
%>
		</FORM>
	</body>
</HTML>
