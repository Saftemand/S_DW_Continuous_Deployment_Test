<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomOrder_PopupContent.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomOrder_PopupContent" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css">
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    
    	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    
    <style type="text/css">
		BODY.margin {MARGIN: 0px }
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
	</style>
</head>
<body>
    <form id="form1" runat="server">
        <div height="100%" id="Body" runat="server" style="height: 100%; width: 100%; overflow: auto;
            overflow-x: hidden;">
        </div>
        <dw:TranslateLabel ID="NoTemplate" Text="could not load template." runat="server" />
    </form>
</body>
</html>
