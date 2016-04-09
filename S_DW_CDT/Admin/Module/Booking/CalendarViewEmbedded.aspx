<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CalendarViewEmbedded.aspx.vb" Inherits="Dynamicweb.Admin.CalendarViewEmbedded" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <link rel="Stylesheet" type="text/css" href="CSS/fullcalendar.css" />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.8/jquery-ui.min.js"></script>
    <script type="text/javascript" src="JS/fullcalendar.min.js"></script>
    <script type="text/javascript">
        function gotoDate(year, month, day) {
            $('#calendar').fullCalendar('gotoDate', year, (month - 1), day);
        }

        function gotoToday() {
            $("#calendar").fullCalendar('today');
        }

        function moveView(direction) {
            if (direction == "next")
                $("#calendar").fullCalendar('next');
            else if (direction == "prev")
                $("#calendar").fullCalendar('prev');
        }

        function getDate() {
            return $("#calendar").fullCalendar('getDate');
        }
    </script>
</head>
<body style="margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <div id="calendar"></div>
    <script type="text/javascript">
        <asp:Literal ID="calendar" runat="server" />
        $('#calendar').fullCalendar('option', 'height', $(window).height());
    </script>
    </form>
</body>
</html>

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

