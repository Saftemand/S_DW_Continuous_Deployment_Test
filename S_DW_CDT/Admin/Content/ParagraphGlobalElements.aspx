<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ParagraphGlobalElements.aspx.vb" Inherits="Dynamicweb.Admin.ParagraphGlobalElements" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
	<dw:ControlResources runat="server">
	</dw:ControlResources>
</head>
<body>
<form id="form1" runat="server">
	<dw:List ID="List1" runat="server" Title="Referencer" PageSize="20">
	    <Columns>
		    <dw:ListColumn runat="server" Name="" Width="25">
		    </dw:ListColumn>
		    <dw:ListColumn runat="server" Name="Area" Width="150">
		    </dw:ListColumn>
			<dw:ListColumn ID="ListColumn1" runat="server" Name="Sti" Width="0">
		    </dw:ListColumn>
		</Columns>
	</dw:List>
</form>
</body>
</html>
