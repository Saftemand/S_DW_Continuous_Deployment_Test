<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GiftCardsList.aspx.vb" Inherits="Dynamicweb.Admin.GiftCards.GiftCardsList" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <link href="../css/Main.css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript">

        Event.observe(document, 'dom:loaded', function () {
            $('CreationDateFilter').getElementsByClassName('ClearDateImage')[0].onclick = function () {
                if ($('CreationDateFilter:DateSelector_notSet').value != 'True') {
                    Calendar.DWClearDate('CreationDateFilter:DateSelector');
                    applyFilter();
                }
            };
        });

        function help() {
		    <%=Gui.Help("", "administration.managementcenter.eCommerce.orders.giftcards")%>;
        }

        function showTransactoinsList(giftCardID, giftCardCurrencyCode) {
            var url = '/Admin/Module/eCom_Catalog/dw7/GiftCards/GiftCardTransactionsList.aspx?GiftCardID=' + giftCardID + '&GiftCardCurrencyCode=' + giftCardCurrencyCode;
            var popup = giftCardTransactions_wnd;
            popup.set_contentUrl(url);
            popup.show();
        }

        function applyFilter() {
            form1.submit();
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <dw:Toolbar ID="ListBar1" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="CloseToolbarButton" runat="server" Divide="None" Image="Cancel" Text="Cancel"
            OnClientClick="doEcom7Close();">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="HelpToolbarButton" runat="server" Divide="None" Image="Help" Text="Help"
            OnClientClick="help();">
        </dw:ToolbarButton>
    </dw:Toolbar>
        <dw:List ID="GiftCardsLst" ShowFooter="true" runat="server" TranslateTitle="True" StretchContent="True" PageSize="25" ShowPaging="true" AllowMultiSelect="true" Title="GiftCards">
            <Columns>
			    <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true"/>
			    <dw:ListColumn ID="colCode" runat="server" Name="Code" EnableSorting="true"/>
			    <dw:ListColumn ID="colCurrency" runat="server" Name="Currency" EnableSorting="true"/>
			    <dw:ListColumn ID="colCreationDate" runat="server" Name="Creation Date" EnableSorting="true"/>
			    <dw:ListColumn ID="colExpiryDate" runat="server" Name="Expiry Date" EnableSorting="true"/>
			    <dw:ListColumn ID="colInitialAmount" runat="server" Name="InitialAmount" EnableSorting="true"/>
			    <dw:ListColumn ID="colBalance" runat="server" Name="RemainingBalance" EnableSorting="true"/>
            </Columns>
            <Filters>
                <dw:ListDateFilter runat="server" id="CreationDateFilter" Label="Creation date" OnClientChange="applyFilter();" /> 
                <dw:ListTextFilter runat="server" id="CodeFilter" Label="Search code" ShowSubmitButton="true" Divide="After" />
            </Filters>
        </dw:List>   
    <dw:PopUpWindow ID="giftCardTransactions" UseTabularLayout="true" TranslateTitle="true" Title="GiftCard Transactions"
            ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="false" IsModal="True"
            ShowHelpButton="false" SnapToScreen="true" Width="620" AutoCenterProgress="true" Height="400" runat="server" /> 

        <%Translate.GetEditOnlineScript()%>
</form>   
</body>
</html>


