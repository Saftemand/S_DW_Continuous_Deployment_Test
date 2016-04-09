<%'UPGRADE_NOTE: All function, subroutine and variable declarations were moved into a script tag global. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1007.htm%>
<script language="VB" runat="Server">
Dim DWWorkflow_ApproveParagraph As Object
'UPGRADE_ISSUE: DWTranslate object was not upgraded. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup2068"'
Dim cTranslate As New DWTranslate
Dim GroupBox_End() As Object
Dim CheckBox As Object
Dim GroupBox_Start() As Object
'UPGRADE_ISSUE: GlobalSetting object was not upgraded. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup2068"'
Dim DWGlobalSetting As New GlobalSetting
Dim DWWorkflow_MaxList As String


</script>
<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file '../../common.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="../../common.asp" -->

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			11-03-03
'
'	Purpose: 
'
'	Revision history:
'		1.0 - 11-03-03 - Rasmus Foged
'		First version.
'**************************************************************************************************
cTranslate = New DWTranslate

DWGlobalSetting = New GlobalSetting
DWGlobalSetting.Load("/files/globalsettings.xml")

Call DWGlobalSetting.StripProperties()

'UPGRADE_NOTE: Object DWGlobalSetting may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
DWGlobalSetting = Nothing
%>
<TABLE border="0" cellpadding="5" cellspacing="0" width="95%">
	<TR>
		<TD><%=cTranslate.Translate("Generelle indstillinger for Workflow og versionsstyring.")%>.</TD>
		<TD height="50" width="38"><IMG src="../images/Icons/Module_Versioncontrol.gif"></TD>
	</TR>
</TABLE>
<%=GroupBox_Start(cTranslate.Translate("Version"))%>
	<TABLE border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="170"><%=cTranslate.Translate("Vis versioner")%></TD>
			<TD>
				<SELECT class="std" name="DWWorkflow_MaxList">
					<OPTION value="5"  <%=IIf(DWWorkflow_MaxList = "5", "selected", "")%>>5</OPTION>
					<OPTION value="10" <%=IIf(DWWorkflow_MaxList = "10", "selected", "")%>>10</OPTION>
					<OPTION value="20" <%=IIf(DWWorkflow_MaxList = "20", "selected", "")%>>20</OPTION>
					<OPTION value="50" <%=IIf(DWWorkflow_MaxList = "50", "selected", "")%>>50</OPTION>
					<OPTION value="0"  <%=IIf(DWWorkflow_MaxList = "0", "selected", "")%>><%=cTranslate.Translate("Alle")%></OPTION>
				</SELECT>
			</TD>
		</TR>
	</TABLE>
<%
Response.Write(GroupBox_End)
Response.Write(GroupBox_Start(cTranslate.Translate("Godkendelse",9)))
%>
	<TABLE border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="170"><%=cTranslate.Translate("Godkend afsnit individuelt.")%></TD>
			<TD><%Call CheckBox(DWWorkflow_ApproveParagraph, "DWWorkflow_ApproveParagraph")%></TD>
		</TR>
	</TABLE>
<%
Response.Write(GroupBox_End)
'UPGRADE_NOTE: Object cTranslate may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
cTranslate = Nothing
%>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>
