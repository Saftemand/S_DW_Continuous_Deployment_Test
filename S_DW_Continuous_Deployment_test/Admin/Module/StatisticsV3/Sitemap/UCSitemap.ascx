<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCSitemap.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.UCSitemap" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<script src="../sitemap/sitemaptree.js" type="text/javascript"></script>
<table cellspacing="0" cellpadding="0" border="0" width="550">
	<tr>
		<td valign="top" rowspan="4"><img src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt=""
				border="0"/></td>
	</tr>
	<asp:Label id="statTotalSummary" runat="server"></asp:Label>
	<tr>
		<td style="WIDTH:100%;HEIGHT:1px;BACKGROUND-COLOR:#cccccc" colspan="2"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2">
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td valign="top">
					<div class="dtree" id="ms">
						<asp:TreeView id="t"  Runat="server"  RootNodeStyle-Font-Underline="false" >
					    </asp:TreeView>
					 </div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%=JavaArray%>
