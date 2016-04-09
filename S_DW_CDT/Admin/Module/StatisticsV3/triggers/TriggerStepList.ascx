<%@ Control Language="vb" AutoEventWireup="false" Codebehind="TriggerStepList.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.TriggerStepList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<script language="javascript">
		function ConfirmStepDelete(survey)
		{
			return confirm('<%=Translate.JSTranslate("Slet")%>' + ' ' + survey.ClientCommandArgument + ' ?');
		}
</script>
<table cellpadding=0 cellspacing=0 border=0 class=clean width=100%>
<asp:Repeater id="_list" runat="server">
<HeaderTemplate>
<tr>
<td width="70%">&nbsp;<strong><%=Translate.Translate("Navn")%></strong></td>
<td width="20%">&nbsp;<strong><%=Translate.Translate("Sortering")%></strong></td>
<td width="10%">&nbsp;<strong><%=Translate.Translate("Slet")%></strong></td>
</tr>
<tr>
<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
</tr>
</HeaderTemplate>
<ItemTemplate>
<tr>
<td width="70%">
<a href="TriggerStepEdit.aspx?StepID=<%# DataBinder.Eval(Container.DataItem, "ID") %>"><%# DataBinder.Eval(Container.DataItem, "TypeName") %>: <%# DataBinder.Eval(Container.DataItem, "ModuleName") %></a>
</td>
<td width="20%">
<img id="moveureplacer" runat="server" src="/Admin/images/nothing.gif" width="15" border="0">
<a id="moveu" runat="server" OnServerClick="OnStepMoveUp" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "SortOrder")%>'><img src="/Admin/Images/pilop.gif" alt="Move Up" border="0"></a>
<a id="moved" runat="server" OnServerClick="OnStepMoveDown" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "SortOrder")%>'><img src="/Admin/Images/pilned.gif" alt="Move Down" border="0"></a>
</td>
<td width="10%" align="center">
<a id="dela" runat="server" OnServerClick="OnStepDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmStepDelete(this);' ClientCommandArgument='<%# (DataBinder.Eval(Container.DataItem, "TypeName") + ": "+DataBinder.Eval(Container.DataItem, "ModuleName"))%>'><img src="/Admin/Images/Delete.gif" alt="<%=Translate.translate("Slet")%>" border="0"></a>
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
<td colspan="3" align="left" style="padding:5px 5px 5px 5px"><%=Translate.translate("Ingen data")%></td>
</tr>
<tr>
<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
</tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
</FooterTemplate>
</asp:Repeater>
<tr>
<td colspan="3" align="right">
<table border="0" cellpadding="0" cellspacing="0">
<tr><td><%=Gui.Button(Translate.translate("Ny pattern trigger"), "location='TriggerStepEdit.aspx?TriggerID=" & _triggerID.ToString & "'", 0)%></td><td width="5">&nbsp;</td></tr>
<tr><td height="5"></td></tr>
</table>
</td>
</tr>
</table>