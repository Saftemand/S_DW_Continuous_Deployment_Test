<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomLoyaltyUserTransaction_List.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomLoyaltyUserTransaction_List" %>

<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .remark:hover{
            cursor :pointer;
        }
    </style>
    </>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
        <Items>
            <dw:GenericResource Url ="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
            <dw:GenericResource Url ="../js/ecomLists.js" />
        </Items>
    </dw:ControlResources>
</head>
<body>
    <form id="form1" runat="server">
        <dw:List ID="tList" runat="server" PageSize ="25" SortDirection="Ascending" >
	    <Columns>
		    <dw:ListColumn ID="utDate" runat ="server" Name="Date"  TranslateName="true" Width="150" EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="utReward" runat="server" Name="Reward" TranslateName="true" Width="150" EnableSorting="true">
		    </dw:ListColumn>
		     <dw:ListColumn ID="utPoints" runat="server" Name="Points" TranslateName="true" Width="150" EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="utExpires" runat="server" Name="Expires" TranslateName="true" Width="150" EnableSorting="true">
		    </dw:ListColumn>
		     <dw:ListColumn ID="utComment" runat="server" Name="Comment" TranslateName="true" Width="150" EnableSorting="true">
		    </dw:ListColumn>
		</Columns>
        </dw:List>
        <dw:PopUpWindow ID="pupNewTransaction" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="350" Height="175" Title="Create new transaction" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>