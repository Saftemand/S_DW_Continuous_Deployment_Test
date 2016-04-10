<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Indexes.aspx.vb" Inherits="Dynamicweb.Admin.Indexes" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <script type="text/javascript" src="/Admin/Content/jsLib/Angular/angular.min.js"></script>

    <dw:ControlResources CombineOutput="False" IncludeClientSideSupport="true" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/Items/css/ItemTypeEdit.css" />
        </Items>
    </dw:ControlResources>

    <link rel="stylesheet" type="text/css" href="/Admin/Content/Management/Database/Indexes.css" />

</head>
<body>
    <script type="text/javascript">
        var app = angular.module('app', []);

        function refreshPress() {
            document.getElementById("refreshButton").click();
        }

        function rebuildPress() {
            document.getElementById("rebuildButton").click();
        }

        function help() {
        }

        var rebuildCompleteMsg = '<%=Translate.Translate("Rebuild complete")%>';
    </script>

    <form id="MainForm" runat="server" ng-app="app" ng-cloak ng-controller="IndexesController">

        <dw:Toolbar runat="server" ShowStart="true" ShowEnd="false">
            <dw:ToolbarButton ID="cmdRefresh" Image="Refresh" OnClientClick="refreshPress();" Text="Refresh" Divide="After" runat="server" />
            <dw:ToolbarButton ID="cmdRebuild" ImagePath="/Admin/Images/Ribbon/Icons/Small/replace2.png" Text="Rebuid Indexes" runat="server" OnClientClick="rebuildPress();" />
            <dw:ToolbarButton ID="cmdHelp" Image="Help" OnClientClick="help();" Text="Help" runat="server" />
        </dw:Toolbar>

        <h2 class="subtitle">
            <dw:TranslateLabel Text="Database Indexes Health" runat="server" />
        </h2>

        <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="body" runat="server">

            <input id="refreshButton" type="button" style="display: none;" ng-click="refresh();" />
            <input id="rebuildButton" type="button" style="display: none;" ng-click="rebuild();" />

            <dw:Overlay ID="loadOverlay" runat="server"></dw:Overlay>

            <div ng-if="permissionError && permissionError.length > 0">
                <dw:Infobar ID="Infobar1" runat="server" Type="Information" Visible="true" TranslateMessage="False">
                    <asp:Literal runat="server" Text="{{permissionError}}" />
                </dw:Infobar>
            </div>

            <div ng-if="!permissionError">
                <div ng-if="error && error.length > 0">
                    <dw:Infobar ID="infError" runat="server" Type="Error" Visible="true" TranslateMessage="False">
                        <asp:Literal runat="server" Text="{{error}}" />
                    </dw:Infobar>
                </div>

                <div class="list database">
                    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1); border-top: none; border-bottom: none;">
                        <ul>
                            <li class="header">
                                <span class="pipe"></span><span class="C0">#</span>
                                <span class="pipe"></span><span class="C1 table-name"><%=Translate.Translate("Table Name")%></span>
                                <span class="pipe"></span><span class="C2 index-name"><%=Translate.Translate("Index Name")%></span>
                                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Fragmentation")%></span>
                                <span class="pipe"></span><span class="C3"></span>
                            </li>
                        </ul>
                        <ul style="position: relative;">
                            <li class="item-field" ng-class="{'in-progress': index.inProgress }" style="position: relative;" ng-repeat="index in database.indexes">
                                <span class="C0"><a href="javascript:void(0);">
                                    <img alt="" src="/Admin/Images/Ribbon/Icons/Small/element.png" /></a></span>
                                <span class="C1 table-name">{{index.tableName}}</span>
                                <span class="C2 index-name">{{index.indexName}}</span>
                                <span class="C3">{{index.frag}}</span>
                                <span class="C3 result">{{index.message}}<span ng-if="index.error && index.error.length > 0" title="{{index.error}}"><%=Translate.Translate("Error")%></span></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </dw:StretchedContainer>

        <dw:Overlay ID="PleaseWait" runat="server" />
    </form>

    <%Translate.GetEditOnlineScript()%>

    <script type="text/javascript" src="/Admin/Content/Management/Database/IndexesRepository.js"></script>
    <script type="text/javascript" src="/Admin/Content/Management/Database/IndexesController.js"></script>

</body>
</html>

