<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TagTree.aspx.vb" Inherits="Dynamicweb.Admin.TagTree" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>TagTree</title>
		<script language="javascript">
	
			function HideUnHide(strName, intID) {
				if(document.getElementById(strName + intID).style.display=='none') {
					document.getElementById(strName + intID).style.display='';
					document.getElementById(strName + 'Pic' + intID).setAttribute('src','/admin/images/Expand_off.gif');
					
				} else {
					document.getElementById(strName + intID).style.display='none';
					document.getElementById(strName + 'Pic' + intID).setAttribute('src','/admin/images/Expand.gif');
				}
			}
			
		</script>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<body TOPMARGIN="0" LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0">
		<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
			<tr>
				<td>
					<table height="100%" width="100%">
						<tr>
							<td bgcolor="#ffffff" valign="top"><asp:Literal id="litOutput" runat="server" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</HTML>
