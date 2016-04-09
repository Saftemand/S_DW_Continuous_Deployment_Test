<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceSelectorListFrame.aspx.vb" Inherits="Dynamicweb.Admin.ResourceSelectorListFrame" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <dw:ControlResources runat="server" ID="ControlResources1" />
</head>
<body>
    <form id="form1" runat="server">

    <dw:List runat="server" ID="ResourceList" ShowTitle="false" StretchContent="false">
        <Columns>
            <dw:ListColumn runat="server" ID="ItemName" EnableSorting="true" />
            <dw:ListColumn runat="server" ID="ItemCategory" EnableSorting="true" />
            <dw:ListColumn runat="server" ID="ItemArea" EnableSorting="true" />
            <dw:ListColumn runat="server" ID="ItemType" EnableSorting="true" />
            <dw:ListColumn runat="server" ID="ItemAdd" />
        </Columns>
    </dw:List>

    </form>

    <script type="text/javascript">
        parent.contentIsLoaded = true;
    </script>
</body>
</html>
