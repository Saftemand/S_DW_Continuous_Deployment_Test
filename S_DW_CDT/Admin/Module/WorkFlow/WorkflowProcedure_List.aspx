<%@ Page CodeBehind="WorkflowProcedure_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.WorkflowProcedure_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
		<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
        <SCRIPT LANGUAGE="javascript">
		<!--
        var WorkFlowID =<%= WorkflowID%>;
		function helpLink()
        {
          return <%= Gui.Help("workflow", "modules.workflow.general.list")%>;
    	}
        function DeleteWorkflowProcedure(WorkflowProcedureID, WorkflowProcedureName) {
			if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("deltager"))%>\n(' + WorkflowProcedureName +')')==true) {
				location.href = "WorkflowProcedure_Del.aspx?workflow=<%=WorkflowID%>&procedureid=" + WorkflowProcedureID;
			}
		}
		//-->
		</SCRIPT>
	</HEAD>
	<BODY>
	<%= Gui.MakeHeaders(Translate.Translate("Procedure - %%", "%%", WorkflowProcedureTitle), Translate.Translate("Procedure"), "all") %>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr style="background-color:White">
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top" style="width:100%;">
                                        <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                               <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location.href='Workflow_List.aspx';" Image="Home" Text="Start" Divide="After">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tNewParticipant" runat="server" OnClientClick="window.location.href = 'WorkflowProcedure_Edit.aspx?workflow='+WorkFlowID;" Image="AddGear" Text="New participant">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tEditSurvey" runat="server" OnClientClick="window.location.href = 'Workflow_Edit.aspx?workflowid='+WorkFlowID;" Image="EditDocument" Text="Edit workflow">
                                                </dw:ToolbarButton>
                                                <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick=" helpLink();">
                                                </dw:ToolbarButton>
                                            </dw:Toolbar>
                              <TABLE border="0" cellpadding="0" width="598">
									<tr>
										<td colspan="5">
											<%=Gui.GroupBoxStart(Translate.Translate("Deltagere"))%>
											<TABLE border="0" width="100%" cellspacing="2" cellpadding="0">
												<%= GetList()%>
												<TR>
													<TD valign="top" rowspan="2" width="22" align="center"><IMG src="../../images/Workflow_Final.gif"></TD>
													<TD width="180"><B><%=Translate.Translate("System")%></B></TD>
													<TD width="10"><IMG src="../../images/check.gif"></TD>
													<TD width="80"><%=Translate.Translate("Krævet")%></TD>
													<TD rowspan="2" colspan="2">&nbsp;</TD>
												</TR>
												<TR>
													<TD><%=Translate.Translate("Publicering",1)%></TD>
													<TD width="10">&nbsp;</TD>
													<TD><%=Translate.Translate("Notificer")%></TD>
												</TR>
											</table>
											<%=Gui.GroupBoxEnd%>
										</td>
									</tr>
								</TABLE>
							</td>
						</tr>
						<tr>
							<td align="right" valign="bottom">
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<%
	Gui.SelectTab()
	%>
	<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>