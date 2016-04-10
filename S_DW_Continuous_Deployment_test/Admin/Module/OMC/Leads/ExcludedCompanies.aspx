<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="ExcludedCompanies.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Leads.ExcludedCompanies" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%=Dynamicweb.Gui.WriteFolderManagerScript()%>

    <script type="text/javascript">
        function save(close) {

            /* Show spinning wheel*/
            var o = new overlay('wait');
            o.show();

            if (close) {
                document.getElementById('saveAndClose').value = 'True';
            }

            document.getElementById('cmdSubmit').click();
        }
    </script>
    <style type="text/css">
        .omc-cpl-hint{
            color: #707070;
            padding-top: 10px;
            padding-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent" class="omc-control-panel" style="padding-left:10px;padding-right:10px;">
         <dw:GroupBox ID="gbIgnoreProviders" Title="Excluded companies" runat="server">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td colspan="2" class="omc-cpl-hint">
                        <dw:TranslateLabel ID="lbIgnoreListCalculation" Text="Here you can specify company names that can be applied as filter in Lead Management tool." runat="server" />
                    </td>
                </tr>
            </table>

             </br>

            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td style="width: 170px" valign="top" style="padding-top: 4px">
                        <dw:TranslateLabel ID="lbISPList" Text="Companies" runat="server" />
                    </td>
                    <td>
                         <omc:EditableListBox id="excludedCompanies" RequestKey="/Globalsettings/Modules/OMC/IgnoreProviders"
                            SelectedItems="<%$ GS: (System.String[]) /Globalsettings/Modules/OMC/IgnoreProviders  %>" runat="server" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
    </div>
    <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
    <input type="hidden" id="saveAndClose" name="saveAndClose" value="" />

    <dw:Overlay ID="wait" runat="server" Message="Please wait" ShowWaitAnimation="True"></dw:Overlay>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
