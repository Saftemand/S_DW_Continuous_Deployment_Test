<%@ Page CodeBehind="ShowLoginInformation.aspx.vb" validateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.ShowLoginInformation" EnableEventValidation="false" %>
<%@ Import namespace="Dynamicweb.Admin" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.DirectoryServices" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title>Show Login Information </title>
		
		<LINK href="Stylesheet.css" type="text/css" rel="STYLESHEET">
			<script language="javascript">
function selectlanguage() {
	location = 'ShowLoginInformation.aspx?setLanguage=' + document.getElementById("languageid").options(document.getElementById("languageid").selectedIndex).value;
}
	
function Modulehide(strDiv) {
	document.getElementById("Open" + strDiv).style.display= 'none'
	document.getElementById("Close" + strDiv).style.display= 'block'
	document.getElementById("Open" + strDiv).outerHTML = document.getElementById("Open" + strDiv).outerHTML
	document.getElementById("Close" + strDiv).outerHTML = document.getElementById("Close" + strDiv).outerHTML
}

function Moduleunhide(strDiv) {
	document.getElementById("Open" + strDiv).style.display= 'block'
	document.getElementById("Close" + strDiv).style.display= 'none'
	document.getElementById("Open" + strDiv).outerHTML = document.getElementById("Open" + strDiv).outerHTML
	document.getElementById("Close" + strDiv).outerHTML = document.getElementById("Close" + strDiv).outerHTML
}


			</script>
	</HEAD>
	<body>
		<%
			
		    If Request.Form("SubmitButton") <> "" Then
		        Dim strDatabase As String
		        Dim strSQLStatement As String
			
		        strDatabase = Request.Form("SelectDatabase")
		        strSQLStatement = Request.Form("txtSQLStatement")
		        
		        If Base.ChkString(strSQLStatement) <> "" Then
		            Base.w(strSQLStatement)
		        End If
			
		        Dim connDB As IDbConnection = Database.CreateConnection(strDatabase)
		        Dim cmdSelect As IDbCommand = connDB.CreateCommand
		        cmdSelect.CommandText = strSQLStatement
		        Try
		            Dim drSelect As IDataReader = cmdSelect.ExecuteReader()
					drSelect.Close()
		            drSelect.Dispose()
		        Catch ex As Exception
		            HttpContext.Current.Response.Write("The following exception occurred:<br><br>" & ex.ToString)
		        End Try
			
		        connDB.Close()
		        connDB.Dispose()

		    Else
		%>
		<table width="600">
			<tr> <!-- Solution Details Start -->
				<td>
					<%=Gui.GroupboxStart("Solution details")%>
					<TABLE BORDER="0" CELLPADDING="2" CELLSPACING="0" WIDTH="100%">
						<TR valign="top">
							<TD align="right" nowrap><strong>Content version:</strong></TD>
							<TD align="left"><asp:Label id="lblCurVer" runat="server" /> (Updates.xml)</TD>
						</TR>
						<TR valign="top">
							<TD align="right" nowrap><strong>Assembly versions:</strong></TD>
							<TD ALIGN="left">
								<%="<b>Dynamicweb.dll " & Base.DWAssemblyVersionInformation & "</b> <br><small>(File version: " & Base.DWAssemblyVersion & ")</small>"%>
								<br>
								<%="<b>Dynamicweb.Admin.dll " & DWAdminVersionInformation() & "</b> <br><small>(File version: " & DWAdminVersion & ")</small>"%>
								<br>
								<%="<b>Dynamicweb.Controls.dll " & Dynamicweb.Controls.AssemblyInformation.DWAssemblyVersionInformation() & "</b> <br><small>(File version: " & Dynamicweb.Controls.AssemblyInformation.DWAssemblyVersion & ")</small>"%>
							</TD>
						</TR>
						<TR valign="top">
							<TD align="right" nowrap><strong>Build date:</strong></TD>
							<TD ALIGN="left" height="17">
								<asp:Label id="Label1" runat="server"></asp:Label>
							</TD>
						</TR>
						<TR valign="top">
							<TD align="right" nowrap><strong>Language DB:</strong></TD>
							<TD align="left"><asp:Label id="lblLangDB" runat="server" /></TD>
						</TR>
						<TR valign="top">
							<TD align="right" nowrap><strong>Server:</strong></TD>
							<TD ALIGN="left">
								<asp:Label id="Label3" runat="server"></asp:Label>
							</TD>
						</TR>
						<tr valign="top">
							<td align="right" nowrap><strong>NEW Server:</strong></td>
							<td align="left">
								<%=Environment.MachineName%> (<a href="\\<%=Environment.MachineName%>\" target="_blank"><%=Environment.MachineName & "." & DomainName%></a>)
							</td>
						</tr>
						<TR valign="top">
							<TD align="right" nowrap><strong>Path:</strong></TD>
							<TD ALIGN="left">
								<asp:Label id="Label2" runat="server"></asp:Label>
							</TD>
						</TR>
						<tr valign="top">
							<td align="right" nowrap><strong>NEW Path:</strong></td>
							<td align="left">
								<%
								Dim myPath as String = "\\" & Environment.MachineName & "\" & Replace(Replace(Server.MapPath("\files"), "e:\", "", 1, -1, CompareMethod.Text), "d:\", "", 1, -1, CompareMethod.Text)
								%>
								<a href="<%=myPath%>" target="_blank"><%=myPath%></a>
							</td>
						</tr>
						<TR valign="top">
							<TD align="right" nowrap><strong>Database type:</strong></TD>
							<TD ALIGN="left">
								<asp:Label id="Label4" runat="server"></asp:Label>
							</TD>
						</TR>
					</TABLE>
					<%=Gui.GroupboxEnd()%>
				</td>
			</tr> <!-- Solution Details End -->
			<tr> <!-- Application vars Start -->
				<td>
					<DIV ID="CloseApplicationVars" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Application vars","ApplicationVars",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenApplicationVars" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Application vars","ApplicationVars",true)%>
							<tr>
								<td colspan="3">
									
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr> <!-- Application vars end -->
			<tr>
				<td>
					<DIV ID="CloseSessionvars" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Session vars","Sessionvars",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenSessionvars" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Session vars","Sessionvars",true)%>
							<tr>
								<td colspan="3">
									
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
			<tr>
				<td>
					<DIV ID="CloseSettings" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Settings","Settings",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenSettings" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Settings","Settings",true)%>
							<tr>
								<td colspan="3">
									<%= Debug.GetSettings()%>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
			<tr>
				<td>
					<DIV ID="CloseModules" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Modules","Modules",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenModules" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Modules","Modules",true)%>
							<tr>
								<td colspan="3">
									<%= Debug.getModules()%>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
			<!--

			<tr>
				<td>
					<DIV ID="CloseProcessInformation" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Process Information","ProcessInformation",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenProcessInformation" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Process Information","ProcessInformation",true)%>
							<tr>
								<td colspan="3">
									<%If Request.ServerVariables("SERVER_NAME") = "dwdotnet.jte.dk" Then%>
									<%'=Debug.getProcessInfo()%>
									<%Else%>
									<br>
									Only enabled on dwdotnet.jte.dk<br>
									<%End If%>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
			<tr>
				<td>
					<DIV ID="CloseShutdownReasons" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Shutdown reasons","ShutdownReasons",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenShutdownReasons" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Shutdown reasons","ShutdownReasons",true)%>
							<tr>
								<td colspan="3">
									<%If Request.ServerVariables("SERVER_NAME") = "dwdotnet.jte.dk" Then%>
									<%'=Debug.getProcessShutDownReasons()%>
									<%Else%>
									<br>
									Only enabled on dwdotnet.jte.dk<br>
									<%End If%>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
-->
			<% If Session("DW_Admin_UserType") = "0" Then %>
			<tr>
				<td>
					<DIV ID="CloseSQLfirehose" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("SQL firehose","SQLfirehose",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenSQLfirehose" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("SQL firehose","SQLfirehose",true)%>
							<tr>
								<td colspan="3">
									<FORM method="post" action="ShowloginInformation.aspx" name="frmSQL" id="frmSQL">
										<br>
										<SELECT Name="SelectDatabase" id="SelectDatabase">
											<%If Database.IsAccess() Then%>
												<%=GetMdbOptionList()%>
											<%Else 'Use old std values%> 
											<option value="Dynamic.mdb" selected>SQL server</option>
											<!--option value="DWShop.mdb">DWShop</option>
											<option value="DWMedia.mdb">DWMedia</option>
											<option value="Access.mdb">Access</option>
											<option value="Forum.mdb">Forum</option>
											<option value="Language.mdb">Language</option>
											<option value="ModuleGenerator.mdb">ModuleGenerator</option>
											<option value="Newsletter.mdb">Newsletter</option>
											<option value="NewsletterExtended.mdb">NewsletterExtended</option>
											<option value="Poll.mdb">Poll</option>
											<option value="Statistics.mdb">Statistics</option>
											<option value="Statisticsv2.mdb">Statisticsv2</option>
											<option value="Stylesheet.mdb">Stylesheet</option-->
											<%End If%>
										</SELECT>
										<br>
										<textarea rows="5" cols="50" value="" id="txtSQLStatement" name="txtSQLStatement">SELECT * FROM </textarea>
										<input type="submit" value="Run" id="SubmitButton" name="SubmitButton">
									</FORM>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr>
			<tr> <!-- System Utilities Start -->
				<td>
					<DIV ID="CloseSystemUtilities" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("System utilities","SystemUtilities",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenSystemUtilities" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("System utilities","SystemUtilities",true)%>
							<TR>
								<td colspan="3">
									<form action="" method="post" name="PageReg" runat="server" ID="Form1">
										<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="2" WIDTH="100%">
											<TR valign="top">
												<TD>Bug log</TD>
												<TD ALIGN="left">
													<input type="button" title="Show log" value="Each server" onclick="location='ShowLoginInformation.aspx?ShowBuglog=true';"
														ID="ShowBuglog" NAME="ShowBuglog"> <input type="button" title="Show log" value="All servers" onclick="location='ShowLoginInformation.aspx?ShowBuglogAllServers=true';"
														ID="ShowBuglog" NAME="ShowBuglog"> <input type="button" title="Show log" value="This website" onclick="location='ShowLoginInformation.aspx?ShowBuglogThisWebsite=true';"
														ID="ShowBuglog" NAME="ShowBuglog">
												</TD>
											</TR>
											<tr valign="top">
												<td align="right" nowrap="nowrap" style="height: 29px">Update referer searchwords in statistics:</td>
												<td align="left" style="height: 29px"><a href="ShowloginInformation.aspx?RunStatUpdate=True">Run update</a></td>
											</tr>
											<TR valign="top">
												<TD>Unlock locked paragraphs</TD>
												<TD ALIGN="left">
													<input type="button" title="Unlock locked paragraphs" value="Delete 'LockTable'" onclick="location='ShowLoginInformation.aspx?DeleteLock=true';"
														ID="UnlockLockedParagraph" NAME="UnlockLockedParagraph">
												</TD>
											</TR>
											<TR valign="top">
												<TD>Retrieve and register tags</TD>
												<TD ALIGN="left">
													<asp:Button id="btnRegTegs" DISABLED runat="server" title="Retrieve and register tags in code"
														Text="Register tags"></asp:Button>
												</TD>
											</TR>
											<TR valign="top">
												<TD>Edit tags</TD>
												<TD ALIGN="left">
													<asp:Button id="Button2" runat="server" title="Edit tags and related information" Text="Template Tag Editor"></asp:Button>
												</TD>
											</TR>
											<TR valign="top">
												<TD>Translation page registration</TD>
												<TD ALIGN="left">
													<asp:Button id="cmdPageRed" Text="Translation page registration" runat="server" Height="24"></asp:Button>
												</TD>
											</TR>
											<TR valign="top">
												<TD>Loop through and register all pages</TD>
												<TD ALIGN="left">
													<asp:Button id="cmdPageRegAll" DISABLED title="Loop through site and register all pages" Text="Register pages"
														runat="server"></asp:Button>
												</TD>
											</TR>
											<TR valign="top">
												<TD>Clean up version data</TD>
												<TD ALIGN="left">
													<input type="button" OnClick="Javacript:location = '/Admin/Module/Debug/VersionCleanUp.aspx';"
														title="Go Clean up version data" value="Version clean up">
												</TD>
											</TR>
											<TR valign="top">
												<TD>Website restart</TD>
												<TD ALIGN="left">
													<input type="button" id="btnRestartWebsites" name="btnRestartWebsites" OnClick="Javacript:if(confirm('Are you absolutely sure?!?!?')) { form.restartweb.value='YesRestart'; form.submit();}"
														value="Restart all websites" runat="server" Width="46" Height="24"> <input type="hidden" id="restartweb" name="restartweb">
												</TD>
											</TR>
											<TR valign="top">
												<TD>Change language</TD>
												<TD ALIGN="left">
													<%=GetLanguageDropDown()%>
												</TD>
											</TR>
											<TR valign="top">
												<TD>
													Newsletter Extended - Fix&nbsp;Recipients</TD>
												<TD ALIGN="left">
													<form action="" method="post" name="FixUsers" ID="FixUsers">
														<input type="button" id="Button1" name="btnFixNewsletterUsers" OnClick="Javacript:form.NewsletterExtendedFixUsers.value = 'Yes'; form.submit();"
															value="Fix Users" runat="server" Width="46" Height="24"> <input type="hidden" id="NewsletterExtendedFixUsers" name="NewsletterExtendedFixUsers"
															value="No">
													</form>
												</TD>
											</TR>
											<TR valign="top">
												<TD>
													ModuleTable - Fix duplicates</TD>
												<TD ALIGN="left">
													<input type="button" id="Button3" name="btnFixModuleDuplicates" OnClick="location = 'ShowLoginInformation.aspx?CleanUpModuleTable=True';" value="Fix Duplicates">
												</TD>
											</TR>
											<TR>
												<TD>
													<asp:HyperLink id="HyperLink1" runat="server" NavigateUrl="/Admin/Module/Language/TerminologyTestPage.aspx"
														Target="_blank">Translation test page</asp:HyperLink></TD>
												<TD align="left"></TD>
											</TR>
										</TABLE>
									</form>
								</td>
							</TR>
						</TABLE>
					</DIV>
				</td>
			</tr> <!-- System Utilities End --><tr> <!-- DW Tools Start -->
				<td>
					<DIV ID="CloseDWTools" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("DW Tools","DWTools",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenDWTools" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("DW Tools","DWTools",true)%>
							<TR>
								<td colspan="3">
									<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="2" WIDTH="100%">
										<TR>
											<TD><asp:HyperLink id="Hyperlink2" runat="server" NavigateUrl="/Admin/DWTools/DWRegEditXML.aspx" Target="_self">Global Settings - RegEdit</asp:HyperLink></TD>
											<TD align="left"></TD>
										</TR>
									</TABLE>
								</td>
							</TR>
						</TABLE>
					</DIV>
				</td>
			</tr> <!-- DW Tools End -->
			
			<tr> <!-- Actionlog -->
				<td>
					<DIV ID="CloseActionlog" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Actionlog","Actionlog",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenActionlog" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Logs","Logs",true)%>
							<tr>
								<td colspan="3">
									<a href="Module/ActionLog/ActionLog.aspx">Actionlog</a>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<a href="/Files/CartLog.log">Cartlog</a>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<a href="/Files/CartSavev2.aspx.log">Cart Savelog</a>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr> <!-- Actionlog end -->
			<tr> <!-- Updatescript -->
				<td>
					<DIV ID="CloseUpdatescript" STYLE="DISPLAY:block">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Updatescript","Updatescript",false)%>
						</TABLE>
					</DIV>
					<DIV ID="OpenUpdatescript" style="DISPLAY:none">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
							<%=Gui.FoldoutSectionHeader("Updatescript","Updatescript",true)%>
							<tr>
								<td colspan="3">
									<a href="/Files/updatelog.html">Updatelog</a>
								</td>
							</tr>
							
							<tr>
								<td colspan="3">
									<table cellpadding="0" cellspacing="0" border="0">
										<form>
											<%=GetUpdateScriptsAndVersionNumbers()%>
											<tr>
												<td>
												</td>
												<td>
													<input name="RunUpdate" type="hidden" value="True">
													<input type="submit" value="Rerun updates" >
												</td>
											</tr>
										</FORM>
									</table>
								</td>
							</tr>
						</TABLE>
					</DIV>
				</td>
			</tr> <!-- Updatescript end --></table>
		<%
		End If
	End If

%>
	</body>
</HTML>
