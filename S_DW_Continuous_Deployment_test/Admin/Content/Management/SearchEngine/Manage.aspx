<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Manage.aspx.vb" Inherits="Dynamicweb.Admin.Manage" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Index - manage" runat="server" /></title>
        
        <%If Dynamicweb.Searching.IndexManager.Status.ContainsKey(Request("Path")) Then%>
        <meta http-equiv="refresh" content="15" />
        <%End If%>

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
            
            @-moz-document url-prefix() 
            {
                div.stylishButton { line-height: 18px; }
                div.stylishButton-active { line-height: 17px !important; }
            }

            div#spCheckStatus.stylishButton { color: #333333; }
            
            <asp:Literal ID="litDisabledStyles" runat="server" />
        </style>

        <style id="stDeactivatedQueue" type="text/css" runat="server">
            .conditionally-deactivated { color: #9b9b9b; }
        </style>

        <script type="text/javascript">
            var SearchEngineIndex = new Object();

            window.onresize = function () { ContextMenu.hide(); }

            SearchEngineIndex.updateIndex = function (path, isPartial, button) {
                if (button) {
                    button.disabled = true;
                }

                new Ajax.Request('/Admin/Content/Management/SearchEngine/Manage.aspx?Path=' +
                    encodeURIComponent(path) + '&Update=' + (isPartial ? 'Partial' : 'Full') + '&t=' + (new Date()).getTime(), { method: 'get' });

                setTimeout(function () {
                    var link = '';
                    var w = window;
                    var dashIndex = 0;

                    if (parent)
                        w = parent;

                    link = w.location.href;
                    dashIndex = link.indexOf('#');
                    if (dashIndex > 0) {
                        link = link.substr(0, dashIndex);
                    }

                    link = link.replace(/[?&]ShowIndex=[^&]*/gi, '');
                    w.location.href = link + (link.indexOf('?') > -1 ? '&' : '?') + 'ShowIndex=' + encodeURIComponent(path);
                }, 750);
            }

            SearchEngineIndex.Switch = function (radioButton) {
                if (confirm('<%=Translate.JsTranslate("Do you want to switch current index folder?")%>')) {
                    __doPostBack('cmdSwitch','');
                }
                else {
                    return false;
                }
            }

            SearchEngineIndex.setEnableListItem = function (path, isActive, exists) {
                var css = 'indexer-normal';

                if (!isActive) {
                    css = 'indexer-locked';
                } else if (!exists) {
                    css = 'indexer-new';
                }

                if (parent && typeof (parent.SearchEngineIndex) != 'undefined' && typeof (parent.SearchEngineIndex.setIndexState) != 'undefined') {
                    parent.SearchEngineIndex.setIndexState(path, css, (isActive && exists));
                }
            }

            SearchEngineIndex.setOptionsVisibility = function (isVisible) {
                var menu = null;
                var leftOffset = -1;
                var menuTopOffset = -1;
                var elm = $(ContextMenu.callingID);

                if (elm) {
                    if (isVisible) {
                        elm.addClassName('stylishButton-active');

                        if (typeof (ContextMenu.menuElement) != 'undefined') {
                            menu = $(ContextMenu.menuElement);

                            if (Prototype.Browser.IE) {
                                menuTopOffset = -2;

                                if (parseInt(document.documentMode) == 7)
                                    leftOffset = 1;
                            }

                            elm.setStyle({ 'left': (parseInt(menu.getStyle('left')) + (menu.getWidth() - elm.getWidth()) + leftOffset) + 'px' });
                            elm.setStyle({ 'top': (parseInt(menu.getStyle('top')) - elm.getHeight()) + 'px' });
                            menu.setStyle({ 'left': (parseInt(menu.getStyle('left')) + leftOffset) + 'px', 'top': (parseInt(menu.getStyle('top')) + menuTopOffset) + 'px' });
                        }
                    }
                    else
                        elm.removeClassName('stylishButton-active');
                }
            }

            SearchEngineIndex.showDefaultLog = function () {
                if (parent && parent.SearchEngineIndex) {
                    parent.SearchEngineIndex.viewLogs('DynamicwebEventLogProvider');
                }
            }

            SearchEngineIndex.checkStatus = function (path) {
                if (parent && parent.SearchEngineIndex) {
                    parent.SearchEngineIndex.showManageDialog(path);
                }
            }

            SearchEngineIndex.manageScheduledUpdates = function (path) {
                if (parent && parent.SearchEngineIndex) {
                    parent.SearchEngineIndex.showScheduledUpdatesDialog(path);
                }
            }
        </script>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <div class="details-container">
                <asp:CheckBox ID="cmdActivateDeactivateCheck" CssClass="cmdActivateDeactivateCheck" Text="Activate/Deactivat" onclick="__doPostBack('cmdActivateDeactivate','')"  runat="server" />
                <fieldset style="margin: 5px 5px 5px 3px">
                    <legend class="gbTitle"><dw:TranslateLabel ID="lbGbStatus" Text="Status" runat="server" /></legend>
                
                    <table border="0" width="100%">
                        <tr class="conditionally-deactivated">
                            <td style="width: 170px"><dw:TranslateLabel ID="lbIndex" Text="Index" runat="server" /></td>
                            <td>
                                <div class="indexer-master indexer-normal"><asp:Literal ID="litIndex" Text="" runat="server" /></div>
                            </td>
                        </tr>
                        <tr class="conditionally-deactivated">
                            <td style="width: 170px"><dw:TranslateLabel ID="lbStatus" Text="State" runat="server" /></td>
                            <td><div id="divStatus" runat="server" /></td>
                        </tr>
                        <%If Dynamicweb.Searching.IndexManager.Status.ContainsKey(Request("Path")) Then
                                Dim indexerStatus As Collections.Generic.Dictionary(Of String, String) = Dynamicweb.Searching.IndexManager.Status(Request("Path"))
                                Dim status As String = indexerStatus("Current") & " / " & indexerStatus("Total")
                                Dim statusTotal As Integer
                                Dim statusCurrent As Integer
                                Integer.TryParse(indexerStatus("Total"), statusTotal)
                                Integer.TryParse(indexerStatus("Current"), statusCurrent)
                                Dim statusProcent As Integer = (statusCurrent / statusTotal) * 100
                                Dim startTime As DateTime
                                If Not DateTime.TryParseExact(indexerStatus("StartTime"), "dd-MM-yyyy HH:mm:ss", Nothing, Globalization.DateTimeStyles.None, startTime) Then
                                    startTime = DateTime.Now
                                End If
                                Dim sinceStart As TimeSpan = DateTime.Now - startTime
                                Dim secondsLeft As Double = (sinceStart.TotalSeconds * (statusTotal / statusCurrent)) - sinceStart.TotalSeconds

                                Dim statusTimeLeft As String = Math.Round((secondsLeft / 60)).ToString
                                
                        %>
                        <tr class="conditionally-disabled conditionally-deactivated">
                           <td></td> 
                           <td>
                               <div style="display:inline-block;width:200px;background-color:white;border:1px solid grey;padding:2px;margin:5px;margin-left:0px"><div style="width:<%=statusProcent%>%;background-color:lightgray">&nbsp;&nbsp;</div></div>&nbsp;<b><%=status%></b>
                               <%If sinceStart.TotalSeconds > 25 Then%>
                               <div><%=Translate.Translate("aprox.")%> <%=statusTimeLeft %> <%=Translate.Translate("minutes")%> <%=Translate.Translate("left")%></div>
                               <%Else%>
                               <div><%=Translate.Translate("Estimating time left")%>...</div>
                               <%End If%>
                           </td>
                        </tr>
                        <%End If%>
                        <tr class="conditionally-disabled conditionally-deactivated">
                            <td><dw:TranslateLabel id="lbLocation" Text="Location" runat="server" /></td>
                            <td><asp:Literal ID="litLocation" runat="server" /></td>
                        </tr>

                        <tr class="conditionally-disabled conditionally-deactivated">
                           <td><dw:TranslateLabel ID="lbSize" Text="Size" runat="server" /></td> 
                           <td><asp:Literal ID="litSize" Text="0 KB" runat="server" />&nbsp;(<dw:TranslateLabel ID="lbTotalEntries" Text="Items total" runat="server" />:&nbsp;<asp:Literal ID="litTotalEntries" Text="N/A" runat="server" />)</td>
                        </tr>

                        <tr class="conditionally-disabled conditionally-deactivated">
                            <td valign="top"><dw:TranslateLabel ID="lbLastUpdated" Text="Updated" runat="server" /></td>
                            <td class="row-last-updated">
                               <asp:Literal ID="litLastUpdated" runat="server" />
                                <a id="lnkUpdateStatus" href="javascript:void(0);" onclick="SearchEngineIndex.showDefaultLog();" runat="server">
                                    <dw:TranslateLabel ID="lbUpdateFailure" Text="An error occured during the last update" runat="server" />
                                </a>
                            </td>
                        </tr>

                        <tr class="conditionally-disabled conditionally-deactivated">    
                            <td style="vertical-align: top;"><%=Translate.Translate("Index folder")%></td>
                            <td>    
                                <asp:RadioButton ID="btnIndexFolder" GroupName="IndexFolder" runat="server" />            
                                <label for="btnIndexFolder">Index</label>
                                <br />
                                <asp:RadioButton ID="btnBackupFolder" GroupName="IndexFolder" runat="server" />            
                                <label for="btnBackupFolder">Backup</label>
                            </td>                                    
                        </tr> 

                        <tr class="conditionally-deactivated conditionally-disabled">
                            <td colspan="2" align="right" style="padding-top: 10px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td id="cellCheckStatus" style="padding-right: 5px" runat="server">
                                            <div class="stylishButton-container">
                                                <div id="spCheckStatus" class="stylishButton" runat="server"><dw:TranslateLabel ID="lbCheckStatus" Text="Check status" runat="server" /></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="stylishButton-container">
                                                <div id="spManageIndex" class="stylishButton" runat="server"><dw:TranslateLabel ID="lbIndexOptions" Text="Options" runat="server" /></div>
                                            </div>

                                            <div style="display: none">
                                                <asp:Button ID="cmdBackup" CssClass="newUIbutton" Text="Backup index" OnClick="cmdBackup_Click" runat="server" />&nbsp;
                                                <asp:Button ID="cmdRestore" CssClass="newUIbutton" Text="Restore index" OnClick="cmdRestore_Click" runat="server" />&nbsp;
                                                <asp:Button ID="cmdSwitch" CssClass="newUIbutton" Text="Switch index" OnClick="cmdSwitch_Click" runat="server" />&nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <fieldset style="margin: 5px 5px 5px 3px">
                    <legend class="gbTitle"><dw:TranslateLabel ID="lbGbPendingChanges" Text="Pending changes" runat="server" /></legend>
                
                    <table border="0" width="100%" class="conditionally-disabled">
                        <tr class="conditionally-deactivated">
                            <td style="width: 170px"><dw:TranslateLabel ID="lbQueueLocation" Text="Location" runat="server" /></td>
                            <td><asp:Literal ID="litQueueLocation" runat="server" /></td>
                        </tr>
                        <tr class="conditionally-deactivated">
                            <td><dw:TranslateLabel ID="lbQueueSize" Text="Size" runat="server" /></td>
                            <td><asp:Literal ID="litQueueSize" Text="0 KB" runat="server" />&nbsp;(<dw:TranslateLabel id="lbResidentSize" Text="resident memory size" runat="server" />:&nbsp;<asp:Literal ID="litQueueResidentSize" Text="0 KB" runat="server" />)</td>
                        </tr>
                        <tr class="conditionally-deactivated">
                            <td><dw:TranslateLabel ID="lbTotal" Text="Items" runat="server" /></td>
                            <td>
                                <asp:Literal ID="litTotal" Text="0" runat="server" />&nbsp;
                                (<div class="item-new" title="<%=Translate.Translate("Added items")%>"><asp:Literal ID="litNewItems" Text="0" runat="server" /></div>
                                <div class="item-updated" title="<%=Translate.Translate("Modified items")%>"><asp:Literal ID="litUpdateItems" Text="0" runat="server" /></div>
                                <div class="item-deleted" title="<%=Translate.Translate("Deleted items")%>"><asp:Literal ID="litDeletedItems" Text="0" runat="server" /></div>)
                            </td>
                        </tr>
                        <tr class="conditionally-deactivated conditionally-disabled">
                            <td colspan="2" align="right" style="padding-top: 10px">
                                <div class="stylishButton-container ">
                                    <div id="spManageQueue" class="stylishButton" runat="server"><dw:TranslateLabel ID="lbQueueOptions" Text="Options" runat="server" /></div>
                                </div>

                                <div style="display: none">
                                    <asp:Button ID="cmdSave" CssClass="newUIbutton" Text="Save on disk" OnClick="cmdSave_Click" runat="server" />&nbsp;
                                    <asp:Button ID="cmdLoad" CssClass="newUIbutton" Text="Load from disk" OnClick="cmdLoad_Click" runat="server" />&nbsp;
                                    <asp:Button ID="cmdClear" CssClass="newUIbutton" Text="Clear" OnClick="cmdClear_Click" runat="server" />&nbsp;
                                    <asp:Button ID="cmdActivateDeactivate" CssClass="newUIButton" Text="Activate/Deactivate" OnClick="cmdActivateDeactivate_Click" runat="server" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <div class="grid-container">
                    <dw:List ID="lstIndexers" ShowPaging="false" ShowTitle="false" runat="server">
                        <Columns>
                            <dw:ListColumn ID="colNumber" Name="" Width="24" runat="server" />
                            <dw:ListColumn ID="colName" Name="Indexer ID" Width="250" runat="server" />
                            <dw:ListColumn ID="colAssembly" Name="Location" Width="250" runat="server" />
                        </Columns>
                    </dw:List>
                </div>
            </div>

            <dw:ContextMenu ID="ManageIndexContext" OnShow="SearchEngineIndex.setOptionsVisibility(true);" OnHide="SearchEngineIndex.setOptionsVisibility(false);" runat="server">
                <dw:ContextMenuButton ID="cmdUpdateIndex" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_replace.png" Text="Opdatering" runat="server" />
                <dw:ContextMenuButton ID="cmdUpdateIndexPartial" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_preferences.png" Text="Partial update" runat="server" />
                <dw:ContextMenuButton ID="cmdScheduledUpdate" Divide="Before" Text="Scheduled updates" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_clock.png"  runat="server" />
                <dw:ContextMenuButton ID="cmdBackupIndex" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/Connection_Copy.png" Text="Create backup" runat="server" />
                <dw:ContextMenuButton ID="cmdRestoreIndex" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_out.png" Text="Restore backup" runat="server" />
            </dw:ContextMenu>

            <dw:ContextMenu ID="ManageQueueContext" OnShow="SearchEngineIndex.setOptionsVisibility(true);" OnHide="SearchEngineIndex.setOptionsVisibility(false);" runat="server">
                <dw:ContextMenuButton ID="cmdViewQueue" ImagePath="/Admin/Images/Ribbon/Icons/Small/Preview.png" Text="View" runat="server" />
                <dw:ContextMenuButton ID="cmdSaveQueue" ImagePath="/Admin/Images/Ribbon/Icons/Small/import1.png" Divide="Before" Text="Save on disk" runat="server" />
                <dw:ContextMenuButton ID="cmdLoadQueue" ImagePath="/Admin/Images/Ribbon/Icons/Small/export1.png" Text="Load from disk" runat="server" />
                <dw:ContextMenuButton ID="cmdActivateDeactivateQueue" ImagePath="" Text="Deactivate" Divide="Before" runat="server" />
                <dw:ContextMenuButton ID="cmdClearQueue" ImagePath="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" Divide="Before" Text="Clear" runat="server" />
            </dw:ContextMenu>
        </form>

        <%Translate.GetEditOnlineScript()%>
    </body>
</html>
