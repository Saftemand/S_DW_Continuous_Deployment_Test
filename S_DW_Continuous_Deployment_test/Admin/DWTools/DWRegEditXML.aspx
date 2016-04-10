<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DWRegEditXML.aspx.vb" Inherits="Dynamicweb.Admin.DWRegEditXML" codePage="65001"%>


<script>
//Closes the menu (or rather hides it) to save space
function closeMenu()
{
	parent.RegEditMainFrame.cols='22,*';
	document.all.RegEditMenuTable.style.display='none';
	document.all.RegEditMenuOpen.style.display='';

	document.getElementById('NavigationClosed').style.display='';
}

//opens the menu (or rather unhides it)
function openMenu()
{
	parent.RegEditMainFrame.cols='200,*';
	document.all.RegEditMenuTable.style.display='';
	document.all.RegEditMenuOpen.style.display='none';
}
</script>
