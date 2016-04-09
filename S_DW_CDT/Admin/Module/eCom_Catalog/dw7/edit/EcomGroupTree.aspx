<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomGroupTree.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomGroupTree2" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title id="title" runat="server"></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/Main.css" />
    <script type="text/javascript" src="../js/groupTree.js"></script>
    <script type="text/javascript" language="JavaScript" src="../images/functions.js"></script>
    <style type="text/css">
        .nav .title
        {
            width: 99%;
            display: none;
        }
        
        .nav .subtitle
        {
            width: 99%;
        }
        
        .nav .tree
        {
            width: 99%;
        }
        
        body.margin
        {
            margin: 0px;
        }
        input, select, textarea
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        div.search-box
        {
            position: absolute;
            top: 2px;
            right: 2px;
        }
        
        .box-end
        {
            height: 21px;
            background-color: #dfe9f5;
            border-top: 1px solid #c3c3c3;
        }

        div.tree {
            height: 350px;
            overflow-y:auto;
        }
    </style>
    <script type="text/javascript">
		//<!--

        function getTree() {
            var tree;
            if (typeof (t) == 'undefined') {
                tree = window.parent.t;
            }
            else {
                tree = t;
            }
            return tree;
         }

		function hideAddGroupsButton() {
			$('transferGroupSelect').style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";
			$('transferGroupSelect').removeAttribute("href");
			$('transferGroupSelect').style.cursor = "";
		}

		function showLoad() {
			if ($('DW_Ecom_GroupTree').style.display == "") {	
				$('DW_Ecom_GroupTree').style.display = "none";
				$('GroupWaitDlg').style.display = "";
			}
		}

		function hideLoad() {
			$('GroupWaitDlg').style.display = "none";		
		}

		var dontAdd = new Array()
		var loop = false; 
		var loopCnt = 0; 
		var tmpCnt = 0; 
		var boolCnt = 0; 
		var i;
		var grpCnt = 0;
		var grpArray = "";
		var arrValue = "";

        function AddProductToDiscount(itemId, itemName, itemImg) {
            grpArray = "["+ itemId +"]";
            setCaller();

            window.opener.ClearProdItems('<%=Request("id")%>_<%=Request("radio")%>');
            window.opener.addProductDivContent(itemId, itemName, itemImg, '<%=Request("id")%>_<%=Request("radio")%>');
            window.opener.invokeObjectByClick('<%=Request("id")%>', '<%=Request("radio")%>');
            window.close();
        }

        function submitGroups()
        {
            <%If Not String.IsNullOrEmpty(Request("AssortmentID")) Then%>
                showLoad();

            <%If Request("CMD") = "ShowProdList_ShowProdGroupList" Then%>
                submitSearchProduct('<%=Request("AssortmentID")%>');
            <%Else%>
                submitProduct('<%=Request("AssortmentID")%>');
			<%End If%>

            return;
            <%End If%>

			hideAddGroupsButton();
			showLoad();

			<%If Request("CMD") = "ShowProdList" Then%>
		        document.getElementById('Form1').SubmitCheckBoxForm.click();
		    <%ElseIf Request("CMD") = "ShowProdGroupList" Then%>
		        appendProductsToGroup(1);
            <%ElseIf Request("CMD") = "ShowProdList_ShowProdGroupList" Then%>
		        appendSearchedProductsToGroup(1);
			<%ElseIf Request("CMD") = "ProductSelectors" Then%>
			    returnProductsAndGroups(1);
			<%ElseIf Request("CMD") = "ProductsAndGroupsSelector" Then%>
			    returnProductsAndGroups(2);
			<%ElseIf Request("CMD") = "ShowProdList_ProductSelectors" Then%>
			    returnProductsToList(1);
			<%ElseIf Request("CMD") = "ShowProdList_ProductsAndGroupsSelector" Then%>
		        returnProductsToList(2);
			<%Else%>
                reLoopGroups();
			<%End If%>
        }

        function submitShop(assortId)
        { 
            var cliEdit = '<%=Request("clientedit")%>';

            if(cliEdit == 'true')
            {
                window.opener.eCommerce.OnAssortmentShopSelected(window, null, null)
                window.close();
            }
            else
            {
                var t = getTree();
                var checkedNodes = t.getCheckedNodes();
                var arrStr = '';

                for(i = 0; i < checkedNodes.length; i++)
                {
                    var node = checkedNodes[i];
                    var item = decodeURIComponent(node.itemID).evalJSON();

                    var id = item.nodeId;

                    if(arrStr != '')
                        arrStr += ',';

                    arrStr += id;
                }

                window.opener.parent.right.location.href = "EcomAssortment_Edit.aspx?CMD=ATTACH_SHOP&ID=" + assortId + "&shopArr=" + arrStr;
                window.close();
            }
        }

        function submitGroup(assortId)
        {
            var cliEdit = '<%=Request("clientedit")%>';

            if(cliEdit == 'true')
            {
                window.opener.eCommerce.OnAssortmentGroupSelected(window, null, null)
                window.close();
            }
            else
            {
                var t = getTree();
                var checkedNodes = t.getCheckedNodes();
                var arrStr = '';

                for(i = 0; i < checkedNodes.length; i++)
                {
                    var node = checkedNodes[i];
                    var item = decodeURIComponent(node.itemID).evalJSON();

                    var id = item.nodeId;

                    if(arrStr != '')
                        arrStr += ',';

                    arrStr += id;
                }

                window.opener.parent.right.location.href = "EcomAssortment_Edit.aspx?CMD=ATTACH_GROUP&ID=" + assortId + "&groupArr=" + arrStr;
                window.close();
            }
        }       

        function submitProduct(assortId)
        { 
            var cliEdit = '<%=Request("clientedit")%>';

            if(cliEdit == 'true')
            {
                window.opener.eCommerce.OnAssortmentProdSelected(window, null, null)
                window.close();
            }
            else
            {
                var t = getTree();
                var checkedNodes = t.getCheckedNodes();
                var arrStr = '';

                for(i = 0; i < checkedNodes.length; i++)
                {
                    var node = checkedNodes[i];
                    var item = decodeURIComponent(node.itemID).evalJSON();
                    var id = item.nodeId;
                    var varId = item.variantId;

                    if(arrStr != '')
                        arrStr += ',';

                    arrStr += id + ':' + varId;
                }

                window.opener.parent.right.location.href = "EcomAssortment_Edit.aspx?CMD=ATTACH_PRODUCT&ID=" + assortId + "&productArr=" + arrStr
                window.close();
            }
        }

        function submitSearchProduct(assortId)
        {
            var cliEdit = '<%=Request("clientedit")%>';
            var arrStr = '';
            var inputs = $$('#Form1 div#DW_Ecom_GroupTree input');

            inputs.each(function (input)
            {
                if(input.checked)
                {
                    var item = input.value.evalJSON();

                    if(arrStr != '')
                        arrStr += ',';

                    arrStr += item.id + ':' + item.variantID + ':' + item.name;
                }
            });

            if(cliEdit == 'true')
            {
                window.opener.parent.right.eCommerce.OnAssortmentProdSelected(null, arrStr);
                window.close();
            }
            else
            {
                window.opener.parent.right.location.href = "EcomAssortment_Edit.aspx?CMD=ATTACH_PRODUCT&ID=" + assortId + "&productArr=" + arrStr
                window.close();
            }
        }

        function submitSearchGroup(assortId, groupid, groupname)
        {
            var cliEdit = '<%=Request("clientedit")%>';

            if(cliEdit == 'true')
            {
                window.opener.parent.right.eCommerce.OnAssortmentGroupSelected(null, groupid, groupname);
                window.close();
            }
            else
            {
                window.opener.parent.right.location.href = "EcomAssortment_Edit.aspx?CMD=ATTACH_GROUP&ID=" + assortId + "&groupArr=" + groupid
                window.close();
            }
        }

        function appendSearchedProductsToGroup(idMode) {
            var productString = "";

            var inputs = $$("#Form1 div#DW_Ecom_GroupTree input");
            inputs.each(function (input) {
                if (input.checked) {
                    var value = input.value.evalJSON();
                    var id = value.id;
                    var variantID = value.variantID;

                    var addString = "";
                    var itemId = "";
                    if (idMode == 1) {
                        if (variantID == "") {
                            addString = "[" + id + "]";
                            itemId = id;
                        }
                        else {
                            addString = "[" + id + "#" + variantID + "]";
                            itemId = id + "#" + variantID
                        }
                    }
                    else {
                        addString = "[p:" + id + "," + variantID + "]";
                        itemId = "p_" + id + "," + variantID;
                    }
                    if (productString.indexOf(addString) < 0) {
                        if (idMode == 1 && productString != "") productString += ';';
                        productString += addString;
                    }
                }
            });

            if (productString != "") {
                AddProductsToGroup(productString, '<%=Request("MasterGroupID")%>');
            }

        }

        function appendProductsToGroup(idMode) {
            var productString = "";
            var t = getTree();
            var checkedNodes = t.getCheckedNodes();

            for (i = 0; i < checkedNodes.length; i++) {
                var node = checkedNodes[i];
                var item = decodeURIComponent(node.itemID).evalJSON();

                var id = item.nodeId;
                var variantID = item.variantId;
                var addString = "";
                var itemId = "";
                if (idMode==1) {
                    if (variantID == ""){  
                        addString = "[" + id + "]";
                        itemId = id;
                    }
                    else {
                        addString = "[" + id + "#" + variantID + "]";
                        itemId = id + "#" + variantID
                    }
                }
                else 
                {
                    addString = "[p:" + id + "," + variantID + "]";
                    itemId = "p_" + id + "," + variantID;
                }
                if (productString.indexOf(addString) < 0) {
                    if (idMode == 1 && productString != "") productString += ';';
                    productString += addString;
                }
            }

            if (productString != "")
            {
                AddProductsToGroup(productString, '<%=Request("MasterGroupID")%>');
            }

        }
		
		function returnProductsToList(idMode) {
		    //Loop checks
		    var productImage = '/Admin/Images/eCom/eCom_Product_small.gif';
		    var variantImage = '/Admin/Images/eCom/eCom_Variants_small.gif';
		    var container = "<%=Request("caller2")%>";
		    
		    var caller = eval("<%=Request("caller")%>");
        	var returnString = caller.value;
			var doAppend = "<%=Request("doAppend") %>".toLowerCase() == "true" ? true : false;
		    
            var inputs = $$("#Form1 div#DW_Ecom_GroupTree input");
            inputs.each(function (input) {
                if (input.checked){
                    var value = input.value.evalJSON();
                    var id = value.id;
					var variantID = value.variantID;
		            var nodeTxt = "";

                    if (input.nextElementSibling){
                        nodeTxt = input.nextElementSibling.innerHTML;  
                    }else {
                        nodeTxt = "";  
                    }
                   
	       	        var addString = "";
                    var itemId = "";
                    if (idMode==1) {
                        if (variantID == ""){  
                            addString = "[" + id + "]";
                            itemId = id;
                        }
                        else {
                            addString = "[" + id + "#" + variantID + "]";
                            itemId = id + "#" + variantID
                        }
                    }
                    else 
                    {
                        addString = "[p:" + id + "," + variantID + "]";
                        itemId = "p_" + id + "," + variantID;
                    }
	       	        if (returnString.indexOf(addString) < 0) {
                        if (idMode==1 && returnString != "") returnString += ';';
                        returnString += addString;                        
                        var image = variantID == "" ? productImage : variantImage;
						if (caller.addProduct && typeof caller.addProduct === 'function') {
						    caller.addProduct(itemId, nodeTxt, image, container);
						} else if (window.opener.addProductDivContent && typeof window.opener.addProductDivContent === 'function') {
						    window.opener.addProductDivContent(itemId, nodeTxt, image, container);
						}
                    }  
                }
            });
          
           // Set caller.value
        	caller.value = returnString;
        	if(caller.onchange) caller.onchange();
        	
			// Close window
			setTimeout("window.close()",500);            
        }
		
		function returnProductsAndGroups(idMode) {
		    var callerID = "<%=Request("caller")%>";
		    var container = "<%=Request("caller2")%>";
            var productImage = '/Admin/Images/eCom/eCom_Product_small.gif';
            var variantImage = '/Admin/Images/eCom/eCom_Variants_small.gif';
            var groupImage = '/Admin/Images/eCom/eCom_Groups_small.gif';
            var searchImage = '/Admin/Images/Ribbon/Icons/Small/search.png';
		    var caller = eval("<%=Request("caller")%>");
        	var returnString = caller.value;
        	var doAppend = "<%=Request("doAppend") %>".toLowerCase() == "true" ? true : false;
		    var eventName = '';

            var t = getTree();
            var checkedNodes = t.getCheckedNodes();

            for (i = 0; i < checkedNodes.length; i++) {
                var node = checkedNodes[i];
                var item = decodeURIComponent(node.itemID).evalJSON();
		        
	            id = item.nodeId;
	                
	                // node is a product
	            if (item.type == "PRODLIST") {
	                eventName = 'EcomGroupTree:ProductsComplete';
	                var variantID = item.variantId;
	                var addString = "";
	                var itemId = "";
	                var image = '';
                        if (idMode==1) {
                            if (variantID == ""){  
                                addString = "[" + id + "]";
                                itemId = id;
                            }
                            else {
                                addString = "[" + id + "#" + variantID + "]";
                                itemId = id + "#" + variantID
                            }
                        }
                        else 
                        {
                            addString = "[p:" + id + "," + variantID + "]";
                            itemId = "p_" + id + "," + variantID;
                        }
	       	            if (returnString.indexOf(addString) < 0) {

	       	                if (idMode == 1 && returnString != "") {
	       	                    returnString += ';';
	       	                }

    	                    returnString += addString;

    	                    if (variantID == "") {
    	                        image = productImage;
    	                    } else {
    	                        image = variantImage;
    	                    }
    	                    var itemData = {
    	                        Id: itemId,
    	                        Type: "p",
    	                        ItemId: id,
    	                        Text: node.name    	                        
    	                    };

    	                    if (caller.addProduct && typeof caller.addProduct === 'function') {
    	                        caller.addProduct(itemId, node.name, image, container, itemData);
    	                    }

    	                    if (window.opener.addProductDivContent && typeof window.opener.addProductDivContent === 'function') {
    	                        window.opener.addProductDivContent(itemId, node.name, image, container, itemData);
    	                    }
                        }
    		        }
    		        
    		        // node is a group
	            else if (item.type == "GROUPLIST") {
	                eventName = 'EcomGroupTree:GroupsComplete';
	                var getShopName = function (node, res) {
	                    if (node._p.name == "Root"){
	                        return " (" + node.name + ")";
	                    }
	                    else {
	                        return getShopName(node._p)
	                    }
	                };
    		            var addString = "[g:" + id + "]";
    		            if (returnString.indexOf(addString) < 0) {
    		                returnString += addString;
    		                var groupsNameParenthesis = <%=(Dynamicweb.Base.IsModuleInstalled("eCom_MultiShopAdvanced") AndAlso (Dynamicweb.eCommerce.Shops.Shop.getShops().Count > 1)).ToString().ToLower()%>?getShopName(node):"";
          	                var itemId = "g_" + id;
          	                var itemData = {
          	                    Id: itemId,
          	                    Type: "g",
          	                    ItemId: id,
          	                    Text: node.name + groupsNameParenthesis
          	                };
          	                if (caller.addProduct && typeof caller.addProduct === 'function') {
          	                    caller.addProduct(itemId, node.name + groupsNameParenthesis, groupImage, container, itemData);
          	                }

          	                if (window.opener.addProductDivContent && typeof window.opener.addProductDivContent === 'function') {
          	                    window.opener.addProductDivContent(itemId, node.name + groupsNameParenthesis, groupImage, container, itemData);
          	                }
                        }
    		        }
	            else if (item.type == "SMARTSEARCH") {
	                eventName = 'EcomGroupTree:SmartSearchComplete';
    		            var addString = "[ss:" + id + "]";
    		            if (returnString.indexOf(addString) < 0) {
          	                returnString += addString;
          	                var itemId = "ss_" + id;

          	                var itemData = {
          	                    Id: itemId,
          	                    Type: "ss",
          	                    ItemId: id,
          	                    Text: node.name
          	                };
          	                if (caller.addProduct && typeof caller.addProduct === 'function') {
          	                    caller.addProduct(itemId, node.name, groupImage, container, itemData);
          	                }

          	                if (window.opener.addProductDivContent && typeof window.opener.addProductDivContent === 'function') {
          	                    window.opener.addProductDivContent(itemId, node.name, searchImage, container, itemData);
          	                }
                        }
                    }
		    }
		    
		    // Set caller.value
        	caller.value = returnString;
        	if (caller.onchange) {
        	    caller.onchange();
        	}

		    // Fire event
        	if (eventName !== '') {
        	    opener.window.document.fire(eventName);
        	}
        	
			// Close window
			setTimeout("window.close()",500);
            		    
		}

function SetGroupID(gID, gName) {
			var theCallerA = eval("<%=Request("caller")%>");
			theCallerA.value = gID;

			var theCallerB = eval("<%=Request("caller2")%>");
			theCallerB.value = gName;

			window.close();
		}
			
		function reLoopGroups() {

				var CMD = "<%=Request("CMD")%>";
		        var doAppend = "<%=Request("doAppend") %>".toLowerCase() == "true" ? true : false;
		        var addVariant = CMD == "ProdItemProd" || CMD == "ShowProd" || CMD == "ShowGroupProdRel";
				
				grpArray = doAppend ? eval("<%=Request("caller")%>").value : "";

				if (CMD == "ProductSelectors" && !doAppend)
                    window.opener.ClearProdItems('<%=Request("id")%>_<%=Request("radio")%>');

                var t = getTree();
                var checkedNodes = t.getCheckedNodes();

                for (i = 0; i < checkedNodes.length; i++) {
                    var node = checkedNodes[i];
                    var item = decodeURIComponent(node.itemID).evalJSON();

                    if(CMD == "ShowGroupToGroupRel" && item.type == "SHOPLIST") {
					    if (confirmDeleteGroupRelations()) {
					        CMD = "DeleteAllParentGroups";
					        break;
					    }
					}

                    if (!!item.nodeId){
                        var tmpA = grpArray.toLowerCase();
                        var tmpB = addVariant ? ("[" + item.nodeId + "," + item.variantId + "]").toLowerCase() : item.nodeId.toLowerCase();

                        if (tmpA.indexOf(tmpB) == -1) {
						    if (grpArray != "") grpArray += ';';
						    if (addVariant) grpArray += "[" + item.nodeId + "," + item.variantId + "]";
						    else grpArray += "[" + item.nodeId + "]";
					    }	
                    }
                }

			    setCaller();
				
			    if (CMD == "ShowProd" || CMD == "ShowGroupProdRel")
				    window.opener.AddRelatedRows();
			    else if (CMD == "ProdItemGrp")
				    window.opener.AddProdItemRows('GRP','ADD');
			    else if (CMD == "ProdItemProd")
			        window.opener.AddProdItemRows('PROD','ADD');
			    else if (CMD == "ShowGroupEditor")
				    window.opener.ProductMultiGroupsAppend("<%=Request("caller2")%>");
				else if (CMD == "DeleteAllParentGroups")
				    window.opener.DeleteAllGroups();
				else if (CMD == "ShowGroupSearchRel")
				    setTimeout("window.opener.AddGroupRelatedSearches();", 400);
				else if (CMD == "ShowProductSearchRel")
				    setTimeout("window.opener.AddRelatedSearchRows();", 400);
			    else
	                setTimeout("window.opener.AddGroupRows('<%=Request("id")%>');", 400);

				setTimeout("window.close()",500);
		}
		
		function AddSingleGroupToProduct(groupId, productId) {
            hideAddGroupsButton();
			showLoad();
		
		    grpArray = groupId;
		    setCaller();
		    window.opener.AddGroupRows(productId);
		    
		    setTimeout("window.close()",500);
		}
		
		function setCaller() {
			if (grpArray != "") {
				var theCaller = eval("<%=Request("caller")%>");
				theCaller.value = grpArray;
			}	
		}
		
		function getCallerValue() {
		    var theCaller = eval("<%=Request("caller")%>");
			return theCaller.value;
		}
		
		function confirmDeleteGroupRelations() {
		    return confirm("<%=Dynamicweb.Backend.Translate.JsTranslate("Selecting the shop will remove the group from all other groups. Do you wish to continue?")%>");
		}

		function ProductCaller(prodID, variantID, prodName) {            
			if (prodID != "") {
			    var Namestr = replaceSubstring("<%=Request("caller")%>", "DW_REPLACE_", "Name_");
			    var NameCaller = eval(Namestr);
			    if (NameCaller) NameCaller.value = prodName;

			    var VariantIDstr = replaceSubstring("<%=Request("caller")%>", "DW_REPLACE_", "VariantID_");
				var VariantCaller = eval(VariantIDstr);
                if (VariantCaller) VariantCaller.value = variantID;

				var IDstr = replaceSubstring("<%=Request("caller")%>", "DW_REPLACE_", "ID_");
                var invokeOnChangeOnID = "<%=Request("invokeOnChangeOnID") %>";
				var IDCaller = eval(IDstr);
				IDCaller.value = prodID;
				if (invokeOnChangeOnID) {
                    try {
                        IDCaller.onchange();
                    } catch(e) {}
                }
			}	
			
			window.close();
		}
		
		function ProductListCaller(pageUrl) {
    		alert(pageUrl);
			if (pageUrl != "") {
			}	
		}		

		function SetGroupID(gID, gName) {
			var theCallerA = eval("<%=Request("caller")%>");
			theCallerA.value = gID;

			var theCallerB = eval("<%=Request("caller2")%>");
		    theCallerB.value = gName;

		    var invokeOnChangeOnID = "<%=Request("invokeOnChangeOnID") %>";

		    if (invokeOnChangeOnID) {
		        try {
		            theCallerA.onchange();
		        } catch (e) { }
		    }

			window.close();
		}
		
		function AddProductToGroup(pID, pGrpID) {
			showLoad();
			window.opener.parent.right.location.href = "EcomUpdator.aspx?CMD=AppendProdToGroup&ID="+ pID +"&GroupID="+ pGrpID
			window.close();
		}

		function AddProductsToGroup(prodArr, pGrpID) {
		    showLoad();
		    window.opener.parent.right.location.href = "EcomUpdator.aspx?CMD=AppendProductsToGroup&ProdArr=" + prodArr + "&GroupID=" + pGrpID
		    window.close();
		}
		
		function AddGroupToGroup(grpID, grpIDTo) {
			showLoad();
			window.opener.parent.right.location.href = "EcomUpdator.aspx?CMD=AppendGroupToGroup&ID="+ grpID +"&GroupID="+ grpIDTo
			window.close();
		}

		//-->
    </script>
</head>
<body>
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <div class="search-box">
        <asp:Literal ID="BoxSearch" runat="server"></asp:Literal></div>
    <form id="Form1" runat="server">
    <div id="GroupWaitDlg" style="position: absolute; top: 40; left: 5; width: 100%;
        height: 1; display: none; cursor: wait;">
        <img src="../images/loading.gif" border="0" alt="loading" />
    </div>
    <dw:StretchedContainer ID="contentStretcher" runat="server" Anchor="body" >
        <div id="DW_Ecom_GroupTree">
            <dw:Tree ID="Tree1" runat="server" SubTitle="All categories" ShowRoot="false" OpenAll="false"
                UseSelection="true" AutoID="true" UseCookies="false" LoadOnDemand="true" UseLines="true">
                <dw:TreeNode ID="Root" NodeID="0" runat="server" Name="Root" ParentID="-1" />
            </dw:Tree>
            <asp:Literal ID="productSearchList" runat="server"></asp:Literal>
            <asp:Button id="SubmitCheckBoxForm" style="display:none;" runat="server"></asp:Button>
        </div>
    </dw:StretchedContainer>
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
</body>
</html>
