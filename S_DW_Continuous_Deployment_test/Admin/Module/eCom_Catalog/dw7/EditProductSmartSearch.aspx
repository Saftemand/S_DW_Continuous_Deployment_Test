<%@ Page Language="vb" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master" AutoEventWireup="false" CodeBehind="EditProductSmartSearch.aspx.vb" Inherits="Dynamicweb.Admin.EditProductSmartSearch" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
     <iframe name="ProductsSmartSearchFrame" id="ProductsSmartSearchFrame" src="/Admin/Content/Management/SmartSearches/EditSmartSearch.aspx?CMD=<%= Base.Request("CMD")%>&ID=<%= Base.Request("ID")%>&preview=<%= Base.Request("preview")%>&backUrl=<%= Base.Request("backUrl")%>&providerType=Dynamicweb.Modules.Searching.SmartSearch.LuceneProductsSmartSearch&calledFrom=eCom" frameborder="0" height="100%" width="100%"></iframe>
<% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
   
</asp:Content>

