<%@ Page Codebehind="WorkflowProcedure_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.WorkflowProcedure_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	    <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    </HEAD>
	<SCRIPT LANGUAGE="javascript">
	<!--
		function helpLink()
        {
          return <%= Gui.Help("workflow", "modules.workflow.general.list.item.edit")%>;
    	}
        function WorkflowShowUserType_OnClick() {
			if (document.getElementById('WorkFlowUser').WorkflowShowUserType[1].checked) {
				document.all("WorkflowUserSelect_User").style.display = "none";
				document.all("WorkflowUserSelect_Group").style.display = "";
			}
			else {
				document.all("WorkflowUserSelect_User").style.display = "";
				document.all("WorkflowUserSelect_Group").style.display = "none";
			}
		}

		function WorkFlowUser_Save() {
			document.getElementById('WorkFlowUser').submit();
		}
        function Redirect()
        {
            <%="location = 'WorkflowProcedure_List.aspx?workflow=" & WorkflowID & "'" %>
        }
	//-->
	</SCRIPT>
	<BODY  style="background-color:White">
	<%= Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("deltager")), Translate.Translate("Deltager"), "all") %>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<tr style="background-color:White">
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<table height="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top">
                                <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                               <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location.href='Workflow_List.aspx';" Image="Home" Text="Start" Divide="After">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tbSaveAndClose" runat="server" OnClientClick="WorkFlowUser_Save();" Image="SaveAndClose" Text="Save and close">
                                                </dw:ToolbarButton>
                                               <dw:ToolbarButton ID="tbCancel" runat="server" OnClientClick="Redirect();" Image="Cancel" Text="Cancel">
                                                </dw:ToolbarButton>
                                                <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick=" helpLink();">
                                                </dw:ToolbarButton>
                                            </dw:Toolbar>
                              	<TABLE border="0" cellpadding="0" width="598">
									<form method="post" action="WorkflowProcedure_Save.aspx<%=Base.IIf(WorkflowProcedureID <> 0, "?procedureid=" & WorkflowProcedureID, "")%>" name="WorkFlowUser" id="WorkFlowUser">
									<INPUT type="hidden" name="AccessWorkflowUserWorkflowID" value="<%=WorkflowID%>">
									<tr>
										<td colspan="5">
											<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
												<TABLE cellpadding="2" cellspacing="0">
													<TR>
														<TD width="170" valign="top">&nbsp;<%=Translate.Translate("Type")%></TD>
														<TD>
															<TABLE border="0" cellpadding="0" cellspacing="0">
																<TR>
																	<TD><INPUT type="radio" onClick="WorkflowShowUserType_OnClick();" name="WorkflowShowUserType" value="user" checked></TD>
																	<TD><%=Translate.Translate("Bruger")%></TD>
																</TR>
																<TR>
																	<TD><INPUT type="radio" disabled onClick="WorkflowShowUserType_OnClick();" name="WorkflowShowUserType" value="group"></TD>
																	<TD><%=Translate.Translate("Gruppe")%></TD>
																</TR>
															</TABLE>
														</TD>
													</TR>
													<TR>
														<TD width="170" valign="top">&nbsp;<%=Translate.Translate("Bruger")%></TD>
														<TD>
															<DIV id="WorkflowUserSelect_User" style="display: ">
																<SELECT class="std" id="AccessWorkflowUserUserID_User" name="AccessWorkflowUserUserID_User">
																<%=GetUserList()%>
																</SELECT>
															</DIV>
															<DIV id="WorkflowUserSelect_Group" style="display: none">
																<SELECT class="std" id="AccessWorkflowUserUserID_Group" name="AccessWorkflowUserUserID_Group">
																<%=GetGroupList()%>
																</SELECT>
															</DIV>
														</TD>
													</TR>
												</TABLE>
											<%=Gui.GroupBoxEnd%>
											<%=Gui.GroupBoxStart(Translate.Translate("Godkendelse"))%>
												<TABLE cellpadding="2" cellspacing="0">
													<TR>
														<TD width="170" valign="top">&nbsp;<%=Translate.Translate("Rolle")%></TD>
														<TD>
															<SELECT class="std" name="AccessWorkflowUserRole" id="AccessWorkflowUserRole">
																<OPTION value="0" <%=Base.IIf(AccessWorkflowUserRole = 0, "selected", "")%>><%=Translate.JSTranslate("Administrator")%></OPTION>
																<OPTION value="3" <%=Base.IIf(AccessWorkflowUserRole = 3, "selected", "")%>><%=Translate.JSTranslate("Godkender")%></OPTION>
																<OPTION value="2" <%=Base.IIf(AccessWorkflowUserRole = 2, "selected", "")%>><%=Translate.JSTranslate("Høringspart")%></OPTION>
																<OPTION value="1" <%=Base.IIf(AccessWorkflowUserRole = 1, "selected", "")%>><%=Translate.JSTranslate("Korrekturlæser")%></OPTION>
															</SELECT>
														</TD>
													</TR>
													<TR>
														<TD width="170" valign="top">&nbsp;<%=Translate.Translate("Krævet")%></TD>
														<TD><INPUT type="checkbox" <%=Base.IIf(Not AccessWorkflowUserRequired, "", "checked")%> id="" name="AccessWorkflowUserRequired" value="1"></TD>
													</TR>
													<TR>
														<TD width="170" valign="top">&nbsp;<%=Translate.Translate("Notificer")%></TD>
														<TD><INPUT type="checkbox" <%=Base.IIf(Not AccessWorkflowUserNotify, "", "checked")%> value="1" id="AccessWorkflowUserNotify" name="AccessWorkflowUserNotify"></TD>
													</TR>
												</TABLE>
											<%=Gui.GroupBoxEnd%>
										</td>
									</tr>
									</form>
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
	<SCRIPT language="javascript">
		document.getElementById('WorkFlowUser').WorkflowShowUserType[<%=Base.IIf(AccessWorkflowUserUserID_User = True, "0", "0")%>].checked = true;
		WorkflowShowUserType_OnClick();
	</SCRIPT>
	<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>