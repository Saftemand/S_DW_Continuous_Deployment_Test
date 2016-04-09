<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="BasicForum_cpl.aspx.vb" Inherits="Dynamicweb.Admin.BasicForum_cpl" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            $("action").value = "DoSave";
            document.frmGlobalSettings.submit();
        }

        function doImport () {
            if (confirm('<%=Translate.JsTranslate("This will import all content from the ForumV2 module on this solution. Current content in the Forum DW8 module will be deleted and cannot be recovered. Do you want to continue?") %>')) {
                $("action").value = "DoImport";
                $('MainForm').setAttribute('action', 'BasicForum_cpl.aspx');
                document.frmGlobalSettings.submit();
            }
        }
    </script>

    <style type="text/css">
        div.heading-row
        {
            height: 18px;
            line-height: 18px;
        }
        
        div.heading-row label,
        div.heading-row input
        {
            display: block;
            float: left;
        }
        
        div.heading-row input
        {
            margin: 0px;
            padding: 0px;
            margin-right: 4px;
            margin-top: 2px;
            width: 15px;
            height: 15px;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <input type="hidden" id="action" name="action">
    <div id="PageContent">
         <dw:GroupBox ID="ImportDataGroup" Title="Import existing forum content" runat="server">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        <input type="button" value="<%=Translate.JsTranslate("Import content from ForumV2 module") %>" onclick="doImport();" class="std"/>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </div>

<script type="text/javascript">
    if ('<%=showDialog%>' == 'True')
        alert("<%=importDone%>");
</script>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</asp:Content>
