<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Page.aspx.vb" Inherits="Dynamicweb.Admin.page" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<dw:ControlResources ID="ControlResources1" runat="server">
	</dw:ControlResources>
    <title></title>
    <script type="text/javascript" src="/Admin/Module/Seo/Chart/JSClass/FusionCharts.js"></script>
    <script type="text/javascript">
    	function changeChartType(chart) {
    		location = "Page.aspx?Chart=" + chart + "&Report=<%=Base.Request("Report")%>&PageID=<%=Base.Request("PageID")%>";
    	}
    </script>
</head>
<body>
	<dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false">
		<dw:ToolbarButton ID="ToolbarButton1" OnClientClick="changeChartType('Line');" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Line">
		</dw:ToolbarButton>
		<dw:ToolbarButton ID="ToolbarButton3" OnClientClick="changeChartType('Pie3D');" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Pie">
		</dw:ToolbarButton>
		<dw:ToolbarButton ID="ToolbarButton2" OnClientClick="changeChartType('Column3D');" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" Text="3D Column">
		</dw:ToolbarButton>
		<dw:ToolbarButton ID="ToolbarButton4" OnClientClick="changeChartType('Column2D');" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" Text="2D Column">
		</dw:ToolbarButton>
	</dw:Toolbar>
<h2 class="subtitle"><%=Dynamicweb.Admin.ParagraphList1.GetPath(Base.ChkInteger(Base.Request("PageID")), True)%></h2>
   <div id="chartdiv" align="center"></div>
   <script type="text/javascript">
   <%=getHtml()%>
   
	chart.render("chartdiv");
	
	function showXML(){
		if(document.getElementById('xml').style.display == ''){
			document.getElementById('xml').style.display = 'none';
		}
		else{
			document.getElementById('xml').style.display = '';
			document.frames.xml.location = 'PageXml.aspx?Chart=<%=Base.Request("Chart")%>PageID=<%=Base.Request("PageID")%>&Report=<%=Base.Request("Report")%>&src=iframe'
		}
	}
	</script>
	<iframe src="" width="500" height="400" id="xml" name="xml" style="display:none;"></iframe>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
