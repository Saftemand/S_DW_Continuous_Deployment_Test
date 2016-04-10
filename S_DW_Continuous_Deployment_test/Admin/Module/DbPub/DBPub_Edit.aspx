<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="DBPub_Edit.aspx.vb" Inherits="Dynamicweb.Admin.DBPub.DBPub_Edit"%>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%=Gui.MakeModuleHeader("dbpub", "Database publishing")%>
<input type="hidden" name="DBPub_settings" value="Proc, PageSize, ChildPage">
<table border="0" cellpadding="0" width="598" cellspacing="0">
	<tr>
		<td>
			<table border="0" width="590" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<%=Gui.GroupBoxStart("DBPub")%>
						<table cellpadding="2" cellspacing="0" border="0">
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Navn")%></td>
								<td><SELECT id="Proc" name="Proc" class="std">
										<%=GetList(Proc)%>
									</SELECT></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Antal pr. side")%></td>
								<td><INPUT class="std" value="<%=PageSize%>" name="PageSize"></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Underside")%></td>
								<td><%=Gui.LinkManager(ChildPage, "ChildPage", "", "0", "", False, false, True, "", false, True)%></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
