<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ReportSelector.ascx.vb" Inherits="Dynamicweb.Admin.OMC.Controls.ReportSelector" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<div id="divSelectContainer" class="report-selector" runat="server">
    <div class="report-selector-inner">
        <script type="text/javascript">
            <asp:Literal ID="litInitialization" runat="server" />    
        </script>

        <dw:Tree ID="reportTree" ShowRoot="false" ShowTitle="false" SubTitle="All reports" TranslateSubTitle="true" 
            UseSelection="false" UseCookies="false" OpenAll="true" UseLines="true" InOrder="true" runat="server">

            <dw:TreeNode ID="nodeRoot" NodeID="0" ParentID="-1" Name="Root" ItemID="/Reports" runat="server" />
        </dw:Tree>
    </div>

    <asp:Literal ID="litRequestItem" runat="server" />
</div>