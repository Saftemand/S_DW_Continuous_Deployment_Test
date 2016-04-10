<%@ Page CodeBehind="poll_category_list.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_category_list" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
'**************************************************************************************************
'	Current version:	1.1.0
'	Created:			29-07-2002
'	Last modfied:		29-07-2002
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 02-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************
%>

<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		function ConfirmCategoryDelete(intCategoryID, strCategoryName) {
			if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + strCategoryName + ')\n\n<%=Translate.Translate("ADVARSEL!")%>\n<%=Translate.Translate("Alle spørgsmål i kategorien vil blive slettet!")%>')==true) {
				location.href = "poll_category_del.aspx?categoryid=" + intCategoryID;
			}
		}
	</SCRIPT>
	<BODY>
		<%=Gui.MakeHeaders(Translate.Translate("Afstemning",9), Translate.Translate("Kategorier"), "all")%>
		<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
			<tr>
				<td valign="top">
					<div ID="Tab1" STYLE="display:;">
						<table height="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top"><br>
									<TABLE border="0" cellpadding="0" width="598">
										<tr>
											<TD><strong><%=Translate.Translate("Kategori")%></strong></TD>
											<TD width="40" align="center"><strong><%=Translate.Translate("Spørgsmål",2)%></strong></TD>
											<TD width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></TD>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
										<%

Dim cnPoll As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
Dim cmdSelect As IDbCommand = cnPoll.CreateCommand
cmdSelect.CommandText = "SELECT PollCategory.PollCategoryID, PollCategory.PollCategoryName, Count(PollItem.PollItemID) AS EnumQuestions FROM PollCategory LEFT JOIN PollItem ON PollCategory.PollCategoryID = PollItem.PollItemCategoryID GROUP BY PollCategory.PollCategoryID, PollCategory.PollCategoryName ORDER BY PollCategory.PollCategoryName ASC"
Dim drPoll as IDataReader = cmdSelect.ExecuteReader()

'Gets and stores ordinal numbers for the columnnames
Dim intOrdinalValuePollCategoryID, intOrdinalValuePollCategoryName, intOrdinalValueEnumQuestions as Integer
intOrdinalValuePollCategoryID = drPoll.GetOrdinal("PollCategoryID")
intOrdinalValuePollCategoryName = drPoll.GetOrdinal("PollCategoryName")
intOrdinalValueEnumQuestions = drPoll.GetOrdinal("EnumQuestions")

Dim blnHasRow as Boolean = false

Do While drPoll.Read()
	If Not blnHasRow Then blnHasRow = True
	With Response
		'*** Security check
		If Base.HasAccess("PollCategories", drPoll(intOrdinalValuePollCategoryID)) Then
			Response.Write("<TR>")
			
			If Base.HasAccess("PollEdit", "") Then
				Response.Write("<TD><A href=""poll_questions_list.aspx?categoryid=" & drPoll(intOrdinalValuePollCategoryID).ToString & """>" & drPoll(intOrdinalValuePollCategoryName) & "</A></TD>")
			Else
				Response.Write("<TD>" & drPoll(intOrdinalValuePollCategoryName) & "</TD>")
			End If
			
			Response.Write("<TD align=""center"">" & drPoll(intOrdinalValueEnumQuestions).ToString & "</TD>")
						
			If Base.HasAccess("PollDelete", "") Then
				Response.Write("<TD align=""center""><A href=""javascript:ConfirmCategoryDelete(" & drPoll(intOrdinalValuePollCategoryID).ToString & ", '" & drPoll(intOrdinalValuePollCategoryName).ToString & "');""><IMG src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("kategori")) & """></A></TD>")
			Else
				Response.Write("<TD align=""center""><IMG style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"" src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("kategori")) & """></TD>")
			End If
			
			Response.Write("</TR>")
			
			Response.Write("<tr><td colspan=""3"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td></tr>")
		End If
	End With
Loop 

drPoll.Close()
drPoll.Dispose()
cmdSelect.Dispose()
cnPoll.Dispose()

%>
										<%If Not blnHasRow Then%>
										<tr>
											<td colspan="3"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%></strong></td>
										</tr>
										<%End If%>
									</TABLE>
								</td>
							</tr>
							<tr>
								<td align="right" valign="bottom">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<%If Base.HasAccess("PollCreate", "") Then%>
											<td><%=Gui.Button(Translate.Translate("Ny kategori"), "window.location='Poll_Category_Edit.aspx'", 90)%></td>
											<td width="5"></td>
											<%End If%>
											<td>
												<%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 90)%>
											</td>
											<%=Gui.HelpButton("poll","modules.poll.general.list",,5)%>
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
		</TABLE>
		<%=Gui.SelectTab()%>
	<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
