<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>



<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Stylesheet control panel
'
'	Revision history:
'		1.0 - 13-06-2002 - Rasmus Foged
'		First version.
'**************************************************************************************************
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("Kontrol Panel - %%","%%",Translate.JsTranslate("Godkendelse",9))%></TITLE>
</HEAD>
<BODY>
<SCRIPT>
	function OK_OnClick() {
		document.getElementById('frmGlobalSettings').submit();
	}

	function findCheckboxNames(form) {
		var _names="";
		for(var i=0; i < form.length ; i++) {
			if(form[i].name!=undefined) {
				if(form[i].type=="checkbox") {
					_names = _names + form[i].name + "@"
				}
			}
		}
	form.CheckboxNames.value=_names;
	}
</SCRIPT>
<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Godkendelse",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type=hidden name=CheckboxNames>
		<TR>
			<TD valign="top">
				<TABLE border="0" cellpadding="5" cellspacing="0" width="95%">
					<TR>
						<TD></TD>
						<TD height="50" width="38"><IMG src="../images/Icons/Module_StyleSheet.gif"></TD>
					</TR>
				</TABLE>
				<%=Gui.GroupBoxStart(Translate.Translate("Godkendelse"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0">

						<TR>
							<TD colspan="2">&nbsp;</TD>
						</tr>
						<TR>
							<TD width="170"><%=Translate.Translate("Standard type")%></TD>
							<TD>
							<%
							Dim ApprovalType as integer = Base.chkNumber(Base.GetGs("/Globalsettings/Modules/VersionControl/ApprovalType"))
							%>
							   <select class=std name="/Globalsettings/Modules/VersionControl/ApprovalType" id="/Globalsettings/Modules/VersionControl/ApprovalType">
								<option value="0" <%=Base.IIf(ApprovalType = 0, "SELECTED", "")%> ><%=Translate.JsTranslate("ingen")%></option>
								<option value="-1" <%=Base.IIf(ApprovalType = -1, "SELECTED", "")%> ><%=Translate.JsTranslate("Strakspublicer")%></option>
								<option value="-3" <%=Base.IIf(ApprovalType = -3, "SELECTED", "")%> ><%=Translate.JsTranslate("Strakspublicer (m/ versionering)")%></option>
								<option value="-2" <%=Base.IIf(ApprovalType = -2, "SELECTED", "")%> ><%=Translate.JsTranslate("Godkendelse")%></option>
								<%
								If Base.IsModuleInstalled("WorkFlow", False) Then
									Dim strSqlWorkFlow As String = "SELECT * FROM AccessWorkflow"
									Dim cnWorkFlow As IDbConnection = Database.CreateConnection("Access.mdb")
									Dim cmdSelectWorkFlow As System.Data.IDbCommand = cnWorkFlow.CreateCommand

									cmdSelectWorkFlow.CommandText = strSqlWorkFlow

									Dim drWorkFlowReader As IDataReader = cmdSelectWorkFlow.ExecuteReader
									Dim intOpAccessWorkflowID As Integer = drWorkFlowReader.GetOrdinal("AccessWorkflowID")
									Dim intOpAccessWorkflowTitle As Integer = drWorkFlowReader.GetOrdinal("AccessWorkflowTitle")
									Dim strSel as String 
									Do While drWorkFlowReader.Read

										If ApprovalType = CType(drWorkFlowReader(intOpAccessWorkflowID), Integer) Then
											strSel = " Selected"
										End If
										response.write("<option value=""" & drWorkFlowReader(intOpAccessWorkflowID).ToString & """" & strSel & ">" & drWorkFlowReader(intOpAccessWorkflowTitle).ToString & "</option>")
										strSel = ""
									Loop
									drWorkFlowReader.Close()
									drWorkFlowReader.Dispose()
									cmdSelectWorkFlow.Dispose()
									cnWorkFlow.Close()
									cnWorkFlow.Dispose()
								End If
								%>
							</td>
						</TR>
						<TR>
							<TD height="5" colspan="2"></TD>
						</tr>

						<%
						Dim ListSize as integer = Base.chkNumber(Base.GetGs("/Globalsettings/Modules/VersionControl/ListSize")) 
						If ListSize = 0 Then
							ListSize = 6
						End If
						%>
							<TD width="170"><%=Translate.Translate("Antal viste versioner")%></TD>
							<TD colspan="2"><%=gui.SpacListExt(ListSize,"/Globalsettings/Modules/VersionControl/ListSize",1,20,1,"")%></TD>
						</tr>

						<TR>
							<TD colspan="2">&nbsp;</TD>
						</tr>
					</TABLE>
				<%=Gui.GroupBoxEnd%>
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD>
									<%=Gui.Button(Translate.Translate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
								</TD>
								<%=Gui.HelpButton("", "administration.controlpanel.workflow")%>
								<TD width="2"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TD>
		<TR>
	</form>
</TABLE>
<%
Translate.GetEditOnlineScript()
%>
