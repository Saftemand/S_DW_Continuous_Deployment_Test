<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ScheduledUpdatesEdit.aspx.vb" Inherits="Dynamicweb.Admin.ScheduledUpdatesEdit" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Scheduled updates" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />

        <style type="text/css">
            html, body
            {
                background-color: #f0f0f0;
                border-right: none !important;
                overflow: hidden;
            }
            
            .update-type div p,
            .misc p
            {
                margin-top: 0px;
                margin-left: 24px;
                color: #9f9f9f;
            }
            
            .schedule-warning
            {
                position: absolute;
                width: 16px;
                height: 16px;
                margin-top: 3px;
                right: -20px;
            }
        </style>

        <script type="text/javascript">
            var w = null;
            if (parent) {
                w = parent.Dynamicweb.Controls.PopUpWindow.current(this);

                if (w) {
                    w.add_ok(function (sender, e) {
                        e.set_cancel(true);

                        w.get_okButton().disabled = true;
                        document.getElementById('ScheduledUpdatesEdit').submit();
                    });
                }
            }

            function setEnableFormControls(enabled) {
                var controls = [];
                var probe = ['input', 'select', 'img.H'];

                for (var i = 0; i < probe.length; i++) {
                    controls = $$('#tabSchedule ' + probe[i]);
                    if (controls != null && controls.length > 0) {
                        for (var j = 0; j < controls.length; j++) {
                            if(typeof(controls[j].value) != 'undefined') {
                                controls[j].disabled = !enabled;
                            } else {
                                controls[j].style.display = (enabled ? '' : 'none');
                            }
                        }
                    }
                }
            }

            $(document).observe('dom:loaded', function () {
                setEnableFormControls(!document.getElementById('UpdateType0').checked);
            });
        </script>
    </head>
    <body>
        <form id="ScheduledUpdatesEdit" runat="server">
            <fieldset style="margin: 5px 5px 5px 3px">
                <legend class="gbTitle"><dw:TranslateLabel ID="lbGbGeneral" Text="General" runat="server" /></legend>
                <table border="0" style="margin: 5px">
                    <tr>
                        <td style="width: 170px" valign="top">
                            <dw:TranslateLabel ID="lbUpdateType" Text="Update type" runat="server" />
                        </td>
                        <td class="update-type" style="position: relative">
                            <div>
                                <dw:RadioButton ID="rbNone" FieldValue="0" FieldName="UpdateType" OnClientClick="setEnableFormControls(false);" runat="server" />
                                <label for="UpdateType0">
                                    <dw:TranslateLabel ID="lbUpdateNone" Text="None" runat="server" />
                                </label>
                                <p>
                                    <dw:TranslateLabel ID="lbUpdateNoneDescription" Text="No automatic updates are scheduled." runat="server" /> 
                                </p>
                            </div>
                            <div>
                                <dw:RadioButton ID="rbSchedulerTasks" FieldValue="1" FieldName="UpdateType" OnClientClick="setEnableFormControls(true);" runat="server" />
                                <label for="UpdateType1" style="position: relative">
                                    <dw:TranslateLabel ID="lbUpdateSchedulerTasks" Text="Create scheduled task" runat="server" />
                                    <img class="schedule-warning" src="/Admin/Images/Ribbon/Icons/Small/Warning.png" id="imgNoSchedulerWarning" runat="server" />
                                </label>
                                <p>
                                    <dw:TranslateLabel ID="lbUpdateSchedulerTasksDescription" Text="Create scheduled task that will handle automatic updates." runat="server" />
                                    <dw:TranslateLabel ID="lbNoScheduler" runat="server" />
                                </p>
                            </div>
                            <div id="divStartupTask" runat="server">
                                <dw:RadioButton ID="rbStartupTasks" FieldValue="2" FieldName="UpdateType" OnClientClick="setEnableFormControls(true);" runat="server" />
                                <label for="UpdateType2" style="position: relative">
                                    <dw:TranslateLabel ID="lbUpdateStartupTasks" Text="Create application startup task" runat="server" />
                                    <img class="schedule-warning" src="/Admin/Images/Ribbon/Icons/Small/Warning.png" id="imgWarning" runat="server" />
                                </label>

                                <p>
                                    <dw:TranslateLabel ID="lbUpdateStartupDescription" Text="Run updates when the application starts." runat="server" />
                                    <dw:TranslateLabel ID="lbUpdateStartupDescription2" Text="This method is not recommended to be used with large indexes." runat="server" />
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset style="margin: 5px 5px 5px 3px">
                <legend class="gbTitle"><dw:TranslateLabel ID="lbGbSchedule" Text="Schedule" runat="server" /></legend>
                <table id="tabSchedule" border="0" style="maring: 5px">
                    <tr>
                        <td style="width: 180px">
                            <dw:TranslateLabel ID="lbLastExecutedText" Text="Last executed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lbLastExecuted" runat="server" />
                        </td>
                    </tr>
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
                            <asp:DropDownList ID="ddInterval" CssClass="std" style="width: 177px" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label AssociatedControlID="chkIsFullUpdate" runat="server">
                                <dw:TranslateLabel ID="lbIsFullUpdate" Text="Full update" runat="server" />
                            </asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkIsFullUpdate" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset style="margin: 5px 5px 5px 3px">
                <legend class="gbTitle"><dw:TranslateLabel ID="lbGbAutomaticUpdates" Text="Diverse" runat="server" /></legend>
                <table border="0" style="margin: 5px;" class="misc">
                    <tr>
                        <td style="width: 180px" valign="top">
                            <dw:TranslateLabel ID="lbAutomaticUpdates" Text="Automatic updates" runat="server" />
                        </td>
                        <td valign="top" style="position: relative">
                            <asp:CheckBox ID="chkAutoUpdateEnabled" runat="server" />
                            <asp:Label ID="lbAutoUpdateEnabled" AssociatedControlID="chkAutoUpdateEnabled" style="position: relative" runat="server">
                                <dw:TranslateLabel ID="lbEnabled" Text="Enable" runat="server" />
                                <img class="schedule-warning" src="/Admin/Images/Ribbon/Icons/Small/Warning.png" id="imgAutoUpdateWarning" runat="server" />
                            </asp:Label>

                            <p>
                                <dw:TranslateLabel ID="lbAutoUpdateDescription" Text="Run updates whenever there are any pending changes." runat="server" />
                                <dw:TranslateLabel ID="lbAutoUpdateDescription2" Text="This method is not recommended to be used with large indexes." runat="server" />
                            </p>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </form>

        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
