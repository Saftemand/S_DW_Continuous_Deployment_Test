<%@ Page CodeBehind="Forum_Message_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Message_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim strCategoryID As String

If Not isNothing(Request.QueryString.Item("categoryid")) Then 
	strCategoryID = Request.QueryString.Item("categoryid")
End If

%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		<!--
		function ConfirmMessageDelete(intMessageID, strMessageName) {
			if (confirm("<%=Translate.JsTranslate("Slet indlæg")%>\n(" + strMessageName + ")")==true) {
				location.href = "Forum_Message_Del.aspx?categoryid=<%=strCategoryID%>&messageid=" + intMessageID;
			}
		}
		
		function ExpandMessages(intMessageID) {
			if (document.all("Forum_Message_" + intMessageID).style.display == "") {
				document.all("Forum_Message_" + intMessageID).style.display = "none";
				document.images["Forum_Message_Image_" + intMessageID].src = "../../images/Expand.gif";
			}
			else {
				document.all("Forum_Message_" + intMessageID).style.display = "";
				document.images["Forum_Message_Image_" + intMessageID].src = "../../images/Expand_off.gif";
			}
		}
		
		//-->
	</SCRIPT>
	<BODY>
	<%= Gui.MakeHeaders(Translate.Translate("%m% kategori - %c%", "%m%", Translate.Translate("Forum", 9), "%c%", GetCategoryProperty("ForumCategoryName", strCategoryID)), Translate.Translate("Indlæg", 1), "all")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top"><br>
								<TABLE border="0" cellpadding="0" width="598">
									<tr>
										<TD width="438" align="Left"><strong><%=Translate.Translate("Indlæg")%></strong></td>
										<TD width="120" align="Left"><strong><%=Translate.Translate("Dato")%></strong></TD>
										<TD width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
									</tr>
									<tr>
									  	<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<tr>
										<td colspan="3"><%= GetMessages(strCategoryID, 0)%></td>
									</tr>
								</TABLE>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td><%=Gui.Button(Translate.Translate("Nyt indlæg"), "location='Forum_Message_Edit.aspx?categoryid=" & strCategoryID & "'", 120)%></td>
										<td width="5"></td>
										<td><%=Gui.Button(Translate.Translate("Rediger %%", "%%", Translate.Translate("kategori")), "location='Forum_Category_Edit.aspx?categoryid=" & strCategoryID & "'", 120)%></td>
										<td width="5"></td>
										<td><%=Gui.Button(Translate.Translate("Luk"), "location='Forum_Category_List.aspx'", 0)%></td>
										<%=Gui.HelpButton("forum", "modules.forum.general.list.item",,5)%>
										<td width="10"></td>
									</tr>
									<tr>
										<td colspan="4" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
<%=Gui.SelectTab()%>
	<BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>