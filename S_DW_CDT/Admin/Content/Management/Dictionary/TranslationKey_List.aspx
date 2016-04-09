<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TranslationKey_List.aspx.vb" Inherits="Dynamicweb.Admin.TranslationKey_List" %>

<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Translation keys" runat="server" /></title>

        <dw:ControlResources ID="ctrlResources" IncludePrototype="true"  CombineOutput="false" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/Dictionary/Dictionary.js" />
            </Items>
        </dw:ControlResources>
        <link rel="stylesheet" type="text/css" href="Dictionary.css" />
    
        <script type="text/javascript">
            document.observe('dom:loaded', function () {
                Dictionary.TranslationKey_List.initialize();
                var tbl = $$("#OuterContainer .list table");

                var arr1 = $$("#ListTable thead .header .columnCell");
                var totalWidth = 0;
                arr1.each(function (el) {
                    totalWidth += el.getWidth();
                });
                var arr2 = $$("#lstKeys_body_stretch .header .columnCell");
                for (var i = 0; i < arr1.length; i++) {
                    var pw = (100 * arr1[i].getWidth()) / totalWidth ;
                    arr2[i].style.width = arr1[i].style.width = pw + "%";
                }
                var arr = List.get_stretchers();
                var s = arr[0];
                s = s.get_stretcherObject();
                s._events.removeAllHandlers("afterStretch");
                tbl.invoke('setStyle', { 'tableLayout': 'fixed' });

                var src = location.href;
                var params = src.toQueryParams();
                if (params.SearchText) {
                    $('SearchText').value = params.SearchText;
                }

                document.onkeydown = function (e) {
                    var code = (e.keyCode ? e.keyCode : e.which);
                    if (code == '13') {
                        doSearch();
                        return false;
                    }
                }
            });

            function doSearch() {
                searchTranslation($('SearchText').value);
            }

            function searchTranslation(searchText) {
                var src = location.href;
                if (src.endsWith('#')) {
                    src = src.substr(0, src.length - 1);
                }

                var params = src.toQueryParams();

                if (params.SearchText) {
                    src = src.replace("SearchText=" + encodeURIComponent(params.SearchText), "SearchText=" + encodeURIComponent(searchText));
                    src = src.replace("SearchText=" + params.SearchText, "SearchText=" + encodeURIComponent(searchText));
                } else if(params.SearchText === ""){
                    src = src.replace("SearchText=", "SearchText=" + encodeURIComponent(searchText));
                } else {
                    src = src + "&SearchText=" + encodeURIComponent(searchText);
                }

                location.href = src;
            }

            function reloadPage(clearSearch) {
                if (clearSearch) {
                    searchTranslation("");
                }
                else {
                    location.reload(true);
                }
            }
        </script>
    
        <style type="text/css">
            .popup-progress
            {
	            padding-top: 150px !important;
	            height: 230px !important;
            }

            #OuterContainer .list .container .header td.columnCell {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            #OuterContainer .list .container .listRow td:not(:first-child) {
                text-align:center;
            }
        </style>

    </head>
    <body>
        <form id="MainForm" runat="server">
            <input type="hidden" ID="hDesignName" runat="server" value="" />
            <input type="hidden" ID="hIsGlobal" runat="server" value="" />
            <input type="hidden" ID="hIsItemType" runat="server" value="" />

            <div id="dic_header" class="dic_header" runat="server">
                <div class="toolbar-filter" runat="server" id="ToolbarFilters">
                    <input type="text" class="textInput" id="SearchText" name="SearchText" placeholder="<%=Dynamicweb.Backend.Translate.Translate("Search")%>" />
                    <img alt="Search" class="submitImage" onclick="doSearch();" src="/Admin/Images/Ribbon/Icons/Small/Search.png"/>
                </div>
                <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	                <dw:ToolbarButton ID="cmdAdd" runat="server" Divide="None" Image="AddDocument" OnClientClick="Dictionary.TranslationKey_List.add()" Text="Add" />
                    <dw:ToolbarButton ID="cmdRefresh" runat="server" Divide="None" Image="Refresh" Text="Refresh" OnClientClick="reloadPage(true);" />
                    <dw:ToolbarButton ID="cmdGoBack" Visible="false" Image="Undo" runat="server" Divide="None" Text="Go back" OnClientClick="" />
	                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="" />
	            </dw:Toolbar>

                <h2 id="Subtitle" class="subtitle" runat="server">
                    <asp:Label ID="lblFilename" Text="" runat="server"></asp:Label>
                    <dw:TranslateLabel ID="lblSubtitle" Text="translation keys" runat="server" />
                </h2>
            </div>
            <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="body" runat="server">
                <dw:List ID="lstKeys" AllowMultiSelect="false" StretchContent="true" ShowPaging="true" ShowTitle="false" runat="server" pagesize="1000">
                </dw:List>

                <span id="jsHelp" style="display: none"><%= Dynamicweb.Gui.Help("", "managementcenter.ecommerce.filters.group.list")%> </span>
                <span id="confirmDelete" style="display: none"><dw:TranslateLabel id="lbDelete" Text="Slet?" runat="server" /></span>  

                <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 

            </dw:StretchedContainer>
        </form>
    </body>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
