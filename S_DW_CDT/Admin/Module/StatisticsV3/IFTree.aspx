<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IFTree.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.IFTree" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<%Dim ID As Byte%>
		<style type="text/css">
			.RNO{ /*Report Normal*/
			cursor:default;
			margin:2px;
		}

		.RMO{ /*Report Mouse Over*/
			cursor:pointer;
			margin:2px;
			text-decoration:underline;
		}

		.RAC{ /*Report Active*/
			cursor:default;
			margin:2px;
			font-weight:bold;
		}
		</style>
		<script type="text/javascript" src="IFTree.js?"></script>
	</HEAD>
	<body onmouseover="document.body.style.cursor = 'default';" style="MARGIN: 0px; BACKGROUND-COLOR: #FFFFFF">
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr>
				<td>
					<div style="width:100%;margin:3px;" ID="ContentCell">
						<%
							ID = 10
						%>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Resume")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
						<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=57,58');"><img src="/Admin/Images/Nothing.gif" width="3" height="1"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Standard")%></div>
						</div>
						<%If Base.HasVersion("18.9.1.0") Then%>
						<%
							ID = 9
						%>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Unikke IP´er")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=51');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Dag")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=52');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Uge")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=53');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Måned")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=54');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("År")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=55');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Ugedag")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=56');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Time")%></div>
						</div>
						<%End If%>
						<%
							ID = 2
						%>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Besøgende")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=2');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Dag")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=3');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Uge")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=4');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Måned")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=5');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("År")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=6');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Ugedag")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=7');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Time")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=8');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Unikke besøgende")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=9');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Tid pr. besøg")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=10');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Nye besøgende")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=11');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sidste %% besøgende", "%%", "#")%></div>
							<%	If Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=12');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sprog")%></div>
							<%	End If%>
						</div>
						<%
							ID = 3
						%>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sidevisninger")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=13');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Mest besøgte")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=14');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Dag")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=15');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Uge")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=16');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Måned")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=17');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("År")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=18');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Indgangssider")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=19');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Udgangssider")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=20');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Pr. besøg")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=21');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sider med 1 besøg")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=22');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Tid pr side")%></div>

							<%If Base.HasVersion("18.9.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=23');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sitemap")%></div>
							<%End If%>
						</div>
						<%
						    If Base.HasVersion("18.8.1.0") Then%>
						<%	
							ID = 4
	                    %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Filer")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=24');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Mest downloadede")%></div>
						</div>
						<%End If%>
						<%
							ID = 5
                        %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Referers")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=25');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("URL")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=26');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Domæne")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=27');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Indgangssider")%></div>
						</div>
						<%
							ID = 6
                        %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("System")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=28');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Browser")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=29');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Operativ system")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=30');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Browser/OS")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=31');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Browser/Platform")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=32');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("OS/Browser")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=33');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Opløsning")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=34');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Opløsning, ordnet")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=35');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Farver")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=36');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Forbindelse")%></div>
						</div>
						<%	
							ID = 7
	                    %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Søgemaskiner")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=37');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Indeksering")%></div>
							<%	If Base.HasVersion("18.5.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=38');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Indekseringer pr. uge")%></div>
							<%	End If%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=39');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sider")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=40');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Henvisninger")%></div>
							<%	If Base.HasVersion("18.5.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=41');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("%% pr. uge","%%",Translate.Translate("Henvisninger"))%></div>
							<%	End If%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=42');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Søgeord")%></div>
							<%	If Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=43');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Søgeord pr. søgemaskine")%></div>
							<%	End If%>
						</div>
						<%
							ID = 8
                        %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Moduler")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<%If Base.HasAccess("Search", "") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, '/Admin/Statisticsv2/Statisticsv2_Report_Modules_Searches.aspx');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Søg")%></div>
							<%End If%>
							<%If Base.HasAccess("Searchv1", "") Then%>
							<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'reports/IFReport.aspx?ids=44');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Søg v1")%></div>
							<%End If%>
							<%	If Base.HasAccess("Extranet") OrElse Base.HasAccess("ExtranetExtended") OrElse Base.HasAccess("UserManagementFrontend") Then%>
							<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'reports/IFReport.aspx?ids=45');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle" /><%=Translate.Translate("Extranet")%></div>
							<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'reports/IFReport.aspx?ids=46');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle" /><%=Translate.Translate("Extranet, pr. uge")%></div>
							<%End If%>
							<%	If Base.HasAccess("ExtranetExtended") OrElse Base.HasAccess("UserManagementFrontend") Then%>
							<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'reports/IFReport.aspx?ids=47');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle" /><%=Translate.Translate("Extranet, sidste %%", "%%", "#")%></div>
							<%End If%>
							<%If (Base.HasAccess("News", "") or Base.HasAccess("NewsV2", "")) And Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=48');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle" /><%=Translate.Translate("Nyheder")%></div>
							<%End If%>
							<%If Base.HasAccess("Poll", "") And Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=49');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle" /><%=Translate.Translate("Afstemning")%></div>
							<%End If%>
							<%If Base.HasAccess("Form", "") And Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=50');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Formularer")%></div>
							<%End If%>
							<%If Base.HasAccess("NewsLetterv3", "") And Base.HasVersion("18.8.1.0") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=59');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Nyhedsbreve")%></div>
						    <div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=60');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=String.Format("{0} {1}", Translate.Translate("Newsletter"), Translate.Translate("modtager"))%></div>
							<%End If%>
						</div>
						<%
							ID = 11
                        %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Stylesheets")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=61');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Default")%></div>
						</div>
						<%
							ID = 12
                        %>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Templates")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=62');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Side")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=63');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Afsnit")%></div>
							<%If Base.HasAccess("News", "") Then%>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=64');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Nyheder")%></div>
							<%End If%>
						</div>
						<%If Base.HasVersion("18.16.0.0") Then%>
						<%
							ID = 13
						%>
						<div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" align="absmiddle" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1" align="absmiddle"><img src="/Admin/Images/Folder_closed2.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Ikke_fundet")%></div>
						<div id=g<%=ID%>r style="margin-left:32px;display:none">
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=65');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Sider")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=66');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Documents")%></div>
							<div class="RNO" onMouseover="mo(this)" onMouseout="no(this);" onClick="ac(this, 'reports/IFReport.aspx?ids=67');"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" border="0" align="absmiddle"><%=Translate.Translate("Others")%></div>
						</div>
						<%End If%>
					</div>
				</td>
			</tr>
		</table>
	</body>
</HTML>
