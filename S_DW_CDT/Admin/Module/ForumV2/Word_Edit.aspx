<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Word_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Word_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<HTML>
	<HEAD>
		<script language="javascript" src="Navigation.js"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body style="MARGIN-LEFT: 20px;">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" runat="server" Headers="Edit" ></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0" height="184">
					<TR>
						<TD vAlign="top">
							<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
						</TD>
					</TR>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td vAlign="top" height="82">
						   <dw:groupboxstart id="SettingsStart" title="Settings" runat="server" ></dw:groupboxstart>
							<table cellSpacing="0" cellPadding="0" width="100%" border="0" >
								<tr>
									<td >&nbsp;</td>
								</tr>
								<tr>
									<td width="171" height="18">&nbsp;<%=Translate.Translate("Ord", 2)%></td>
									<td width="261" height="18"><asp:textbox MaxLength="255" id="txWord" CssClass="std" Runat="server"></asp:textbox></td>
								</tr>
								<tr><td>&nbsp;</td></tr>
							</table>
						</td>
					</tr>
					<tr>
						<td vAlign="bottom" align="right">
							<table cellSpacing="0" cellPadding="0" border="0">
								<tr>
									<td><asp:button id="btnSubmit" CssClass="ButtonSubmit" Runat="server" Text="OK" CausesValidation="True"></asp:button></td>
									<td height="20">&nbsp;</td>
									<td width="20" height="23"><%=Gui.Button(Translate.Translate("Annuller"), "location='Settings.aspx?Tab=4'", 0)%></td>
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