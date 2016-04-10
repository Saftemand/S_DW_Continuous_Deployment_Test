<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="InsertGlobalElement.aspx.vb" Inherits="Dynamicweb.Admin.InsertGlobalElement" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <meta http-equiv="Pragma" content="no-cache" />
	<meta name="Cache-control" content="no-cache" />
	<meta http-equiv="Cache-control" content="no-cache" />
	<meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT" />
    <dw:ControlResources runat="server">
	</dw:ControlResources>
	<style type="text/css">
	#insertGlobalElementList_body tr
	{
		cursor:pointer;
	}
	.rightCorner
	{
		position:fixed;
		top:-1px;
		right:0px;
	}
	</style>
	<!--[if gt IE 7]>
	<style type="text/css">
	.rightCorner
	{
		position:fixed;
		top:0px;
		right:0px;
	}
	</style>
	<![endif]--> 

</head>
<body>
<form id="form1" runat="server">
    <dw:List ID="insertGlobalElementList" runat="server" Title="Include global paragraph" PageSize="20" ShowCollapseButton="False" AllowMultiSelect="True">
		<Filters>
            <dw:ListAutomatedSearchFilter ID="sFilter" runat="server" />
        </Filters>
	    <Columns>
		    <dw:ListColumn ID="ListColumn1" runat="server" Name="" Width="25">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn2" runat="server" Name="Afsnitsnavn" Width="0" EnableSorting="true">
		    </dw:ListColumn>
		     <dw:ListColumn ID="ListColumn4" runat="server" Name="I brug" Width="0" EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn3" runat="server" Name="Fra" Width="0" EnableSorting="true">
		    </dw:ListColumn>
		</Columns>
	</dw:List>

	<span class="rightCorner">
	<dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" ShowStart="false">
		<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="ParagraphAdd" Text="Include Selected" OnClientClick="parent.insertMultiSelectGlobal(List);" EnableViewState="True">
		</dw:ToolbarButton>
        <dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="AddDocument" Text="Tilføj" OnClientClick="parent.insertNewGlobalElement();">
		</dw:ToolbarButton>
	</dw:Toolbar>
	</span>
</form>
</body>
</html>
