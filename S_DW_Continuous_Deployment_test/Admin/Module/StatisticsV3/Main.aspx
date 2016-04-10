<%@ Register TagPrefix="uc" TagName="menu" Src="UCMenu.ascx" %>
<%@ Register TagPrefix="uc" TagName="buttons" Src="UCButtons.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Main.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.Main" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title></title>
<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
	<% 	If Dynamicweb.Gui.NewUI Then%>
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	
	<%End If%>
	
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">

	<script type="text/javascript" src="Main.js?"></script>

</head>
<body onmouseover="document.body.style.cursor = 'default';" style="margin: 0px; background-color: <%=Dynamicweb.Gui.NewUIbgColor%>">
    <dw:PopUpWindow ID="pupLocation" runat="server" AutoReload="True" IsModal="True" AutoCenterProgress="True" ShowOkButton="False" TranslateTitle="False" ShowCancelButton="False" ShowClose="True" Height="500" HidePadding="True" iframeHeight="200" Width="900" UseTabularLayout="True"></dw:PopUpWindow>
    <form id="report" name="report">
		<input type="hidden" name="Crawlers" id="Crawlers" runat="server">
		<input type="hidden" name="Admins" id="Admins" runat="server">
		<input type="hidden" name="OnePv" id="OnePv" runat="server">
		<input type="hidden" name="Extranetusers" id="Extranetusers" runat="server">
		<input type="hidden" name="IPfiltering" id="IPfiltering" runat="server">
		<input type="hidden" name="Fillbar" id="Fillbar" runat="server">
		<input type="hidden" name="Qstr" id="Qstr" runat="server">
	</form>
	<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" id="MenuTable">
		<tr bgcolor="#ffffff">			
        <% 		If Not Dynamicweb.Gui.NewUI Then%>
            <td valign="top" style="width: 200px;border-right: 5px solid <%=Dynamicweb.Gui.NewUIbgColor%>" nowrap>			
		<%Else%>			
            <td valign="top" style="width: 200px;border-right: 1px solid <%=Dynamicweb.Gui.NewUIbordercolor%>" nowrap>			
		<%End If%>			
				<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
					
						<% 	If Dynamicweb.Gui.NewUI Then%>
						<tr height="48" id="TreeStart">
						<td>
						<h1 class="title"><%=Translate.Translate("Statistik")%></h1>
						<h2 class="subtitle" style="height: 20px;"><%=Translate.Translate("Rapporter")%></h2>
						</td>
						</tr>
						<%else %>
						<tr height="23" bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" id="Tr1">
						<td>
						&nbsp;<strong><%=Translate.Translate("Rapporter")%>
						</strong></td>
						</tr>
						<%End If%>
						
					
					<% 		If Not Dynamicweb.Gui.NewUI Then%>
					<tr bgcolor="<%=Dynamicweb.Gui.NewUIbordercolor%>" height="1">
						<td></td>
					</tr>
					<%End If%>
					<tr>
						<td>
							<iframe width="100%" height="100%" src="IFTree.aspx" frameborder="0" marginheight="0" marginwidth="0" name="_iftree" id="_iftree"></iframe>
						</td>
					</tr>
				</table>
			</td>			
			<td valign="top" nowrap>
				<table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
				<% 	If Dynamicweb.Gui.NewUI Then%>
				<tr height="27"><td>
				<uc:buttons ID="_buttons2" runat="server"></uc:buttons>
			</td></tr>
				<%else %>
					<tr bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" height="4">
						<td background="Admin/Images/nothing.gif" colspan="4"></td>
					</tr>
					<tr bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" height="50">
						<td>
							<uc:buttons ID="_buttons" runat="server"></uc:buttons>
						</td>
					</tr>
					<tr bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" height="4">
						<td background="/Admin/images/SpacerBG.gif"></td>
					</tr>
				<%End If%>
					
					<tr height="50" bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>">
						<td>
							<uc:menu ID="_menu" runat="server"></uc:menu>
						</td>
					</tr>
					<% 	If Not Dynamicweb.Gui.NewUI Then%>
					<tr bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" height="4">
						<td background="/Admin/images/SpacerBG.gif"></td>
					</tr>
					<%End If%>
					<tr>
						<td valign="top" align="left">
							<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
								<tr>
								<% 	If Not Dynamicweb.Gui.NewUI Then%>
									<td height="100%" style="width: 20px" nowrap bgcolor="#f9f8f3">&nbsp;</td>
									<%End If %>
									<td width="100%">
										<iframe width="100%" height="100%" src="" frameborder="0" marginheight="0" marginwidth="0" name="_ifreport" id="_ifreport"></iframe>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<script language="javascript">
	    changeReportSrc();

	    function showLocation(ip)
	    {
            <%=Me.pupLocation.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/Leads/Details/Location.aspx?knowip=true&IP=' + ip);   
            <%=Me.pupLocation.ClientInstanceName%>.show();
	    }
    </script>

</body>
</html>
