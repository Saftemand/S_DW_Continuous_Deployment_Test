<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Calendar_List.aspx.vb" Inherits="Dynamicweb.Admin.Calendar_List" codePage="65001" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
'**************************************************************************************************
'	Current version:	2.0
'	Created:			2-12-2005
'
'	Purpose: List categories and locations for the calendar module
'
'	Revision history:
'		2.0 2-12-2005 Rasmus Pedersen /RAP
'**************************************************************************************************


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script language="javascript">
		function del(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + strName + ')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle %% vil blive slettet!", "%%", Translate.JSTranslate("begivenheder"))%>')){
				location = "Delete.aspx?ID=" + ID + "&Type=Category";
			}
		}
		function delLoc(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("lokalitet"))%>\n(' + strName + ')')){
				location = "Delete.aspx?ID=" + ID + "&Type=Location";
			}
		}
		function delProv(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("provision"))%>\n(' + strName + ')')){
				location = "booking/ProvisioningEdit.aspx?BookingProvisionID=" + ID + "&Action=Delete";
			}
		}
		function delEquip(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("equipment"))%>\n(' + strName + ')')){
				location = "booking/EquipmentEdit.aspx?BookingEquipmentID=" + ID + "&Action=Delete";
			}
		}
		function delField(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("field"))%>\n(' + strName + ')')){
				location = "booking/CustomFieldEdit.aspx?BookingCustomFieldID=" + ID + "&Action=Delete";
			}
		}
		</script>
		<%
		    Dim Tabs As String
		    Tabs += Translate.Translate("Kategorier") & ","
		    Tabs += Translate.Translate("Lokaliteter")
			If False and Base.HasVersion("19.13.1.0") Then
				Tabs += "," & Translate.Translate("Provisioning") & ","
				Tabs += Translate.Translate("Equipment") & ","
				Tabs += Translate.Translate("Custom Fields")
			End If
		 %>
		<%=Gui.MakeHeaders(Translate.Translate("Aktivitetskalender V2", 9), Tabs, "Javascript", False, "")%>
	</head>
	<body>
	<%=Gui.MakeHeaders(Translate.Translate("Aktivitetskalender V2", 9), Tabs, "Html", False, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top"><br />
								<TABLE cellpadding="0" border="0" width="598">
									<tr>
										<td><strong><%=Translate.Translate("Kategori")%></strong></td>
										<td><strong><%=Translate.Translate("Type")%></strong></td>
										<td width="20" align="center" nowrap><strong><%=Translate.Translate("Slet")%></strong></td>		
									</tr>
									<tr>
										<td colspan="3" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<asp:literal id="litCatList" runat="server" />
								</table>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table>
									<tr>
										<td><%=Gui.Button(Translate.Translate("Ny kategori"), "location = 'CategoryEdit.aspx';", 0)%></td>
										<td><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
										<%=Gui.HelpButton("", "modules.calendar.general.list.category")%>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<div ID="Tab2" STYLE="display:none;">
					<table height="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top"><br />
								<TABLE cellpadding="0" border="0" width="598">
									<tr>
										<td><strong><%=Translate.Translate("Lokalitet")%></strong></td>
										<td width="20" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
									</tr>
									<tr>
										<td colspan="2" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<asp:literal id="litLocList" runat="server" />
								</table>
							</td>
						</tr>
						
						<tr>
							<td align="right" colspan="2" valign="bottom">
								<table>
									<tr>
										<td><%=Gui.Button(Translate.Translate("Ny lokalitet"), "location = 'LocationEdit.aspx';", 0)%></td>
										<td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
										<%=Gui.HelpButton("", "modules.calendar.general.list.location")%>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	</body>
</html>
<%=Gui.SelectTab()%>
<%
Translate.GetEditOnlineScript()
%>