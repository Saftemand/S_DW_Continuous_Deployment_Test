<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailPersonalization.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.EmailPersonalization" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Personalization</title>
    <dw:ControlResources ID="ControlResources1" CombineOutput="false" IncludePrototype="true" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Module/OMC/js/EmailPersonalization.js" />
            <dw:GenericResource Url="/Admin/Module/OMC/css/EmailPersonalization.css" />
        </Items>
    </dw:ControlResources>
</head>
<body>
    <form id="MainForm" runat="server">
        <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server">
            <dw:ToolbarButton ID="cmdAddSection" runat="server" Divide="Before" Image="Plus" OnClientClick="Dynamicweb.Page.Personalization.get_current().addSegment();" Text="Add segment" />
	        <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="Dynamicweb.Page.Personalization.get_current().help();" />
        </dw:Toolbar>
        <h1 class="title">
            <dw:TranslateLabel runat="server" Text="Email Personalization" />
        </h1>
        <div class="list-container">
            <dw:List runat="server"  
                ID="SegmentList" 
                ShowTitle="false"
                PageSize="1000">
            </dw:List>
        </div>
        <div style="float:right;">
           <input type="button" id="btnSave" value="Save" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="Dynamicweb.Page.Personalization.get_current().saveSegments();"/>
           <input type="button" id="btnCancel"  value="Cancel" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="Dynamicweb.Page.Personalization.get_current().close();"/>
        </div>  
        
        <dw:ContextMenu ID="SegmentContextMenu" runat="server">
            <dw:ContextMenuButton ID="cmdSelectAll" ImagePath="/Admin/images/Check.gif" Text="Select all" runat="server" OnClientClick="Dynamicweb.Page.Personalization.get_current().selectSegment(ContextMenu.callingID);" />
            <dw:ContextMenuButton ID="cmdDeselectAll" ImagePath="/Admin/images/Minus.gif" Text="Deselect all" runat="server" OnClientClick="Dynamicweb.Page.Personalization.get_current().deselectSegment(ContextMenu.callingID);" />
            <dw:ContextMenuButton ID="cmdDeleteSegment" ImagePath="/Admin/Images/Icons/Stop.gif" Divide="Before" Text="Delete segment" runat="server" OnClientClick="Dynamicweb.Page.Personalization.get_current().delSegment(ContextMenu.callingID);" />
        </dw:ContextMenu>
    </form>

    <%Translate.GetEditOnlineScript()%>
</body>
</html>
