<%@ Register TagPrefix="dwc" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls2" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Test.aspx.vb" Inherits="Dynamicweb.Admin.Test" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Test</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../../Stylesheet.css" type="text/css" rel="STYLESHEET">
	</head>
	<body ms_positioning="GridLayout">
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<dwc:button id="Button3" runat="server" btnonclick="alert('asdas')" btnname="Knap 3" width="144px"
				height="40px" style="Z-INDEX: 101; LEFT: 280px; POSITION: absolute; TOP: 40px"></dwc:button>
			<dwc:button id="Button2" runat="server" btnname="Annuller" style="Z-INDEX: 102; LEFT: 200px; POSITION: absolute; TOP: 112px"></dwc:button>
			<dwc:button id="Button1" runat="server" btnonclick="alert()" btnname="ok" style="Z-INDEX: 103; LEFT: 296px; POSITION: absolute; TOP: 80px"></dwc:button>
			<dw:radiobutton id="RadioButton1" style="Z-INDEX: 104; LEFT: 240px; POSITION: absolute; TOP: 232px"
				runat="server"></dw:radiobutton>
			<dw:button id="Button4" style="Z-INDEX: 105; LEFT: 296px; POSITION: absolute; TOP: 192px" runat="server"></dw:button>
		</form>
	</body>
</html>
