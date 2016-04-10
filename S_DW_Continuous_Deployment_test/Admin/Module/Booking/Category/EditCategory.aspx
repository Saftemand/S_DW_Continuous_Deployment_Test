<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditCategory.aspx.vb" Inherits="Dynamicweb.Admin.EditCategory" %>
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
    
    <script type="text/javascript">
        var categoryID = <%=categoryID %>;
        
        function save(doClose) {
            $("form1").action = "EditCategory.aspx?Save=True&ID=" + categoryID + "&doClose=" + doClose;
            $("form1").submit();
        }

        function cancel() {
            parent.resetContentFrameLocation();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dw:Toolbar runat="server" ID="Toolbar1" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="btnSaveAndClose" Image="SaveAndClose" Text="Save and close" Translate="true" ShowWait="true" OnClientClick="save(true);" />
            <dw:ToolbarButton runat="server" ID="btnSave" Image="Save" Text="Save" Translate="true" ShowWait="true" OnClientClick="save(false);" />
            <dw:ToolbarButton runat="server" ID="btnCancel" Image="Cancel" Text="Cancel" Translate="true" OnClientClick="history.go(-1);" />
        </dw:Toolbar>
        
        <dw:GroupBox ID="GroupBox2" runat="server" DoTranslation="true" Title="Category settings">
	        <table cellpadding="1" cellspacing="1" width="99%">        
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" /></div>
			        </td>
			        <td>
                        <dw:Infobar runat="server" ID="NameTooLongBar" Message="Name is too long. 255 characters is maximum." TranslateMessage="true" Type="Error" Visible="false" />
			            <input runat="server" type="text" id="CategoryName" name="CategoryName" class="NewUIinput" />
			        </td>
		        </tr>			    
		        <tr>
			        <td width="170" style="vertical-align: top;">
				        <div class="nobr"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Area" /></div>
			        </td>
			        <td>
			            <select runat="server" id="CategoryAreaID" name="CategoryAreaID" class="NewUIinput">
			            </select>
			        </td>
		        </tr>			    
            </table>			        
        </dw:GroupBox>

        <Booking:CalendarSetup runat="server" ID="CalendarSetup" AllowInheritance="false" />
    </form>
    
    <script type="text/javascript">
        if (<%=doRedirect %>)
            //cancel();
            parent.location.reload(true);
    </script>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>