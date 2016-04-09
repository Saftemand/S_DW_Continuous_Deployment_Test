<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Unsubscribe.aspx.vb" Inherits="Dynamicweb.Admin.Unsubscribe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">
        body {
            background-color: darkgray;
        }
        p {
            text-align: center;
        }
        span.heading {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form runat="server">
        <p>
            <span class="heading"><asp:Label runat="server" ID="lblHeader"></asp:Label></span><br />
            <asp:Label runat="server" ID="lblDescription"></asp:Label>
        </p>
    </form>
</body>
</html>
