<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCReportGraph.ascx.vb" Inherits="Dynamicweb.Admin.Survey.UCReportGraph" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<style type="text/css"> .barBG { FONT-SIZE: 10px; WIDTH: 240px; FONT-FAMILY: verdana; HEIGHT: 18px; BACKGROUND-COLOR: #d1d1d1 } .bar { FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F'); HEIGHT: 100% } </style>
<table width="512">
	<TBODY>
		<tr>
			<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" height="36" alt="" border="0"></td>
		</tr>
		<span id="statTotalHeading">
			<tr>
				<td width="402"><strong style="COLOR:#003366"> <span id="lblTitle" runat="server">
							<%=Title()%>
							<br>
							<asp:DropDownList ID="ddl" Runat="server" Visible="False" />
						</span></strong>
				</td>
				<td align="right" valign="bottom" style="WIDTH:90px"><strong style="COLOR:#003366">Total:
						<span id="lblTotal" runat="server">
							<%=Total()%>
						</span></strong>
				</td>
			</tr>
		</span>
		<tr>
			<td style="WIDTH:100%;HEIGHT:1px;BACKGROUND-COLOR:#cccccc" colspan="2"></td>
		</tr>
		<tr>
			<td><asp:LinkButton ID="lbtn" Runat="server" Visible="False" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<span id="statBlock">
					<asp:Repeater ID="rpt" Runat="server">
						<HeaderTemplate>
							<table cellpadding="0" cellspacing="0" border="0" width="100%">
						</HeaderTemplate>
						<ItemTemplate>
							<tr>
								<td><b><span id="lblGroupName" runat="server"></span></b></td>
							</tr>
							<tr>
								<td width="170">
									<%#DataBinder.Eval(Container.DataItem,DataTextField)%>
									&nbsp; <a id="lnkShortcutURL" target="_blank" runat="server"><img id="imgShortcut" src="/Admin/Images/Shortcut.gif" border="0" runat="server" /></a>
									&nbsp;<img id="imgFlag" runat="server" border="0" />
								</td>
								<td class="barBG"><SPAN STYLE="WIDTH:<%#cint(DataBinder.Eval(Container.DataItem,DataBarField))%>%" class="bar"></SPAN></td>
								<td align="right">&nbsp;<span id="lblValueFiled"><%#DataBinder.Eval(Container.DataItem,DataValueField)%></span></td>
								<td align="right">&nbsp;<%#cint(DataBinder.Eval(Container.DataItem,DataPercentField))%>%</td>
							</tr>
						</ItemTemplate>
						<SeparatorTemplate>
							<tr>
								<td height="2"></td>
							</tr>
						</SeparatorTemplate>
						<FooterTemplate>
</table>
</FooterTemplate> </asp:Repeater></SPAN></TD></TR>
<tr>
	<td>&nbsp;</td>
</tr>
</TBODY></TABLE>
<%
Translate.GetEditOnlineScript()
%>
