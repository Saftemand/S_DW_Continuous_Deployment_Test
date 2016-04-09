<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CustomFields_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Employee.CustomFields_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<script language="javascript">
		function DeleteItem(ItemID)
		{
			if(confirm('<%=Translate.JSTranslate("Slet")%>?'))
				location = "CustomFields_Values_Delete.aspx?ID=" + ItemID + "&FieldID=" + "<%=_fID%>" + "&context=" + "<%=_fContext%>";
		}
		function ValidateField(fieldName)
		{
			
		}
	</script>
	<body>
		<%=Gui.MakeHeaders(Translate.translate("Brugerdefineret felt"), Translate.translate("Brugerdefineret felt"), "all")%>
		<table border="0" cellpadding="2" cellspacing="0" width="598" class="tabTable">
			<div id="Tab1" style="DISPLAY:"/>
			<form method="post" runat="server" ID="Form1">
				<TBODY>
					<tr valign="top">
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Generelt"))%>
					<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td width="170"><%=Translate.Translate("Navn")%></td>
						<td><asp:TextBox ID="_txName" CssClass="std" MaxLength="100" Runat="server"></asp:TextBox></td>
						<td><asp:RequiredFieldValidator ID="_NameValidator" Display=Dynamic Runat="server" ErrorMessage="- Required field"
								ControlToValidate="_txName"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Systemnavn")%></td>
						<td><asp:TextBox ID="_txSystemName" CssClass="std" MaxLength="100" Enabled="False" Runat="server"></asp:TextBox></td>
						<td><asp:RequiredFieldValidator ID="_SystemNameValidator" Display=Dynamic Runat="server" ErrorMessage="- Required field"
								ControlToValidate="_txSystemName"></asp:RequiredFieldValidator>
							<asp:regularexpressionvalidator id="_SystemNameValidatorExpr" Display=Dynamic runat="server" ErrorMessage="- Incorrect field" ControlToValidate="_txSystemName"
								ValidationExpression="([a-zA-Z0-9_\-\.])+"></asp:regularexpressionvalidator>
						</td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Felttype")%></td>
						<td>
							<asp:DropDownList ID="_lstType" CssClass="std" Enabled="False" Runat="server">
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Dropdown")%></td>
						<td><asp:CheckBox ID="_chkDropDown" Checked="False" Runat="server"></asp:CheckBox></td>
					</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<% If _chkDropDown.Checked Then %>
						<%=Gui.GroupBoxStart(Translate.Translate("Dropdown"))%>
						<table cellspacing="0" cellpadding="2" border="0" width="370">
						<% If Not _cfHasVals Then %>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td colspan="2"><strong><%=Translate.Translate("Intet")%></strong></td>
						</tr>
						<% Else %>
						<tr>
							<td colSpan="2">
							<asp:repeater id="_repeatVals" Runat="server">
								<HeaderTemplate>
									<tr>
										<td align="left" width="45%"><strong><%=Translate.Translate("Værdi")%></strong></td>
										<td align="left" width="45%"><strong><%=Translate.Translate("Tekst")%></strong></td>
										<td align="left" width="10%"><strong><%=Translate.Translate("Slet")%></trong></td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left"><a href="CustomFields_Values_Edit.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldValueID") %>&FieldID=<%=_fID%>&TypeID=<%=_typeID%>&sysname=<%=_fSysName%>&context=<%=_fContext%>"><%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldValueKey") %></a></td>
										<td align="left"><%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldValueValue") %></td>
										<td align="center"><a href="javascript:DeleteItem(<%# DataBinder.Eval(Container.DataItem, "AccessCustomFieldValueID") %>);"><img src="/Admin/Images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet")%>"></a></td>
									</tr>
								</ItemTemplate>
							</asp:repeater>
						<% End if %>
						<tr valign="bottom">
							<td align="left">
								<table cellSpacing="0" cellPadding="0" border="0">
									<tr>
										<td align="left"><%=Gui.Button(Translate.Translate("Ny"), "window.location='CustomFields_Values_Edit.aspx?FieldID=" & _fID & "&sysname=" & _fSysName & "&context=" & _fContext & "&TypeID=" & _lstType.SelectedValue & "';", 0)%></td>
									</tr>
									<tr>
										<td colSpan="2" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</TD>
			</TR>
			<%=Gui.GroupBoxEnd()%>
				<% End If %>
				</td>
					</tr>
					<tr valign="bottom">
						<td vAlign="bottom" align="left" width="70%"><asp:customvalidator id="_cusValidator" Runat="server" ControlToValidate="_txSystemName" ErrorMessage="<b>ERROR:</b> the specified system name is already exits. Please type another."
								OnServerValidate="ServerValidate" Display="Static"></asp:customvalidator></td>
						<td valign="bottom" align="right">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td align="right"><asp:Button ID="_btnSubmit" CausesValidation="True" Text="OK" CssClass="buttonSubmit" Runat="server"></asp:Button></td>
									<td width="5"></td>
									<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "window.location = 'CustomFields_List.aspx?context=" & _fContext & "';", 0)%></td>
									<td width="10"></td>
								</tr>
								<tr>
									<td colspan="2" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</form>
			</TBODY>
		</table>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
