<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ColorGen.aspx.vb" Inherits="Dynamicweb.Admin.ColorGen" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	<style type="text/css">
	body
	{
		color:#333333;
		font-family:Arial;
		font-size:8px;
		overflow:hidden;
	}
	.color
	{
		float:left;
		margin:5px;
		margin-left:0px;
		height:40px;
		width:55px;
		cursor:pointer;
	}
	.color span 
	{
		position:relative;
		background: url("10-black.png") repeat scroll 0 0 transparent;
		display: block;
		height: 5px; 
	}
	.light 
	{
		color:#e1e1e1;
	}
	.color a.txt
	{
		padding-top:3px;
		text-align:center;
		height:35px;
		overflow:hidden;
		display:block;
	}
	.color a div
	{
		display:none;
	}
	.color a:hover div
	{
		display:block;
		cursor:default;
	}
	h2 
	{
		font-size:12px;
		clear:both;
		margin:0px;
	}
	</style>
	<script type="text/javascript">
		function sc(hex) {
			if (confirm("Set as base: " + hex)) {
				location = 'ColorGen.aspx?hex=' + hex.replace('#', '') + '&dt=' + new Date().getTime();
			}
			return false;
        }

        function setColor(hex, element, fontColor) {
        	//parent.RichSelect.setselected("", parentName);
            //RichColorSelect_selectitems
            //parent.document.getElementById('RichColorSelect_selectboxcontent').style.backgroundColor = hex;
        	var parentName = document.getElementById('parent').value;

        	//alert(parent.document.getElementById(parentName + '_selectboxcontent'));
        	//alert(hex);
        	parent.document.getElementById(parentName + '_selectboxcontent').innerHTML = '<div style="background-color:' + hex + ';" class="color' + fontColor + '">' + hex + '</div>';

        	//alert(parent.document.getElementById(parentName + '_selectitems'));
            parent.document.getElementById(parentName + '_selectitems').style.display = 'none';

            //alert(parent.document.getElementById(parentName));
            parent.document.getElementById(parentName).value = hex;

            //alert(parent.document.getElementById(parentName + '_selected'));
            parent.document.getElementById(parentName + '_selected').value = hex;
            //location = 'ColorGen.aspx?hex=' + hex.replace('#', '') + '&dt=' + new Date().getTime() + '&parent=' + parentName + '&colorgroups=' ;
            return false;
        }

	</script>
</head>
<body>
    <form id="form1" runat="server" enableviewstate="false">
    <input type="hidden" runat="server" name="parent" id="parent" />
	<a href="javascript:document.location.reload();">Recalc</a>
	<h2>Base and clean color</h2>
    <div runat="server" id="colors">
    
    </div>
	<p>&nbsp;</p>
	<br />
	<br />
	<br />
	<br />
    </form>
	
</body>
</html>
