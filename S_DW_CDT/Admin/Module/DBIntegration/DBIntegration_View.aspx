<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="job" TagName="datasource" Src="UCDataSource.ascx" %>
<%@ Register TagPrefix="job" TagName="datatarget" Src="UCDataTarget.ascx" %>
<%@ Register TagPrefix="job" TagName="maplist" Src="UCMap.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DBIntegration_View.aspx.vb" Inherits="Dynamicweb.Admin.DBIntegration.DBIntegration_View" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>DBIntegration_View</title>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta content="True" name="vs_snapToGrid">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script>
		function ConfirmDelete(elm)
		{
			return confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("element"))%>\n(' + elm.ClientCommandArgument + ')');
		}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<%WriteInfo()%>
		<form id="Form1" method="post" runat="server">
			<%=Gui.MakeHeaders(translate.translate("Databaseintegration"), TabNames(), "", false, "")%>
			<table class="tabTable" cellSpacing="0" cellPadding="0" border="0">
					<tr>
						<td valign="top"><br>
							<asp:panel id="Tab1" Runat="server" Width="100%">
								<TABLE width="100%">
									<TR>
										<TD>
											<TABLE>
												<TR>
													<TD width="170"><%=Translate.translate("Navn")%></TD>
													<TD>
														<asp:TextBox id="tbJobName" Width="300" Runat="server" CssClass="std"></asp:TextBox>
														<asp:RequiredFieldValidator id="RequiredFieldValidatorJobName" runat="server" ErrorMessage=" fill job name"
															Display="Static" ControlToValidate="tbJobName"></asp:RequiredFieldValidator></TD>
												</TR>
											</TABLE>
										</TD>
									</TR>
									<TR>
										<TD>
											<job:datasource id="_dataSourceControl" runat="server" TabNumber="1"></job:datasource></TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:panel id="Tab2" style="DISPLAY: none" Runat="server">
								<TABLE width="100%">
									<TR>
										<TD>
											<job:datatarget id="_dataTargetControl" runat="server" TabNumber="2"></job:datatarget></TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:panel id="Tab3" style="DISPLAY: none" Runat="server">
								<TABLE width="100%">
									<TR>
										<TD>
											<job:maplist id="_mapList" runat="server" TabNumber="3"></job:maplist></TD>
									</TR>
								</TABLE>
							</asp:panel>
						</td>
					</tr>
					<tr>
						<td width="100%"><asp:label id="ErrorMessage" Runat="server">&nbsp;</asp:label></td>
					</tr>
					<tr>
						<td width="100%">&nbsp;</td>
					</tr>
					<tr>
						<td width="100%" align="right">
							<asp:Button Runat="server" ID="Save" Text="OK" CssClass="buttonSubmit"></asp:Button>
							<asp:Button Runat="server" ID="Back" Text="Cancel" CssClass="buttonSubmit"></asp:Button>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="100%">&nbsp;</td>
					</tr>
					<tr>
						<td valign="bottom" width="100%"><span class="std" style="WIDTH: 100%; HEIGHT: 5px"><asp:label id="StatusMessage" Runat="server">&nbsp;</asp:label></span></td>
					</tr>
			</table>
		</form>
		<%=Gui.SelectTab(_guiTabID)%>
		<%Translate.GetEditOnlineScript()%>
	</body>
</HTML>
