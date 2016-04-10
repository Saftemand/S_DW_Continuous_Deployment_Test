<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFReportUserAll.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFReportUserAll" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.Admin" %>

<%If Base.HasVersion("18.10.1.0") AndAlso isFrame = 0 Then%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<html>
	<head>
		<title><%=Translate.JSTranslate("Detaljeret besøgsrapport")%></title>
		<meta name=vs_defaultClientScript content="JavaScript">
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css">
	</head>

	<FRAMESET border="0" frameborder="0" framespacing="0" cols="175,*" topmargin="0" leftmargin="0">
	<FRAME name="DW_IPStat_Nav" src="../ReportUserAll/IFReportUserAll.aspx?isframe=1&Statv2SessionID=<%=reqSessionID%>" frameborder="0" marginheight="0" marginwidth="0" border="0" scrolling="no" noresize>
		<FRAMESET border="0" frameborder="0" framespacing="0" rows="24,*" topmargin="0" leftmargin="0">
		<FRAME name="DW_IPStat_Top" src="../ReportUserAll/IFReportUserAll.aspx?isframe=2" frameborder="0" marginheight="0" marginwidth="0" border="0" scrolling="no" noresize>
		<FRAME name="DW_IPStat_Main" src="../ReportUserAll/IFReportUserAll.aspx?isframe=3&Statv2SessionID=<%=reqSessionID%>" frameborder="0" marginheight="0" marginwidth="0" border="0" scrolling="auto">
		</FRAMESET>   
	</FRAMESET>   
	</html>
	<%Response.End%>		
<%End If%>
	
<%If Base.HasVersion("18.10.1.0") AndAlso (isFrame > 0 AND isFrame < 3) Then%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<html>
	<head>
		<title><%=Translate.JSTranslate("Detaljeret besГёgsrapport")%></title>
		<LINK rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css">
	</head>

	<body style="background-color:#ECE9D8;margin:0px;" scroll=no>

	<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" ID="MenuTable" style="display:">
		<tr bgColor="#FFFFFF">
			<td width="0" bgColor="#ECE9D8" rowspan="2"></td>
				<%
				Dim boxWidth as String
				Dim textTrans as String
				If isFrame = 1 Then
					boxWidth = "170+10"
					textTrans = Translate.Translate("Kalender")
				Else
					boxWidth = "100%"
					textTrans = Translate.Translate("Detaljer")
				End If
				%>

			<td valign="top" width="<%=boxWidth%>">
				<table cellspacing="0" cellpadding="0" border="0" width="<%=boxWidth%>" height="100%">
					<tr height="23" bgColor="#ECE9D8" ID="TreeStart">
						<td>&nbsp;<strong><%=textTrans%></strong></td>
					</tr>
					<tr bgColor="#ACA899" height="1">
						<td></td>
					</tr>
					<%If isFrame = 1 Then%>
					<tr>
						<td>
						<div style="width:<%=boxWidth%>;height:100%;overflow:auto;margin: 0x 0px 0px 10px;" ID="IPDatesCell">
						<asp:Repeater ID="repeaterForLeftPart" Runat="server">
							<ItemTemplate>
							<b>
								<span id="lblYear" runat="server">
									<%#DataBinder.Eval(Container.DataItem,"Year")%>
								</span>
							</b>
							
							<img src="/Admin/Images/Icons/Page_ext.gif" align="absmiddle">
								<a id="lnk" runat="server" target="DW_IPStat_Main" 
									onclick=<%#"BoldIpDate('"& DataBinder.Eval(Container.DataItem,"IDStr") &"');"%>
									href='<%#"IFReportUserAll.aspx?isframe=3&Statv2SessionID="& DataBinder.Eval(Container.DataItem,"IDStr")%>'>
									<span id='<%#"STATIP_"& DataBinder.Eval(Container.DataItem,"IDStr")%>'>
										<%#DataBinder.Eval(Container.DataItem,"Title")%>
									</span>
								</a>
								<br/>
							</ItemTemplate>
						</asp:Repeater>
						</div>
						</td>
					</tr>
					<%End If%>
				</table>
			</td>                
			<%If isFrame = 1 Then%>
			<td width="5" bgColor="#ECE9D8" rowspan="2"></td>
			<%End If%>
		</tr>
	</table>
<script>
	var prevID
	function BoldIpDate(idStr) {
		if (prevID) 
			{
				if (document.getElementById('STATIP_'+ prevID)) 
				{
					document.getElementById('STATIP_'+ prevID).style.fontWeight = "";
				}
			}

		if (idStr) 
		{
			if (document.getElementById('STATIP_'+ idStr)) 
			{
				document.getElementById('STATIP_'+ idStr).style.fontWeight = "bold";
			}
		}
		
		prevID = idStr;
	}
	
</script>
	</body>
	</html>	
	<%Response.End%>	
<%End If%>


<%If isFrame = 3 Then%>

<title>-</title>
	<%If Base.HasVersion("18.10.1.0") = false Then%>
		<!-- #INCLUDE FILE="IFReportCommon.aspx" -->
	<%Else%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<html>
	<head>
		<title></title>
		<LINK rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css">
	</head>	
	<%End If%>
	
	<table width=100%>
<tr>
<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
</tr>
<tr>
	<td width=80%><strong style="color:#003366;"><%=Translate.Translate("Detaljeret besøgsrapport")%></strong></td>
<td align=right style="width:75px;"></td>
</tr>
<tr>
<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
</tr>
<tr>
<td colspan=2>&nbsp;</td>
</tr>
</table>

<%Response.Flush()%>
	<table width=100% border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="20">&nbsp;</td>
<td>
	<asp:Label id="statSessionReport" runat="server"></asp:Label>
</td>
</tr>
</table>

<%If ValueGwIP <> Nothing AND ValueGwIP <> "" Then%>
	<%Response.Flush()%>
		<table width=100% border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td width="20">&nbsp;</td>
	<td>
		<%
		'getIspInfo(ValueGwIP)		
		%>
		<table width="100%">
		<tr><td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td></tr>
		<tr><td width="50%"><%=Translate.Translate("ISP/Company")%></td><td><div id="statISPDiv"><font color="#990000"><%=Translate.Translate("Henter data...")%></font></div></td></tr>
		<tr><td width="50%"><%=Translate.Translate("Land")%></td><td><asp:Label id="statCountry" runat="server"></asp:Label></td></tr>
		<tr><td width="50%"><%=Translate.Translate("Hostname")%></td><td><div id="statHostnameDiv"><font color="#990000"><%=Translate.Translate("Henter data...")%></font></div></td></tr>
		</table>
	</td>
	</tr>
	</table>
<%End If%>

<%If (ValueSessionPath <> Nothing AND ValueSessionPath <> "") AND (ValueSessionTime <> Nothing AND ValueSessionTime <> "") AND (ValueSessionTimeEnd <> Nothing AND ValueSessionTimeEnd <> "") Then%>
	<%Response.Flush()%>
		<table width=100% border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td width="20">&nbsp;</td>
	<td colspan="2">
		<table width="100%">
		<asp:Label id="statSites" runat="server"></asp:Label>
		</table>
	</td>
	</tr>
	</table>
<%End If%>

<%If ValueSessionID <> Nothing AND ValueSessionID <> "" Then%>
	<%Response.Flush()%>
		<table width=100% border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td width="20">&nbsp;</td>
	<td colspan="2">
		<table width="100%">
		<asp:Label id="statNews" runat="server"></asp:Label>
		</table>
	</td>
	</tr>
	</table>
<%End If%>

<%If ValueSessionID <> Nothing AND ValueSessionID <> "" Then%>
	<%Response.Flush()%>
		<table width=100% border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td width="20">&nbsp;</td>
	<td colspan="2">
		<table width="100%">
		<asp:Label id="statFiles" runat="server"></asp:Label>
		</table>
	</td>
	</tr>
	</table>
<%End If%>

</body>
</html>
	
	<%If Base.HasVersion("18.10.1.0") Then%>
		<iframe style="display:none;" height="1" width="1" ID="FetchIPData" src="about:blank"></iframe>
<%
		FetchIPData(ValueGwIP, reqSessionID)
	Else
getIspInfo(ValueGwIP)
	End If%>
	

<%End If%>

<%
Translate.GetEditOnlineScript()
%>
