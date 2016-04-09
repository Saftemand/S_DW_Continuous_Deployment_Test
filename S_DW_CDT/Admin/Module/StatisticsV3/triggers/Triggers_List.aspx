<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Triggers_List.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.Triggers_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<HEAD>
<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<LINK href="../StatCss.css" type="text/css" rel="STYLESHEET">
<script language=javascript src="Survey.js" ></script>
<script language="javascript">
		function ConfirmTriggerDelete(trigger)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%> ' + trigger.ClientCommandArgument + ' ?');
		}
</script>
</HEAD>
<form id="Form1" method="post" runat="server">
<%=Gui.MakeHeaders(Translate.Translate("Triggers"), Translate.Translate("Triggers"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td valign="top" width="100%">
<table cellpadding=0 cellspacing=0 border=0 width=100%>
<asp:Repeater id="_list" runat="server">
<HeaderTemplate>
<tr>
<td width="50%">&nbsp;<strong><%=Translate.Translate("Navn")%></strong></td>
<td width="40%">&nbsp;<strong><%=Translate.Translate("Type")%></strong></td>
<td width="10%">&nbsp;<strong><%=Translate.Translate("Slet")%></strong></td>
</tr>
<tr>
<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
</tr>
</HeaderTemplate>
<ItemTemplate>
<tr>
<td width="40%">
<a href="TriggersEdit.aspx?TriggerID=<%# DataBinder.Eval(Container.DataItem, "ID") %>"><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
</td>
<td width="20%">
<%# DataBinder.Eval(Container.DataItem, "TypeName") %>
</td>
<td width="10%" align="center">
<a id="dela" runat="server" OnServerClick="OnTriggerDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmTriggerDelete(this);' ClientCommandArgument='<%# Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name"))%>'><img src="/Admin/Images/Delete.gif" alt="Delete this trigger" border="0"></a>
</td>
</tr>
</ItemTemplate>
<SeparatorTemplate>
<tr>
<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
</tr>
</SeparatorTemplate>
<FooterTemplate>
<tr id="nodata" runat="server">
<td colspan="3" align="left" style="padding:5px 5px 5px 5px"><%=Translate.Translate("Ingen triggers")%></td>
</tr>
<tr>
<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
</tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
</FooterTemplate>
</asp:Repeater>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="right" valign="bottom">
<table cellspacing="5">
<tr>
<td><%=Gui.Button(Translate.translate("Ny trigger"), "location='TriggersEdit.aspx'", 0)%></td>
<%=Gui.HelpButton("", "modules.statisticsv3.general.toolbar.triggers")%>
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
