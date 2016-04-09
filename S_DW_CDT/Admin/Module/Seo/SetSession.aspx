<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SetSession.aspx.vb" Inherits="Dynamicweb.Admin.SetSession" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Seo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <script language="javascript" type="text/javascript">
    window.parent.document.getElementById("Culture").innerHTML = "<%=GetCulture()%>"
	</script>
    </div>
    </form>
</body>
</html>
