<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PathEdit.aspx.vb" Inherits="Dynamicweb.Admin.PathEdit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="stylesheet" href="/Admin/Stylesheet.css" />
</head>
<body>
	<form id="form1" runat="server">
		<input id="PathID" name="PathID" type="hidden" runat="server" />
		<dw:TabHeader runat="server" Tabs="" Title="" ID="TabHeader1" />
		<table id="Tab1" class="tabTable" border="0">
			<tr>
				<td valign="top">
					<dw:GroupBoxStart runat="server" Title="Rediger" ID="gbs" />
					<table>
						<tr>
							<td width="170">
								<%=Translate.Translate("Sti")%>
							</td>
							<td>
								<input id="Path" runat="server" type="text" class="std" /></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Link")%>
							</td>
							<td>
								<dw:LinkManager runat="server" ID="Redirect" />
							</td>
						</tr>
						<tr>
							<td width="170" valign="top">
								<%=Translate.Translate("Status")%>
							</td>
							<td>
								<asp:RadioButtonList runat="server" ID="Status">
								</asp:RadioButtonList>
							</td>
						</tr>
						<tr>
							<td width="170">
							</td>
							<td>
								<input id="Active" runat="server" type="checkbox" value="True" /><label for="Active"><%=Translate.Translate("Aktiv")%></label></td>
						</tr>
					</table>
					<dw:GroupBoxEnd runat="server" ID="gbe" />
				</td>
			</tr>
			<tr>
				<td align="right" valign="bottom" style="padding: 3px;">
					<asp:Button ID="save" runat="server" CssClass="buttonSubmit" Text="" />
					<%=Dynamicweb.Gui.Button(Translate.Translate("Annuller"), "history.go(-1);", 200)%>
					<%=Dynamicweb.Gui.HelpButton("modules.urlpath.general.edit.item")%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>