<%@ Page Language="vb" AutoEventWireup="false" validateRequest="false" Codebehind="DIBS_FlexWin.aspx.vb" Inherits="Dynamicweb.Admin.Gateway.DIBS_FlexWin"%>
<%@ Import namespace="Dynamicweb" %>
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<html>
<head>
<title>Betaling</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<script type="text/javascript">
<!--
window.onload = function (evt) { document.forms[0].submit(); }
//-->
</script>
</head>
<body>
<form method="post" action="https://payment.architrade.com/paymentweb/start.action">
	<input type="hidden" name="merchant" value="<%=Request.QueryString("merchant") %>" />
	<input type="hidden" name="lang" value="<%=Request.QueryString("lang") %>" />
	<input type="hidden" name="amount" value="<%=Request.QueryString("amount") %>" />
	<input type="hidden" name="currency" value="<%=Request.QueryString("currency") %>" />
	<input type="hidden" name="orderid" value="<%=Request.QueryString("orderid") %>" />
	<input type="hidden" name="ordertext" value="<%=Request.QueryString("ordertext") %>" />

    <input type="hidden" name="accepturl" value="<%=Request.QueryString("accepturl") %>" />
	<input type="hidden" name="cancelurl" value="<%=Request.QueryString("cancelurl") %>" />
	<input type="hidden" name="callbackurl" value="<%=Request.QueryString("callbackurl") %>" />
	<input type="hidden" name="HTTP_COOKIE" value="<%=Request.QueryString("HTTP_COOKIE") %>" />

<%  If Base.Request("test") <> "" Then%>
	<input type="hidden" name="test" value="true" />
<%  End If%>

</form>
</body>
</html>