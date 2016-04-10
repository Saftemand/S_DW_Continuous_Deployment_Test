<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="AutomationsList.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Automations.AutomationsList" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function setAutomationOnOpener(automationID, automationName) {
            var openerid = '<%=Dynamicweb.Input.Request("openerid")%>';
            opener.document.getElementById(openerid).value = automationID;
            opener.document.getElementById('Title_' + openerid).value = automationName;
            window.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:List runat="server" ID="lstAutomations" NoItemsMessage="No campaigns found" Title="Campaigns" ShowTitle="false">
        <Columns>
            <dw:ListColumn runat="server" ID="clmName" Name="Name" />
            <dw:ListColumn runat="server" ID="clmTimesRun" Name="Times run" />
            <dw:ListColumn runat="server" ID="clmLastExeTime" Name="Last execution time" />
        </Columns>
    </dw:List>
</asp:Content>
