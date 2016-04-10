<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomFields_List.aspx.vb" Inherits="Dynamicweb.Admin.Employee.CustomFields_List" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
			<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<script language="javascript">
		function DeleteField(FieldName, FieldID)
		{
			if(confirm('<%=Translate.JSTranslate("Slet")%>?'))
				location = "CustomFields_Delete.aspx?ID=" + FieldID + "&context=" + "<%=_fContext%>";
		}		
	</script>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Brugerdefinerede felter"), Translate.Translate("Generelt"), "all")%>
		<% if Not _cfHasRows Then %>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
				<div id="Tab1" style="DISPLAY:"/>
				<tr>
					<td valign="top"><strong><br>&nbsp;<%=Translate.Translate("Ingen brugerdefinerede felter")%></strong></td>
				</tr>
		<% Else %> 
			<asp:Repeater ID="_repeatFields" Runat="server">
				<HeaderTemplate>
					<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
						<div id="Tab1" style="DISPLAY:"/>
						<tr>
							<td valign="top">
								<table border="0" cellpadding="0" width="598">
									<tr valign="top">
										<td colspan="3"><br></td>	
								</tr>
								<tr>
									<td align="left" width="400"><strong><%= Translate.Translate("Navn")%></strong></td>
									<td align="left" width="150"><strong><%= Translate.Translate("Felttype")%></strong></td>
									<td align="center" width="48"><strong><%= Translate.Translate("Slet")%></strong></td>
								</tr>
								<tr>
									<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
								</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td align="left"><a href="CustomFields_Edit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldID")%>&context=<%# _fContext %>"><img src="/Admin/Images/Icons/Module_Form_small.gif" align="left" border="0">&nbsp;<%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldName") %></a></td>
						<td align="left"><%# Translate.Translate(DataBinder.Eval(Container.DataItem, "AccessCustomFieldTypeName")) %></td>
						<td align="center"><a href="javascript:DeleteField('<%# Base.JSEnable(Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "AccessCustomFieldName")))%>', <%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldID")%>);"><img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0"></a></td>
					</tr>
				</ItemTemplate>
				<SeparatorTemplate>
					<tr>
						<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
					</tr>
				</SeparatorTemplate>
				<FooterTemplate>
					</table></td></tr>
			</FooterTemplate>
		</asp:Repeater>
		<% End if %>
		<tr valign="bottom">
			<td colspan="3" align="right">
				<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td colspan="2" height="5"></td>
					</tr>
					<tr>
						<td align="right"><%=Gui.Button(Translate.Translate("Nyt felt"), "window.open('CustomFields_Edit.aspx?context=" & _fContext & "','_self');", 90)%></td>
						<td width="5"></td>
					</tr>
					<tr>
						<td colspan="2" height="5"></td>
					</tr>
				</table>
			</td>	
		</tr>
	</body>
</html>
<%Translate.GetEditOnlineScript()%>
