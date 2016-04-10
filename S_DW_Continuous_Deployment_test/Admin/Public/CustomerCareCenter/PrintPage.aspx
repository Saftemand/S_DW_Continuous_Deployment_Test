<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrintPage.aspx.vb" Inherits="Dynamicweb.Admin.CustomerCareCenter.PrintPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Print page</title>
    <link rel="stylesheet" type="text/css" href="/Files/Templates/eCom/CustomerCareCenter/CustomerCareCenter.css">
    <script>       
        function PrintPage()
        {
            window.focus();
            window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
      
        <div id="divPrint" enableviewstate="false" visible="false" style="margin-top:10px;" runat="server" ></div>
        
        <div id="divNoOrders" runat="server" visible="false" style="margin-top:10px;">
            No items found to print...
        </div>
        <br/>
        <noscript>
            Please, use printing capabilities of your browser to print this page.
        </noscript>
                      
    </form>
</body>
</html>
