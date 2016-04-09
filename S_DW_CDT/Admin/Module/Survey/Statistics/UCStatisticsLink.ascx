<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCStatisticsLink.ascx.vb" Inherits="Dynamicweb.Admin.UCStatisticsLink" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<table width="512">
	<tr>
		<td valign="top" rowspan="4"><img src="/Admin/Images/Icons/Module_Tagwall.gif" height="36" alt="" border="0"></td>
	</tr>
	<span id="statTotalHeading">
		<tr>
			<td width="402"><strong style="COLOR:#003366"> <span id="lblTitle" runat="server">
						<%=Title()%>
					</span></strong>
			</td>
			<td align="right" valign="bottom" style="WIDTH:90px">
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
		<td><A href="Statistics_Comments.aspx?QuestionID=<%=QuestionID()%>">Comments</A></td>
	</tr>
</table>
<%
Translate.GetEditOnlineScript()
%>
