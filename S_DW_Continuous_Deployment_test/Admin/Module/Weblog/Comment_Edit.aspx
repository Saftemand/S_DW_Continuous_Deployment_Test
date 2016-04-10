<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Comment_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Comment_Edit" ValidateRequest="false" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Comment_Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
		<script language="javascript">
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
			function Send()
			{
				if(typeof(dw_HTMLMode) != "undefined" && dw_HTMLMode == false)
					document.forms.Form1._Editor.value = DWEditor.DOM.body.innerHTML;
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" Headers="Comment" ToolTip="Edit comment"></dw:tabheader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td valign="top">
						<dw:groupboxstart id="TitleStart" title="Title" runat="server"></dw:groupboxstart>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<TBODY>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="lbHeadline" text="Headline" runat="server"></dw:translatelabel></td>
									<td><asp:TextBox CssClass="std" ID="txHeadline" MaxLength="100" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="HeadlineValidator" ControlToValidate="txHeadline" ErrorMessage="- required field"
											Runat="server"></asp:RequiredFieldValidator></td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="lbUserName" text="Author" runat="server"></dw:translatelabel></td>
									<td><asp:TextBox CssClass="std" ID="txUserName" MaxLength="50" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="UserNameValidator" ControlToValidate="txUserName" ErrorMessage="- required field"
											Runat="server"></asp:RequiredFieldValidator></td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="lbEmail" text="Email" runat="server"></dw:translatelabel></td>
									<td><asp:TextBox CssClass="std" ID="txEmail" MaxLength="50" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="EmailValidator" ControlToValidate="txEmail" ErrorMessage="- required field"
											Runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator id="EmailRegexValidator" ControlToValidate="txEmail" ValidationExpression="^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$" 
											ErrorMessage="- incorrect value" Runat="server" Display="Dynamic" />
									</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="lbDate" text="Date" runat="server"></dw:translatelabel></td>
									<td><%=Dates.DateSelect(_date, false, false, false, "dtDate")%></td>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<dw:groupboxend id="TitleEnd" runat="server"></dw:groupboxend>
			<br>
			<dw:groupboxstart id="TextStart" title="Text" runat="server"></dw:groupboxstart>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="center"><%=Gui.Editor("_Editor", 550, 300, _text)%></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			</TD></TR>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><%=Gui.Button("OK", "Send();Validate(); if (ValidatorOnSubmit()) return true;", 0)%></td>
							<td width="5">&nbsp;</td>
							<td><%=Gui.Button(Translate.Translate("Close"), "location='Article_Edit.aspx?ArticleID=" & _articleID & "&BlogID=" & _blogID & "&Tab=2'", 0)%></td>
							<td width="10">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="3" height="5"></td>
						</tr>
					</table>
				</td>
			</tr>
			</TBODY></TABLE>
		</form>
	</body>
</HTML>
<% 
	Translate.GetEditOnlineScript()
%>