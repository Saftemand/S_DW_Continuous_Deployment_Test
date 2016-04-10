<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Survey_List.aspx.vb" Inherits="Dynamicweb.Admin.Survey.Survey_List" %>
<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Register TagPrefix="pc" TagName="column" Src="ColumnControl.ascx"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SurveysList</title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
    </dw:ControlResources>
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
    <script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
    <script type="text/javascript" language="javascript" src="js/Survey.js" ></script>
    <script type="text/javascript" language="javascript" src="js/surveyTree.js"></script>
    <script type="text/javascript">
     function help() {
		    <%=Gui.Help("Survey", "modules.survey.general")%>
	    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dw:Toolbar ID="SurveyToolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="tbNewSurvey" runat="server" OnClientClick="listActions.callNewSurvey();" Image="AddDocument" Text="Ny survey">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbExtranetParticipants" runat="server" OnClientClick="listActions.showParticipants(2);" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Extranet participants">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbEmailParticipants" runat="server" OnClientClick="listActions.showParticipants(1);"  ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Email participants" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Hjælp">
            </dw:ToolbarButton>
        </dw:Toolbar>
        <div class="list">
            <table width="100%" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <%=GetBreadcrumb() %>
                    </td>
                </tr>
            </table>
        </div>
        <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
            <dw:List ID="SurveyList" runat="server" Title="" ShowTitle="false" TranslateTitle="false" StretchContent="true"
                UseCountForPaging="true" HandlePagingManually="true" PageSize="25" >
                <Filters>
                    <dw:ListTextFilter runat="server" ID="TextSurveyFilter" WaterMarkText="Search" Width="175"
                        ShowSubmitButton="True" Divide="None" Priority="1" />
                    <dw:ListDropDownListFilter ID="PageSizeFilter1" Width="150" Label="Surveys per page"
                        AutoPostBack="true" Priority="2" runat="server">
                        <Items>
                            <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                            <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                            <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                            <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                            <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                        </Items>
                    </dw:ListDropDownListFilter>
                </Filters>
                <Columns>
                    <dw:ListColumn ID="sListColumn0" EnableSorting="false" runat="server" Name="" Width="5">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sName" EnableSorting="true" runat="server" Name="Name" Width="400">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sModifiedOn" EnableSorting="true" runat="server" Name="Modified" HeaderAlign="Center" ItemAlign="Center" Width="150">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sIsActive" EnableSorting="true" runat="server" Name="Active" HeaderAlign="Center" ItemAlign="Center" Width="60">
                    </dw:ListColumn>
                </Columns>
            </dw:List>
        </dw:StretchedContainer>
        <dw:ContextMenu ID="SurveyContextMenu" runat="server">
            <dw:ContextMenuButton ID="NewQuestion" runat="server" Divide="After" Image="AddDocument" Text="New Question" OnClientClick="listActions.newQuestionFromSurveyList();" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="lEditSurvey" runat="server" Divide="None" Image="EditDocument" Text="Edit survey" OnClientClick="listActions.editSurvey();" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="lToggleActivity" runat="server" Divide="None" Image="Check" Text="Toggle activation" OnClientClick="listActions.toggleActivation();" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="lStatistics" runat="server" Divide="Before" Image="PieChart" Text="Show statistics" OnClientClick="listActions.callStatistics();" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="lDeleteSurvey" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete survey" OnClientClick="listActions.deleteSurvey();" >
            </dw:ContextMenuButton>
        </dw:ContextMenu>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>

