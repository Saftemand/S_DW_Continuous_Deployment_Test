<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="Booking_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Booking_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="Booking"  />
<dw:ModuleSettings ID="ModuleSettings1" runat="server" ModuleSystemName="Booking" Value="ShowAction, EditReservationTemplate, ShowReservationTemplate, Arrange, Startfrom, PeriodAdd, CalendarTemplate, ItemID, OrderListBy, CategoryShow, CategoryID, ShowBookingTemplate, HourStart, HourEnd, HourSplit, ExpandMonthHoleWeeks, MaxAllowedOffset, SelectedCategoryID" />

<script type="text/javascript">
    $$('body').each(function (el) { el.setStyle({ backgroundColor: '#fff' }) });

	function ActionChanged() {
		if (document.forms.paragraph_edit.ShowAction[1].checked) {
			document.getElementById("listSettings").style.display = "block";
			document.getElementById("resoucesettings").style.display = "none";
			if (document.getElementById("calendarSettings") != null) {
			    document.getElementById("calendarSettings").style.display = "none";
			}
		}
		else {
			document.getElementById("listSettings").style.display = "none";
			document.getElementById("resoucesettings").style.display = "block";
			if (document.getElementById("calendarSettings") != null) {
			    document.getElementById("calendarSettings").style.display = "block";
			}
		}
    }

    function UpdateItemID() {
        $('ResourceCell').select('[name="ItemIDs"]').each(function (s) {
            Event.observe(s, 'click', function () {
                $("ItemID").value = s.value;
            })
        });

        $('ResourceCell').select('[name="ItemIDs"]').each(function (s) {
            if (s.checked) {
                $("ItemID").value = s.value;
            }
        });
    }

    function SelectionChanged() {

        $("SelectedCategoryID").value = $("CategorySelector").value

        var url = "/Admin/Module/Booking/Booking_Edit.aspx"

        new Ajax.Request(url, {
            method: 'get',
            parameters: {
                CategoryID: $("CategorySelector").value
            },
            onSuccess: function (transport) {
                $("ResourceCell").update(transport.responseText);
                UpdateItemID();
            }
        });
    }
</script>

<dw:GroupBox ID="GroupBox1" runat="server" Title="Action" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
			</td>
			<td>
				<dw:RadioButton ID="ShowActionShowResource" runat="server" FieldName="ShowAction" FieldValue="ShowResource" />
				<label for="ShowActionShowResource">
					<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Kalender" /></label><br />
				
				<dw:RadioButton ID="ShowActionListResources" runat="server" FieldName="ShowAction" FieldValue="ListResources" />
				<label for="ShowActionListResources">
					<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="List" />
					</label><br />
			</td>
		</tr>
	</table>
</dw:GroupBox>
<div id="resoucesettings">
<dw:GroupBox ID="GroupBox5" runat="server" Title="Show" DoTranslation="true">
<table>
		<tr>
			<td style="width: 170px;" valign="top">
				<dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="Category" />
			</td>
            <td>
                <select id="CategorySelector" onchange="SelectionChanged();" style="width:250px;">
                    <%=CategorySelect.ToString()%>
                </select>
                <input type="hidden" name="SelectedCategoryID" id="SelectedCategoryID" value="" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 170px;" valign="top">
                <dw:TranslateLabel ID="TranslateLabel00" runat="server" Text="Item" />
            </td>
			<td>
				<table border="0" cellpadding="2" cellspacing="0" id="Table1">
					<tr>
						<td id="ResourceCell" runat="server">
						</td>
					</tr>
                    <input type="hidden" name="ItemID" id="ItemID" value="" runat="server" />
				</table>
			</td>
		</tr>
	</table>
</dw:GroupBox>
</div>
<div id="listSettings">
    <dw:GroupBox ID="GroupBox3" runat="server" Title="Vis" DoTranslation="true">
	    <table>
		    <tr>
			    <td style="width: 170px;" valign="top">
				    <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Category" />
			    </td>
			    <td>
				    <dw:RadioButton ID="CategoryShowAll" runat="server" FieldName="CategoryShow" FieldValue="All" />
				    <label for="CategoryShowAll">
					    <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Alle" />
					    </label><br />
				    <dw:RadioButton ID="CategoryShowSelected" runat="server" FieldName="CategoryShow"
					    FieldValue="Selected" />
				    <label for="CategoryShowSelected">
					    <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Valgte" /></label><br />
				    <dw:RadioButton ID="CategoryShowAllButSelected" runat="server" FieldName="CategoryShow"
					    FieldValue="AllButSelected" />
				    <label for="CategoryShowAllButSelected">
					    <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Alle, undtagen valgte" /></label><br />
				    <table border="0" cellpadding="2" cellspacing="0" id="CategoryTable">
					    <tr>
						    <td style="width: 10px;">
						    </td>
						    <td id="CategoryCell" runat="server">
						    </td>
					    </tr>
				    </table>
			    </td>
		    </tr>
	    </table>
    </dw:GroupBox>

	<dw:GroupBox ID="GroupBox4" runat="server" Title="List items" DoTranslation="true">
		<table>
			<tr>
				<td style="width: 170px;">
					<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Template" />
				</td>
				<td>
					<dw:FileManager ID="ListItemTemplate" runat="server" Folder="/Templates/Booking/ListItems" />
				</td>
			</tr>
			<tr style="display:none;"> <!--Currently always sort by name -->
				<td style="width: 170px;" valign="top">
					<dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Order by" />
				</td>
				<td>
					<dw:RadioButton ID="OrderListByName" runat="server" FieldName="OrderListBy" FieldValue="Name" />
					<label for="OrderListByName">
						<dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Name" /></label><br />

					<dw:RadioButton ID="OrderListBySort" runat="server" FieldName="OrderListBy" FieldValue="Sort" />
					<label for="OrderListBySort">
						<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Sort" /></label><br />
				</td>
			</tr>
		</table>
	</dw:GroupBox>
    <script type="text/javascript">
	    document.getElementById("ShowActionShowResource").onclick = ActionChanged;
	    document.getElementById("ShowActionListResources").onclick = ActionChanged;
	    ActionChanged();
    </script>
</div>

<script type="text/javascript">
	function CategoryChanged() {
		if (document.forms.paragraph_edit.CategoryShow[0].checked) {
			document.getElementById("CategoryTable").style.display = "none";
		}
		else {
			document.getElementById("CategoryTable").style.display = "block";
		}
	}

	document.getElementById("CategoryShowAll").onclick = CategoryChanged;
	document.getElementById("CategoryShowSelected").onclick = CategoryChanged;
	document.getElementById("CategoryShowAllButSelected").onclick = CategoryChanged;
	CategoryChanged();
</script>

<dw:GroupBox ID="GroupBox6" runat="server" Title="Show reservation">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="ShowReservationTemplate" Name="ShowReservationTemplate" runat="server" Folder="/Templates/Booking/ShowReservation" />
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="GroupBox7" runat="server" Title="Create reservation">
	<table>
		<tr>
			<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="EditReservationTemplate" Name="EditReservationTemplate" runat="server" Folder="/Templates/Booking/EditReservation" />
			</td>
		</tr>
	</table>
</dw:GroupBox>

<div id="calendarSettings">
<dw:GroupBox ID="GroupBox2" runat="server" Title="Kalender" DoTranslation="true">
<table>
		<tr>
			<td style="width: 170px;" valign="top">
				<dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Gruppering" />
			</td>
			<td>
				<dw:RadioButton ID="ArrangeDay" runat="server" FieldName="Arrange" FieldValue="Day" />
				<label for="ArrangeDay">
					<dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Dag" /></label><br />
				
				<dw:RadioButton ID="ArrangeWorkWeek" runat="server" FieldName="Arrange" FieldValue="WorkWeek" />
				<label for="ArrangeWorkWeek">
					<dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Work week" /></label><br />
					
					<dw:RadioButton ID="ArrangeWeek" runat="server" FieldName="Arrange" FieldValue="Week" />
				<label for="ArrangeWeek">
					<dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Uge" /></label><br />
					
					<dw:RadioButton ID="ArrangeMonth" runat="server" FieldName="Arrange" FieldValue="Month" />
				<label for="ArrangeMonth">
					<dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Måned" /></label><br />
			</td>
		</tr>
		<tr id="startDate">
			<td style="width: 170px;" valign="top">
				<dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="Start_dato" />
			</td>
			<td>
				<dw:RadioButton ID="StartfromPeriod" runat="server" FieldName="Startfrom" FieldValue="Period" />
				<label for="StartfromPeriod">
					<dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Start of period" /></label><br />
				
				<dw:RadioButton ID="StartfromToday" runat="server" FieldName="Startfrom" FieldValue="Today" />
				<label for="StartfromToday">
					<dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Today" /></label><br />
			</td>
		</tr>
		<tr>
			<td style="width: 170px;" valign="top">
				<%=Translate.Translate("Tilføj_%%", "%%", Translate.Translate("periode"))%>
			</td>
			<td>
				<%=Dynamicweb.Gui.Dropdown("PeriodAdd", -12, 12, Properties.Value("PeriodAdd"))%>
			</td>
		</tr>
		
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="CalendarTemplate" Name="CalendarTemplate" runat="server" Folder="/Templates/Booking/Calendar" />
			</td>
		</tr>
		<tr id="CalendarMonthSettings">
			<td valign="top">
				
			</td>
			<td>
				<dw:CheckBox ID="ExpandMonthHoleWeeks" FieldName="ExpandMonthHoleWeeks" runat="server" Value="1" />
				<label for="ExpandMonthHoleWeeks">
				<dw:TranslateLabel ID="TranslateLabel27" runat="server" Text="Expand to hole weeks" />
				</label>
			</td>
		</tr>
		<tr id="CalendarDaySettings">
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel23" runat="server" Text="Time" />
			</td>
			<td>
				<table>
					<tr>
						<td style="width: 120px;" valign="top">
							<dw:TranslateLabel ID="TranslateLabel24" runat="server" Text="Fra" />
						</td>
						<td>
							<%=Dynamicweb.Gui.Dropdown("HourStart", 0, 24, Properties.Value("HourStart"), "", "class=""std"" style=""width:50px;""")%>
						</td>
					</tr>
					<tr>
						<td style="width: 120px;" valign="top">
							<dw:TranslateLabel ID="TranslateLabel25" runat="server" Text="Til" />
						</td>
						<td>
							<%=Dynamicweb.Gui.Dropdown("HourEnd", 1, 24, Properties.Value("HourEnd"), "", "class=""std"" style=""width:50px;""")%>
						</td>
					</tr>
					<tr>
						<td style="width: 120px;" valign="top">
							<dw:TranslateLabel ID="TranslateLabel26" runat="server" Text="Split hour by" />
						</td>
						<td>
							<select name="HourSplit" class="std" style="width:50px;">
							<option value="5"<%=IIf(Properties.Value("HourSplit")="5", " selected", "") %>>5</option>
							<option value="10"<%=IIf(Properties.Value("HourSplit")="10", " selected", "") %>>10</option>
							<option value="15"<%=IIf(Properties.Value("HourSplit")="15", " selected", "") %>>15</option>
							<option value="30"<%=IIf(Properties.Value("HourSplit")="30", " selected", "") %>>30</option>
							<option value="60"<%=IIf(Properties.Value("HourSplit")="60", " selected", "") %>>60</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel28" runat="server" Text="Max allowed offset" /> (<dw:TranslateLabel ID="TranslateLabel29" runat="server" Text="År" />)
			</td>
			<td>
				<%=Dynamicweb.Gui.Dropdown("MaxAllowedOffset", 1, 20, Properties.Value("MaxAllowedOffset"), "", "class=""std"" style=""width:50px;""")%>
			</td>
		</tr>
	</table>
</dw:GroupBox>
</div>

<script type="text/javascript">
	function GroupingChanged() {
		if (document.forms.paragraph_edit.Arrange[3].checked) {
			document.getElementById("CalendarDaySettings").style.display = "none";
			document.getElementById("CalendarMonthSettings").style.display = "block";
		}
		else {
			document.getElementById("CalendarDaySettings").style.display = "block";
			document.getElementById("CalendarMonthSettings").style.display = "none";
		}

		if (document.forms.paragraph_edit.Arrange[0].checked) {
			document.getElementById("startDate").style.display = "none";
			document.forms.paragraph_edit.Startfrom[1].checked = true;
		}
		else {
			document.getElementById("startDate").style.display = "";
		}
	}

	document.getElementById("ArrangeDay").onclick = GroupingChanged;
	document.getElementById("ArrangeWorkWeek").onclick = GroupingChanged;
	document.getElementById("ArrangeWeek").onclick = GroupingChanged;
	document.getElementById("ArrangeMonth").onclick = GroupingChanged;
	GroupingChanged();

	$("SelectedCategoryID").value = $("CategorySelector").value

	UpdateItemID();
	ActionChanged();
</script>

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
