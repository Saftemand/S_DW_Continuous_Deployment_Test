<%@ Page AutoEventWireup="true" Codebehind="CategoryEdit.aspx.cs" Inherits="CategoryEdit" Language="C#" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<%=Gui.MakeHeaders("Rediger kategori", "Kategori", "Javascript", false, "")%>
	</head>
	<body>
	<%=Gui.MakeHeaders("Kategori", "Kategori", "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="height:180px;">
		<form action="CategorySave.aspx" method="post">
		<input type="hidden" name="_ID" id="_ID" value="" runat="server">
		<tr>
			<td valign="top">
				<br>
				<%=Gui.GroupBoxStart("Kategori")%>
				<table>
					<tr>
						<td width="170">Navn</td>
						<td><input type="text" name="Name" id="Name" value="" class="std" runat="server"></td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd()%>
			</td>
		</tr>
		<tr>
			<td align="right" colspan="2">
				<table>
					<tr>
						<td><%=Gui.Button("OK", "document.forms[0].submit();", 0)%></td>
						<td><%=Gui.Button("Annuller", "location = 'CategoryList.aspx';", 0)%></td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
  </body>
</html>
