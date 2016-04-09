<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="LanguageManagement_cpl.aspx.vb" Inherits="Dynamicweb.Admin.LanguageManagement_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
             document.getElementById('MainForm').submit();
        }

        page.onHelp = function() {
            <%=Gui.help("", "modules.languagemanagement.cpl") %>
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
<dw:GroupBoxStart ID="gbVersionStart" Title="Language versions" runat="server" />
    <table border="0" cellpadding="2" cellspacing="0">
        <tr>
            <td width="170">&nbsp;</td>
            <td>
                <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/DeactivateParagraphOnNew"), "/Globalsettings/Modules/LanguageManagement/DeactivateParagraphOnNew")%>
                <label for="/Globalsettings/Modules/LanguageManagement/DeactivateParagraphOnNew"><dw:TranslateLabel ID="lb1" Text="Deactivate new paragraphs" runat="server" /></label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/DeactivatePageOnNew"), "/Globalsettings/Modules/LanguageManagement/DeactivatePageOnNew")%>
                <label for="/Globalsettings/Modules/LanguageManagement/DeactivatePageOnNew"><dw:TranslateLabel ID="lb2" Text="Deactivate new pages" runat="server" /></label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowNewParagraphs"), "/Globalsettings/Modules/LanguageManagement/AllowNewParagraphs")%>
                <label for="/Globalsettings/Modules/LanguageManagement/AllowNewParagraphs"><dw:TranslateLabel ID="TranslateLabel1" Text="Allow paragraph operations (Create, copy, move, delete, sort)" runat="server" /></label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowGlobalParagraphs"), "/Globalsettings/Modules/LanguageManagement/AllowGlobalParagraphs")%>
                <label for="/Globalsettings/Modules/LanguageManagement/AllowGlobalParagraphs"><dw:TranslateLabel ID="TranslateLabel3" Text="Allow new global paragraphs" runat="server" /></label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <%=Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowNewPages"), "/Globalsettings/Modules/LanguageManagement/AllowNewPages")%>
                <label for="/Globalsettings/Modules/LanguageManagement/AllowNewPages"><dw:TranslateLabel ID="TranslateLabel2" Text="Allow page operations (Create, copy, move, delete, sort)" runat="server" /></label>
            </td>
        </tr>
		
		<tr>
            <td>&nbsp;</td>
            <td>
                <%= Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/InheritPageChanges"), "/Globalsettings/Modules/LanguageManagement/InheritPageChanges")%>
                <label for="/Globalsettings/Modules/LanguageManagement/InheritPageChanges"><dw:TranslateLabel ID="TranslateLabel7" Text="Copy master changes to language versions if values are the same." runat="server" /> (<dw:TranslateLabel ID="TranslateLabel8" Text="Sider" runat="server" />)</label>
            </td>
        </tr>
		<tr>
            <td>&nbsp;</td>
            <td>
                <%= Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/InheritParagraphChanges"), "/Globalsettings/Modules/LanguageManagement/InheritParagraphChanges")%>
                <label for="/Globalsettings/Modules/LanguageManagement/InheritParagraphChanges"><dw:TranslateLabel ID="TranslateLabel4" Text="Copy master changes to language versions if values are the same." runat="server" /> (<dw:TranslateLabel ID="TranslateLabel6" Text="Afsnit" runat="server" />)</label>
            </td>
        </tr>
		<tr>
            <td>&nbsp;</td>
            <td>
                <%= Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/CompareParagraphAsText"), "/Globalsettings/Modules/LanguageManagement/CompareParagraphAsText")%>
                <label for="/Globalsettings/Modules/LanguageManagement/CompareParagraphAsText"><dw:TranslateLabel ID="TranslateLabel9" Text="Compare paragraphs as text" runat="server" /></label>
            </td>
        </tr>
		<tr>
            <td>&nbsp;</td>
            <td>
                <%= Gui.CheckBox(Base.GetGs("/Globalsettings/Modules/LanguageManagement/UseAreaNamesForDropdowns"), "/Globalsettings/Modules/LanguageManagement/UseAreaNamesForDropdowns")%>
                <label for="/Globalsettings/Modules/LanguageManagement/UseAreaNamesForDropdowns"><dw:TranslateLabel ID="TranslateLabel5" Text="Use language name in dropdowns" runat="server" /></label>
            </td>
        </tr>
    </table>
<dw:GroupBoxEnd ID="gbVersionEnd" runat="server" />
<% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
