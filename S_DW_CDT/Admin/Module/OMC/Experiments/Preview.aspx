<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Preview.aspx.vb" Inherits="Dynamicweb.Admin.Preview" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><dw:TranslateLabel runat="server" Text="Preview" /></title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true"/>
	<link rel="StyleSheet" href="Preview.css" type="text/css" />
	<script type="text/javascript" src="Preview.js">
	</script>
</head>
<body>
	<form action="">
	<input type="hidden" id="testurl" value="<%=Dynamicweb.Input.Request("original") %>" />
	</form>
    <div class="header">
		<h1 runat="server" id="previewHeading"></h1>
		<a href="javascript:test('1');" class="active" id="link1"><%= Dynamicweb.Backend.Translate.Translate("Original")%></a>
		<a href="javascript:test('2');" class="" id="link2"><%= Dynamicweb.Backend.Translate.Translate("Variants")%></a>
    </div>
	<div style="position:fixed;top:43px;bottom:0px;right:0px;left:0px;">
		<iframe id="previewFrame" src="<%=Dynamicweb.Input.Request("original") %>&variation=1" style="border:0;width:100%;height:100%;">
	</iframe>
	</div>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
