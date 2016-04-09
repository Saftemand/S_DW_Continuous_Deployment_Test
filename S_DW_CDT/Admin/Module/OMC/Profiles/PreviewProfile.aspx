<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PreviewProfile.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Profiles.PreviewProfile" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Preview" /></title>
	<dw:ControlResources ID="ControlResources01" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" />
	<link rel="StyleSheet" href="../Experiments/Preview.css" type="text/css" />
	<script type="text/javascript" src="../Experiments/Preview.js">
	</script>
</head>
<body>
	<form action="">
	<input type="hidden" id="testurl" value="<%=OriginalPage %>" />
	</form>
    <div class="header">
		<h1 runat="server" id="prevHeading"></h1>
        <select id="profilesList" runat="server" onchange="previewProfileTest();" ></select>
    </div>
	<div style="position:fixed;top:43px;bottom:0px;right:0px;left:0px;">
		<iframe id="previewFrame" src="<%=OriginalPage %>" style="border:0;width:100%;height:100%;" >
	</iframe>
	</div>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>

