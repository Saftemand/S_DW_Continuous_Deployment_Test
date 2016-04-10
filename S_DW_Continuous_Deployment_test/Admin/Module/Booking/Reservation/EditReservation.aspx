<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditReservation.aspx.vb" ValidateRequest="false" Inherits="Dynamicweb.Admin.EditReservation" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="Booking" TagName="ResourceSelector" Src="../Controls/ResourceSelector.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    
    <script type="text/javascript">
        var ID = <%=reservationID %>;
        var deleteText = "<%=deleteText %>";
        
        function save(doClose) {
            $("form1").action = "EditReservation.aspx?ID=" + ID + "&doClose=" + doClose + "&Save=True";
            $("form1").submit()
        }

        function cancel() {
            parent.resetContentFrameLocation();
        }

        function deleteThis(obj) {
            if (Toolbar.buttonIsDisabled('btnDelete'))
                return;

            if (!confirm(deleteText))
                return;

            // Delete the reservation
            new Ajax.Request('/Admin/Module/Booking/DeleteItem.aspx?Type=Reservation&ID=' + ID, {
                method: 'get',
                asynchronous: false
            });

            cancel();
        }

        function setAllDay(obj) {
            if (obj.checked) {
                // All day event
                $("StartTimeInterval").hide();
                $("EndTimeInterval").hide();
                $("StartTimeAllDay").show();
                $("EndTimeAllDay").show();
            } else {
                // Not all day event
                $("StartTimeInterval").show();
                $("EndTimeInterval").show();
                $("StartTimeAllDay").hide();
                $("EndTimeAllDay").hide();
            }
        }

        function findTimeSlot(type) {
            $("form1").action = "EditReservation.aspx?ID=" + ID + "&" + type + "=True";
            $("form1").submit();
        }

        function setCalendarID(obj) {
            $("CalendarID").value = obj.options[obj.selectedIndex].value;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dw:Toolbar runat="server" ID="Toolbar1" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="btnSaveAndClose" Image="SaveAndClose" Text="Save and close" Translate="true" ShowWait="true" OnClientClick="save(true);" />
            <dw:ToolbarButton runat="server" ID="btnSave" Image="Save" Text="Save" Translate="true" ShowWait="true" OnClientClick="save(false);" />
            <dw:ToolbarButton runat="server" ID="btnCancel" Image="Cancel" Text="Cancel" Translate="true" OnClientClick="cancel();" Divide="After" />
            <dw:ToolbarButton runat="server" ID="btnDelete" Image="Delete" Text="Delete" Translate="true" OnClientClick="deleteThis();" Disabled="true" Divide="After" />
            <dw:ToolbarButton runat="server" ID="btnFindNextTimeSlot" Text="Show next open time" Image="Clock" Translate="true" OnClientClick="findTimeSlot('FindNextTimeSlot');" />
            <dw:ToolbarButton runat="server" ID="btnFindAnyResourceAtThisTime" Text="Find free resources" Image="Clock" Translate="true" OnClientClick="findTimeSlot('FindAnyResourceAtTimeSlot');" />
            <dw:ToolbarButton runat="server" ID="btnFindFirstResource" Text="Find first open resource" Image="Clock" Translate="true" OnClientClick="findTimeSlot('FindFirstAvailableResource');" Visible="false" />
        </dw:Toolbar>
        
        <asp:Panel runat="server" ID="ReservationErrors">
        </asp:Panel>

        <dw:GroupBox runat="server" Title="Reservation settings">
	        <table cellpadding="1" cellspacing="1">
                <tr id="calendarLabelRow" runat="server">
                    <td width="170" style="vertical-align: top;">
                        <div class="nobr"><dw:TranslateLabel runat="server" Text="Current calendar" /></div>
                    </td>
                    <td>
                        <asp:DropDownList ID="CalendarLabel" runat="server" CssClass="NewUIinput" onchange="setCalendarID(this);">
                        </asp:DropDownList>
                        <asp:HiddenField ID="CalendarID" runat="server" />
                    </td>
                </tr>        
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Items to book" /></div>
			        </td>
			        <td>
                        <Booking:ResourceSelector runat="server" ID="ResourceSelector1" CssClass="NewUIinput" Height="100" />
			        </td>
		        </tr>			    
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" /></div>
			        </td>
			        <td>
                        <dw:Infobar runat="server" ID="NameTooLongBar" Message="Name is too long. 255 characters is maximum." TranslateMessage="true" Type="Error" Visible="false" />
			            <input runat="server" type="text" id="ReservationName" name="ReservationName" class="NewUIinput" />
			        </td>
		        </tr>			    
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="All day" /></div>
			        </td>
			        <td>
			            <input runat="server" type="checkbox" id="ReservationAllDay" name="ReservationAllDay" value="true" onclick="setAllDay(this);" />
			        </td>
		        </tr>
                <tr id="newTimeSuggestedRow" runat="server" visible="false">
                    <td width="170" style="vertical-align: top;">
                    </td>
                    <td>
                        <dw:Infobar runat="server" ID="infoTime" Message="A new time has been suggested" TranslateMessage="true" />
                    </td>
                </tr>
		        <tr id="StartTimeInterval">
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Start time" /></div>
			        </td>
			        <td>
			            <dw:DateSelector runat="server" ID="ReservationStartTime" AllowNeverExpire="false" AllowNotSet="false" IncludeTime="true" />
			        </td>
		        </tr>			    
		        <tr id="EndTimeInterval">
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="End time" /></div>
			        </td>
			        <td>
			            <dw:DateSelector runat="server" ID="ReservationEndTime" AllowNeverExpire="false" AllowNotSet="false" IncludeTime="true" />
			        </td>
		        </tr>
		        <tr id="StartTimeAllDay">
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Start day" /></div>
			        </td>
			        <td>
			            <dw:DateSelector runat="server" ID="ReservationStartTimeAllDay" AllowNeverExpire="false" AllowNotSet="false" IncludeTime="false" />
			        </td>
		        </tr>			    
		        <tr id="EndTimeAllDay">
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="End day" /></div>
			        </td>
			        <td>
			            <dw:DateSelector runat="server" ID="ReservationEndTimeAllDay" AllowNeverExpire="false" AllowNotSet="false" IncludeTime="false" />
			        </td>
		        </tr>			    
		        <tr>
		            <td width="170" style="vertical-align: top;">
		                <div class="nobr"><dw:TranslateLabel runat="server" Text="Description" /></div>
		            </td>
		            <td style="width: 500px;">
		                <dw:Editor runat="server" ID="ReservationText" Width="250" />
		            </td>
		        </tr>		    
            </table>			        
        </dw:GroupBox>

    </form>
    
    <script type="text/javascript">
        if (<%=doRedirect %>)
            cancel();

        setAllDay($("ReservationAllDay"));
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>