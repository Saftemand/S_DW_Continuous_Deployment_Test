<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.List4" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title></title>
	    <dw:ControlResources ID="ctrlResources" runat="server" />
	    
	    <link href="/Admin/Content/Management/Start.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript" src="/Admin/Module/Seo/Chart/JSClass/FusionCharts.js"></script>
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
        <form runat="server" id="form1">
	        <h1 class="title">
		        <dw:TranslateLabel ID="lbDashboard" runat="server" Text="Reports" />
	        </h1>
	        <h2 class="subtitle">&nbsp;</h2>
            <div runat="server" id="myContent">
                <dw:List runat="server" ID="ReportList" NoItemsMessage="No data available">
                </dw:List>
            </div>
        </form>
    </body>
    
    <%  
        Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
