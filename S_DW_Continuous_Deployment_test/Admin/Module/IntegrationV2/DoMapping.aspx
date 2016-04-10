<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DoMapping.aspx.vb" Inherits="Dynamicweb.Admin.DoMapping" %>

<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.AjaxTest" Assembly="Dynamicweb.Controls" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" IncludePrototype="true">
        <Items>
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Module/IntegrationV2/js/DoMapping.js" />
        </Items>
    </dw:ControlResources>
    <link rel="StyleSheet" href="/Admin/Module/IntegrationV2/css/DoMapping.css" type="text/css" />

    <script type="text/javascript">
        var IE11 = <%=If(Dynamicweb.Base.CheckIE11Version().Major >= 11, "true", "false")%>;
function help () {
    <%=Dynamicweb.Gui.Help("data integration", "modules.dataintegration.edit")%>
}
    </script>

</head>
<body style="height: 100%; overflow: hidden; min-width: 700px; background-color: white">
    <form id="form1" runat="server">
        <dw:Overlay ID="forward" Message="Please wait" runat="server">
        </dw:Overlay>
        <input type="hidden" name="action" id="action" value="" />
        <input type="hidden" name="currentMapping" id="currentMapping" value="" />
        <input type="hidden" name="currentColumnMapping" id="currentColumnMapping" value="" />

        <input type="hidden" name="activeMapping" id="activeMapping" runat="server" />
        <input type="hidden" name="activeMappingID" id="activeMappingID" runat="server" />
        <input type="hidden" name="jobName" id="jobName" runat="server" />        
        <dw:RibbonBar runat="server" ID="doMappingBar">
            <dw:RibbonBarTab runat="server" ID="doMappingBarTab" Name="Activity">
                <dw:RibbonBarGroup runat="server" ID="doMappingSaveGroup" Name="Tools">
                    <dw:RibbonBarButton runat="server" ID="Save" Size="Small" Image="Save" Text="Save" OnClientClick="save();" />
                    <dw:RibbonBarButton runat="server" ID="SaveAndClose" Size="Small" Image="SaveAndClose" Text="Save and close" OnClientClick="saveAndClose();" />
                    <dw:RibbonBarButton runat="server" ID="Cancel" Size="Small" Image="Cancel" Text="Cancel" OnClientClick="cancel();" ShowWait="true" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="SaveAndRun" Name="Run">
                    <dw:RibbonBarButton runat="server" ID="SaveAndRunButton" Size="Large" ImagePath="/Admin/Module/IntegrationV2/img/run_activity.png" Text="Save and run" OnClientClick="stopConfirmation();var runIt= confirm('Run activity?');if (runIt){ var o = new overlay('forward');o.show(); SaveAndRun();} else return false;" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="doMappingEditGroup" Name="Mapping">
                    <dw:RibbonBarButton runat="server" ID="addTableMapping" Size="Small" ImagePath="/Admin/Module/IntegrationV2/img/table_mapping_new_small.png" Text="Add table mapping" OnClientClick="addTableMapping()" ShowWait="true" />
                    <dw:RibbonBarButton runat="server" ID="tableAddColumnMapping" Size="Small" Text="Add column mapping to current table" OnClientClick="tableAddColumnMapping()" ImagePath="img/column_mapping_add_small.png" />
                    <dw:RibbonBarButton runat="server" ID="tableRemoveColumnMapping" Size="Small" Text="Remove unselected column mapping" OnClientClick="tableRemoveColumnMapping()" ImagePath="img/column_mapping_delete_small.png" />                    
                    <dw:RibbonBarButton runat="server" ID="createMappingAtRuntime" Size="Small" Text="Create mappings at runtime" OnClientClick="stopConfirmation();$('action').value='createMappingAtRuntime';$('form1').submit();stopConfirmation();" Image="DocumentNotebook" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="doMappingEditTable" Name="Tables">
                    <dw:RibbonBarButton runat="server" ID="addDestinationTable" Size="Small" ImagePath="/Admin/Module/IntegrationV2/img/destination_table_new_small.png" Text="Add new destination table" OnClientClick="stopConfirmation();dialog.show('addTableDialog')" ShowWait="false" />
                    <dw:RibbonBarButton runat="server" ID="addColumnToDestinationTable" Size="Small" Text="Add column to current destination table" OnClientClick="addColumnMapping()" ImagePath="img/destination_column_add_small.png" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="doMappingEditSourceDestination" Name="Settings">
                    <dw:RibbonBarButton runat="server" ID="editSourceSettings" Size="Small" ImagePath="/Admin/Module/IntegrationV2/img/source_settings_small.png" Text="Edit source settings" OnClientClick="stopConfirmation();sourceEditPopup_wnd.show()" />
                    <dw:RibbonBarButton runat="server" ID="editDestinationSettings" Size="Small" ImagePath="/Admin/Module/IntegrationV2/img/destination_settings_small.png" Text="Edit destination settings" OnClientClick="stopConfirmation();destinationEditPopup_wnd.show()" />
                    <dw:RibbonBarButton runat="server" ID="editNotificationSettings" Size="Small" ImagePath="/Admin/Module/IntegrationV2/img/notification_settings_small.png" Text="Edit notification settings" OnClientClick="stopConfirmation();notificationSettings_wnd.show()" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="validateSchemaGroup" Name="Settings xml file" Visible="false">
                    <dw:RibbonBarButton runat="server" ID="validateSchema" Size="Large" Text="Check tables schema" Image="Check" OnClientClick="showErrorsDialog();/*stopConfirmation();$('action').value='checkErrorsInSettingsXmlFile';$('form1').submit();*/" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="activitylog" Name="Log">
                    <dw:RibbonBarButton runat="server" ID="showHistoryLog" Size="Large" Text="Log" Image="Information" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="doMappingHelp" Name="Help">
                    <dw:RibbonBarButton runat="server" ID="help" Size="Large" Image="Help" Text="Help" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <dw:Infobar ID="InfoDiv" TranslateMessage="true" Message="This job is set to do mappings automatically at runtime." Title="This job is set to do mappings automatically at runtime." runat="server" />        
        <div id="jobNameTitleDiv" class="jobname" runat="server">
        </div>        
        <div>
            <dw:GroupBox runat="server" Title="Table">
                <div id="jobContainerDivSizeLimiter" style="height: 200px; margin-left: 10px; margin-right: 10px; margin-bottom: 3px; background-color: White;">
                    <div style="width: 100%; padding-bottom: 3px; margin-bottom: 0px;">
                        <div class="SourceHeadingTable">
                            Source table</div>
                        <div class="DestinationHeadingTable">
                            Destination table
                        </div>
                    </div>
                    <dw:StretchedContainer Anchor="jobContainerDivSizeLimiter" ID="jobContainerDiv" runat="server" Scroll="VerticalOnly" Stretch="Fill" />
                </div>
            </dw:GroupBox>
            <br />
            <fieldset style='margin: 5px;' class="columnMappingGroupBox" id="testNameDivSizeLimiter">
                <legend class='gbTitle'>Data column mapping&nbsp;</legend>
                <div style="width: 100%; padding-bottom: 3px;">
                    <div class="checkAllDiv">
                        <input type="checkbox" id="checkAllCheckbox" onclick="toggleActiveSelection()" /></div>
                    <div class="SourceHeading">
                        Source column</div>
                    <div class="DestinationHeading">
                        Destination column</div>
                </div>
                <div style="clear: both;">
                </div>
                <br />
                <dw:StretchedContainer Anchor="testNameDivSizeLimiter" ID="testName" runat="server" Scroll="VerticalOnly" />
            </fieldset>
        </div>
        <dw:Dialog runat="server" ID="addTableDialog" ShowOkButton="true" ShowCancelButton="true" Width="390" Title="New destination table" OkAction="stopConfirmation();$('action').value='createNewDestinationTable';$('form1').submit();">
            <div style="float: left; width: 100px">
                Table name</div>
            <div style="float: left;">
                <input type="text" name="newTableName" class="NewUIinput" id="newTableName" runat="server" /></div>
        </dw:Dialog>
        <dw:Dialog runat="server" ID="addColumnDialog" ShowOkButton="true" ShowCancelButton="true" Width="390" Title="New destination column" OkAction="stopConfirmation();$('action').value='createNewDestinationColumn';$('form1').submit();">
            <div style="float: left; width: 100px">
                Column name
            </div>
            <div style="float: left;">
                <input type="text" name="newColumnName" class="NewUIinput" id="newColumnName" runat="server" /></div>
        </dw:Dialog>
        <dw:Dialog runat="server" ID="editScripting" ShowOkButton="true" ShowCancelButton="true" Title="Scripting" OkAction="stopConfirmation();$('action').value='editScripting';$('form1').submit();">
            <select runat="server" id="scriptType" name="scriptType">
                <option value="none">None</option>
                <option value="append">Append</option>
                <option value="prepend">Prepend</option>
                <option value="constant">Constant</option>
            </select>
            <input type="text" id="scriptValue" class="NewUIinput" name="scriptValue" />
        </dw:Dialog>
        <dw:Dialog runat="server" ID="editConditionals" ShowOkButton="true" ShowCancelButton="true" Title="Edit conditionals" Width="600" OkAction="stopConfirmation();$('action').value='editConditionals';$('form1').submit();">
            <div id="editConditionalsDiv" name="editConditionalsDiv">
            </div>
        </dw:Dialog>
        <dw:Dialog runat="server" ID="addConditional" ShowOkButton="true" ShowCancelButton="true" Title="Add conditionals" Width="600" OkAction="stopConfirmation();$('action').value='addConditional';$('form1').submit();">
            <select runat="server" id="addConditionalColumn" name="addConditionalColumn">
            </select>
            <select runat="server" id="addConditionalOperator">
                <option value="EqualTo">=</option>
                <option value="LessThan">&lt;</option>
                <option value="GreaterThan">&gt;</option>
                <option value="DifferentFrom">&lt;&gt;</option>
                <option value="Contains">Contains</option>
            </select>
            <input type="text" id="addCondition" class="NewUIinput" name="addCondition" />
        </dw:Dialog>
        <dw:Dialog  runat="server" ID="selectKeys" ShowOkButton="true" ShowCancelButton="true" Title="Select key columns" Width="600" OkAction="stopConfirmation();$('action').value='setKeyColumn';$('form1').submit();">
            <div id="selectKeyColumns" name="selectKeyColumns" style="height:400px;overflow: auto; overflow-x: hidden;padding:30px;margin:10px 30px 10px 30px">
            </div>
        </dw:Dialog>
        <dw:Dialog runat="server" ID="editDestinationSettingsDialog" ShowOkButton="true" ShowCancelButton="true" Title="Edit source settings" Width="600">
        </dw:Dialog>
        <dw:Dialog runat="server" ID="showErrorsDlg" Width="600" IsModal="true" ShowClose="false" ShowOkButton="true" ShowCancelButton="true" Title="Errors found in job settings xml file" OkAction="stopConfirmation();$('action').value='fixErrorsInSettingsXmlFile';$('form1').submit();">
            <dw:List ID="errorList" runat="server" Title="Errors List" TranslateTitle="True" StretchContent="false" PageSize="25" ShowPaging="true" Height="400">
                <Columns>
                    <dw:ListColumn ID="Source" EnableSorting="false" runat="server" Name="Source" Width="30"></dw:ListColumn>
                    <dw:ListColumn ID="ErrorType" EnableSorting="true" runat="server" Name="Error Type" Width="30"></dw:ListColumn>
                    <dw:ListColumn ID="Tables" runat="server" Name="Tables/Columns"></dw:ListColumn>
                </Columns>
            </dw:List>
            <dw:TranslateLabel ID="lblMappingErrorText" Text="Mapping errors should be fixed manually." runat="server" />
            <br />
            <dw:TranslateLabel ID="lblConfirmText" Text="Click OK to use the current schema for source and destination" runat="server" />
        </dw:Dialog>
        <dw:Dialog runat="server" ID="editTableScripting" ShowOkButton="true" ShowCancelButton="true" Title="Select table scripting" OkAction="stopConfirmation();$('action').value='editTableScripting';$('form1').submit();">            
            <div id="editTableScriptingDiv">
            </div>
        </dw:Dialog>
        <dw:PopUpWindow ID="historyLogPopup" AutoReload="true" Width="800" Height="560" ShowCancelButton="false" ShowOkButton="false" ShowClose="True" Title="Job log" runat="server" IsModal="True" AutoCenterProgress="True" />
        <dw:PopUpWindow ID="sourceEditPopup" ContentUrl="/Admin/Module/IntegrationV2/editSource.aspx" AutoReload="true" Title="Edit source settings" ShowClose="true" ShowOkButton="false" Width="500" ShowCancelButton="false" runat="server" HidePadding="true" />
        <dw:PopUpWindow ID="destinationEditPopup" ContentUrl="/Admin/Module/IntegrationV2/editDestination.aspx" AutoReload="true" Title="Edit destination settings" ShowClose="true" ShowOkButton="false" Width="500" ShowCancelButton="false" runat="server" HidePadding="true" />
        <dw:PopUpWindow ID="notificationSettings" ContentUrl="/Admin/Module/IntegrationV2/NotificationSettings.aspx" AutoReload="true" Title="Edit notification settings" ShowClose="true" ShowOkButton="false" Width="600" Height="300" ShowCancelButton="false" runat="server" HidePadding="true" />
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
