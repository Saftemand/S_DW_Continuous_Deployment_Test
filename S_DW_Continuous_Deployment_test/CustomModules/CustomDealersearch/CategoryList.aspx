<%@ Page AutoEventWireup="true" Codebehind="CategoryList.aspx.cs" Inherits="CategoryList" Language="C#" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript">
		function del(ID){
			if(confirm("Delete?")){
				location = "CategoryDelete.aspx?ID=" + ID;
			}
		}
		</script>
		<%=Gui.MakeHeaders("Kategorier", "Kategorier", "Javascript", false, "")%>
	</head>
	<body>
	<%=Gui.MakeHeaders("Kategorier", "Kategorier", "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<tr>
			<td valign="top">
				<br>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td width="568"><strong>Kategori</strong></td>
						<td width="30" align="center"><strong>Slet</strong></td>		
					</tr>
					<tr>
						<td colspan="2" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<asp:literal id="Literal1" runat="server"></asp:literal>
					<tr>
						<td align="right" colspan="2">
							<table>
								<tr>
									<td><%=Gui.Button("Ny kategori", "location = 'CategoryEdit.aspx';", 0, false)%></td>
									<td><%=Gui.Button("Annuller", "location = '/Admin/Module/Modules.aspx';", 0, false)%></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</body>
</html>
