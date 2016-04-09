<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="Cdn_cpl.aspx.vb" Inherits="Dynamicweb.Admin.cdn_cpl" %>

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
            <%=Gui.help("", "managementcenter.web.cdn") %>
        }        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:GroupBox ID="gbInjection" Title="Indstillinger" runat="server">
        <table border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td style="width: 170px" valign="top">
                        
                </td>
                <td>
                    <%=Dynamicweb.Gui.CheckBox(Base.GetGs("/Globalsettings/System/cdn/active"), "/Globalsettings/System/cdn/active")%>
                    <label for="/Globalsettings/System/cdn/active"><dw:TranslateLabel ID="TranslateLabel1" Text="Active" runat="server" /></label>
                </td>
            </tr>
			<tr>
                <td valign="top">
                    <dw:TranslateLabel ID="TranslateLabel3" Text="Host" runat="server" />
                </td>
                <td>
	                <input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/cdn/host")%>" name="/Globalsettings/System/cdn/host" /><br />
					<small>http(s)://cdn.domain.com</small>
                </td>
            </tr>
			<tr>
                <td valign="top">
                    <dw:TranslateLabel ID="TranslateLabel2" Text="Host" runat="server" /> <small>(GetImage.ashx)</small>
                </td>
                <td>
	                <input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/cdn/getimagehost")%>" name="/Globalsettings/System/cdn/getimagehost" /><br />
					<small>http(s)://cdn.domain.com</small>
                </td>
            </tr>
            
        </table>
    </dw:GroupBox>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
