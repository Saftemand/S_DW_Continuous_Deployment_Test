<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ValidateEmailsResults.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.ValidateEmailsResults" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <title>Results of the emails validation</title>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css">
    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
</head>

<script language="javascript" type="text/javascript">

        function getSelectedRows() {
            var rows = new Array;

            // The item that is right clicked
            // if (ContextMenu.callingItemID != null) rows[0] = ContextMenu.callingItemID;

            // The selected items in the list (will overwrite the right clicked item if any exists)
            var selectedRows = List.getSelectedRows('ResultsList');

            if (selectedRows.length > 0) {
                for (var i = 0; i < selectedRows.length; i++) {
                    rows[i] = selectedRows[i].attributes['itemid'].value;
                }
            }

            return rows;
        }

        function deleteSelectedRecipients() {
            var rows = getSelectedRows();

            if (rows.length == 0) {
                alert('<%=Translate.JSTranslate("Recipients are not selected.")%>');
                return false;
            }

            if (deleteConfirm()) {
                // Set ids
                var selectedRows = '';
                for (var i = 0; i < rows.length; i++)
                    selectedRows += (i > 0 ? ',' : '') + rows[i];

                document.getElementById('deleteRcps').value = selectedRows;
                return true;
            }
            return false;
        }

        function deleteConfirm() {
            return confirm('<%=Translate.JSTranslate("WARNING: Selected item will be deleted absolutely. It will not be restored back!")%>');
        }
                
</script>

<body style="margin: 0px; height: 100%;">
    <form id="Form1" runat="server" style="margin: 0; padding: 0;">
        <dw:List ID="ResultsList" runat="server"
             AllowMultiSelect="true" 
             Title="Invalid e-mails"
             UseCountForPaging="true" 
             HandlePagingManually="true" >
            <Filters>
                  <dw:ListTextFilter runat="server" id="TextFilter" WaterMarkText="Search" Width="175" ShowSubmitButton="true" Divide="After" />
            </Filters>
            <Columns>
			    <dw:ListColumn ID="colName" runat="server" Name="User name" EnableSorting="true" />
			    <dw:ListColumn ID="colEmail" runat="server" Name="E-mail" EnableSorting="true" />
			    <dw:ListColumn ID="colDelete" runat="server" Name="Delete" Width="50" HeaderAlign="Center" ItemAlign="Center" />
		    </Columns>
        </dw:List>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin: 0px; height: 100%;">
            <tr>
                <td style="background-color:#DDECFF">
                      <asp:Button ID="DeleteRecipients" OnClientClick="deleteSelectedRecipients();" 
                         Style="width: 120px; vertical-align: middle;" runat="server" Text="Delete selected" />
                </td>
            </tr>
        </table>
        <% Translate.GetEditOnlineScript()%>
        <input type="hidden" name="deleteRcps" id="deleteRcps" value="" />
    </form>
</body>
</html>
