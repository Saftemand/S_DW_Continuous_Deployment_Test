<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Start.aspx.vb" Inherits="Dynamicweb.Admin.Dashboard.Start" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
	    <dw:ControlResources ID="ctrlResources" runat="server" />
	    
	    <link href="/Admin/Content/Management/Start.css" rel="stylesheet" type="text/css" />
	    
        <script type="text/javascript">
    	    function over(row) {
    		    row.className = 'over';
    	    }
    	    function out(row) {
    		    row.className = '';
    	    }

    	    function doClick(id) {
    	        var ret = true;
    	        var node = null;
    	        var selectedID = id;
    	        var treeInstance = null;
        	    
    	        if (parent && parent.t) {
    	            treeInstance = parent.t;

    	            if (treeInstance.aNodes.length > 1) {
    	                treeInstance.closeLevel(treeInstance.aNodes[1]);
    	                selectedID = selectNode(id, parent.t);

    	                ret = (selectedID == id);
    	                if (!ret) {
    	                    node = treeInstance.getNodeByID(selectedID);
    	                    if(node)
    	                        location.href = node.url;
    	                }
    	            }
    	        }

    	        return ret;
    	    }

    	    function selectNode(id, tree) {
    	        var ret = -1;
    	        var children = [];
    	        var node = tree.getNodeByID(id);
        	    
    	        if(node) {
    	            if (node.url && node.url.length > 0) {
    	                ret = id;
    	                tree.openTo(id, true);
    	            } else {
    	                children = tree.getNodesByPID(node.id);
    	                if(children && children.length > 0) {
    	                    ret = selectNode(children[0].id, tree);
    	                }
    	            }
    	        }

    	        return ret;
    	    }
        </script>
    </head>
    <body onload="selectNode(parent.t.aNodes[1].id, parent.t);">
	    <h1 class="title">
		    <dw:TranslateLabel ID="lbDashboard" runat="server" Text="Dashboard" />
	    </h1>
	    <h2 class="subtitle">&nbsp;</h2>
        <div runat="server" id="myContent">
            <table>
                <asp:Repeater ID="repRootNodes" OnItemDataBound="repRootNodes_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <tr id="rowSection" onmouseover="over(this)" onmouseout="out(this)" runat="server">
                            <td>
                                <div class="hover">
                                    <table>
                                        <tr>
                                            <td valign="top">
                                                <img id="imgIcon" alt="" runat="server" />
                                            </td>
                                            <td valign="top">
                                                <h1 id="sHeader" runat="server"></h1>
                                                <asp:Repeater ID="repSectionNodes" runat="server">
                                                    <ItemTemplate>
                                                        <h2>
                                                            <a id="lnkNode" runat="server"></a>
                                                        </h2>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </body>
    
    <%  
        Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
