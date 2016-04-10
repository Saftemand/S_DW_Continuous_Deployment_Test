<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="calendar-lang.js.aspx.vb" Inherits="Dynamicweb.Admin.calendar_lang_js" ContentType="text/javascript" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

if (typeof(Calendar) != "undefined" && typeof(Calendar._DN) == "undefined") {

// full day names
Calendar._DN = new Array
("<%=Translate.JsTranslate("Sunday")%>",
 "<%=Translate.JsTranslate("Monday")%>",
 "<%=Translate.JsTranslate("Tuesday")%>",
 "<%=Translate.JsTranslate("Wednesday")%>",
 "<%=Translate.JsTranslate("Thursday")%>",
 "<%=Translate.JsTranslate("Friday")%>",
 "<%=Translate.JsTranslate("Saturday")%>",
 "<%=Translate.JsTranslate("Sunday")%>");

// short day names
Calendar._SDN = new Array
("<%=Translate.JsTranslate("Sun")%>",
 "<%=Translate.JsTranslate("Mon")%>",
 "<%=Translate.JsTranslate("Tue")%>",
 "<%=Translate.JsTranslate("Wed")%>",
 "<%=Translate.JsTranslate("Thu")%>",
 "<%=Translate.JsTranslate("Fri")%>",
 "<%=Translate.JsTranslate("Sat")%>",
 "<%=Translate.JsTranslate("Sun")%>");

// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = 1;

// full month names
Calendar._MN = new Array
("<%=Translate.JsTranslate("January")%>",
 "<%=Translate.JsTranslate("February")%>",
 "<%=Translate.JsTranslate("March")%>",
 "<%=Translate.JsTranslate("April")%>",
 "<%=Translate.JsTranslate("May")%>",
 "<%=Translate.JsTranslate("June")%>",
 "<%=Translate.JsTranslate("July")%>",
 "<%=Translate.JsTranslate("August")%>",
 "<%=Translate.JsTranslate("September")%>",
 "<%=Translate.JsTranslate("October")%>",
 "<%=Translate.JsTranslate("November")%>",
 "<%=Translate.JsTranslate("December")%>");

// short month names
Calendar._SMN = new Array
("<%=Translate.JsTranslate("Jan")%>",
 "<%=Translate.JsTranslate("Feb")%>",
 "<%=Translate.JsTranslate("Mar")%>",
 "<%=Translate.JsTranslate("Apr")%>",
 "<%=Translate.JsTranslate("May")%>",
 "<%=Translate.JsTranslate("Jun")%>",
 "<%=Translate.JsTranslate("Jul")%>",
 "<%=Translate.JsTranslate("Aug")%>",
 "<%=Translate.JsTranslate("Sep")%>",
 "<%=Translate.JsTranslate("Oct")%>",
 "<%=Translate.JsTranslate("Nov")%>",
 "<%=Translate.JsTranslate("Dec")%>");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "<%=Translate.JsTranslate("About the calendar")%>";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this ;-)
"For latest version visit: http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"Date selection:\n" +
"- Use the \xab, \xbb buttons to select year\n" +
"- Use the " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " buttons to select month\n" +
"- Hold mouse button on any of the above buttons for faster selection.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Time selection:\n" +
"- Click on any of the time parts to increase it\n" +
"- or Shift-click to decrease it\n" +
"- or click and drag for faster selection.";

Calendar._TT["PREV_YEAR"] = "<%=Translate.JsTranslate("Prev. year (hold for menu)")%>";
Calendar._TT["PREV_MONTH"] = "<%=Translate.JsTranslate("Prev. month (hold for menu)")%>";
Calendar._TT["GO_TODAY"] = "<%=Translate.JsTranslate("Go Today")%>";
Calendar._TT["NEXT_MONTH"] = "<%=Translate.JsTranslate("Next month (hold for menu)")%>";
Calendar._TT["NEXT_YEAR"] = "<%=Translate.JsTranslate("Next year (hold for menu)")%>";
Calendar._TT["SEL_DATE"] = "<%=Translate.JsTranslate("Select date")%>";
Calendar._TT["DRAG_TO_MOVE"] = "<%=Translate.JsTranslate("Drag to move")%>";
Calendar._TT["PART_TODAY"] = "<%=Translate.JsTranslate(" (today)")%>";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "<%=Translate.JsTranslate("Display %% first", "%%", "%s")%>";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "<%=Translate.JsTranslate("Close")%>";
Calendar._TT["TODAY"] = "<%=Translate.JsTranslate("Today")%>";
Calendar._TT["TIME_PART"] = "<%=Translate.JsTranslate("(Shift-)Click or drag to change value")%>";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%a, %b %e";

Calendar._TT["WK"] = "<%=Translate.JsTranslate("wk")%>";
Calendar._TT["TIME"] = "<%=Translate.JsTranslate("Time:")%>";

}
