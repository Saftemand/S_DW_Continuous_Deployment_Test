<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UCOrderList.ascx.vb" Inherits="Dynamicweb.Admin.UCOrderList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

 <input id="orderIds" name="orderIds" type="hidden" value="" />
 <input id="ShopID" name="ShopID" type="hidden" value="<%=Dynamicweb.Base.ChkString(Dynamicweb.Base.Request("ShopID")) %>" />
 <input id="isQuotes" name="isQuotes" type="hidden" value="<%=IsQuotes%>"/>
<asp:Panel runat="server" ID="ContentPanel">
    <!-- Ribbon bar start -->
    <div style="min-width:832px;overflow:hidden;">
    <dw:RibbonBar ID="OrderListRibbon" runat="server">
        <dw:RibbonBarTab ID="TabOrders" Name="Orders" runat="server">
            <dw:RibbonBarGroup Name="Tools" runat="server">
                <dw:RibbonBarButton ID="ButtonDelete" Image="DeleteDocument" Size="Small" Text="Delete" OnClientClick="deleteOrder();" runat="server" Disabled="true"/>
                <dw:RibbonBarButton ID="ButtonCapture" ImagePath="/Admin/Images/eCom/eCom_Payment_small.gif" Size="Small" Text="Capture orders" OnClientClick="captureOrders();" runat="server" Disabled="true"/>
                <dw:RibbonBarButton ID="ButtonCreateShippingDocuments" ImagePath="/Admin/Images/eCom/eCom_ShippingDocument_small.png" Size="Small" Text="Create shipping documents" OnClientClick="createShippingDocuments();" runat="server" Disabled="true"/>
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup ID="OrderStateButtonView" Name="Set order state" runat="server">
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup ID="OrderStateListView" Name="Set order state" runat="server">
                <dw:RibbonBarPanel ID="RibbonBarPanel1" runat="server">
                    <dw:GroupDropDownList ID="OrderStateList" CssClass="NewUIinput" style="width: auto; margin-top: 3px;" runat="server" />
                </dw:RibbonBarPanel>
                <dw:RibbonBarButton ID="ButtonSetOrderState" Image="Check" Size="Small" Text="Set" OnClientClick="setOrderState($(orderStateListClientID).value);" runat="server" Disabled="true"/>
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup runat="server" Name="Filters">
                <dw:RibbonBarButton runat="server" ID="ButtonReset" Text="Reset" Size="Large" ImagePath="/Admin/Module/eCom_Catalog/dw7/images/OrderList/reset.png" OnClientClick="ResetFilters();" />
                <dw:RibbonBarButton runat="server" ID="ButtonApplyFilters" Text="Apply" Size="Large" Image="Check" OnClientClick="javascript:List._submitForm('List');" />
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup Name="Print" runat="server">
                <dw:RibbonBarButton ID="ButtonPrint" Image="Print" Size="Large" Text="Print" OnClientClick="printOrders();" runat="server" />
            </dw:RibbonBarGroup>

            <dw:RibbonBarGroup Name="Help" runat="server">
                <dw:RibbonBarButton ID="ButtonHelp" Image="Help" Size="Large" Text="Help" OnClientClick="helpOL();" runat="server" />
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>

    </dw:RibbonBar>
    </div>
    <!-- Ribbon bar end -->

    <!-- List start -->
    <div id="ListContent" class="content" style="overflow: auto;">
    <dw:List runat="server"
             ID="List"
             AllowMultiSelect="true"
             Title="Orders" UseCountForPaging="true"
             HandleSortingManually="true"
             HandlePagingManually="true"
             OnClientSelect="rowSelected();"
             ShowCollapseButton="true"
             Personalize="true"
             OnClientCollapse="SaveCollapseState(true);enableResetButton();"
             OnClientUnCollapse="SaveCollapseState(false);">
        <Filters>

            <dw:ListDropDownListFilter runat="server" ID="OrderStateFilter" Label="Order state" Width="150" OnClientChange="enableResetButton();"/>

            <dw:ListDropDownListFilter runat="server" ID="DatePresetFilter" Width="150" Label="Preset interval" OnClientChange="enableResetButton(); javascript:setDatePreset();" >
                <Items>
                    <dw:ListFilterOption Text="Select interval" Value="" selected="true"/>
                    <dw:ListFilterOption Text="All dates" Value="All_Time" />
                    <dw:ListFilterOption Text="Today" Value="Today" />
                    <dw:ListFilterOption Text="Latest week" Value="Last_Week" />
                    <dw:ListFilterOption Text="Latest month" Value="Last_Month" />
                    <dw:ListFilterOption Text="Latest 6 months" Value="Last_6_Months" />
                    <dw:ListFilterOption Text="Latest year" Value="Last_Year" />
                </Items>
            </dw:ListDropDownListFilter>

            <dw:ListDropDownListFilter runat="server" ID="CaptureStateFilter" Label="Capture state" Width="150" Divide="After" OnClientChange="enableResetButton();">
                <Items>
                    <dw:ListFilterOption Text="All" Value="All" DoTranslate="true" Selected="true" />
                    <dw:ListFilterOption Text="Captured" Value="Captured" DoTranslate="true" />
                    <dw:ListFilterOption Text="Not captured" Value="NotCaptured" DoTranslate="true" />
                    <dw:ListFilterOption Text="Not supported" Value="NotSupported" DoTranslate="true" />
                </Items>
            </dw:ListDropDownListFilter>

            <dw:ListDropDownListFilter runat="server" ID="CompletedFilter" Label="Order progress" Width="150" OnClientChange="enableResetButton();"/>

            <dw:ListDateFilter runat="server" id="FromDateFilter" Label="Start date" OnClientChange="enableResetButton();" />

            <dw:ListDropDownListFilter runat="server" ID="UntransferredFilter" Label="Untransferred" Width="150" Divide="After" OnClientChange="enableResetButton();">
                <Items>
                    <dw:ListFilterOption Text="All" Value="0" DoTranslate="true" Selected="true" />
                    <dw:ListFilterOption Text="Yes" Value="1" DoTranslate="true" />                    
                </Items>
            </dw:ListDropDownListFilter>            

            <dw:ListDropDownListFilter runat="server" ID="PageSizeFilter" Label="Orders per page" Width="150" OnClientChange="enableResetButton();" >
                <Items>
                    <dw:ListFilterOption Text="10" Value="10" DoTranslate="false"/>
                    <dw:ListFilterOption Text="25" Value="25" DoTranslate="false" Selected="true" />
                    <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                    <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                    <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                    <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                </Items>
            </dw:ListDropDownListFilter>

            <dw:ListDateFilter runat="server" id="ToDateFilter" Label="End date" OnClientChange="enableResetButton();" />            

            <dw:ListTextFilter runat="server" id="TextFilter" Label="Search" Width="175" ShowSubmitButton="false" Divide="After" OnClientChange="enableResetButton();" />
        </Filters>
    </dw:List>
    </div>
    <!-- List end -->

 

       <!-- context menu for carts/quotes in the orderlist start -->
    <dw:ContextMenu runat="server" ID="OrderListNonOrderContext">
        <dw:ContextMenuButton ID="ContextShowOrder" Image="EditDocument" Text="Show" OnClientClick="showOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextDeleteOrders" Image="DeleteDocument" Text="Delete" OnClientClick="deleteOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextPrint" Image="Print" Text="Print" Divide="Before" OnClientClick="printOrders();" runat="server" />
        <dw:ContextMenuButton ID="ContextBulkCapture" ImagePath="/Admin/Images/eCom/eCom_Payment_small.gif" Text="Capture" Divide="Before" OnClientClick="captureOrders();" runat="server" />
    </dw:ContextMenu>
    <!-- context menu end-->
     <!-- context menu for completed orders in the orderlist start -->
    <dw:ContextMenu runat="server" ID="OrderListOrderContext">
        <dw:ContextMenuButton ID="ContextShowOrder2" Image="EditDocument" Text="Show order" OnClientClick="showOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextDeleteOrders2" Image="DeleteDocument" Text="Delete" OnClientClick="deleteOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextSetOrderState2" Image="Check" Text="Set order state" Divide="Before" runat="server">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextCreateRMA2" Image="DeleteDocument" Text="Create new RMA" OnClientClick="createRma(createRmaConfirmationText);" runat="server" />
        <dw:ContextMenuButton ID="ContextPrint2" Image="Print" Text="Print order" Divide="Before" OnClientClick="printOrders();" runat="server" />
        <dw:ContextMenuButton ID="ContextBulkCapture2" ImagePath="/Admin/Images/eCom/eCom_Payment_small.gif" Text="Capture orders" Divide="Before" OnClientClick="captureOrders();" runat="server" />
    </dw:ContextMenu>
    <!-- Order context menu end -->
    <!-- context menu for carts/Orders in the QuoteList start -->
    <dw:ContextMenu runat="server" ID="QuoteListNonQuoteContext">
        <dw:ContextMenuButton ID="ContextShowOrder3" Image="EditDocument" Text="Show quote" OnClientClick="showOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextDeleteOrders3" Image="DeleteDocument" Text="Delete" OnClientClick="deleteOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextPrint3" Image="Print" Text="Print order" Divide="Before" OnClientClick="printOrders();" runat="server" />
    </dw:ContextMenu>
    <!-- context menu end-->
     <!-- context menu for Quotes in the QuoteList start -->
    <dw:ContextMenu runat="server" ID="QuoteListQuoteContext">
        <dw:ContextMenuButton ID="ContextShowOrder4" Image="EditDocument" Text="Show quote" OnClientClick="showOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextDeleteOrders4" Image="DeleteDocument" Text="Delete" OnClientClick="deleteOrder();" runat="server" />
        <dw:ContextMenuButton ID="ContextSetOrderState4" Image="Check" Text="Set quote state" Divide="Before" runat="server">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextPrint4" Image="Print" Text="Print quote" Divide="Before" OnClientClick="printOrders();" runat="server" />
    </dw:ContextMenu>
    <!-- Order context menu end -->

</asp:Panel>

<!-- Print Panel start -->

<asp:Panel ID="PrintPreview" runat="server" style="display: none;">
    <dw:RibbonBar ID="PrintRibbon" runat="server">
        <dw:RibbonBarTab ID="PrintRibbonPrintTab" Name="Print" runat="server">
            <dw:RibbonBarGroup ID="PrintRibbonPrintGroup" Name="Tools" runat="server">
                <dw:RibbonBarButton ID="PrintRibbonCloseButton" Image="Error" Text="Close" Size="Large" OnClientClick="closePrintPreview();" runat="server" />
                <dw:RibbonBarButton ID="PrintRibbonRefreshButton" Image="Refresh" Text="Refresh" Size="Large" OnClientClick="reloadPrintPreview();" runat="server" />
                <dw:RibbonBarButton ID="PrintRibbonPrintButton" Image="Print" Text="Print" Size="Large" OnClientClick="processPrinting();" runat="server" />
            </dw:RibbonBarGroup>
            <dw:RibbonBarGroup ID="PrintRibbonTemplateGroup" Name="Template" runat="server">
                <dw:RibbonBarPanel ID="PrintRibbonTemplatePanel" runat="server">
                    <dw:FileManager ID="PrintTemplate" Folder="Templates/eCom7/Order" OnChange="reloadPrintPreview(this.value);" runat="server" />
                </dw:RibbonBarPanel>
            </dw:RibbonBarGroup>
        </dw:RibbonBarTab>
    </dw:RibbonBar>

    <!-- Content -->
    <div id="PrintContent"></div>

    <!-- Loading gif -->
    <div id="PrintLoading">
        <img src="/Admin/Module/eCom_Catalog/images/ajaxloading.gif" alt=""/><br /><br />
        <dw:TranslateLabel runat="server" Text="Preparing orders for printing" />
    </div>

    <!-- Error div -->
    <div id="PrintError">
        <img src="/Admin/Images/Ribbon/Icons/error.png" alt="" />
        <dw:TranslateLabel runat="server" Text="An error occured, please try again." />
    </div>
</asp:Panel>
<!-- Print Panel end -->

<!-- Action start -->
    <input type="hidden" runat="server" id="ActionHidden"  name="Action" value="" />
    <input type="hidden" runat="server" id="OrderIDsHidden" name="OrderIDs" value="" />
    <input type="hidden" id="SelectedOrderStateID" name="SelectedOrderStateID" value="" />
    <input type="hidden" id="OrderListPageNumber" name="OrderListPageNumber" value="<%=List.PageNumber %>" />
<!-- Action end -->


  <dw:PopUpWindow ID="dlgCapture" Title="Capture order" AutoCenterProgress="true" TranslateTitle="true" ShowOkButton="false" ShowCancelButton="true" CancelText="Close" ShowHelpButton="false" 
                ShowClose="true" Width="450" Height="300" AutoReload="true" UseTabularLayout="true" runat="server" />

<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	<dw:Dialog ID="SetupWizardDialog" runat="server" Width="560" iframeHeight="450" ShowOkButton="false" ShowCancelButton="false" Title="Setup guide" IsIFrame="true">
	</dw:Dialog>

