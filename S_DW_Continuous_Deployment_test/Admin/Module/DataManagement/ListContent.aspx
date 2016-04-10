<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListContent.aspx.vb" Inherits="Dynamicweb.Admin.ListContent_2" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;" >
<head runat="server">
    <title></title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" />
	
    <script type="text/javascript">
    var itemId = <%=ItemID%>;
    var redirCMD = "<%=redirCMD %>";
    if ('<%=Base.ChkBoolean(Base.Request("Refresh")) %>' == 'True') {
        if (redirCMD.length != 0) {
            parent.submitReload(itemId, redirCMD);
        }else{
            parent.submitMe(itemId);
        }
    }    
    </script>

    <script type="text/javascript">
    function ContextmenuClick(cmd) {
        ContentRowHandler(cmd);
    }
    
    function ContentRowHandler(cmd) {
        var Id = ContextMenu.callingItemID;
        var listId = ContextMenu.callingID;

        if (cmd == "LIST_TABLEROWS") {
            editRow(Id);
        }
        if (cmd == "EDIT_TABLEROW") {
            location = "Connection/EditTableRow.aspx?ID=" + Id;
        }
        
    }
    
    function editRow(Id) {
        location = "ListContent.aspx?item=" + Id + "&CMD=TABLEVIEW";
    }

    function PerformViewCheck() {
        var showPopup = <%=showPopup %>;
        if (showPopup) {
            doPopupForTestVariables();
        }
    }
    
    function doPopupForTestVariables() {
        var time = new Date();
        ajaxLoader("ListContent.aspx?AJAXCMD=FILL_POPUP&ID=" + itemId + "&timestamp=" + time.getTime(), "PopupTable");
        dialog.show('popup');
    }

    function ajaxLoader(url,divId) {
        new Ajax.Updater(divId, url, {
            asynchronous: false, 
            method: 'get',
            
            onSuccess: function(request) {
                $(divId).update(request.responseText)
            }
        } );
    }
    
    function saveTestVars() {
        document.getElementById('form1').action = "ListContent.aspx?CMD=SAVE_VARS&ID=" + itemId;
        document.getElementById('form1').submit();
    }
    </script>
</head>
<body onload="javascript:PerformViewCheck();" style="height: 100%;">
    <form id="form1" runat="server" style="height: 100%;">
    
		<dw:dialog ID="popup" ShowOkButton="true" runat="server" OkAction="saveTestVars();" ShowClose="false" Title="Test values">
            <dw:GroupBox ID="GroupBox1" DoTranslation="true" runat="server" Title="Angiv testværdier">
                <div id="PopupTable" style="overflow: auto;"></div>			        
            </dw:GroupBox>	
        </dw:dialog>
    
        <dw:List ID="List1" runat="server" Title="Items" PageSize="30" />
    
		<dw:Contextmenu ID="ContextmenuItems" runat="server">
			<dw:ContextmenuButton ID="ContextmenuButton1" runat="server" Divide="After" Image="Preview" Text="Show" OnClientClick="ContextmenuClick('LIST_TABLEROWS');" />
			<dw:ContextmenuButton ID="ContextmenuButton2" runat="server" Divide="None" Image="Convert" Text="Refresh" OnClientClick="location=location;" />
		</dw:Contextmenu>

		<dw:Contextmenu ID="ContextmenuEditItems" runat="server">
			<dw:ContextmenuButton ID="ContextmenuButton3" runat="server" Divide="None" Image="View_Edit" Text="Edit" OnClientClick="ContextmenuClick('EDIT_TABLEROW');" />
		</dw:Contextmenu>
		
    </form>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
