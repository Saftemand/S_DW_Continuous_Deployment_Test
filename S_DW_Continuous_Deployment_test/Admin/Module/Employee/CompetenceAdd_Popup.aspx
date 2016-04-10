<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CompetenceAdd_Popup.aspx.vb" Inherits="Dynamicweb.Admin.Employee.CompetenceAdd_Popup" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HTML>
	<HEAD>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<%=Gui.GroupBoxStart("Parameters")%>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td><asp:Label ID="lblCategory" Runat="server"><%=Translate.Translate("Kategori")%></asp:Label></td>
				<td><asp:DropDownList ID="lstCategory" CssClass="std" Width="150px" Runat="server"></asp:DropDownList></td>
				<td><asp:Label ID="lblCompetence" Runat="server"><%=Translate.Translate("Kompetence")%></asp:Label></td>
				<td><asp:DropDownList ID="lstCompetence" CssClass="std" Width="150px" Runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr valign="bottom">
				<td align="right" colspan="4"><asp:Button ID="btnSubmit" Text=" OK " Runat="server"></asp:Button></td>
				<td width="5"></td>
				<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "javascript:close();", 0)%></td>
				<td width="10"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd()%>
	</body>
</HTML>
<%Translate.GetEditOnlineScript()%>
