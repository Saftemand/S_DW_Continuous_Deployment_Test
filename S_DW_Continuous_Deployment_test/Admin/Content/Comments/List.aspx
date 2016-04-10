<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.List5" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	<dw:ControlResources runat="server">
	</dw:ControlResources>
	<script type="text/javascript">
		var ItemID = '<%=ItemID %>';
		var Type = '<%=Type %>';
		var LangID = '<%=LangID %>';
	</script>
	<script src="Comments.js" type="text/javascript"></script>
	<style type="text/css">
	#CommentList_body tr
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
     <dw:List ID="CommentList" runat="server" Title="Kommentarer" PageSize="20">
	    <Columns>
		    <dw:ListColumn ID="ListColumn1" runat="server" Name="" Width="25">
		    </dw:ListColumn>
			<dw:ListColumn ID="ListColumn2" runat="server" Name="Dato" Width="110">
		    </dw:ListColumn>
		     <dw:ListColumn ID="ListColumn3" runat="server" Name="Navn" Width="0">
		    </dw:ListColumn>
            <dw:ListColumn ID="ListColumn7" runat="server" Name="Active" Width="50">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn6" runat="server" Name="Rating" Width="50">
		    </dw:ListColumn>
		    <dw:ListColumn ID="ListColumn4" runat="server" Name="Besked" Width="0">
		    </dw:ListColumn>
			<dw:ListColumn ID="ListColumn5" runat="server" Name="" Width="25">
		    </dw:ListColumn>
		</Columns>
	</dw:List>
	<span class="rightCorner">
	<dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" ShowStart="false">
		<dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="AddDocument" Text="Tilføj" OnClientClick="add();">
		</dw:ToolbarButton>
	</dw:Toolbar>
	</span>
    </form>
</body>
</html>
