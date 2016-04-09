<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="VoteVariant_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.VoteVariant_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<HTML>
	<HEAD>
		<script src="Navigation.js" language="javascript"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body style="MARGIN-LEFT: 20px;">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="<br>" runat="server" Headers="Edit"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px"  border="0">
					<TR>
						<TD vAlign="top">
							<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
						</TD>
					</TR>
					<tr>
						<td height="3">&nbsp;</td>
					</tr>
					<tr>
						<td vAlign="top">
							<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="TextLabel" runat="server" Text="Variant text"></dw:translatelabel></td>
									<td><asp:TextBox ID="txText" MaxLength="100" Runat="server" CssClass="std"></asp:TextBox></td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="CountLabel" runat="server" Text="Votes count"></dw:translatelabel></td>
									<td><asp:TextBox ID="txCount" MaxLength="6" Runat="server" CssClass="std"></asp:TextBox></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table cellSpacing="0" cellPadding="0" border="0">
								<TR>
									<td><asp:Button ID="btnSubmit" CssClass="buttonSubmit" Runat="server" Text="OK"></asp:Button></td>
									<td width="5">&nbsp;</td>
									<td><input type="button" id="btnCancel" class="buttonSubmit" value="<%=Translate.Translate("Annuller")%>" onclick="location = 'Thread_Edit.aspx?ThreadID=<%=_threadID%>';"></td>
									<td width="10">&nbsp;</td>
								</TR>
								<tr>
									<td height="5">&nbsp;</td>
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