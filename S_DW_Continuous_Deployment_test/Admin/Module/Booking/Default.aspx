<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin._Default5" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />

	<link rel="Stylesheet" href="/Admin/Content/StylesheetNewUI.css" />

    <script type="text/javascript">
        var areaIDOffset = <%=areaIDOffset %>;
        var itemOffset = <%=itemIDOffset %>;
        var categoryOffset = <%=categoryIDOffset %>;
        
        var deleteText_Calendar = "<%=deleteText_Calendar %>";
        var deleteText_Service = "<%=deleteText_Service %>";
        var deleteText_Resource = "<%=deleteText_Resource %>";
        var deleteText_Category = "<%=deleteText_Category %>";
        var deleteText_Reservation = "<%=deleteText_Reservation %>";
    </script>
    <script type="text/javascript" src="/Admin/Module/Booking/JS/Booking.js"></script>
</head>
<body id="body" runat="server">
    <form id="form1" runat="server">
		<dw:ModuleAdmin runat="server" ContentFrameSrc="UpcomingEvents.aspx" ID="moduleadmin">
			<dw:Tree ID="Tree1" runat="server" SubTitle="All categories" Title="Booking" ShowRoot="false" openAll="false" useSelection="true" useCookies="true" useLines="true" AutoID="false" ContextMenuID="AreaContext" >
				<dw:TreeNode NodeID="0" runat="server" Name="Root" ParentID="-1">
				</dw:TreeNode>
			</dw:Tree>
		</dw:ModuleAdmin>
		
		<!-- Context menus -->
		<dw:ContextMenu runat="server" ID="AreaContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton1" DoTranslate="True" Image="AddDocument" Text="New category" OnClientClick="newItem('Category', ContextMenu.callingItemID);" />
		</dw:ContextMenu>
		
		<dw:ContextMenu runat="server" ID="CategoryContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton2" DoTranslate="True" Image="AddDocument" Text="New category" OnClientClick="newItem('Category', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton6" DoTranslate="True" Image="EditDocument" Text="Edit category" OnClientClick="editItem('Category', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton3" DoTranslate="True" Image="DeleteDocument" Text="Delete category" OnClientClick="deleteItem('Category', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton7" DoTranslate="True" Image="AddDocument" Text="New resource" OnClientClick="newItem('Resource', ContextMenu.callingItemID);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton8" DoTranslate="True" Image="AddDocument" Text="New service" OnClientClick="newItem('Service', ContextMenu.callingItemID);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton9" DoTranslate="True" Image="AddDocument" Text="New calendar" OnClientClick="newItem('Calendar', ContextMenu.callingItemID);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton21" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Reservation', 0);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton22" DoTranslate="True" Image="AddDocument" Text="New appointment" OnClientClick="newReservation('Appointment', 0);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="ResourceContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton4" DoTranslate="True" Image="AddDocument" Text="New resource" OnClientClick="newItem('Resource', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton10" DoTranslate="True" Image="EditDocument" Text="Edit resource" OnClientClick="editItem('Resource', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton5" DoTranslate="True" Image="DeleteDocument" Text="Delete resource" OnClientClick="deleteItem('Resource', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton11" DoTranslate="True" Image="AddDocument" Text="Show resource" OnClientClick="showItem('Resource', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton25" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Resource', ContextMenu.callingItemID - itemOffset);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="ServiceContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton12" DoTranslate="True" Image="AddDocument" Text="New service" OnClientClick="newItem('Service', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton13" DoTranslate="True" Image="EditDocument" Text="Edit service" OnClientClick="editItem('Service', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton14" DoTranslate="True" Image="DeleteDocument" Text="Delete service" OnClientClick="deleteItem('Service', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton15" DoTranslate="True" Image="AddDocument" Text="Show service" OnClientClick="showItem('Service', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton26" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Service', ContextMenu.callingItemID - itemOffset);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="CalendarContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton16" DoTranslate="True" Image="AddDocument" Text="New calendar" OnClientClick="newItem('Calendar', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton17" DoTranslate="True" Image="EditDocument" Text="Edit calendar" OnClientClick="editItem('Calendar', ContextMenu.callingItemID - itemOffset);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton18" DoTranslate="True" Image="DeleteDocument" Text="Delete calendar" OnClientClick="deleteItem('Calendar', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton19" DoTranslate="True" Image="AddDocument" Text="Show calendar" OnClientClick="showItem('Calendar', ContextMenu.callingItemID - itemOffset);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton29" DoTranslate="True" Image="AddDocument" Text="New appointment" OnClientClick="newReservation('Calendar', ContextMenu.callingItemID - itemOffset);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="ResourcesContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton20" DoTranslate="True" Image="AddDocument" Text="New resource" OnClientClick="newItem('Resource', ContextMenu.callingItemID);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton23" DoTranslate="True" Image="AddDocument" Text="Show resources" OnClientClick="showItems('Resource', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton30" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Reservation', 0);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton32" DoTranslate="True" Image="AddDocument" Text="New appointment" OnClientClick="newReservation('Appointment', 0);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="ServicesContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton24" DoTranslate="True" Image="AddDocument" Text="New service" OnClientClick="newItem('Service', ContextMenu.callingItemID);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton27" DoTranslate="True" Image="AddDocument" Text="Show services" OnClientClick="showItems('Service', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton33" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Reservation', 0);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton34" DoTranslate="True" Image="AddDocument" Text="New appointment" OnClientClick="newReservation('Appointment', 0);" />
		</dw:ContextMenu>

		<dw:ContextMenu runat="server" ID="CalendarsContext" Translate="true">
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton28" DoTranslate="True" Image="AddDocument" Text="New calendar" OnClientClick="newItem('Calendar', ContextMenu.callingItemID);" Divide="After" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton31" DoTranslate="True" Image="AddDocument" Text="Show calendars" OnClientClick="showItems('Calendar', ContextMenu.callingItemID);" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton35" DoTranslate="True" Image="AddDocument" Text="Book resource" OnClientClick="newReservation('Reservation', 0);" Divide="Before" />
		    <dw:ContextMenuButton runat="server" ID="ContextMenuButton36" DoTranslate="True" Image="AddDocument" Text="New appointment" OnClientClick="newReservation('Appointment', 0);" />
		</dw:ContextMenu>
    </form>
    
    <script type="text/javascript">
        $("ContentFrame").style.height = $("tree1").offsetHeight + 46 + "px";
    </script>
    
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>