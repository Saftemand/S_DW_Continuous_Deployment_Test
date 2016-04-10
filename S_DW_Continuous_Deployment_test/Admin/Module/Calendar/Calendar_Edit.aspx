<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Calendar_Edit.aspx.vb" Inherits="Dynamicweb.Admin.CalendarEdit" ValidateRequest="false" codePage="65001" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

'**************************************************************************************************
'	Current version:	2.0
'	Created:			13-12-2005
'	Last modfied:		13-12-2005
'
'	Purpose: File to edit Calendar paragraphs
'
'	Revision history:
'		2.0 13-12-2005 Rasmus Pedersen RAP
'		Complete rewrite of the calendar module.
'**************************************************************************************************


%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<input type="Hidden" name="Calendar_Settings" value="IgnoreRest, EmailSubject, ThankYouPage, ApprovalMailTemplate, CreateFormTemplate, ApproveEvent, NotifyEmail, NotifyOnNew, ActiveCategoryCreate, ActiveLocationsCreate, CalendarFunction, CalendarInterval, Next, Previous, ParagraphMainTemplate, BookingCalendarTemplate, BookingMonthCalendarTemplate, BookingQuickAccessTemplate, BookingOwnReservationsTemplate, BookingOwnReservationsRowTemplate, BookingReportTemplate, BookingReportRowTemplate, CalendarTemplate, Date, Time, Event, Location, NoEvents, Title, Year, Month, Category, StartDate, EndDate, Description, ActiveLocations, ActiveCategories, ActiveReservations, ActiveWorkdays, CalendarShowCalendar, CalendarTimePeriod, EventTemplate, EventListTemplate, EventListPartTemplate, LocationTemplate, LocationListTemplate, LocationListPartTemplate, LocationEventListPartTemplate, CategoryTemplate, CategoryListTemplate, CategoryListPartTemplate, ReservationListTemplate, ReservationListPartTemplate, CategoryEventListPartTemplate, CalendarCustomMonthNames, CalendarUseCustomMonthNames, ShowType, MaxNumberOfEvents, DwMonday, DwTuesday, DwWednesday, DwThursday, DwFriday, DwSaturday, DwSunday, ReservationsView,ValidTo,ValidFrom">

<script>
<!--

function ToggleCustomNamer(){
	if(document.getElementById('CalendarUseCustomMonthFields').style.display == "none") {
		document.getElementById('CalendarUseCustomMonthFields').style.display = ""
	} else {
		document.getElementById('CalendarUseCustomMonthFields').style.display = "none"
	}	
}

function UnHideInterval(){
	document.getElementById('IntervalLabel').style.display = ""
}
function HideInterval(){
	document.getElementById('IntervalLabel').style.display = "none"
}

function UnHideMaxEvents(){
	document.getElementById('MaxNumberOfEventsLabel').style.display = ""
}
function HideMaxEvents(){
	document.getElementById('MaxNumberOfEventsLabel').style.display = "none"
}

function ToggleCreate() {
	if (document.getElementById('CreateEvents').checked) {
		document.getElementById('EventShow').style.display = 'none';
		document.getElementById('EventEdit').style.display = '';
		document.getElementById('ReservationShow').style.display = 'none';
	}
	var rev = document.getElementById('ShowReservations');
	if (rev != null && rev != 'undefined' && rev.checked) {
		document.getElementById('EventShow').style.display = 'none';
		document.getElementById('EventEdit').style.display = 'none';
		document.getElementById('ReservationShow').style.display = '';
	}
	if (document.getElementById('ShowEvents').checked) {
		document.getElementById('EventShow').style.display = '';
		document.getElementById('EventEdit').style.display = 'none';
		document.getElementById('ReservationShow').style.display = 'none';
	}
}

function ToggleShowCalendar(){
	if(typeof(document.getElementById('ShowCalendarSettings')) == "object") {
		if(document.getElementById('ShowCalendarSettings').style.display == "none") {
			document.getElementById('ShowCalendarSettings').style.display = ""
		} else {
			document.getElementById('ShowCalendarSettings').style.display = "none"
		}	
	}
}

//-->
</script>
<tr>
	<td>
		<%=Gui.MakeModuleHeader("Calendar", Translate.JsTranslate("Aktivitetskalender V2"))%>
	</td>
</tr>
<tr>
	<td width="100%">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td colspan=2>

					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Funktion")%></td>
							<td>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr>
										<td>
											<input runat="server" type="Radio" class="clean" id="ShowEvents" name="CalendarFunction" value="ShowEvents" onclick="ToggleCreate();"> <%=Translate.Translate("Vis begivenheder")%><BR>
											<input runat="server" type="Radio" class="clean" id="CreateEvents" name="CalendarFunction" value="CreateEvents" onclick="ToggleCreate();"> <%=Translate.Translate("Opret begivenheder")%><BR>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td valign=top width=170></td>
							<td><input runat="server" type="checkbox" class="clean" id="IgnoreRest" name="IgnoreRest" value="True"/><label for="IgnoreRest"><%=Translate.Translate("Do not maintain paragraph layout on page")%></label></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<div id="EventEdit" runat="server">
					<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Medtag følgende kategorier")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitCategoriesCreate" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Lokaliteter"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Medtag følgende lokaliteter")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitLocationsCreate" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Oprettelse"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Notificer")%></td>
							<td valign=top><input type="checkbox" name="NotifyOnNew" id="NotifyOnNew" value="Notify" runat="server"></td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Modtager")%></td>
							<td valign=top><input type="text" class="std" name="NotifyEmail" value="<%=objProp.Value("NotifyEmail")%>"></td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Emne")%></td>
							<td valign=top><input type="text" class="std" name="EmailSubject" value="<%=objProp.Value("EmailSubject")%>"></td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Godkendelse",1)%></td>
							<td valign=top><input type="checkbox" name="ApproveEvent" value="Approve" id="ApproveEvent" runat="server"></td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Kvitteringsside")%></td>
							<td valign=top><%=Gui.LinkManager(objProp.Value("ThankYouPage"), "ThankYouPage", "")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("E-mail")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("ApprovalMailTemplate"), "Templates/Calendar/Mail", "ApprovalMailTemplate")%></td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Oprettelse",1)%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CreateFormTemplate"), "Templates/Calendar/CreateForm", "CreateFormTemplate")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</div>
					<div id="EventShow" runat="server">
					<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Vis")%></td>
							<td>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr>
										<td>
											<input runat="server" type="Radio" class="clean" id="FromSelection" name="ShowType" value="FromSelection" onclick="HideInterval();UnHideMaxEvents();"><LABEL FOR=FromSelection><%=Translate.Translate("Begivenheder")%></LABEL>
										</td>
									</tr>
									<tr id="MaxNumberOfEventsLabel" valign=top runat=server>
										<td style="padding-left:20px;">
											<LABEL FOR=MaxNumberOfEvents><%=Translate.Translate("Vis antal")%> </LABEL> <input runat="server" type="Text" class="std" maxlength="255" style="width:35px;" name="MaxNumberOfEvents" id="MaxNumberOfEvents">
										</td>
									</tr>
									<tr>
										<td>
											<input runat="server" type="Radio" class="clean" id="ListLocations" name="ShowType" value="ListLocations" onclick="HideInterval();HideMaxEvents();"><LABEL FOR=ListLocations><%=Translate.Translate("Lokaliteter")%></LABEL>
										</td>
									</tr>
									<tr>
										<td>
											<input runat="server" type="Radio" class="clean" id="ListCategories" name="ShowType" value="ListCategories" onclick="HideInterval();HideMaxEvents();"><LABEL FOR=ListCategories><%=Translate.Translate("Kategorier")%></LABEL>
										</td>
									</tr>
									<tr>
										<td>
											<input runat="server" type="Radio" class="clean" id="AsCalendar" name="ShowType" value="AsCalendar" onclick="UnHideInterval();HideMaxEvents();"><LABEL FOR=AsCalendar><%=Translate.Translate("Kalender")%></LABEL>
										</td>
									</tr>
									<tr id="IntervalLabel" runat=server valign=top>
										<td style="padding-left:20px;">
											<input runat="server" type="Radio" class="clean" id="UseDay" name="CalendarInterval" value="Day"><LABEL FOR=UseDay><%=Translate.Translate("Dag")%></LABEL><br />
											<input runat="server" type="Radio" class="clean" id="UseWeek" name="CalendarInterval" value="Week"><LABEL FOR=UseWeek><%=Translate.Translate("Uge")%></LABEL><br />
											<input runat="server" type="Radio" class="clean" id="UseMonth" name="CalendarInterval" value="Month"><LABEL FOR=UseMonth><%=Translate.Translate("Måned")%></LABEL><br />
											<input runat="server" type="Radio" class="clean" id="UseYear" name="CalendarInterval" value="Year"><LABEL FOR=UseYear><%=Translate.Translate("År")%></LABEL>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Medtag følgende kategorier")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitCategories" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Lokaliteter"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Medtag følgende lokaliteter")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitLocations" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><strong><%=Translate.Translate("Kalender")%></strong></td>
							<td valign=top></td>
						</tr>

						<tr>
							<td valign=top width="170"><%=Translate.Translate("List")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CalendarTemplate"), "Templates/Calendar/Calendar", "CalendarTemplate")%></td>
						</tr>
					</table>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><strong><%=Translate.Translate("Kategori")%></strong></td>
							<td valign=top></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CategoryListTemplate"), "Templates/Calendar/CategoryList", "CategoryListTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CategoryListPartTemplate"), "Templates/Calendar/Category", "CategoryListPartTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CategoryTemplate"), "Templates/Calendar/Category", "CategoryTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Begivenhed - %%", "%%", Translate.Translate("Liste element"))%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("CategoryEventListPartTemplate"), "Templates/Calendar/Event", "CategoryEventListPartTemplate")%></td>
						</tr>
					</table>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><strong><%=Translate.Translate("Lokalitet")%></strong></td>
							<td valign=top></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("LocationListTemplate"), "Templates/Calendar/LocationList", "LocationListTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("LocationListPartTemplate"), "Templates/Calendar/Location", "LocationListPartTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("LocationTemplate"), "Templates/Calendar/Location", "LocationTemplate")%></td>
						</tr>

						<tr>
							<td valign=top><%=Translate.Translate("Begivenhed - %%", "%%", Translate.Translate("Liste element"))%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("LocationEventListPartTemplate"), "Templates/Calendar/Event", "LocationEventListPartTemplate")%></td>
						</tr>
					</table>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><strong><%=Translate.Translate("Begivenhed")%></strong></td>
							<td valign=top></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("EventListTemplate"), "Templates/Calendar/EventList", "EventListTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("EventListPartTemplate"), "Templates/Calendar/Event", "EventListPartTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("EventTemplate"), "Templates/Calendar/Event", "EventTemplate")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</div>
					<div id="ReservationShow" runat="server">
					<%=Gui.GroupBoxStart(Translate.Translate("Reservations"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Views")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr><td><%=Translate.Translate("Multiple calendar view (day view)")%></td><td><input type="radio" name="ReservationsView" id="MultipleView" runat="server" value="multiple" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'none':'block')"></td></tr>
									<tr><td><%=Translate.Translate("Normal Week calendar view")%></td><td><input type="radio" name="ReservationsView" id="NormalView" value="normal" runat="server" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'none':'block')"></td></tr>
									<tr><td><%=Translate.Translate("Work week calendar view")%></td><td><input type="radio" name="ReservationsView" id="WorkweekView" value="workweek" runat="server" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'block':'none')"></td></tr>
									<tr><td><%=Translate.Translate("Month calendar view")%></td><td><input type="radio" name="ReservationsView" id="MonthView" value="month" runat="server" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'none':'block')"></td></tr>
									<tr><td><%=Translate.Translate("My own reservations")%></td><td><input type="radio" name="ReservationsView" id="OwnView" value="ownreservations" runat="server" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'none':'block')"></td></tr>
									<tr><td><%=Translate.Translate("Report viewer")%></td><td><input type="radio" name="ReservationsView" id="ReportView" value="report" runat="server" onclick="document.getElementById('workdaysrow').style.display=((this.checked)?'none':'block')"></td></tr>
								</table>
							</td>
						</tr>
						<tr>
							<td valign=top width=170><%=Translate.Translate("Reservations to include")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitReservations" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
						<tr id="workdaysrow" runat="server">
							<td valign=top width=170><%=Translate.Translate("Work days")%></td>
							<td valign=top>
								<table cellpadding=0 cellspacing=0 border=0>
									<asp:literal id="LitWorkdays" runat="server"></asp:literal>
								</table>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Afsnits-skabelon")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("ParagraphMainTemplate"), "Templates/Calendar/Booking", "ParagraphMainTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Normal view calendar")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingCalendarTemplate"), "Templates/Calendar/Booking", "BookingCalendarTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Month calendar")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingMonthCalendarTemplate"), "Templates/Calendar/Booking", "BookingMonthCalendarTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Quick Access")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingQuickAccessTemplate"), "Templates/Calendar/Booking", "BookingQuickAccessTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Own Reservations")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingOwnReservationsTemplate"), "Templates/Calendar/Booking", "BookingOwnReservationsTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Own Reservations Element")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingOwnReservationsRowTemplate"), "Templates/Calendar/Booking", "BookingOwnReservationsRowTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Report viewer")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingReportTemplate"), "Templates/Calendar/Booking", "BookingReportTemplate", "")%></td>
						</tr>
						<tr>
							<td valign=top width="170"><%=Translate.Translate("Report viewer element")%></td>
							<td valign=top><%=gui.FileManager(objProp.Value("BookingReportRowTemplate"), "Templates/Calendar/Booking", "BookingReportRowTemplate", "")%></td>
						</tr>
					</table>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td valign=top width="170"><strong><%=Translate.Translate("Reservations")%></strong></td>
							<td valign=top></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("ReservationListTemplate"), "Templates/Calendar/ReservationList", "ReservationListTemplate")%></td>
						</tr>
						<tr>
							<td valign=top><%=Translate.Translate("Liste element")%></td>
							<td valign=top><%=Gui.FileManager(objProp.Value("ReservationListPartTemplate"), "Templates/Calendar/ReservationList", "ReservationListPartTemplate")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</div>
					<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
					<table cellpadding=2 cellspacing=0 border=0>
						<tr>
							<td width="170"><%=Translate.Translate("Titel")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Title" id="Title"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Dato")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Date" id="Date"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("År")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Year" id="Year"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Måned")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Month" id="Month"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Tid")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Time" id="Time"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Kategori")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Category" id="Category"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Begivenhed")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Event" id="Event"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Lokalitet")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Location" id="Location"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Ingen begivenheder")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="NoEvents" id="NoEvents"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Start dato")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="StartDate" id="StartDate"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Slut dato")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="EndDate" id="EndDate"></td>
						</tr>
						<tr>
							<td><%= Translate.Translate("Gyldig Fra")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="ValidFrom" id="ValidFrom"></td>
						</tr>
						<tr>
							<td><%= Translate.Translate("Gyldig Til")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="ValidTo" id="ValidTo"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Beskrivelse")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Description" id="Description"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Næste")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Next" id="Next"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Forrige")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="Previous" id="Previous"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Monday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwMonday" id="DwMonday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Tuesday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwTuesday" id="DwTuesday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Wednesday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwWednesday" id="DwWednesday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Thursday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwThursday" id="DwThursday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Friday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwFriday" id="DwFriday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Saturday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwSaturday" id="DwSaturday"></td>
						</tr>
						<tr>
							<td><%=Translate.Translate("Sunday")%></td>
							<td><input runat="server" type="Text" class="std" maxlength="255" name="DwSunday" id="DwSunday"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
	</td>
</tr>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
