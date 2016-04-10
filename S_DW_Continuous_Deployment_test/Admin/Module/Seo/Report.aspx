<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Report.aspx.vb" Inherits="Dynamicweb.Admin.Report"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<script language="JavaScript" src="Chart/JSClass/FusionCharts.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="TabHeader1" runat="server" title="Referers" returnwhat="All" headers="Top 10"></dw:tabheader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
					<br>
						<table border="0" cellpadding="0" width="598">
							<tr>
								<td>
								
								<div id="chartdiv" align="center"></div>
								

								<script type="text/javascript">
								
								//var chart = new FusionCharts("Chart/Charts/MSLine.swf", "ChartId", "590", "400", "0", "0");
								//var chart = new FusionCharts("Chart/Charts/Bar2D.swf", "ChartId", "590", "400", "0", "0");
								//chart.setDataURL(escape("ReportXml.aspx?ID=<%=Base.Request("ID")%>&Report=<%=Base.Request("Report")%>&src=js&compress=false&uni="+(new Date()).getTime()));
								//alert("ReportXml.xml?uni="+(new Date()).getTime());
								//chart.setDataURL("ReportXml.xml?uni="+(new Date()).getTime());
								<%=getHtml()%>
								chart.render("chartdiv");
								
								function showXML(){
									if(document.getElementById('xml').style.display == ''){
										document.getElementById('xml').style.display = 'none';
									}
									else{
										document.getElementById('xml').style.display = '';
										document.frames.xml.location = 'ReportXml.aspx?ID=<%=Base.Request("ID")%>&Report=<%=Base.Request("Report")%>&src=iframe'
									}
								}
								</script>
								<iframe src="" width="590" height="400" id="xml" name="xml" style="display:none;"></iframe>
								<a href="javascript:showXML();"><dw:TranslateLabel ID="lbShowXML" Text="Show xml" runat="server" /></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>
