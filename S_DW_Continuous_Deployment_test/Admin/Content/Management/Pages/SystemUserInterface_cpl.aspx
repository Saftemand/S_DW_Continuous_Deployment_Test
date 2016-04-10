<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SystemUserInterface_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemUserInterface_cpl" %>
<%@ Import namespace="Dynamicweb" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
     <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onHelp = function() {
            <%=Gui.help("", "administration.managementcenter.system.userinterface") %>
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <iframe id="PageContent" src="/Admin/Module/Language/Language_Edit.aspx?caller=ManagementCenter" 
        width="100%" frameborder="0"></iframe>
</asp:Content>
