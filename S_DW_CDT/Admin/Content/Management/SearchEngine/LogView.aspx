<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LogView.aspx.vb" Inherits="Dynamicweb.Admin.LogView" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><dw:TranslateLabel ID="lbTitle" Text="Logs" runat="server" /></title>

    <dw:ControlResources ID="ctrlResources" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Management/SearchEngine/List.css" />
        </Items>
    </dw:ControlResources>

    <style type="text/css">
        html, body
        {
            background-color: #f0f0f0;
            overflow: hidden;
        }
        
        .list-container 
        {
        	height: 280px;
        	overflow: auto;
        }
        
        .list-container > div
        {
        	border: 1px solid #9FAEC2;
        }
        
        .message-container 
        {
        	overflow: auto;
        	overflow-x: hidden;
        	height: 130px;
        }
    </style>

    <script type="text/javascript">
        var SearchEngineIndex = new Object();

        SearchEngineIndex._currentRow = null;

        SearchEngineIndex.showMessage = function (id) {
            var msg = document.getElementById('msg' + id);
            var messageContainer = document.getElementById('divMessage');

            if (msg && messageContainer) {
                if (SearchEngineIndex._currentRow) {
                    List.setRowSelected('lstLogs', SearchEngineIndex._currentRow, false);
                }

                SearchEngineIndex._currentRow = List.getRowByID('lstLogs', id.toString());

                if (SearchEngineIndex._currentRow) {
                    List.setRowSelected('lstLogs', SearchEngineIndex._currentRow, true);
                }

                messageContainer.innerHTML = SearchEngineIndex.formatMessage(msg.value);
            }
        }

        SearchEngineIndex.formatMessage = function (msg) {
            var ret = msg;

            if (ret) {
                ret = ret.replace(/</g, '&lt;');
                ret = ret.replace(/>/g, '&gt;');
                ret = ret.replace(/\n/g, '<br />');
            }

            return ret;
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server">
        <div class="list-container">
            <div>
                <dw:List ID="lstLogs" PageSize="10" ShowTitle="false" runat="server">
                    <Columns>
                        <dw:ListColumn ID="colIcon" Name="Type" Width="48" HeaderAlign="Center" ItemAlign="Center" runat="server" />
                        <dw:ListColumn ID="colMessage" Name="Message" Width="240" runat="server" />
                        <dw:ListColumn ID="colIndex" Name="Index" Width="125" EnableSorting="true" runat="server" />
                        <dw:ListColumn ID="colDate" Name="Date" Width="138" EnableSorting="true" runat="server" />
                    </Columns>
                </dw:List>
            </div>
        </div>

        <fieldset style="margin: 5px 5px 5px 3px">
            <legend class="gbTitle"><dw:TranslateLabel ID="lbGbMessage" Text="Message" runat="server" /></legend>
            <table style="width: 100%">
                <tr>
                    <td>
                        <div class="message-container" id="divMessage"></div>
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>

    <script type="text/javascript">
        setTimeout(function () {
            var messages = $$('.log-message');

            if (messages != null && messages.length > 0) {
                SearchEngineIndex.showMessage(messages[0].id.replace('msg', ''));
            }
        }, 100);
    </script>
</body>
</html>
