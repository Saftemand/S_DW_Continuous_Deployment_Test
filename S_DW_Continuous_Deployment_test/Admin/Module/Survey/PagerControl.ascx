<%@ Control Language="vb" AutoEventWireup="false" Codebehind="PagerControl.ascx.vb" Inherits="Dynamicweb.Admin.Survey.PagerControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<table cellpadding=0 cellspacing=0 border=0 class=clean height='20' width=100%>
		<tr valign='middle'>
			<td align='left' style="<%=ShowCommentStyle%>">&nbsp;<%=Comment%></td>
			<td align='right'><%=PrevLink%>&nbsp;<%=CurrentPageComment%>&nbsp;<%=NextLink%></td>
		</tr>
</table>
<%
Translate.GetEditOnlineScript()
%>
