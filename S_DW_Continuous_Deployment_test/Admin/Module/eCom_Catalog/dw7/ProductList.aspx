<%@ Page Language="vb" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master"
    AutoEventWireup="false" CodeBehind="ProductList.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.ProductList" %>
    
<%@ Register TagPrefix="ecom" Namespace="Dynamicweb.Admin.eComBackend" Assembly="Dynamicweb.Admin" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">

    <link rel="Stylesheet" href="css/productList.css" />

    <script type="text/javascript" src="js/ProductList.js"></script>
    <script type="text/javascript" src="js/productMenu.js"></script>
    <script type="text/javascript" language="JavaScript" src="images/layermenu.js"></script>
    <script type="text/javascript" language="JavaScript" src="Wizard/wizardstart.js"></script>
    
    <style type="text/css">
        .list table.main_stretcher tr.header,
        .list table.main_stretcher tr.header > td
        {
	        visibility: visible;
        }        
    </style>
    <script type="text/javascript">
        this.previousValue;

        function confirmAll() {
            var selectElement = document.getElementById('ProductList:fNumRows').value;
            if (selectElement == "all") {
                if (!confirm('<%= Translate.JsTranslate("Selecting All can be very slow if you have many products. Continue?")%>')) {
                    document.getElementById('ProductList:fNumRows').value = this.previousValue;
                    return 0;
                } else {
                    List._submitForm('ProductList:fNumRows');
                }
            } else {
                this.previousValue = document.getElementById('ProductList:fNumRows').value;
                List._submitForm('ProductList:fNumRows');
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">

    <input id="productIds" name="productIds" type="hidden" value="" />
    <input id="productColumns" name="productColumns" type="hidden" value="<%= GetProductColumns() %>" />
    <input id="productListState" name="productListState" type="hidden" value="<%= ProductList.GetControlState() %>" />

<asp:Panel runat="server" ID="ContentPanel">

    <!-- Ribbon bar start -->
    <div style="min-width:1000px;overflow:hidden;">
    <dw:RibbonBar ID="Ribbon1" runat="server">
        <dw:RibbonBarTab ID="RibbonBarTab1" Name="Products" runat="server">
            
            <dw:RibbonBarGroup ID="RibbonBarGroup10" Name="Tools" runat="server">
                <%--<dw:RibbonBarButton ID="RibbonBarButton7" Text="Move to group" Image="FolderInto"
                    runat="server" Size="Small">
                </dw:RibbonBarButton>
                <dw:RibbonBarButton ID="RibbonBarButton2" Text="Attach to group" runat="server" Image="FolderAdd"
                    Size="Small">
                </dw:RibbonBarButton>--%>
                <dw:RibbonBarButton ID="cmdDelete" Text="Delete" runat="server" ImagePath="/Admin/Images/eCom/eCom_Product_delete_small.gif" Size="Small" />
                <dw:RibbonBarButton ID="cmdDelocalize" Text="Delocalize" ImagePath="/Admin/Images/Ribbon/Icons/small/earth_delete.png" runat="server" Size="Small" />
                <dw:RibbonBarButton ID="cmdLocalize" Text="Localize" ImagePath="/Admin/Images/Ribbon/Icons/small/earth.png" runat="server" Size="Small" />
            </dw:RibbonBarGroup>
            
            <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Insert" runat="server">
                
                <dw:RibbonBarButton ID="cmdNewProduct" Text="New product" ImagePath="/Admin/Images/eCom/eCom_Product_add.gif" runat="server" Size="Large" OnClientClick="newProduct();" />
                <dw:RibbonBarButton ID="cmdBulkCreate" Text="Create multiple products" ImagePath="/Admin/Images/eCom/add_multiple_products.gif" runat="server" Size="Large" OnClientClick="createMultipleProducts();" />
            </dw:RibbonBarGroup>
            
            <dw:RibbonBarGroup ID="RibbonBarGroup2" Name="Edit" runat="server">
                <dw:RibbonBarButton ID="EditProducts" Text="Edit products" Image="View_Edit" Size="Small" runat="server" OnClientClick="productListEditing();" />
                <dw:RibbonBarButton ID="SortProducts" Text="Sort products" ImagePath="/Admin/Images/eCom/eCom_Product_sort_small.gif" Size="Small" runat="server" OnClientClick="productListSorting();" />
                <dw:RibbonBarButton ID="cmdEditGroup" Text="Edit group" ImagePath="/Admin/Module/ecom_catalog/dw7/images/content/eCom_Groups_small.gif" runat="server" Size="Small" OnClientClick="editGroup();" />
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup ID="RibbonGroupLanguage" Name="Language" runat="server">
                <ecom:LanguageSelector ID="langSelector" OnClientSelect="selectLang" runat="server" />
             </dw:RibbonBarGroup>
             
            <dw:RibbonBarGroup ID="RibbonBarGroup3" Name="Help" runat="server">
                <dw:RibbonBarButton ID="RibbonBarButton6" Image="Help" runat="server" Text="Help" OnClientClick="help();" />
            </dw:RibbonBarGroup>
            
        </dw:RibbonBarTab>
        <dw:RibbonBarTab ID="tabAdvanced" Name="Filters" runat="server">
            <dw:RibbonBarGroup ID="groupSearchFilters" Name="Search filters" ModuleSystemName="eCom_SearchExtended" runat="server">
                <dw:RibbonBarButton ID="cmdFilterVisibility" Text="Configure visibility" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_display.png" Size="Small" runat="server" />
                <dw:RibbonBarButton ID="cmdFilterOptions" Text="Edit filter options" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_edit.png" Size="Small" runat="server" />
                <dw:RibbonBarButton ID="cmdExecutionSettings" Text="Performance settings" ImagePath="/Admin/Images/Ribbon/Icons/Small/funnel_preferences.png" Size="Small" runat="server" />
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup ID="grpHelp" Name="Help" runat="server">
                <dw:RibbonBarButton ID="cmdHelp" Image="Help" runat="server" Text="Help" OnClientClick="help();" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
    </dw:RibbonBar>
    </div>
    <!-- Ribbon bar end -->

    <!-- List start -->
    <div id="ListContent" style="overflow: auto;">
    <dw:List runat="server"
        ID="ProductList"  
        Title="» Bikes » Road bikes"
        ShowCount="false"
        AllowMultiSelect="true"
        OnRowExpand="OnRowExpand"
        HandlePagingManually="true"
        HandleSortingManually="true"
        OnClientSelect="productSelected();"
        Personalize="true"
        PageSize="25">
        <Filters>
            <dw:ListTextFilter runat="server" ID="TextFilter" WaterMarkText="Search" Width="175" ShowSubmitButton="True" Divide="None" />
            <dw:ListDropDownListFilter ID="fNumRows" Width="150" Label="Products per page" AutoPostBack="true" Priority="3" runat="server" OnClientChange="confirmAll() && ">
                <Items>
                    <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                    <dw:ListFilterOption Text="50" Value="50" DoTranslate="false"/>
                    <dw:ListFilterOption Text="75" Value="75" DoTranslate="false"/>
                    <dw:ListFilterOption Text="100" Value="100" DoTranslate="false"/>
                    <dw:ListFilterOption Text="200" Value="200" DoTranslate="false"/>
                    <dw:ListFilterOption Text="All" Value="all" DoTranslate="True"/>
                </Items>
            </dw:ListDropDownListFilter>
        </Filters>
    </dw:List>
    </div>
    <!-- List end -->

    <!-- Context menu start -->
    <dw:ContextMenu ID="ProductContext" runat="server">
        <dw:ContextMenuButton ID="copyProductButton" runat="server" Image="Copy" OnClientClick="productMenu.copyProduct();" Text="Copy" />
        <dw:ContextMenuButton ID="attachMultipleProductsButton" Views="common,ungroup" runat="server" Image="MoveDocument" OnClientClick="productMenu.attachMultipleProducts();" Text="Add to group" />
        <dw:ContextMenuButton ID="editProductButton" runat="server" Image="EditDocument" Text="Edit product" OnClientClick="productMenu.editProduct();" />
        <dw:ContextMenuButton ID="moveProductButton" runat="server" Image="MoveDocument" OnClientClick="productMenu.moveProduct();" Text="Move" />
        <dw:ContextMenuButton ID="removeProductButton" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/RemoveDocument.png" OnClientClick="productMenu.detachProduct();" Text="Detach from group" />
        <dw:ContextMenuButton ID="deleteProductButton" runat="server" Image="DeleteDocument" Text="Delete" OnClientClick="productMenu.deleteProduct();" />
        <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" Divide="Before" ImagePath="/Admin/Images/Ecom/Ecom_Product_active_small.gif"  OnClientClick="productMenu.activateProduct();" Text="Activate" />
        <dw:ContextMenuButton ID="ContextMenuButton2" runat="server" ImagePath="/Admin/Images/Ecom/Ecom_Product_deactive_small.gif"  OnClientClick="productMenu.deactivateProduct();" Text="Deactivate" />
    </dw:ContextMenu>
    <!-- Context menu end -->

    <dw:PopUpWindow ID="pwGroupFiltersEdit" Title="Search filters" UseTabularLayout="true" TranslateTitle="true" ContentUrl="/Admin/Module/eCom_Catalog/dw7/GroupFiltersEdit.aspx" ShowClose="true" HidePadding="false" 
        AutoReload="true" ShowOkButton="true" ShowCancelButton="true" ShowHelpButton="false" Width="700" Height="450" OkText="Save" CancelText="Close" runat="server" />

    <dw:Dialog 
        ID="LocalizationDialog" 
        runat="server" 
        Title="Localization" 
        TranslateTitle="true"
        ShowClose="true" 
        Width="400">
        <div style="margin: 5px">
            <dw:TranslateLabel ID="TranslateLabel3" runat="server" text="Do you want to localize all selected products to the current language?" />
            <br />
            <asp:CheckBox id="deactivateProducts" runat="server" Text="Deactivate products after localization" />
        </div>
        <div style="text-align:right;">
	        <asp:Button ID="btnLocalize" CssClass="newUIbutton" style="max-width:50px" runat="server" OnClick="cmdLocalize_Click" Text="OK" />
	        <button type="button" class="dialog-button-cancel" onclick="dialog.hide('LocalizationDialog');return false;"><dw:TranslateLabel ID="TranslateLabel5" runat="server" text="Cancel" /></button>
	    </div>
    </dw:Dialog>

</asp:Panel>
    
	<script type="text/javascript">

    // Set Grid height
    window.onload = window.onresize = function () {

        var elemGrid = document.getElementById('ListContent');
        if (elemGrid) {

            var ribbonHeight = 0;

            var elemRibbon = document.getElementById('Ribbon1');
            if (elemRibbon) {
                ribbonHeight = elemRibbon.offsetHeight;
            }
        
            var gridHeight = document.body.clientHeight - ribbonHeight;

            if (gridHeight < 0) {
                gridHeight = 0;
            }

            elemGrid.style.height = gridHeight + 'px';
        }        
    }

	function help(){
		<%=Dynamicweb.Gui.Help("", "ecom.productlist", "en") %>
	}

    	productMenu._successCopyMessage = '<%= Translate.JsTranslate("The selected products were successfully copied.")%>';
	    productMenu._failureCopyMessage = '<%= Translate.JsTranslate("Errors occurred when copying the products. Some products may have been copied. Error message:")%>';
	    productMenu._deleteMessage = '<%= Translate.JsTranslate("Do you want to delete the selected products? This will delete all language versions!")%>';
	    productMenu._deleteMessage2 = '<%= Translate.JsTranslate("Do you want to delete the selected products? This will delete all language versions and from all groups!")%>';
	    productMenu._detachMessage = '<%= Translate.JsTranslate("Do you want to detach the selected products? This will remove all language versions of the selected products from the group!")%>';
	    productMenu._failureDetachMessage = '<%= Translate.JsTranslate("Errors occurred when detaching the products. Some products may have been detached.")%>';

	    this.previousValue = document.getElementById('ProductList:fNumRows').value;
	</script>
    
    <span id="spDelocalizeMsg" style="display: none"><dw:TranslateLabel id="lbDelocalizeMsg" Text="Do you want to delocalize the selected products?" runat="server" /></span>
    <span id="spDeleteMsg" style="display: none"><dw:TranslateLabel id="TranslateLabel1" Text="Do you want to delete the selected products? This will delete all language versions!" runat="server" /></span>
    
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript() %>
    
</asp:Content>
