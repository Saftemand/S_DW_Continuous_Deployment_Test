<%@ Page CodeBehind="Workflow_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Workflow_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
		<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
        <SCRIPT LANGUAGE="javascript">
		<!--
		    var WorkFlowID = '<%= WorkflowID%>';
		    function Redirect() {
		        if (WorkFlowID == '0')
		            location = 'Workflow_List.aspx';
		        else location = 'WorkflowProcedure_List.aspx?workflow=' + WorkFlowID;
            }
			function CheckForm() {
				if (document.getElementById('AccessWorkflow').AccessWorkflowTitle.value != "") {
					document.getElementById('AccessWorkflow').submit();
				}
				else {
					alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
					document.getElementById('AccessWorkflow').AccessWorkflowTitle.focus();
				}
			}
        function helpLink()
        {
          return <%= Gui.Help("workflow", "modules.workflow.general.list")%>;
    	}
		//-->
		</SCRIPT>
	</HEAD>
	<BODY  style="background-color:White">
	<%= Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Godkendelse",9), "%c%", Translate.Translate("procedure") ), Translate.Translate("Indstillinger"), "all") %>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable" width="598"  style="background-color:White">
		<form method="post" action="Workflow_Save.aspx<%=Base.IIf(AccessWorkflowID <> 0, "?workflowid=" & AccessWorkflowID, "")%>" name="AccessWorkflow" id="AccessWorkflow">
		<tr style="background-color:White">
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
				           <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                               <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location.href='Workflow_List.aspx';" Image="Home" Text="Start" Divide="After">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tbSaveAndClose" runat="server" OnClientClick="CheckForm();" Image="SaveAndClose" Text="Save and close">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tbCancel" runat="server" OnClientClick="Redirect();" Image="Cancel" Text="Cancel">
                                                </dw:ToolbarButton>
                                                <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick=" helpLink();">
                                                </dw:ToolbarButton>
                                            </dw:Toolbar>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<TABLE border="0" cellpadding="0" width="100%">
							<TR>
								<TD width="170"><%=Translate.Translate("Navn")%></TD>
								<TD><INPUT type="text" maxlength="80" name="AccessWorkflowTitle" value="<%=AccessWorkflowTitle%>" id="AccessWorkflowTitle" class="std"></TD>
							</TR>
							<tr>
								<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Obligatorisk trin"))%></td>
								<td><%=Gui.FileManager(AccessWorkflowRequiredTemplate, "Templates/Workflow", "AccessWorkflowRequiredTemplate")%></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Notificering"))%></td>
								<td><%=Gui.FileManager(AccessWorkflowNotifyTemplate, "Templates/Workflow", "AccessWorkflowNotifyTemplate")%></td>
							</tr>
						</TABLE>
					<%=Gui.GroupboxEnd()%>
				</div>
			</td>
		</tr>
		<tr  style="background-color:White">
			<td align="right" valign="bottom">
						</td>
		</tr>
		</form>
	</table>
	<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>