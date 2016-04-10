<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ModelEdit.aspx.vb" Inherits="Dynamicweb.Admin.Recommendation.ModelEdit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Model edit</title>
    <style>
        td:first-child {
            width: 170px;
        }

        .required label::after {
            content: '*';
            display: inline-block;
        }

        #ExportNow, #ResetExport {
            float: right;
        }
    </style>
    <dw:ControlResources runat="server" ID="ControlResources1" IncludePrototype="true" />
    <script>
        var _overlay = null;

        var validate = function (success) {
            _overlay = new overlay('__ribbonOverlay');

            success();

            return;
            _overlay.message('Validating model ...');
            _overlay.show();
            var url = location.href.replace(/#.*/, '');
            url += (url.indexOf('?') < 0 ? '?' : '&') + 'ajax=true&cmd=validatemodel';
            var fields = document.querySelectorAll('#ModelEditForm input');
            var i, field;
            for (i = 0; field = fields[i]; i++) {
                url += '&' + encodeURIComponent(field.name) + '=' + encodeURIComponent(field.value);
            }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        try {
                            var data = JSON.parse(this.response);
                            if (data.result) {
                                success();
                            } else {
                                _overlay.hide();
                                alert(data.message ? data.message : 'Invalid data');
                            }
                        } catch (ex) { }
                    }
                }
            }
            ;;; console.debug('url', url);
            xhr.open('get', url);
            xhr.send();
            return true;
        },

        save = function (action) {
            validate(function () {
                _overlay.message('Saving model');
                $("action").value = action ? action : "save";
                $('submit').click();
            });
        },

        saveAndClose = function () {
            save("saveAndClose");
        },

        cancel = function () {
            location.href = '<%= Dynamicweb.Admin.Recommendation.ModelList.ModelListUrl + "#" + Model.Id.ToString() %>';
        }
    </script>
</head>
<body>
    <form runat="server" id="ModelEditForm">
        <dw:Toolbar runat="server" ID="Toolbar" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="cmdSave" Divide="None" Image="Save" Text="Save" OnClientClick="save()" />
            <dw:ToolbarButton runat="server" ID="cmdSaveAndClose" Divide="None" Image="SaveAndClose" Text="Save and close" OnClientClick="saveAndClose()" />
            <dw:ToolbarButton runat="server" ID="cmdCancel" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="cancel()" ShowWait="true" />
            <dw:ToolbarButton runat="server" ID="cmdHelp" Divide="None" Image="Help" Text="Help" OnClientClick="showHelp()" />
        </dw:Toolbar>
        <h2 class="subtitle">
            <dw:TranslateLabel runat="server" Text="Recommendation model" />
        </h2>
        <dw:Infobar runat="server" ID="InfoBarErrorMessages" Visible="False"></dw:Infobar>

        <div style="display: none">
            <input type="hidden" name="action" id="action" value="" />
            <input type="submit" id="submit" value="Submit" style="display: none" />
        </div>

        <dw:GroupBox runat="server" ID="grpDetails" Title="Details" DoTranslation="true">
            <table>
                <tr class="required">
                    <td>
                        <label for="ModelName">
                            <dw:TranslateLabel runat="server" Text="Model name" />
                        </label>
                    </td>
                    <td>
                        <input runat="server" type="text" id="ModelName" class="std" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox runat="server" ID="grpServiceSettings" Title="Service settings" DoTranslation="true">
            <table>
                <tr class="required">
                    <td>
                        <label for="ModelServiceUrl">
                            <dw:TranslateLabel runat="server" Text="Service url" />
                        </label>
                    </td>
                    <td>
                        <input runat="server" type="text" id="ModelServiceUrl" class="std" />
                    </td>
                </tr>
                <tr runat="server" visible="false" class="required">
                    <td>
                        <label for="ModelServiceClientId">
                            <dw:TranslateLabel runat="server" Text="Service client id" />
                        </label>
                    </td>
                    <td>
                        <input runat="server" type="text" id="ModelServiceClientId" class="std" />
                    </td>
                </tr>
                <tr class="required">
                    <td>
                        <label for="ModelServiceModelId">
                            <dw:TranslateLabel runat="server" Text="Service model id" />
                        </label>
                    </td>
                    <td>
                        <input runat="server" type="text" id="ModelServiceModelId" class="std" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox runat="server" ID="grpModelParameters" Title="Model parameters" DoTranslation="true">
            <table>
                <tr>
                    <td>
                        <label for="_ParametersModelType">
                            <dw:TranslateLabel runat="server" Text="Model type" />
                        </label>
                    </td>
                    <td>
                        <select runat="server" id="_ParametersModelType" class="std" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="_ParametersSimilarityType">
                            <dw:TranslateLabel runat="server" Text="Similarity type" />
                        </label>
                    </td>
                    <td>
                        <select runat="server" id="_ParametersSimilarityType" class="std" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="_ParametersUserCutoff">
                            <dw:TranslateLabel runat="server" Text="User cutoff" />
                        </label>
                    </td>
                    <td>
                        <input runat="server" id="_ParametersUserCutoff" class="std" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox runat="server" ID="grpDataExportSchedule" Title="Data export schedule" DoTranslation="true">
            <table>
                <tr>
                    <td>
                        <label for="_ExportDataType">
                            <dw:TranslateLabel runat="server" Text="Data type" />
                        </label>
                    </td>
                    <td>
                        <select runat="server" id="_ExportDataType" class="std" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="_ExportStartTime">
                            <dw:TranslateLabel runat="server" Text="Start time" />
                        </label>
                    </td>
                    <td>
                        <dw:DateSelector runat="server" ID="_ExportStartTime" IncludeTime="True" ShowAsLabel="False" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="_ExportInterval">
                            <dw:TranslateLabel runat="server" Text="Repeat every" />
                        </label>
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="_ExportInterval" CssClass="std"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <label>
                            <input runat="server" type="checkbox" id="ExportRebuildServiceModel" />
                            <dw:TranslateLabel runat="server" Text="Rebuild service model after export" />
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel runat="server" Text="Export started at" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="ExportStartedAt" />
                        <button runat="server" id="ExportNow" onserverclick="ServerClick">Export now</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel runat="server" Text="Export finished at" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="ExportFinishedAt" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel runat="server" Text="Export status" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="ExportStatus" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox runat="server" ID="Caching" Title="Caching" DoTranslation="true">
            <table>
                <tr>
                    <td>
                        <label for="_RecommendationCacheLifetime">
                            <dw:TranslateLabel runat="server" Text="Recommendations cache lifetime" />
                        </label>
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="_RecommendationCacheLifetime" CssClass="std"></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <div class="service-schedule">
            <dw:GroupBox runat="server" ID="grpServiceSchedule" Title="Service schedule" DoTranslation="true">
                <table>
                    <tr>
                        <td>
                            <label for="_ScheduleStartTime">
                                <dw:TranslateLabel runat="server" Text="Start time" />
                            </label>
                        </td>
                        <td>
                            <dw:DateSelector runat="server" ID="_ScheduleStartTime" IncludeTime="True" ShowAsLabel="False" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="_ScheduleInterval">
                                <dw:TranslateLabel runat="server" Text="Repeat every" />
                            </label>
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="_ScheduleInterval" CssClass="std"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Last scheduled run" />
                        </td>
                        <td>
                            <asp:Label runat="server" ID="LastScheduledRun" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </form>
    <%--
    <script>(function () {
    var i, el, elements,

       updateUI = function () {
           var i, el = document.getElementById('ExportRebuildServiceModel'),
           isEnabled = el && el.checked;
           elements = document.querySelectorAll('.service-schedule');
           for (i = 0; el = elements[i]; i++) {
               el.style.display = !isEnabled ? 'block' : 'none';
           }
       };

    elements = document.querySelectorAll('#ExportRebuildServiceModel');
    for (i = 0; el = elements[i]; i++) {
        el.addEventListener('change', updateUI);
    }
    updateUI();
}())</script>
    --%>
    <%
        Translate.GetEditOnlineScript()
    %>
</body>
</html>
