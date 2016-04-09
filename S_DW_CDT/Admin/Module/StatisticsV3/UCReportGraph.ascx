<%@ Import namespace="Dynamicweb.StatisticsV3.Consts"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCReportGraph.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.UCReportGraph" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%=JavaArray%>
<table width="512">
	<tr>
		<td vAlign="top" rowSpan="4"><IMG height="36" alt="" src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_heading.gif" width="32"
				border="0">
		</td>
	</tr>
	<span id="statTotalHeading">
		<tr>
			<td width="402">
				<strong style="COLOR: #003366"><span id="lblTitle" runat="server" /></strong>
				<br>
				<SELECT class="std" id="ddl" onchange="globalReload();" runat="server" />
			</td>
			<td style="WIDTH: 90px" vAlign="bottom" align="right">
				<strong style="COLOR: #003366">Total: <span id="lblTotal" runat="server" /></strong>
			</td>
		</tr>
	</span>
	<tr>
		<td style="WIDTH: 100%; HEIGHT: 1px; BACKGROUND-COLOR: #cccccc" colSpan="2"></td>
	</tr>
	<tr id="trLinks" runat="server">
		<td>
			<A id="lnkShowAll" style="TEXT-DECORATION: underline" runat="server"></A><A id="lnkBack" style="TEXT-DECORATION: underline" href="javascript:history.go(-1)"
				runat="server"></A>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colSpan="2"><span id="statBlock">
				<table cellSpacing="0" cellPadding="0" width="100%" border="0">
					<asp:repeater id="rpt" Runat="server">
						<ItemTemplate>
							<tr>
								<td colspan="3">
									<span id="pnlLogo" runat="server">
										<br />
										<img id="imgLogo" runat="server" border="0" vspace="0"> </span><b><span id="lblGroupName" runat="server">
										</span></b>
								</td>
								<td align="right" valign="bottom">
									<strong><span id="lblGroupCount" runat="server" /></strong>
								</td>
							</tr>
							<tr runat="server" id="trGroupLine">
								<td colspan="4" height="1" style="height:1px;background-color:#E1E1E1"></td>
							</tr>
							<tr>
								<td width="170">
									<a id="lnkTitle" runat="server" /><span id="spnTitle" runat="server" /><a id="lnkShortcutURL" target="_blank" runat="server">
										<img src='<%=_hostname%>/Admin/Images/Shortcut.gif' border="0"/> </a>
									<span id="spnFlag" runat="server"><img id="imgFlag" runat="server" border="0" /> </span>
								</td>
								<td bgcolor="#d1d1d1" width="240px" style="height:18px;">
									<img src="<%=_hostname%>/Admin/images/BlueBar.bmp"
                                         style="width:<%#Base.ChkDouble(DataBinder.Eval(Container.DataItem,DataBarField))%>%;height:18px;" 
									     border="0"/>
								</td>
								<td align="right">&nbsp;<%#Base.ChkNumber(DataBinder.Eval(Container.DataItem,DataValueField))%></td>
								<td align="right">&nbsp;<%#Base.ChkDouble(DataBinder.Eval(Container.DataItem,DataPercentField))%>%</td>
							</tr>
							<tr>
								<td height="1" colspan="4"></td>
							</tr>
						</ItemTemplate>
					</asp:repeater></table>
			</span>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
