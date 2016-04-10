<%@ Page Codebehind="Template_Edit.aspx.vb" Language="vb" ValidateRequest="false"
    AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
    '**************************************************************************************************
    '	Current version:	1.1
    '	Created:			16-05-2002
    '	Last modfied:		08-06-2004
    '
    '	Purpose: File to edit template paragraphs
    '
    '	Revision history:
    '		1.0 - 16-05-2002 - Nicolai Pedersen
    '		First version.
    '		1.1 - 08-06-2004 - David Frandsen
    '		Converted to .NET
    '**************************************************************************************************

</script>

<input type="Hidden" name="Template_settings" value="TemplateFile, TemplateParagraphs, TemplateMediaCount<%=VarNames %>" />
<tr>
    <td>
        <%=Gui.MakeModuleHeader("Template", "Templates")%>
    </td>
</tr>
<tr>
    <td>
        <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
                <td style="width: 170px;">
                    <%=Translate.Translate("Template")%>
                </td>
                <td>
                    <%=Gui.FileManager(prop.Value("TemplateFile"), "Templates/ParagraphSetup", "TemplateFile")%>
                </td>
            </tr>
            <tr>
                <td>
                    <%=Translate.Translate("Antal afsnit")%>
                </td>
                <td>
                    <%=Gui.SpacListExt(prop.Value("TemplateParagraphs"), "TemplateParagraphs", 1, 200, 1, "")%>
                </td>
            </tr>
            <tr>
                <td>
                    <%=Translate.Translate("Antal billeder")%>
                </td>
                <td>
                    <%=Gui.SpacListExt(prop.Value("TemplateMediaCount"), "TemplateMediaCount", 1, 200, 1, "")%>
                </td>
            </tr>
        </table>
        <%=Gui.GroupBoxEnd%>
    </td>
</tr>
<%  For i As Integer = 1 To Base.ChkNumber(prop("TemplateMediaCount"))%>
<tr>
    <td colspan="2">
        <%=Gui.GroupBoxStart(Translate.Translate("Billede %%", "%%", i.ToString))%>
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
                <td style="width: 170px;">
                    <%=Translate.Translate("Billede")%>
                </td>
                <td>
                    <%= Gui.FileManager(prop.Value("TemplateMedia" & i), Dynamicweb.Content.Management.Installation.ImagesFolderName, "TemplateMedia" & i)%>
                </td>
            </tr>
            <tr>
                <td style="width: 170px;">
                    <%=Translate.Translate("Link")%>
                </td>
                <td>
                    <%=Gui.LinkManager(prop.Value("TemplateLink" & i), "TemplateLink" & i, "")%>
                </td>
            </tr>
        </table>
        <%=Gui.GroupBoxEnd%>
    </td>
</tr>
<%  Next%>
<%
    Translate.GetEditOnlineScript()
%>
