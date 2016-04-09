<%@ Page CodeBehind="poll_questions_list.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_questions_list" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
'**************************************************************************************************
'	Current version:	1.1.1
'	Created:			29-07-2002
'	Last modfied:		03-05-2005
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.1.1 - 03-05-2005 - Bo Brandt
'		Display poll category name
'
'		1.1.0 - 01-06-2004 - David Frandsen
'		Converted to .NET
'
'		1.0.0 - 29-07-2002
'		First version.
'**************************************************************************************************


Dim cnPollQuestion As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
Dim cmdSelect As IDbCommand = cnPollQuestion.CreateCommand
cmdSelect.CommandText = "SELECT * FROM PollItem WHERE PollItemCategoryID=" & Request.QueryString.Item("categoryid") & " ORDER BY PollItemID ASC"
Dim drPollItems as IDataReader = cmdSelect.ExecuteReader()

'Gets and stores ordinal numbers for the columnnames
Dim intOrdinalValuePollItemID, intOrdinalValuePollItemText, intOrdinalValuePollItemActive as Integer
intOrdinalValuePollItemID = drPollItems.GetOrdinal("PollItemID")
intOrdinalValuePollItemText = drPollItems.GetOrdinal("PollItemText")
intOrdinalValuePollItemActive = drPollItems.GetOrdinal("PollItemActive")

%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		function ConfirmCategoryDelete(intItemid, strItemName) {
			if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("spørgsmål"))%>\n(' + strItemName + ')')==true) {
				location.href = "poll_questions_del.aspx?itemid=" + intItemid + "&categoryid=<%=Request.QueryString.Item("categoryid")%>";
			}
		}
	</SCRIPT>
	<BODY>
	<%=Gui.MakeHeaders(Translate.Translate("%m% kategori - %c%", "%m%", Translate.Translate("Afstemning",9), "%c%", PollName), Translate.Translate("Spørgsmål",2), "all")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top"><br>
								<TABLE border="0" cellpadding="0" width="598">
									<tr>
										<TD width="400"><strong><%=Translate.Translate("Spørgsmål",1)%></strong></td>
										<TD width="40" align="right"><strong><%=Translate.Translate("Aktiv")%></strong></td>
										<TD width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
									</tr>
									<tr>
									  	<td colspan="3" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<%

Dim blnHasRow as Boolean = false

Do While drPollItems.Read()
	If Not blnHasRow Then blnHasRow = True
		Response.Write("<TR>")
		Dim strPollItem As String = Trim(Base.StripHTML(drPollItems(intOrdinalValuePollItemText)))
		If strPollItem.Length > 75 Then
		    strPollItem = Left(strPollItem, 75) & "..."
		ElseIf strPollItem.Length = 0 Then
		    strPollItem = "..."
		End If
		If Base.HasAccess("PollEdit", "") Then
			Response.Write("<TD><A href=""poll_questions_edit.aspx?itemid=" & drPollItems(intOrdinalValuePollItemID).ToString & """>" & strPollItem & "</A></TD>")
		Else
			Response.Write("<TD>" & strPollItem & "</TD>")
		End If
		
		Response.Write("<TD align=""center""><A href=""poll_questions_toggle.aspx?categoryid=" & Request.QueryString.Item("categoryid") & "&itemid=" & drPollItems(intOrdinalValuePollItemID).ToString & """><IMG src=""../../images/" & IIf(Base.ChkBoolean(drPollItems(intOrdinalValuePollItemActive).ToString) = True, "check", "minus") & ".gif"" border=""0""></A></TD>")
		
		If Base.HasAccess("PollDelete", "") Then
			Response.Write("<TD align=""center""><A href=""javascript:ConfirmCategoryDelete(" & drPollItems(intOrdinalValuePollItemID).ToString & ",'" & Base.StripHTML(drPollItems(intOrdinalValuePollItemText).tostring) & "');""><IMG src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("spørgsmål")) & """></A></TD>")
		Else
			Response.Write("<TD align=""center""><IMG alt=""" & Translate.Translate("Du har ingen adgang") & """ style=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"" src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("spørgsmål")) & """></TD>")
		End If
		
		Response.Write("</TR>")
		Response.Write("<tr><td colspan=""3"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td></tr>")
Loop 

drPollItems.Close()
drPollItems.Dispose()
cmdSelect.Dispose()
cnPollQuestion.Dispose()
%>
									<%If Not blnHasRow Then%>
									<tr>
										<td colspan="3"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("spørgsmål",1))%></strong></td>
									</tr>
									<%End If%>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<%If Base.HasAccess("PollCreate", "") Then%>
										<td><%=Gui.Button(Translate.Translate("Nyt spørgsmål"), "location='Poll_questions_Edit.aspx?categoryid=" & Request.QueryString.Item("categoryid") & "'", 110)%></td>
										<td width="5"></td>
										<%End If%>
										<%If Base.HasAccess("PollEdit", "") Then%>
										<td><%=Gui.Button(Translate.Translate("Rediger %%", "%%", Translate.Translate("kategori")), "window.location='poll_category_edit.aspx?categoryid=" & Request.QueryString.Item("categoryid") & "'", 120)%></td>
										<td width="5"></td>
										<%End If%>
										<td><%=Gui.Button(Translate.Translate("Luk"), "window.location='poll_category_list.aspx'", 90)%></td>
										<%=Gui.HelpButton("poll","modules.poll.general.list.item",,5)%>
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
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
