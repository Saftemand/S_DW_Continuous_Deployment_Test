<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrderContext_List.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderContext_List" %>

<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
</head>
<body>
    <form id="form2" runat="server">
	    <asp:Literal id="BoxStart" runat="server"></asp:Literal>

        <dw:List ID="List1" runat="server" Title="" ShowTitle="false" StretchContent="false"  PageSize="25">
            <Filters></Filters>
            <Columns>
			    <dw:ListColumn ID="colId" runat="server" Name="Id" Width="100" EnableSorting="true"/>
			    <dw:ListColumn ID="colName" runat="server" Name="Navn" Width="200" EnableSorting="true"/>
			    <dw:ListColumn ID="colShops" runat="server" Name="Shops" Width="400" EnableSorting="true"/>
            </Columns>
        </dw:List>

	    <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 
    </form>
</body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>