<%@ Page CodeBehind="Menu.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Menu3" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.OleDb" %>

<script language="VB" runat="Server">
Dim Statv2SettingsExtranetusers As Boolean
Dim Statv2SettingsOnePv As Boolean
Dim sql As String
Dim Statv2SettingsCrawlers As Boolean
Dim Statv2SettingsArea As Object
Dim tmpAreaIDs As Object
Dim strAreaList As String
Dim MinDate As String
Dim Statv2SettingsFillbar As Boolean
Dim Statv2SettingsIPfiltering As Boolean
Dim theID1 As Integer
Dim theID2 As String
Dim ID As Integer
Dim bolShowAll As Boolean
Dim TS As Date
Dim Statv2SettingsAdmins As Boolean
</script>

<%

Server.ScriptTimeOut = 90
'**************************************************************************************************
'	Current version:	1.0
'	Created:			26-08-2003
'	Last modfied:		26-08-2003
'
'	Purpose: Show treeview of reports in statistics module
'
'	Revision history:
'		1.0 - 26-08-2003 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************
%>
<html>
    <head>
        <title></title>
        <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
            <style type="text/css">
.RNO{ /*Report Normal*/
	cursor:hand;
	margin:2px;
}

.RMO{ /*Report Mouse Over*/
	cursor:hand;
	margin:2px;
	text-decoration:underline;
}

.RAC{ /*Report Active*/
	cursor:hand;
	margin:2px;
	font-weight:bold;
}
</style>
            <script>
activeObj = "";
function mo(obj){
	if(activeObj != obj){
		obj.className = "RMO";
	}
}

function no(obj){
	if(activeObj != obj){
		obj.className = "RNO";
	}
}

function ac(obj, reportScript){
	activeObj.className = "RNO";
	obj.className = "RAC";
	activeObj = obj
	document.getElementById('report').action = reportScript;
	document.getElementById('report').submit();
}

function do_export(reportScript){
	document.getElementById('report').action = reportScript;
	document.getElementById('report').submit();
}

function res(){
	activeObj.className = "RNO";
	activeObj = "";
}

function SetLetter(strID){
	document.getElementById('report').ID.value = strID;
}

function SetFromDate(intDay, intMonth, intYear){
	document.getElementById('report').Statv2From_day.value = intDay;
	document.getElementById('report').Statv2From_month.value = intMonth;
	document.getElementById('report').Statv2From_year.value = intYear;
}

function toggle(obj){
	if(document.getElementById(obj.id + 'r').style.display == ""){
		document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand2.gif"
		document.getElementById(obj.id + 'r').style.display = "none";
	}
	else{
		document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand_off2.gif"
		document.getElementById(obj.id + 'r').style.display = "";
	}
}
            </script>
    </head>
    <body onMouseover="this.style.cursor = 'default'" style="background-color:#ECE9D8;margin:0px;"
        scroll="no">
        <table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" ID="MenuTable"
            style="display:">
            <tr bgColor="#FFFFFF">
                <td width="5" bgColor="#ECE9D8" rowspan="2"></td>
                <td valign="top" width="190">
                    <table cellspacing="0" cellpadding="0" border="0" width="225" height="100%">
                        <tr height="23" bgColor="#ECE9D8" ID="TreeStart">
                            <td>&nbsp;<strong><%=Translate.Translate("Rapporter")%></strong></td>
                        </tr>
                        <tr bgColor="#ACA899" height="1">
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <div style="width:100%;height:100%;overflow:auto;margin:3px;" ID="ContentCell">
                                    <div class="RNO" onClick="ac(this, 'Statisticsv2_Report_Resume_Last.aspx');"><img src="/Admin/Images/Nothing.gif" width="13" height="1"><img src="/Admin/Images/Icons/Statv2_Report.gif" alt="" hspace="1" border="0" align="absmiddle"><%=Translate.Translate("Resume")%></div>
                                    <% ID = 9%>
                                    <div class=RNO onClick="toggle(this);" id=g<%=ID%>><img src="/Admin/Images/Expand2.gif" alt="" border="0" id=g<%=ID%>i><img src="/Admin/FileManager/Folder_closed.gif" alt="" hspace="1" border="0"
                                            align="absmiddle"><%=Translate.Translate("Lister")%></div>
                                    <div id=g<%=ID%>r style="margin-left:32px;display:none">
                                    <%=GetCategories("letters")%>
									</div>
                                <% ID = 10%>
                                  <!--  <div class=RNO onClick="toggle(this);" onMouseover="mo(this)" onMouseout="no(this);" id=g<%=ID%>><img src="/Admin/Images/Expand.gif" width="9" height="13" alt="" border="0" id=g<%=ID%>i><img src="/Admin/Images/Nothing.gif" width="3" height="1"><img src="/Admin/FileManager/Folder_closed.gif" width="19" height="17" alt="" border="0"
                                            align="absmiddle"><%=Translate.Translate("Sammenlign")%></div>
                                    <div id=g<%=ID%>r style="margin-left:32px;display:none">
                                    <%'=GetCategories2("compare")%>
                                    -->
									</div>
                               </td>
                        </tr>
                    </table>
                </td>
                <td width="5" bgColor="#ECE9D8" rowspan="2"></td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
					<tr>
						<td height=50>
							<table cellspacing="0" cellpadding="4" border="0" width="100%">
							<tr height="50" bgColor="#ECE9D8">
								<td width="5" bgColor="#ECE9D8"></td>
								<td>
									<table cellspacing="0" cellpadding="0" border="0" height="100%">

										<form name="report" id="report" action="" method="get" target="stat">
											<input type=hidden name="ID" value=""> <input type=hidden name="Tab" value="Tab2"><input type=hidden name="StatType" value=""> 
											<tr>
												<td align="center" width="15"></td>
												<td>
													<table cellspacing="0">
	                                                   
														<%
	TS = DateAdd(Microsoft.VisualBasic.DateInterval.Month, -1, CDate(Dates.DWNow))
	MinDate = Year(TS) & "-" & Month(TS) & "-01"

	Dim objDate As New Dates
	%>
														<tr>
															<td></td>
															<td><%=Translate.Translate("Fra")%></td>
															<td colspan="2"><%=objDate.DateSelect(MinDate, False, False, False, "Statv2From")%></td>
															<td></td>
															<td></td>
														</tr>
														<tr>
															<td></td>
															<td><%=Translate.Translate("Til")%></td>
															<td colspan="2"><%=objDate.DateSelect(Dates.DWNow, False, False, False, "Statv2To")%></td>
															<td></td>
															<td></td>
														</tr>
														<%objDate = Nothing%>
													</table>
												</td>
												<!--td align=center width=75><a href="UpdateIPs.aspx" target="stat"><img src="/Admin/images/Icons/Statistics_export.gif" alt="" width="32" height="32" border="0"><br><nobr>IP'er</nobr></a></td-->
											</tr>
										</form>
									</table>
								</td>
								<td align="center" width="48" >
									<%If Base.HasVersion("18.2.1.0") Then%>
									<a href="#" onClick="<%=Gui.Help("statv2","modules.statistics")%>;">
										<img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" border="0"><br>
										<%=Translate.Translate("Hjælp")%>
									</a>
									<%End If%>
								</td>
							</tr>
							<tr bgColor="#ECE9D8" height="4">
								<td colspan="6" background="/Admin/images/SpacerBG.gif"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
							<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
								<tr>
									<td width="5" bgColor="#F9F8F3"></td>
									<td>
										<iframe width="100%" height="100%" name="stat" src="about:blank" LEFTMARGIN="10" TOPMARGIN="0"
											MARGINHEIGHT="0" MARGINWIDTH="0" BORDER="0" FRAMEBORDER="0"></iframe>
									</td>
								</tr>
							</table>
						</td>
					</tr>
                </table>
                </td>
            </tr>
        </table>
        <script>
toggle(document.getElementById('g101'));
        </script>
    </body>
</html>
<%
	Translate.GetEditOnlineScript()
%>