<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TriggerIpEdit.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggerIpEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Ip Edit</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
		</script>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Form1" method="post" runat="server">
				<%=Gui.MakeHeaders(Translate.Translate("Rediger"), translate.translate("IP"), "all")%>
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="StepInfo" title="Summary" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="TextLabel" runat="server" Text="IP"></dw:translatelabel></td>
									<td><asp:TextBox ID="txText" CssClass="std" Runat="server"></asp:TextBox></td>
									<td valign="top"><asp:RequiredFieldValidator ID="TextValidator" ControlToValidate="txText" ErrorMessage="- required field" Runat="server" display="dynamic"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="ExpressionValidator" ControlToValidate="txText" ValidationExpression="^([0-9]{0,3})\.([0-9]{0,3})\.([0-9]{0,3})\.([0-9]{0,3})$" ErrorMessage="- invalid ip address" Runat="server" EnableClientScript="true" display="dynamic"></asp:RegularExpressionValidator><asp:CustomValidator id="CorrectIpValidator" EnableClientScript="false" ErrorMessage="- invalid ip address" OnServerValidate="CorrectIpValidation" runat="server" display="dynamic"/></td>
								</tr>
							</table>
							<dw:groupboxend id="StepInfoEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Validate(); if (ValidatorOnSubmit()) return true;" value="<%=Translate.translate("OK")%>"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.translate("Annuller"), "location='TriggersEdit.aspx?TriggerID=" & _triggerId.ToString &"'", 0)%></td>
									<td width="5">&nbsp;</td>
									<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.triggers.edit.ip.edit")%>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
    </form>

  </body>
</html>
<% 
	Translate.GetEditOnlineScript()
%>