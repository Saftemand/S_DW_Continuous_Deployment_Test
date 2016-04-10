<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master" EnableEventValidation="false"
    ValidateRequest="false" CodeBehind="EcomProduct_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.ProductEdit" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ecom" Namespace="Dynamicweb.Admin.eComBackend" Assembly="Dynamicweb.Admin" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">

    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />

    <script type="text/javascript" src="../js/hotkeys.js"></script>
    <script type="text/javascript" src="../js/queryString.js"></script>
    <script type="text/javascript" src="../js/productEdit.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Validation.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/List/List.js"></script>
    <script type="text/javascript" src="../js/ecomLists.js"></script>
    <link rel="STYLESHEET" type="text/css" href="../../../../Stylesheet.css" />
    <link rel="Stylesheet" type="text/css" href="../css/productEdit.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/List/List2.css" />
    
    <%If Base.Request("VariantID") <> "" Then%>
    <style type="text/css">
    	body {
    		top: 0px;
    		margin-top: 0px;
    		margin-right: 0px;
    		margin-bottom: 0px;
    		margin-left: 0px;
    	}
    </style>
    <% End If%>

    <style type="text/css">
    	#optimizePopup div.popup-progress-image {
    		padding-top: 100px !important;
    	}
        .cropText {
            display:block;
            width: 400px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
    </style>
    <asp:Literal ID="CurrencyOptions" runat="server"></asp:Literal>

    <script type="text/javascript">
        strHelpTopic = 'ecom.productman.product.edit';

        var useUnit = true;
			<%If Base.HasAccess("eCom_Units", "") Then%>
        useUnit = true;
			<%Else%>
        useUnit = false;
			<%End If%>

        var priceStandard = false;
        var priceExtended = false;
			<%If Base.HasAccess("eCom_Pricing", "") Then%>
        priceStandard = true;
        <%End If%>

			<%If Base.HasAccess("eCom_PricingExtended", "") Then%>
        priceExtended = true;
        <%End If%>

        var useProviderBasedEditors = false;
        <%If UseEditors Then%>
        useProviderBasedEditors = true;
        <%End If%>
    </script>
	<%	If Not UseEditors Then%>
    <script type="text/javascript" src="/Admin/Editor/fckeditor.js"></script>
	<%	End If%>
    <script type="text/javascript" language="JavaScript" src="../images/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../images/addrows.js"></script>
    <script type="text/javascript" language="JavaScript" src="../images/layermenu.js"></script>
    <script type="text/javascript" language="JavaScript" src="../Wizard/wizardstart.js"></script>
    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/images/DateSelector.js"></script>
    <script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
    <script src="/Admin/Link.js" type="text/javascript"></script>
    <script type="text/javascript">        function html() { return true; }</script>
    <script type="text/javascript">

        var aspForm;

        $(document).observe('dom:loaded', function() {
            aspForm = document.forms[0];
            document.onmousemove = getMouseXY;

            if(_tabNum && _tabNum == '1'){ //check if default tab loaded.
                window.focus(); // for ie8-ie9
                document.getElementById('<%=Name.ClientID %>').focus();
            }
    	});

        $(document).observe('keydown', function (e) {
            if (e.keyCode == 13) {
                var srcElement = e.srcElement ? e.srcElement : e.target;
                if (srcElement.type != 'textarea') {
                    e.preventDefault();
                }
            }
        });

        function onOptimizeShow(sender, args) {
            sender.set_title('<%=Translate.JsTranslate("Optimize")%>');
		}

		function SaveProduct() {
    	    <% ' This is a workaround (hack) for Bug 11007 %>
			<% If UseEditors then %>
    	    (function() {
    	        try {
    	            if (typeof CKEDITOR != 'undefined') {
    	                var editorName;
    	                for (editorName in CKEDITOR.instances) {
    	                    CKEDITOR.instances[editorName].updateElement();
    	                }
    	            }
    	        } catch (ex) {}
    	    }());
			<% End If %>
    	    validationResult = Page_ClientValidate("");
    	    if(!validationResult){
    	        return false;
    	    }

			
    	    if(!ProductEdit.validate())
    	    {
    	        return false;
    	    }
			
    	    var pname = "<%=Name.ClientID %>";

			if($(pname).value.trim().length == 0){
			    Ribbon.radioButton('RibbonBasicButton', 'ctl00$ContentHolder$RibbonBasicButton', 'productTabs');
			    ribbonTab('GENERAL', 1);
			    return;
			}

			FillDivLayer("LOADING", "", "SAVE");

			<%If VariantProduct Then%>
    	    window.name = "VariantWin";
    	    aspForm.target = "VariantWin";
			<%End If%>

    	    submitPricePrioritySort();
    	    submitCurrentTab();

    	    if (window.onProductSaveCallback) {
    	        window.onProductSaveCallback();
    	    }

    	    return true;
    	}

    	function submitPricePrioritySort() {
    	    try {
    	        for (i = 0; i < aspForm.MatrixSelected.length; i++) {
    	            aspForm.MatrixSelected.options[i].selected = true;
    	        }
    	    } catch(e) {
    	        //Nothing
    	    }
    	}

    	function DeleteProduct() {
    	    var Message;
    	    if (isDefaultLang)
    	        Message = '<%=Dynamicweb.Backend.Translate.JsTranslate("Slet?")%>';
        	else
        	    Message = '<%=Dynamicweb.Backend.Translate.JsTranslate("This will delete the product across all languages. Use delocalize to remove product from selected language.") %>';

            if (confirm (Message)) {
                FillDivLayer("LOADING", "", "SAVE");

				<%If VariantProduct Then%>
			    window.name = "VariantWin";
			    document.getElementById('Form1').target = "VariantWin";
				<%End If%>
			    return true;
			}
			else
			    return false;
        }
        function Delocalize() {
            var Message = '<%=Dynamicweb.Backend.Translate.JsTranslate("Delocalize?")%>';
		    if (confirm (Message)) {
		        FillDivLayer("LOADING", "", "SAVE");

				<%If VariantProduct Then%>
			    window.name = "VariantWin";
			    document.getElementById('Form1').target = "VariantWin";
				<%End If%>
			    return true;
			}
			else
			    return false;
        }

        function gotoPage(url) {
            document.location.href = url;
        }

        function browseDetailArchive(type, cnt) {
            var elem = document.getElementById("DETAIL_Value[" + type + "]" + cnt);
            browseArchive("DETAIL_Value[" + type + "]" + cnt + "","",elem.value);
        }


        function AddToGroups(fieldName) {
			<%If AddGroupsAssortment Then%>
		    if (fieldName == "addGroupsChecked") {
		        ActivateTabClick('Tab5');
		        closeAllRollerMenu();
		        TabLoader('5');
		    }

				<%If Request("ID") <> "" Then%>
		    if (prodGroupAdd) {
		        var caller = "opener.document.getElementById('Form1')."+ fieldName;
		        var groupTreeWin = window.open("EcomGroupTree.aspx?CMD=ShowGroupRel&MasterProdID=<%=Request("ID")%>&caller="+ caller,"","displayWindow,width=460,height=400,scrollbars=no");
            }
				<%Else%>
		    alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
		    <%End If%>
			<%Else%>
		    alert("<%=Dynamicweb.Backend.Translate.JsTranslate("Modulet er ikke aktiveret!")%>")
			<%End If%>
		}

        function AddToRelatedProductGroups(){
            var relatedGroupwindow = window.open("EcomRelGrp_Edit.aspx?isPopUp=TRUE", "","displayWindow,width=500,height=400,scrollbars=no")
            if (window.focus) {
                relatedGroupwindow.focus();    
            }
            return false;
        }

        function UpdateRelatedProductGroups(groupName, groupID){
            var ctnr = $('RelatedContext').getElementsByClassName("container containerFixed")[0];
            var newGrp = document.createElement("a");
            newGrp.href = "#";            
            newGrp.onclick = function(){checkTab('RELATED', 8, function(){{ AddRelated('addRelatedChecked',groupID);}});};
            var innerspan = document.createElement("span");
            innerspan.className = "item";
            var innerImg = document.createElement("img");
            innerImg.className = "icon";
            innerImg.src = "/Admin/Images/Ribbon/Icons/Small/Check.png";
            innerspan.appendChild(innerImg);
            innerspan.innerHTML += groupName;
            newGrp.appendChild(innerspan);
            var outerSpan = document.createElement("span");
            outerSpan.appendChild(newGrp);
            ctnr.insertBefore(outerSpan, ctnr.firstChild);
        }

        function AddToRelatedSearch(fieldName) {
            if (fieldName == "addRelatedSearchesChecked") {
                ActivateTabClick('Tab12');
                closeAllRollerMenu();
                TabLoader('12');

                <%If Request("ID") <> "" Then%>
    		    var caller = "opener.document.getElementById('Form1')."+ fieldName;
    		    var groupTreeWin = window.open("EcomGroupTree.aspx?CMD=ShowProductSearchRel&MasterProdID=<%=Request("ID")%>&caller="+ caller,"","displayWindow,width=460,height=400,scrollbars=no");
				<%Else%>
    		    alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
				<%End If%>
    		}
        }

        function IncludeInDiscounts(fieldName) {
            if (fieldName == "includingDiscountsChecked") {
                ActivateTabClick('Tab14');
                closeAllRollerMenu();
                TabLoader('14');
            }

            <%If Request("ID") <> "" Then%>
                var caller = "opener.document.getElementById('Form1')."+ fieldName;
                var discountTreeWin = window.open("../lists/EcomOrderDiscount_List.aspx?CMD=ProdIncludeInDiscounts&ProdID=<%=Request("ID")%>&VariantID=<%=Request("VariantID")%>&caller="+ caller,"","displayWindow,width=860,height=400,scrollbars=no");
            <%Else%>
            alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
            <%End If%>            
        }

        function ExcludeFromDiscounts(fieldName) {
            if (fieldName == "excludingDiscountsChecked") {
                ActivateTabClick('Tab14');
                closeAllRollerMenu();
                TabLoader('14');
            }

            <%If Request("ID") <> "" Then%>
            var caller = "opener.document.getElementById('Form1')."+ fieldName;
            var discountTreeWin = window.open("../lists/EcomOrderDiscount_List.aspx?CMD=ProdExcludeFromDiscounts&ProdID=<%=Request("ID")%>&VariantID=<%=Request("VariantID")%>&caller="+ caller,"","displayWindow,width=860,height=400,scrollbars=no");
            <%Else%>
            alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
            <%End If%>            
        }

        function IncludeDiscounts(discountArr){
            FillDivLayer("LOADING","","PRODDISCOUNT");
            EcomUpdator.document.location.href="../edit/EcomUpdator.aspx?CMD=Product.IncludeInDiscounts&DiscountArr=" + discountArr;            
        }

        function ExcludeDiscounts(discountArr){
            FillDivLayer("LOADING","","PRODDISCOUNT");
            EcomUpdator.document.location.href="../edit/EcomUpdator.aspx?CMD=Product.ExcludeFromDiscounts&DiscountArr=" + discountArr;            
        }

        
        function CheckPrimaryDWRow(chk, rowID) {
            if (!chk.hasClassName('RelatedGroupPrimary')) {
                var inputs = $$("table span.RelatedGroupPrimary");
                inputs.each(function (item) { item.removeClassName('RelatedGroupPrimary'); });
                $('GRPREL_PRIMARY_ID').value = rowID;
            }
            else {
                $('GRPREL_PRIMARY_ID').value = "";
            }
            chk.toggleClassName('RelatedGroupPrimary');
        }

        function CheckDeleteDWRow(rowID, rowCount, layerName, ProductId, prefix, arg1, arg2, message) {
            var totalGroups = parseInt(document.getElementById("DWRowNextLine"+ prefix).value);
            if (parseInt(totalGroups) <= 2) {
                alert("<%=Dynamicweb.Backend.Translate.JsTranslate("Kan ikke slette sidste gruppe!")%>")
    		} else {
    		    DeleteDWRow(rowID,rowCount,layerName,ProductId,prefix,arg1,arg2, message);
    		}
        }

        function AddDetailLine(method, type) {
            ActivateTabClick('Tab3');
            closeAllRollerMenu();

            if (prodDetailAdd) {
                enableClick = true;
                if (method == "ADD") {
                    RemoveNoneline("DWRowNoDetailLine"+ type);
                    closeRollerMenu('DetailLayer');

                    if (type == "0") {
                        AddDWRowLine("DETAILURL", "_E_"+ type);
                    } else {
                        AddDWRowLine("DETAILTXT", "_E_"+ type);
                    }
                }
                if (method == "SHOW") {
                    doGenerelRollerMenu('DetailLayer');
                }

            }
        }


        function DelPropertyLine(method, propID, rowID, prefix, typeId) {
            CallerForDeleteDWRow(propID, rowID, method, propID, prefix, typeId, '');
        }

        function CallerForDeleteDWRow(DWRowid, rowID, typeStr, methodID, prefix, arg1, arg2) {
            showMessage = false;
            var Message = "<%=Translate.JSTranslate("Slet?")%>";
			if (confirm (Message)) {
			    DeleteDWRow(DWRowid, rowID, typeStr, methodID, prefix, arg1, arg2);
			}
			showMessage = true;
        }

        function AddPropertyLine(method, propID) {

            if(_productId.length == 0){
                alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
			    return;
			}

            ActivateTabClick('Tab4');
            closeAllRollerMenu();

            if (prodPropertyAdd) {
                enableClick = true;

                if (method == "ADD") {
                    FillDivLayer("LOADING", "", "PRODPROPREL");
                    AddDWRowFromArry("SETPRODPROPREL", "<%=Request("ID")%>", "", "../Edit/", propID, "")
					closeRollerMenu('PropertyLayer');
                }
                if (method == "SHOW") {
                    var div = document.getElementById('PropertyLayer');
                    div.style.height = document.body.clientHeight / 2;
                    doGenerelRollerMenu('PropertyLayer');
                }

            }

        }


        var methodMode = "";
        var methodGrpId = "";
        var methodId = "";
        function VariantGrpLine(grpID, imgID, methodStr, mID) {

            if(_productId.length == 0){
                alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
			    return;
			}

            if (prodVariantGrpAdd) {
                methodMode = methodStr;
                methodGrpId = grpID;
                methodId = mID;
                if (methodMode == "DEL") {
                    dialog.show('DeleteVariantGroup');
                }
                else{
                    continueDeleteVariantGroup(false);
                }
            }
        }

        function continueDeleteVariantGroup(fromDialog) {
            FillDivLayer("LOADING", "", "VARGRP");
            FillDivLayer("DWNONE", "", "VAROPT");
            setTimeout('AddDelVariantGrpLine()', "10");
            closeRollerMenu('VariantGroupLayer');
            if (fromDialog){
                dialog.hide('DeleteVariantGroup');
            }
         }

        function AddDelVariantGrpLine() {
            if (methodMode == "ADD") {
                AddDWRowFromArry("ADDVARIANTGRPPRODREL", "<%=Request("ID")%>", methodGrpId, "../Edit/", "", "")
			}
            if (methodMode == "DEL") {
                AddDWRowFromArry("DELVARIANTGRPPRODREL", "<%=Request("ID")%>", methodGrpId, "../Edit/", methodId, "")
			}
        }

        function SelectAllVariants() {
            for (var i = 0; i < document.getElementById('Form1').VARCOMBO_singleVarOptLine.length;i++) {
                document.getElementById('Form1').VARCOMBO_singleVarOptLine[i].checked = true;
            }
        }
        function UnSelectAllVariants() {
            for (var i = 0; i < document.getElementById('Form1').VARCOMBO_singleVarOptLine.length;i++) {
                document.getElementById('Form1').VARCOMBO_singleVarOptLine[i].checked = false;
            }
        }

        function changeImgType(mMode, picID, mType) {
            try {
                if (mType == "VARGRP") {
                    if (methodMode == "ADD") {
                        srcStr = "../images/check.gif";
                    } else {
                        srcStr = "../images/empty.gif";
                    }
                }
                if (mType == "VAROPT") {
                    var srcStr = document.getElementById(picID).getAttribute("src");
                    var fileName = GetFileNameFromUrl(srcStr);

                    if (fileName == "empty.gif") {
                        srcStr = "../images/check.gif";
                    } else {
                        srcStr = "../images/empty.gif";
                    }
                }

                if (mType == "VAREXISTS") {
                    if (mMode == "TRUE") {
                        srcStr = "../images/editvariantasprod_small.gif";
                    } else {
                        srcStr = "../images/editvariantasprod_small_dim.gif";
                    }
                }

                if (mType == "VAREXISTS") {
                    if (window.dialogArguments) {
                        dialogArguments.document.getElementById(picID).setAttribute("src",srcStr);
                    } else {
                        window.opener.document.getElementById(picID).setAttribute("src",srcStr);
                    }

						<%If Request("DelVariant") = "1" Then%>
					    if (mMode == "FALSE") {
					        top.close();
					    }
						<%End If%>
					} else {
					    document.getElementById(picID).setAttribute("src",srcStr);
					}

                } catch(e) {
                    //Nothing
                }


				<%If Request("closeVariantWindow") = "true" Then%>
			    top.close();
				<%End If%>
			}

        function changeImgFileName(picID) {
            var srcStr = document.getElementById(picID).getAttribute("src");
            var fileName = GetFileNameFromUrl(srcStr);
            return fileName;
        }

        function FillDivLayer(typeStr, fillData, fillLayer) {
            var fillStr = "",
                doc = Dynamicweb.Ajax.Document.get_current(),
    	        collectionHelper = Dynamicweb.Utilities.CollectionHelper,
                typeHelper = Dynamicweb.Utilities.TypeHelper;

            if (typeStr == "LOADING") {
                fillStr = '<asp:Literal id="LoadBlock" runat="server"></asp:Literal>';
            }


            if (typeStr == "DWNONE") {
                fillStr = '<br />';
            }

            if (fillData != "") {
                fillStr = fillData;
            }

            if (fillLayer == "PRODDETAIL") {
                doc.getElementById('ProductDetailData').innerHTML = fillStr;
            }
            if (fillLayer == "PRODPROPREL") {
                doc.getElementById('ProductProperty').innerHTML = fillStr;
            }
            if (fillLayer == "PRODGRPREL") {
                doc.getElementById('ProductGrpRelData').innerHTML = fillStr;
            }
            if (fillLayer == "PRODPRICE") {
                var loader = Dynamicweb.Ajax.ResourceLoader.get_current(),
                    container = doc.getElementById('ProductPriceData'),
                    collectionHelper = Dynamicweb.Utilities.CollectionHelper,
                    resources = [];
    		    
                if (typeStr == "LOADING") {
                    container.innerHTML = fillStr;
                } else {
                    collectionHelper.forEach(loader.parse(fillStr), function (resource) {
                        if (resource.type !== 'css') {
                            resources.push(resource.url);
                        }
                    });

                    require(resources, function () {
                        Dynamicweb.Ajax.ControlManager.get_current().add_controlReady('PriceMatrix', function (control) {
                            var makeDirty = function () {
                                ProductEdit.isDirty = true;
                            },
                            validation = function (sender, args) {
                                var row = args.row,
                                    validFrom = row.get_propertyValue('ValidFrom'),
                                    validTo = row.get_propertyValue('ValidTo');

                                if ((validFrom && validFrom !== null) && (validTo && validTo !== null)) {
                                    if (validFrom > validTo) {
                                        alert("<%=Dynamicweb.Backend.Translate.JsTranslate("Dates are not valid!")%>")
                                        args.cancel = true;
                                    }
                                }
                            };

    		                control.add_rowCreating(validation);
    		                control.add_rowUpdating(validation);
    		                
                            control.add_rowCreated(function(sender,args){
                                makeDirty(sender,args);

                                var row = args.row,
                                    isInformative = row.get_propertyValue('IsInformative');

                                if(isInformative && isInformative !== null) {
                                    if(isInformative) {
                                        row.set_propertyValue('IsInformative','<%=Backend.Translate.JsTranslate("Yes")%>')
                                    }
                                    else {
                                        row.set_propertyValue('IsInformative','<%=Backend.Translate.JsTranslate("No")%>')
                                    }
                                }
                                else {
                                    row.set_propertyValue('IsInformative','<%=Backend.Translate.JsTranslate("No")%>')
                                }
                                
    		                
    		                });
    		                control.add_rowUpdated(makeDirty);
    		                control.add_rowDeleted(makeDirty);
    		            });

    		            document.loaded = true; //hack for AjaxControl onReady event
    		            container.innerHTML = fillStr;
    		            doc.evalScripts(fillStr);
    		        });
                }
            }
            if (fillLayer == "PRODPRICEPERIODSELECT") {
                doc.getElementById('Price_PeriodSelect').innerHTML = fillStr;
            }
            if (fillLayer == "PRODPRICEVARIANTSELECT") {
                doc.getElementById('Price_VariantSelect').innerHTML = fillStr;
            }
            if (fillLayer == "PRODPRICEUNITSELECT") {
                doc.getElementById('Price_UnitSelect').innerHTML = fillStr;
            }
            if (fillLayer == "PRODVARINT") {
                var loader = Dynamicweb.Ajax.ResourceLoader.get_current(),
                    container = doc.getElementById('ProductVariantData'),
                    collectionHelper = Dynamicweb.Utilities.CollectionHelper,
                    resources = [];

                if (typeStr == "LOADING") {
                    container.innerHTML = fillStr;
                } else {
                    collectionHelper.forEach(loader.parse(fillStr), function (resource) {
                        if (resource.type !== 'css') {
                            resources.push(resource.url);
                        }
                    });

                    require(resources, function () {
                        Dynamicweb.Ajax.ControlManager.get_current().add_controlReady('variantCombinations', function (control) {
                            var VALUE_ALL = '_$ALL_',
                                TRANSLATION_ALL = '<%=Dynamicweb.Backend.Translate.Translate("All")%>',
                                VALIDATION_ERROR = "<%=Dynamicweb.Backend.Translate.JsTranslate("Combinations must be unique!")%>",
                                dataColumns,                                
                                makeDirty = function () {
                                    ProductEdit.isDirty = true;
                                    updateVariantCombinationsText(control.count());
                                },
                                isRowValid = function (row) {
                                    var isValid = true;
                                    if (control.findRow(function (x) { return row.get_id() !== x.get_id() && row.compareTo(x); })) {
                                        isValid = false;
                                    }

                                    return isValid;
                                },
                                validation = function (sender, args) {
                                    if (!args.cancel && sender.findRow(function (x) { return args.row.get_id() !== x.get_id() && args.row.compareTo(x); })) {
                                        alert(VALIDATION_ERROR);
                                        args.cancel = true;
                                    }
                                };

                            updateVariantCombinationsText(control.count());

                            dataColumns = collectionHelper.where(control.get_columns(), function(x){ return !typeHelper.isUndefined(x.editor) && typeHelper.isInstanceOf(x.editor, Dynamicweb.Controls.EditableList.Editors.ComboboxEditor);});

                            control.add_dialogOpening(function (sender, args) {
                                //new one!
                               if (args.row.get_id() === '') {
                                    collectionHelper.forEach(dataColumns, function (column) {
                                        var source, item;
                                        
                                        item = column.editor.findItem(function (x) { return x.value === VALUE_ALL;});
                            
                                        if (!item) {
                                            source = column.editor.get_dataSource();
                                            source.push({value:VALUE_ALL, text: TRANSLATION_ALL});
                                            column.editor.set_dataSource(source);
                                        }
                                    });
                                } else {
                                    collectionHelper.forEach(dataColumns, function (column) {
                                        var item;
                                        item = column.editor.findItem(function (x) { return x.value === VALUE_ALL;});
                            
                                        if (item) {
                                            column.editor.removeItem(item);
                                        }
                                    });
                                }
                            });
    		                
                            control.add_rowUpdating(validation);
                            control.add_rowCreating(validation);
                            control.add_rowCreating(function (sender, args) {
                                var properties = args.row.get_properties(),
                                    hasAllValue = false,
                                    columns = [],
                                    column,
                                    rows,
                                    row,
                                    tmp,
                                    collect;

                                hasAllValue = collectionHelper.any(properties, function (x) { return x === VALUE_ALL });

                                if (hasAllValue) {
                                    collectionHelper.forEach(properties, function (propValue, propName) {
                                        var options,
                                            option,
                                            column = sender.getColumn(propName);

                                        if (column.editor && typeHelper.isFunction(column.editor.get_dataSource)) {
                                            options = [];
                                            
                                            if (propValue === VALUE_ALL) {
                                                collectionHelper.forEach(column.editor.findItems(function (i) {return i.value !== VALUE_ALL;}), function (o){
                                                    options.push({name: column.name, value: o.value});
                                                });
                                            } else {
                                                options.push({name: column.name, value: column.editor.getItem(propValue).value});
                                            }

                                            columns.push(options);
                                        }
                                    });

                                    collect = function () {
                                        return Dynamicweb.Utilities.CollectionHelper.reduce(arguments, function(a, b) {
                                            var ret = [];
                                            collectionHelper.forEach(a, function(a) {
                                                collectionHelper.forEach(b, function(b) {
                                                    ret.push(a.concat([b]));
                                                });
                                            });
                                            return ret;
                                        }, [[]]);
                                    };
                                    
                                    tmp = collect.apply(this, columns);
                                    rows = [];

                                    collectionHelper.forEach(tmp, function (arr){

                                        row = {'SimpleVariant': false};

                                        collectionHelper.forEach(arr, function (o) {
                                            row[o.name] = o.value;
                                        });
                                        if(typeHelper.isUndefined(control.findRow(function (x) { return typeHelper.compare(row, x.get_properties()); }))){
                                            rows.push(row);
                                        }
                                    });
             
                                    if (collectionHelper.any(rows, function (r) {return !typeHelper.isUndefined(control.findRow(function (x) { return typeHelper.compare(r, x.get_properties()); }));})) {
                                        alert(VALIDATION_ERROR);
                                    } else {
                                        control.addRowRange(rows);                                                                                
                                        setTimeout(function () {
                                            sender.get_dialog().cancel();
                                        }, 10);
                                    }

                                    args.cancel = true;
                                } else {
                                    validation(sender, args);                                                                        
                                }                                
                            });
    		                
    		                control.add_rowCreated(makeDirty);
    		                control.add_rowUpdated(makeDirty);
    		                control.add_rowDeleted(makeDirty);
    		            });
    		            
    		            document.loaded = true; //hack for AjaxControl onReady event
    		            container.innerHTML = fillStr;
    		            doc.evalScripts(fillStr);
    		        });
                }
            }
            if (fillLayer == "VARGRP") {
                doc.getElementById('VariantGroupRelData').innerHTML = fillStr;
            }
            if (fillLayer == "VAROPT") {
                doc.getElementById('VariantOptionRelData').innerHTML = fillStr;
            }
            if (fillLayer == "PRODREL") {
                doc.getElementById('ProductRelatedData').innerHTML = fillStr;
            }
            if (fillLayer == "SEARCHREL") {
                doc.getElementById('SearchRelatedData').innerHTML = fillStr;
            }
            if (fillLayer == "PRODUNIT") {
                doc.getElementById('ProductUnitBlock').innerHTML = fillStr;
            }
            if (fillLayer == "PRODSTOCK") {
                doc.getElementById('ProductStockBlock').innerHTML = fillStr;
            }
            if (fillLayer == "PRODITEM") {
                doc.getElementById('ProductItemBlock').innerHTML = fillStr;
            }
            if (fillLayer == "PRODDESC") {
                doc.getElementById('ProductDescBlock').innerHTML = fillStr;
    	
            }
            if (fillLayer == "PRODDESCEDITOR") {
                doc.getElementById('ProductCustomFieldsEditor').innerHTML = fillStr;

                try {
                    var sDescr = eval(document.getElementsByName('ShortDescription'));
                    sDescr.focus();
                } catch(e) {
                    //Nothing
                }
            }
            if (fillLayer == "PRODDISCOUNT") {
                doc.getElementById('ProductDiscountData').innerHTML = fillStr;
            }
            if (fillLayer == "PRODVATGROUP") {
                var loader = Dynamicweb.Ajax.ResourceLoader.get_current(),
                    container = doc.getElementById('ProductVATGroups'),
                    collectionHelper = Dynamicweb.Utilities.CollectionHelper,
                    resources = [];

                if (typeStr == "LOADING") {
                    container.innerHTML = fillStr;
                } else {
                    collectionHelper.forEach(loader.parse(fillStr), function (resource) {
                        if (resource.type !== 'css') {
                            resources.push(resource.url);
                        }
                    });

                    require(resources, function () {
                        Dynamicweb.Ajax.ControlManager.get_current().add_controlReady('VATGroupsList', function (control) {
                            var makeDirty = function () {
                                ProductEdit.isDirty = true;
                            },
                            validation = function (sender, args) {
                                var country = args.row.get_propertyValue('CountryID');
                                if (!args.cancel && sender.findRow(function (x) { return args.row.get_id() !== x.get_id() && country === x.get_propertyValue('CountryID'); })) {
                                    alert("<%=Dynamicweb.Backend.Translate.JsTranslate("It should be only one VAT group for each country!")%>");
                                    args.cancel = true;
                                }
                            };

                            control.add_rowCreating(validation);
                            control.add_rowUpdating(validation);
    		                
                            control.add_rowCreated(makeDirty);
                            control.add_rowUpdated(makeDirty);
                            control.add_rowDeleted(makeDirty);
                        });

                        document.loaded = true; //hack for AjaxControl onReady event
                        container.innerHTML = fillStr;
                        doc.evalScripts(fillStr);
                    });
                }
            }

            if (fillLayer == "SAVE") {
                doc.getElementById('PageHolderStart').innerHTML = fillStr;

                for (var i = 0; i < 12; i++) {
                    try {
                        doc.getElementById('PageContent'+ i).style.display = 'none';
                    } catch(e) {
                        //Nothing
                    }
                }

                doc.getElementById('PageHolderStart').innerHTML = fillStr;
            }

            if(_onloaded != null)
            {
                _onloaded();
                _onloaded = null;
            }
        }

        function updateVariantCombinationsText(count){
            var span = document.getElementById("varinatCombinationsCount");
            if(span){
                span.innerHTML = count;
            }
        }

        function AddRelated(fieldName, RelgrpID) {
            if(_productId.length == 0){
                alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
    		    return;
    		}

            if (prodRelatedAdd) {
                document.getElementById('Form1').addRelatedGrpID.value = RelgrpID;
                var caller = "opener.document.getElementById('Form1')."+ fieldName;
                window.open("EcomGroupTree.aspx?CMD=ShowProd&MasterProdID=<%=Request("ID")%>&caller="+ caller + "&RelgrpID=" + RelgrpID,"","displayWindow,width=460,height=400,scrollbars=no");
            }

            closeRollerMenu('RelatedLayer');
        }

        function AddProductItem(typeMode) {
            <%If Request("ID") <> "" Then%>
            if (prodProdItemAdd) {
                var caller = "opener.document.getElementById('Form1').addProdItemGrpChecked";
                if (typeMode == "ProdItemProd") {
                    caller = "opener.document.getElementById('Form1').addProdItemProdChecked";
                }
                window.open("EcomGroupTree.aspx?CMD="+ typeMode +"&AppendType="+ typeMode +"&MasterProdID=<%=Request("ID")%>&caller="+ caller,"","displayWindow,width=460,height=400,scrollbars=no");
            }
            <%Else%>
            alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the product...")%>")
            <%End If%>
            closeRollerMenu('ProdItemLayer');
        }

        function AddProdItemRows(typeMode, method) {
            var checkedArray = ""
            if (typeMode == "PROD") {
                checkedArray = document.getElementById('Form1').addProdItemProdChecked.value;
            } else {
                checkedArray = document.getElementById('Form1').addProdItemGrpChecked.value;
            }

            if (method == "ADD") {
                FillDivLayer("LOADING", "", "PRODREL");
            }
            setTimeout(""+ AddProdItemRowsPutter(checkedArray, typeMode, method), "10");
        }

        function AddProdItemRowsPutter(checkedArray, typeMode, method) {

            AddDWRowFromArry('PRODITEMS', '<%=Request("ID")%>', checkedArray, '../Edit/', typeMode, method)
		}

		function AddGroupRows(id) {
		    FillDivLayer('LOADING', '', 'PRODGRPREL');

		    var grpArray = document.getElementById('Form1').addGroupsChecked.value;
		    var prodId = '';

		    if (typeof b == 'undefined') {
		        prodId = '<%=Request("ID")%>';
        } else {
            prodId = id;
        }
        setTimeout("AddDWRowFromArry('PRODGROUPS','" + prodId + "', '" + grpArray + "', '../Edit/', '', '');", 500);
    }

    function AddRelatedRows() {
        FillDivLayer("LOADING", "", "PRODREL");
        setTimeout('AddRelatedRowsPutter()', "10");
    }


    function AddRelatedRowsPutter() {
        var grpArray = document.getElementById('Form1').addRelatedChecked.value;
        var relGrpID = document.getElementById('Form1').addRelatedGrpID.value;
        AddDWRowFromArry('PRODRELATED', '<%=Request("ID")%>', grpArray, '../Edit/', relGrpID, '<%=Request("GroupID")%>')
    }

    function AddRelatedSearchRows() {
        FillDivLayer("LOADING", "", "SEARCHREL");
        setTimeout('AddRelatedSearchRowsPutter()', "10");
    }

    function AddRelatedSearchRowsPutter() {
        var grpArray = document.getElementById('Form1').addRelatedSearchesChecked.value;
        var relGrpID = document.getElementById('Form1').addRelatedGrpID.value;
        AddDWRowFromArry('SEARCHRELATED', '<%=Request("ID")%>', grpArray, '../Edit/', relGrpID, '<%=Request("GroupID")%>')
    }

    function removeFromField(grpID) {
        var tmpList = ""
        var listGrp = document.getElementById('Form1').oldGroupsChecked.value;

        tmpList = replaceSubstring(listGrp, "[" + grpID + "];", "")
        tmpList = replaceSubstring(tmpList, "[" + grpID + "]", "")

        document.getElementById('Form1').oldGroupsChecked.value = tmpList;
    }

    function ReloadPage(pageID, tabId) {
        if (pageID != "") {
            document.location.href = "EcomProduct_Edit.aspx?Tab="+ tabId +"&ID="+ pageID;
        }
    }


    function changeVariantStatusGlobal(optionCombo, prodStr, selectBoxID) {
        var statusType = "";

        if (selectBoxID.checked == false) {
            statusType = "DEL";
        } else {
            statusType = "ADD";
        }
        AddDWRowFromArry("VAROPTPRODREL", prodStr, optionCombo, "../Edit/", statusType, "")
    }

    function changeVariantStatusMax2(optionCombo, prodStr, imgID) {
        var statusType = "";
        changeImgType("", imgID, "VAROPT");

        var fn = changeImgFileName(imgID);
        if (fn == "empty.gif") {
            statusType = "DEL";
        } else {
            statusType = "ADD";
        }
        AddDWRowFromArry("VAROPTPRODREL", prodStr, optionCombo, "../Edit/", statusType, "")
    }

    function changeDelBut(objID, counter, calc) {
        document.getElementById('CALCDELBUT'+ objID).src = "../images/editprice_small.gif";

        //EnableCurrencyPriceEdit(counter,calc);

        document.getElementById('CALCHREF'+ objID).removeAttribute("href");
        document.getElementById('CALCHREF'+ objID).href = "javascript:changeDelBut('"+ objID +"','"+ counter +"','"+ calc +"')";
    }


    function changeCheckedVariantCount(elem,amount) {
        var oldValue = parseInt(document.getElementById('prodVariantCheckedCnt').value);
        var newValue = 0;

        if (elem.checked == false) {
            newValue = oldValue - parseInt(amount);
        } else {
            newValue = oldValue + parseInt(amount);
        }

        document.getElementById('prodVariantCheckedCnt').value = newValue;
    }

    function uncheckCheckBox(cbElem){
        if(cbElem.checked)
            cbElem.checked = false;
    }

    function addVariantOption(group, param) {
        addVariantOption.dialogID = 'AddVariantOption';

        if(!addVariantOption.dialog) {
            addVariantOption.dialog = $(addVariantOption.dialogID);
        }

        if (!addVariantOption.input) {
            addVariantOption.input = addVariantOption.dialog.select('input')[0];
        }

        addVariantOption.input.value = param.item.text;
        addVariantOption.param = param;
        addVariantOption.group = group;

        if (confirm('<%=Backend.Translate.Translate("Variant option does not exist. Do you want to create it?")%>')) {
            dialog.show(addVariantOption.dialogID);
            addVariantOption.input.focus();
        } else {
            param.cancel();
        }
    }
    
    function addVariantOptionComplete() {
        var over = new overlay('ProductEditOverlay');
        if (addVariantOption.param) {

            if (!addVariantOption.input.value) {
                alert('<%= Backend.Translate.Translate("Name can not be empty.")%>')
                return;
            }

            new Ajax.Request('/Admin/Module/eCom_Catalog/dw7/Edit/EcomUpdator.aspx', {
                method: 'GET',
                parameters: {
                    'CMD' : 'CreateVariantOption',
                    'ID' : '<%=Base.Request("ID")%>',
                    'LangID' :'<%=eCommerce.Common.Context.LanguageID %>',
                    'VariantGroupID' : addVariantOption.group,
                    'VariantOptionName' : addVariantOption.input.value
                },
                onCreate: function () {
                    over.show();
                },
                onSuccess: function (transport) {
                    if (transport.responseText) {
                        addVariantOption.param.complete({
                            text: addVariantOption.input.value,
                            value: transport.responseText
                        });
                    } else {
                        alert('<%=Backend.Translate.Translate("Creation is FAILED.")%>');
                        addVariantOption.param.cancel();
                    }
                },
                onFailure: function () {
                    alert('<%=Backend.Translate.Translate("Unexpected internal error.")%>');
                    addVariantOption.param.cancel();
                },
                onComplete: function () {
                    setTimeout(function() {
                        dialog.hide(addVariantOption.dialogID);
                        over.hide();
                    }, 100);
                }
            });
        }
    }

    function addVariantOptionCancel() {
        if (addVariantOption.param) {
            dialog.hide(addVariantOption.dialogID);
            addVariantOption.param.cancel();
        }
    }

    function sortVariant(a, b, key) {
        var column,
            option,
            vA = a, 
            vB = b, 
            helper = Dynamicweb.Utilities.CollectionHelper,
            func = function (v1, v2) {
                if (v1 > v2) {
                    return 1;
                }
                        
                if (v1 < v2) {
                    return -1;
                }
                    
                return 0;
            };

        // memorize columns
        if (!sortVariant.cache) {
            sortVariant.cache = new Dynamicweb.Utilities.Dictionary();
            helper.forEach(variantCombinations_EditableList.get_columns(), function(c) {
                var options;
                
                if (c.editorMetadata) {
                    options = new Dynamicweb.Utilities.Dictionary();

                    helper.forEach(c.editorMetadata.options || [], function (o){
                        options.add(o.value, o);
                    });

                    sortVariant.cache.add(c.name, options);
                }
            });
        }

        column = sortVariant.cache.get(key);

        if (column) {
            option = column.get(a);
            
            if (option) {
                vA = option.text;
            }

            option = column.get(b);
     
            if (option) {
                vB = option.text;
            }
        }

        return func(vA, vB);
    }

    function getVariantIcon(variant) {
        var result = '';
        if (variant.get_state() !== Dynamicweb.Controls.EditableList.Enums.ModelState.NEW) {
            if (variant.get_propertyValue('SimpleVariant')) {
                result = '../images/editvariantasprod_small_dim.gif'
            } else {
                result = '../images/editvariantasprod_small.gif'
            }
        }

        return result;
    }

    function openVariant(variant, column) {
        var productId = '<%=prodId %>',
		        collHelper = Dynamicweb.Utilities.CollectionHelper,
		        values = collHelper.where(variant.get_properties(), function (value, prop) { return prop !== 'SimpleVariant'; });

		    gotoVariant(productId, '', values.join('.'), !variant.get_propertyValue('SimpleVariant'), function () {
		        variant.set_propertyValue('SimpleVariant', false);
		    });
		}

		function gotoVariant(prodId, groupID, variantId, found, callback) {
		    var screenWidth = screen.width;
		    var screenHeight = screen.height;
		    var minusWidth = (screenWidth / 4);
		    var minusHeight = (screenHeight / 4);

		    var width = screenWidth - minusWidth;
		    var height = screenHeight - minusHeight;

		    var left = (screenWidth - width)/2;
		    var top = (screenHeight - height)/2;

		    var variantPage = "EcomProduct_Edit.aspx?ID="+ prodId +"&GroupID="+ groupID +"&VariantID="+ variantId + "&Found=" + found + "&ecom7master=hidden";

		    if (variantPage != "") {
		        var VariantWin = window.open(variantPage, "" , "displayWindow,left="+left+",top="+top+",screenX="+left+",screenY="+top+",width="+width+",height="+height+",scrollbars=no");
		        VariantWin.onProductSaveCallback = callback || function () {};
		        //var VariantWin = window.showModalDialog(page, window, "dialogWidth:"+width+"px;dialogHeight:"+height+"px;dialogLeft:"+left+"px;dialogTop:"+top+"px;center:yes;help:no;status:yes;scroll:no;");
		    }
		}

		function showAllVariants(){
		    FillDivLayer("LOADING", "", "PRODVARINT");
		    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.VariantList&ShowAllVariantOptions=True";
		}

		function EnableCurrencyMatrixPrice(LineNumb, Currency) {
		    var hideField =	document.getElementById('PRICEMATRIXLINES_Hide'+ LineNumb +'_'+ Currency);
		    var amountField = document.getElementById('PRICEMATRIXLINES_Amount'+ LineNumb +'_'+ Currency);

		    if (hideField.value == "1") {
		        amountField.focus();
		        if (navigator.appName.indexOf("Microsoft") != -1) {
		            amountField.style.filter = "";
		        }else {
		            amountField.style.opacity = "1";
		        }

		        if (document.selection) {
		            var amountValue = amountField.value
		            amountField.focus();
		            amountField.value = "";
		            sel = document.selection.createRange();
		            sel.text = amountValue;
		        }
		        amountField.select();

		        hideField.value = "0";
		    } else {
		        //amountField.onfocus = "";
		        //amountField.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";

		        //hideField.value = "1";
		    }

		}

		function DisableCurrencyMatrixPrice(LineNumb, Currency, checkCtrl, e) {
		    //var evtobj = window.event ? window.event : window.Event
		    if (e.ctrlKey == true || checkCtrl == false) {
		        var hideField =	document.getElementById('PRICEMATRIXLINES_Hide'+ LineNumb +'_'+ Currency);
		        var amountField = document.getElementById('PRICEMATRIXLINES_Amount'+ LineNumb +'_'+ Currency);
		        var oldAmountField = document.getElementById('PRICEMATRIXLINES_OldAmount'+ LineNumb +'_'+ Currency);

		        amountField.value = oldAmountField.value;
		        if (navigator.appName.indexOf("Microsoft") != -1) {
		            amountField.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";
		        }else {
		            amountField.style.opacity = "0.3";
		        }
		        hideField.value = "1";
		    } else {
		        return false;
		    }
		}

		function checkLength(LineNumb, Currency, e) {
		    var amountField = document.getElementById('PRICEMATRIXLINES_Amount'+ LineNumb +'_'+ Currency);

		    if (amountField.length <= 0 || amountField.value == 0) {
		        amountField.value = 0;
		        DisableCurrencyMatrixPrice(LineNumb, Currency, false, e);
		    }
		}


		function changeRowColor(objRow, method){
		    if (method == "over") {
		        objRow.style.backgroundColor='#f3f1e7';
		    } else {
		        objRow.style.backgroundColor='';
		    }
		}

		function changeRowColorClass(objRow, method){
		    if (method == "over") {
		        objRow.className = 'OutlookItemOver';
		    } else {
		        objRow.className = 'OutlookItem';
		    }
		}

		function help(){
		<%=Dynamicweb.Gui.Help("", "ecom.productlist.edit", "en") %>
		}

    </script>

    <script type="text/javascript">
        function sortProductItems() {
            var elem = document.getElementById("PRODITEMHOLDER");
            var sort = document.getElementById("PRODITEMSORTER")

            if (elem.style.display == '') {
                elem.style.display = 'none';
                sort.style.display = '';

                EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.Item.Sort";
            } else {
                elem.style.display = '';
                sort.style.display = 'none';
            }
        }

        function fillProductItems(fillStr) {
            var sort = document.getElementById("SORTEDLIST")
            sort.innerHTML = fillStr;
        }

        function submitSortProductItems(){
            var values = ""
            var elem = document.getElementById("ElemSort")
            for (i = 0; i < elem.length; i++) {
                if (values == "") {
                    values = elem.options[i].value;
                } else {
                    values +=  ";" + elem.options[i].value;
                }
            }
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMDSort=SAVE&CMD=Product.Item.Sort&ElemSort="+ values;
        }

        function sortReleatedProducts(grpId) {
            var elem = document.getElementById("RELGRPHOLDER_" + grpId);
            var sort = document.getElementById("RELGRPSORTER_" + grpId)

            if (elem.style.display == '') {
                elem.style.display = 'none';
                sort.style.display = '';

                EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.Releated.Sort&GroupID="+ grpId;
            } else {
                elem.style.display = '';
                sort.style.display = 'none';
            }
        }


        function fillReleatedProducts(grpId, fillStr) {
            var sort = document.getElementById("SORTEDLIST_" + grpId)
            sort.innerHTML = fillStr;
        }


        function checkSortInput(grpId) {
            var elem = document.getElementById("ElemSort"+ grpId)
            //elem.multiple = true;

            setTimeout(""+ submitSort(grpId), 200);
        }

        function submitSort(grpId){
            var values = ""
            var elem = document.getElementById("ElemSort"+ grpId)
            for (i = 0; i < elem.length; i++) {
                //elem.options[i].selected = true;


                if (values == "") {
                    values = elem.options[i].value;
                } else {
                    values +=  ";" + elem.options[i].value;
                }
            }
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMDSort=SAVE&CMD=Product.Releated.Sort&GroupID="+ grpId +"&ElemSort"+ grpId +"="+ values;
        }
        function MoveSortUp(grpId){
            try {
                var elem = document.getElementById("ElemSort"+ grpId)
                ID = elem.selectedIndex;

                if (ID != 0) {
                    val1 = elem[ID - 1].value;
                    val2 = elem[ID - 1].text;
                    elem.options[ID - 1] = new Option(elem[ID].text, elem[ID].value);
                    elem.options[ID] = new Option(val2, val1);
                    elem.options[ID - 1].selected = true;
                    ToggleImage(ID - 1,grpId);
                }
            } catch(e) {
                alert(e);
                //Nothing
            }
        }

        function MoveSortDown(grpId){
            try {
                var elem = document.getElementById("ElemSort"+ grpId)
                ID = elem.selectedIndex;

                if (ID != elem.length - 1) {
                    val1 = elem[ID + 1].value;
                    val2 = elem[ID + 1].text;
                    elem.options[ID + 1] = new Option(elem[ID].text, elem[ID].value);
                    elem.options[ID] = new Option(val2, val1);
                    elem.options[ID + 1].selected = true;
                    ToggleImage(ID + 1,grpId);
                }
            } catch(e) {
                alert(e);
                //Nothing
            }
        }

        function ToggleImage(ID, grpId){
            var imgUp = document.getElementById("up"+ grpId)
            var imgDown = document.getElementById("down"+ grpId)
            var elem = document.getElementById("ElemSort"+ grpId)

            if (ID > -1) {
                if (ID == 0) {
                    imgUp.src = "/Admin/images/Collapse_inactive.gif";
                    imgUp.alt = "";
                } else {
                    imgUp.src = "/Admin/images/Collapse.gif";
                    imgUp.alt = "<%=Translate.JsTranslate("Flyt op")%>";
                }

                if (ID == elem.length - 1) {
                    imgDown.src = "/Admin/images/Expand_inactive.gif";
                    imgDown.alt = "";
                } else {
                    imgDown.src = "/Admin/images/Expand_active.gif";
                    imgDown.alt = "<%=Translate.JsTranslate("Flyt ned")%>";
                }
            } else {
                imgUp.src = "/Admin/images/Collapse_inactive.gif";
                imgUp.alt = "";
                imgDown.src = "/Admin/images/Expand_inactive.gif";
                imgDown.alt = "";
            }
        }
    </script>

    <script>
        var IE = document.all?true:false;
        if (!IE) document.captureEvents(Event.MOUSEMOVE);

        var tempX = 0;
        var tempY = 0;
        var tmpPriceLine = null;
        function getMouseXY(e) {
            if (IE) {
                tempX = event.clientX + document.body.scrollLeft;
                tempY = event.clientY + document.body.scrollTop;
            } else {
                tempX = e.pageX;
                tempY = e.pageY;
            }
            tempX = tempX - 10;

            // catch possible negative values in NS4
            if (tempX < 0){tempX = 0}
            if (tempY < 0){tempY = 0}
            return true
        }

        function SelectPriceSelectors(layerName, lineID){
            tmpPriceLine = lineID;

            if (layerName == 'Price_UnitSelect') {
                if (tempX > 0) {
                    tempX = tempX - 140;
                }
            }
            if (layerName == 'Price_VariantSelect') {
                if (tempX > 0) {
                    tempX = tempX - 30;
                }
            }



            doGenerelRollerMenu(layerName, tempX, tempY);
        }

        //PERIOD
        function SetPeriodInfo(perID) {
            perName = document.getElementById('PeriodProperty'+ perID).value;
            SetPricePeriod(perID,perName);
        }

        function SetPricePeriod(perID, perName) {
            if (tmpPriceLine != null) {
                document.getElementById('PRICE_PeriodID'+ tmpPriceLine).value = perID;
                document.getElementById('PRICE_Period'+ tmpPriceLine).value = perName;
            }

            try {
                closeRollerMenu('Price_PeriodSelect');
            } catch(e) {
                //Nothing
            }
        }

        //VARIANT
        function SetVariantInfo(varID) {
            varName = document.getElementById('VariantProperty'+ varID).value;
            SetPriceVariant(varID,varName);
        }


        function SetPriceVariant(varID, varName) {
            if (tmpPriceLine != null) {
                document.getElementById('PRICE_VariantID'+ tmpPriceLine).value = varID;
                document.getElementById('PRICE_Variant'+ tmpPriceLine).value = varName;
            }

            try {
                closeRollerMenu('Price_VariantSelect');
            } catch(e) {
                //Nothing
            }
        }

        //UNIT
        function SetPriceUnit(unitID, unitName) {
            if (tmpPriceLine != null) {
                document.getElementById('PRICE_UnitID'+ tmpPriceLine).value = unitID;
                document.getElementById('PRICE_Unit'+ tmpPriceLine).value = unitName;
            }

            try {
                closeRollerMenu('Price_UnitSelect');
            } catch(e) {
                //Nothing
            }
        }

        function changeAType(mMode, anchorID) {
            try {
                if (mMode == "TRUE") {
                    hrefStr = "javascript:gotoVariant('<%=prodId%>','<%=groupId%>','<%=variantId%>','True')";
    			} else {
    			    hrefStr = "javascript:gotoVariant('<%=prodId%>','<%=groupId%>','<%=variantId%>','False')";
    			}
                if (window.dialogArguments) {
                    dialogArguments.document.getElementById(anchorID).setAttribute("href",hrefStr);
                } else {
                    window.opener.document.getElementById(anchorID).setAttribute("href",hrefStr);
                }
            } catch(e) {
                //Nothing
            }
        }

        function showProductsInBOMGroup(rowID, itemID) {
            if ($('PI_BOMProdListRow'+ rowID).style.display == '') {
                $('PI_BOMProdListRow'+ rowID).style.display = 'none';
                if($('PI_BOMProdListNoProductRow'+ rowID)){
                    $('PI_BOMProdListNoProductRow'+ rowID).style.display = 'none';
                }
                $('BOM_'+ itemID).setAttribute("src","../images/group_in.png");
            } else {
                $('PI_BOMProdListRow'+ rowID).style.display = '';
                if($('PI_BOMProdListNoProductRow'+ rowID)){
                    $('PI_BOMProdListNoProductRow'+ rowID).style.display = '';
                }
                $('BOM_'+ itemID).setAttribute("src","../images/group_out.png");
            }
        }

        function fillProductsInBOMGroup(rowID, fillValue) {
            try {
                var div = eval('PI_BOMProdList'+ rowID);
                div.innerHTML = fillValue;
            } catch(e) {
                //Nothing
            }
        }

        function setDefaultProductForBOMGroup(rowID, productID) {
            document.getElementById('PRODITEM_DefaultProductID'+ rowID).value = productID;
        }


        function addOption(theSel, theText, theValue) {
            var newOpt = new Option(theText, theValue);
            var selLength = theSel.length;
            theSel.options[selLength] = newOpt;
        }

        function deleteOption(theSel, theIndex) {
            var selLength = theSel.length;
            if(selLength>0) {
                theSel.options[theIndex] = null;
            }
        }

        function moveOption(theSelFrom, theSelTo) {
            if (HideMatrix()) {
                var selLength = theSelFrom.length;
                var selectedText = new Array();
                var selectedValues = new Array();
                var selectedCount = 0;
                var i;

                // Find the selected Options in reverse order
                // and delete them from the 'from' Select.
                for(i=selLength-1; i>=0; i--) {
                    if(theSelFrom.options[i].selected) {
                        selectedText[selectedCount] = theSelFrom.options[i].text;
                        selectedValues[selectedCount] = theSelFrom.options[i].value;
                        deleteOption(theSelFrom, i);
                        getMultiplePriceIndex(null);
                        selectedCount++;
                    }
                }

                // Add the selected text/values in reverse order.
                // This will add the Options to the 'to' Select
                // in the same order as they were in the 'from' Select.
                for(i=selectedCount-1; i>=0; i--) {
                    addOption(theSelTo, selectedText[i], selectedValues[i]);
                }
            }
        }

        function MoveUp(){
            if (HideMatrix()) {
                try {
                    ID = document.getElementById('Form1').MatrixSelected.selectedIndex;
                    if (ID != 0) {
                        val1 = document.getElementById('Form1').MatrixSelected[ID - 1].value;
                        val2 = document.getElementById('Form1').MatrixSelected[ID - 1].text;
                        document.getElementById('Form1').MatrixSelected.options[ID - 1] = new Option(document.getElementById('Form1').MatrixSelected[ID].text, document.getElementById('Form1').MatrixSelected[ID].value);
                        document.getElementById('Form1').MatrixSelected.options[ID] = new Option(val2, val1);
                        document.getElementById('Form1').MatrixSelected.options[ID - 1].selected = true;
                    }
                } catch(e) {
                    //Nothing
                }
            }
        }

        function MoveDown(){
            if (HideMatrix()) {
                try {
                    ID = document.getElementById('Form1').MatrixSelected.selectedIndex;
                    if (ID != document.getElementById('Form1').MatrixSelected.length - 1) {
                        val1 = document.getElementById('Form1').MatrixSelected[ID + 1].value;
                        val2 = document.getElementById('Form1').MatrixSelected[ID + 1].text;
                        document.getElementById('Form1').MatrixSelected.options[ID + 1] = new Option(document.getElementById('Form1').MatrixSelected[ID].text, document.getElementById('Form1').MatrixSelected[ID].value);
                        document.getElementById('Form1').MatrixSelected.options[ID] = new Option(val2, val1);
                        document.getElementById('Form1').MatrixSelected.options[ID + 1].selected = true;
                    }
                } catch(e) {
                    //Nothing
                }
            }
        }

        function HideMatrix() {
            var hide = document.getElementById("HideTheMatrix").value;
            if (hide == "0") {
                if (confirm("<%=Translate.JSTranslate("Alle priser bliver slettet!")%>\n<%=Translate.JsTranslate("Continue?")%>")) {
			        document.getElementById("HideTheMatrix").value = "1";
			        document.getElementById("MatrixSchema").style.display = "none";
			        return true;
			    } else {
			        document.getElementById("HideTheMatrix").value = "0";
			        document.getElementById("MatrixSchema").style.display = "";
			        return false;
			    }
			} else {
			    return true;
			}

        }

        function getMultiplePriceIndex(elem) {
            try {
                ID = elem.selectedIndex;
                val1 = document.getElementById('Form1').MatrixSelected[ID].value;
                val2 = document.getElementById('Form1').MatrixSelected[ID].text;

                if (val1 == 'MULTIPLEPRICES') {
                    document.getElementById('PriceMatrix_MULTIPLEPRICES').style.display = '';
                } else {
                    document.getElementById('PriceMatrix_MULTIPLEPRICES').style.display = 'none';
                }
            } catch(e) {
                try {
                    document.getElementById('PriceMatrix_MULTIPLEPRICES').style.display = 'none';
                } catch(e) {
                    //Nothing
                }
            }
        }

        /*******************************
		* LOADER FOR TAB CLICKS
		*******************************/

        function TabLoader(tabName) {

            if (tabName == "DESCRIPTION")
            {
                loadDescriptionTab();
                return;
            }

            toggleRibbonButtons(true);

            if (tabName == "GENERAL" || tabName == "1") {
                strHelpTopic = 'ecom.productman.product.edit.general';
            }

            if (tabName == "DETAIL" || tabName == "3") {
                strHelpTopic = 'ecom.productman.product.edit.media';
                if ($('ProductDetailData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODDETAIL");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.DetailList";
                }
            }

            if (tabName == "PROPERTY" || tabName == "4") {
                strHelpTopic = 'ecom.productman.product.edit.fields';
                if ($('ProductProperty').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODPROPREL");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.PropertyList";
                }
            }

            if (tabName == "GROUP" || tabName == "5") {
                strHelpTopic = 'ecom.productman.product.edit.groups';
                if ($('ProductGrpRelData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODGRPREL");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.GroupList";
                }
            }

            if (tabName == "PRICE" || tabName == "6") {
                strHelpTopic = 'ecom.productman.product.edit.prices';
                if ($('ProductPriceData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODPRICE");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.PriceList";
                }
            }

            if (tabName == "VARIANTS" || tabName == "7") {
                strHelpTopic = 'ecom.productman.product.edit.variants';
                if ($('ProductVariantData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODVARINT");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.VariantList";
                }
            }


            if (tabName == "RELATED" || tabName == "8") {
                strHelpTopic = 'ecom.productman.product.edit.related';
                if ($('ProductRelatedData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODREL");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.RelatedList&GroupID=<%=Request("GroupID")%>";
                }
            }

            if (tabName == "RELATEDSEARCHES" || tabName == "12") {
                strHelpTopic = 'ecom.productman.product.edit.related';
                if ($('SearchRelatedData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "SEARCHREL");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.RelatedSearches&GroupID=<%=Request("GroupID")%>";
                }
            }

            if (tabName == "UNIT" || tabName == "10") {
                strHelpTopic = 'ecom.productman.product.edit.stock';
                if ($('ProductUnitBlock').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODUNIT");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.UnitList";
                }
            }

            if (tabName == "STOCK" || tabName == "13") {
                strHelpTopic = 'ecom.productman.product.edit.stock';
                if ($('ProductStockBlock').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODSTOCK");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.StockList";
                }
            }

            if (tabName == "ITEM" || tabName == "11") {
                strHelpTopic = 'ecom.productman.product.edit.partslist';
                if ($('ProductItemBlock').innerHTML == "") {
                    //if (prodProdItemAdd) {
                    FillDivLayer("LOADING", "", "PRODITEM");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.ItemList";
                    //}
                }
            }

            if (tabName == "DISCOUNT" || tabName == "14") {
                strHelpTopic = 'ecom.productman.product.edit.discounts';
                if ($('ProductDiscountData').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODDISCOUNT");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.DiscountList";
                }
            }

            if (tabName == "VATGROUP" || tabName == "15") {
                strHelpTopic = 'ecom.productman.product.edit.vatgroups';
                if ($('ProductVATGroups').innerHTML == "") {
                    FillDivLayer("LOADING", "", "PRODVATGROUP");
                    EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Product.VATGroupList";
                }
            }
        }

        function setScrollHeight()
        {
            var nav = parent.document.getElementById('DW_Ecom_Nav');
            var tab = document.getElementById('tabPlace');

            if(!document.all && (nav && tab))
                tab.style.height = nav.scrollHeight - 100;
        }

        function fileArchiveOnKeyUp(fileArchive) {
            // http:// is needed as a prefix for MindWorking Mediadatabase!
            //			if(!isProductImageSource(fileArchive)) return;
            //			if(fileArchive.value.indexOf('://') != -1){
            //				alert('<%=Translate.JsTranslate("Http and ftp adresses are not allowed in this field.") %>');
		    //				fileArchive.value = Mid(fileArchive.value, fileArchive.value.indexOf('://') + 3, fileArchive.value.length);
		    //			}
		}

        function fileArchiveOnChange(fileArchive){
            fileArchiveOnKeyUp(fileArchive);
        }

        function isProductImageSource(fileArchive){
            var name = fileArchive.name;
            if(name == 'ProductImageSmall' || name == 'ProductImageMedium' || name == 'ProductImageLarge'){
                return true;
            }else{
                return false;
            }
        }

        function Mid(str, start, len){
            if (start < 0 || len < 0) return "";
            var iEnd, iLen = String(str).length;
            if (start + len > iLen){
                iEnd = iLen;
            }else{
                iEnd = start + len;
            }

            return String(str).substring(start, iEnd);
        }

        function LoadMindworkingProductSheetEditor(){
            var mindworkingEditor = window.open("/Admin/Module/MwProductSheet/MwProductSheet_ProductSetup.aspx?id=<%=Base.Request("ID")%>", "MW", 'resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=500,height=150,left=200,top=120');
    	    mindworkingEditor.focus();
    	}

    	var commentsUrl = '';
    	function comments(){
    	    commentsUrl = '/Admin/Content/Comments/List.aspx?Type=ecomProduct&ItemID=<%=Base.Request("ID")%>&LangID=<%=eCommerce.Common.Context.LanguageID %>';
    	    dialog.show('CommentsDialog');
    	    document.getElementById("CommentsFrame").src = commentsUrl;
    	}

		<% If Not UseEditors then %>
        window.onload = function() { InitFckEditorProductCategoriesFields(); }
        <% End If%>       
    </script>

    <%If Request("ImgChange") <> "" Then%>

    <script type="text/javascript">
        changeAType("<%=Request("ImgChange")%>", "EditVarA_<%=variantId%>")
        changeImgType("<%=Request("ImgChange")%>", "EditVarImg_<%=prodId%>_<%=variantId%>", "VAREXISTS")
    </script>

    <% End If%>


    <script type="text/javascript">
        function reloadSMP(id)
        {          
            <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&ID=' + id + '&ecomPublish=true' + '&prodId=' + '<%=Me.prodId%>');
            <%=Me.pupCreateMessage.ClientInstanceName%>.reload();
        }

        function showSMP()
        {
            var name = encodeURIComponent($('<%=Me.Name.ClientID%>').value);
            var desc = "";
            if($('LongDescription').value.length > 0 ){
                desc = encodeURIComponent($('LongDescription').value.stripTags());
            }else if($('ShortDescription').value.length > 0 ){
                desc = encodeURIComponent($('ShortDescription').value.stripTags());
            } else if($('<%=Me.MetaDescr.ClientID%>').value.length > 0 ){
                desc = encodeURIComponent($('<%=Me.MetaDescr.ClientID%>').value.stripTags());
            }
    var img = "";
    if($('ProductImageSmall').value.length > 0 ){
        img = encodeURIComponent($('ProductImageSmall').value);
    }else if($('ProductImageMedium').value.length > 0 ){
        img = encodeURIComponent($('ProductImageMedium').value);
    } else if($('ProductImageLarge').value.length > 0 ){
        img = encodeURIComponent($('ProductImageLarge').value);
    }
            <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&name=' + name + '&desc=' + desc + '&ecomPublish=true&ProductID=' + '<%=Me.prodId%>' + '&prodId=' + '<%=Me.prodId%>' + '&img=' + img);
            <%=Me.pupCreateMessage.ClientInstanceName%>.show();
        }

        function hideSMP()
        {                 
            <%=Me.pupCreateMessage.ClientInstanceName%>.hide();
        }

        var _MetaTitleCounterMaxId = '<%=MetaTitleCounterMax.ClientID%>';
        var _MetaKeywordsCounterMaxId = '<%=MetaKeywordsCounterMax.ClientID%>';
        var _MetaDescrCounterMaxId = '<%=MetaDescrCounterMax.ClientID%>';

        var ElemCounter;

        function ShowCounters(field, counter, counterMax) {

            HideCounter();

            if (field == null || field == 'undefined') return;

            var elemCounter = document.getElementById(counter);
            if (elemCounter == null || elemCounter == 'undefined') return;

            var elemCounterMax = document.getElementById(counterMax);
            if (elemCounterMax == null || elemCounterMax == 'undefined') return;

            ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
            ElemCounter = elemCounter;

        }

        function HideCounter() {
            if (ElemCounter) {
                setTextContent(ElemCounter, '');
            }
        }


        function CheckAndHideCounter(field, counter, counterMax) {

            if (CheckCounter(field, counter, counterMax) == true) {

                HideCounter();
            }
        }

        function CheckCounter(field, counter, counterMax) {

            if (field == null || field == 'undefined') return false;

            var elemCounter = document.getElementById(counter);
            if (elemCounter == null || elemCounter == 'undefined') return false;

            var elemCounterMax = document.getElementById(counterMax);
            if (elemCounterMax == null || elemCounterMax == 'undefined') return false;

            ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
            return true;
        }

        function ShowCounter(elemCounter, maxSize, currentSize) {

            if (currentSize < maxSize) {
                setTextContent(elemCounter, (maxSize - currentSize) + ' ' + '<%=Translate.JsTranslate("remaining before recommended maximum")%>');
    		}
    		else {
    		    setTextContent(elemCounter, '<%=Translate.JsTranslate("recommended maximum exceeded")%>');
    		}

            var sizeInPercentage = 100;

            if (maxSize > 0) {
                sizeInPercentage = currentSize * 100 / maxSize;
            }

            if (sizeInPercentage < 80) {
                elemCounter.style.color = '#7F7F7F';
            }
            else if (sizeInPercentage < 90) {
                elemCounter.style.color = '#000000';
            }
            else {
                elemCounter.style.color = '#FF0000';
            }
        }

        function setTextContent(element, text) {
            while (element.firstChild !== null) {
                element.removeChild(element.firstChild); // remove all existing content
            }
            element.appendChild(document.createTextNode(text));
        }

        function showStockEditDialog(rowId){
            if(rowId){
                $('trID').style.display ='';
                $('id_tmp').value = rowId;
                if($$('#ddlStockLocation option[value=\'' + $('PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId).value + '\']').first()){
                    $('ddlStockLocation').selectedIndex = $$('#ddlStockLocation option[value=\'' + $('PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId).value + '\']').first().index;
                    if($('ddlStockLocation')[$('ddlStockLocation').selectedIndex].text == ""){                       
                        $('ddlStockLocation').value = '0';
                    }
                }else{
                    $('ddlStockLocation').selectedIndex = 0;
                }

                if($('ddlUnit').selectedIndex = $$('#ddlUnit option[value=\'' + $('PRODSTOCKUNIT_ID' + rowId).value + '\']').first()){
                    $('ddlUnit').selectedIndex = $$('#ddlUnit option[value=\'' + $('PRODSTOCKUNIT_ID' + rowId).value + '\']').first().index;
                }else{
                    $('ddlUnit').selectedIndex = 0;
                }

                $$('#nsAmount')[0].value = $$('#' + rowId + ' td').pluck('innerHTML')[2].stripTags().replace('&nbsp;','');
                $$('#nsVolume')[0].value = $$('#' + rowId + ' td').pluck('innerHTML')[3].stripTags().replace('&nbsp;','');
                $$('#nsWeight')[0].value = $$('#' + rowId + ' td').pluck('innerHTML')[4].stripTags().replace('&nbsp;','');
                $('UpdateRowID').value = rowId;
            }else{

                if($('id_tmp').value == $('PRODSTOCKUNIT_LAST_ROW_ID').value){
                    $('id_tmp').value = parseInt($('PRODSTOCKUNIT_LAST_ROW_ID').value) + 1;
                    $('PRODSTOCKUNIT_LAST_ROW_ID').value = $('id_tmp').value;
                }else{
                    $('id_tmp').value = $('PRODSTOCKUNIT_LAST_ROW_ID').value;
                }

                $('ddlStockLocation').value = '0';
                $('ddlUnit').value = '0';
                $$('#nsAmount')[0].value = '<%=String.Format("0{0}00", Base.GetCulture().NumberFormat.NumberDecimalSeparator)%>';
                $$('#nsVolume')[0].value = '<%=String.Format("0{0}00", Base.GetCulture().NumberFormat.NumberDecimalSeparator)%>';
                $$('#nsWeight')[0].value = '<%=String.Format("0{0}00", Base.GetCulture().NumberFormat.NumberDecimalSeparator)%>';

                $('UpdateRowID').value = "";
            }
            dialog.show('StockEditDialog');
        }

        function updateStockRow(rowId){
            if(validateRow(rowId)){
                $('PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId).value = $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].value;
                $('PRODSTOCKUNIT_ID' + rowId).value = $('ddlUnit')[$('ddlUnit').selectedIndex].value;
                $('PRODSTOCKUNIT_QUANTITY' + rowId).value = $$('#nsAmount')[0].value;
                $('PRODSTOCKUNIT_VOLUME' + rowId).value = $$('#nsVolume')[0].value;
                $('PRODSTOCKUNIT_WEIGHT' + rowId).value = $$('#nsWeight')[0].value;

                $$('#' + rowId + ' td')[0].update('<span style="margin-left:5px;">' + (($('ddlStockLocation').value == '0') ? "" : $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].text) + '</span>');
                $$('#' + rowId + ' td')[1].update('<span style="margin-left:5px;">' + $('ddlUnit')[$('ddlUnit').selectedIndex].text + '</span>');
                $$('#' + rowId + ' td')[2].update('<span style="margin-left:5px;">' + $$('#nsAmount')[0].value + '</span>');
                $$('#' + rowId + ' td')[3].update('<span style="margin-left:5px;">' + $$('#nsVolume')[0].value + '</span>');
                $$('#' + rowId + ' td')[4].update('<span style="margin-left:5px;">' + $$('#nsWeight')[0].value + '</span>');
                $('UpdateRowID').value = "";
                dialog.hide('StockEditDialog');
            }
        }

        function addStockRow(){
            if(validateRow()){
                var stockLocation = (($('ddlStockLocation').value == '0') ? "" : $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].text);
                var units = $('ddlUnit')[$('ddlUnit').selectedIndex].text;
                var stockLocationID = $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].value;
                var unitID = $('ddlUnit')[$('ddlUnit').selectedIndex].value;
                var amount = $$('#nsAmount')[0].value;
                var volume = $$('#nsVolume')[0].value;
                var weight = $$('#nsWeight')[0].value;

                var rowId =  $('id_tmp').value;
                var tr = new Element('tr');
                tr.setAttribute("id",rowId);
                tr.addClassName('listRow');
                tr.setStyle({
                    cursor: 'pointer',
                    'border-bottom-color': '#bdcce0',
                    'border-bottom-width': '1px',
                    'border-bottom-style': 'solid'
                });
                tr.observe('click', function(event) {
                    showStockEditDialog(rowId);
                });
		    
                tr.observe('mouseover', function(event) {
                    changeBackground(this, true);
                });
                tr.observe('mouseout', function(event) {
                    changeBackground(this, false);
                });
                tr.insert(new Element('td').update('<span style="margin-left:5px;">' + stockLocation + '</span>')); 
                tr.insert(new Element('td').update('<span style="margin-left:5px;">' + units + '</span>')); 
                tr.insert(new Element('td').update('<span style="margin-left:5px;">' + amount + '</span>')); 
                tr.insert(new Element('td').update('<span style="margin-left:5px;">' + volume + '</span>')); 
                tr.insert(new Element('td').update('<span style="margin-left:5px;">' + weight + '</span>')); 
                tr.insert(new Element('td').update('<a href=\'#\' onclick=\' deleteRow("'+rowId+'");\'><img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" style="border:none; margin-left:5px;"></a>'));
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_LINEID' + rowId + "' name=\'PRODSTOCKUNIT_LINEID" + rowId + "' value='" + rowId + "'>"); 
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_QUANTITY' + rowId + "' name=\'PRODSTOCKUNIT_QUANTITY" + rowId + "' value='" + amount + "'>"); 
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_VOLUME' + rowId + "' name=\'PRODSTOCKUNIT_VOLUME" + rowId + "' value='" + volume + "'>"); 
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_WEIGHT' + rowId + "' name=\'PRODSTOCKUNIT_WEIGHT" + rowId + "' value='" + weight + "'>"); 
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId + "' name=\'PRODSTOCKUNIT_STOCKLOCATION_ID" + rowId + "' value='" + stockLocationID + "'>"); 
                tr.insert('<input type=hidden id=\'PRODSTOCKUNIT_ID' + rowId + "' name=\'PRODSTOCKUNIT_ID" + rowId + "' value='" + unitID + "'>"); 

                $('DWRowLineTable_G2_').down('#clickRow').insert({before:tr});
                $('UpdateRowID').value = "";
                dialog.hide('StockEditDialog');
            }
        }

        function changeBackground(tr, isMouseOver){
            if(tr){
                if(isMouseOver){
                    tr.observe('mouseover', function(event) {
                        this.setStyle({backgroundColor: '#EBF7FD'});
                    });
                }else{
                    tr.observe('mouseout', function(event) {
                        this.setStyle({backgroundColor: '#fff'});
                    });
                }
            }
        }

        function deleteRow(rowId){
            $('PRODSTOCKUNIT_DELETE_ITEMS').value += "[" + $('PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId).value + ","+ $('PRODSTOCKUNIT_ID' + rowId).value + "];";
            var script = '$("' + rowId + '").stopObserving("click"); Element.remove("'+ rowId + '")';
            eval(script);
        }

        function validateRow(rowId){
            if($('ddlUnit')[$('ddlUnit').selectedIndex].value == "0"){
                alert('<%=Translate.JsTranslate("The unit field cannot be empty! Please select unit.")%>');
		        $('ddlUnit').focus();
		        return false;
		    }
            var isNotExist = true;
            if(rowId){
                $$('tr.listRow').each(function (i){ 
                    if($('PRODSTOCKUNIT_ID' + i.id).value ==  $('ddlUnit')[$('ddlUnit').selectedIndex].value &&
                       $('PRODSTOCKUNIT_STOCKLOCATION_ID' + i.id).value ==  $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].value &&
                       ($('PRODSTOCKUNIT_ID' + rowId).value !=  $('ddlUnit')[$('ddlUnit').selectedIndex].value ||
                        $('PRODSTOCKUNIT_STOCKLOCATION_ID' + rowId).value !=  $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].value)) {
                        alert('<%=Translate.JsTranslate("The unit with this stock location is already exist! Please choose another stock location or unit.")%>');
		                $('ddlStockLocation').focus();
		                isNotExist = false;
		                return;
		            }
		        });
            }else{
                $$('tr.listRow').each(function (i){ 
                    if($('PRODSTOCKUNIT_ID' + i.id).value ==  $('ddlUnit')[$('ddlUnit').selectedIndex].value &&
                       $('PRODSTOCKUNIT_STOCKLOCATION_ID' + i.id).value ==  $('ddlStockLocation')[$('ddlStockLocation').selectedIndex].value ) {
                        alert('<%=Translate.JsTranslate("The unit with this stock location is already exist! Please choose another stock location or unit.")%>');
		                $('ddlStockLocation').focus();
		                isNotExist = false;
		                return;
		            }
		        });
            }
            return isNotExist;
        }

    </script>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
<div style="min-width:1000px;overflow:hidden;">
    <dw:RibbonBar ID="RibbonBar" runat="server">
        <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Product" runat="server" Visible="true">

            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">

                <dw:RibbonBarButton ID="btnSaveProduct" Disabled="True" Text="Save" Image="Save" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClick="SaveProduct_Click" OnClientClick="if(!SaveProduct()) {return false;}" />
                <dw:RibbonBarButton ID="btnSaveAndCloseProduct" Disabled="True" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClientClick="if(!SaveProduct()) {return false;}" OnClick="SaveAndCloseProduct_Click" />
                <dw:RibbonBarButton ID="btnCancel" Text="Close" Image="Cancel" Size="Small" runat="server" OnClick="btnCancel_Click" EnableServerClick="true" PerformValidation="False" />
                <dw:RibbonBarButton ID="RibbonBarButton1" Text="Delete" ImagePath="/Admin/Images/eCom/eCom_Product_delete_small.gif" Size="Small"
                    runat="server" EnableServerClick="true" PerformValidation="false" OnClick="DeleteProduct_Click" OnClientClick="if(!DeleteProduct()){return false;}" >
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="RibbonBarButton2" Text="Comments" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" ModuleSystemName="eCom_PowerPack" Size="Small" runat="server" OnClientClick="comments();" />
                <dw:RibbonBarButton ID="cmdOptimize" Text="Optimize" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_view.png" ModuleSystemName="SeoExpress" Size="Small" runat="server" />
            
            </dw:RibbonBarGroup>

             <dw:RibbonBarGroup ID="RibbonBarGroup18" Name="Information" runat="server">

                <dw:RibbonBarRadioButton ID="RibbonBasicButton" runat="server" Text="Details" Checked="false" Image="DocumentProperties" Group="productTabs"
                    Size="Small" OnClientClick="ribbonTab('GENERAL', 1);" >
                </dw:RibbonBarRadioButton>
                <dw:RibbonBarRadioButton ID="RibbonDescrButton" runat="server" Checked="False" Text="Description" Image="EditDocument" Group="productTabs"
                    Size="Small" OnClientClick="ribbonTab('DESCRIPTION', 2);" >
                </dw:RibbonBarRadioButton>
                <dw:RibbonBarRadioButton ID="RibbonMediaButton" runat="server" Checked="False" Text="Media" ImagePath="/Admin/Images/eCom/eCom_Media_small.gif" Group="productTabs"
                    Size="Small" ContextmenuId="MediaContext" SplitButton="true" OnClientClick="ribbonTab('DETAIL', 3);" >
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonDefaultInfoButton" Checked="true" Visible="false" Text="def1" Size="Small"
                        runat="server" ImagePath="/Admin/Images/x.gif" >
                </dw:RibbonBarRadioButton>

             </dw:RibbonBarGroup>
             <dw:RibbonBarGroup ID="RibbonBarGroupOptions" Name="Options" runat="server">

                <dw:RibbonBarRadioButton ID="RibbonRelatedGroupsButton" Checked="False" Text="Related groups"
                        Size="Small"
                        runat="server" Image="Folder"
                        ContextMenuId="GroupsContext" SplitButton="true"
                        OnClientClick="ribbonTab('GROUP', 5);" Group="productTabs"
                        />

                <dw:RibbonBarRadioButton ID="RibbonRelatedProdButton" Checked="False" Text="Related products" Size="Small"
                        runat="server" ImagePath="/Admin/Images/eCom/eCom_Related_small.gif"
                        ContextMenuId="RelatedContext" SplitButton="true"
                        OnClientClick="ribbonTab('RELATED', 8);" Group="productTabs" />

                <dw:RibbonBarRadioButton ID="RibbonRelatedSearchesButton" Checked="False" Text="Related searches" Size="Small"
                        runat="server" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif"
                        ContextMenuId="RelatedSearchesContextMenu" SplitButton="true"
                        OnClientClick="ribbonTab('RELATEDSEARCHES', 12);" Group="productTabs" />

                <dw:RibbonBarRadioButton ID="RibbonVariantsButton" Checked="False" Text="Variants" Size="Small"
                        runat="server" ImagePath="/Admin/Images/eCom/eCom_Variants_small.gif"
                        ContextMenuId="VariantsContext" SplitButton="true"
                        OnClientClick="ribbonTab('VARIANTS', 7);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonFieldsButton" Checked="False" Text="Field groups" Size="Small"
                        runat="server" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/buttons/AddPropOption.png"
                        ContextMenuId="FieldsContext" SplitButton="true"
                        OnClientClick="ribbonTab('PROPERTY', 4);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonPartsListsButton" Checked="False" Text="Parts Lists" Size="Small"
                        runat="server" ImagePath="/admin/images/ecom/Module_eCom_PartsLists_small.gif"
                        ContextMenuId="PartsListContext" SplitButton="true"
                        OnClientClick="ribbonTab('ITEM', 11);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonPricesButton" Checked="False" Text="Prices" Size="Small"
                        runat="server" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/buttons/Prices.png"
                        OnClientClick="ribbonTab('PRICE', 6);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonUnitButton" Checked="False" Text="Units" Size="Small"
                        runat="server" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/buttons/Stock.png"
                        OnClientClick="ribbonTab('UNIT', 10);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonStockButton" Checked="False" Text="Stock" Size="Small"
                        runat="server" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_stockgrp.png"
                        OnClientClick="ribbonTab('STOCK', 13);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonDiscountsButton" Checked="False" Text="Discounts" Size="Small"
                        runat="server" ContextMenuId="DiscountContext" SplitButton="true" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_salesdiscount.png"
                        OnClientClick="ribbonTab('DISCOUNT', 14);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarRadioButton ID="RibbonVATGroupsButton" Checked="False" Text="VAT groups" Size="Small"
                        runat="server" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_vatgroups.png"
                        OnClientClick="ribbonTab('VATGROUP', 15);" Group="productTabs">
                </dw:RibbonBarRadioButton>

                <dw:RibbonBarButton ID="RibbonMwButton" Text="Product Sheet" Size="Small"
                        runat="server" ImagePath="/Admin/Images/Icons/Module_MwMediaDatabase_Small.gif" OnClientClick="LoadMindworkingProductSheetEditor();" ModuleSystemName="MwMediaDatabase">
                </dw:RibbonBarButton>

                <dw:RibbonBarRadioButton ID="RibbonDefaultOptButton" Checked="true" Visible="false" Text="Variants" Size="Small"
                        runat="server" ImagePath="/Admin/Images/x.gif" >
                </dw:RibbonBarRadioButton>

             </dw:RibbonBarGroup>

             <dw:RibbonBarGroup ID="RibbonGroupLanguage" Name="Language" runat="server">
                <ecom:LanguageSelector ID="langSelector" OnClientSelect="selectLang" TrackFormChanges="true" runat="server" />
             </dw:RibbonBarGroup>

             <dw:RibbonBarGroup ID="RibbonBarGroup23" Name="Delocalize" runat="server">
                <dw:RibbonBarButton ID="RibbonDelocalizeButton" Text="Delocalize" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/buttons/delocalize.png" Size="Large"
                runat="server" EnableServerClick="true" OnClick="DelocalizeProduct_Click" OnClientClick="if(!Delocalize()){return false;}" >
             </dw:RibbonBarButton>
             </dw:RibbonBarGroup>

             <dw:RibbonBarGroup ID="RibbonBarGroup20" Name="Help" runat="server">
                <dw:RibbonBarButton ID="ButtonHelp" Image="Help" Size="Large" Text="Help" runat="server" OnClientClick="help();" />
             </dw:RibbonBarGroup>
         </dw:RibbonBarTab>        
        <dw:RibbonBarTab ID="rbtOptions" Active="false" Name="Options" Visible="true" runat="server">
            <dw:RibbonBarGroup ID="RibbonbarGroup2" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="btnPeriodSaveProduct" Disabled="True" Text="Save" Title="Save" Image="Save" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClick="SaveProduct_Click" OnClientClick="if(!SaveProduct()) {return false;}" />
                <dw:RibbonBarButton ID="btnPeriodSaveAndCloseProduct" Disabled="True" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClientClick="if(!SaveProduct()) {return false;}" OnClick="SaveAndCloseProduct_Click" />
                <dw:RibbonBarButton ID="btnPeriodCancel" Text="Close" Image="Cancel" Size="Small" runat="server" OnClientClick="cancel();" />
                <dw:RibbonBarButton ID="btnPeriodDelete" Text="Delete" ImagePath="/Admin/Images/eCom/eCom_Product_delete_small.gif" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="DeleteProduct_Click" OnClientClick="if(!DeleteProduct()){return false;}" />
                <dw:RibbonBarButton ID="cmdPeriodComments" Text="Comments" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" ModuleSystemName="eCom_PowerPack" Size="Small" runat="server" OnClientClick="comments();" />
                <dw:RibbonBarButton ID="cmdPeriodOptimize" Text="Optimize" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_view.png" ModuleSystemName="SeoExpress" Size="Small" runat="server" />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="rbgPublication" Name="Publication" runat="server">
                <dw:RibbonBarPanel ID="rbpActivation" ExcludeMarginImage="true" runat="server">
                    <table style="height: 45px; margin: 0px 0px 0px 0px;">
                        <tr valign="top">
                            <td>
                                <dw:DateSelector runat="server" EnableViewState="false" ID="ProductActiveFrom" />
                            </td>
                            <td>
                                <%=Translate.Translate("Activation date")%>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                                <dw:DateSelector runat="server" EnableViewState="false" ID="ProductActiveTo" />
                            </td>
                            <td>
                                <%=Translate.Translate("Deactivation date")%>
                            </td>
                        </tr>
                    </table>
                </dw:RibbonBarPanel>
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
         <dw:RibbonBarTab ID="tabMarketing" Active="false" Name="Marketing" Visible="true" runat="server">
                <dw:RibbonbarGroup ID="groupMarketingSave" Name="Tools" runat="server">
				    <dw:RibbonBarButton ID="btnMarketingSaveProduct" Disabled="True" Text="Save" Title="Save" Image="Save" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClick="SaveProduct_Click" OnClientClick="if(!SaveProduct()) {return false;}" />
                    <dw:RibbonBarButton ID="btnMarketingSaveAndCloseProduct" Disabled="True" Text="Save and close" Image="SaveAndClose" Size="Small" runat="server" ShowWait="true" EnableServerClick="true" OnClientClick="if(!SaveProduct()) {return false;}" OnClick="SaveAndCloseProduct_Click" />
                    <dw:RibbonBarButton ID="btnMarketingCancel" Text="Close" Image="Cancel" Size="Small" runat="server" OnClientClick="cancel();" />
                    <dw:RibbonBarButton ID="btnMarketingDelete" Text="Delete" ImagePath="/Admin/Images/eCom/eCom_Product_delete_small.gif" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="DeleteProduct_Click" OnClientClick="if(!DeleteProduct()){return false;}" />
                    <dw:RibbonBarButton ID="cmdMarketingComments" Text="Comments" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" ModuleSystemName="eCom_PowerPack" Size="Small" runat="server" OnClientClick="comments();" />
                    <dw:RibbonBarButton ID="cmdMarketingOptimize" Text="Optimize" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_view.png" ModuleSystemName="SeoExpress" Size="Small" runat="server" />
                </dw:RibbonbarGroup>

                <dw:RibbonBarGroup ID="groupMarketingRestrictions" Name="Personalization" runat="server">
                    <dw:RibbonbarButton ID="cmdMarketingPersonalize" Text="Personalize" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" runat="server" />
                    <dw:RibbonbarButton ID="cmdMarketingProfileDynamics" Text="Add profile points" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" runat="server" />
                </dw:RibbonBarGroup>
             <dw:RibbonBarGroup ID="rbgSMP" Name="Social publishing" runat="server">
                 <dw:RibbonBarButton ID="rbPublish" Text="Publish" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" OnClientClick="showSMP();" runat="server" />
             </dw:RibbonBarGroup>
                <dw:RibbonbarGroup ID="groupMarketingHelp" Name="Help" runat="server">
					<dw:RibbonbarButton ID="cmdMarketingHelp" Text="Help" Image="Help" Size="Large" OnClientClick="help();" runat="server">
					</dw:RibbonbarButton>
				</dw:RibbonbarGroup>
            </dw:RibbonBarTab>

      </dw:RibbonBar>
</div>
      <dw:Infobar runat="server" ID="PublishPeriodInfoBar" />
      <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"></asp:Literal>
      </div>
      <div id="validationSummaryInfo" class="pe-hidden">
        <dw:Infobar ID="prodValidatorInfo" runat="server" Message="Please fill out all required fields."></dw:Infobar>
      </div>

      <dw:ContextMenu ID="MediaContext" runat="server">
        <dw:ContextMenuButton ID="editProductButton" runat="server" OnClientClick="checkTab('DETAIL', 3, function(){AddDetailLine('ADD','0');});" Image="Check" Text="Billeder/links" />
        <dw:ContextMenuButton ID="deleteProductButton" runat="server" OnClientClick="checkTab('DETAIL', 3, function(){AddDetailLine('ADD','1');});" Image="Check" Text="Tekst" />
      </dw:ContextMenu>

      <dw:ContextMenu ID="GroupsContext" runat="server" MaxHeight="650">
        <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" OnClientClick="checkTab('GROUP', 5, function(){ AddToGroups('addGroupsChecked');});" Image="Check" Text="Add groups" />
      </dw:ContextMenu>

      <dw:ContextMenu ID="FieldsContext" runat="server" MaxHeight="650">
      </dw:ContextMenu>

      <dw:ContextMenu ID="VariantsContext" runat="server" MaxHeight="500">
      </dw:ContextMenu>

      <dw:ContextMenu ID="RelatedContext" runat="server" MaxHeight="650">
      </dw:ContextMenu>

    <dw:ContextMenu ID="RelatedSearchesContextMenu" runat="server" MaxHeight="650">
        <dw:ContextMenuButton ID="ContextMenuButton2" runat="server" OnClientClick="checkTab('RELATEDSEARCHES', 12, function(){ AddToRelatedSearch('addRelatedSearchesChecked');});" Image="Check" Text="Add smart search" />
    </dw:ContextMenu>


      <dw:ContextMenu ID="PartsListContext" runat="server" MaxHeight="650">
      </dw:ContextMenu>

      <dw:ContextMenu ID="DiscountContext" runat="server" MaxHeight="650">
        <dw:ContextMenuButton ID="ContextMenuButton3" runat="server" OnClientClick="checkTab('DISCOUNT', 14, function(){ IncludeInDiscounts('includingDiscountsChecked');});" Image="Check" Text="Manage including discounts" />
        <dw:ContextMenuButton ID="ContextMenuButton4" runat="server" OnClientClick="checkTab('DISCOUNT', 14, function(){ ExcludeFromDiscounts('excludingDiscountsChecked');});" Image="Check" Text="Manage excluding discounts" />
      </dw:ContextMenu>

			<input type="hidden" id="addGroupsChecked" name="addGroupsChecked">
			<input type="hidden" id="addRelatedChecked" name="addRelatedChecked">
            <input type="hidden" id="addRelatedSearchesChecked" name="addRelatedSearchesChecked">
			<input type="hidden" id="addRelatedGrpID" name="addRelatedGrpID">
			<input type="hidden" id="addProdItemGrpChecked" name="addProdItemGrpChecked">
			<input type="hidden" id="addProdItemProdChecked" name="addProdItemProdChecked">
			<input type="hidden" id="Tab" name="Tab">
			<input type="hidden" id="TabName" name="TabName">
            <input type="hidden" id="refreshGroups">
			<asp:Literal id="NoProductExistsForLanguageBlock" runat="server"></asp:Literal>
			<dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="Auto" Anchor="document" runat="server">

			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
				<tr>
					<td valign="top">
						<div id="PageHolderStart" style="DISPLAY:none;"></div>
						<div id="Tab1" class="Tab1Div" style="DISPLAY:none">
							<div id="PageContent1">
								<table border="0" cellpadding="0" cellspacing="0" width='95%' style='WIDTH:95%'>
										<tr>
											<td>
												<fieldset style='MARGIN: 5px; width:100%;'><legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%">
																	<colgroup>
																		<col width="170px" />
																		<col />
																	</colgroup>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
																		<td>
				                                                           <asp:textbox id="Name" runat="server" MaxLength="255" CssClass="NewUIinput"></asp:textbox>
				                                                           <asp:CustomValidator ID="custom1" runat="server" ClientValidationFunction="checkRequired" ControlToValidate="Name" ErrorMessage="*" ValidateEmptyText="true" ></asp:CustomValidator>
				                                                        </td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelNumber" runat="server" Text="Nummer"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="Number" runat="server" MaxLength="255" CssClass="NewUIinput"></asp:textbox>
                                                                            <%=GetValidateSpanBlock("ProductNumber", "Number")%>
																		</td>
																	</tr>
                                                                    <tr>
                                                                        <td><dw:TranslateLabel ID="tLabelId" runat="server" Text="Id"></dw:TranslateLabel></td>
                                                                        <td><asp:TextBox ID="IdStr" runat="server" CssClass="NewUIinput" Enabled="False"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelDefaultShopID" runat="server" Text="Shop"></dw:TranslateLabel></td>
																		<td><asp:DropDownList id="DefaultShopID" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelManufacturerID" runat="server" Text="Producent"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:DropDownList id="ManufacturerID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                                                                            <%=GetValidateSpanBlock("ProductManufacturer", "ManufacturerID")%>
																		</td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelVatGrpID" runat="server" Text="Default VAT group"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:DropDownList id="VatGrpID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                                                                            <%=GetValidateSpanBlock("ProductVATGroup", "VatGrpID")%>
																		</td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelType" runat="server" Text="Produkttype"></dw:TranslateLabel></td>
																		<td><asp:DropDownList id="Type" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelTypeNotDefault" runat="server" Text="Produkttype"></dw:TranslateLabel></td>
																		<td><asp:DropDownList id="TypeNotDefault" CssClass="NewUIinput" runat="server"></asp:DropDownList><asp:textbox id="TypeHiddenValue" runat="server" style="display:none;"></asp:textbox></td>
																	</tr>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelPriceType" runat="server" Text="Prisudregning"></dw:TranslateLabel></td>
																		<td><asp:DropDownList id="PriceType" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</fieldset>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Aktivere produkt")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%">
																	<colgroup>
																		<col width="170px" />
																		<col />
																	</colgroup>
																	<tr>
																		<td><dw:TranslateLabel id="tLabelActive" runat="server" Text="Aktiv type"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:DropDownList id="dpActive" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                                                                            <%=GetValidateSpanBlock("ProductActive", "dpActive")%>
																		</td>
																	</tr>
																	<tr>
																		<td valign="top"><dw:TranslateLabel id="tLabelPeriodID" runat="server" Text="Kampagne"></dw:TranslateLabel></td>
																		<td valign="top">
                                                                            <asp:DropDownList id="PeriodID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                                                                            <%=GetValidateSpanBlock("ProductPeriod", "PeriodID")%>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</fieldset>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Default information")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table id="TableProductDefaultInformation" border="0" cellpadding="2" cellspacing="2" width="100%" runat="server">
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelPrice" runat="server" Text="Pris"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="Price" width="80" CssClass="NewUIinput" style="TEXT-ALIGN: right" runat="server">
                                                                            </asp:textbox>&nbsp;<asp:Label id="CurrencyLabel" runat="server"></asp:Label>
                                                                            <%=GetValidateSpanBlock("ProductPrice", "Price")%>
																		</td>
																	</tr>
																	<tr id="RowCostInfo">
																		<td width="170"><dw:TranslateLabel id="tLabelCost" runat="server" Text="Cost"></dw:TranslateLabel></td>
																		<td><asp:textbox id="Cost" width="80" CssClass="NewUIinput" style="TEXT-ALIGN: right" runat="server"></asp:textbox>&nbsp;<asp:Label id="CurrencyLabelCost" runat="server"></asp:Label>
                                                                        </td>
																	</tr>
																	<tr>
                                                                        <td width="170">
                                                                            <dw:TranslateLabel ID="tLabelStock" runat="server" Text="Lagerstand"></dw:TranslateLabel>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="Stock" Width="40" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                                            <%=GetValidateSpanBlock("ProductStock", "Stock")%>
                                                                            <span style="color: gray;">
                                                                                <dw:TranslateLabel ID="lblStockSum" runat="server" Text="Sum of variant stocks" Visible="False"></dw:TranslateLabel>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelStockGroupID" runat="server" Text="Lagerstatus"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:DropDownList id="StockGroupID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                                                                            <%=GetValidateSpanBlock("ProductStockGroup", "StockGroupID")%>
																		</td>
																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelWeight" runat="server" Text="Weight"></dw:TranslateLabel></td>
																		<td><asp:textbox id="Weight" Width="40" CssClass="NewUIinput" runat="server" />
																			<%=eCommerce.Common.Gui.GetWeightUnit%>
                                                                            <%=GetValidateSpanBlock("ProductWeight","Weight")%>
																		</td>

																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelVolume" runat="server" Text="Rumfang"></dw:TranslateLabel></td>
																		<td><asp:textbox id="Volume" Width="40" CssClass="NewUIinput" runat="server" />
																			<%=eCommerce.Common.Gui.GetVolumeUnit%>
                                                                            <%=GetValidateSpanBlock("ProductVolume", "Volume")%>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
                    					        </fieldset>
                                                <%If Base.HasVersion("8.5.0.0") andalso Base.IsModuleInstalled("LoyaltyPoints")  Then%>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Loyalty points")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%" runat="server">
																	<tr>
																		<td width="170"><dw:TranslateLabel id="TranslateLabel10" runat="server" Text="Points"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="DefaultPoints" width="80" CssClass="NewUIinput" style="TEXT-ALIGN: right" runat="server"></asp:textbox>
                                                                            <%=GetValidateSpanBlock("ProductDefaultPoints", "DefaultPoints")%>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</fieldset>
                                                <%End If%>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Meta information")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%">
																	<tr>
																		<td width="170"><dw:TranslateLabel id="TranslateLabel1" runat="server" Text="Title"></dw:TranslateLabel></td>
																		<td width="200">
                                                                            <asp:textbox id="MetaTitle" CssClass="NewUIinput product-meta-title" runat="server"
                                                                            onfocus="ShowCounters(this,'MetaTitleCounter',_MetaTitleCounterMaxId);"
                                                                            onkeyup="CheckCounter(this,'MetaTitleCounter',_MetaTitleCounterMaxId);"
                                                                            onblur="CheckAndHideCounter(this,'MetaTitleCounter',_MetaTitleCounterMaxId);"
                                                                            ></asp:textbox>
                                                                        </td>
                                                                        <td align="left" valign="top" width="auto">
                                                                            <strong id="MetaTitleCounter" class="char-counter"></strong>
					                                                        <input type="hidden" id="MetaTitleCounterMax" runat="server"/>
                                                                        </td>
																	</tr>
                                                                    <tr>
																		<td width="170" class="LabelTop"><dw:TranslateLabel id="TranslateLabel2" runat="server" Text="Description"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="MetaDescr" TextMode="MultiLine" Columns="30" Rows="4" CssClass="NewUIinput product-meta-description" runat="server"
                                                                            onfocus="ShowCounters(this,'MetaDescrCounter',_MetaDescrCounterMaxId);"
                                                                            onkeyup="CheckCounter(this,'MetaDescrCounter',_MetaDescrCounterMaxId);"
                                                                            onblur="CheckAndHideCounter(this,'MetaDescrCounter',_MetaDescrCounterMaxId);"
                                                                            ></asp:textbox>
                                                                        </td>
                                                                        <td align="left" valign="top">
                                                                            <strong id="MetaDescrCounter" class="char-counter"></strong>
					                                                        <input type="hidden" id="MetaDescrCounterMax" runat="server"/>
                                                                        </td>
																	</tr>
																	<tr>
																		<td width="170" class="LabelTop"><dw:TranslateLabel id="TranslateLabel3" runat="server" Text="Keywords"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="MetaKeywords" TextMode="MultiLine" Columns="30" Rows="4" CssClass="NewUIinput product-meta-keywords" runat="server"
                                                                            onfocus="ShowCounters(this,'MetaKeywordsCounter',_MetaKeywordsCounterMaxId);"
                                                                            onkeyup="CheckCounter(this,'MetaKeywordsCounter',_MetaKeywordsCounterMaxId);"
                                                                            onblur="CheckAndHideCounter(this,'MetaKeywordsCounter',_MetaKeywordsCounterMaxId);"
                                                                            ></asp:textbox>
                                                                        </td>
                                                                        <td align="left" valign="top">
                                                                            <strong id="MetaKeywordsCounter" class="char-counter"></strong>
					                                                        <input type="hidden" id="MetaKeywordsCounterMax" runat="server"/>
                                                                        </td>
																	</tr>
                                                                    <%If Base.HasVersion("8.3.0.0") Then%>
                                                                    <tr>
																		<td><dw:TranslateLabel id="TranslateLabel5" runat="server" Text="Canonical page"></dw:TranslateLabel></td>
																		<td>
                                                                            <asp:textbox id="MetaCanonical" MaxLength="255" CssClass="NewUIinput" runat="server"></asp:textbox>
                                                                        </td>
                                                                        <td></td>
																	</tr>
                                                                    <%End If%>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="TranslateLabel4" runat="server" Text="URL"></dw:TranslateLabel></td>
																		<td><asp:textbox id="MetaUrl" CssClass="NewUIinput product-meta-url" runat="server" ></asp:textbox></td>
                                                                        <td></td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</fieldset>
												<fieldset style='MARGIN: 5px;WIDTH: 100%' runat="server" id="BackCatalog"><legend class="gbTitle"><%=Translate.Translate("Back catalog")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" >
														<tr>
															<td width="170"></td>
															<td width="200">
																<label>
																	<asp:CheckBox id="ExcludeFromIndex" runat="server" />
																	<dw:TranslateLabel id="ExcludeFromIndexLabel" runat="server" Text="Exclude from index"></dw:TranslateLabel>
																</label>
															</td>
														</tr>
														<tr>
															<td width="170"></td>
															<td width="200">
																<label>
																	<asp:CheckBox id="ExcludeFromCustomizedUrls" runat="server" />
																	<dw:TranslateLabel id="ExcludeFromCustomizedUrlsLabel" runat="server" Text="Exclude from customized urls"></dw:TranslateLabel>
																</label>
															</td>
														</tr>
														<tr>
															<td width="170"></td>
															<td width="200">
																<label>
																	<asp:CheckBox id="ExcludeFromAllProducts" runat="server" />
																	<dw:TranslateLabel id="ExcludeFromAllProductsLabel" runat="server" Text="Exclude from &quot;All products&quot;"></dw:TranslateLabel>
																</label>
															</td>
														</tr>
													</table>
												</fieldset>
                                                <div id="ProductCalculatedFields" runat="server">
													<asp:Literal id="ProductCalculatedFieldList" runat="server"></asp:Literal>
												</div>
												<div id="ProductCustomFields">
													<asp:Literal id="ProductFieldList" runat="server"></asp:Literal>
												</div>
												<div id="ProductCategoriesBlock">
                                                    <asp:Literal id="ProductCategoriesFieldList" runat="server"></asp:Literal>
												</div>
											</td>
										</tr>
									</table>
							</div>
						</div>
						<div id="Tab2" class="Tab2Div" style="DISPLAY:none">
							<div id="PageContent2">
									<table border="0" cellpadding="0" cellspacing="0" width='95%' style='WIDTH:95%'>
										<tr>
											<td>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Beskrivelse")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%" id="Descriptions" runat="server">
																	<colgroup>
																		<col width="170px" />
																		<col />
																	</colgroup>
																	<tr>
																		<td valign="top"><dw:TranslateLabel id="tLabelShortDescription" runat="server" Text="Teaser tekst"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:Editor runat="server" ID="ShortDescription" name="ShortDescription"/>
                                                                            
																		</td>
                                                                        <td><%=GetValidateSpanBlock("ProductShortDescription", "ShortDescription")%></td>
																	</tr>
																	<tr>
																		<td valign="top"><dw:TranslateLabel id="tLabelLongDescription" runat="server" Text="Beskrivelse"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:Editor runat="server" ID="LongDescription" name="LongDescription"/>
																		</td>
                                                                        <td><%=GetValidateSpanBlock("ProductLongDescription","LongDescription")%></td>
																	</tr>
																</table>
																<div id="ProductDescBlock">
																   <%= ProductDescription() %>
																</div>
															</td>
														</tr>
													</table>
												</fieldset>
											</td>
										</tr>
									</table>
									<div id="ProductCustomFieldsEditor">
									    <asp:Literal id="ProductFieldsList" runat="server"></asp:Literal>
									</div>
							</div>
						</div>
						<div id="Tab3" class="Tab3Div" style="DISPLAY:none">
							<div id="PageContent3">
								<%
									Dim tmpImgSelect As String = Translate.Translate("Gennemse")
								%>
								<table border="0" cellpadding="0" cellspacing="0" width='95%' style='WIDTH:95%'>
										<tr>
											<td>
												<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Medier")%></legend>
													<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
														<tr>
															<td>
																<table border="0" cellpadding="2" cellspacing="2" width="100%">
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelProductImageSmall" runat="server" Text="Lille"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:FileArchive runat="server" id="ProductImageSmall" CastEvents="True" ShowPreview="True" size="50" cssClass="NewUIinput"></dw:FileArchive>
                                                                            <%=GetValidateSpanBlock("ProductImageSmall", "ProductImageSmall")%>
																		</td>
																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelProductImageMedium" runat="server" Text="Medium"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:FileArchive runat="server" id="ProductImageMedium" CastEvents="True" ShowPreview="True" size="50" cssClass="NewUIinput"></dw:FileArchive>
                                                                            <%=GetValidateSpanBlock("ProductImageMedium", "ProductImageMedium")%>
																		</td>
																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelProductImageLarge" runat="server" Text="Stor"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:FileArchive runat="server" id="ProductImageLarge" CastEvents="True" ShowPreview="True" size="50" cssClass="NewUIinput"></dw:FileArchive>
                                                                            <%=GetValidateSpanBlock("ProductImageLarge", "ProductImageLarge")%>
																		</td>
																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelProductLink1" runat="server" Text="Link"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:FileArchive runat="server" id="ProductLink1" cssClass="NewUIinput"></dw:FileArchive>
                                                                            <%=GetValidateSpanBlock("ProductLink1", "ProductLink1")%>
																		</td>
																	</tr>
																	<tr>
																		<td width="170"><dw:TranslateLabel id="tLabelProductLink2" runat="server" Text="Alternativ link"></dw:TranslateLabel></td>
																		<td>
                                                                            <dw:FileArchive runat="server" id="ProductLink2" cssClass="NewUIinput"></dw:FileArchive>
                                                                            <%=GetValidateSpanBlock("ProductLink2", "ProductLink2")%>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</fieldset>
												<div id="ProductDetailData"><%=ProductDetailData()%></div>
											</td>
										</tr>
									</table>
							</div>
						</div>
						<div id="Tab4" class="Tab4Div" style="DISPLAY:none">
							<div id="PageContent4">
								<div id="ProductProperty"></div>
							</div>
						</div>
						<div id="Tab5" class="Tab5Div" style="DISPLAY:none">
							<div id="PageContent5">
								<div id="ProductGrpRelData"></div>
							</div>
						</div>
						<div id="Tab6" class="Tab6Div" style="DISPLAY:none">
							<div id="PageContent6">
								<div id="ProductPriceData"></div>
							</div>
						</div>
						<div id="Tab7" class="Tab7Div" style="DISPLAY:none">
							<div id="PageContent7">
								<div id="ProductVariantData"></div>
							</div>
						</div>
						<div id="Tab8" class="Tab8Div" style="DISPLAY:none">
							<div id="PageContent8">
								<div id="ProductRelatedData"></div>
							</div>
						</div>
                        <div id="Tab12" class="Tab12Div" style="DISPLAY:none">
							<div id="PageContent12">
								<div id="SearchRelatedData"></div>
							</div>
						</div>
						<div id="Tab10" class="Tab10Div" style="DISPLAY:none">
							<div id="PageContent10">
								<div id="ProductUnitBlock"></div>
							</div>
						</div>
						<div id="Tab11" class="Tab11Div" style="DISPLAY:none">
							<div id="PageContent11">
								<div id="ProductItemBlock"></div>
							</div>
						</div>
						<div id="Tab13" class="Tab13Div" style="DISPLAY:none">
							<div id="PageContent13">
								<div id="ProductStockBlock"></div>
							</div>
						</div>
						<div id="Tab14" class="Tab14Div" style="DISPLAY:none">
							<div id="PageContent14">
								<div id="ProductDiscountData"></div>
							</div>
						</div>
						<div id="Tab15" class="Tab15Div" style="DISPLAY:none">
							<div id="PageContent15">
								<div id="ProductVATGroups"></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
			</dw:StretchedContainer>
		<iframe name="EcomUpdator" id="EcomUpdator" width="0" height="0" tabindex="-1" align="right" marginwidth="0" marginheight="0" frameborder="0" src="EcomUpdator.aspx" border="0"></iframe>

		<dw:PopUpWindow ID="optimizePopup" OnClientShow="onOptimizeShow" UseTabularLayout="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true"
		    Title="Optimize" HidePadding="true" Width="750" Height="300" runat="server" />

        <omc:MarketingConfiguration ID="marketConfig" runat="server" />

    	<dw:PopUpWindow ID="RelatedLimitationPopup" UseTabularLayout="true" AutoReload="true" ShowOkButton="true" ShowCancelButton="true" ShowClose="true"
		    Title="Limitations" TranslateTitle="true" HidePadding="false" Width="600" Height="400" runat="server" ContentUrl="" />

		<div id="Price_PeriodSelect" style="DISPLAY:none;POSITION:absolute"></div>
		<div id="Price_VariantSelect" style="DISPLAY:none;POSITION:absolute"></div>
		<div id="Price_UnitSelect" style="DISPLAY:none;POSITION:absolute"></div>

        <dw:Dialog ID="DeleteVariantGroup" Title="Delete variant group" UseTabularLayout="true" ShowOkButton="true" Width="500" ShowCancelButton="true" ShowClose="true" OkAction="continueDeleteVariantGroup(true);" runat="server">
            <div class="delete">
                <p><dw:TranslateLabel Text="Are you sure you want to delete  the variant group?" runat="server" /></p>
                <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align:middle;margin-left:10px;margin-right:10px;" />
                <dw:TranslateLabel Text="If this variant group is deleted then all variants will also be deleted." runat="server" />
            </div>
        </dw:Dialog>

		<dw:Dialog ID="CommentsDialog" runat="server" Title="Comments" HidePadding="true" Width="625">
		<iframe id="CommentsFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
		</dw:Dialog>
        <dw:PopUpWindow ID="pupCreateMessage" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="720" Height="580" iframeHeight="530" 
            Title="Publish product to social media" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />

        <dw:Dialog ID="StockEditDialog" runat="server" Title="Edit stock info" HidePadding="false" Width="400" ShowOkButton="True" ShowCancelButton="True" ShowClose="False" OkAction="if($('UpdateRowID') && !isNaN($('UpdateRowID').value) && $('UpdateRowID').value.length > 0){updateStockRow($('UpdateRowID').value);}else{ addStockRow();}">
            <input type="hidden" id="UpdateRowID" name="UpdateRowID" value=""/>
            <table style="padding-bottom: 80px;" class="price-editor">
                <tr id="trID" style="display:none;">
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="TranslateLabel6" Text="Id" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="id_tmp" runat="server" ClientIDMode="Static" ReadOnly="True" Enabled="False"  Width="264"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="lbSenderName" Text="Stock location" runat="server" />
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="ddlStockLocation" Width="268"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="lbSenderEmail" Text="Unit" runat="server" />
                    </td>
                    <td>
                         <asp:DropDownList runat="server" ClientIDMode="Static" ID="ddlUnit" Width="268"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="TranslateLabel7" Text="Amount" runat="server" />
                    </td>
                    <td data-role="price-value">
					    <input type="text" id="nsAmount" style="width: 264px;" name="nsAmount" class="NewUIinput"/>
                   </td>
                </tr>
                <tr>
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="TranslateLabel8" Text="Volume" runat="server" />
                    </td>
                    <td data-role="price-value">
					    <input type="text" id="nsVolume" style="width: 264px;" name="nsVolume" class="NewUIinput"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 90px">
                        <dw:TranslateLabel ID="TranslateLabel9" Text="Weight" runat="server" />
                    </td>
                    <td data-role="price-value">
					    <input type="text" id="nsWeight" style="width: 264px;" name="nsWeight" class="NewUIinput"/>
                    </td>
                </tr>
            </table>
		</dw:Dialog>

    <dw:Dialog ID="AddVariantOption" runat="server" Title="Add new variant option" Width="250" ShowHelpButton="false" ShowCancelButton="true" ShowClose="false" ShowOkButton="true" OkAction="addVariantOptionComplete()" CancelAction="addVariantOptionCancel()" FinalizeActions="false">
        <label><dw:TranslateLabel Text="Option name" runat="server" /></label>
        <input />
    </dw:Dialog>

    <dw:Overlay ID="ProductEditOverlay" runat="server"></dw:Overlay>


		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

    	<script type="text/javascript">
            <%If eCommerce.Common.Context.LanguageID <> Dynamicweb.eCommerce.Common.Application.DefaultLanguage.LanguageID Then%>
    	    isDefaultLang = false;
            <%End If%>

    	    document.observe("dom:loaded", function(){
    	        if (<%=OMCRedirect %>)
    	        {
                    Ribbon.tab(2, 'RibbonBar');
    	        ProductEdit.openContentRestrictionDialog('<%=prodId %>', '', '<%=langId %>');
    	    }

                ProductEdit.terminology['unsavedChanges'] = '<%=Backend.Translate.Translate("Data you have entered may not be saved.")%>';
    	    ProductEdit.Marketing = <%=marketConfig.ClientInstanceName%>;
    	    ProductEdit.RelatedLimitationPopup = <%=RelatedLimitationPopup.ClientInstanceName%>;
    	    ProductEdit.initialization();
    	    });
        </script>

		
</asp:Content>
