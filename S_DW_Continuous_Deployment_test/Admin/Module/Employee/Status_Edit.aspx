<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Status_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Status_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Status_Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="TheForm" method="post" runat="server">
			<input type=hidden value="<%=_statusID%>" name=ID>
			<%=Gui.MakeHeaders(Translate.Translate("Rediger"), Translate.Translate("Status"), "", False, "595")%>
			<TABLE class="TabTable" style="WIDTH: 595px" cellSpacing="5" cellPadding="5">
				<div id="Tab1" style="DISPLAY:none"/>
				<tr valign="top">
					<td width="50"><%=Translate.Translate("Navn")%></td>
					<td><asp:textbox id="_name" runat="server" CssClass="std" maxLength = "50"></asp:textbox></td>
					<td><asp:requiredfieldvalidator id="_nameValidator" runat="server" Display="Dynamic" ErrorMessage="Status Name should not be empty"
							ControlToValidate="_name"></asp:requiredfieldvalidator></td>
				</tr>
				<tr valign="bottom">
					<td colspan="3" align="right">
						<asp:Button Runat="server" ID="Ok" CssClass="buttonSubmit" Text=""></asp:Button>
						<asp:Button Runat="server" ID="cancel" Text="Cancel" CausesValidation="False" CssClass="buttonSubmit"></asp:Button>
					</td>
				</tr>
			</TABLE>
		</form>
		<%Translate.GetEditOnlineScript()%>
	</body>
</HTML>
