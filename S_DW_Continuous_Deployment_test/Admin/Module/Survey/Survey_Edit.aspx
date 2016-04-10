<%@ Page Language="vb" ValidateRequest="false"  AutoEventWireup="false" Codebehind="Survey_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Survey.Survey_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<script language="JavaScript">
function OnChangeCheck()
{
	var i;
	var ids = "";
	var theForm = document.forms[0];
	for (i = 0; i < g_survey.length; i++)
	{
		if (theForm["survey_" + g_survey[i]].checked)
		{
			if (ids.length > 0)
				ids += ",";
			ids += g_survey[i];
		}
	}
	theForm["SurveyIDs"].value = ids;
}
</script>

<style>
.gbtable 
{
	padding-left: 5px
}
</style>
<input type="hidden" value="CookiesDisabledText, Master, Results, Info, SurveyIDs, Register, Paging, DoubleColumns, FailedPage, PassedPage, StatusNotStartedText, StatusInProgressText, StatusInProgressColor, StatusPassedText, StatusPassedColor, StatusFailedText, StatusFailedColor, SurveyList, Question, Errors"	name="Survey_settings"/>
<%=Gui.MakeModuleHeader("Survey", "Survey")%>
<input type="hidden" name="SurveyIDs" value="<%=_prop.Value("SurveyIDs")%>"/>
<table cellSpacing="0" cellPadding="0" width="598" border="0">
	<tr>
		<td>
			<table cellSpacing="0" cellPadding="0" width="590" border="0">
				<tr>
					<td colSpan="2">
						<%=Gui.GroupBoxStart(Translate.Translate("Layout templates"))%>
						<table cellSpacing="0" cellPadding="2" class="gbtable">
							<tr>
								<td width="170"><%=Translate.Translate("Master")%></td>
								<TD><%=Gui.FileManager(_prop.Value("Master"), "Templates/Survey/Layout", "Master")%></TD>
							</tr>
							<tr>
								<td><%=Translate.Translate("Survey visning")%></td>
								<TD><%=Gui.FileManager(_prop.Value("SurveyList"), "Templates/Survey/Layout", "SurveyList")%></TD>
							</tr>							
							<tr>
								<TD><%=Translate.Translate("Information")%></TD>
								<TD><%=Gui.FileManager(_prop.Value("Info"), "Templates/Survey/Layout", "Info")%></TD>
							</tr>
							<tr>
								<TD><%=Translate.Translate("Resultat")%></TD>
								<TD><%=Gui.FileManager(_prop.Value("Results"), "Templates/Survey/Layout", "Results")%></TD>
							</tr>
							<tr>
								<TD><%=Translate.Translate("Tilmelding")%></TD>
								<TD><%=Gui.FileManager(_prop.Value("Register"), "Templates/Survey/Layout", "Register")%></TD>
							</tr>
							<tr>
								<TD><%=Translate.Translate("Spørgsmål")%></TD>
								<TD><%=Gui.FileManager(_prop.Value("Question"), "Templates/Survey/Layout", "Question")%></TD>
							</tr>
                            <tr>
								<TD><%= Translate.Translate("Fejl")%></TD>
								<TD><%=Gui.FileManager(_prop.Value("Errors"), "Templates/Survey/Layout", "Errors")%></TD>
							</tr>							
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.Translate("Survey Status"))%>
						<table cellSpacing="0" cellPadding="2" class="gbtable">
							<tr>
								<td width="170"><%=Translate.Translate("Ikke begyndt")%></td>
								<td><input type="text" name="StatusNotStartedText" maxlength="255" class="std" value="<%=_prop.Value("StatusNotStartedText")%>"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Under udførelse tekst")%></td>
								<td><input type="text" name="StatusInProgressText" maxlength="255" class="std" value="<%=_prop.Value("StatusInProgressText")%>"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Cookies disabled text")%></td>
								<td><input type="text" name="CookiesDisabledText" maxlength="255" class="std" value="<%=_prop.Value("CookiesDisabledText")%>"/></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Under udførelse farve")%></td>
								<td><dw:ColorSelect id="StatusInProgressColor" runat="server" name="StatusInProgressColor"></dw:ColorSelect></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Tekst ved bestået")%></td>
								<td><input type="text" name="StatusPassedText" maxlength="255" class="std" value="<%=_prop.Value("StatusPassedText")%>"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Farve ved bestået")%></td>
								<td><dw:ColorSelect id="StatusPassedColor" runat="server" name="StatusPassedColor" first="false"></dw:ColorSelect></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Tekst ved dumpet")%></td>
								<td><input type="text" name="StatusFailedText" maxlength="255" class="std" value="<%=_prop.Value("StatusFailedText")%>"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Farve ved dumpet")%></td>
								<td><dw:ColorSelect id="StatusFailedColor" runat="server" name="StatusFailedColor" first="false"></dw:ColorSelect></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
					
						<%=Gui.GroupBoxStart(Translate.Translate("Navigation"))%>
						<table cellSpacing="0" cellPadding="2" class="gbtable">
							<tr>
								<td width="170"><%=Translate.Translate("Sideindeling")%></td>
								<td><input type="checkbox" name="Paging" <%=PagingChecked%> /></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Brug to kolonner")%></td>
								<td><input type="checkbox" name="DoubleColumns" <%=DoubleColumnsChecked%> /></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Side ved bestået")%></td>
								<td><%=Gui.LinkManagerExt(_prop.Value("PassedPage"), "PassedPage", string.Empty)%></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Side ved dumpet")%></td>
								<td><%=Gui.LinkManagerExt(_prop.Value("FailedPage"), "FailedPage", string.Empty)%></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>

						<%=Gui.GroupBoxStart(Translate.Translate("Surveys"))%>
						<table cellSpacing="0" cellPadding="2" class="gbtable">
							<%=GenerateSurveys()%>
						</table>
						<%=Gui.GroupBoxEnd()%>
					
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
Translate.GetEditOnlineScript()
%>