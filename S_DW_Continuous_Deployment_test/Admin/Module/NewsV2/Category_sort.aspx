<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Category_sort.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsV2.Category_sort" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeScriptaculous="true"
        runat="server">
    </dw:ControlResources>
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/category.js"></script>
    <script type="text/javascript" src="/admin/module/ecom_catalog/dw7/js/dwsort.js"></script>
    <script type="text/javascript" src="js/categorySort.js"></script>
    <style type="text/css">
        .list ul
        {
            min-width: 640px;
        }
        
        #items li
        {
            cursor: default;
            border-bottom: 1px solid #BDCCE0;
        }
        
        .list li.header
        {
            border-top: 0px solid #BDCCE0;
            min-width: 640px;
        }
        
        .breadcrumb
        {
            border-bottom: 1px solid #BDCCE0;
            height: 20px;
            line-height: 18px;
            display: inherit;
            vertical-align: middle;
            padding-left: 10px;
        }
        
        #BottomInformationBg
        {
            height: 53px;
            width: 100%;
            min-width: 818px;
            background-image: url('/Admin/Images/BottomInformationBg.png');
            background-repeat: repeat-x;
            position: fixed;
            bottom: 0px;
        }
        
        #BottomInformationBg img
        {
            margin: 10px;
        }
        
        #BottomInformationBg .label
        {
            color: #5A6779;
            padding-left: 5px;
            padding-right: 5px;
        }
        
        .w20px
        {
            vertical-align: middle;
            padding: 0px;
            width: 20px;
        }
    </style>
    <script type="text/javascript">
	function help(){
		<%=Gui.Help("newsv2", "modules.newsv2.general.categories.sorting")%>
	}
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
        <dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();"
            ID="Save" />
        <dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="category.list();"
            ID="Cancel" />
        <dw:ToolbarButton ID="help" runat="server" OnClientClick="help();" Image="Help" Text="Help">
        </dw:ToolbarButton>
    </dw:Toolbar>
    <div id="breadcrumb" class="breadcrumb" runat="server">
    </div>
    <div class="list">
        <ul>
            <li class="header"><span class="w20px" style="padding-top: 0px;"></span><span class="pipe">
            </span><span><a href="#" onclick="sorter.sortBy('name'); return false;">
                <%=Translate.Translate("Name")%></a>
                <img style="display: none;" id="name_up" src="/Admin/Images/ColumnSortUp.gif" />
                <img style="display: none;" id="name_down" src="/Admin/Images/ColumnSortDown.gif" />
            </span></li>
        </ul>
        <dw:StretchedContainer ID="SortingContainer" Scroll="Auto" Stretch="Fill" Anchor="document"
            runat="server">
            <ul id="items">
                <asp:Repeater ID="GroupsRepeater" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <li id="Group_<%#Eval("ID")%>"><span class="w20px" style="padding-top: 2px; padding-left: 5px;
                            overflow: hidden;">
                            <img src="/Admin/Images/Ribbon/Icons/Small/Document.png" /></span> <span>
                                <%#Eval("NewsCategoryName")%></span> </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </dw:StretchedContainer>
        <div id="BottomInformationBg">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td rowspan="2">
                        <img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" />
                    </td>
                    <td align="right">
                        <span class="label"><span id="GroupsCount" style="padding: 0;" runat="server"></span>
                            &nbsp;<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Categories" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
     <% Translate.GetEditOnlineScript()%>
    </form>
</body>
</html>
