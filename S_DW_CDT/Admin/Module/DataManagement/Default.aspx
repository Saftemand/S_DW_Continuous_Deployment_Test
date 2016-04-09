<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.DMDefault" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.eCommerce.UserPermissions" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DM</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <dw:ControlResources ID="ControlResources1" runat="server" />

    <script type="text/javascript">
    var initID = <%=Base.ChkInteger(Base.Request("initID"))%>;
    var cmd = '<%=Base.ChkString(Base.Request("CMD"))%>';
    var txtNoMoreViews = '<%=Dynamicweb.Backend.Translate.JsTranslate("You cannot create any more data lists. Install 'Data List (Extended)' to create more.") %>';
    
    function submitMe(itemId) {
        document.getElementById('Form1').InitID.value = itemId;
        document.getElementById('Form1').submit();
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
            case "ADD_CONNECTION":
                contentFrame.src = "Connection/EditConnection.aspx?CMD=" + cmd;
                break;
            case "DELETE_CONNECTION":
                if (confirm('<%=Translate.JsTranslate("Delete connection?")%>')) {
                    contentFrame.src = "Connection/EditConnection.aspx?ID=" + Id + "&CMD=" + cmd;
                }
                break;
            case "EDIT_CONNECTION":
            case "COPY_CONNECTION":
                contentFrame.src = "Connection/EditConnection.aspx?ID=" + Id + "&CMD=" + cmd;
                break;
            case "ADD_VIEW":
                contentFrame.src = "View/EditView.aspx?CMD=" + cmd;
                break;
            case "EDIT_VIEW":
                contentFrame.src = "View/EditView.aspx?ID=" + Id + "&CMD=" + cmd;
                break;
            case "EDIT_AND_PREVIEW":
                contentFrame.src = "View/EditView.aspx?ID=" + Id + "&CMD=" + cmd + "&preview=True";
                break;
            case "DELETE_VIEW":
                if (confirm('<%=Translate.JsTranslate("Delete view?")%>'))
                 {
                     if(initID == Id) 
                    {
                        var url = "View/EditView.aspx?ID=" + Id + "&CMD=" + cmd;
                        ///httpRequest.open('POST', url, true);
                        new Ajax.Request( 'View/EditView.aspx', {
                              method:  'post',
                              parameters:  { 'ID': Id,'CMD':cmd},
                              onSuccess:  function(response){
                                parent.document.getElementById('ContentFrame').src='/Admin/Module/DataManagement/Default.aspx';
                              },
                              onFailure:  function(){
                                alert("Wasn't deleted due to the error");
                              }
                            }); 
//                        this.cmd = "LIST_VIEW";
//                        this.initID = 0;
                            //parent.document.getElementById('ContentFrame').src='/Admin/Module/DataManagement/Default.aspx';
                    }
                    else contentFrame.src = "View/EditView.aspx?ID=" + Id + "&CMD=" + cmd;
                    
                }
                break;
            case "TESTVALUES_VIEW":
                contentFrame.src = "ListContent.aspx?ID=" + Id + "&CMD=VIEWS&ChangeTestVars=True";
                break;
            case "ADD_FORM_VIEW":
                contentFrame.src = "Form/EditForm.aspx?CMD=" + cmd;
                break;
            case "ADD_FORM_MANUAL":
                contentFrame.src = "Form/EditForm.aspx?CMD=" + cmd;
                break;
            case "EDIT_FORM":
                contentFrame.src = "Form/EditForm.aspx?ID=" + Id + "&CMD=" + cmd;
                break;
            case "DELETE_FORM":
                if (confirm('<%=Translate.JsTranslate("Delete form?")%>')) {
                    contentFrame.src = "Form/EditForm.aspx?ID=" + Id + "&CMD=" + cmd;
                }  
                break;      
            case "ADD_PUBLISHING":
                contentFrame.src = "Publishing/EditPublishing.aspx?CMD=" + cmd;
                break;
            case "EDIT_PUBLISHING":
            case "DELETE_PUBLISHING":
                contentFrame.src = "Publishing/EditPublishing.aspx?ID=" + Id + "&CMD=" + cmd;
                break;
            default:
                contentFrame.src = "ListContent.aspx?ID=" + Id + "&Name=" + Name + "&CMD=" + cmd;
                break;
        }                
    }    
    </script>

</head>
<body style="height: 100%;">
    <form id="Form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin ID="ModuleAdmin" runat="server">
        <dw:Tree ID="Tree1" runat="server" SubTitle="Settings" Title="Data Lists" ShowRoot="false" openAll="false" useSelection="true" useCookies="true" useLines="true">
            <dw:TreeNode ID="TreeNode1" NodeID="0" runat="server" Name="Root" ParentID="-1" />
        </dw:Tree>
    </dw:ModuleAdmin>
    <input type="hidden" id="InitID" name="InitID" value="0" />
    <input type="hidden" id="CMD" name="CMD" value="" />
    </form>
    
    <dw:Contextmenu ID="ConnectionContext" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="Connection_Add" Text="New connection"
            OnClientClick="ContextmenuClick('ADD_CONNECTION');" />
    </dw:Contextmenu>
    <dw:Contextmenu ID="ConnectionContext_Adv" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="Connection_Add" Text="New connection"
            OnClientClick="ContextmenuClick('ADD_CONNECTION');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="Connection_Edit" Text="Edit connection"
            OnClientClick="ContextmenuClick('EDIT_CONNECTION');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="Connection_Delete" Text="Delete connection"
            OnClientClick="ContextmenuClick('DELETE_CONNECTION');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="Connection_Copy" Text="Copy connection"
            OnClientClick="ContextmenuClick('COPY_CONNECTION');" />
    </dw:Contextmenu>
    
    <dw:Contextmenu ID="ViewContext" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="New data list" OnClientClick="ContextmenuClick('ADD_VIEW');" />
    </dw:Contextmenu>
    <dw:Contextmenu ID="ViewContextDisabled" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="New data list" OnClientClick="alert(txtNoMoreViews);" />
    </dw:Contextmenu>
    <dw:Contextmenu ID="ViewContext_Adv" runat="server">
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="New data list" OnClientClick="ContextmenuClick('ADD_VIEW');" />
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Edit" Text="Edit data list" OnClientClick="ContextmenuClick('EDIT_VIEW');" />
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Delete" Text="Delete data list" OnClientClick="ContextmenuClick('DELETE_VIEW');" />
		<dw:ContextmenuButton runat="server" Divide="None" Image="View_Add" Text="Change test values" OnClientClick="ContextmenuClick('TESTVALUES_VIEW');" />
	</dw:Contextmenu>	

    <dw:Contextmenu ID="FormContext" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="Form_Add" Text="Create form from table"
            OnClientClick="ContextmenuClick('ADD_FORM_VIEW');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="Form_Add" Text="Create form manually"
            OnClientClick="ContextmenuClick('ADD_FORM_MANUAL');" />
    </dw:Contextmenu>
    <dw:Contextmenu ID="FormContext_Adv" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="Form_Edit" Text="Edit form"
            OnClientClick="ContextmenuClick('EDIT_FORM');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="Form_Delete" Text="Delete form"
            OnClientClick="ContextmenuClick('DELETE_FORM');" />
    </dw:Contextmenu>
    
    <dw:Contextmenu ID="PublishingContext" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="TextCode_Add" Text="New publishing"
            OnClientClick="ContextmenuClick('ADD_PUBLISHING');" />
    </dw:Contextmenu>
    <dw:Contextmenu ID="PublishingContext_Adv" runat="server">
        <dw:ContextmenuButton runat="server" Divide="None" Image="TextCode_Add" Text="New publishing"
            OnClientClick="ContextmenuClick('ADD_PUBLISHING');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="TextCode_Edit" Text="Edit publishing"
            OnClientClick="ContextmenuClick('EDIT_PUBLISHING');" />
        <dw:ContextmenuButton runat="server" Divide="None" Image="TextCode_Delete" Text="Delete publishing"
            OnClientClick="ContextmenuClick('DELETE_PUBLISHING');" />
    </dw:Contextmenu>

    <script type="text/javascript">
        //ContentFrameHandler(0, "");
        if (initID.length != 0 && cmd.length != 0) {
            ContentFrameHandler(initID, "", cmd);
        }else{
            try {
                if (t) {
                    if (initID > 0) {
                        // Open to firstID
                        t.openTo(initID);
                        for (i = 0; i < t.aNodes.length; i++) {
                            var node = t.aNodes[i];
                            if (node.id == initID)
                                t.s(i);
                        }
                    } else {
                        // Open selected node
                        for (i = 0; i < t.aNodes.length; i++) {
                            var nodeB = t.aNodes[i];
                            if (nodeB._is) {
                                initID = nodeB.id;
                                break;
                            }
                        }
                    }
                }
            }catch (e) {
            }

            ContentFrameHandler(initID, "");
        }
    </script>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
