<%@ Page AutoEventWireup="true" Codebehind="DealerList.aspx.cs" Inherits="DealerList" Language="C#" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript">
		function del(ID){
			if(confirm("Slet?")){
				location = "DealerDelete.aspx?ID=" + ID + "&CategoryID=<%=Request.QueryString["ID"]%>";
			}
		}
		</script>
		<%=Gui.MakeHeaders("Forhandlere", "Forhandlere", "Javascript", false, "")%>
	</head>
	<body>
	<%=Gui.MakeHeaders("Forhandlere", "Forhandlere", "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<tr>
			<td valign="top">,
				<br>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td width="230"><strong>Navn</strong></td>
						<td width="180"><strong>Adresse</strong></td>
						<td width="128"><strong>By</strong></td>
						<td width="30" align="center"><strong>Kopier</strong></td>
						<td width="30" align="center"><strong>Slet</strong></td>
					</tr>
					<tr>
						<td colspan="5" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<asp:literal id="Literal1" runat="server"></asp:literal>
					<tr>
						<td align="right" colspan="5">
							<table>
								<tr>
									<td><%=Gui.Button("Ny forhandler", "location = 'DealerEdit.aspx?CategoryID=" + Request.QueryString["ID"] + "';", 0, false)%></td>
									<td><%=Gui.Button("Rediger kategori", "location = 'CategoryEdit.aspx?ID=" + Request.QueryString["ID"] + "';", 0, false)%></td>
									<td><%=Gui.Button("Annuller", "location = 'CategoryList.aspx';", 0, false)%></td>
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