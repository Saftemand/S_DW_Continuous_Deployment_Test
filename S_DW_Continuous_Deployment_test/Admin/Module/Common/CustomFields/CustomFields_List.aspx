<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/Common/List.Master" CodeBehind="CustomFields_List.aspx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.CustomFields_List" %>
<%@ Register Src="~/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>

<asp:content id="Content1" contentplaceholderid="BreadcrumbHolder" runat="server">
      <%=GetBreadcrumb() %>
</asp:content>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:HeaderCell ID="HeaderCell1" runat="server" Width="38%" IsSorting="false" Caption="Field name" />
    <list:HeaderCell ID="HeaderCell2" runat="server" Width="25%" IsSorting="false" Caption="Template tag" />
    <list:HeaderCell ID="HeaderCell3" runat="server" Width="25%" IsSorting="false" Caption="Field type" />
    <list:HeaderCell ID="HeaderCell4" runat="server" Width="4%" IsSorting="false" Caption="Sort" />
    <list:HeaderCell ID="HeaderCell5" runat="server" Width="8%" IsSorting="false" Caption="Slet" Alignment="Center" />
</asp:content>