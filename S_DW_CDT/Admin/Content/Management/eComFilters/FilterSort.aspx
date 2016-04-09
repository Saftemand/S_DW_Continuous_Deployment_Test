<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FilterSort.aspx.vb" Inherits="Dynamicweb.Admin.FilterSort" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeScriptaculous="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
	<link rel="Stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/List/List.css" />

    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/js/dwsort.js"></script>
    <script type="text/javascript">

        var sorter;

        Event.observe(window, 'load', function () {
            Position.includeScrollOffsets = true;
            sorter = new DWSortable('items',
                { name: function (s) { return ("" + s.children[1].innerHTML).toLowerCase(); }
                }
            );
        });

        function save() {
            new Ajax.Request("/Admin/Content/Management/eComFilters/FilterSort.aspx", {
                method: 'post',
                parameters: {
                    "SortFields": Sortable.sequence('items').join(','),
                    "Save": "save",
                    "GroupID": <%=getGroupID%>
                    },
                onSuccess: cancel
            });
        }

        function cancel() {
            window.location.href = "/Admin/Content/Management/eComFilters/FilterList.aspx?GroupID=" + <%=getGroupID%>;
        }


    </script>
	<style type="text/css">
        .list ul {
	        min-width:640px;
        }
        
        #items li {
	        cursor:default;
	        border-bottom:1px solid #BDCCE0;
        }

        .list li.header {
	        border-top:0px solid #BDCCE0;
	        min-width:640px;
        }

        .w20px {
	        vertical-align:middle;
	        padding:0px;
	        width:20px;
	        white-space:nowrap;
	        overflow:hidden;
        }
        	
        .w620px { width:620px; white-space:nowrap;overflow:hidden;}


	</style>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="Save" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("Sort filter options")%></h2>
	<div class="list">
		<ul>
			<li class="header">
				<span class="w20px" style="padding-top: 0px;">
				</span>
				<span class="pipe"></span>
				<span class="w620px">
				    <a href="#" onclick="sorter.sortBy('name'); return false;"><%=Translate.Translate("Name")%></a>
				    <img style="display:none;" alt="up" id="name_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" alt="down" id="name_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
			</li>
		</ul>
	    <dw:StretchedContainer ID="SortingContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
		<ul id="items">
		    <asp:Repeater ID="FilterFieldsRepeater" runat="server" enableviewstate="false">
    		    <ItemTemplate>
			    <li id="Filter_<%#Eval("ID")%>">
				    <span class="w20px" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
					    <img  alt="" src="/Admin/Images/Ribbon/Icons/Small/Document.png" /></span>
				    <span class="w620px"><%#Eval("Name")%></span>
			    </li></ItemTemplate>
		    </asp:Repeater>
		</ul>
        </dw:StretchedContainer>
    </div>

    </form>
</body>
</html>
    <% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>