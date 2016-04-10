<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="pipelinetree.ascx.vb"
    Inherits="Dynamicweb.Admin.Integration.pipelinetree" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%
    Response.Cache.SetExpires(DateTime.Now)
    Response.Cache.SetCacheability(HttpCacheability.NoCache)
    Response.AddHeader("pragma", "no-cache")
    Response.AddHeader("cache-control", "private")
    Response.CacheControl = "no-cache"
%>
<script type="text/javascript">
function menuClick(type){

    if(type == 'new'){
        parent.Integration_Main.location.href = "Edit.aspx?Integration=true";
        return;
    }
 
    var data = ContextMenu.callingItemID;
    var item = decodeURIComponent(data).evalJSON();
       
    if (type == "delete"){
         if (confirm("<%=Translate.JsTranslate("Slet?")%>")) {
		        parent.Integration_Main.location.href = "Edit.aspx?Delete=true&ID="+ item.nodeId;
		    }   
    }
    else if(type == 'open'){
        parent.Integration_Main.location.href = "Edit.aspx?Integration=true&ID="+ item.nodeId;
    }
}
  
</script>
<dw:StretchedContainer ID="contentStretcher" runat="server" Anchor="body">
    <dw:Tree ID="Tree1" runat="server" SubTitle="Integration" ShowRoot="false" OpenAll="true"
        UseSelection="true" UseCookies="false" UseLines="true">
        <dw:TreeNode ID="Root" NodeID="0" runat="server" Name="Root" ParentID="-1" />
    </dw:Tree>
</dw:StretchedContainer>
<dw:ContextMenu ID="Menu" runat="server">
    <dw:ContextMenuButton ID="ContextMenuButton3" runat="server" Divide="None" Image="AddDocument"
        Text="Ny" OnClientClick="menuClick('new');">
    </dw:ContextMenuButton>
</dw:ContextMenu>
<dw:ContextMenu ID="PIPE" runat="server">
    <dw:ContextMenuButton ID="ContextMenuButton4" runat="server" Divide="None" Image="AddDocument"
        Text="Ny" OnClientClick="menuClick('new');">
    </dw:ContextMenuButton>
    <dw:ContextMenuButton ID="ContextMenuButton5" runat="server" Divide="None" Image="DeleteDocument"
        Text="Slet" OnClientClick="menuClick('delete');">
    </dw:ContextMenuButton>
    <dw:ContextMenuButton ID="ContextMenuButton6" runat="server" Divide="None" Image="View"
        Text="Open" OnClientClick="menuClick('open');">
    </dw:ContextMenuButton>
</dw:ContextMenu>
<dw:ContextMenu ID="LOCKEDPIPE" runat="server">
    <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" Divide="None" Image="AddDocument"
        Text="Ny" OnClientClick="menuClick('new');">
    </dw:ContextMenuButton>
    <dw:ContextMenuButton ID="ContextMenuButton7" runat="server" Divide="None" Image="View"
        Text="Open" OnClientClick="menuClick('open');">
    </dw:ContextMenuButton>
</dw:ContextMenu>
