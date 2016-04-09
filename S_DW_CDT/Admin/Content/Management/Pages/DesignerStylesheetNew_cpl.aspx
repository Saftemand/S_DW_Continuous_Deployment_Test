<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="DesignerStylesheetNew_cpl.aspx.vb" Inherits="Dynamicweb.Admin.DesignerStylesheetNew_cpl" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            var frame = document.getElementById('PageContent');
            
            if (frame) {
                frame.contentWindow.ValidateThisForm();
            }
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <iframe id="PageContent" width="100%" frameborder="0" 
        src='/Admin/Stylesheet/Stylesheet_create.aspx?Caller=ManagementCenter&StylesheetID=<%=Base.ChkNumber(Request.QueryString("StylesheetID"))%>'></iframe>
        
    <% Translate.GetEditOnlineScript()%>
</asp:Content>