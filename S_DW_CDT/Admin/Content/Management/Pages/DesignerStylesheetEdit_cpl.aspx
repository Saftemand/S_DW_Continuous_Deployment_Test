<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="DesignerStylesheetEdit_cpl.aspx.vb" Inherits="Dynamicweb.Admin.DesignerStylesheetEdit_cpl" %>
<%@ Import Namespace="Dynamicweb" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            var frame = document.getElementById('PageContent');
            var form = null;

            if (frame) {
                if (document.getElementById('hiddenSource').value == "ManagementCenterSave") {
                    frame.contentWindow.document.getElementById('SaveOnly').value = 1;
                }
                form = frame.contentWindow.document.getElementById('StylesheetClassForm');
                if (form) {
                    form.submit();
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <iframe id="PageContent" width="100%" frameborder="0" 
        src='<%=String.Format("/Admin/Stylesheet/stylesheet_edit.aspx?Caller=ManagementCenter&StylesheetName={0}&StylesheetID={1}&ClassID={2}&Tab={3}", _
            Server.UrlEncode(Base.Request("StylesheetName")), Base.Request("StylesheetID"), Base.Request("ClassID"), Base.Request("Tab")) %>'>
    </iframe>
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
        %>
</asp:Content>