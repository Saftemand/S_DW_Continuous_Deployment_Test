<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ColumnControl.ascx.vb" Inherits="Dynamicweb.Admin.Survey.ColumnControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<td width="<%=Width%>" background="<%=BackGround%>">&nbsp;<span title="<%=SortTitle%>"><a href="?sort=<%=SortIndex%>&direction=<%=SortDirection%><%=AdditionParams%>"><strong><%=Title%></strong></a><%=SortImage%></span></td>
<%
Translate.GetEditOnlineScript()
%>