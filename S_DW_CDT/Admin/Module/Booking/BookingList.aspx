<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BookingList.aspx.vb" Inherits="Dynamicweb.Admin.BookingList" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    
    <script type="text/javascript">
        var itemID = <%=itemID %>;
        var itemType = "<%=itemType %>";
        var calendarViewBaseUrl = "CalendarViewEmbedded.aspx";
        var pagingRefresh = <%=pagingRefresh %>;
        var defaultViewButton = "<%=defaultView %>";
        var startDate = <%=startDate %>;

        var calendarSelectedDateIsSet = false;
        var calendarSelectedStartDate;
        var calendarSelectedEndDate;
        var calendarSelectedIsAllDay;

        Event.observe(document, 'dom:loaded', function () {
            pageLoaded();
        });

        function changeView(type, subType, viewButton) {
            if (type == "calendar") {
                if (subType) {
                    $('CalendarFrame').src = calendarViewBaseUrl + "?id=" + itemID + "&type=" + subType;
                }
                $("ItemReservation").show();
                $("ReservationList").hide();
            } else if (type == 'reservation') {
                $("ItemReservation").hide();
                $("ReservationList").show();

                // Initialize list stretch
                var stretchers = List.get_stretchers();
                for (var i = 0; i < stretchers.length; i++) {
                    stretchers[i].initialize();
                    stretchers[i].adjustSize();
                    stretchers[i].get_stretcherObject().stretch();
                }

                unsetCalendarSelectedDates();
            } else {
                $("ItemView").hide();
            }

            defaultViewButton = viewButton;
            setTimeout("setDateAndView();", 250);
        }

        function gotoSelectedDate() {
            var year = parseInt($("DateSelector1_year").value);
            var month = parseInt($("DateSelector1_month").value);
            var day = parseInt($("DateSelector1_day").value);

            gotoDate(year, month, day);
        }

        function gotoDate(year, month, day) {
            var func = null;
            try {
                func = $("CalendarFrame").contentWindow.gotoDate;
                if (typeof(func) != "function")
                    return;
            } catch (e) { return; }

            func(year, month, day);
            setTimeout("setDateAndView();", 250);
        }

        function gotoToday() {
            var func = null;
            try {
                func = $("CalendarFrame").contentWindow.gotoToday;
                if (typeof(func) != "function")
                    return;
            } catch (e) { return; }

            func();
            setTimeout("setDateAndView();", 250);
        }

        function moveCalendarView(direction) {
            var func = null;
            try {
                func = $("CalendarFrame").contentWindow.moveView;
                if (typeof(func) != "function")
                    return;
            } catch (e) { return; }

            func(direction);
            setTimeout("setDateAndView();", 250);
        }

        function getCalendarDate() {
            var func = null;
            try {
                func = $("CalendarFrame").contentWindow.getDate;
                if (typeof(func) != "function")
                    return null;
            } catch (e) { return null; }

            return func();
        }

        function setDateAndView() {
            var date = getCalendarDate();
            if (!date)
                return;

            var url = "BookingList.aspx?AJAXCMD=SETDATE&DATEYEAR=" + date.getFullYear() + "&DATEMONTH=" + (date.getMonth() + 1) + "&DATEDAY=" + date.getDate() + "&VIEW=" + defaultViewButton + "&REFRESH=" + (new Date()).getTime();

            new Ajax.Request(url, {
                method: 'get'
            });
        }

        function setCalendarSelectedDates(startDate, endDate, isAllDay) {
            calendarSelectedStartDate = startDate;
            calendarSelectedEndDate = endDate;
            calendarSelectedIsAllDay = isAllDay;
            calendarSelectedDateIsSet = true;
            Ribbon.enableButton("btnNewAtSelection");
        }

        function unsetCalendarSelectedDates() {
            calendarSelectedStartDate = null;
            calendarSelectedEndDate = null;
            calendarSelectedIsAllDay = null;
            calendarSelectedDateIsSet = false;
            Ribbon.disableButton("btnNewAtSelection");
        }

        function newReservationAtSelection() {
            if (!calendarSelectedDateIsSet)
                return;

            parent.newReservation(itemType, itemID, calendarSelectedStartDate, calendarSelectedEndDate, calendarSelectedIsAllDay);
        }

        function pageLoaded() {
            if (pagingRefresh) {
                if ($('RibbonBarRadioButton4')) {
                    Ribbon.activateButton('RibbonBarRadioButton4');
                    $('RibbonBarRadioButton4').onclick();
                }
            } else {
                if ($(defaultViewButton))
                    $(defaultViewButton).onclick();

                setTimeout("gotoDate(startDate.Year, startDate.Month, startDate.Day);", 250);
            }

//            if (itemID > 0)
//                parent.navigateToItem(itemID);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel runat="server" ID="ListView" Visible="false">
            <dw:List runat="server" ID="List1" PageSize="30" TranslateTitle="true">
            </dw:List>
        </asp:Panel>
        
        <asp:Panel runat="server" ID="ItemView" Visible="false">
            <dw:RibbonBar runat="server" ID="Ribbon1">
                <dw:RibbonBarTab runat="server" ID="tabCalendar" Name="Reservation">
                    <dw:RibbonBarGroup runat="server" ID="grpReservations" Name="Reservations">
                        <dw:RibbonBarButton runat="server" Image="AddDocument" Size="Large" Text="New" OnClientClick="parent.newReservation(itemType, itemID);" />
                        <dw:RibbonBarButton runat="server" Image="AddDocument" Size="Large" Text="New at selection" OnClientClick="newReservationAtSelection();" ID="btnNewAtSelection" Disabled="true" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="grpEditResource" Name="Resource" Visible="false">
                        <dw:RibbonBarButton ID="RibbonBarButton1" runat="server" Image="EditDocument" Size="Large" Text="Edit resource" OnClientClick="parent.editItem(itemType, itemID);" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="grpEditService" Name="Service" Visible="false">
                        <dw:RibbonBarButton ID="RibbonBarButton2" runat="server" Image="EditDocument" Size="Large" Text="Edit service" OnClientClick="parent.editItem(itemType, itemID);" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="grpEditCalendar" Name="Kalender" Visible="false">
                        <dw:RibbonBarButton ID="RibbonBarButton3" runat="server" Image="EditDocument" Size="Large" Text="Edit calendar" OnClientClick="parent.editItem(itemType, itemID);" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="grpGoToDate" Name="Go to">
                        <dw:RibbonBarButton runat="server" ID="gotoToday" DoTranslate="true" Text="Today" Image="Clock" Size="Large" OnClientClick="gotoToday();" />
                        <dw:RibbonBarButton runat="server" ID="gotoDate" DoTranslate="true" Text="Date" Image="Clock" Size="Large" OnClientClick="dialog.show('dlgGoToDate');" />
                        <dw:RibbonBarButton runat="server" ID="gotoPrevious" DoTranslate="true" Text="Previous" Image="NavigateLeft" Size="Large" OnClientClick="moveCalendarView('prev');" />
                        <dw:RibbonBarButton runat="server" ID="gotoNext" DoTranslate="true" Text="Next" Image="NavigateRight" Size="Large" OnClientClick="moveCalendarView('next');" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="grpViews" Name="View">
                        <dw:RibbonBarRadioButton runat="server" ID="RibbonBarRadioButton1" Group="Views" Image="Table_Selection_Cell" Size="Large" Text="Day" OnClientClick="changeView('calendar', 'day', 'RibbonBarRadioButton1');" />
                        <dw:RibbonBarRadioButton runat="server" ID="RibbonBarRadioButton2" Group="Views" Image="Table_Selection_Row" Size="Large" Text="Week" OnClientClick="changeView('calendar', 'week', 'RibbonBarRadioButton2');" />
                        <dw:RibbonBarRadioButton runat="server" ID="RibbonBarRadioButton3" Group="Views" Image="Table_Selection_All" Size="Large" Text="Month" OnClientClick="changeView('calendar', 'month', 'RibbonBarRadioButton3');" />
                        <dw:RibbonBarRadioButton runat="server" ID="RibbonBarRadioButton4" Group="Views" Image="DocumentNotebook" Size="Large" Text="List" OnClientClick="changeView('reservation', 'list', 'RibbonBarRadioButton4');" />
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>

            <dw:Dialog runat="server" ID="dlgGoToDate" OkAction="gotoSelectedDate(); dialog.hide('dlgGoToDate');" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" ShowHelpButton="false" Title="Go to date" TranslateTitle="true">
                <dw:DateSelector runat="server" ID="DateSelector1" AllowNeverExpire="false" AllowNotSet="false" IncludeTime="false" ShowAsLabel="false"  />
            </dw:Dialog>
            
            <dw:StretchedContainer ID="MainContent" runat="server" Scroll="Hidden" Anchor="document" Stretch="Fill">
                <asp:Panel runat="server" ID="ItemReservation" style="height: 100%; width: 100%; display: none;">
                    <iframe src="" id="CalendarFrame" style="width: 100%; height: 100%;"></iframe>
                </asp:Panel>

                <asp:Panel runat="server" ID="ReservationList" style="height: 100%; width: 100%">
                    <dw:List ID="ReservationsList" runat="server" TranslateTitle="true" StretchContent="true" >
                        <Filters>
                            <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Items per page" AutoPostBack="true" Priority="3" runat="server">
                                <Items>
                                    <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                                    <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                                    <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                                    <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                                    <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                                </Items>
                            </dw:ListDropDownListFilter>
                        </Filters>
                        <Columns>
			                <dw:ListColumn ID="ListColumn1" runat="server" Name="Name" Width="200" />
			                <dw:ListColumn ID="ListColumn2" runat="server" Name="Text" Width="200" />
			                <dw:ListColumn ID="ListColumn3" runat="server" Name="Start Time" Width="120"/>
			                <dw:ListColumn ID="ListColumn4" runat="server" Name="End Time" Width="120"/>
			            </Columns>
                    </dw:List>
                </asp:Panel>

            </dw:StretchedContainer>
        </asp:Panel>
    </form>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>