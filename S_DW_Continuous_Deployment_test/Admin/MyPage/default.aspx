<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="Dynamicweb.Admin._default1" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Content.Workflow" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<script language="VB" runat="Server">
	Dim StartTimeOne As Single
    Dim StatLink As String
    Dim AreaName As String
    Dim tmpDay As String
    Dim Statv2SettingsArea As String
    Dim i As Byte
    Dim strSQLTakenTask As String
    Dim blTaskExists As Boolean
    Dim PriorityImage As String
    Dim strAccessSql As String
    Dim Home As String
    Dim tmpAreaIDs As Object
    Dim sql As String
    Dim Manual_InfoBox_URLLocation As String
    Dim tmpDate As String
    Dim GroupBoxWidth As String
    Dim strWhere As String
    Dim WT_temp As String
    Dim MyPagesSQL As String

    Const ManualURLLocation As String = "http://manual2002.dynamicweb.dk/"
	Const Manual_InfoPage_URLLocation As String = "http://manual2002.dynamicweb.dk/?id=614"
    Const ParagraphStart As String = "<!--Paragraphs start-->"
    Const ParagraphEnd As String = "<!--Paragraphs end-->"

    Dim LanguagePrefix As String

    ' Check for new updates and update cache-file.
    Dim CacheStreamInfoBox As Object
    Dim CacheStreamInfoPage As Object
    Dim ModuleCount As Byte

    Dim dicUsersEmail As New HashTable
	Dim dicAccssUser As New HashTable

    ' Page module
    Dim PageSQL As String
    Dim MyTextStyle As String
    Dim PageCount As Byte

    
    'Dim cVTabs As New VerticalTab
	
	Sub WT(ByVal strText As String)
		WT_temp = WT_temp & "<!--" & strText & ": (" & Microsoft.VisualBasic.DateAndTime.Timer - StartTimeOne & ")-->" & vbCrLf
    End Sub
    
</script>

<%
StartTimeOne = Microsoft.VisualBasic.DateAndTime.Timer
	'Dim DynamicConn As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
	'Dim DynamicSelectCmd As IDbCommand = DynamicConn.CreateCommand

WT_temp = vbCrLf
WT(("Start"))
%>
<%	
	LanguagePrefix = "614"
	If Dynamicweb.Base.ChkString(Session("DW_Language")) = "1" Then	'Danish
		LanguagePrefix = "111"
	ElseIf Dynamicweb.Base.ChkString(Session("DW_Language")) = "9" Or Environment.MachineName.ToLower = "hn-w-8" Then	'Swedish
		LanguagePrefix = "914"
	End If


If Base.GetGs("/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation").ToString <> "" Then
	Manual_InfoBox_URLLocation = Base.GetGs("/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation").ToString
	Else
		If Dynamicweb.Base.ChkString(Session("DW_Language")) = "1" Then	'Danish
			Manual_InfoBox_URLLocation = "http://mypage.dynamicweb.dk/"
		Else
			Manual_InfoBox_URLLocation = "http://mypage.dynamicweb-cms.com/"
		End If
		
End IF


WT(("After translate init"))
CacheStreamInfoBox = ""
CacheStreamInfoPage = ""

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>    
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Cache-control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta name="Cache-control" content="no-cache" />
	<meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT" />
	<title>
		<%=Translate.JsTranslate("Min side")%>
	</title>
	<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css" />
	<style type="text/css">
			.MyPageSection {
				border: 1px solid #E6E6E6;
				padding: 4px;
			}
			.MyPageSectionHeader {
				border: 1px solid #E6E6E6;
				padding-left: 5px;
				background-color: #E6E6E6;
				height: 25px;
			}			.MyPageSectionHeader A {
				font-weight: bold;
				font-size: 12px;
			}
			.InfoBox A {
				color: #003366;
				text-decoration: none;
			}
			.InfoBox A:hover {
				color: #003366;
				text-decoration: underline;
			}
			.h1 {
				font-family: Verdana;
				font-size: 14px;
				font-weight: bold;
			}
		</style>
	<style type="text/css">
			body {
				background: <%=Gui.NewUIbgColor()%>;
			}
		
			.barBG {
				height:18px;
				width:240px;
				font-family:verdana;
				font-size:10px;
				background-color:#d1d1d1;
			}
			
			.bar {
				height:100%;
				filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F');
			}
			<%If Gui.NewUI Then %>
	b.title
	{
		background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
		height:25px;
		line-height:25px;
		vertical-align:middle;
		color: #15428b;
		font-size:14px;
		font-weight:bolder;
		font-family: Arial, Microsoft JhengHei;
		display:block;
		padding-left:5px;
		/*border-top :1px solid #6593CF;
		border-left :1px solid #6593CF;*/
		border-right :1px solid #6593CF;
	}
	<%End if%>
		</style>

    <dw:ControlResources runat="server" />
	<script type="text/javascript">
		var varPrevTaskID
		varPrevTaskID = '0'
		
		getPopUpWindow = function() {
		    var dialog = null;		    	    
		    try {
		        dialog = eval('<%=pwDialog.ClientInstanceName%>');
		    } catch (ex) { }	                
		    return dialog;
		}
    </script>    
</head>
<body topmargin="3" leftmargin="5" oncontextmenu="<%=IIf(Session("DW_Admin_UserID") = 1, "", "return true;")%>">
	<div id="vtab1">
		<dw:Infobar runat="server" Type="Information" Message="Old users are non-functional. Upgrade to new user management now!" id="UserManagementConversionInformation" Action="javascript:document.location='/Admin/Module/UserManagement/ConversionWizard.aspx'" />
		
		<table border="0" cellpadding="3" width="100%" id="Table1">
			<tr>
				<td valign="top" width="450">
					<table class="MyPageSection" cellspacing="0" cellpadding="0" height="320" width="450" id="Table2">
						<tr>
							<td class="MyPageSectionHeader">
								<a href="#">
									<img src="../images/MyPageBullit.gif" border="0" align="absmiddle" />&nbsp;<%=Translate.Translate("Seneste nyt")%>
								</a>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table cellpadding="0" cellspacing="0" class="InfoBox" id="Table3">
									<iframe src="" frameborder="0" width="440" height="330" id="news"></iframe>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td valign="top">
					<table class="MyPageSection" cellspacing="0" cellpadding="0" height="160" width="450" id="Table4">
						<tr>
							<td class="MyPageSectionHeader"><a href="/Admin/Content/Management/Pages/ModulesList_cpl.aspx">
								<img src="../images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Moduler")%></a> </td>
						</tr>
						<tr>
                            <td valign="top">
                                <table border="0" cellspacing="0" cellpadding="0" width="100%" id="Table5">
                                    <asp:Repeater ID="myModulesRepeater" runat="server" enableviewstate="false">
                        			    <ItemTemplate>
									        <tr height="20">
										        <td><a href="<%# Eval("ModuleScript") %>">
											        <img border="0" align="absmiddle" src="<%# Eval("ImagePath") %>">&nbsp;<font color="DimGray"><b><%# Eval("ModuleName")%></b></font></a></td>
									        </tr>
                                            </ItemTemplate>
		                            </asp:Repeater>
								</table>
							</td>
						</tr>
					</table>
					<br />
					<%
                    	If Base.HasAccess("Corporate", "") Then%>
					<table class="MyPageSection" cellspacing="0" cellpadding="0" height="160" width="450"
						id="Table7">
						<tr>
							<td class="MyPageSectionHeader">
								<a href="#">
									<img src="../images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Mine sider")%></a>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table border="0" cellpadding="0" cellspacing="0" width="100%" id="Table8">
									<%		
										Dim sql As String = " SELECT TOP 5 DateDiff(" & Database.SqlDatePart("day") & ",PageUpdatedDate," & Database.SqlDate(Dates.DWNow()) & ") AS PageDaysOverdue, PageID, PageMenuText, PageUpdatedDate " & _
					   " FROM		Page " & _
					   " WHERE		((PageManager = " & Session("DW_Admin_UserID") & ") AND ((PageManageFrequence) <= DateDiff(" & Database.SqlDatePart("day") & ",PageUpdatedDate," & Database.SqlDate(Dates.DWNow()) & "))) " & _
					   " AND PageManageFrequence > 0" & _
					   " ORDER BY	DateDiff(" & Database.SqlDatePart("day") & ",PageUpdatedDate," & Database.SqlDate(Dates.DWNow()) & ") DESC , Page.PageMenuText"
										'base.we(dynamicSelectCmd.CommandText.tostring)
										'Dim MyPagesReader As IDataReader = dynamicSelectCmd.ExecuteReader()
										Dim MyPagesReader As IDataReader = Database.CreateDataReader(sql)

                                        Dim opPageID As Integer = MyPagesReader.getordinal("PageID")
                                        Dim opPageMenuText As Integer = MyPagesReader.getordinal("PageMenuText")
                                        Dim opPageDaysOverdue As Integer = MyPagesReader.getordinal("PageDaysOverdue")

		                                WT(("After SQL"))

                               			i = 0
                                		Do While MyPagesReader.Read And i < 5
                                			With Response
                                				.Write("<TR>")
                                				.Write("<TD width=""20"" height=""22"" align=""center""><IMG src=""../images/icons/Page_wfa.gif""></TD>")
                                				.Write("<TD height=""22""><A href=""../Page_Edit.aspx?ID=" & MyPagesReader(opPageID) & """>" & MyPagesReader(opPageMenuText) & " <font color=""Gray"">(" & Translate.Translate("%% dage", "%%", CStr(MyPagesReader(opPageDaysOverdue))) & ")</font></A></TD>")
                                				.Write("</TR>")
                                				i = i + 1
                                			End With
                                		Loop 

                                		If i = 0 Then
			                                With Response
				                                .Write("<TR>")
				                                .Write("<TD>" & Translate.Translate("Ingen sider skal behandles") & "</TD>")
				                                .Write("</TR>")
			                                End With
                                        Else
                                	        Response.Write("<TR><TD colspan=""2"" bgcolor=""#c4c4c4""><IMG height=""1"" src=""../images/nothing.gif""></TD></TR>")
                                		End If

										MyPagesReader.Close()
										MyPagesReader.Dispose()

		                                WT(("After corporate Ed"))
									%>
								</table>
							</td>
						</tr>
					</table>
					<%	End If%>
				</td>
			</tr>
			<tr>
				<td valign="top" width="320">
					<%If Base.GetGs("/Globalsettings/Settings/MyPage/HideStat").ToString <> "True" Then%>
					<%InitializeStat()%>
					<table class="MyPageSection" cellspacing="0" cellpadding="0" height="160" width="450" id="Table6">
						<tr>
							<td class="MyPageSectionHeader">
								<%	
										StatLink = "../statistics/default.aspx"
										If Base.HasVersion("18.4.1.0") Then
											StatLink = "../module/statisticsv3/main.aspx"
	'TODO: AccessGetValue
	'                                		tmpAreaIDs = Base.AccessGetValue("AreaCategories")
											If tmpAreaIDs <> "" Then
												tmpAreaIDs = Split(tmpAreaIDs, ",")
												Statv2SettingsArea = tmpAreaIDs(0)
												AreaName = " (" & Base.GetAreaName(Statv2SettingsArea) & ")"
											End If
										End If
								%>
								<a href="<%=StatLink%>">
									<img src="../images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Besøgende sidste %% dage", "%%", "5")%><%=AreaName%></a> </td>
							<td align="right" class="MyPageSectionHeader"><a href="/Admin/MyPage/Default.aspx?stat=<%=StatParam()%>">
								<%=StatText()%></a> </td>
						</tr>
						<tr>
							<td valign="top" colspan="2">
								<%If ShowStatToUser() Then%>
								<iframe src="" frameborder="0" width="310" height="123" scrolling="no" id="mypagestats"></iframe>
								<%Else%>
								<%End If%>
							</td>
						</tr>
					</table>
					<%End If%>
				</td>
				<td valign="top">
					
				</td>
			</tr>
			<tr>
				<td colspan="2" valign="top">
					<%
                    	If Base.HasAccess("TaskManager", "") Then%>
					<table class="MyPageSection" cellspacing="0" cellpadding="0" height="160" width="450" id="Table9">
						<tr>
							<td class="MyPageSectionHeader"><a href="/Admin/Module/TaskManager/TaskManager_Administration.aspx">
								<img src="../images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Mine opgaver")%></a> </td>
						</tr>
						<tr>
							<td valign="top">
								<form method="post" action="/Admin/Module/TaskManager/TaskManager_Status_close.aspx?Page=default" id="TaskManagerArchiveForm" name="TaskManagerArchiveForm">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" id="Table10">
										<div id="TaskText0" style="display: None; "">
										</div>
										<%		

                                		strSQLTakenTask = " SELECT * FROM TaskManager WHERE TaskStatus <> 3 AND TaskTakerID = " & Session("DW_Admin_UserID") & " ORDER BY TaskDeadLine, TaskPriority"
											'Dim cn As IDbConnection = Database.CreateConnection("Dynamic.mdb")
											'Dim cmd As IDbCommand = cn.CreateCommand()
                                		strAccessSql = " SELECT AccessUserID, AccessUserName, AccessUserEmail FROM AccessUser " & " WHERE (AccessUserType IN (4,5,3)) " & " ORDER BY AccessUserID ASC"
																				                                		
											'Dim cnAccess As IDbConnection = Database.CreateConnection("Access.mdb")
											'Dim cmdAccess As IDbCommand = cnAccess.CreateCommand()
											'cmdAccess.CommandText = strAccessSql
											'Dim drAccess As IDataReader = cmdAccess.ExecuteReader()
											Dim drAccess As IDataReader = Database.CreateDataReader(strAccessSql, "Access.mdb")

										Do While drAccess.Read()
											dicAccssUser.Add(CStr(drAccess(0)), CStr(drAccess(1) & ""))
											dicUsersEmail.Add(CStr(drAccess(0)), CStr(drAccess(2) & ""))
										Loop 

										drAccess.Close()
										drAccess.Dispose()
											'cmdAccess.Dispose()
											'cnAccess.Close()
											'cnAccess.Dispose()
                                              
											'      cmd.CommandText = strSQLTakenTask
											'Dim drTakenTask as IDataReader = cmd.ExecuteReader()
											Dim drTakenTask As IDataReader = Database.CreateDataReader(strSQLTakenTask)
											Dim blnDrTakenTaskHasRows As Boolean = False
                                		
                                		If drTakenTask.Read() Then
                                			blnDrTakenTaskHasRows = True
                                		End If
											drTakenTask.Close()
											drTakenTask.Dispose()
                                		
                                		
                                                           		
                                		If Not blnDrTakenTaskHasRows Then
										%>
										<tr>
											<td colspan="4">
												<%=Translate.Translate("Ingen opgaver")%>
											</td>
										</tr>
										<%			
                                		Else
										%>
										<tr>
											<td width="50%"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<%=Translate.Translate("Emne")%>
											</strong></td>
											<td><strong>
												<%=Translate.Translate("Deadline")%>
											</strong></td>
											<td><strong>
												<%=Translate.Translate("Stiller")%>
											</strong></td>
											<td><strong>
												<%=Translate.Translate("Afslut")%>
											</strong></td>
										</tr>
										<%			
										End If
										
										'cmd.CommandText = strSQLTakenTask
										'drTakenTask = cmd.ExecuteReader()
										drTakenTask = Database.CreateDataReader(strSQLTakenTask)
                                		Do While drTakenTask.Read()
                                			If drTakenTask("TaskPriority") = 1 Then
                                				PriorityImage = "PriorityHigh.gif"
                                			ElseIf drTakenTask("TaskPriority") = 3 Then 
                                				PriorityImage = "PriorityLow.gif"
                                			Else
				                                PriorityImage = "Nothing.gif"
                                			End If
			                                blTaskExists = True
										%>
	</div>
	<tr>
		<td colspan="4" bgcolor="#C4C4C4"></td>
	</tr>
	<tr>
		<td style="cursor: hand;" onclick="document.all('TaskText' + varPrevTaskID).style.display='None';varPrevTaskID = '<%=drTakenTask("TaskID")%>';document.all('TaskText<%=drTakenTask("TaskID")%>').style.display='block';" onclick="Javascript: location='/Admin/Module/TaskManager/TaskManager_Edit.aspx?Page=default&TaskID=<%=drTakenTask("TaskID")%>'" width="50%">
			<img src="../images/<%=PriorityImage%>" align="absbottom" width="16px"><%=drTakenTask("TaskHeader")%>
		</td>
		<td>
			<%=drTakenTask("TaskDeadline")%></td>
		<td><a title="mailto" style="text-decoration: underline;" href="mailto:<%=dicUsersEmail.Item(CStr(drTakenTask("TaskGiverID") & ""))%>">
			<%=dicAccssUser.Item(CStr(drTakenTask("TaskGiverID") & ""))%></a></td>
		<td title="<%=Translate.JSTranslate("Opdater")%>" align="center" width="5%">
			<input type="checkbox" value="<%=drTakenTask("TaskID")%>" id="cbCompleteTask" name="cbCompleteTask">
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<div border="0" id="TaskText<%=drTakenTask("TaskID")%>" style="display: none;">
				<em>
					<%=CStr(drTakenTask("TaskDescription"))%></em></div>
		</td>
	</tr>
	<%			
                                		Loop 
	drTakenTask.Close()
	drTakenTask.Dispose()
	'cmd.Dispose()
	'cn.Dispose()
                                		
	%>
	<tr>
		<td colspan="4">&nbsp; </td>
	</tr>
	<%		If blTaskExists = True Then%>
	<tr>
		<td width="150"></td>
		<td colspan="3" align="right">
			<%=Gui.Button("Ok", "Submit()", 90)%></td>
	</tr>
	<%		End If
                                		
		                                WT(("After TaskManager"))
	%>

	<%	
        	If Base.HasVersion("18.3.1.0") Then
	%>
	<table align="right" id="Table11">
		<tr align="right">
			<%=Gui.HelpButton("MyPage", "gui.content.mypage")%>
			<td width="2"></td>
		</tr>
	</table>
	<%		
	        End If
        End If
	%>
	</DIV>
	        
	</div>

<dw:PopUpWindow ID="pwDialog" ContentUrl="" AutoReload="true" ShowClose="true" ShowCancelButton="false" ShowOkButton="false" runat="server" 
    Width="360" Height="80" TranslateTitle="true" UseTabularLayout="true" HidePadding="true" SnapToScreen="true" IsModal="true" />                  
</body>
</html>

<script type="text/javascript">
<!--
	// See ASP code above
	function displayIframes(){
		if(document.getElementById("news")) {
		document.getElementById("news").src = "<%=Manual_InfoBox_URLLocation%>";
		}
		
		if(document.getElementById("mypagestats")) {
		document.getElementById("mypagestats").src = "MyPageStat.aspx";
	}
	}
	
    setTimeout("displayIframes()",  100);		

-->
</script>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
