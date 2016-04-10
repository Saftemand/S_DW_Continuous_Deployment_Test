<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="EditItem.aspx.vb" Inherits="Dynamicweb.Admin.EditItem" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="Booking" TagName="CalendarSetup" Src="../Controls/CalendarSetup.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>

	<link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
	<link rel="Stylesheet" href="/Admin/Module/Booking/CSS/Booking.css" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <script type="text/javascript" src="EditItem.js"></script>     

    <script type="text/javascript">
        var itemID = <%=itemID %>;
        var itemType = "<%=itemTypeName %>";
        var categoryID = <%=categoryID %>;
        var referrerURL = "<%=referrerURL %>";

        function pageLoaded() {
//            if (itemID > 0)
//                parent.navigateToItem(itemID);
        }
    </script>
</head>
<body onload="pageLoaded();">
    <form id="form1" runat="server">
        <dw:Toolbar runat="server" ID="Toolbar1" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="btnSaveAndClose" Image="SaveAndClose" Text="Save and close" Translate="true" ShowWait="true" OnClientClick="save(true);" />
            <dw:ToolbarButton runat="server" ID="btnSave" Image="Save" Text="Save" Translate="true" ShowWait="true" OnClientClick="save(false);" />
            <dw:ToolbarButton runat="server" ID="btnCancel" Image="Cancel" Text="Cancel" Translate="true" OnClientClick="showReservations();" />
            <dw:ToolbarButton runat="server" ID="btnReservations" Image="DocumentProperties" Text="Reservations" Translate="true" Disabled="true" Divide="Before" />
        </dw:Toolbar>
        
        <dw:GroupBox ID="GroupBox1" runat="server" DoTranslation="true" Title="Settings">
	        <table cellpadding="1" cellspacing="1">        
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" /></div>
			        </td>
			        <td>
                        <dw:Infobar runat="server" ID="NameTooLongBar" Message="Name is too long. 255 characters is maximum." TranslateMessage="true" Type="Error" Visible="false" />
			            <input runat="server" type="text" id="ItemName" name="ItemName" class="NewUIinput" onkeypress="return event.keyCode!=13;" />
			        </td>
		        </tr>			    
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Category" /></div>
			        </td>
			        <td>
			            <select runat="server" id="ItemCategoryID" name="ItemCategoryID" class="NewUIinput">
			            </select>
			        </td>
		        </tr>			    
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Description" /></div>
			        </td>
		            <td style="width: 500px;">
			            <dw:Editor runat="server" ID="ItemDescription" />
			        </td>
		        </tr>			    
            </table>			        
        </dw:GroupBox>

        <Booking:CalendarSetup runat="server" ID="CalendarSetup1" />

    </form>
    
    <script type="text/javascript">
        if (<%=doRedirect %>)
            //showReservations();
            parent.location.reload(true);
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>