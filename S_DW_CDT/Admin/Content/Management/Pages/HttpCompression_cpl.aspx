<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="HttpCompression_cpl.aspx.vb" Inherits="Dynamicweb.Admin.HttpCompression_cpl" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            page.submit();
        }

        page.onHelp = function() {
            <%=Gui.help("", "managementcenter.web.httpcompression") %>
        }        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:GroupBox ID="gbInjection" Title="Indstillinger" runat="server">
        <table border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td style="width: 170px" valign="top">
                        <dw:TranslateLabel ID="lbDisable" Text="Type" runat="server" />
                </td>
                <td>
                    <%
                       	   If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/System/http/Compression/Type")) Then
                       		   Base.SetGs("/Globalsettings/System/http/Compression/Type", "gzip")
                       	   End If
                    %>
                    <%=Dynamicweb.Gui.RadioButton(Base.GetGs("/Globalsettings/System/http/Compression/Type"), "/Globalsettings/System/http/Compression/Type", "gzip")%>
                    <label for="/Globalsettings/System/http/Compression/Typegzip"><dw:TranslateLabel ID="TranslateLabel1" Text="GZip" runat="server" /> <small>(<dw:TranslateLabel ID="TranslateLabel4" Text="Standard" runat="server" />)</small></label>
                    <br />
                    <%=Dynamicweb.Gui.RadioButton(Base.GetGs("/Globalsettings/System/http/Compression/Type"), "/Globalsettings/System/http/Compression/Type", "deflate")%>
                    <label for="/Globalsettings/System/http/Compression/Typedeflate"><dw:TranslateLabel ID="TranslateLabel2" Text="Deflate" runat="server" /></label>
                    <br />
                    <%=Dynamicweb.Gui.RadioButton(Base.GetGs("/Globalsettings/System/http/Compression/Type"), "/Globalsettings/System/http/Compression/Type", "none")%>
                    <label for="/Globalsettings/System/http/Compression/Typenone"><dw:TranslateLabel ID="TranslateLabel3" Text="Ingen" runat="server" /></label>
                    <br />
                </td>
            </tr>
            
        </table>
    </dw:GroupBox>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
