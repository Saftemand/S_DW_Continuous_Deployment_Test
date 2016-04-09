<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.Dashboard._Default2" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<dw:ControlResources ID="ControlResources1" runat="server" />
	
	<script type="text/javascript">
        function setTreeHeight(){
            document.getElementById("tree1").style.height = document.getElementById("tree1").offsetHeight + "px";
        }
	</script>
	<style type="text/css">
	.LayoutTable .TreeContainer
{
	width:249px;
	max-width:249px;
	height:100%;
}
	.nav
{
	width: 247px;
}
.nav .tree
{
	width: 246px;
}
.nav .title
{
	width:246px;
}
.nav .subtitle
{
	width:246px;
}
	</style>
</head>
<body>
    <dw:ModuleAdmin ID="ModuleAdmin1" runat="server" ContentFrameSrc="/Admin/Content/Dashboard/Start.aspx">
        <dw:Tree ID="Tree1" runat="server" SubTitle="Dynamicweb" Title="Dashboard" ShowRoot="false" UseCookies="false">
            <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Root" ParentID="-1" ImagePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/home.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/home.png">
            </dw:TreeNode>
        </dw:Tree>
    </dw:ModuleAdmin>

    <% Translate.GetEditOnlineScript()%>
    <script type="text/javascript">
        setTreeHeight();
    </script>
</body>
</html>
