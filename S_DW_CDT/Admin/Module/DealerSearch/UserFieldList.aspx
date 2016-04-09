<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UserFieldList.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.UserFieldList" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim udTxt as string = Translate.Translate("Brugerdefinerede felter")
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript">
		function del(ID){
			if(confirm("Slet?")){
				location = "UserFieldDelete.aspx?ID=" + ID;
			}
		}
		</script>
		<%=Gui.MakeHeaders(udTxt, udTxt, "Javascript", false, "")%>
	</head>
	<body>
	<%=Gui.MakeHeaders(udTxt, udTxt, "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<tr>
			<td valign="top">
				<br>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td width="498"><strong><%=Translate.Translate("Navn")%></strong></td>
						<td width="70" align="center"><strong><%=Translate.Translate("Sorter")%></strong></td>
						<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
					</tr>
					<tr>
						<td colspan="3" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<asp:literal id="Literal1" runat="server"></asp:literal>
					<tr>
						<td align="right" colspan="3">
							<table>
								<tr>
									<td><%=Gui.Button("Nyt felt", "location = 'UserFieldEdit.aspx';", 0)%></td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'CategoryList.aspx';", 0)%></td>
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
<%Translate.GetEditOnlineScript()%>