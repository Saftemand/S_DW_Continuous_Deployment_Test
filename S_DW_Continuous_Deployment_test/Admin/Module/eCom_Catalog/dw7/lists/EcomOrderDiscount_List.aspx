<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrderDiscount_List.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderDiscount_List" %>
<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>
<%@ Register Src="~/Admin/Module/eCom_Catalog/dw7/lists/UCOrderDiscount_List.ascx" TagPrefix="odl" TagName="UCOrderDiscount_List" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
        <script language="javascript" type="text/javascript">

         function deleteDiscount() {
            var discountIDs = getCheckedRows();
            if (confirm("<%= Translate.JsTranslate("Do you want to delete this discount.")%>")) {
                    new Ajax.Request("/Admin/Module/eCom_Catalog/dw7/lists/EcomOrderDiscount_List.aspx", {
                    method: 'get',
                    parameters: {
                        DiscountID: discountIDs,
                        Delete: "delete"
                    },
                    onComplete: function (transport) {
                        if (transport.responseText.length == 0) {
                            window.location.reload(true);
                        } else {
                            alert(transport.responseText);
                        }
                    }
                });
            }
        }

        function onCloseDialog() {
            window.location.reload(true);
        }

        function editDiscount(id) {
            document.location.href = '/Admin/Module/eCom_Catalog/dw7/edit/EcomOrderDiscount_Edit.aspx?OrderDiscountID=' + id;
        }

        function copyDiscount(id) {
            document.location.href = '/Admin/Module/eCom_Catalog/dw7/edit/EcomOrderDiscount_Edit.aspx?OrderDiscountID=' + id + '&CopyMode=true';
        }

        function selectDiscount(id)
        {
            var row = List.getRowByID('DiscountList', id.toString());
            List.setRowSelected('DiscountList', row, !List.rowIsSelected(row), null);
        }

        function isIEBrowser() {
            var ua = window.navigator.userAgent
            var msie = ua.indexOf("MSIE ")
            if (msie < 0) {
                msie = ua.indexOf("rv:11.0")
            }
            if (msie > 0) {
                return true;
            } else {
                return false;
            }
        }

        function discountSelected() {
            if (List && List.getSelectedRows('DiscountList').length > 0) {
                $("cmdDiscountDelete").className = "";
                $("linkDiscountDelete").href = "javascript:deleteDiscount();";
            } else {
                $('cmdDiscountDelete').className = "toolbarButtonDisabled";
            }
        }

        function getCheckedRows() {
            var IDs = [];
            var discountID = ContextMenu.callingID;
            var checkedRows = List.getSelectedRows('DiscountList');

            if (checkedRows && checkedRows.length > 0) {
                for (var i = 0; i < checkedRows.length; i++) {
                    IDs[i] = checkedRows[i].id.replace("row", "");
                }
            } else if (discountID) {
                IDs[0] = discountID;
            }
            return IDs;
        }

        function reStretch() {
                Dynamicweb.Controls.StretchedContainer.stretchAll();
                Dynamicweb.Controls.StretchedContainer.Cache.updatePreviousDocumentSize();
        }

        function IncludeInDiscounts()
        {
            var discountArr = getCheckedRows().join(",")
            
            showLoad();
            window.opener.parent.right.IncludeDiscounts(discountArr);
            window.close();
        }

        function ExcludeFromDiscounts() {
            var discountArr = getCheckedRows().join(",")

            showLoad();
            window.opener.parent.right.ExcludeDiscounts(discountArr);
            window.close();
        }

        function showLoad() {
            if ($('OuterContainer').style.display == "") {
                $('OuterContainer').style.display = "none";
                $('WaitDialog').style.display = "";
            }
        }
    </script>
    <style type="text/css">
        #divToolbar {
            position:fixed;
            left:0px;
            top:0px;
            width:100%;
        }
        #OuterContainer {
            top:46px;
            position:fixed;
            width:100%;
        }
    </style>
</head>
<body onload="reStretch()">
    <form id="form1" runat="server">
    <input type="hidden" name="selctedRowID" id="selctedRowID" />
    <div style="height: 98%;">
        <asp:Literal id="BoxStart" runat="server"></asp:Literal>
        <div id="WaitDialog" style="position: absolute; top: 40px; left: 5px; width: 100%; height: 1px; display: none; cursor: wait;">
            <img src="../images/loading.gif" border="0" alt="loading" />
        </div>
       <dw:StretchedContainer ID="OuterContainer" Stretch="Fill" Anchor="document" runat="server" Scroll="VerticalOnly">
        <odl:UCOrderDiscount_List runat="server"
             ID="DiscountList"
             AllowMultiSelect="true"
             UseCountForPaging="true"
             HandleSortingManually="true"
             HandlePagingManually="true"
             Personalize="true"
             StretchContent="true" 
             ShowTitle="false"
             PageSize="50"
             PageNumber="1"
             RowUsePointerCursor="true"
             RowContextMenuID="OrderDiscountContext"
             OnClientSelect="discountSelected();"            
             OnClientRowClickCallback="editDiscount">
        </odl:UCOrderDiscount_List>
        </dw:StretchedContainer>
        <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 
    </div>
    <dw:ContextMenu ID="OrderDiscountContext" runat="server">
        <dw:ContextMenuButton ID="cmdCopyDiscount" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_add_small.gif" Text="Copy discount" OnClientClick="copyDiscount(ContextMenu.callingID);" />
        <dw:ContextMenuButton ID="cmdEditDiscount" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_small.gif" Text="Edit discount" OnClientClick="editDiscount(ContextMenu.callingID);" />
        <dw:ContextMenuButton ID="cmdDeleteDiscount" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_delete_small.gif" Text="Delete discount" OnClientClick="deleteDiscount(ContextMenu.callingID);" />
    </dw:ContextMenu>

    <dw:PopUpWindow ID="OrderDiscountEditDialog" Title="Edit Discount" UseTabularLayout="true" TranslateTitle="true" ContentUrl="" 
    ShowClose="false" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="false" 
    ShowHelpButton="false" SnapToScreen="false" Width="705" AutoCenterProgress="true" Height="610" runat="server"/>

    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
