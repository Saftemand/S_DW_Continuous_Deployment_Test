<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master"
    Codebehind="EcomGroup_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomGroupEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ecom" Namespace="Dynamicweb.Admin.eComBackend" Assembly="Dynamicweb.Admin" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/List/List2.css" />
    
	<style type="text/css">
	    body.margin { margin: 0px }
	    input,select,textarea {font-size: 11px; font-family: verdana,arial;}
	    .groupTab {}
	    .saveBtn {}
        .saveAndCloseBtn {}
        
        #DWRowLineTable span.RelatedGroup 
        {
            width: 16px;
            height: 16px;
            display: inline-block; 
            padding: 2px;
            background: url(/Admin/images/Minus.gif) no-repeat center;
        }
        
        #DWRowLineTable span.RelatedGroupPrimary,
        #DWRowLineTable span.RelatedGroupInherited
        {
            background-image: url(/Admin/images/Check.gif) !important;
        }
        
        #breadcrumb
        {
            border-bottom: #9faec2 1px solid;
            line-height: 18px;
            background-color: #ffffff;
            padding-left: 10px;
            display: inherit;
            height: 20px;
            vertical-align: middle;
        }

        .hide-error
        {
            visibility:hidden;
        }

        td.LabelTop {
          vertical-align: top;
          padding-top: 6px;
          width: 170px;
        }
	</style>		

	<script type="text/javascript" language="JavaScript" src="../images/functions.js"></script>
	<script type="text/javascript" language="JavaScript" src="../images/addrows.js"></script>
    <script type="text/javascript" language="javascript" src="../images/AjaxAddInParameters.js"></script>
    <script type="text/javascript" language="JavaScript" src="../images/layermenu.js"></script>
    <script type="text/javascript" language="javascript" src="../js/EcomGroup_Edit.js"></script>
    <script type="text/javascript" src="../js/productEdit.js"></script>
    <script type="text/javascript" src="/Admin/Content/JsLib/dw/Validation.js"></script>
    <script type="text/javascript" src="/Admin/Images/Ribbon/UI/List/List.js"></script>
    <script type="text/javascript" src="../js/ecomLists.js"></script>

	<script type="text/javascript"> //<!--
	    $(document).observe('dom:loaded', function () {
	        ecomGroupEditInit();

	        if ($F("activeTab") == 'generalTab') { //check if default tab loaded.
	            window.focus(); // for ie8-ie9 
	            document.getElementById('<%=NameStr.ClientID %>').focus();
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
	//--> </script>
	
	<script type="text/javascript" src="/Admin/Link.js"></script>
	<script type="text/javascript" src="/Admin/FormValidation.js"></script>
	
	<script type="text/javascript">
	function help() {
	<%=Dynamicweb.Gui.help("", "ecom.group.edit", "en") %>
	}

    function loadTab(tabId) {
        showTab(tabId);
        FillDivLayer2("LOADING", "", tabId);
        if (tabId == "relatedGroupsTab")
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Group.RelatedGroupList";	
        else if (tabId == "relatedProductsTab")
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Group.RelatedProductList";	
        else if (tabId == "relatedSearchesTab")
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Group.RelatedSmartSearchList";
        else if (tabId == "discountsTab")
            EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Group.DiscountList";
    }

	function FillDivLayer2(typeStr, fillData, fillLayer) {
		var fillStr = ""
			
		if (typeStr == "LOADING") {		
			fillStr = '<asp:Literal id="LoadBlock" runat="server"></asp:Literal>';
		}

		if (typeStr == "DWNONE") {
			fillStr = '<br />';
		}

		if (fillData != "") {
			fillStr = fillData;
		}
	    
        if (fillLayer == "GRPREL")
            fillLayer = "relatedGroupsTab";
        else if (fillLayer == "GRPPRODREL")
            fillLayer = "relatedProductsTab";
         else if (fillLayer == "GRPSEARCHREL")
             fillLayer = "relatedSearchesTab";
         else if (fillLayer == "GRPDISCOUNT")
             fillLayer = "discountsTab";

        $(fillLayer).innerHTML = fillStr;
	}

    function AddRelatedGroups() {
        AddRelated('relatedGroupsChecked');
    }

    function AddRelatedSearch() {
        AddRelated('relatedSearchesChecked');
    }

    function AddRelatedProducts(RelgrpID) {
        document.getElementById('Form1').addRelatedGrpID.value = RelgrpID;
        AddRelated('relatedProductsChecked', RelgrpID);
    }

    function AddRelated(fieldName, RelgrpID) {
        if (globalGroupId.length > 0) {
            if (typeof(fieldName) == "undefined")
                fieldName = 'relatedGroupsChecked';

            if (fieldName == "relatedGroupsChecked") {
                showTab("relatedGroupsTab");

	            if (enableClick) {
		            var caller = "opener.document.getElementById('Form1')."+ fieldName;
		            window.open("/Admin/module/ecom_catalog/dw7/edit/EcomGroupTree.aspx?CMD=ShowGroupGroupRel&MasterGroupID=" + globalGroupId + "&MasterShopID=" + globalShopId + "&caller=" + caller, "", "displayWindow,width=460,height=400,scrollbars=no");
	            }
            }
            else if (fieldName == "relatedSearchesChecked") {
                showTab("relatedSearchesTab");

	            if (enableClick) {
		            var caller = "opener.document.getElementById('Form1')."+ fieldName;
		            window.open("/Admin/module/ecom_catalog/dw7/edit/EcomGroupTree.aspx?CMD=ShowGroupSearchRel&MasterGroupID=" + globalGroupId + "&MasterShopID=" + globalShopId + "&caller=" + caller, "", "displayWindow,width=460,height=400,scrollbars=no");
	            }
            }
            else {
				var caller = "opener.document.getElementById('Form1')."+ fieldName;
				window.open("EcomGroupTree.aspx?CMD=ShowGroupProdRel&caller="+ caller + "&RelgrpID=" + RelgrpID + "&GroupID=" + globalGroupId,"","displayWindow,width=460,height=400,scrollbars=no");
            }
        }
        else {
            alert("<%=Dynamicweb.Backend.Translate.JsTranslate("Save group first...")%>")
        }
    }

		function AddRelatedRows() {
			FillDivLayer2("LOADING", "", "GRPPRODREL");
			setTimeout('AddRelatedRowsPutter()', "10");
		}

		function AddRelatedRowsPutter() {
			var prodArray = document.getElementById('Form1').relatedProductsChecked.value;
			AddDWRowFromArry('GROUPPRODRELATED', globalGroupId, prodArray, '../Edit/', document.getElementById('Form1').addRelatedGrpID.value);
		}

        function sortReleatedProducts(grpId) {
            var elem = document.getElementById("RELGRPHOLDER_" + grpId);
            var sort = document.getElementById("RELGRPSORTER_" + grpId)            
			
			if (elem.style.display == '') {
				elem.style.display = 'none';
				sort.style.display = '';

				EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=Group.ReleatedProduct.Sort&GroupID="+ grpId;	
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
			EcomUpdator.document.location.href = "EcomUpdator.aspx?CMDSort=SAVE&CMD=Group.ReleatedProduct.Sort&GroupID="+ grpId +"&ElemSort"+ grpId +"="+ values;	
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
	        var imgUp = document.images["up"+ grpId]
	        var imgDown = document.images["down"+ grpId]
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

        var categoryDidChange = false;
        var originalCategory;
        function ProductCategoryChange(obj) {
            //
            if (!categoryDidChange)
                originalCategory = obj.selectedIndex;

            var msg = '<%=Dynamicweb.Backend.Translate.JsTranslate("Changing the category will affect all products in the group. Data will be lost if the changes are saved. Click 'Ok' to confirm.")%>';
            if (confirm(msg)) {
                $("CurentProductCategory").value = obj.selectedIndex;
                categoryDidChange = originalCategory == obj.selectedIndex;
                updateProductCategory(obj.selectedOptions[0].value);
            } else {
                obj.selectedIndex = $("CurentProductCategory").value;
            }
        }

	    function updateProductCategory(newCategory) {
	        console.log("updateProductCategory", newCategory);
	    }

        function ConfirmSave() {
            var msg = '<%=Dynamicweb.Backend.Translate.JsTranslate("Category has changed. Data will be lost for all products in the group. Click 'Ok' to confirm.")%>';
            if (categoryDidChange && !confirm(msg)) {
                return false;
            }
            return true;
        }

	    function AddToRelatedProductGroups() {
	        var relatedGroupwindow = window.open("EcomRelGrp_Edit.aspx?isPopUp=TRUE", "", "displayWindow,width=460,height=400,scrollbars=no")
	        if (window.focus) {
	            relatedGroupwindow.focus();
	        }
	        return false;
	    }

	    function IncludeInDiscounts(fieldName) {
	        if (fieldName == "includeInDiscountsChecked") {
	            showTab('discountsTab');
	        }

	        <%If Request("ID") <> "" Then%>
	        var caller = "opener.document.getElementById('Form1')." + fieldName;
	        var discountTreeWin = window.open("../lists/EcomOrderDiscount_List.aspx?CMD=GroupIncludeInDiscounts&GroupID=<%=Request("ID")%>&caller=" + caller, "", "displayWindow,width=860,height=400,scrollbars=no");
	        discountTreeWin.focus();
	        <%Else%>
	        alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the group...")%>")
	        <%End If%>
	    }

	    function ExcludeFromDiscounts(fieldName) {
	        if (fieldName == "excludeFromDiscountsChecked") {
	            showTab('discountsTab');
	        }

	        <%If Request("ID") <> "" Then%>
	        var caller = "opener.document.getElementById('Form1')." + fieldName;
	        var discountTreeWin = window.open("../lists/EcomOrderDiscount_List.aspx?CMD=GroupExcludeFromDiscounts&GroupID=<%=Request("ID")%>&caller=" + caller, "", "displayWindow,width=860,height=400,scrollbars=no");
	        discountTreeWin.focus();
	        <%Else%>
	        alert("<%=Dynamicweb.Backend.Translate.JsTranslate("You need to save the group...")%>")
	        <%End If%>
	    }

	    function IncludeDiscounts(discountArr) {
	        FillDivLayer2("LOADING", "", "discountsTab");
	        EcomUpdator.document.location.href = "../edit/EcomUpdator.aspx?CMD=Group.IncludeInDiscounts&DiscountArr=" + discountArr;
	    }

	    function ExcludeDiscounts(discountArr) {
	        FillDivLayer2("LOADING", "", "discountsTab");
	        EcomUpdator.document.location.href = "../edit/EcomUpdator.aspx?CMD=Group.ExcludeFromDiscounts&DiscountArr=" + discountArr;
	    }

	</script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
<div style="min-width:1000px;overflow:hidden;">
    <dw:RibbonBar runat="server" ID="myribbon">
        <dw:RibbonBarTab Name="Group" runat="server">
            <dw:RibbonBarGroup Name="Tools" runat="server">
                <dw:RibbonBarButton Text="Save" ID="RBSave" Image="Save" Size="Small" runat="server" ShowWait="true" OnClientClick="if(!saveGroupData()) return false;" OnClick="RBSave_Click" EnableServerClick="true" />
                <dw:RibbonBarButton Text="Save and close" ID="RBSaveAndClose" Image="SaveAndClose" Size="Small" ShowWait="true" runat="server" OnClientClick="if(!saveGroupData()) return false;" OnClick="RBSaveAndClose_Click" EnableServerClick="true" />
                <dw:RibbonBarButton Text="Close" ID="RBClose" Image="Cancel" Size="Small" runat="server" OnClick="RBClose_Click" EnableServerClick="true" />
                <dw:RibbonBarButton Text="Delete" ID="RBDelete" ImagePath="/Admin/Images/eCom/eCom_Groups_delete_small.gif" Size="Small" runat="server" EnableServerClick="true" PerformValidation="false" OnClick="RBDelete_Click" OnClientClick="if (!deleteGroup()) return false;" />
             </dw:RibbonBarGroup>
             <dw:RibbonBarGroup Name="Information" runat="server">
                <dw:RibbonBarRadioButton ID="basicBtn" runat="server" Text="Details" Image="DocumentProperties" Group="groupTabs" Size="Small" OnClientClick="showTab('generalTab');" />
                <dw:RibbonBarRadioButton ID="descriptionBtn" runat="server" Text="Description" Image="EditDocument" Group="groupTabs" Size="Small" OnClientClick="showTab('descriptionTab');" />
                <dw:RibbonBarRadioButton ID="locationBtn" Text="Location" Size="Small" runat="server" Image="FolderView" OnClientClick="showTab('locationTab');" ContextMenuId="LocationMenu" SplitButton="true" Group="groupTabs" />
                <dw:RibbonBarRadioButton Checked="true" Visible="false" Text="def1" Size="Small" runat="server" ImagePath="/Admin/Images/x.gif" Group="groupTabs" />
                <dw:RibbonBarRadioButton ID="orderLineFieldsBtn" Text="Orderline fields" Size="Small" runat="server" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_orderlinefield.png" ContextMenuId="OrderLineContextMenu" SplitButton="true" OnClientClick="showTab('orderlineTab');" Group="groupTabs" />
                <dw:RibbonBarRadioButton ID="discountsBtn" Text="Discounts" Size="Small" runat="server" ImagePath="/Admin/Module/eCom_Catalog/images/tree/btn_salesdiscount.png" SplitButton="true" ContextMenuId="DiscountContextMenu" OnClientClick="loadTab('discountsTab');" Group="groupTabs" />
                <dw:RibbonBarRadioButton ID="RibbonBarRadioButton1" Checked="true" Visible="false" Text="def1" Size="Small" runat="server" ImagePath="/Admin/Images/x.gif" Group="groupTabs" />
             </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="Navigation" Name="Navigation" runat="server">
                <dw:RibbonBarCheckbox ID="NavigationShowInMenu" Text="Show in menu" Image="Tree" Size="Small" runat="server" />
                <dw:RibbonBarCheckbox ID="NavigationShowInSiteMap" Image="Sitemap" Text="Show in sitemap" runat="server" />
                <dw:RibbonBarCheckbox ID="NavigationClickable" Text="Clickable" Image="Mouse" runat="server" />
            </dw:RibbonBarGroup>
             <dw:RibbonBarGroup Name="New products" runat="server">
                <dw:RibbonBarRadioButton ID="RibbonRelatedGroupsButton" Checked="False" Text="Default related groups" Size="Small" runat="server" Image="Folder" ContextMenuId="RelatedGroupsContextMenu" SplitButton="true" OnClientClick="loadTab('relatedGroupsTab')" Group="groupTabs" />
                <dw:RibbonBarRadioButton ID="RibbonBarRelatedProductsButton" Checked="False" Text="Default related products" Size="Small" runat="server" ImagePath="/Admin/Images/eCom/eCom_Related_small.gif" ContextMenuId="RelatedProductsContextMenu" SplitButton="true" OnClientClick="loadTab('relatedProductsTab')" Group="groupTabs" />
                <dw:RibbonBarRadioButton ID="RibbonBarRelatedSearchesButton" Checked="False" Text="Default related searches" Size="Small" runat="server" ImagePath="/Admin/Images/Icons/Module_Filearchive_small.gif" ContextMenuId="RelatedSearchesContextMenu" SplitButton="true" OnClientClick="loadTab('relatedSearchesTab')" Group="groupTabs" />
             </dw:RibbonBarGroup>
             <dw:RibbonBarGroup ID="RibbonGroupLanguage" Name="Language" runat="server">
                <ecom:LanguageSelector ID="langSelector" OnClientSelect="selectLang" TrackFormChanges="true" runat="server" />
             </dw:RibbonBarGroup>
             <dw:RibbonBarGroup ID="RibbonGroupDelocalize" Name="Delocalize" runat="server">
                <dw:RibbonBarButton ID="RibbonDelocalizeButton" Text="Delocalize" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/buttons/delocalize.png" Size="Large"
                runat="server" EnableServerClick="true" OnClick="DelocalizeGroup_Click" OnClientClick="if(!delocalize()){return false;}" >
             </dw:RibbonBarButton>
             </dw:RibbonBarGroup>
             <dw:RibbonBarGroup Name="Help" runat="server">
                <dw:RibbonBarButton ID="ButtonHelp" Image="Help" Size="Large" Text="Help" runat="server" OnClientClick="help();" />
             </dw:RibbonBarGroup>
         </dw:RibbonBarTab>
    </dw:RibbonBar>
	</div>
	<dw:ContextMenu ID="OrderLineContextMenu" runat="server" MaxHeight="650" Translate="false" />
	<dw:ContextMenu ID="LocationMenu" runat="server">
	    <dw:ContextMenuButton runat="server" OnClientClick="AddGroups('addGroupsChecked');" Text="Attach as subgroup" ImagePath="/Admin/Images/eCom/eCom_Groups_attach_small.gif"/>
	</dw:ContextMenu>
    <dw:ContextMenu ID="RelatedGroupsContextMenu" runat="server" MaxHeight="650">
        <dw:ContextMenuButton runat="server" OnClientClick="AddRelated('relatedGroupsChecked');" Image="Check" Text="Add groups" />
    </dw:ContextMenu>

    <dw:ContextMenu ID="RelatedProductsContextMenu" runat="server" MaxHeight="650"/>

    <dw:ContextMenu ID="RelatedSearchesContextMenu" runat="server" MaxHeight="650">
        <dw:ContextMenuButton runat="server" OnClientClick="AddRelated('relatedSearchesChecked');" Image="Check" Text="Add smart search" />
    </dw:ContextMenu>

      <dw:ContextMenu ID="DiscountContextMenu" runat="server" MaxHeight="650">
        <dw:ContextMenuButton ID="ContextMenuButton3" runat="server" OnClientClick="IncludeInDiscounts('includeInDiscountsChecked');" Image="Check" Text="Manage including discounts" />
        <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" OnClientClick="ExcludeFromDiscounts('excludeFromDiscountsChecked');" Image="Check" Text="Manage excluding discounts" />
      </dw:ContextMenu>

    <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"/>
    </div>
    <div id="validationSummaryInfo" style="display:none;">
        <dw:Infobar ID="validationInfobar" runat="server" Message="Please fill out all required fields."/>
    </div>
	
	<asp:Literal id="NoGrpExistsForLanguageBlock" runat="server"></asp:Literal>
	<dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="Auto" Anchor="document" runat="server">

	<asp:textbox Visible="False" Enabled="True" id="LanguageIDStr" runat="server"></asp:textbox>			

	<input type="hidden" name="addGroupsChecked"/>
    <input type="hidden" name="relatedGroupsChecked"/>
    <input type="hidden" name="relatedSearchesChecked"/>
    <input type="hidden" name="relatedProductsChecked"/>
    <input type="hidden" id="addRelatedGrpID" name="addRelatedGrpID"/> 
	
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab" style="clear:left;">
	<tr><td valign="top">
	<table border="0" cellpadding="0" cellspacing="0" width="95%" style="width:95%;">
	<tr><td>

	<div class="groupTab" id="generalTab">			
		<fieldset style="width: 100%;margin:5px;">
		    <legend class="gbTitle"><%=Translate.Translate("Indstillinger")%>&nbsp;</legend>
		    <table border="0" cellpadding="2" cellspacing="0" width="100%" style="width:100%;">
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
				    <td style="white-space:nowrap;">
		                <asp:textbox id="NameStr" runat="server" MaxLength="255" cssClass="ecomStd"/>
		                <span id="errNameStr" style="color: Red;"></span>
		            </td>
			    </tr>
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelNumber" runat="server" Text="Nummer"/></td>
				    <td>
		                <asp:textbox id="NumberStr" runat="server" MaxLength="255" cssClass="ecomStd"/>
		            </td>
			    </tr>
                <tr>
                    <td width="170"><dw:TranslateLabel ID="tLabelId" runat="server" Text="Id"></dw:TranslateLabel> </td>
                    <td>
                        <asp:TextBox ID="IdStr" runat="server" CssClass="ecomStd" Enabled="False"></asp:TextBox>
                        <input type="button" runat="server" id="BtnEditGroupId" class="newUIbutton" onclick="dialog.show('EditGroupIdDialog');" value="Edit group id"/>
                    </td>
                </tr>
			    <tr style="display:none;">
				    <td width="170"><dw:TranslateLabel id="tLabelPageIDRel" runat="server" Text="PageIDRel"/></td>
				    <td><asp:textbox id="Name_PageIDRelStr" runat="server" cssClass="ecomStd"/>
				    <asp:textbox id="ID_PageIDRelStr" style="display:none;" runat="server"/>&nbsp;
				    <img src="/Admin/images/Icons/Page_int.gif" onclick="javascript:internalEcom(0, '', 'PageIDRelStr', '');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Internt link")%>"/>&nbsp;
				    <img src="/Admin/images/Icons/Page_Decline.gif" onclick="javascript:RemoveInternalEcom('PageIDRelStr');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Slet link")%>"/></td>
			    </tr>			  
                <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelProductCategory" runat="server" Text="Product category"></dw:TranslateLabel></td>
				    <td><asp:DropDownList id="ProductCategory" onchange="ProductCategoryChange(this);" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
			    </tr>
    		</table>
            <input type="hidden" id="CurentProductCategory" value="<%=ProductCategory.SelectedIndex%>"/>
		</fieldset>
		<fieldset style="width: 100%;margin:5px;">
		    <legend class="gbTitle"><%=Translate.Translate("Medier")%>&nbsp;</legend>
	    	<table border="0" cellpadding="2" cellspacing="0" width="100%" style="width:100%;">
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelSmallImg" runat="server" Text="Lille"></dw:TranslateLabel></td>
				    <td><dw:FileArchive runat="server" id="SmallImgStr" ShowPreview="True" MaxLength=255 cssClass="ecomStd"></dw:FileArchive></td>
			    </tr>
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelLargeImg" runat="server" Text="Stor"></dw:TranslateLabel></td>
				    <td><dw:FileArchive runat="server" id="LargeImgStr" ShowPreview="True" MaxLength="255" cssClass="ecomStd"></dw:FileArchive></td>
			    </tr>
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelIcon" runat="server" Text="Ikon"></dw:TranslateLabel></td>
				    <td><dw:FileArchive runat="server" id="IconStr" ShowPreview="True" MaxLength="255" cssClass="ecomStd"></dw:FileArchive></td>
			    </tr>					
		    </table>
		</fieldset>
        <fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Meta information")%></legend>
			<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
				<tr>
					<td>
						<table border="0" cellpadding="2" cellspacing="2" width="100%">
							<tr>
								<td width="170"><dw:TranslateLabel id="TranslateLabel2" runat="server" Text="Title"></dw:TranslateLabel></td>
								<td><asp:textbox id="MetaTitle" CssClass="NewUIinput product-meta-title" runat="server"></asp:textbox></td>
							</tr>
							<tr>
								<td width="170"><dw:TranslateLabel id="TranslateLabel3" runat="server" Text="Keywords"></dw:TranslateLabel></td>
								<td><asp:textbox id="MetaKeywords" CssClass="NewUIinput product-meta-keywords" runat="server"></asp:textbox></td>
							</tr>
							<tr>
								<td width="170"><dw:TranslateLabel id="TranslateLabel4" runat="server" Text="Description"></dw:TranslateLabel></td>
								<td><asp:textbox id="MetaDescr" TextMode="MultiLine" Columns="30" Rows="4" CssClass="NewUIinput product-meta-description" runat="server"></asp:textbox></td>
							</tr>
                            <%If Base.HasVersion("8.3.0.0") Then%>
                            <tr>
								<td><dw:TranslateLabel id="TranslateLabel7" runat="server" Text="Canonical page"></dw:TranslateLabel></td>
								<td><asp:textbox id="MetaCanonical" MaxLength="255" CssClass="NewUIinput" runat="server"></asp:textbox></td>
							</tr>
                            <%End If%>
							<tr>
								<td width="170"><dw:TranslateLabel id="TranslateLabel5" runat="server" Text="URL"></dw:TranslateLabel></td>
								<td>
									<asp:textbox id="MetaUrl" CssClass="NewUIinput product-meta-url" runat="server" />
								</td>
							</tr>
							<tr>
								<td width="170"><dw:TranslateLabel id="TranslateLabel6" runat="server" Text="Primary page"></dw:TranslateLabel></td>
								<td>
                                    <dw:LinkManager ID="MetaPrimaryPage" DisableParagraphSelector="true" DisableFileArchive="true" runat="server" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</fieldset>
		<fieldset style="width: 100%;margin:5px;">
		    <legend class="gbTitle"><%=Translate.Translate("Default values for new products")%>&nbsp;</legend>
	    	<table border="0" cellpadding="2" cellspacing="0" style="width:100%;">
			    <tr>
				    <td width="170"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Manufacturer"></dw:TranslateLabel></td>
				    <td>
                        <asp:DropDownList id="ManufacturerID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                        &nbsp;
                        <asp:ImageButton runat="server" ID="ApplyManufacturer" OnClick="OnApplyManufacturer" style="position: inherit; top: 3px"/>
                    </td>
			    </tr>
			    <tr>
				    <td width="170"><dw:TranslateLabel runat="server" Text="Moms gruppe"></dw:TranslateLabel></td>
				    <td>
                        <asp:DropDownList id="VatGrpID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                        &nbsp;
                        <asp:ImageButton runat="server" ID="ApplyVatGroup" OnClick="OnApplyVatGroup" style="position: inherit; top: 3px"/>
                    </td>
			    </tr>
			    <tr>
				    <td width="170"><dw:TranslateLabel id="tLabelStockGroupID" runat="server" Text="Lagerstatus"></dw:TranslateLabel></td>
                    <td>
                        <asp:DropDownList id="StockGroupID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
                        &nbsp;
                        <asp:ImageButton runat="server" ID="ApplyStockGroup" OnClick="OnApplyStockGroup" style="position: inherit; top: 3px"/>
                    </td>
			    </tr>					
		    </table>
		</fieldset>
		<fieldset style="width: 100%;margin:5px;" runat="server" id="DiscountsContainer">
		    <legend class="gbTitle"><%=Translate.Translate("Discounts")%>&nbsp;</legend>
            <asp:CheckBoxList runat="server" ID="Discounts" RepeatColumns="3" />
		</fieldset>

        <div id="ProductCustomFields">
		    <asp:Literal id="GroupFieldList" runat="server"></asp:Literal>
	    </div>

		<div id="ProductCategoriesBlock">
            <asp:Literal id="GroupCategoriesFieldList" runat="server"></asp:Literal>
		</div>
	</div>
	
	<div class="groupTab" id="descriptionTab" style="display:none;">
		<fieldset style="width: 100%;margin:5px;"><legend class="gbTitle"><%=Translate.Translate("Beskrivelse")%>&nbsp;</legend>
		<table border="0" cellpadding="8" cellspacing="0" width="100%" style="width:100%;">
			<tr valign="top">
				<td><dw:Editor id="Description" runat="server" ForceNew="true" InitFunction="true" WindowsOnLoad="false" GetClientHeight="false"></dw:Editor></td>
			</tr>					
		</table>
		</fieldset>
	</div>
	</td></tr>
	</table>
	
	<div class="groupTab" id="locationTab" style="display:none;">
		<div id="GrpRelData">
		    <asp:Literal id="GroupList" runat="server"/>
		</div>
	</div>
	
	<div class="groupTab" id="relatedGroupsTab" style="display:none;">
	</div>

	<div class="groupTab" id="relatedProductsTab" style="display:none;">
	</div>

	<div class="groupTab" id="relatedSearchesTab" style="display:none;">
	</div>

	<div class="groupTab" id="orderlineTab" style="display:none;">
	    <input type="hidden" id="OrderLineFieldCount" name="OrderLineFieldCount" value="0" />
	        <table border="0" cellpadding="0" cellspacing="0" width="95%" style="width:95%;">
	            <tr><td>
	                <fieldset style="width: 100%;margin:5px;"><legend class="gbTitle"><%=Translate.Translate("Orderline fields")%>&nbsp;</legend>
	                    <label for="OrderLineFieldsInheritCheckbox">
	                        <dw:TranslateLabel runat="server" Text="Inherit orderlinefields from parent groups" />
	                    </label>
	                    <asp:CheckBox runat="server" ID="OrderLineFieldsInheritCheckbox" />
	                    <br />
	                    <asp:Literal id="OrderLineFieldsLiteral" runat="server"></asp:Literal>
	                    
	                    <div <%=IIf(OrderLineFieldsInheritCheckbox.Checked, "", "style=""display: none;""") %>>
	                        <asp:Literal id="OrderLineFieldsInheritedLiteral" runat="server"></asp:Literal>
	                    </div>
	                </fieldset>
	            </td></tr>
	        </table>
    </div>

    <div class="groupTab" id="discountsTab" style="display:none;">
    </div>

	</td>
	</tr>
	</table>				
	</dw:StretchedContainer>
	
    <!-- Edit Group Id Dialog -->
    <dw:Dialog runat="server" ID="EditGroupIdDialog" Title="Edit group id" ShowCancelButton="true" ShowOkButton="true" OkText="Apply" OkAction="saveAndCloseEditGroupIdDlg();">        
		<table cellpadding="1" cellspacing="1">
            <tr>
			    <td width="170"><dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="New group id" /></td>
			    <td><input type="text" id="txtEditedGroupId" maxlength="255" class="NewUIinput" /></td>
		    </tr>            
		</table>
    </dw:Dialog>

	<script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>
    
    <script type="text/javascript">

    function ResizeFckEditor() {
        var pText = $('Description___Frame');
        var h = getClientHeight(0,'Description');
	    if(pText)
	        pText.setStyle({ height: (h) + 'px' });
	}

    function getClientHeight(Height, Name) {
        if (Name == 'Description') {
            var h = document.documentElement.clientHeight;
            h -= $("myribbon").getHeight();
            h -= $("breadcrumb").getHeight();
            h -= $("LocationMenu").getHeight();
            if (h < 0) h = 0;
            if (h >= 20) h -= 20;
            return h;
        }
        else {
            return Height;
        }
	}
	window.onload = function () {
	    editor.init();
	    InitGroupField();
	}
	window.onresize = function() {
	    ResizeFckEditor();
	}

	function saveAndCloseEditGroupIdDlg() {
	    var groupId = document.getElementById("txtEditedGroupId").value;
	    
	    if (groupId == '') {
	        alert('<%=Translate.JsTranslate("The group id cannot be empty.")%>');
	        document.getElementById("txtEditedGroupId").focus();
	    } else {
	        new Ajax.Request("/Admin/Module/eCom_Catalog/dw7/Edit/EcomGroup_Edit.aspx?CMD=CheckGroupId&EditedGroupID=" + groupId, {
	            method: 'get',
	            onSuccess: function (transport) {
	                if (transport.responseText != "true") {
	                    alert('<%=Translate.JsTranslate("The group id is already in use and cannot be used again.")%>');
                    }
                    else {
	                    if (confirm('<%=Translate.JsTranslate("The group id will be updated and it cannot be undone")%>')) {
	                        dialog.hide('EditGroupIdDialog');
	                        document.getElementById('Form1').action = "EcomGroup_Edit.aspx?CMD=UpdateGroupId&EditedGroupID=" + groupId + "&ID=" + globalGroupId +
                                "&shopID=" + globalShopId + "&parentID=" + globalParentId;
	                        document.getElementById('Form1').submit();
	                    }
                    }
                },
                onFailure: function () {
                    alert('<%=Translate.JsTranslate("Error checking existing group id.")%>');
                }
            });
        }       	    
	}    
	</script>
	
	<iframe name="EcomUpdator" id="EcomUpdator" width="501" height="501" align="right" marginwidth="0" marginheight="0" border="0" frameborder="0" src="EcomUpdator.aspx"></iframe>
	
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
