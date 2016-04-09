<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/Reports/ReportPage.master" CodeBehind="Funnel.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Reports.Funnel" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.Charts" Assembly="Dynamicweb.Controls" %>

<asp:Content ContentPlaceHolderID="ReportContent" runat="server">
    <dw:Chart ID="repChart" Width="500" Height="400" AutoDraw="false" runat="server" />
</asp:Content>
