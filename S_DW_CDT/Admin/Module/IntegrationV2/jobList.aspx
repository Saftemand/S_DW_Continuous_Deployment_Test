<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="jobList.aspx.vb" Inherits="Dynamicweb.Admin.jobList" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" IncludeUIStylesheet="true">
        <Items>
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/jobList.js" />
        </Items>
    </dw:ControlResources>

    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>

    <script type="text/javascript">
        function help() {
            <%=Gui.Help("data integration", "modules.dataintegration.general")%>
        }

        function CreateUrlTask() {
            $('activity').value = 'addurltask';
            dialog.hide('UrlBuilderDialog');
            document.getElementById('selectedUrlJob').value = SelectionBox.getElementsRightAsArray('UrlBuilderActionSelector');
            dialog.show('AddTaskDialog');
        }

        function GenerateUrl() {
            var jobs = SelectionBox.getElementsRightAsArray('UrlBuilderActionSelector');
            var syncExecution = document.getElementById('checkSyncExecution').checked;
            var stopOnFail = document.getElementById('checkStopOnFailedJob').checked;

            if(jobs.length == 0) {
                document.getElementById('UrlBuilderUrlValue').value = '';
                document.getElementById('btnCreateTask').disabled = 'disabled';
                return;
            }
            else {
                document.getElementById('btnCreateTask').removeAttribute('disabled');
            }

            ShowUrlBuilderOverlay();
            new Ajax.Request('/Admin/Module/IntegrationV2/jobList.aspx?action=UrlBuilder&SyncExecution=' + syncExecution + '&StopOnFailedJob=' + stopOnFail + '&jobsToRun=' + jobs, {
                method: 'post',
                onComplete: function (transport) {
                    document.getElementById('UrlBuilderUrlValue').value = transport.responseText;
                    HideUrlBuilderOverlay();
                },
            });
        }

        function SetSelectedJobs(listId, jobname) {
            var sjobs = GetSelectedJobsNames(listId);

            if(sjobs.length > 0)
                $('selectedJob').value = sjobs;
            else
                $('selectedJob').value = jobname;
        }

        function GetSelectedJobsNames(listId) {
            var ret = '';
            var jobs = List.getSelectedRows(listId);

            if(jobs != null) {
                var len = jobs.toArray().length;

                for(i = 0; i < len; i++) {
                    if(i > 0)
                        ret += ';';

                    ret += jobs[i].readAttribute("itemid");
                }
            }

            return ret;
        }

        function ShowUrlBuilderOverlay() {
            var o = new overlay('UrlBuilderOverlay');
            o.show();
        }

        function HideUrlBuilderOverlay() {
            var o = new overlay('UrlBuilderOverlay');
            o.hide();
        }

        function toggleShow() {
            if($('UrlActivation').checked) {
                $('addInDiv').style.display = 'none';
            }
            else {
                $('addInDiv').style.display = 'block';
            }
        }

        function ValidateJobName() {
            var name = document.getElementById('newName').value;

            if(name == null || name == '' || name.indexOf(',') > -1) {
                alert('<%=Translate.JsTranslate("Invalid activity name")%>');
                return false;
            }
            else
                return true;
        }

        function DeleteJobs() {
            var jobs = List.getSelectedRows('activityList');

            if(jobs != null && jobs.toArray().length > 1)
                $('selectedJob').value = GetSelectedJobsNames('activityList');
            else
                $('selectedJob').value = ContextMenu.callingItemID;

            dialog.show('DeleteActivityDialog');
        }

        function DeleteActivity() {
            List.setAllSelected('activityList', false);
            $('form1').submit();
        }

        function OnSelectCtxView(sender, args) {
            var ret = ['activityListContextMenu'];
            var jobs = List.getSelectedRows('activityList');

            if(jobs != null && jobs.toArray().length > 1)
                ret.push('DeleteActivityButton');
            else {
                ret.push('RenameActivityButton');
                ret.push('EditDescriptionButton');
                ret.push('NotificationSettingsButton');
                ret.push('DeleteActivityButton');
                ret.push('RenameActivityButton');
                ret.push('LogButton');
                ret.push('AddTaskButton');
            }

            return ret;
        }

        function OnEditDescription()
        {
            var desc = List.getAllRows("activityList")[ContextMenu.callingID - 1].readAttribute('attrDescription');
            $('activity').value = 'editdesc';
            $('newJobDesc').value = desc;
            $('selectedJob').value = ContextMenu.callingItemID;
            dialog.show('editDescription');
        }

        function deleteLogs() {
            if (confirm('<%=Translate.JsTranslate("All logs older than a week will be deleted. Do you want to continue?")%>')) {
                var o = new overlay('forward');
                o.show();
                $('action').value = 'deleteLogs';
                $('form1').submit();
            };
        }
    </script>

</head>
<body onload="if (!(window.showNewWizard===undefined))newWizard_wnd.show();if (!(window.showNewFromTemplate===undefined))newFromTemplate_wnd.show();">
    <form id="form1" runat="server">
        <dw:Overlay ID="forward" Message="Please wait" runat="server">
        </dw:Overlay>
        <div>
            <dw:Toolbar runat="server" ID="JobSelect" ShowEnd="false">
                <dw:ToolbarButton runat="server" ID="btnNew" Text="New activity" ImagePath="/Admin/Module/IntegrationV2/img/activity_new_small.png" Translate="true" OnClientClick="$('activity').value='';$('action').value='new';$('form1').submit();" />
                <dw:ToolbarButton runat="server" ID="btnNewFromTemplate" Text="New activity from template" ImagePath="/Admin/Module/IntegrationV2/img/activity_new_small.png" Translate="true" OnClientClick="$('activity').value='';$('action').value='newFromTemplate';$('form1').submit();" />
                <dw:ToolbarButton runat="server" ID="btnUrl" Text="URL Builder" ImagePath="/Admin/Images/Ribbon/Icons/Small/preferences.png" Translate="true" OnClientClick="dialog.show('UrlBuilderDialog')" />                
                <dw:ToolbarButton runat="server" ID="btnDeleteLogs" Text="Delete old logs" ImagePath="/Admin/Images/Ribbon/Icons/Small/TextCode_delete.png" Translate="true"  OnClientClick="deleteLogs();" />
                <dw:ToolbarButton runat="server" ID="bthHelp" Text="Help" Image="Help" Translate="true" OnClientClick="help();" />
            </dw:Toolbar>
        </div>
        <div id="jobs">
            <input type="hidden" name="selectedJob" id="selectedJob" runat="server" />
            <input type="hidden" name="selectedUrlJob" id="selectedUrlJob" runat="server" />
            <input type="hidden" name="activity" id="activity" runat="server" />
            <input type="hidden" name="action" id="action" runat="server" />
            <dw:List ID="activityList" Title="Activities" AllowMultiSelect="true" Personalize="true" runat="server" ContextMenuID="activityListContextMenu">
                <Columns>
                    <dw:ListColumn ID="clmName" Name="Name" runat="server" Width="120" />
                    <dw:ListColumn ID="clmTask" Name="Scheduled" runat="server" />
                    <dw:ListColumn ID="clmRun" Name="Run" runat="server" Width="20" />
                    <dw:ListColumn ID="clmDesc" Name="Description" runat="server" WidthPercent="50" />
                </Columns>
            </dw:List>
            <dw:ContextMenu runat="server" ID="activityListContextMenu" OnClientSelectView="OnSelectCtxView">
                <dw:ContextMenuButton runat="server" ID="RenameActivityButton" Text="Rename" ImagePath="img/activity_rename_small.png" OnClientClick="$('activity').value='rename';$('newName').value=ContextMenu.callingItemID;$('selectedJob').value=ContextMenu.callingItemID;dialog.show('RenameActivityDialog')">
                </dw:ContextMenuButton>
                <dw:ContextMenuButton runat="server" ID="EditDescriptionButton" Text="Edit description" ImagePath="img/scripting_edit_small.png" OnClientClick="OnEditDescription();">
                </dw:ContextMenuButton>
                <dw:ContextMenuButton runat="server" ID="NotificationSettingsButton" Text="Notification settings" ImagePath="img/notification_settings_small.png" OnClientClick="if(notificationSettings_wnd){notificationSettings_wnd.set_contentUrl('/Admin/Module/IntegrationV2/NotificationSettings.aspx?selectedJob=' + ContextMenu.callingItemID);notificationSettings_wnd.show();}">
                </dw:ContextMenuButton>
                <dw:ContextMenuButton runat="server" ID="DeleteActivityButton" Text="Delete" ImagePath="img/activity_delete_small.png" OnClientClick="$('activity').value='delete'; DeleteJobs();">
                </dw:ContextMenuButton>
                <dw:ContextMenuButton runat="server" ID="LogButton" Text="Log" Image="Information">
                </dw:ContextMenuButton>
                <dw:ContextMenuButton runat="server" ID="AddTaskButton" Text="Schedule task" ImagePath="/Admin/Images/Ribbon/Icons/Small/Clock.png" OnClientClick="$('activity').value='addtask';$('selectedJob').value=ContextMenu.callingItemID;dialog.show('AddTaskDialog');">
                </dw:ContextMenuButton>
            </dw:ContextMenu>
        </div>
        <dw:Dialog Title="Generate URL" ID="UrlBuilderDialog" Width="482" runat="server" OkAction="$('form1').submit();" IsModal="True">
            <dw:Overlay ID="UrlBuilderOverlay" Message="Please wait" runat="server">
            </dw:Overlay>
            <dw:SelectionBox ID="UrlBuilderActionSelector" runat="server" Width="200" Height="200" LeftHeader="Source jobs" RightHeader="Target jobs" TranslateHeaders="True" ShowSortRight="True">
            </dw:SelectionBox>
            <div style="margin-bottom: 2px; vertical-align: middle">
                <input id="btnGenerate" type="button" value="Generate URL" onclick="GenerateUrl();" />
                <input id="checkSyncExecution" type="checkbox" value="False" /><span><%=Translate.JsTranslate("Synchronous execution")%></span>
                <input id="checkStopOnFailedJob" type="checkbox" value="False" /><span><%=Translate.JsTranslate("Stop on failed jobs")%></span>
            </div>
            <asp:TextBox Height="150px" ReadOnly="False" Width="422px" ID="UrlBuilderUrlValue" runat="server" TextMode="MultiLine"></asp:TextBox>
            <div style="margin-top: 6px; margin-right: 21px; text-align: right;">
                <input id="btnCreateTask" disabled="disabled" type="button" value="Create as scheduled task" onclick="CreateUrlTask();" />
                <input id="btnCancelTask" type="button" value="Cancel" onclick="dialog.hide('UrlBuilderDialog');" />
            </div>
        </dw:Dialog>
        <dw:Dialog Title="New activity" ID="newJob" Width="390" runat="server" ShowCancelButton="true" ShowOkButton="true" OkAction="$('form1').submit();">
            <div style="float: left; width: 100px">
                Activity name
            </div>
            <div style="float: left;">
                <input type="text" id="name" runat="server" class="NewUIinput" /></div>
            <br />
            <input type="checkbox" id="newJobAutomatedMapping" runat="server" />
            <label for="newJobAutomatedMapping">
                Perform mapping automatically on run</label>
        </dw:Dialog>
        <dw:Dialog Title="Rename activity" ID="RenameActivityDialog" Width="390" runat="server" ShowCancelButton="true" ShowOkButton="true" OkAction="if(ValidateJobName()) {$('form1').submit();}">
            <div style="float: left; width: 100px">
                New name
            </div>
            <div style="float: left;">
                <input type="text" id="newName" runat="server" class="NewUIinput" /></div>
        </dw:Dialog>
        <dw:Dialog Title="Delete activity" ID="DeleteActivityDialog" runat="server" ShowCancelButton="true" ShowOkButton="true" OkAction="DeleteActivity();">
            Are you sure you want to delete the activity?
        </dw:Dialog>
        <dw:Dialog Title="Edit description" ID="editDescription" Width="390" runat="server" ShowCancelButton="true" ShowOkButton="true" OkOnEnter="true" OkAction="$('form1').submit();">
            <div style="float: left; width: 100px; margin-top: 5px; margin-bottom: 5px;">
                <%=Translate.JsTranslate("Activity description")%>
            </div>
            <div style="float: left; margin-top: 5px; margin-bottom: 5px;">
                <textarea id="newJobDesc" name="newJobDesc" runat="server" rows="3" cols="30"></textarea>
            </div>
            <br />
        </dw:Dialog>
        <dw:PopUpWindow ID="newWizard" ContentUrl="/Admin/Module/IntegrationV2/SelectSource.aspx" AutoReload="true" Title="Create new activity" ShowClose="true" ShowOkButton="false" ShowCancelButton="false" runat="server" OnClientHide="cancelNew" HidePadding="true" TranslateTitle="true" Height="460" Width="600" />
        <dw:PopUpWindow ID="newFromTemplate" ContentUrl="/Admin/Module/IntegrationV2/NewJobFromTemplate.aspx" AutoReload="true" Title="Create new activity" ShowClose="true" ShowOkButton="false" ShowCancelButton="false" runat="server" OnClientHide="cancelNew" HidePadding="true" TranslateTitle="true" Width="600" />
        <dw:PopUpWindow ID="historyLogPopup" AutoReload="true" Width="800" Height="560" ShowCancelButton="false" ShowOkButton="false" ShowClose="True" Title="Job log" runat="server" IsModal="False" AutoCenterProgress="True" />
        <dw:PopUpWindow ID="notificationSettings" ContentUrl="/Admin/Module/IntegrationV2/NotificationSettings.aspx" AutoReload="true" Title="Notification settings" ShowClose="true" ShowOkButton="false" Width="600" Height="300" ShowCancelButton="false" runat="server" HidePadding="true" TranslateTitle="true" />
        <dw:Dialog ID="AddTaskDialog" FinalizeActions="false" Title="Add scheduled integration task" ShowOkButton="true" Width="600" ShowCancelButton="true" runat="server" OkAction="dialog.hide('AddTaskDialog');var o = new overlay('forward');o.show();$('form1').submit();">
            <fieldset style="margin: 5px 5px 5px 3px">
                <legend class="gbTitle">
                    <dw:TranslateLabel ID="lbGbSchedule" Text="Schedule" runat="server" />
                </legend>
                <table id="tabSchedule" border="0" style="margin: 5px">
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="lbStartDate" Text="Start date" runat="server" />
                        </td>
                        <td>
                            <div style="position: relative">
                                <dw:DateSelector runat="server" ID="dtStart" AllowNeverExpire="false" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="lbInterval" Text="Interval" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddInterval" CssClass="std" Style="width: 177px" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td width="100" valign="top">
                            Activation
                        </td>
                        <td width="300" valign="top">
                            <input type="radio" runat="server" name="Activation" id="UrlActivation" value="UrlActivation" onclick="javascript:toggleShow();" checked="true" />
                            <label for="UrlActivation">
                                <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Url" />
                            </label>
                            <input type="radio" runat="server" name="Activation" id="AddInActivation" value="AddInActivation" onclick="javascript:toggleShow();" />
                            <label for="AddInActivation">
                                <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Add-in" />
                            </label>
                        </td>
                    </tr>
                </table>
                <div id="addInDiv" style="display: none;">
                    <asp:Literal ID="addInSelectorScripts" runat="server"></asp:Literal>
                    <de:AddInSelector ID="addInSelector" runat="server" AddInShowParameters="true" UseLabelAsName="True" AddInShowNothingSelected="false" AddInTypeName="Dynamicweb.Extensibility.ScheduledTaskAddins.BaseScheduledTaskAddIn" AddInShowFieldset="false" useNewUI="True" AddInIgnoreTypeName="Dynamicweb.Data.Integration.Interfaces.IERPIntegration" />
                    <asp:Literal ID="addInSelectorLoadScript" runat="server"></asp:Literal>
                </div>
            </fieldset>
        </dw:Dialog>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
