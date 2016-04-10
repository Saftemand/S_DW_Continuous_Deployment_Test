<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.DefaultSmartSearches" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.eCommerce.UserPermissions" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SmartSearch</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <base target="_self" />
    <dw:ControlResources ID="ControlResources1" runat="server" />

    <script type="text/javascript">
    var initID = '<%= ItemUID.ToString() %>';
    var nodeID = <%= ItemID.ToString() %>;
    var userID = <%= UserID.ToString() %>;
    var frameLevel = <%= FrameLevel.ToString() %>;
    var previewMode = '<%= CType(IIf(IsPreview, "&preview=on", String.Empty), String) %>';
    var popupMode = '<%= CType(IIf(IsPopup, "&popup=on", String.Empty), String) %>';
    var providerTypeName = '<%= CType(IIf(Not String.IsNullOrEmpty(ProviderTypeName), "&providerType=" & ProviderTypeName, String.Empty), String) %>';
        
    var cmd = '<%=Base.ChkString(Base.Request("CMD"))%>';
    var txtNoMoreViews = '<%=Dynamicweb.Backend.Translate.JsTranslate("You cannot create any more smart search lists.") %>';
    
    function submitMe(itemId) {
        document.getElementById('Form1').InitID.value = itemId;
        document.getElementById('Form1').submit();
    }

    function popupRedirect(e){
        if(window.showModalDialog) {
            document.getElementById('popupNavigateLink').href = e;
            document.getElementById('popupNavigateLink').click();
         }
         else {
            window.location = e;
         }
    }
    
    function submitReload(itemId, cmd) {
        document.getElementById('Form1').InitID.value = itemId;
        document.getElementById('Form1').CMD.value = cmd;
        document.getElementById('Form1').submit();
    }
    
    function getContentFrameHeight() {
        return document.getElementById("ContentFrame").clientHeight;
    }
    
    function ContextmenuClick(cmd) {
        var id = ContextMenu.callingItemID;
        ContentFrameHandler(id, "", cmd);
    }
    
    function NodeClick(Id, Name, cmd) {
        ContentFrameHandler(Id, Name, cmd);
    }

    function ContentFrameHandler(Id, Name, cmd) {
        var contentFrame = document.getElementById("ContentFrame");
        
        switch(cmd)
        {
            case "ADD_SMART_SEARCH":
                contentFrame.src = "EditSmartSearch.aspx?CMD=" + cmd + "&userID=" + userID + "&frameLevel=" + frameLevel + previewMode + popupMode + "&providerType=" + Id;
                break;
            case "EDIT_SMART_SEARCH":
                contentFrame.src = "EditSmartSearch.aspx?ID=" + Id + "&CMD=" + cmd +"&userID=" + userID + "&frameLevel=" + frameLevel + previewMode + popupMode + providerTypeName;
                break;
            case "DELETE_SMART_SEARCH":
                if (confirm('<%=Translate.JsTranslate("Delete smart search?")%>'))
                 {
                    if(initID == Id) 
                    {
                        var url = "EditSmartSearch.aspx?ID=" + Id + "&CMD=" + cmd+"&userID=" + userID + "&frameLevel=" + frameLevel + previewMode + popupMode + providerTypeName;
                        new Ajax.Request( 'EditSmartSearch.aspx', {
                              method:  'post',
                              parameters:  { 'ID': Id,'CMD':cmd},
                              onSuccess:  function(response){
                                parent.document.getElementById('ContentFrame').src='/Admin/Content/Management/SmartSearches/Default.aspx?userID=' + userID + '&frameLevel=' + frameLevel + previewMode + popupMode + providerTypeName;
                              },
                              onFailure:  function(){
                                alert("Wasn't deleted due to the error");
                              }
                            }); 
                    }
                    else contentFrame.src = "EditSmartSearch.aspx?ID=" + Id + "&CMD=" + cmd + "&userID=" + userID + "&frameLevel=" + frameLevel  + previewMode + popupMode + providerTypeName;
                }
                break;
            default:
                var actionUrl = "ViewSmartSearchResults.aspx?ID=" + Id;

                if (!cmd || cmd != "INIT_DATA") {
                    var returnValue = new Object();
                    returnValue.listID = Id;
                    returnValue.listName = Name;
                    window.returnValue = returnValue;
                    if (!window.showModalDialog) {
                        var fnName = window.name + "_modalDialogOk";
                        var fn = window.opener[fnName];
                        if (fn) {
                            fn(returnValue);
                        }
                    }
                    <%= If(IsPopup, "window.close();", "contentFrame.src = actionUrl;")%>
                } else{
                    contentFrame.src = actionUrl;
                }
                break;
        }
    }
    </script>

</head>
<body style="height: 100%;">
    <form id="Form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin ID="ModuleAdmin" runat="server">
        <dw:Tree ID="Tree1" runat="server" SubTitle="Smart searches list" Title="Smart Searches" ShowRoot="false" openAll="false" useSelection="true" useCookies="true" useLines="true">
            <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Root" ParentID="-1" />
        </dw:Tree>
    </dw:ModuleAdmin>
    <input type="hidden" id="InitID" name="InitID" value="0" />
    <input type="hidden" id="CMD" name="CMD" value="" />
    </form>
    <a href=”" id=”popupNavigateLink” style=”display:none;” />
    
    <dw:Contextmenu ID="FolderContextMenu" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="New smart search" OnClientClick="ContextmenuClick('ADD_SMART_SEARCH');" />
    </dw:Contextmenu>

    <dw:Contextmenu ID="ItemContextMenu" runat="server">
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="New smart search" OnClientClick="ContextmenuClick('ADD_SMART_SEARCH');" />
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Edit" Text="Edit smart search" OnClientClick="ContextmenuClick('EDIT_SMART_SEARCH');" />
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Delete" Text="Delete smart search" OnClientClick="ContextmenuClick('DELETE_SMART_SEARCH');" />
	</dw:Contextmenu>
    
    <script type="text/javascript">
        //ContentFrameHandler(0, "");
        
        if (initID.length != 0 && cmd.length != 0) {
            ContentFrameHandler(initID, "", cmd);
        }else{
            try {
                if (t) {
                    if (nodeID > 0) {
                        // Open to firstID
                        t.openTo(nodeID);
                        for (i = 0; i < t.aNodes.length; i++) {
                            var node = t.aNodes[i];
                            if (node.id == nodeID)
                                t.s(i);
                        }
                    } else {
                        // Open selected node
                        for (i = 0; i < t.aNodes.length; i++) {
                            var nodeB = t.aNodes[i];
                            if (nodeB._is) {
                                nodeID = nodeB.id;
                                initID = nodeB.itemID;
                                break;
                            }
                        }
                    }
                }
            }catch (e) {
            }

            ContentFrameHandler(initID, "", "INIT_DATA");
        }
    </script>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
