<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" Codebehind="Emoticon_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Emoticon_Edit" %>
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
			<dw:tabheader id="Tabs" title="Edit emoticon" runat="server" Headers="Edit"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0">
					<TR>
						<TD vAlign="top">
							<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
						</TD>
					</TR>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td vAlign="top" width="610">
							<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td width="108">&nbsp;</td>
								</tr>
								<tr>
									<td height="27" width="108">&nbsp;<%=Translate.Translate("Kombination")%></td>
									<td width="303" height="27"><asp:TextBox ID="txCombination" MaxLength="30" Runat="server" CssClass="std"></asp:TextBox></td>
								</tr>
								<tr>
									<td width="108" height="19">&nbsp;<%=Translate.Translate("Ikon")%></td>
									<td height="19" width="303"><dw:FileManager ID="fmIcon" Runat="server" CssClass="std"></dw:FileManager></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><asp:Button ID="btnSubmit" CausesValidation="True" Runat="server" CssClass="ButtonSubmit"></asp:Button></td>
									<td height="20">&nbsp;</td>
									<td width="20" height="23"><%=Gui.Button(Translate.Translate("Annuller"), "location='Settings.aspx?Tab=1'", 0)%></td>
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