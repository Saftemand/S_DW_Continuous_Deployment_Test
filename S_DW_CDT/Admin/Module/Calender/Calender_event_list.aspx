<%@ Page CodeBehind="Calender_event_list.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_event_list" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim LockedByUserName As String
Dim IncludeImg As String
Dim DWParagraphMaxLockTime As String = CStr(Base.GetGS("/globalsettings/Settings/Paragraph/MaximumLockingInMinutes"))
Dim LockedByTime As Byte
Dim LockedByUserID As Byte
Dim CheckGetStatus As Object
Dim Sql As String
Dim LockedStatus() As Byte = Nothing

Response.Expires = -100
%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Calender Category List</title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function DeleteCalenderEvent(lclCalenderEventID,lclCalenderEventTitle,lclCalenderEventCategoryID){
	if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("begivenhed"))%>\n(' + lclCalenderEventTitle + ')')){
		location = "Calender_Event_Del.aspx?CalenderEventCategoryID=" + lclCalenderEventCategoryID + "&CalenderEventID=" + lclCalenderEventID;
	}
}
</script>

<%=Gui.MakeHeaders(Translate.translate("%m% kategori - %c%", "%m%", Translate.Translate("Aktivitetskalender",9) ,"%c%", Server.HtmlEncode(Request.QueryString.Item("CalenderCategory"))) & "&nbsp;", Translate.Translate("Begivenheder"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
<tr><td valign=top>
			<div ID="Tab1" STYLE="display:;">
			<table border="0" cellpadding="0" width="598">
				<tr>
					<td colspan="5"><br></td>
				</tr>
				<tr>
					<td width="115" align="left">&nbsp;<strong><%=Translate.Translate("Dato")%></strong></td>
					<td width="285" align="left"><strong><%=Translate.Translate("Begivenhed")%></strong></td>
					<td width="50" align="left"><strong><%=Translate.Translate("Aktiv")%></strong></td>
					<td width="100" align="left"><strong><%=Translate.Translate("Opdateret")%></strong></td>
					<td width="48" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
				<tr>
					<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
 				</tr>
				<%
				Dim CategoryID as integer = 0
				CategoryID = Base.ChkNumber(request.QueryString.Item("CalenderCategoryID"))
Sql = " SELECT	* " & _
	  " FROM	CalenderEvent " & _
	  " WHERE	CalenderEvent.CalenderEventCategoryID=" & CategoryID & _
	  " ORDER BY CalenderEvent.CalenderEventDate DESC "
	  
Dim cnCalender	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand		= cnCalender.CreateCommand
cmdSelect.CommandText = sql


Dim ds As DataSet = New DataSet
Dim da As IDbDataAdapter = Database.CreateAdapter()
da.SelectCommand = cmdSelect
da.Fill(ds)

Dim drCalender As DataRow

'Dim drCalender	as IDataReader		= cmdSelect.ExecuteReader()
Dim i as integer = 0
Dim blnHasRow as Boolean = false 
Do While i < ds.Tables(0).Rows.Count
		drCalender = ds.Tables(0).Rows(i)
		If Not blnHasRow Then blnHasRow = True

		i = i + 1
		LockedByUserID = 0
		LockedByUserName = ""

		If IsArray(LockedStatus) Then
			If Trim(DWParagraphMaxLockTime) = "" Or Not IsNumeric(DWParagraphMaxLockTime) Then
				DWParagraphMaxLockTime = "30"
			End If
			LockedByTime = LockedStatus(1)
			If Now < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, CInt(DWParagraphMaxLockTime), System.Date.FromOADate(LockedByTime)) Then
				LockedByUserID = LockedStatus(0)
				If LockedByUserID <> 0 Then
					LockedByUserName = Access.AccessGetUserName(LockedByUserID)
				Else
					LockedByUserName = "Administrator"
				End If
			End If
		End If
		
		If LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID Then
			If drCalender("CalenderEventInclude") Then
				IncludeImg = "<a href=""Calender_event_SetActive.aspx?CalenderEventID=" & drCalender("CalenderEventID") & "&CalenderEventInclude=1&CalenderCategoryID=" & drCalender("CalenderEventCategoryID") & "&CalenderCategory=" & Server.HtmlEncode(Request.QueryString.Item("CalenderCategory")) & """><img src=""../../images/Check.gif"" border=0></a>"
			Else
				IncludeImg = "<a href=""Calender_event_SetActive.aspx?CalenderEventID=" & drCalender("CalenderEventID") & "&CalenderEventInclude=0&CalenderCategoryID=" & drCalender("CalenderEventCategoryID") & "&CalenderCategory=" & Server.HtmlEncode(Request.QueryString.Item("CalenderCategory")) & """><img src=""../../images/Minus.gif"" border=0></a>"
			End If
		Else
			If drCalender("CalenderEventInclude") Then
				IncludeImg = "<img src=""../../images/Check.gif"" border=0>"
			Else
				IncludeImg = "<img src=""../../images/Minus.gif"" border=0>"
			End If
		End If
		%>
					<tr>
							<td width="115" height="20" align="left">&nbsp;
						<%If (LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID) And Base.HasAccess("CalenderEdit", "") Then
			%>			<a href="calender_event_edit.aspx?CalenderEventID=<%=drCalender("CalenderEventID")%>&CalenderCategoryID=<%=drCalender("CalenderEventCategoryID")%>" >
										<%=Dates.ShowDate(CDate(drCalender("CalenderEventDate")), Dates.Dateformat.Short, True)%>
									</a>
						<%		Else
			%>			<%=Dates.ShowDate(CDate(drCalender("CalenderEventDate")), Dates.Dateformat.Short, True)%>
						<%		End If
		%>	</td>
							<td width="285" align="left">
						<%		If LockedByUserName <> "" Then
			If Session("DW_Admin_UserID") = LockedByUserID Then
				%>				<img src="../../Images/infoicon.gif" border="0" align="absmiddle" alt="<%=Replace(Translate.Translate("Redigeres af %%"),"%%",LockedByUserName)%>">
						<%			Else
				%>				<img src="../../Images/Icons/Stop.gif" border="0" align="absmiddle" alt="<%=Replace(Translate.Translate("Redigeres af %%"),"%%",LockedByUserName)%>">
						<%			End If
		End If
		
		If (LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID) And Base.HasAccess("CalenderEdit", "") Then%>
					<a href="calender_event_edit.aspx?CalenderEventID=<%=drCalender("CalenderEventID").tostring%>&CalenderCategoryID=<%=drCalender("CalenderEventCategoryID").tostring%>">
										<%=Server.HtmlEncode(drCalender("CalenderEventTitle").tostring())%>
									</a>
						<%		Else
			%>			<%=drCalender("CalenderEventTitle")%>
						<%		End If
		%>	</td>	
						
						<td width="50" align="center"><%=IncludeImg%></td>
						<td width="100" align="left"><%=Dates.ShowDate(CDate(drCalender("CalenderEventModified")), Dates.Dateformat.Short, False)%></td>
						<%If (LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID) And Base.HasAccess("CalenderDelete", "") Then%>
							<td width="48" align="center"><a href="javascript:DeleteCalenderEvent('<%=drCalender("CalenderEventID").tostring%>','<%=Base.JSEnable(Server.HtmlEncode(drCalender("CalenderEventTitle").tostring()))%>','<%=drCalender("CalenderEventCategoryID").tostring%>');"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("begivenhed"))%>"></a></td>
						<%		Else%>
							<td width="48" align="center"><img style="filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)" src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("begivenhed"))%>"></td>
						<%		End If%>
					</tr>
					<tr>
						<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
	 				</tr>
					<%Loop%>
					<%If Not blnHasRow Then%>
					<tr>
						<td colspan="3"><br /><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("begivenheder"))%></strong></td>
					</tr>
					<%End If%>

			</table>
			</div>
		</td>
	</tr>
	<tr valign="bottom">
		<td colspan="4" align="right">
		
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="6"><br></td>
			</tr>
			<tr>
				<%If Base.HasAccess("CalenderCreate", "") Then%>
				<td align="right"><%=Gui.Button(Translate.Translate("Ny begivenhed"), "window.open('Calender_event_edit.aspx?CalenderCategoryID=" & request.QueryString.Item("CalenderCategoryID") & "','_self');", 100)%></td>
				<td width="5"></td>
				<%End If%>
				<%If Base.HasAccess("CalenderEdit", "") Then%>
				<td align="right"><%=Gui.Button(Translate.Translate("Rediger %%", "%%", Translate.Translate("kategori")), "location='calender_category_edit.aspx?CalenderCategoryID=" & request.QueryString.Item("CalenderCategoryID") & "&CalenderCategory=" & Base.JSEnable(Server.HtmlEncode(Request.QueryString.Item("CalenderCategory"))) & "';", 0)%></td>
				<td width="5"></td>
				<%End If%>
				<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "location='Calender_Category_List.aspx';", 0)%></td>
				<%=Gui.HelpButton("calendar_create", "modules.calender.general.list.item",,5)%>
				<td width="10"></td>
			</tr>
			<tr>
				<td colspan="4" height="5"></td>
			</tr>			
		</table>
		</td>
		</tr> 
</table>
</body>
<%
ds.Dispose()
cmdSelect.Dispose()
cnCalender.Close()
cnCalender.Dispose()

Translate.GetEditOnlineScript()
%>
