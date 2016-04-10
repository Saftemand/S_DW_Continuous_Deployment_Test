<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Rank_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Rank_Edit" %>
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
			<dw:tabheader id="Tabs" title="Edit rank" runat="server" Headers="Edit"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0" height="176">
					<TR>
						<TD vAlign="top">
							<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
						</TD>
					</TR>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td vAlign="top" height="106">
							<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150" height="20">&nbsp;<%=Translate.Translate("Titel")%></td>
									<td width="255" height="20"><asp:TextBox ID="txName" MaxLength="100" Runat="server" CssClass="std"></asp:TextBox></td>
								</tr>
								<tr>
									<td>&nbsp;<%=Translate.Translate("Point")%></td>
									<td width="255"><asp:TextBox ID="txCount" MaxLength="6" Runat="server" CssClass="std"></asp:TextBox></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><asp:Button ID="btnSubmit" CausesValidation="True" Runat="server" Text="OK" CssClass="ButtonSubmit"></asp:Button></td>
									<td height="20">&nbsp;</td>
									<td width="20" height="23"><%=Gui.Button(Translate.Translate("Luk"), "location='Settings.aspx?Tab=2'", 0)%></td>
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