<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="DesignerStylesheetSettingsSpecific_cpl.aspx.vb" Inherits="Dynamicweb.Admin.DesignerStylesheetSettingsSpecific_cpl" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <iframe id="PageContent" width="100%" frameborder="0" src='<%=GetSettingsUrl()%>'></iframe>
    
    <% Translate.GetEditOnlineScript() %>
</asp:Content>