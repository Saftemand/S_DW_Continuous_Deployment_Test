<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrintPopup.aspx.vb" Inherits="Dynamicweb.Admin.PrintPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Print</title>
    <script type="text/javascript" language="javascript">
        function fillPrintContent() {
            var divElm = document.getElementById("PrintContent");
            divElm.innerHTML = opener.document.getElementById("PrintContent").innerHTML;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="PrintContent">
    
    </div>
    </form>
    
</body>
    <script type="text/javascript" language="javascript">
        fillPrintContent();
        print();
    </script>
</html>
