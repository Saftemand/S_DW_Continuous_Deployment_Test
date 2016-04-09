<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DBIntegration_import.aspx.vb" Inherits="Dynamicweb.Admin.DBIntegration.DBIntegration_import" %>
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<script language="Javascript">
				function CallProgress()
				{
					document.getElementById("Progress_ShowStatus").innerHTML = "<iframe name='IFrameName' src='ShowProgress.aspx' frameborder='no' scrolling='no' height=0 width=0>";
				}
				function SetTotal(num)
				{
					document.getElementById("total").innerHTML = num;
				}
				function SetImported(num)
				{
					document.getElementById("imported").innerHTML = num;
				}
				function SetErrors(num)
				{
					document.getElementById("errors").innerHTML = num;
				}
				function SetStatus(stat)
				{
					document.getElementById("status").innerHTML = stat;
				}
				function SetElapsed(val)
				{
					document.getElementById("elapsed").innerHTML = val;
				}
				function ProgressBar(num)
				{
					num = Math.round(num);
					var perc = 300/100 * num;
					document.getElementById("finished").style.pixelWidth = perc;
					document.getElementById("percent").innerHTML = num + "%";
				}	
				function SetComplete(status)
				{
					document.getElementById("progressArea").style.display = "none";										
					document.getElementById("buttons1").style.display = "";
					//if((status == 3) || (status == 4)|| (status == 9))
					//{
					//	document.getElementById("accept").disabled= true;
					//	document.getElementById("reject").disabled= true;
					//	document.getElementById("_leave").disabled= true;
					//}
				}
				function ViewLog(mode)
				{
					if(mode == true)
					{
						document.getElementById("viewlog").style.display = "";	
					}
					if(mode == false)
					{
						document.getElementById("viewlog").style.display = "none";	
					}
				}	
								
</script>
<%=Gui.MakeHeaders(Translate.Translate("Import system indstillinger"), Translate.translate("Import"), "all")%>
<table class="TabTable" id="Table1" cellPadding="0" width="100%" border="0">
	<form id="Form1" method="post" runat="server">
		<TBODY>
			<TR>
				<TD vAlign="top" align="left">
					<fieldset style="MARGIN: 5px; WIDTH: 100%"><legend class="gbTitle"><%=Translate.translate("Import status")%> 
							&nbsp;</legend><br>
						<table id="Table2" cellSpacing="2" cellPadding="2" width="100%" border="0">
							<tr>
								<td width="100"><%=translate.translate("Navn")%>&nbsp;</td>
								<td><asp:label id="jobname" runat="server"></asp:label></td>
							</tr>
							<tr>
								<td width="100"><%=translate.translate("Status")%>&nbsp;</td>
								<td><asp:label id="status" runat="server"></asp:label></td>
							</tr>
							<tr>
								<td><%=translate.translate("Total")%>&nbsp;</td>
								<td><asp:label id="total" runat="server"></asp:label></td>
							</tr>
							<tr>
								<td><%=translate.translate("Importerede")%>&nbsp;</td>
								<td><asp:label id="imported" runat="server"></asp:label></td>
							</tr>
							<tr>
								<td><%=translate.translate("Fejl")%>&nbsp;</td>
								<td><asp:label id="errors" runat="server"></asp:label></td>
							</tr>
							<tr>
								<td><%=translate.translate("Tidsforbrug")%>&nbsp;</td>
								<td><asp:label id="elapsed" runat="server" Text="00:00"></asp:label></td>
							</tr>
						</table>
						<br>
					</fieldset>
				</TD>
			</TR>
			<TR id="progressArea">
				<TD vAlign="top" align="left">
					<fieldset style="MARGIN: 5px; WIDTH: 100%"><legend class="gbTitle"><%=translate.translate("Status")%>&nbsp;</legend><br>
						<table id="Table3" cellSpacing="2" cellPadding="2" width="100%" border="0">
							<tr>
								<td width="75"></td>
								<td style="WIDTH: 300px"><span id="filename"></span></td>
							</tr>
							<tr vAlign="middle">
								<td></td>
								<td style="WIDTH: 300px" vAlign="top" width="300">
									<fieldset style="WIDTH: 300px">
										<table id="progress" height="15" width="300">
											<tr align="left">
												<td><span id="finished" style="HEIGHT: 15px; BACKGROUND-COLOR: #dcdcdc"></span></td>
											</tr>
										</table>
									</fieldset>
								</td>
								<td vAlign="middle"><span id="percent" style="HEIGHT: 15px"></span></td>
								<td align="right"><asp:button id="AbortBtn" runat="server" Text="Cancel" CssClass="buttonSubmit" OnCommand="OnAbort" ></asp:button></td> 
                            </tr>
						</table>
					</fieldset>
				</TD>
			</TR>
			<tr id="viewlog" style="DISPLAY: none" vAlign="top" runat="server">
				<td vAlign="top">
					<fieldset style="MARGIN: 5px; WIDTH: 100%"><legend class="gbTitle"><%=translate.translate("Import log")%> &nbsp;</legend>
						<table id="Table4" width="100%" border="0">
							<tr align="left">
								<td><asp:label id="showLog" runat="server"></asp:label>
									<DIV></DIV>
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
			<TR id="buttons1" style="DISPLAY: none" vAlign="top" align="right">
				<td vAlign="top">&nbsp;&nbsp;<asp:button id="log" runat="server" Text="View log" CssClass="buttonSubmit" OnCommand="OnShowLog"></asp:button>&nbsp;&nbsp;<asp:button id="canc" runat="server" Text="Cancel" CssClass="buttonSubmit" OnCommand="OnCancel"></asp:button></td>
			</TR>
		</TBODY>
	</form>
</table>
<DIV id="Progress_ShowStatus"></DIV>
<%Doit()%>
<%=CallProc%>
<%Translate.GetEditOnlineScript()%>
