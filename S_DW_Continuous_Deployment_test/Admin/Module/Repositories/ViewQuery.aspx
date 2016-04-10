<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewQuery.aspx.vb" Inherits="Dynamicweb.Admin.Repositories.ViewQuery" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="rp" TagName="QueryEditor"  Src="~/Admin/Module/Repositories/Controls/QueryEditor.ascx" %>
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

    </head>
    <body>

    <script type="text/javascript" src="/Admin/Content/jsLib/Angular/angular.min.js"></script>

    <script type="text/javascript">
        var repositoryclean = '<%=Request("Repository")%>';
        var repository = '<%=Request("Repository").Replace(".","-")%>';
        var item = '<%=Request("Item").Replace(".","-")%>';
        var app = angular.module('app', []);
        app.location = [{}];
    </script>

    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/QueryRepository.js"></script>
    <script type="text/javascript" src="/Admin/Module/Repositories/Scripts/QueryController.js"></script>

    <form id="MainForm" onsubmit="" srunat="server" ng-submit="setIndex()" ng-controller="queryController" style="margin:0px">
		<div style="min-width:1000px;overflow:hidden">
		    <dw:Ribbonbar runat="server" ID="myribbon">
			    <dw:RibbonbarTab Active="true" Name="Query" runat="server">
				    <dw:RibbonbarGroup runat="server" ID="grpTools" Name="Funktioner">
					    <dw:RibbonbarButton runat="server"  Text="Save" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave" NgClick="setQuery();" ShowWait="true" WaitTimeout="500"></dw:RibbonbarButton>
					    <dw:RibbonbarButton runat="server" Text="Save and close" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose" NgClick="setQueryAndExit()" ShowWait="true" WaitTimeout="500"></dw:RibbonbarButton><dw:RibbonbarButton runat="server" Text="Cancel" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id='+repositoryclean" ShowWait="false" WaitTimeout="500">
					    </dw:RibbonbarButton>
				    </dw:RibbonbarGroup>
                    <dw:RibbonbarGroup runat="server" ID="grpAdd" Name="Add">
					    <dw:RibbonbarButton runat="server" Text="Add parameter" Size="Small" Image="AddDocument" ID="cmdNewParameter"  NgClick="openParameterDialog();"></dw:RibbonbarButton>
                        <dw:RibbonbarButton runat="server" Text="Add sorting" Size="Small" Image="AddDocument" ID="cmdNewSorting"  NgClick="openSortingDialog();"></dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Help">
					    <dw:RibbonbarButton ID="RibbonbarButton1" runat="server" Size="Large" Text="Help" Image="Help"  OnClientClick="window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=administration.managementcenter.Repositories.Query&LanguageID=en', 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes,scrollbars=yes');"></dw:RibbonbarButton>
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
                <rp:QueryEditor runat="server" ShowSource="true">
                </rp:QueryEditor>
            </div>

        </div>


    <rp:Infobar runat="server" Model="query" Name="{{query.Name}}" Type="Query" Icon="/Admin/Images/Repository/query_32.png" FileName="{{query.FileName}}"></rp:Infobar>


    <div ng-include="'/Admin/Module/Repositories/Views/Query/dlgSearch.html'" ng-repeat="query in [query.query]"></div>

    <dw:Dialog ID="ParameterDialog" Title="Parameter" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okParameterDialog').click();" runat="server">
        <button style="display:none;" id="okParameterDialog" type="button" class="dialog-button-ok" ng-click="saveParameterDialog();">OK</button>
	    <dw:GroupBox ID="GroupBox10" runat="server" Title="Generelt" DoTranslation="true">
            <table border="0">
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Name" runat="server" /></td>
                    <td><input ng-model="draftParam.Name" type="text" class="std" /></td>
                </tr>
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Type" runat="server" /></td>
                    <td>
                        <select class="std" ng-model="draftParam.Type">
                            <option value="System.String">System.String</option>
                            <option value="System.Boolean">System.Boolean</option>
                            <option value="System.Decimal">System.Decimal</option>
                            <option value="System.Single">System.Single</option>
                            <option value="System.Double">System.Double</option>
                            <option value="System.Int16">System.Int16</option>
                            <option value="System.Int32">System.Int32</option>
                            <option value="System.Int64">System.Int64</option>
                            <option value="System.DateTime">System.DateTime</option>
                            <option value="System.String[]">System.String[]</option>
                            <option value="System.Boolean[]">System.Boolean[]</option>
                            <option value="System.Decimal[]">System.Decimal[]</option>              
                            <option value="System.Single[]">System.Single[]</option>
                            <option value="System.Double[]">System.Double[]</option>
                            <option value="System.Int16[]">System.Int16[]</option>
                            <option value="System.Int32[]">System.Int32[]</option>
                            <option value="System.Int64[]">System.Int64[]</option> 
                            <option value="System.DateTime[]">System.DateTime[]</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Default value" runat="server" /></td>
                    <td>
                        <input ng-model="draftParam.DefaultValue" type="text" class="std" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </dw:Dialog>

    <dw:Dialog ID="SortOrderDialog" Title="Sort By" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okSortingDialog').click();" runat="server">
        <button style="display:none;" id="okSortingDialog" type="button" class="dialog-button-ok" ng-click="saveSortingDialog();">OK</button>
	    <dw:GroupBox ID="GroupBox1" runat="server" Title="Generelt" DoTranslation="true">
            <table border="0">
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Field" runat="server" /></td>
                    <td>
                        <select class="std" ng-model="draftSort.Field" ng-options="field.Name as field.Name for field in model.Fields">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="left-label"><dw:TranslateLabel Text="Direction" runat="server" /></td>
                    <td>
                        <select class="std" ng-model="draftSort.SortDirection">
                            <option value="Descending"><%=Translate.Translate("Descending")%></option>
                            <option value="Ascending"><%=Translate.Translate("Ascending")%></option>
                        </select>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </dw:Dialog>

    <dw:Dialog ID="EditExpressionDialog" Title="Edit expression" Width="600" ShowClose="true" ShowOkButton="true" ShowCancelButton="True" OkAction="document.getElementById('okEditExpressionDialog').click();" runat="server">
        <button style="display:none;" id="okEditExpressionDialog" type="button" class="dialog-button-ok" ng-click="saveEditExpressionDialog();">OK</button>
	    <dw:GroupBox ID="GroupBox2" runat="server" Title="Generelt" DoTranslation="true">
            <div>
                <table border="0">
                    <tr>
                        <td class="left-label"><dw:TranslateLabel Text="Right expression" runat="server" /></td>
                        <td>
                            <select class="std" ng-model="rightExpressionDraft.class">
                                <option value="ConstantExpression"><%=Translate.Translate("Constant")%></option>
                                <option value="ParameterExpression"><%=Translate.Translate("Parameter")%></option>
                                <option value="MacroExpression"><%=Translate.Translate("Macro")%></option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div ng-if="rightExpressionDraft.class == 'ConstantExpression'">
                <div ng-include="'EditConstantExpression.html'"></div>
            </div>
            <div ng-if="rightExpressionDraft.class == 'ParameterExpression'">
                <div ng-include="'EditParameterExpression.html'"></div>
            </div>
            <div ng-if="rightExpressionDraft.class == 'MacroExpression'">
                <div ng-include="'EditMacroExpression.html'" ></div>
            </div>
        </dw:GroupBox>
    </dw:Dialog>

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
