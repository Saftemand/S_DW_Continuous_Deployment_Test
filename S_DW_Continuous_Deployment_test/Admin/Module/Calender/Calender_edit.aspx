<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ Page CodeBehind="Calender_edit.aspx.vb" validateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Calender_edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

'**************************************************************************************************
'	Current version:	1.1
'	Created:			06-12-2001
'	Last modfied:		14-06-2004
'
'	Purpose: File to edit calender paragraphs
'
'	Revision history:
'		1.1 - 13-06-2004 - David Frandsen
'		Converted to .NET
'		1.0.2 - 17-01-2002 - Michael Skarum
'		Removed the used of the function "Input field" (Not longer used in DW)
'		1.0.1 - 13-12-2001 - Michael Skarum
'		Fixed bugs
'		1.0 - 06-12-2001 - Michael Skarum
'		First version.
'**************************************************************************************************

Dim strCalenderCustomMonthsLegend = "<input type=""CheckBox"" onclick=""ToggleCustomNamer();"" name=""CalenderUseCustomMonthNames"" value=""1"" id=""both"" checked>" & Translate.Translate("Custom måned navne")

Dim CalenderDesignCategoryIDArray() As String
Dim ParagraphModuleSettings As String
Dim arrCalenderCustomMonthNames() As String
Dim ParagraphID As Integer
Dim sql As String
Dim i As Integer
Dim checked As Boolean
Dim propObj As new Properties()
Dim blnNewParagraph as Boolean = false


If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If



Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        propObj = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        blnNewParagraph = True
    End If

If blnNewParagraph = false Then
	
	If propObj.Value("CalenderDesignShowPlace")	= "1" Then
		propObj.Value("CalenderDesignShowPlace") = "checked"
	End If
	If propObj.Value("CalenderDesignShowTime")	= "1" Then
		propObj.Value("CalenderDesignShowTime")	= "checked"
	End If
	If Not propObj.Value("CalenderDesignTimePeriod") = "" Then
		If CShort(propObj.Value("CalenderDesignTimePeriod"))	= 1 Then
			propObj.Value("CalenderDesignTimePeriodYear")	= ""
			propObj.Value("CalenderDesignTimePeriodMonth")	= "checked"
		ElseIf CShort(propObj.Value("CalenderDesignTimePeriod")) = 2 Then 
			propObj.Value("CalenderDesignTimePeriodYear")	= "checked"
			propObj.Value("CalenderDesignTimePeriodMonth")	= ""
		'ElseIf CShort(propObj.Value("CalenderDesignTimePeriod")) = 3 Then 
		'	propObj.Value("CalenderDesignTimePeriodAll")	= "checked"
		'	propObj.Value("CalenderDesignTimePeriodMonth")	= ""
		Else
			propObj.Value("CalenderDesignTimePeriodYear")	= ""
			propObj.Value("CalenderDesignTimePeriodMonth")	= "checked"
		End If
	End If
Else
	propObj.Value("CalenderDesignTextDate")				= Translate.Translate("Dato")
	propObj.Value("CalenderDesignTextTime")				= Translate.Translate("Tid")
	propObj.Value("CalenderDesignTextEvent")			= Translate.Translate("Begivenhed")
	propObj.Value("CalenderDesignTextPlace")			= Translate.Translate("Sted")
	propObj.Value("CalenderDesignTextNoEvents")			= Translate.Translate("Ingen begivenheder")
	propObj.Value("CalenderDesignTextNextPage")			= Translate.Translate("Næste side")
	propObj.Value("CalenderDesignTextPrevPage")			= Translate.Translate("Forrige side")
	propObj.Value("CalenderImages")						= ""
	propObj.Value("CalenderCategoryChkbox")				= ""
	propObj.Value("CalenderDesignMaxEvents")			= "5"
	propObj.Value("CalenderDesignShowPlace")			= "1"
	propObj.Value("CalenderDesignShowTime")				= "1"
	propObj.Value("CalenderDesignShowCalender")			= "1"
	propObj.Value("CalenderDesignTimePeriod")			= "1"
	propObj.Value("CalenderDesignTimePeriodYear")		= ""
	propObj.Value("CalenderDesignTimePeriodMonth")		= "checked"
	propObj.Value("CalenderUseCustomMonthNames")		= "0"
	propObj.Value("CalenderShowMEqueals")				= "0"
	
End If

sql = "Select * from CalenderCategory order by CalenderCategory"
Dim cnCalenderCategory	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdCalenderCategory As IDbCommand		= cnCalenderCategory.CreateCommand
cmdCalenderCategory.CommandText = sql
Dim drCalenderCategory	As IDataReader		= cmdCalenderCategory.ExecuteReader()

If InStr(propObj.Value("CalenderCustomMonthNames"), ",") Then
	arrCalenderCustomMonthNames = Split(propObj.Value("CalenderCustomMonthNames"), ",")
Else
	Redim arrCalenderCustomMonthNames(12)
	arrCalenderCustomMonthNames(0) = Dates.Medmonth(1)
	arrCalenderCustomMonthNames(1) = Dates.Medmonth(2)
	arrCalenderCustomMonthNames(2) = Dates.Medmonth(3)
	arrCalenderCustomMonthNames(3) = Dates.Medmonth(4)
	arrCalenderCustomMonthNames(4) = Dates.Medmonth(5)
	arrCalenderCustomMonthNames(5) = Dates.Medmonth(6)
	arrCalenderCustomMonthNames(6) = Dates.Medmonth(7)
	arrCalenderCustomMonthNames(7) = Dates.Medmonth(8)
	arrCalenderCustomMonthNames(8) = Dates.Medmonth(9)
	arrCalenderCustomMonthNames(9) = Dates.Medmonth(10)
	arrCalenderCustomMonthNames(10) = Dates.Medmonth(11)
	arrCalenderCustomMonthNames(11) = Dates.Medmonth(12)
End If

Dim blnDrCalenderCategoryHasRows = False
CalenderDesignCategoryIDArray = Split(propObj.Value("CalenderDesignCategoryID"), ",")
Do While drCalenderCategory.Read()
	if Not isDbNull(drCalenderCategory("CalenderCategoryID")) Then
	If Not blnDrCalenderCategoryHasRows Then
		blnDrCalenderCategoryHasRows = True
	End If
	If UBound(CalenderDesignCategoryIDArray) >= 0 Then
		For y As Integer = LBound(CalenderDesignCategoryIDArray) To UBound(CalenderDesignCategoryIDArray)
			If Base.ChkNumber(CalenderDesignCategoryIDArray(y)) = Base.ChkNumber(drCalenderCategory("CalenderCategoryID").ToString) Then
				propObj.Value("CalenderCategoryChkbox") = propObj.Value("CalenderCategoryChkbox") & Chr(10) & "<input checked class=""clean"" type=""checkbox"" name=""CalenderDesignCategoryID"" value=""" & drCalenderCategory("CalenderCategoryID").ToString & """>" & drCalenderCategory("CalenderCategory").ToString & "<br>"
				checked = True
			End If
		Next 
		If Not checked Then
			propObj.Value("CalenderCategoryChkbox") = propObj.Value("CalenderCategoryChkbox") & Chr(10) & "<input  class=""clean"" type=""checkbox"" name=""CalenderDesignCategoryID"" value=""" & drCalenderCategory("CalenderCategoryID").ToString & """>" & drCalenderCategory("CalenderCategory").ToString & "<br>"
		End If
		checked = False
	Else
		propObj.Value("CalenderCategoryChkbox") = propObj.Value("CalenderCategoryChkbox") & Chr(10) & "<input  class=""clean"" type=""checkbox"" name=""CalenderDesignCategoryID"" value=""" & drCalenderCategory("CalenderCategoryID").ToString & """>" & drCalenderCategory("CalenderCategory").ToString & "<br>"
	End If
	End If
Loop 

If Not blnDrCalenderCategoryHasRows Then
	Response.Write("<strong>" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier")) & "</strong>")
	drCalenderCategory.Close()
	drCalenderCategory.Dispose()
	cmdCalenderCategory.Dispose() 
	cnCalenderCategory.Close()
	cnCalenderCategory.Dispose()
Else

drCalenderCategory.Close()
drCalenderCategory.Dispose()
cmdCalenderCategory.Dispose() 
cnCalenderCategory.Close()
cnCalenderCategory.Dispose()

%>
<input type="Hidden" name="Calender_Settings" value="CalenderDesignTextDate, CalenderDesignTextTime, CalenderDesignTextEvent, CalenderDesignTextPlace, CalenderDesignTextNoEvents, CalenderDesignTextNextPage, CalenderDesignTextPrevPage, CalenderImages, CalenderDesignMaxEvents, CalenderDesignShowPlace, CalenderDesignShowTime, CalenderDesignShowCalender, CalenderDesignTimePeriod, CalenderDesignCategoryID, CalenderCustomMonthNames, CalenderUseCustomMonthNames, CalenderShowMEqueals">


<script>
<!--

function ToggleCustomNamer(){
	if(typeof(document.all.CalenderUseCustomMonthFields) == "object") {
		if(document.all.CalenderUseCustomMonthFields.style.display == "none") {
			document.all.CalenderUseCustomMonthFields.style.display = ""
		} else {
			document.all.CalenderUseCustomMonthFields.style.display = "none"
		}	
	}
}

function ToggleShowCalender(){
	if(typeof(document.all.ShowCalenderSettings) == "object") {
		if(document.all.ShowCalenderSettings.style.display == "none") {
			document.all.ShowCalenderSettings.style.display = ""
		} else {
			document.all.ShowCalenderSettings.style.display = "none"
		}	
	}
}

//-->
</script>
<tr>
	<td>
		<%=Gui.MakeModuleHeader("calender", "Aktivitetskalender")%>
	</td>
</tr>
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td width=170><%=Translate.Translate("Dato")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextDate" value="<%=propObj.Value("CalenderDesignTextDate")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Tid")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextTime" value="<%=propObj.Value("CalenderDesignTextTime")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Begivenhed")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextEvent" value="<%=propObj.Value("CalenderDesignTextEvent")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Sted")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextPlace" value="<%=propObj.Value("CalenderDesignTextPlace")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Ingen begivenheder")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextNoEvents" value="<%=propObj.Value("CalenderDesignTextNoEvents")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Næste side")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextNextPage" value="<%=propObj.Value("CalenderDesignTextNextPage")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Forrige side")%></td>
							<td><input type="Text" class="std" maxlength="255" name="CalenderDesignTextPrevPage" value="<%=propObj.Value("CalenderDesignTextPrevPage")%>"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Kalenderbillede")%></td>
							<td><%= Gui.FileManager(propObj.Value("CalenderImages"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "CalenderImages")%></td>
						</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					<%if propObj.Value("CalenderUseCustomMonthNames")="1" then
						response.write(Gui.GroupBoxStart(strCalenderCustomMonthsLegend))
					else
						response.write(Gui.GroupBoxStart(replace(strCalenderCustomMonthsLegend, " checked", " ")))
					end if%>
					&nbsp;
					<table cellpadding=2 cellspacing=0 border=0 ID="CalenderUseCustomMonthFields" ID="CalenderUseCustomMonthFields" style="display=<%If propObj.Value("CalenderUseCustomMonthNames") = "1" Then Response.Write("") Else Response.Write("none")%> ;">
						<tr>
							<td width=170><%=Dates.LongMonth(1)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(0)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(2)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(1)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(3)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(2)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(4)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(3)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(5)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(4)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(6)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(5)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(7)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(6)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(8)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(7)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(9)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(8)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(10)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(9)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(11)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(10)%>"></td>
						</tr>
						<tr>
							<td><%=Dates.LongMonth(12)%></td>
							<td><input type="Text" maxlength="255" class="std" name="CalenderCustomMonthNames" value="<%=arrCalenderCustomMonthNames(11)%>"></td>
						</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td width=170><%=Translate.Translate("Max. antal begivenheder")%></td>
							<td>
								<input type="Text" maxlength="255" class="std" name="CalenderDesignMaxEvents" value="<%=propObj.Value("CalenderDesignMaxEvents")%>" style="width:25px;">
							</td>
						</tr>
						<tr>
							<td  valign="top"><%=Translate.Translate("Oplysninger")%></td>
							<td>
								<input type="Checkbox" VALUE="1" class="clean" name="CalenderDesignShowPlace" <%=propObj.Value("CalenderDesignShowPlace")%>> <%=Translate.Translate("Vis sted")%><br>
								<input type="Checkbox" VALUE="1" class="clean" name="CalenderDesignShowTime" <%=propObj.Value("CalenderDesignShowTime")%>> <%=Translate.Translate("Vis tidspunkt")%><br>
							</td>
						</tr>
						<tr>
							<td valign="top"><%=Translate.Translate("Kalender")%></td>
							<td>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr>
										<td><input type="checkbox" onclick="ToggleShowCalender();" name="CalenderDesignShowCalender" value="1" <%If propObj.Value("CalenderDesignShowCalender") = "1" Then Response.Write("CHECKED")%> ID="Checkbox1"></td>
										<td>&nbsp;<%=Translate.Translate("Vis kalender")%></td>
									</tr>
								</table>
								<table cellpadding=0 cellspacing=0 border=0 ID="ShowCalenderSettings" style="display=<%If propObj.Value("CalenderDesignShowCalender") = "1" Then Response.Write("") Else Response.Write("none")%> ;">
									<tr>
										<td>
											<input type="Radio" class="clean" name="CalenderDesignTimePeriod" value="1" <%=propObj.Value("CalenderDesignTimePeriodMonth")%>> <%=Translate.Translate("Vis ´År/Måned´")%><BR>
											<input type="Radio" class="clean" name="CalenderDesignTimePeriod" value="2" <%=propObj.Value("CalenderDesignTimePeriodYear")%>> <%=Translate.Translate("Vis ´År´")%><BR>
											<!-- <input type="Radio" class="clean" name="CalenderDesignTimePeriod" value="3" <%=propObj.Value("CalenderDesignTimePeriodAll")%>> <%=Translate.Translate("Vis alle")%> -->
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Vis begivenhed som afsnit")%></td>
							<td><input type="checkbox" name="CalenderShowMEqueals" value="1" <%If propObj.Value("CalenderShowMEqueals") = "1" Then Response.Write("CHECKED")%>></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Medtag følgende kategorier")%></td>
							<td valign=top><%=propObj.Value("CalenderCategoryChkbox")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
	</td>
</tr>

<script language="JavaScript">
	function Check_CalenderDesignShowCalender_box(){
		if (document.paragraph_edit.CalenderDesignShowCalender.checked){
			document.paragraph_edit.CalenderDesignTimePeriod[0].disabled = false;
			document.paragraph_edit.CalenderDesignTimePeriod[1].disabled = false;
			<%If (propObj.Value("CalenderDesignTimePeriod")) = "1" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[0].checked = true;
			<%ElseIf (propObj.Value("CalenderDesignTimePeriod")) = "2" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[1].checked = true;
			<%ElseIf (propObj.Value("CalenderDesignTimePeriod")) = "3" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[2].checked = true;
			<%End If%>
		}
		else {
			document.paragraph_edit.CalenderDesignTimePeriod[0].disabled = true;
			document.paragraph_edit.CalenderDesignTimePeriod[1].disabled = true;
			<%If (propObj.Value("CalenderDesignTimePeriod")) = "1" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[0].checked = true;
			<%ElseIf (propObj.Value("CalenderDesignTimePeriod")) = "2" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[1].checked = true;
			<%ElseIf (propObj.Value("CalenderDesignTimePeriod")) = "3" Then%>
			document.paragraph_edit.CalenderDesignTimePeriod[2].checked = true;
			<%End If%>
		}
	}
	
	function Check_CalenderDesignCategoryID_boxes(){ 
	if (document.paragraph_edit.CalenderDesignCategoryID.checked){
			return true;
	}
	else{
		for(i=0;i<document.paragraph_edit.CalenderDesignCategoryID.length;i++){
			if(document.paragraph_edit.CalenderDesignCategoryID[i].checked){
				return true;
			}
		}
	}
}
//Check_CalenderDesignShowCalender_box()

</script>
<%
End If
%>

<%
Translate.GetEditOnlineScript()
%>