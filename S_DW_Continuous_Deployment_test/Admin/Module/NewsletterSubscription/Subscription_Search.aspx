<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Subscription_Search.aspx.vb" Inherits="Dynamicweb.Admin.Subscription_Search" %>
<%@ Import Namespace="Dynamicweb.Admin"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Collections" %>

<%
Dim intCurEndCounter As Integer
Dim intCurPos As Integer
Dim intPageAmount As Integer
Dim intPosCounter As Integer
Dim intNextPos As Integer
Dim intRecordCount as Integer

Dim strSql As String
Dim AuditAreaID As Integer

Dim strSqlUpdateDB As String
Dim SortField As String

Dim SQLGetNews As String
Dim SQLGetCalendarWhere As String
Dim SQLGetNewsWhere As String
Dim strCheckBoxName As String
Dim SQLGetRows As String
Dim SQLGetParagraph As String
Dim SQLGetCalendar As String
Dim SQLGetParagraphWhere As String
Dim SQLGetPages As String
Dim SQLGetOrder As String

Dim AuditType As String

Dim AuditDateTimeFrom As String
Dim AuditDateTimeTo As String

Dim strIDTitleString As String

Dim width2To4 As String
Dim strLocation As String
Dim SortOrder As String

Dim SQLGetPagesWhere As String
Dim AuditUserID As String

Dim strAuditData As String
Dim width1 As String

Dim strAnd As String
Dim UserListOutput As String

Dim dicUsersEmail As HashTable
Dim dicAccssUser As HashTable

Dim strHome as String = "/admin/"


intPageAmount = 20
intCurPos = Base.ChkNumber(Request.Item("CurPos"))
If Not isNumeric(intCurPos) Then
	intCurPos = 0
End If
intCurPos = Cint(intCurPos)

width2To4 = "25"
width1 = "30"

If Base.HasAccess("Corporate", "") Then
	width2To4 = "20"
	width1 = "25"
End If

AuditUserID = Request.Item("AuditUserID")
AuditDateTimeFrom = Dates.ParseDate("AuditDateTimeFrom")



If AuditDateTimeFrom = "" Then
	If Request("AuditDateTimeFrom") <> "" Then
		AuditDateTimeFrom = Request("AuditDateTimeFrom") 
	Else
		AuditDateTimeFrom = "01-01-2005"
	End if
End If

AuditDateTimeTo = Dates.ParseDate("AuditDateTimeTo")

If AuditDateTimeTo = "" Then
	If Request("AuditDateTimeTo") <> "" Then
		AuditDateTimeTo = Request("AuditDateTimeTo") 
	Else
        AuditDateTimeTo = Dates.DWNow
	End If
End If
AuditAreaID = Base.ChkNumber(Request.Item("AuditAreaID"))
AuditType = Request.Item("AuditType")
SortOrder = Request.Item("SortOrder")
SortField = Request.Item("SortField")

If SortOrder = "" Then
	SortOrder = "ASC"
End If
If SortField = "" Then
	SortField = "5"
End If

    'If Base.GetGs("/Globalsettings/Modules/Audit/DifferentiatePagesParagraphs") = "True" Then										
SQLGetPages = "SELECT PageMenuText, PageID, PageCreatedDate, PageUserCreate, PageUpdatedDate, PageUserEdit, PageManager, '', 'Page_closed.gif' FROM Page"
'SQLGetParagraph = "SELECT ParagraphHeader, ParagraphID, ParagraphCreatedDate, ParagraphUserCreate, ParagraphUpdatedDate, ParagraphUserEdit, '', ParagraphPageID, 'paragraph.gif' FROM Paragraph INNER JOIN Page ON Page.PageID = Paragraph.ParagraphPageID "
'Else
'	SQLGetPages		= " SELECT PageMenuText, PageID, PageCreatedDate, PageUserCreate, PageUpdatedDate, PageUserEdit, PageManager, '', 'Page_closed.gif' FROM Page" & '					  " INNER JOIN Paragraph ON Paragraph.ParagraphPageID = Page.PageID"
'	SQLGetParagraph = ""
'End If

SQLGetNews = "SELECT NewsHeading, NewsID, NewsCreatedDate, NewsUserCreate, NewsUpdatedDate, NewsUserEdit, '', NewsCategoryID, 'Module_News_Small.gif' FROM News"
'SQLGetCalendar = "SELECT CalenderEventTitle, CalenderEventID, CalenderEventCreated, CalenderEventUserCreate, CalenderEventModified, CalenderEventUserEdit, '', CalenderEventCategoryID, 'Module_Calender_Small.gif' FROM CalenderEvent"

If AuditUserID = "0" Then
	SQLGetPagesWhere = " WHERE (PageUserCreate IN (NULL, 0) OR PageUserEdit IN (NULL, 0)) "
	'SQLGetParagraphWhere = " WHERE (ParagraphUserCreate IN (NULL, 0) OR ParagraphUserEdit IN (NULL, 0)) "
	SQLGetNewsWhere = " WHERE (NewsUserCreate IN (NULL, 0) OR NewsUserEdit IN (NULL, 0)) "
'	SQLGetCalendarWhere = " WHERE (CalenderEventCreated IN (NULL, 0) OR CalenderEventUserEdit IN (NULL, 0)) "
ElseIf AuditUserID = "" Then 
	SQLGetPagesWhere = " WHERE "
	'SQLGetParagraphWhere = " WHERE "
	SQLGetNewsWhere = " WHERE "
'	SQLGetCalendarWhere = " WHERE "
Else
	SQLGetPagesWhere = " WHERE (PageUserCreate = " & AuditUserID & " OR PageUserEdit = " & AuditUserID & ") "
	'SQLGetParagraphWhere = " WHERE (ParagraphUserCreate = " & AuditUserID & " OR ParagraphUserEdit = " & AuditUserID & ") "
	SQLGetNewsWhere = " WHERE (NewsUserCreate = " & AuditUserID & " OR NewsUserEdit = " & AuditUserID & ") "
	'SQLGetCalendarWhere = " WHERE (CalenderEventCreated = " & AuditUserID & " OR CalenderEventUserEdit = " & AuditUserID & ") "
End If

If IsDate(CDate(AuditDateTimeTo)) Then
	If IsNumeric(AuditUserID) Then
		strAnd = " AND "
	Else
		strAnd = ""
	End If
	SQLGetPagesWhere = SQLGetPagesWhere & strAnd & " ((PageCreatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ") OR (PageUpdatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ")) "
	'SQLGetParagraphWhere = SQLGetParagraphWhere & strAnd & " ((ParagraphCreatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ") OR (ParagraphUpdatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ")) "
	SQLGetNewsWhere = SQLGetNewsWhere & strAnd & " ((NewsCreatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ") OR (NewsUpdatedDate BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ")) "
	'SQLGetCalendarWhere = SQLGetCalendarWhere & strAnd & " ((CalenderEventCreated BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ") OR (CalenderEventModified BETWEEN " & Database.SqlDate(AuditDateTimeFrom) & " AND " & Database.SqlDate(AuditDateTimeTo) & ")) "
End If

If IsNumeric(AuditAreaID) And AuditAreaID <> "0" Then
	If SQLGetPagesWhere = " WHERE " Then
		SQLGetPagesWhere = SQLGetPagesWhere & " PageAreaID = " & AuditAreaID & " "
	'	SQLGetParagraphWhere = SQLGetParagraphWhere & " Page.PageAreaID = " & AuditAreaID & " "
	Else
		SQLGetPagesWhere = SQLGetPagesWhere & " AND PageAreaID = " & AuditAreaID & " "
	'	SQLGetParagraphWhere = SQLGetParagraphWhere & " AND Page.PageAreaID = " & AuditAreaID & " "
	End If
End If

SQLGetOrder = "ORDER BY " & SortField & " " & SortOrder

If SQLGetPagesWhere = " WHERE " Then
	SQLGetPagesWhere = ""
	'SQLGetParagraphWhere = ""
	SQLGetNewsWhere = ""
	SQLGetCalendarWhere = ""
End If

'If Base.GetGs("/Globalsettings/Modules/Audit/DifferentiatePagesParagraphs") <> "True" AND SQLGetPagesWhere <> "" Then										
'	SQLGetPagesWhere = Replace(SQLGetPagesWhere, "WHERE ", "")
'	SQLGetParagraphWhere = Replace(SQLGetParagraphWhere, "WHERE ", "")
'	SQLGetPagesWhere = " WHERE (" & SQLGetPagesWhere & ") OR (" & SQLGetParagraphWhere & ")"
'End If

If AuditType = "" Then
	SQLGetRows = SQLGetPages & SQLGetPagesWhere & vbNewLine & "UNION" & vbNewLine
	
	'If Base.GetGs("/Globalsettings/Modules/Audit/DifferentiatePagesParagraphs") = "True" Then
'		SQLGetRows = SQLGetRows & SQLGetParagraph & SQLGetParagraphWhere & vbNewLine & "UNION" & vbNewLine
'	End If
	SQLGetRows = SQLGetRows & SQLGetNews & SQLGetNewsWhere & vbNewLine' & "UNION" & vbNewLine & SQLGetCalendar & SQLGetCalendarWhere & vbNewLine & SQLGetOrder
Else
	If AuditType = "1" Then
		SQLGetRows = SQLGetPages & SQLGetPagesWhere & vbNewLine & SQLGetOrder
	ElseIf AuditType = "2" Then 
		'SQLGetRows = SQLGetParagraph & SQLGetParagraphWhere & vbNewLine & SQLGetOrder
	ElseIf AuditType = "3" Then 
		SQLGetRows = SQLGetNews & SQLGetNewsWhere & vbNewLine & SQLGetOrder
'	ElseIf AuditType = "4" Then 
'		SQLGetRows = SQLGetCalendar & SQLGetCalendarWhere & vbNewLine & SQLGetOrder
	End If
End If

'w SQLGetRows

strSql =	" SELECT AccessUserID, AccessUserName, AccessUserEmail FROM AccessUser " & _
			" WHERE (AccessUserType IN (1,4,5,3)) " & _
			" ORDER BY AccessUserID ASC"
		
Dim cnAccess	As System.Data.IDbConnection	= Database.CreateConnection("Access.mdb")
Dim cmdSelect	As IDbCommand					= cnAccess.CreateCommand
cmdSelect.CommandText = strSql
Dim drAccess	as IDataReader					= cmdSelect.ExecuteReader()

dicUsersEmail = New HashTable()
dicAccssUser = New HashTable()

Do While drAccess.Read()
	dicAccssUser.Add(drAccess(0).ToString, drAccess(1).ToString)
	dicUsersEmail.Add(drAccess(0).ToString, drAccess(2).ToString)
Loop 
drAccess.Close()
drAccess = cmdSelect.ExecuteReader()

%>
<SCRIPT LANGUAGE="JavaScript">
	function SetSort(intSortField) {
		if(AuditForm.SortField.value == intSortField) {
			if(AuditForm.SortOrder.value == 'ASC') {	
				AuditForm.SortOrder.value = 'DESC'
			} else {
				AuditForm.SortOrder.value = 'ASC'
			}
			AuditForm.submit();
		}else {
			AuditForm.SortField.value = intSortField
			AuditForm.submit();
		}
	}
	function UpdateElement() {
		AuditForm.UpdateElements.value = 'yes';
		AuditForm.submit();
	}
	function Paging(intDirection) {
		if(intDirection==-1) {
			AuditForm.CurPos.value = <%=intCurPos - intPageAmount%>
		} else {
			AuditForm.CurPos.value = <%=intCurPos + intPageAmount%>
		}
		UpdateSearch();
	}
	
	function UpdateSearch(){
		document.getElementById('AuditForm').action = 'Subscription_Search.aspx';
		document.getElementById('AuditForm').submit();
	}

	function SubmitSelected(){
		document.getElementById('AuditForm').action = 'Subscription_AddSubscription.aspx';
		document.getElementById('AuditForm').submit();
	}
	
	function updateSelections(obj){
	    var val = obj.name.toLowerCase() + "-" + obj.value;
	    var itemsHidden = document.getElementById("ItemsHidden");
	    
	    if (obj.checked) {
	        if (itemsHidden.value.indexOf(val) >= 0)
	            return;
	        itemsHidden.value = itemsHidden.value + "," + val;
	    } else {
	        itemsHidden.value = itemsHidden.value.replace("," + val, "").replace(val, "")
	    }
	}
</SCRIPT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Kategorier</TITLE>
		<LINK REL="STYLESHEET" TYPE="text/css" HREF="<%=strHome%>Stylesheet.css">
	</HEAD>
	<BODY>
		<form method="post" action="Subscription_Mail_Edit.aspx" id="AuditForm" name="AuditForm">
		<input type="hidden" ID="SortOrder" name="SortOrder" value="<%=SortOrder%>">
		<input type="hidden" ID="SortField" name="SortField" value="<%=SortField%>">
		<input type="hidden" ID="UpdateElements" name="UpdateElements" value="">
		<input type="hidden" ID="CurPos" name="CurPos" value="">
		<input type="hidden" id="ItemsHidden" name="ItemsHidden" value="<%=hiddenItemsValue %>" />
		
		<%=Gui.MakeHeaders(Translate.Translate("Indholdsabonnement",9) & " - " & Translate.Translate("Indhold"), Translate.Translate("Indhold"), "all")
%>
		<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable" ID="Table1">
			<TR>
				<TD valign="top">
					<BR>
					<div ID="Tab1" STYLE="display:;">
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table4">
							<TR>
								<TD WIDTH="170">&nbsp;<%=Translate.Translate("Vælg bruger")%></TD>
								<TD>
									<%
UserListOutput = "<SELECT name=""AuditUserID"" id=""AuditUserID"" class=""std"">" & vbNewLine

UserListOutput = UserListOutput & "<OPTION  value="""">" & Translate.Translate("Alle") & "</OPTION>"
UserListOutput = UserListOutput & "<OPTION  value=""0"">" & Translate.Translate("blank registrering") & "</OPTION>"

Do While drAccess.Read()
	UserListOutput = UserListOutput & "<option "
	If AuditUserID = drAccess("AccessUserID").ToString Then
		UserListOutput = UserListOutput & " SELECTED "
	End If
	UserListOutput = UserListOutput & "value=""" & drAccess("AccessUserID").ToString & """>" & drAccess("AccessUserName").ToString & "</option>" & Chr(10)
Loop 

UserListOutput = UserListOutput & "</SELECT>" & Chr(10)

Response.Write(UserListOutput)

'Cleanup
drAccess.Close()
drAccess.Dispose()
cmdSelect.Dispose()
cnAccess.Dispose()
%>
								</TD>
							</TR>
							<tr>
								<td width="150">&nbsp;<%=Translate.Translate("Vælg fra")%></td>
								<td><%=Dates.DateSelect(AuditDateTimeFrom, True, True, True, "AuditDateTimeFrom")%></td>
							</tr>
							<tr>
								<td width="150">&nbsp;<%=Translate.Translate("Vælg til")%></td>
								<td><%=Dates.DateSelect(AuditDateTimeTo, True, True, True, "AuditDateTimeTo")%></td>
							</tr>
							<TR>
								<TD WIDTH="170">&nbsp;<%=Translate.Translate("Vælg type")%></TD>
								<TD>
									<SELECT name="AuditType" id="AuditType" CLASS="Std">
										<option <%If AuditType = "" Then Response.Write("SELECTED")%> value=""><%=Translate.Translate("Alle")%></option>
										<option <%If AuditType = "1" Then Response.Write("SELECTED")%> value="1"><%=Translate.Translate("Side")%></option>
										<%If 1=2 then'If Base.GetGs("/globalsettings/Modules/Audit/DifferentiatePagesParagraphs") = "True" Then%>
											<option <%	If AuditType = "2" Then Response.Write("SELECTED")%> value="2"><%=Translate.Translate("Afsnit")%></option>
										<%End If%>
										<option <%If AuditType = "3" Then Response.Write("SELECTED")%> value="3"><%=Translate.Translate("Nyhed")%></option>
									</select>
								</TD>
							</TR>
							<tr>
								<td width="150">&nbsp;<%=Translate.Translate("Sproglag")%></td>
								<td><%=Gui.SelectArea("AuditAreaID", AuditAreaID)%></td>
							</tr>
							<tr>
								<td width="150"></td>
								<td><img src="/x.gif" height="1px" width="265px"><%=Gui.Button(Translate.Translate("Opdater"), "UpdateSearch()", 90)%></td>
							</tr>
							
						</TABLE>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Indhold"))%>
						<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%" ID="Table2">
							<TR>
								<TD>&nbsp;&nbsp; <STRONG><span style="cursor: hand;<%If SortField = "9" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(9);"><%=Translate.Translate("Type")%></span>/<span style="cursor: hand;<%If SortField = "1" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(1);"><%=Translate.Translate("Navn")%></span></STRONG></TD>
								<TD><STRONG><span style="cursor: hand;<%If SortField = "3" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(3);"><%=Translate.Translate("Oprettet")%></span>/<span style="cursor: hand;<%If SortField = "4" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(4);"><%=Translate.Translate("Hvem")%></spans></STRONG></TD>
								<TD><STRONG><span style="cursor: hand;<%If SortField = "5" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(5);"><%=Translate.Translate("Editeret")%></span>/<span style="cursor: hand;<%If SortField = "6" Then Response.Write("text-decoration :underline;")%>" onclick="SetSort(6);"><%=Translate.Translate("Hvem")%></span></STRONG></TD>
								<%If width2To4 = "20" Then
	Response.Write("<TD>&nbsp;<STRONG><span style=""cursor: hand;")
	If SortField = "7" Then
		Response.Write("text-decoration :underline;")
	End If
	Response.Write(""" onclick=""SetSort(7);"">" & Translate.Translate("Ansvarlig") & "</span></STRONG></TD>")
End If%>
								<TD WIDTH="5%">&nbsp;<STRONG><%=Translate.Translate("Vælg")%></STRONG></TD>
							</TR>
							<%


Dim cnAudit		As System.Data.IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdAudit	As IDbCommand					= cnAudit.CreateCommand
'throw new exception(SQLGetRows)
cmdAudit.CommandText = SQLGetRows
Dim drAudit		as IDataReader					= cmdAudit.ExecuteReader()
intRecordCount = 0
Do While drAudit.Read()
	intRecordCount += 1
Loop
drAudit.Close()
drAudit	= cmdAudit.ExecuteReader()

Dim blnDrAuditHasRows as Boolean = false
intPosCounter = 0
intNextPos = intCurPos + intPageAmount
Do While drAudit.Read()
	If Not blnDrAuditHasRows Then blnDrAuditHasRows = True
	If intPosCounter >= intCurPos And intPosCounter < intNextPos Then
		%>
							<TR>
								<TD COLSPAN="<%		If width2To4 = "20" Then Response.Write("5") Else Response.Write("4")%>" BGCOLOR="#C4C4C4">
								</TD>
							</TR>
							<%		
		strAuditData = "&NewsletterSubscription=false&AuditUserID=" & AuditUserID & "&AuditDateTimeFrom=" & AuditDateTimeFrom & "&AuditDateTimeTo=" & AuditDateTimeTo & "&AuditType=" & AuditType & "&SortOrder=" & SortOrder & "&SortField=" & SortField
		If drAudit(8) = "Page_closed.gif" Then
			strLocation = strHome & "Page_Edit.aspx?ID=" & drAudit(1).ToString & strAuditData
			strCheckBoxName = "Page"
			strIDTitleString = "PageID = " & drAudit(1)
		ElseIf drAudit(8).ToString = "paragraph.gif" Then 
			strLocation = strHome & "Paragraph/paragraph_edit.aspx?ID=" & drAudit(1).ToString & "&PageID=" & drAudit(7).ToString & strAuditData
			strCheckBoxName = "Paragraph"
			strIDTitleString = "ParagraphID = " & drAudit(1)
		ElseIf drAudit(8).ToString = "Module_News_Small.gif" Then 
			strLocation = strHome & "module/News/News_Module_Edit.aspx?CategoryID=" & drAudit(7).ToString & "&NewsID=" & drAudit(1).ToString & strAuditData
			strCheckBoxName = "News"
			strIDTitleString = "NewsID = " & drAudit(1)
		ElseIf drAudit.Item(8).ToString = "Module_Calender_Small.gif" Then 
			strLocation = strHome & "module/Calender/calender_event_edit.aspx?CalenderEventID=" & drAudit(1).ToString & "&CalenderCategoryID=" & drAudit(7).ToString & strAuditData
			strCheckBoxName = "Calendar"
			strIDTitleString = "CalendarID = " & drAudit(1).ToString
		End If
		
		%>
							<TR title="<%=strIDTitleString%>">
								<TD>
									<TABLE BORDER="0" CELLPADDING="0" WIDTH="100%">
										<TR>
											<TD width="32px" style="cursor: hand;" onclick="location = '<%=strLocation%>';">&nbsp;&nbsp; <img src="<%=strHome%>images/icons/<%=drAudit(8).ToString%>"></TD>
											<TD valign="middle" style="cursor: hand;" onclick="location = '<%=strLocation%>';"><%=drAudit(0).ToString%></TD>
										<TR>
									</TABLE>
								</TD>
								<TD>
									<%		
		If IsDate(drAudit(2)) Then
			Response.Write(Dates.ShowDate(CDate(drAudit(2).ToString), Dates.Dateformat.Short, True))
		End If
		If dicAccssUser.Item(drAudit(3).ToString) <> "" Then
			If dicUsersEmail.Item(drAudit(3).ToString) <> "" Then
				Response.Write(",<br><a title=""mailto"" style=""text-decoration :underline;"" href=""mailto:" & dicUsersEmail.Item(CStr(drAudit.Item(3))) & """>" & dicAccssUser.Item(CStr(drAudit.Item(3))) & "</a>")
			Else
				Response.Write(",<br>" & dicAccssUser.Item(drAudit(3).ToString))
			End If
		End If
		%>
								</TD>
								<TD>									
									<%		
		Response.Write(Dates.ShowDate(CDate(drAudit(4).ToString), Dates.Dateformat.Short, True))
		If dicAccssUser.Item(drAudit(5).ToString) <> "" Then
			If dicUsersEmail.Item(drAudit(5).ToString) <> "" Then
				Response.Write(",<br><a title=""mailto"" style=""text-decoration :underline;"" href=""mailto:" & dicUsersEmail.Item(drAudit(5).ToString) & """>" & dicAccssUser.Item(drAudit(5).ToString) & "</a>")
			Else
				Response.Write(",<br>" & dicAccssUser.Item(drAudit(5).ToString))
			End If
		End If
		%>
								</TD>
								<%		If width2To4 = "20" Then
			Response.Write("<TD>&nbsp;" & dicAccssUser.Item(drAudit(6).ToString) & "</TD>")
		End If%>
								<TD title="<%=Translate.Translate("Opdater")%>" align="center" WIDTH="5%">
								    <input type="checkbox" value="<%=drAudit(1).ToString%>" id="<%=strCheckBoxName%>" name="<%=strCheckBoxName%>" onclick="updateSelections(this)"
								    <%=Base.IIf(selectedItems.Contains(strCheckBoxName.ToLower() & "-" & drAudit(1).ToString), "checked=""checked""", "")  %> /></TD>
							</TR>
							<%		
		intCurEndCounter = intPosCounter
	End If
	intPosCounter = intPosCounter + 1
Loop 

If Not blnDrAuditHasRows Then
	%>
							<TR>
								<TD COLSPAN="3"><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%>
								</TD>
							</TR>
							<%	
End If

%>
							<TR>
								<TD COLSPAN="<%If width2To4 = "20" Then Response.Write("5") Else Response.Write("4")%>" BGCOLOR="#C4C4C4">
								</TD>
							</TR>
							<TR>
								<TD align="right" COLSPAN="<%If width2To4 = "20" Then Response.Write("5") Else Response.Write("4")%>">
									<%
'w intPosCounter & ":" & intNextPos & ":" & intCurPos & ":" & intCurEndCounter + 1 & ":" & (intCurEndCounter + 1) & " > " & drAudit.RecordCount
If intNextPos <> intPageAmount Then
	Response.Write("<img style=""cursor: hand;"" onclick=""Javascript:Paging(-1);"" src=""" & strHome & "images/Page_Previous.gif"">&nbsp;")
Else
End If
If Cint(intCurEndCounter + 1) < Cint(intRecordCount) Then
	Response.Write("<img style=""cursor: hand;"" onclick=""Javascript:Paging(1);"" src=""" & strHome & "images/Page_Next.gif"">&nbsp;")
Else
	Response.Write("<img src=""/x.gif"" height=""1px"" width=""20px"">&nbsp;")
End If
%>
								</TD>
							</TR>
							
							<TR>
								<TD COLSPAN="<%If width2To4 = "20" Then Response.Write("5") Else Response.Write("4")%>">
									&nbsp;
								</TD>
							</TR>
						</TABLE>
						<%=Gui.GroupBoxEnd%>

					</div>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="RIGHT" VALIGN="BOTTOM">
					<%=Gui.MakeOkCancelHelp("SubmitSelected();", "location='Subscription_Mail_Edit.aspx'", True, "modules.contextsubscription.general.list.edit.contents")%>
				</TD>
			</TR>
		</TABLE>
		</form>
	</BODY>
</HTML>

<%
'Cleanup
drAudit.Close()
drAudit.Dispose()
cmdAudit.Dispose()
cnAudit.Dispose()

%>

<%Translate.GetEditOnlineScript()%>