<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FastLoadRedirect.aspx.vb" Inherits="Dynamicweb.Admin.FastLoadRedirect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <div style="margin-top:15px; margin-left:10px;">
        <img src="/Admin/Module/eCom_Catalog/images/loading.gif" alt="Loading content" />
    </div>
</body>
</html>

<script type="text/javascript">
    document.location = '<%=redirectTo %>';
</script>
