<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewIndex.aspx.vb" Inherits="Dynamicweb.Admin.Repositories.ViewIndex" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="rp" TagName="Infobar" Src="~/Admin/Module/Repositories/Controls/Infobar.ascx" %>

<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" ng-app="app">
<head runat="server">
    <title></title>
    <dw:ControlResources IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Repositories/Styles/Repository.css" />
</head>
<body>

    <script type="text/javascript" src="/Admin/Content/jsLib/Angular/angular.min.js"></script>

    <script type="text/javascript">
        var repositoryclean = '<%=Request("Repository")%>';
        var repository = '<%=Request("Repository").Replace(".","-")%>';
        var item = '<%=Request("Item").Replace(".","-")%>';
        var defaultInstanceType = '<%=DefaultInstanceType%>';
        var defaultBuildType = '<%=DefaultBuildType%>';
        var app = angular.module('app', []);
        app.location = [{}];

        var _messages = {
            foundDuplicateNames: '<%=Translate.JsTranslate("Found duplicate settings names")%>',
            saveIndexBeforeBuild: '<%=Translate.JsTranslate("Please save the Index before build")%>'
        };
    </script>

    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/IndexRepository.js"></script>
    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/IndexController.js"></script>
    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/Filters.js"></script>


    <form id="MainForm" runat="server" ng-submit="setIndex()" ng-controller="indexController" ng-cloak style="margin: 0px">
        <!-- RIBBON-->
        <div style="min-width: 1000px; overflow: hidden;">
            <dw:RibbonBar runat="server" ID="myribbon">
                <dw:RibbonBarTab Active="true" Name="Index" runat="server">
                    <dw:RibbonBarGroup runat="server" ID="grpTools" Name="Funktioner">
                        <dw:RibbonBarButton runat="server" Text="Save" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave" NgClick="setIndex();" ShowWait="true" WaitTimeout="500"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Save and close" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose" NgClick="setIndexAndExit()" ShowWait="true" WaitTimeout="500"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Cancel" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id='+repositoryclean" ShowWait="false" WaitTimeout="500">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="RibbonbarGroup3" Name="Index">
                        <dw:RibbonBarButton runat="server" Text="Add instance" Size="Small" Image="AddDocument" ID="RibbonbarButton3" NgClick="openInstanceDialog(null);"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Add build" Size="Small" Image="AddDocument" ID="RibbonbarButton6" NgClick="openBuildDialog(null);"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="RibbonbarGroup4" Name="Fields">
                        <dw:RibbonBarButton runat="server" Text="Add field" Size="Small" Image="AddDocument" ID="RibbonbarButton2" NgClick="newFieldDialog(null);"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Add field type" Size="Small" Image="AddDocument" ID="RibbonbarButton4" NgClick="newFieldTypeDialog(null);"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Help">
                        <dw:RibbonBarButton ID="RibbonbarButton1" runat="server" Size="Large" Text="Help" Image="Help" OnClientClick="window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=administration.managementcenter.Repositories.Index&LanguageID=en', 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes,scrollbars=yes');"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>
        </div>

        <!-- BREADCRUMB -->
        <div id="breadcrumb">
            »
                <a href="/admin/content/management/Start.aspx"><%=Translate.Translate("Management")%></a> »
                <a href="#"><%=Translate.Translate("Repositories")%></a> »
                <a href="/Admin/Module/Repositories/ViewRepository.aspx?id=<%=Request("Repository")%>"><%=Request("Repository")%></a> »
                <a href="#"><b><%=Request("Item")%></b></a>
        </div>

        <!-- CONTENT -->
        <div class="list" ng-if="!preview">

            <ul>
                <li class="header">
                    <span class="pipe"></span><span class="C0" style="width: 90%; padding-left: 5px;"></span>
                </li>
            </ul>

            <div id="_contentWrapper" style="padding: 5px; padding-right: 20%">


                <dw:GroupBox ID="GroupBox1" runat="server" Title="Instances" DoTranslation="true">
                    <div ng-if="getNumberOfInstances() == 0">
                        <%=Translate.Translate("No instances")%>
                    </div>

                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1); border-bottom: none; margin: 3px;" ng-if="getNumberOfInstances() &gt; 0">

                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C2"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Status")%></span>
                                <span class="pipe"></span><span class="C1" style="width: 110px;"><%=Translate.Translate("Current")%></span>
                                <span class="pipe"></span><span class="C1" style="width: 100px;"><%=Translate.Translate("Start time")%></span>
                                <span class="pipe"></span><span class="C1" style="width: 100px;"><%=Translate.Translate("End time")%></span>
                                <span class="pipe"></span><span class="C1" style="width: 115px;"><%=Translate.Translate("Run time")%></span>
                                <span class="pipe"></span><span class="C1" style="width: 100px;"><%=Translate.Translate("Actions")%></span>
                                <span class="pipe"></span><span class="C4"><%=Translate.Translate("Messages")%></span>
                            </li>
                        </ul>

                        <ul id="items" style="position: relative; min-height: 25px;">
                            <li class="item-field" style="position: relative; height: 30px; padding-top: 1px;" ng-repeat="(name, value) in index.Instances">
                                <span class="C0" style="padding-top: 5px;">
                                    <%--<input type="radio" disabled="disabled"/>--%>
                                </span>
                                <span class="C1" style="padding-top: 7px;"><a ng-click="openInstanceDialog(name);" href="javascript:void(0);"><span class="inner field-name"><b>{{name}}</b></span></a></span>
                                <span class="C2">
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);" ng-repeat="info in [status[name]]">

                                        <!-- NEVER BUILT -->
                                        <div ng-if="!info.Status">
                                            <progress class="state-never progress" ng-value="0" max="100"></progress>
                                            <span class="state-text-never progress-text"><%=Translate.Translate("Never built")%></span>
                                        </div>

                                        <!-- BUILD COMPLETED -->
                                        <div ng-if="info.Status && info.Status.State == 0">
                                            <progress class="state-completed progress" ng-value="info.Status.CurrentCount+1" max="{{info.Status.TotalCount}}"></progress>
                                            <span class="state-text-completed progress-text"><%=Translate.Translate("Completed")%></span>
                                        </div>

                                        <!-- BUILD FAILED -->
                                        <div ng-if="info.Status && info.Status.State == 1">
                                            <progress class="state-failed progress" ng-value="info.Status.CurrentCount+1" max="{{info.Status.TotalCount}}"></progress>
                                            <span class="state-text-failed progress-text"><%=Translate.Translate("Failed")%></span>
                                        </div>

                                        <!-- BUILD FIRST -->
                                        <div ng-if="info.Status && info.Status.State == 2 && (!info.LastStatus)">
                                            <progress class="state-running-first progress" ng-value="info.Status.CurrentCount+1" max="{{info.Status.TotalCount}}"></progress>
                                            <span class="state-text-running-first progress-text">{{100* info.Status.CurrentCount / info.Status.TotalCount | number:2}}%</span>
                                        </div>

                                        <!-- BUILD FORM COMPLETED -->
                                        <div ng-if="info.Status && info.Status.State == 2 && info.LastStatus && info.LastStatus.State == 0">
                                            <progress class="state-running-from-completed progress" ng-value="info.Status.CurrentCount+1" max="{{info.Status.TotalCount}}"></progress>
                                            <span class="state-text-running-from-completed progress-text">{{100* info.Status.CurrentCount / info.Status.TotalCount | number:2}}%</span>
                                        </div>

                                        <!-- BUILD FORM FAILED -->
                                        <div ng-if="info.Status && info.Status.State == 2 && info.LastStatus.State && info.LastStatus.State == 1">
                                            <progress class="state-running-from-failed progress" ng-value="info.Status.CurrentCount+1" max="{{info.Status.TotalCount}}"></progress>
                                            <span class="state-text-running-from-failed progress-text">{{100* info.Status.CurrentCount / info.Status.TotalCount | number:2}}%</span>
                                        </div>
                                    </a>
                                </span>
                                <span class="C1" style="padding-top: 7px; width: 110px;" ng-repeat-start="info in [status[name]]">
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);">
                                        <span class="inner field-name" ng-if="info.Status.CurrentCount > 0">{{info.Status.CurrentCount | number}} / {{info.Status.TotalCount | number}}</span>
                                    </a>
                                </span>
                                <span class="C1" style="padding-top: 7px; width: 100px;">
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);"><span class="inner field-name">{{info.Status.StartTime | date : "<%=Dynamicweb.Dates.DateFormatStringShort%>"}}</span></a>
                                </span>
                                <span class="C1" style="padding-top: 7px; width: 100px;" ng-if="info.Status.EndTime > info.Status.StartTime">
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);"><span class="inner field-name">{{info.Status.EndTime | date : "<%=Dynamicweb.Dates.DateFormatStringShort%>"}}</span></a>
                                </span>
                                <span class="C1" style="padding-top: 7px; width: 100px;" ng-if="info.Status.EndTime <= info.Status.StartTime"></span>
                                <span class="C1" style="padding-top: 7px; width: 115px;" ng-repeat-end>
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);"><span class="inner field-name">{{info.Status.RunTime | timespan : '<%=Translate.Translate("hours")%>' : '<%=Translate.Translate("minutes")%>' : '<%=Translate.Translate("seconds")%>'}}</span></a>
                                </span>
                                <span class="C2" style="width: 100px;">
                                    <button ng-if="!status[name].IsActive && status[name].Status && status[name].Status.State == 1 && status[name].Resumable" ng-click="resumeIndex(name, status[name].Status.Meta)">&nbsp;Resume&nbsp;</button>
                                </span>
                                <span class="C1" style="padding-top: 4px; width: 250px;">
                                    <a ng-click="openInstanceDialog(name);" href="javascript:void(0);">
                                        <span class="inner field-name" ng-if="status[name].Status && status[name].Status.State == 2">{{status[name].Status.LatestLogInformation}}
                                        </span>
                                        <span class="inner field-name" ng-if="status[name].Status && status[name].Status.State == 1">
                                            <span style="cursor: pointer; color: red" title="{{status[name].Status.FailExceptionStackTrace}}">{{status[name].Status.FailExceptionMessage}}</span>
                                        </span>
                                    </a>
                                </span>

                                <span class="C4" style="float: right; padding-top: 0px;"><a href="javascript:void();" ng-click="deleteInstance(name);">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>

                            </li>
                        </ul>
                    </div>

                </dw:GroupBox>

                <!-- BUILDS -->
                <dw:GroupBox ID="GroupBox7" runat="server" Title="Builds" DoTranslation="true">
                    <div ng-if="getNumberOfBuilds() == 0">
                        <%=Translate.Translate("No builds")%>
                    </div>

                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1); border-bottom: none; margin: 3px;" ng-if="getNumberOfBuilds() &gt 0">

                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C2" style="width: 450px;"><%=Translate.Translate("Builder")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Build")%></span>
                            </li>
                        </ul>

                        <ul id="items" style="position: relative;">
                            <li class="item-field" style="position: relative;" ng-repeat="build in index.Builds">
                                <span class="C0"><a ng-click="openBuildDialog(build.Name);" href="javascript:void(0);">
                                    <img alt="" src="/Admin/Images/Ribbon/Icons/Small/document.png"></a></span>
                                <span class="C1"><a ng-click="openBuildDialog(build.Name);" href="javascript:void(0);"><span class="inner field-name"><b>{{build.Name}}</b></span></a></span>
                                <span class="C2" style="width: 450px;"><a ng-click="openBuildDialog(build.Name);" href="javascript:void(0);"><span class="inner field-name">{{build.Type}}</span></a></span>
                                <span class="C3"><span class="inner field-name">
                                    <input type="button" class="newUIbutton btn-build" ng-repeat="instance in index.Instances" ng-disabled="status[instance.Name].IsActive" ng-click="buildIndex(instance.Name, build.Name)" value="{{instance.Name}}" /></span></span>
                                <span class="C4" style="float: right"><a href="javascript:void(0);" ng-click="deleteBuild(build.Name);">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                            </li>
                        </ul>
                    </div>

                </dw:GroupBox>

                <!-- FIELDS -->
                <dw:GroupBox ID="GroupBox8" runat="server" Title="Fields" DoTranslation="true">
                    <div ng-if="!index.Schema.FieldsFromIndexDefinition || index.Schema.FieldsFromIndexDefinition.length &lt; 1">
                        <%=Translate.Translate("No fields")%>
                    </div>

                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1); border-bottom: none; margin: 3px;" ng-if="index.Schema.FieldsFromIndexDefinition.length &gt; 0">

                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C2"><%=Translate.Translate("System Name")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Source")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Type")%></span>
                                <span class="pipe"></span><span class="C4" style="float: right;">
                                    <a href="" ng-click="toggleFields()" ng-show="hasExtensionFieldDefinition()">
                                        <img ng-if="!expandFields" src="/Admin/Images/Ribbon/UI/Tree/img/nolines_plus.gif" alt="" />
                                        <img ng-if="expandFields" src="/Admin/Images/Ribbon/UI/Tree/img/nolines_minus.gif" alt="" />
                                    </a></span>
                            </li>
                        </ul>


                        <ul style="position: relative;" ng-if="expandFields">
                            <li class="item-field" style="position: relative;" ng-repeat="field in index.Schema.Fields">
                                <span class="C0"><a href="javascript:void(0);">
                                    <img alt="" src="/Admin/Images/Repository/Field.png"></a></span>
                                <span class="C1">{{field.Name}}</span>
                                <span class="C2">{{field.SystemName}}</span>
                                <span class="C3" ng-if="field.Source">{{field.Source}}</span>
                                <span class="C3" ng-if="field.Sources">{{field.Sources}}</span>
                                <span class="C3">{{field.Type}}</span>
                            </li>
                        </ul>
                        <ul style="position: relative;" ng-if="!expandFields">
                            <li class="item-field" style="position: relative;" ng-repeat="field in index.Schema.FieldsFromIndexDefinition">

                                <div ng-if="field.class == 'FieldDefinition'">
                                    <span ng-click="openFieldDialog(field);" class="C0" style="cursor: pointer;">
                                        <img alt="" src="/Admin/Images/Repository/Field.png"></span>
                                    <span ng-click="openFieldDialog(field);" class="C1" style="cursor: pointer;">{{field.Name}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C2" style="cursor: pointer;">{{field.SystemName}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Source}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Type}}</span>
                                    <span class="C4" style="float: right; cursor: pointer;"><a href="javascript:void(0);" ng-click="removeField($index)">
                                        <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                                </div>

                                <div ng-if="field.class == 'ExtensionFieldDefinition'">
                                    <span class="C0" ng-click="openFieldDialog(field);" style="cursor: pointer;">
                                        <img alt="" src="/Admin/Images/Repository/Field.png"></span>
                                    <span class="C1" ng-click="openFieldDialog(field);" style="width: 80%; padding: 0px; background-color: #f2fbff; margin-top: 3px; border: 1px dotted silver; cursor: pointer;">&nbsp; <b><%=Translate.Translate("Schema extender")%>:</b> {{field.Type}}</span>
                                    <span class="C4" style="float: right; cursor: pointer;"><a href="javascript:void(0);" ng-click="removeField($index)">
                                        <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                                </div>

                                <div ng-if="field.class == 'CopyFieldDefinition'">
                                    <span ng-click="openFieldDialog(field);" class="C0" style="cursor: pointer;">
                                        <img alt="" src="/Admin/Images/Repository/Field.png"></span>
                                    <span ng-click="openFieldDialog(field);" class="C1" style="cursor: pointer;">{{field.Name}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C2" style="cursor: pointer;">{{field.SystemName}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Sources}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Type}}</span>
                                    <span class="C4" style="float: right; cursor: pointer;"><a href="javascript:void(0);" ng-click="removeField($index)">
                                        <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                                </div>

                                <div ng-if="field.class == 'GroupingFieldDefinition'">
                                    <span ng-click="openFieldDialog(field);" class="C0" style="cursor: pointer;">
                                        <img alt="" src="/Admin/Images/Repository/Field.png"></span>
                                    <span ng-click="openFieldDialog(field);" class="C1" style="cursor: pointer;">{{field.Name}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C2" style="cursor: pointer;">{{field.SystemName}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Sources}}</span>
                                    <span ng-click="openFieldDialog(field);" class="C3" style="cursor: pointer;">{{field.Type}}</span>
                                    <span class="C4" style="float: right; cursor: pointer;"><a href="javascript:void(0);" ng-click="removeField($index)">
                                        <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                                </div>

                            </li>
                        </ul>
                    </div>
                </dw:GroupBox>

                <!-- FIELD TYPES -->
                <dw:GroupBox ID="GroupBox12" runat="server" Title="Field types" DoTranslation="true">
                    <div ng-if="!index.Schema.FieldTypes || index.Schema.FieldTypes.length &lt; 1">
                        <%=Translate.Translate("No field types")%>
                    </div>

                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1); border-bottom: none; margin: 3px;" ng-if="index.Schema.FieldTypes.length &gt; 0">
                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Type")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative;">
                            <li class="item-field" style="position: relative;" ng-repeat="fieldType in index.Schema.FieldTypes">
                                <span ng-click="openFieldTypeDialog(fieldType);" class="C0"><a href="javascript:void(0);">
                                    <img alt="" src="/Admin/Images/Repository/FieldType_16.png" /></a></span>
                                <span ng-click="openFieldTypeDialog(fieldType);" class="C1">{{fieldType.Name}}</span>
                                <span ng-click="openFieldTypeDialog(fieldType);" class="C3">{{fieldType.Type}}</span>
                                <span class="C4" style="float: right; cursor: pointer;"><a href="javascript:void(0);" ng-click="removeFieldType($index)">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif" /></a></span>
                            </li>
                        </ul>
                    </div>
                </dw:GroupBox>

            </div>

        </div>

        <dw:Dialog ID="dlgInstance" Title="Instance" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okInstanceDialog').click();" runat="server">
            <button style="display: none;" id="okInstanceDialog" type="button" ng-click="saveInstanceDialog();">OK</button>

            <dw:GroupBox ID="GroupBox2" runat="server" Title="Settings">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <dw:TranslateLabel Text="Name" runat="server" />
                        </td>
                        <td>
                            <input name="dlgInstanceName" ng-readonly="draftInstance.originalName != 'new'" ng-model="draftInstance.Name" type="text" id="dlgInstanceName" class="std" />
                        </td>
                    </tr>
                    <tr>
                        <td class="left-label">
                            <dw:TranslateLabel Text="Select provider" runat="server" />
                        </td>
                        <td>
                            <ul class="unstyled">
                                <li ng-model="draftInstance.Type" ng-repeat="instanceType in instanceTypes">
                                    <label>
                                        <input type="radio"
                                            ng-model="draftInstance.Type"
                                            ng-value="instanceType.FullName"
                                            id="{{instanceType.Name}}"
                                            name="{{instanceType.Name}}"
                                            ng-change="draftInstance.Settings ={}">
                                        {{instanceType.Name}}
                                    </label>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <span ng-if="draftInstance.Type == 'Dynamicweb.Indexing.Lucene.LuceneIndexProvider, Dynamicweb.Indexing.Lucene'">
                <dw:GroupBox ID="grpLucene" Title="Lucene settings" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    Folder
                                </label>
                            </td>
                            <td>
                                <input name="dlgInstanceName" ng-model="draftInstance.Settings.Folder" type="text" id="dlgInstanceName" class="std" />
                                <div class="view-index-root-folder">{{getLuceneIndexRootFolder()}}</div>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </span>

            <span ng-if="draftInstance.Type == 'Dynamicweb.Indexing.Solr.SolrIndexProvider, Dynamicweb.Indexing.Solr'">
                <dw:GroupBox runat="server" Title="Solr">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <%=Translate.Translate("Url")%>
                                </label>
                            </td>
                            <td>
                                <input name="dlgBuildName" ng-model="draftInstance.Settings.Url" type="text" id="dlgBuildName" class="std" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <%=Translate.Translate("Username")%>
                                </label>
                            </td>
                            <td>
                                <input name="dlgBuildName" ng-model="draftInstance.Settings.Username" type="text" id="dlgBuildName" class="std" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <%=Translate.Translate("Password")%>
                                </label>
                            </td>
                            <td>
                                <input name="dlgBuildName" ng-model="draftInstance.Settings.Password" type="text" id="dlgBuildName" class="std" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </span>
        </dw:Dialog>

        <dw:Dialog ID="dlgBuild" Title="Build" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okBuildDialog').click();" runat="server">
            <button style="display: none;" id="okBuildDialog" type="button" class="dialog-button-ok" ng-click="saveBuildDialog();">OK</button>

            <dw:GroupBox ID="GroupBox9" runat="server" Title="Generelt">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <label>
                                <%=Translate.Translate("Name")%>
                            </label>
                        </td>
                        <td>
                            <input name="dlgBuildName" ng-model="draftBuild.Name" type="text" id="dlgBuildName" class="std" />
                        </td>
                    </tr>
                    <tr>
                        <td class="left-label">
                            <%=Translate.Translate("Builder")%>
                        </td>
                        <td>
                            <select class="std" name="ddlBuildType" ng-model="draftBuild.Type" ng-change="changeBuildType()" ng-options="buildType.FullName as buildType.Name for buildType in buildTypes" ng-disabled="getNumberOfBuilds() &gt; 0"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="left-label">
                            <%=Translate.Translate("Builder action")%>
                        </td>
                        <td>
                            <select class="std" name="ddlBuildAction" ng-model="draftBuild.Action" ng-options="buildAction for buildAction in buildActions[draftBuild.Type]"></select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>


            <span ng-if="draftBuild.Type == 'Dynamicweb.Indexing.Builders.SqlIndexBuilder, Dynamicweb.Indexing'">
                <dw:GroupBox runat="server" Title="Connection settings">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <%=Translate.Translate("Connection String")%>
                                </label>
                            </td>
                            <td>
                                <input ng-model="draftBuild.Settings.Connection" type="text" class="std" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>

                <dw:GroupBox runat="server" Title="Query">
                    <table border="0">
                        <tr>
                            <td>
                                <textarea name="dlgBuildName" ng-model="draftBuild.Settings.Query" type="text" class="std name" style="width: 100%; height: 80px;" onkeyup=""></textarea>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>

                <dw:GroupBox runat="server" Title="Query to get count">
                    <table border="0">
                        <tr>
                            <td>
                                <textarea name="dlgBuildName" ng-model="draftBuild.Settings.CountQuery" type="text" class="std name" style="width: 100%; height: 80px;" onkeyup=""></textarea>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </span>

            <div ng-show="draftBuild.Type != 'Dynamicweb.Indexing.Builders.SqlIndexBuilder, Dynamicweb.Indexing'">
                <dw:GroupBox ID="GroupBox4" runat="server" Title="Settings">
                    <div class="list">
                        <div id="items" style="background-color: white; border: 1px solid rgba(188, 203, 223, 1); height: 200px; overflow-x: hidden;">
                            <ul style="min-width: initial !important;">
                                <li class="header" style="min-width: initial !important;">
                                    <span class="pipe"></span>
                                    <span class="C1"><%=Translate.Translate("Name")%></span>
                                    <span class="pipe"></span>
                                    <span class="C2"><%=Translate.Translate("Value")%></span>
                                </li>
                            </ul>
                            <ul style="position: relative; min-width: initial !important;">
                                <li class="item-field" style="position: relative; min-width: initial !important;" ng-repeat="setting in draftBuild.settingsArr track by $index">
                                    <span class="C1">
                                        <input type="text" style="border: 0; font-size: 9pt" ng-model="setting.name" />
                                    </span>
                                    <span class="C2">
                                        <input type="text" style="border: 0; font-size: 9pt" ng-model="setting.value" />
                                    </span>
                                    <span style="float: right;"><a href="javascript:void(0);" ng-click="removeSettingFromBuild(draftBuild, $index)">
                                        <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                                </li>
                            </ul>
                        </div>
                        <input type="button" class="newUIbutton" style="margin: 2px" ng-click="addSettingToBuild(draftBuild);" value="<%=Translate.Translate("Add")%>" />
                    </div>
                </dw:GroupBox>
            </div>
        </dw:Dialog>

        <dw:Dialog ID="FieldDialog" Title="Field" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okFieldDialog').click();" runat="server">
            <button style="display: none;" id="okFieldDialog" type="button" class="dialog-button-ok" ng-click="saveFieldDialog();">OK</button>

            <dw:GroupBox ID="GroupBox10" runat="server" Title="Generelt">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <dw:TranslateLabel Text="Field type" runat="server" />
                        </td>
                        <td>
                            <select class="std" ng-model="draftField.class">
                                <option value="FieldDefinition"><%=Translate.Translate("Field")%></option>
                                <option value="CopyFieldDefinition"><%=Translate.Translate("Summary field")%></option>
                                <option value="ExtensionFieldDefinition"><%=Translate.Translate("Schema extender")%></option>
                                <option value="GroupingFieldDefinition"><%=Translate.Translate("Grouping")%></option>
                            </select>
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label">
                            <%=Translate.Translate("Name")%>
                        </td>
                        <td>
                            <input ng-model="draftField.Name" type="text" class="std" />
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label">
                            <%=Translate.Translate("System name")%>
                        </td>
                        <td>
                            <input ng-model="draftField.SystemName" type="text" class="std" />
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label">
                            <%=Translate.Translate("Source")%>
                        </td>
                        <td>
                            <select class="std" name="ddlBuildAction" ng-model="draftField.Source" ng-options="fieldSource for fieldSource in fieldSources"></select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <dw:GroupBox ID="GroupBox11" runat="server" Title="Settings">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <span ng-if="draftField.class != 'CopyFieldDefinition'">
                                <%=Translate.Translate("Type")%>
                            </span>
                        </td>
                        <td>
                            <select class="std" ng-model="draftField.Type" ng-options="type.name as type.name group by type.groupName for type in types" ng-if="hasUserDefinedFieldTypes && (draftField.class == 'FieldDefinition' || draftField.class == 'GroupingFieldDefinition')">
                            </select>

                            <select class="std" ng-model="draftField.Type" ng-options="type.name as type.name for type in types" ng-if="!hasUserDefinedFieldTypes && (draftField.class == 'FieldDefinition' || draftField.class == 'GroupingFieldDefinition')">
                            </select>

                            <select class="std" ng-model="draftField.Type" ng-if="draftField.class == 'ExtensionFieldDefinition'" ng-options="extensionType.FullName as extensionType.Name for extensionType in extensionTypes">
                            </select>
                        </td>
                    </tr>

                    <%--
                        <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition'">
                            <td class="left-label">
                                <%=Translate.Translate("Analyzer")%>
                            </td>
                            <td>
                                <input ng-model="draftField.Analyzer" type="text" class="std" />
                            </td>
                        </tr>
                    --%>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label">
                            <%=Translate.Translate("Boost")%>
                        </td>
                        <td>
                            <input ng-model="draftField.Boost" type="text" class="std" />
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label"></td>
                        <td align="left">
                            <input type="checkbox" ng-model="draftField.Stored" onkeyup="" />
                            <%=Translate.Translate("Stored")%>
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label"></td>
                        <td align="left">
                            <input type="checkbox" ng-model="draftField.Indexed" onkeyup="" />
                            <%=Translate.Translate("Indexed")%>
                        </td>
                    </tr>

                    <tr ng-if="draftField.class == 'FieldDefinition' || draftField.class == 'CopyFieldDefinition' || draftField.class == 'GroupingFieldDefinition'">
                        <td class="left-label"></td>
                        <td align="left">
                            <input type="checkbox" ng-model="draftField.Analyzed" onkeyup="" />
                            <%=Translate.Translate("Analyzed")%>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <span id="list" class="list" ng-if="draftField.class == 'CopyFieldDefinition'">
                <dw:GroupBox ID="GroupBox3" runat="server" Title="Sources">
                    <div id="items" style="background-color: white; border: 1px solid rgba(188, 203, 223, 1); height: 200px; overflow-x: hidden;">
                        <ul style="min-width: initial !important;">
                            <li class="header" style="min-width: initial !important;">
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Field")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative; min-width: initial !important;">
                            <li class="item-field" style="position: relative; min-width: initial !important;" ng-repeat="source in draftField.Sources track by $index">
                                <span class="C3" style="width: 250px;">
                                    <select style="width: 250px;" ng-model="draftField.Sources[$index]" class="std" ng-options="field.SystemName as field.Name for field in index.Schema.Fields">
                                    </select>
                                    <span ng-model="draftField.Sources[$index]"></span>
                                </span>
                                <span class="C3"></span>
                                <span class="C0"><a href="javascript:void(0);" ng-click="removeCopyFieldSource(draftField, $index)">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                            </li>
                        </ul>
                    </div>
                    <input type="button" class="newUIbutton" style="margin: 2px" ng-click="addFieldToCopyList(draftField);" value="<%=Translate.Translate("Add")%>" />
                </dw:GroupBox>
            </span>

            <div class="list" ng-if="draftField.class == 'GroupingFieldDefinition'">
                <dw:GroupBox ID="GroupBox5" runat="server" Title="Groups">
                    <div id="items" style="background-color: white; border: 1px solid rgba(188, 203, 223, 1); height: 200px; overflow-x: hidden;">
                        <ul style="min-width: initial !important;">
                            <li class="header" style="min-width: initial !important;">
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("From")%></span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("To")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative; min-width: initial !important;">
                            <li class="item-field" style="position: relative; min-width: initial !important;" ng-repeat="group in draftField.Groups track by $index">
                                <span class="C1">
                                    <input type="text" style="border: 0; font-size: 9pt" ng-model="group.Name" />
                                </span>
                                <span class="C1">
                                    <input type="text" style="border: 0; font-size: 9pt" ng-model="group.From" />
                                </span>
                                <span class="C1">
                                    <input type="text" style="border: 0; font-size: 9pt" ng-model="group.To" />
                                </span>
                                <span style="float: right;"><a href="javascript:void(0);" ng-click="removeGroupFromGrouping(draftField, $index)">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                            </li>
                        </ul>
                    </div>
                    <input type="button" class="newUIbutton" style="margin: 2px" ng-click="addGroupToGrouping(draftField);" value="<%=Translate.Translate("Add")%>" />
                </dw:GroupBox>
            </div>

            <div class="list" ng-if="draftField.class == 'ExtensionFieldDefinition'">
                <dw:GroupBox ID="GroupBox6" runat="server" Title="Excluded fields">
                    <div id="items" style="background-color: white; border: 1px solid rgba(188, 203, 223, 1); height: 200px; overflow-x: hidden;">
                        <ul style="min-width: initial !important;">
                            <li class="header" style="min-width: initial !important;">
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Name")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative; min-width: initial !important;">
                            <li class="item-field" style="position: relative; min-width: initial !important;" ng-repeat="excluded in draftField.ExcludedFields track by $index">
                                <span class="C3">
                                    <input type="text" style="border: 0; font-size: 9pt" ng-model="draftField.ExcludedFields[$index]" />
                                </span>
                                <span style="float: right;"><a href="javascript:void(0);" ng-click="removeExcludedField(draftField, $index)">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                            </li>
                        </ul>
                    </div>
                    <input type="button" class="newUIbutton" style="margin: 2px" ng-click="addExcludedField(draftField);" value="<%=Translate.Translate("Add")%>" />
                </dw:GroupBox>
            </div>
        </dw:Dialog>

        <dw:Dialog ID="FieldTypeDialog" Title="Field type" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okFieldTypeDialog').click();" runat="server">
            <button style="display: none;" id="okFieldTypeDialog" type="button" class="dialog-button-ok" ng-click="saveFieldTypeDialog();">OK</button>

            <dw:GroupBox ID="GroupBox13" runat="server" Title="Generelt">
                <table border="0">
                    <tr>
                        <td class="left-label">
                            <%=Translate.Translate("Name")%>
                        </td>
                        <td>
                            <input ng-model="draftFieldType.Name" type="text" class="std" />
                        </td>
                    </tr>
                    <tr>
                        <td class="left-label">
                            <%=Translate.Translate("Type")%>
                        </td>
                        <td>
                            <select class="std" ng-model="draftFieldType.Type" ng-options="type.name as type.name for type in types">
                            </select>
                        </td>
                    </tr>
                      <tr>
                        <td class="left-label">
                            <%=Translate.Translate("Boost")%>
                        </td>
                        <td>
                            <input ng-model="draftFieldType.Boost" type="text" class="std" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>

            <dw:GroupBox ID="GroupBox14" runat="server" Title="Analyzers">
                <div class="list">
                    <div id="items" style="background-color: white; border: 1px solid rgba(188, 203, 223, 1); height: 200px; overflow-x: hidden;">
                        <ul style="min-width: initial !important;">
                            <li class="header" style="min-width: initial !important;">
                                <span class="pipe"></span>
                                <span class="C4" style="width: 250px;"><%=Translate.Translate("Provider")%></span>
                                <span class="pipe"></span>
                                <span class="C4" style="width: 250px;"><%=Translate.Translate("Analyzer")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative; min-width: initial !important;">
                            <li class="item-field" style="position: relative; min-width: initial !important;" ng-repeat="analyzer in draftFieldType.Analyzers track by $index">
                                <span class="C4">
                                    <select class="std" ng-model="analyzer.key" ng-options="instanceType.FullName as instanceType.Name for instanceType in instanceTypes">
                                    </select>
                                </span>
                                <span class="C4">
                                    <select class="std" ng-model="analyzer.value" ng-options="analyzer.FullName as analyzer.Class for analyzer in analyzersDataSource(analyzer.key) | orderBy:'Class'">
                                    </select>
                                </span>
                                <span style="float: right;"><a href="javascript:void(0);" ng-click="removeAnalyzerFromFieldType(draftFieldType, $index)">
                                    <img src="/Admin/Images/Icons/Delete_vsmall.gif" /></a></span>
                            </li>
                        </ul>
                    </div>
                    <input type="button" class="newUIbutton" style="margin: 2px" ng-click="addAnalyzerToFieldType(draftFieldType);" value="<%=Translate.Translate("Add")%>" />
                </div>
            </dw:GroupBox>

        </dw:Dialog>

        <rp:Infobar runat="server" Model="index" Name="{{index.Name}}" Type="Index" Icon="/Admin/Images/Repository/index_32.png" FileName="{{index.FileName}}"></rp:Infobar>

    </form>

    <dw:Overlay ID="ItemTypeEditOverlay" runat="server"></dw:Overlay>

    <%Translate.GetEditOnlineScript()%>

    <!-- Controls resources start -->
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Dialog/Tabular/Dialog.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Dialog/PopUpWindow.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/OMC/css/AjaxRichControl.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Contextmenu/Contextmenu.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/Default.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/ItemTypeEdit.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/LanguageSelector.css" />

    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Utilities.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/Ribbon.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/Overlay/Overlay.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/Dialog/Dialog.js"></script>
    <script type="text/javascript" src="/Admin/Filemanager/Upload/js/EventsManager.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/Dialog/PopUpWindow.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Ajax.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Observable.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/Contextmenu/Contextmenu.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/require.js"></script>
    <script type="text/javascript" src="/Admin/Content/Items/js/Default.js"></script>
    <script type="text/javascript" src="/Admin/Content/Items/js/ItemTypeEdit.js"></script>
    <!-- Controls resources end -->

    <script type="text/javascript">
        Dynamicweb.Ajax.ControlManager.get_current().initialize();
    </script>

    <style>
        .C0 {
            max-width: 18px;
        }
    </style>
</body>
</html>
