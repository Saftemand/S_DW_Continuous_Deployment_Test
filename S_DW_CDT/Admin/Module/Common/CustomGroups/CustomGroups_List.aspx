<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/Common/List.Master" CodeBehind="CustomGroups_List.aspx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.CustomGroups_List" %>
<%@ Register Src="~/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>

<asp:content id="Content1" contentplaceholderid="BreadcrumbHolder" runat="server">
      <%=GetBreadcrumb() %>
</asp:content>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:HeaderCell ID="HeaderCell1" runat="server" Width="67%" IsSorting="false" Caption="Group name" />
    <list:HeaderCell ID="HeaderCell2" runat="server" Width="25%" IsSorting="false" Caption="Fields" />
    <list:HeaderCell ID="HeaderCell5" runat="server" Width="8%" IsSorting="false" Caption="Slet" Alignment="Center" />
</asp:content>