<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SmsList.aspx.vb" Inherits="Dynamicweb.Admin.SmsList" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	 <dw:ControlResources ID="ctrlResources" IncludePrototype="false" CombineOutput="true" runat="server"></dw:ControlResources>
	<script>
		function add() {
			location = "Message.aspx";
		}
		function help() {
			alert('help');
		}
		function editItem(itemid) {
			location = "Message.aspx?MessageID=" + itemid;
		}

		function deleteItem() {
		    var smsToDeleteIDs = getCheckedRows();
		    if (smsToDeleteIDs.length > 0) {
		        if (confirm("<%= Translate.JsTranslate("Are you sure you want to delete this message?")%>")) {
		            new Ajax.Request("SmsList.aspx", {
                        method: 'get',
                        parameters: {
                            SmsID: smsToDeleteIDs,
                            Delete: "delete"
                        },
                        onComplete: function (transport) {
                            if (transport.responseText.length == 0) {
                                window.location.reload(true);
                            } else {
                                alert(transport.responseText);
                            }
                        }
                    });
		        }
		    }
		}

	    function lstSelectingHandler() {
	        if (List && List.getSelectedRows('lstPaths').length > 0) {
	            $("cmdDelete").className = "";
	        } else {
	            $('cmdDelete').className = "toolbarButtonDisabled";
	        }
	    }

	    function getCheckedRows() {
	        var rowsIDs = [];
	        var contextMenuCaller = ContextMenu.callingID;
	        var checkedRows = List.getSelectedRows('lstPaths');

	        if (checkedRows && checkedRows.length > 0) {
	            for (var i = 0; i < checkedRows.length; i++) {
	                rowsIDs[i] = checkedRows[i].id.replace("row", "");
	            }
	        } else if (contextMenuCaller) {
	            rowsIDs[0] = contextMenuCaller;
	        }
	        return rowsIDs;
	    }

    </script>
</head>
<body>
    <form id="Mainform" runat="server">
		<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdAdd" runat="server" Disabled="false" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/small/message_add.png" OnClientClick="if(!Toolbar.buttonIsDisabled('cmdAdd')) {{ add(); }}" Text="New text message" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />                
                <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="Before" Image="Delete" Text="Delete" Disabled="true" OnClientClick="deleteItem();" />                
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Text messages" runat="server" />
	        </h2>
		<dw:List ID="lstPaths" AllowMultiSelect="True" ShowPaging="true" ShowTitle="false" runat="server" pagesize="50" HandleSortingManually="False" OnClientSelect="lstSelectingHandler();">
            <Columns>
                <dw:ListColumn ID="colDate" EnableSorting="true" Name="Date" Width="150" runat="server" />
                <dw:ListColumn ID="colName" EnableSorting="true" Name="Name" Width="200" runat="server" />
                <dw:ListColumn ID="colMessage" EnableSorting="true" Name="Message" Width="300" runat="server" />
                <dw:ListColumn ID="colRecipients" EnableSorting="true" Name="Recipients" Width="125" runat="server" />
				<dw:ListColumn ID="colDelivered" EnableSorting="true" Name="Delivered" Width="125" runat="server" />
				<dw:ListColumn ID="colFirstdeliverDate" EnableSorting="true" Name="First delivered" Width="150" runat="server" />
				<dw:ListColumn ID="colLastdeliverDate" EnableSorting="true" Name="Last delivered" Width="150" runat="server" />
            </Columns>
        </dw:List>        
        <dw:ContextMenu ID="SmsContext" runat="server">
            <dw:ContextMenuButton ID="cmdEditContext" runat="server" Divide="None" Text="Edit message" OnClientClick="editItem(ContextMenu.callingID);" Image="EditGear" />
            <dw:ContextMenuButton ID="cmdDeleteContext" runat="server" Divide="None" Text="Delete message" OnClientClick="deleteItem(ContextMenu.callingID);" Image="Delete" />
        </dw:ContextMenu>
		<span id="jsHelp" style="display: none"><%=Dynamicweb.Gui.help("", "modules.sms.general.list.item") %> </span>
        <span id="confirmDelete" style="display: none"><dw:TranslateLabel id="lbDelete" Text="Slet?" runat="server" /></span>
    </form>
</body>
</html>
