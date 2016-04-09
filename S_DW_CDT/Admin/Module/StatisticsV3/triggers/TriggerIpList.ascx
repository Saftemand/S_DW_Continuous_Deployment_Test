<%@ Control Language="vb" AutoEventWireup="false" Codebehind="TriggerIpList.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggerIpList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<script language="javascript">
		function ConfirmIpDelete(survey)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%> ' + survey.ClientCommandArgument + ' ?');
		}
</script>
<table cellpadding=0 cellspacing=0 border=0 class=clean width=100%>
<asp:Repeater id="_list" runat="server">
<HeaderTemplate>
<tr>
<td width="90%">&nbsp;<strong><%=Translate.Translate("IP")%></strong></td>
<td width="10%">&nbsp;<strong><%=Translate.Translate("Slet")%></strong></td>
</tr>
<tr>
<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
</tr>
</HeaderTemplate>
<ItemTemplate>
<tr>
<td width="90%">
<a href="TriggerIpEdit.aspx?StepID=<%# DataBinder.Eval(Container.DataItem, "ID") %>"><%# DataBinder.Eval(Container.DataItem, "Ip") %></a>
</td>
<td width="10%" align="center">
<a id="dela" runat="server" OnServerClick="OnIpDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmIpDelete(this);' ClientCommandArgument='<%# Base.JSEnable(DataBinder.Eval(Container.DataItem, "Ip"))%>'><img src="/Admin/Images/Delete.gif" alt="<%=translate.translate("Slet")%>" border="0"></a>
</td>
</tr>
</ItemTemplate>
<SeparatorTemplate>
<tr>
<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
</tr>
</SeparatorTemplate>
<FooterTemplate>
<tr id="nodata" runat="server">
<td colspan="2" align="left" style="padding:5px 5px 5px 5px"></td>
</tr>
<tr>
<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
</FooterTemplate>
</asp:Repeater>
<tr>
<td colspan="2" align="right">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td><%=Gui.Button(Translate.translate("Ny trigger"), "location='TriggerIpEdit.aspx?TriggerID=" & _triggerID.ToString & "'", 0)%></td><td width="5">&nbsp;</td></tr>
<tr><td height="5"></td></tr>
</table>
</td>
</tr>
</table>