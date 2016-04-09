<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VouchersManagerMain.aspx.vb" Inherits="Dynamicweb.Admin.VouchersManager.VouchersManagerMain" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" language="javascript" src="js/VouchersManagerMain.js"></script>
    <script type="text/javascript" language="javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript" language="javascript">
            function help() {
		        <%=Dynamicweb.Gui.Help("", "administration.managementcenter.eCommerce.productcatalog.vouchers") %>
	        }
    </script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
    <dw:Toolbar ID="ListBar1" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="SaveToolbarButton" runat="server" Divide="None" Image="Save"
            Text="Save" Disabled="true">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="SaveAndCloseToolbarButton" runat="server" Divide="None" Image="SaveAndClose"
            Text="Save and Close" Disabled="true">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="CancelToolbarButton" runat="server" Divide="None" Image="Cancel"
            Text="Cancel" OnClientClick="doEcom7Close();">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="NewVoucherListToolbarButton" runat="server" Divide="None" Image="Plus"
            Text="New voucher list" OnClientClick="vouchersManagerMain.editList();">
        </dw:ToolbarButton>
        <dw:ToolbarButton ID="HelpToolbarButton" runat="server" Divide="None" Image="Help" Text="Help"
            OnClientClick="help();">
        </dw:ToolbarButton>
    </dw:Toolbar>
    <dw:List ID="VouchersLists" runat="server" Title="Vouchers" ShowTitle="True" StretchContent="false"  PageSize="25" ContextMenuID="VouchersListsContext">
        <Columns>
			    <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true"/>
			    <dw:ListColumn ID="colActive" runat="server" Name="Active" EnableSorting="true"/>
			    <dw:ListColumn ID="colValueProvider" runat="server" Name="Value Provider" EnableSorting="true"/>
			    <dw:ListColumn ID="colProviderName" runat="server" Name="Provider Name" EnableSorting="true"/>
			    <dw:ListColumn ID="colValue" runat="server" Name="Value" EnableSorting="true"/>
			    <dw:ListColumn ID="colType" runat="server" Name="Type" EnableSorting="true"/>
			    <dw:ListColumn ID="colDateFrom" runat="server" Name="Date From" EnableSorting="true"/>
			    <dw:ListColumn ID="colDateTo" runat="server" Name="Date To" EnableSorting="true"/>
        </Columns>
    </dw:List>
    </form>
    <dw:ContextMenu ID="VouchersListsActiveItemContext" runat="server" >
        <dw:ContextMenuButton ID="AddListContextMenuButton1" runat="server" Divide="None" Image="EditDocument" Text="Edit list" Views="activate_cat,deactivate_cat" OnClientClick="vouchersManagerMain.editList()" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeactivateListContextMenuButton" runat="server" Divide="None" Image="Delete" Text="Deactivate list" Views="deactivate_cat" OnClientClick="vouchersManagerMain.deactivateList()" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteListContextMenuButton1" runat="server" Divide="None" Image="DeleteDocument" Text="Delete list" Views="activate_cat,deactivate_cat" OnClientClick="vouchersManagerMain.deleteList();" > </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="VouchersListsInactiveItemContext" runat="server" >
        <dw:ContextMenuButton ID="AddListContextMenuButton2" runat="server" Divide="None" Image="EditDocument" Text="Edit list" Views="activate_cat,deactivate_cat" OnClientClick="vouchersManagerMain.editList()" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ActivateListContextMenuButton" runat="server" Divide="None" Image="Check" Text="Activate list" Views="activate_cat" OnClientClick="vouchersManagerMain.activateList()" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteListContextMenuButton2" runat="server" Divide="None" Image="DeleteDocument" Text="Delete list" Views="activate_cat,deactivate_cat" OnClientClick="vouchersManagerMain.deleteList();" > </dw:ContextMenuButton>
    </dw:ContextMenu>


    <script type="text/javascript">
        //vouchersManagerMain.listList();
    </script>
    <% Translate.GetEditOnlineScript()%>
</body>
</html>
