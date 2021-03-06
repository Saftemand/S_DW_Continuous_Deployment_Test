﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomRmaState_List.aspx.vb"
    Inherits="Dynamicweb.Admin.EcomRmaState_List" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server">
    </dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/layermenu.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar runat="server" ID="Toolbar" ShowStart="true" ShowEnd="false">
    </dw:Toolbar>
    <dw:List ID="lstRmaStates" runat="server" Title="" ShowTitle="false" StretchContent="true"
        PageSize="25">
        <Filters>
        </Filters>
        <Columns>
            <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true" Width="300" />
            <dw:ListColumn ID="colIsTranslated" runat="server" Name="Translated" EnableSorting="true"
                Width="300" />
            <dw:ListColumn ID="colIsDefault" runat="server" Name="Default" EnableSorting="true"
                Width="300" />
        </Columns>
    </dw:List>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>