<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DBPub_List.aspx.vb" Inherits="Dynamicweb.Admin.DBPub.DBPub_List" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
			<script language="javascript">
		function del(ID){
			if(confirm("<%=Translate.JSTranslate("Slet")%>?")){
				location = "DBPub_DeleteView.aspx?ViewID=" + ID;
			}
		}
			</script>
	</HEAD>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Publiceringer"), Translate.Translate("Publiceringer"), "", false, "")%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<form runat="server" method="post">
				<TBODY>
					<tr>
						<td valign="top">
							<br>
							<table border="0" cellpadding="0" width="598">
								<tr>
									<td width="538"><strong><%=Translate.Translate("Publicering", 10)%></strong></td>
									<td width="30" align="center"><strong><%=Translate.Translate("Kopier")%></strong></td>
									<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
								</tr>
								<tr>
									<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
								</tr>
								<asp:literal id="Literal1" runat="server"></asp:literal>
								<tr>
									<td align="right" colspan="3">
										<table>
											<tr>
												<td><asp:Button ID="NewDBView" CssClass="buttonSubmit" Runat="server"></asp:Button></td>
												<td><%=Gui.Button(Translate.Translate("Annuller"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
                      							<TD><%=Gui.HelpButton("dbpub", "modules.dbpub.general.publication.list")%></TD>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</form>
			</TBODY>
		</table>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>