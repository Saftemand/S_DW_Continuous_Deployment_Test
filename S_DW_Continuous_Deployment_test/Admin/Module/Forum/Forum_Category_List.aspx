<%@ Page CodeBehind="Forum_Category_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Category_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%@ Import namespace="System.Data" %>


<%
Dim i As Integer
Dim dtCategories As DataTable

%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		function ConfirmCategoryDelete(intCategoryID, strCategoryName) {
			if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + strCategoryName + ')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle indlæg i kategorien vil blive slettet!")%>')==true) {
				location.href = "forum_category_del.aspx?categoryid=" + intCategoryID;
			}
		}
	</SCRIPT>
	<BODY>
	<%=Gui.MakeHeaders(Translate.Translate("Forum",9), Translate.Translate("Kategorier"), "all")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top"><br>
								<TABLE border="0" cellpadding="0" width="598">
									<tr>
										<TD><strong><%=Translate.Translate("Kategori")%></strong></td>
										<TD width="50" align="center"><strong><%=Translate.Translate("Indlæg",1)%></strong></td>
										<TD width="60" align="center"><strong><%=Translate.Translate("Medtag")%></strong></td>
										<TD width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
									</tr>
									<tr>
									  	<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<%

Dim blnHasRow as Boolean = false

dtCategories = GetCategories(False, "")
If dtCategories.Rows.Count > 0 Then
	blnHasRow=True
	For i = 0 To dtCategories.Rows.Count -1
		With Response
			.Write("<TR>")
			If Base.HasAccess("ForumEdit", "") Then
				.Write("<TD><A href=""forum_message_list.aspx?categoryid=" & dtCategories.Rows(i)("ForumCategoryID") & """>" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "<span style=""color:#C1C1C1;"">") & Server.HtmlEncode(dtCategories.Rows(i)("ForumCategoryName")) & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "</span>") & "</A></TD>")
			Else
				.Write("<TD>" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "<span style=""color:#C1C1C1;"">") & dtCategories.Rows(i)("ForumCategoryName") & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "</span>") & "</TD>")
			End If
			.Write("<TD align=""center"">" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "<span style=""color:#C1C1C1;"">") & dtCategories.Rows(i)("ForumMessageCount") & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "", "</span>") & "</TD>")
			If Base.HasAccess("ForumEdit", "") Then
				.Write("<TD align=""center""><A href=""Forum_Category_Toggle.aspx?categoryid=" & dtCategories.Rows(i)("ForumCategoryID") & "&SetActiveInactive=" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "Active", "Inactive") & """>" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "<IMG src=""../../images/check.gif"" border=""0"">", "<IMG src=""../../images/minus.gif"" border=""0"">") & "</A></TD>")
			Else
				.Write("<TD align=""center"">" & Base.IIf(dtCategories.Rows(i)("ForumCategoryActive"), "<IMG style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"" src=""../../images/check.gif"" border=""0"">", "<IMG style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"" src=""../../images/minus.gif"" border=""0"">") & "</TD>")
			End If
			If Base.HasAccess("ForumDelete", "") Then
				.Write("<TD align=""center""><A href=""javascript:ConfirmCategoryDelete(" & dtCategories.Rows(i)("ForumCategoryID") & ", '" & Base.JSEncode(Server.HtmlEncode(dtCategories.Rows(i)("ForumCategoryName"))) & "');""><IMG src=""../../images/delete.gif"" " & Base.IIf(Not dtCategories.Rows(i)("ForumCategoryActive"), "style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)""", "") & " border=""0"" alt=""" & Translate.Translate("Slet %%", "%%", Translate.Translate("kategori")) & """></A></TD>")
			Else
				.Write("<TD align=""center""><IMG src=""../../images/delete.gif"" style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"" border=""0""></TD>")
			End If
			.Write("</TR>")
			
			.Write("<tr><td colspan=""4"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=""1"" height=""1"" alt="""" border=""0""></td></tr>")
		End With
	Next 
	dtCategories.Dispose()
End If
%>
									<%If Not blnHasRow Then%>
									<tr>
										<td colspan="3"><br /><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%></td>
									</tr>
									<%End If%>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<%If Base.HasAccess("ForumCreate", "") Then%>
										<td><%=Gui.Button(Translate.Translate("Ny kategori"), "location='Forum_Category_Edit.aspx'", 90)%></td>
										<%End If%>
										<td width="5"></td>
										<td><%=Gui.Button(Translate.Translate("Luk"), "location='../Modules.aspx'", 0)%></td>
										<%=Gui.HelpButton("forum", "modules.forum.general.list",,5)%>
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