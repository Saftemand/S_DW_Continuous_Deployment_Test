<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewFacets.aspx.vb" Inherits="Dynamicweb.Admin.Repositories.ViewFacets" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="rp" TagName="Infobar"  Src="~/Admin/Module/Repositories/Controls/Infobar.ascx" %>

<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" ng-app="app">
    <head runat="server">
	    <title></title>
        <dw:ControlResources IncludePrototype="true" runat="server"></dw:ControlResources>
        <link rel="stylesheet" type="text/css" href="/Admin/Module/Repositories/Styles/Repository.css" />

        <!-- Controls resources start -->
        <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Dialog/Tabular/Dialog.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Dialog/PopUpWindow.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Module/OMC/css/AjaxRichControl.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Contextmenu/Contextmenu.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Content/StyleSheetNewUI.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/Default.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/ItemTypeEdit.css" />
        <link rel="stylesheet" type="text/css" href="/Admin/Content/Items/css/LanguageSelector.css" />
        <!-- Controls resources end -->

        <style type="text/css">
            .C0 {
                max-width:20px;
            }
 
            .btn {
                margin:5px;border:1px solid gray;border-radius:4px;padding:2px;font-size: 8pt
            }
        </style>

    </head>
    <body>

    <script type="text/javascript" src="/Admin/Content/jsLib/Angular/angular.min.js"></script>

    <script type="text/javascript">
        var repositoryclean = '<%=Request("Repository")%>';
        var repository = '<%=Request("Repository").Replace(".","-")%>';
        var item = '<%=Request("Item").Replace(".","-")%>';
        var app = angular.module('app', []);
        app.location = [{}]
    </script>

    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/FacetsRepository.js"></script>
    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/FacetsController.js"></script>

    <form id="MainForm" onsubmit="" runat="server" ng-controller="facetsController" style="margin:0px">
	    <div style="min-width:1000px;overflow:hidden">
		    <dw:Ribbonbar runat="server" ID="myribbon">
			    <dw:RibbonbarTab Active="true" Name="Facets" runat="server">
				    <dw:RibbonbarGroup runat="server" ID="grpTools" Name="Funktioner">
					    <dw:RibbonbarButton runat="server"  Text="Save" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave" NgClick="setFacets();" ShowWait="true" WaitTimeout="500"></dw:RibbonbarButton>
					    <dw:RibbonbarButton runat="server" Text="Save and close" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose" NgClick="setFacetsAndExit()" ShowWait="true" WaitTimeout="500"></dw:RibbonbarButton><dw:RibbonbarButton runat="server" Text="Cancel" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id='+repositoryclean" ShowWait="false" WaitTimeout="500">
					    </dw:RibbonbarButton>
				    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup runat="server" ID="RibbonbarGroup3" Name="Index">
					    <dw:RibbonbarButton runat="server" Text="Add Field Facet" Size="Small" Image="AddDocument" ID="RibbonbarButton3" NgClick="newFacetDialog({Name:'Facet1', Type: 'Field'});"></dw:RibbonbarButton>
					    <dw:RibbonbarButton runat="server" Text="Add List Facet" Size="Small" Image="AddDocument" ID="RibbonbarButton4" NgClick="newFacetDialog({Name:'Facet1', Type: 'List', Options:[]});"></dw:RibbonbarButton>
				    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Help">
					    <dw:RibbonbarButton ID="RibbonbarButton1" runat="server" Size="Large" Text="Help" Image="Help"  OnClientClick="window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=administration.managementcenter.Repositories.Facets&LanguageID=en', 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes,scrollbars=yes');"></dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
                </dw:RibbonbarTab>
            </dw:Ribbonbar>
        </div>

        <div id="breadcrumb">
            »
            <a href="/admin/content/management/Start.aspx"><%=Translate.Translate("Management")%></a> »
            <a href="#"><%=Translate.Translate("Repositories")%></a> »
            <a href="/Admin/Module/Repositories/ViewRepository.aspx?id=<%=Request("Repository")%>"><%=Request("Repository")%></a> »
            <a href="#"><b><%=Request("Item")%></b></a>
        </div>


        <!-- LIST -->
        <div class="list" ng-if="!preview">


            <li class="header">
                <span class="pipe"></span><span class="C0"></span>
            </li>


            <div id="_contentWrapper" style="padding:5px;padding-right:20%">

                <dw:GroupBox ID="GroupBox8" runat="server" Title="Query" DoTranslation="true">
                    <table>
                        <tr>
                            <td class="left-label"><dw:TranslateLabel Text="Query" runat="server" /></td>
                            <td>
                                <select class="std" ng-if="datasources.length == 0" value="{{facets.Source.Item}}">
                                    <option>{{facets.Source.Item}}</option>
                                </select>
                                <select class="std" ng-if="datasources" ng-change="onFacetsSourceChanged();" ng-model="facets.Source" ng-options="ds.Item group by ds.Repository for ds in datasources track by ds.Item">
                                </select>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>

                <!-- Facets-->
                <dw:GroupBox ID="GroupBox9" runat="server" Title="Facets" DoTranslation="true">
                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1);border-bottom:none;margin:3px;">
                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                                <span class="pipe"></span><span class="C2"><%=Translate.Translate("Field")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Type")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Query Parameter")%></span>
                            </li>
                        </ul>
                        <ul style="position: relative;">
                            <li class="item-field" ng-class="{'item-field-no-longer-available': isNoLongerAvailable(facet)}" style="position: relative;" ng-repeat="facet in facets.Items">
                                <span class="C0" ng-click="openFacetDialog(facet);"><a href="javascript:void(0);"><img alt="" src="/Admin/Images/Repository/Facet.png"/></a></span>
                                <span class="C1" ng-click="openFacetDialog(facet);">{{facet.Name}}</span>
                                <span class="C2" ng-click="openFacetDialog(facet);">{{facet.Field}}</span>
                                <span class="C3" ng-click="openFacetDialog(facet);">{{facet.Type}}</span>
                                <span class="C3" ng-click="openFacetDialog(facet);">{{facet.QueryParameter}}</span>
                                <span class="C1" style="width:auto;float:right;"><a href="javascript:void();" ng-click="removeFacet($index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif"></a></span>
                            </li>
                        </ul>
                    </div>
                </dw:GroupBox>

            </div>
        </div>

    <dw:Dialog ID="FacetDialog" Title="Facet" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okFacetDialog').click();" runat="server">
        <button style="display:none;" id="okFacetDialog" type="button" class="dialog-button-ok" ng-click="saveFacetDialog();">OK</button>
		<dw:GroupBox ID="GroupBox10" runat="server" Title="Generelt" DoTranslation="true">
            <table border="0">
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Name" runat="server" /></td>
                    <td><input ng-model="draftFacet.Name" type="text" class="std" /></td>
                </tr>
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Field" runat="server" /></td>
                    <td>
                        <select class="std" ng-model="draftFacet.Field" ng-options="field.SystemName as field.Name for field in model.Fields">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Query parameters" runat="server" /></td>
                    <td>
                        <select class="std" ng-model="draftFacet.QueryParameter" ng-options="param.Name as param.Name for param in parameters">
                        </select>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <div class="list list-options" ng-if="draftFacet.Type == 'List'">
            <dw:GroupBox ID="GroupBox11" runat="server" Title="Facets" DoTranslation="true">
                <div id="items" style="background-color:white;border: 1px solid rgba(188, 203, 223, 1);height:200px;overflow-x:hidden;">
                    <ul>
                        <li class="header">
                            <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span>
                            <span class="pipe"></span><span class="C2"><%=Translate.Translate("Value")%></span>
                        </li>
                    </ul>
                    <ul style="position: relative; min-height: 5px;">
                        <li class="item-field" style="position: relative;" ng-repeat="option in draftFacet.Options">
                            <span class="C1">&nbsp;&nbsp;<input type="text" ng-model="option.Name" style="border:0;font-size:9pt"/></span>
                            <span class="C2"><input type="text" ng-model="option.Value" style="border:0;font-size:9pt"/></span>
                            <span class="C3"><a href="" ng-click="removeFacetOption($index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif" /></a></span>
                        </li>
                    </ul>
                </div>
                <input type="button" class="btn " style="margin:2px" ng-click="draftFacet.Options.push({})" value="<%=Translate.Translate("Add")%>" />
            </dw:GroupBox>       
        </div>
    </dw:Dialog>



    <rp:Infobar runat="server" Model="facets" Name="{{facets.Name}}" Type="Facets" Icon="/Admin/Images/Repository/facets_32.png" FileName="{{facets.FileName}}"></rp:Infobar>


    </form>


    <dw:Overlay ID="ItemTypeEditOverlay" runat="server"></dw:Overlay>


    <!-- Controls resources start -->
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

    <%Translate.GetEditOnlineScript()%>

    <script type="text/javascript">
        Dynamicweb.Ajax.ControlManager.get_current().initialize();
    </script>    

    </body>
</html>
