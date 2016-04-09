<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="Audit_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Audit_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
    Dim strParagraphSettingsSql As String
    Dim intParagraphID As Integer

    If Request("ID") <> "" Then
        intParagraphID = Base.ChkNumber(Request("ID"))
    ElseIf Request("ParagraphID") <> "" Then
        intParagraphID = Base.ChkNumber(Request("ParagraphID"))
    Else
        intParagraphID = 0
    End If



    Dim prop As New Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'intParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(intParagraphID, True)
        'prop.LoadProperty(ParagraphModuleSettings, true)
    Else
        prop.Value("AuditNumberOfRows") = "5"
        prop.Value("AuditTemplateList") = "AuditTemplateList.html"
        prop.Value("AuditTemplateElement") = "AuditTemplateElement.html"
        prop.Value("AuditStart") = "3"
        prop.Value("AuditTypeID") = ""
    End If

%>
<script language="Javascript">
    function ShowHideAuditPageIDRow(val) {
        if (val == "AuditStart2") {
            $("AuditPageIDRow").show();
            $("AuditAreaIDRow").hide();
        }
        else if (val == "AuditStart1") {
            $("AuditPageIDRow").hide();
            $("AuditAreaIDRow").show();
        } else {
            $("AuditPageIDRow").hide();
            $("AuditAreaIDRow").hide();
        }

	}
</script>
<input type="Hidden" name="Audit_Settings" value="AuditNumberOfRows, AuditTemplateList, AuditTemplateElement, AuditStart, AuditPageID, AuditAreaID, AuditTypeID">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("audit", "Audit")%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<TABLE border="0" cellpadding="0" cellspacing="0">
				<TR><TD colspan="2">&nbsp;</td></tr>
				<TR>
					<TD width="170"><%=Translate.Translate("Antal")%></TD>
					<TD>
						<%=Gui.SpacListExt(prop.Value("AuditNumberOfRows"), "AuditNumberOfRows", 1, 50, 1, "")%>
					</TD>
				</TR>
				<TR><TD Colspan="2" height="6px"></TD></TR>
				<TR>
					<TD width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></TD>
					<TD>
						<%=Gui.FileManager(prop.Value("AuditTemplateList"), "Templates/Audit", "AuditTemplateList")%>
					</TD>
				</TR>
				<TR><TD Colspan="2" height="6px"></TD></TR>
				<TR>
					<TD width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Element"))%></TD>
					<TD>
						<%=Gui.FileManager(prop.Value("AuditTemplateElement"), "Templates/Audit", "AuditTemplateElement")%>
					</TD>
				</TR>
				<TR><TD Colspan="2" height="6px"></TD></TR>
				<tr>
					<td width=170 valign=top><%=Translate.Translate("Vis")%></td>
					<td>
						<table border="0" cellpadding="0" cellspacing="0" ID="Table1">
							<tr>
								<td><input type="radio" name="AuditStart" id="AuditStart3" value="3"<%If prop.Value("AuditStart") = "3" Then%> checked<%End If%> onClick="ShowHideAuditPageIDRow(this.id)"></td>
								<td><label for="AuditStart3"><%=Translate.Translate("Alle sider/Sproglag")%></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="AuditStart" id="AuditStart1" value="1"<%If prop.Value("AuditStart") = "1" Then%> checked<%End If%> onClick="ShowHideAuditPageIDRow(this.id)"></td>
								<td><label for="AuditStart1"><%=Translate.Translate("Sproglag")%></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="AuditStart" id="AuditStart2" value="2"<%If prop.Value("AuditStart") = "2" Then%> checked<%End If%> onClick="ShowHideAuditPageIDRow(this.id)"></td>
								<td><label for="AuditStart2"><%=Translate.Translate("Herfra og ned")%></label></td>
							</tr>
						</table>			
					</td>
				</tr>
				<TR><TD Colspan="2" height="6px"></TD></TR>
				<%If prop.Value("AuditStart") = "2" Then%>
					<tr ID=AuditPageIDRow>
				<%Else%>
					<tr ID=AuditPageIDRow style="display:none;">
				<%End If%>
					<td><%=Translate.Translate("Side")%></td>
					<td><%=Gui.LinkManager(prop.Value("AuditPageID"), "AuditPageID", "")%></td>
				</tr>
				<%If prop.Value("AuditStart") = "1" Then%>
					<tr ID=AuditAreaIDRow>
				<%Else%>
					<tr ID=AuditAreaIDRow style="display:none;">
				<%End If%>
					<td><%=Translate.Translate("Sproglag")%></td>
					<td><%=Gui.SelectArea("AuditAreaID", prop.Value("AuditAreaID"))%></td>
				</tr>
				<TR><TD colspan="2">&nbsp;</TD></TR>
			</TABLE>
		<%=Gui.GroupBoxEnd%>	
	</TD>
</TR>

<%Translate.GetEditOnlineScript()%>