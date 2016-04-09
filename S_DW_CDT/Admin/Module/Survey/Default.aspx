<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default_old.aspx.vb" Inherits="Dynamicweb.Admin.Survey._Default" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
    <script type="text/javascript" language="javascript" src="js/Survey.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
    <dw:ModuleAdmin runat="server">
        <dw:Tree ID="SurveysTree" runat="server" SubTitle="Surveys" ContextMenuID="BackgroundMenu" Title="Navigation" ShowRoot="false"
            OpenAll="false" UseSelection="true" UseCookies="false" LoadOnDemand="true" UseLines="true">
            <dw:TreeNode ID="RootNode" NodeID="0" runat="server" Name="Root" ParentID="-1">
            </dw:TreeNode>
        </dw:Tree>
    </dw:ModuleAdmin>
    <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions" ShowClose="true" HidePadding="true" >
        <iframe id="permissionEditDialogIFrame" style="width: 300px; height:240px; overflow:hidden" scrolling="no"></iframe>
    </dw:Dialog>
    <input type="hidden" name="ActiveSurveyID" id="ActiveSurveyID" value="0">
    <input type="hidden" name="AddedSurvey" id="AddedSurvey" value="-2">
    <input type="hidden" name="AddedSurveyText" id="AddedSurveyText" value="0">
    <input type="hidden" name="SurveyWithAddedQuestion" id="SurveyWithAddedQuestion" value="-1">
    </form>

    <dw:ContextMenu ID="SurveyContextMenu1" runat="server">
        <dw:ContextMenuButton ID="NewQuestion" runat="server" Divide="After" Image="AddGear" Text="New Question" OnClientClick="menuActions.newQuestion();" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="lEditSurvey" runat="server" Divide="None" Image="EditDocument" Text="Edit survey" OnClientClick="menuActions.editSurvey();" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="lStatistics" runat="server" Divide="Before" Image="PieChart" Text="Show statistics" OnClientClick="menuActions.callStatistics();" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="lDeleteSurvey" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete survey" OnClientClick="menuActions.deleteSurvey();" > </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="QuestionContextMenu1" runat="server">
        <dw:ContextMenuButton ID="EditQuestion" runat="server" Divide="None" Image="EditDocument" Text="Edit question" OnClientClick="menuActions.editQuestion();" > </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="DeleteQuestion" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete question" OnClientClick="menuActions.deleteQuestion();" > </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="BackgroundMenu" runat="server">
            <dw:ContextMenuButton ID="BNewSurvey" runat="server" Image="AddDocument" Text="New survey" OnClientClick="menuActions.callNewSurvey();" > </dw:ContextMenuButton>
    </dw:ContextMenu>

    <script type="text/javascript" language="javascript">
        menuActions.listSurveys();
    </script>

    <% Translate.GetEditOnlineScript()%>
</body>
</html>
