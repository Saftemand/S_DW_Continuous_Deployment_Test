<%@ Page CodeBehind="Workflow_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Workflow_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
		
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
        <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
        <SCRIPT language="JavaScript">
			// WORKFLOW
            function helpLink(){
            <%= Gui.Help("workflow", "modules.workflow.general.list")%>;
    		}
            function Workflow() {
				location.href = "Workflow_List.aspx";
			}

			function EditWorkFlow(WorkflowID) {
				location.href = "WorkflowProcedure_List.aspx?workflow=" + WorkflowID;
			}

			function DeleteWorkFlow(WorkflowID, WorkflowTitle) {
				if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("procedure"))%>\n(' + WorkflowTitle + ')')==true) {
					location.href = "Workflow_Del.aspx?workflow=" + WorkflowID;
				}
			}
			// WORKFLOW

		</SCRIPT>
	</HEAD>
	<BODY>
	<%= Gui.MakeHeaders(Translate.Translate("Godkendelse",9), Translate.Translate("Procedurer"), "all") %>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable" >
		<tr style="background-color:White">
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top" style="width:100%;">
                                      <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                                <dw:ToolbarButton ID="tbNewWorkflow" runat="server" OnClientClick="window.location.href = 'Workflow_Edit.aspx';" Image="AddDocument" Text="New workflow">
                                                </dw:ToolbarButton>
                                                <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                                                </dw:ToolbarButton>
                                            </dw:Toolbar>
                             	<TABLE border="0" cellpadding="0" style="width:100%">
									<tr>
										<TD width="16"></TD>
										<TD><strong><%=Translate.Translate("Procedure")%></strong></td>
										<TD width="40" align="center"><strong><%=Translate.Translate("Trin")%></strong></TD>
										<TD width="120" align="Left"><strong><%=Translate.Translate("Oprettet")%></strong></TD>
										<TD width="50" align="center"><strong><%=Translate.Translate("I brug")%></strong></TD>
										<TD width="50" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
									</tr>
									<tr>
									  	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
									</tr>
									<tr>
										<td colspan="5">
											<%= GetList() %>
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