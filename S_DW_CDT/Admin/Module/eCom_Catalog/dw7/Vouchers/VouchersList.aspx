<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VouchersList.aspx.vb" Inherits="Dynamicweb.Admin.VouchersManager.VouchersList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Vouchers List</title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <script type="text/javascript" language="javascript" src="js/VouchersList.js"></script>
    <script type="text/javascript" language="javascript" src="js/VouchersManagerMain.js"></script>
    <script type="text/javascript" language="javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("", "administration.managementcenter.eCommerce.productcatalog.vouchers") %>
	    }
    </script>
</head>
<body>
<div style="overflow:auto; min-width:1000px;">
    <form id="form2" runat="server">
    <dw:Toolbar ID="ListBar1" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="SaveToolbarButton" runat="server" Divide="None" Image="Save"
            Text="Save" Disabled="true">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="SaveAndCloseToolbarButton" runat="server" Divide="None" Image="SaveAndClose"
            Text="Save and Close" Disabled="true">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="CloseToolbarButton" runat="server" Divide="None" Image="Cancel" Text="Cancel"
            OnClientClick="openInContentFrame('VouchersManagerMain.aspx');">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="AddVoucherToolbarButton" runat="server" Divide="None" Image="ScrollAdd"
            Text="Add Vouchers">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="DeleteVoucherToolbarButton" runat="server" Divide="None" Image="ScrollDelete"
            Text="Delete Voucher">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="GenerateVouchersToolbarButton" runat="server" Divide="None" Image="Refresh"
            Text="Generate Vouchers">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="ActivateListToolbarButton" runat="server" Divide="None" Image="Check"
            Text="Activate List">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="DeactivateListToolbarButton" runat="server" Divide="None" Image="Delete"
            Text="Deactivate List">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="SendMailsToolbarButton" runat="server" Divide="None" Image="Mail" Text="Send Mails">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="ExportToCsv" runat="server" Divide="None" ImagePath="/Admin/Images/ext/xls.gif" Text="Download vouchers in CSV">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="HelpToolbarButton" runat="server" Divide="None" Image="Help" Text="Help"
            OnClientClick="help();">
        </dw:ToolbarButton>
    </dw:Toolbar>

    <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"
        runat="server">
        <dw:List ID="vouchersList" ShowFooter="true" runat="server" TranslateTitle="True" StretchContent="true" PageSize="25" ShowPaging="true" AllowMultiSelect="true" >
            <Columns>
                <dw:ListColumn ID="ListColumn4" EnableSorting="false" runat="server" Name="" Width="5"></dw:ListColumn>
                <dw:ListColumn ID="VoucherCode" EnableSorting="true" runat="server" Name="Voucher Code" Width="80"></dw:ListColumn>
                <dw:ListColumn ID="DateUsed" EnableSorting="true" runat="server" Name="Date Used" WidthPercent="15"></dw:ListColumn>
                <dw:ListColumn ID="OrderID" EnableSorting="true"  runat="server" Name="Order" WidthPercent="15"></dw:ListColumn>
                <dw:ListColumn ID="EmailSend" EnableSorting="true" runat="server" Name="Send to" WidthPercent="15"></dw:ListColumn>
                <dw:ListColumn ID="VoucherStatus" EnableSorting="true" runat="server" Name="Voucher status" Width="30"></dw:ListColumn>
            </Columns>
        </dw:List>
    </dw:StretchedContainer>
    <dw:ContextMenu ID="vouchersContextMenu" runat="server" OnClientSelectView="vouchersList.contextMenuView" >
        <dw:ContextMenuButton ID="DeleteVoucherMenuButton" runat="server" Divide="After" Image="AddDocument" Text="New Thread" OnClientClick="message.addThread();"  >
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:Dialog runat="server" ID="vouchersGeneratorDialog" Width="550" Title="Vouchers Generator" ShowClose="true" ShowOkButton="False" HidePadding="true" >
        <iframe id="vouchersGeneratorDialogIFrame" style="width: 534px; height:380px; overflow:hidden" scrolling="no"></iframe>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="vouchersDialog" Width="416" Title="Add Voucher" ShowClose="true" ShowOkButton="False" HidePadding="true" >
        <iframe id="vouchersDialogIFrame" style="width: 400px; height:260px; overflow:hidden" scrolling="no"></iframe>
    </dw:Dialog>
    <dw:Dialog runat="server" ID="vouchersSendMailsDialog" Width="450" Title="Send Mails" ShowClose="true" ShowOkButton="False" HidePadding="true" >
        <iframe id="vouchersSendMailsDialogIframe" style="width: 434px; height:360px; overflow:hidden" scrolling="no"></iframe>
    </dw:Dialog>

        <%Translate.GetEditOnlineScript()%>
    </form>
   </div> 
</body>
</html>

