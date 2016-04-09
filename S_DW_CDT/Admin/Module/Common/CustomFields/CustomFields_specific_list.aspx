<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/Common/List.Master" Codebehind="CustomFields_specific_list.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2.CustomFields_specific_list" %>
<%@ Register Src="/Admin/Module/Common/HeaderColumn.ascx" TagName="HeaderCell" TagPrefix="list" %>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:HeaderCell runat="server" Width="38%" IsSorting="false" Caption="Field name" />
    <list:HeaderCell runat="server" Width="25%" IsSorting="false" Caption="Template tag" />
    <list:HeaderCell runat="server" Width="25%" IsSorting="false" Caption="Field type" />
    <list:HeaderCell runat="server" Width="4%" IsSorting="false" Caption="Sort" />
    <list:HeaderCell runat="server" Width="8%" IsSorting="false" Caption="Slet" Alignment="Center" />
</asp:content>