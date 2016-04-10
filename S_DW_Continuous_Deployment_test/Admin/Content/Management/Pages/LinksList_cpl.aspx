<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinksList_cpl.aspx.vb" Inherits="Dynamicweb.Admin.LinksList_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<meta http-equiv="Content-Type"  content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
    <title>My page link list</title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
	
	<link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
	<link rel="Stylesheet" href="/Admin/Content/PageSort.css" />
	<script src="/Admin/Content/PageSort.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

	    function openEditDialog(dialogID, linkID, linkUrl) {
            dialog.show(dialogID);
            $("Link_EditLink").value = linkUrl;
            $("EditLinkID").value = linkID;
	    }

        function openAddDialog(dialogID) {
	        dialog.show(dialogID);
	    }

	    function deleteItem(linkID) {
	        if (confirm("<%= Translate.JSTranslate("The link will be removed from the list.")%>")) {
	            new Ajax.Request("/Admin/Content/Management/Pages/LinksList_cpl.aspx", {
	                method: 'post',
	                parameters: {
	                    "LinkID": linkID,
	                    "Delete": "delete"
	                },
	                onComplete: function (transport) {
	                    window.location.reload(true);
	                }
            });
	        }
	    }

	    function saveSorting() {
	        new Ajax.Request("/Admin/Content/Management/Pages/LinksList_cpl.aspx", {
            method: 'post',
            parameters:{
                "Links": Sortable.sequence('items').join(','),
                "Save": "save"
            },
            onComplete: function (transport) {
                window.location.reload(true);
            }
            });
        }

        function addNewLink() {
            new Ajax.Request("/Admin/Content/Management/Pages/LinksList_cpl.aspx", {
                method: 'post',
                parameters: {
                    "LinkUrl": $("Link_NewLink").value,
                    "AddLink": "AddLink"
                },
                onComplete: function (transport) {
                    window.location.reload(true);
                }
            });
        }

        function editLink() {
            new Ajax.Request("/Admin/Content/Management/Pages/LinksList_cpl.aspx", {
                method: 'post',
                parameters: {
                    "LinkID":  $("EditLinkID").value,
                    "LinkUrl": $("Link_EditLink").value,
                    "EditLink": "EditLink"
                },
                onComplete: function (transport) {
                    window.location.reload(true);
                }
            });
        }

	    function showStartFrame() {
	        location = '/Admin/Content/Management/Start.aspx';
	    }
	</script>
</head>

<body onload="sort_init();" style="overflow:hidden;">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="saveSorting();" ID="Save" ShowWait="true" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="showStartFrame();" ID="Cancel" ShowWait="true" />
        <dw:ToolbarButton runat="server" Text="Add link" Image="Link_Add" ID="cmdAddLink" ShowWait="true" />
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("My page link list")%></h2>
    <form id="form1" runat="server">
    <input type="hidden" id="EditLinkID"/>
	    <div class="list">
		    <asp:Repeater ID="PagesRepeater" runat="server" enableviewstate="false">
			    <HeaderTemplate>
			    <ul>
				    <li class="header">
					    <span class="C1" style="padding-top: 0px;">
					    </span>
					    <span class="pipe"></span>
					    <span class="C2" id="sort_name">
					        <%= Translate.Translate("Link")%>
					    </span> 
					    <span class="pipe"></span>
					    <span class="C3" id="sort_updated">
					        <%= Translate.Translate("Remove")%>
					    </span> 
					    <span class="pipe"></span>
				    </li>
			    </ul>
			    <ul id="items">
			    </HeaderTemplate>
			    <ItemTemplate>
				    <li id="Link_<%# Eval("ID")%>">
					    <span class="C1" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
						    <img src="/Admin/Images/Ribbon/Icons/Small/Link.png" onclick="openEditDialog('dlgEdit', '<%# Eval("ID")%>','<%# Eval("LinkUrl")%>');"
                             alt="<%= Translate.Translate("Edit")%>"/></span>
					    <span class="C2"><%# Eval("LinkUrl")%></span> 
                        <span class="C3" id="Span2"><img src="/Admin/Images/Icons/Delete.png" onclick="deleteItem(<%# Eval("ID")%>);" alt="<%= Translate.Translate("Delete")%>"/></span>
				    </li></ItemTemplate>
			    <FooterTemplate>
				</ul>
			    </FooterTemplate>
		    </asp:Repeater>
        </div>
        <dw:Dialog ID="dlgAddHeader" FinalizeActions="false" Title="Add new link" ShowOkButton="true" Width="400" ShowCancelButton="true" runat="server">
	    <table border="0" cellspacing="2" cellpadding="2" width="400">
		    <tr>
				<td width=50><%= Translate.Translate("Link url")%></td>
				<td><%= Gui.LinkManager("", "NewLink", "")%></td>
		    </tr>
	    </table>
        </br>
        </dw:Dialog>

        <dw:Dialog ID="dlgEdit" FinalizeActions="false" Title="Edit link" ShowOkButton="true" Width="400" ShowCancelButton="true" runat="server">
	    <table border="0" cellspacing="2" cellpadding="2" width="400">
		    <tr>
				<td width=50><%= Translate.Translate("Link url")%></td>
				<td><%= Gui.LinkManager("", "EditLink", "", )%></td>
		    </tr>
	    </table>
        </br>
        </dw:Dialog>
    </form>
</body>
  <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
