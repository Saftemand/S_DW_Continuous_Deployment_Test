<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SurveyQuestion_List.aspx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyQuestion_List" %>
<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Register TagPrefix="pc" TagName="column" Src="ColumnControl.ascx"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>QuestionsList</title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
    <link type="text/css" href="/Admin/Stylesheet.css" />
    <script type="text/javascript" language="javascript" src="js/default.js"></script>
    <script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
    <script type="text/javascript" language="javascript" src="js/surveyTree.js"></script>
    <script type="text/javascript" language="javascript" src="js/Survey.js" ></script>
    <script type="text/javascript">
         function help() {
		    <%=Gui.Help("Survey", "modules.survey.general")%>
	    }
</script>
</head>
<body style="overflow:hidden; ">
    <form id="form2" runat="server">
        <dw:Toolbar ID="SurveyToolbar" runat="server" ShowEnd="false">
            <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="listActions.home();" Image="Home" Text="Start" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbNewSurvey" runat="server" OnClientClick="listActions.callNewSurvey();" Image="AddDocument" Text="Ny survey">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbNewQuestion" runat="server" OnClientClick="listActions.newQuestion();" Image="AddGear" Text="Nyt spørgsmål" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbExtranetParticipants" runat="server" OnClientClick="listActions.showParticipants(2);" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Extranet participants">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbEmailParticipants" runat="server" OnClientClick="listActions.showParticipants(1);"  ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Email participants" Divide="After">
            </dw:ToolbarButton>
            <dw:ToolbarButton ID="tbStatistics" runat="server" OnClientClick="listActions.callStatistics();" Image="PieChart" Text="Statistik" Divide="After">
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
            <dw:List ID="QuestionList" runat="server" Title="" ShowTitle="false" TranslateTitle="false" StretchContent="true"
                UseCountForPaging="true" HandlePagingManually="true" PageSize="25">
                <Filters>
                    <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Questions per page"
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
                    <dw:ListColumn ID="ListColumn0" EnableSorting="false" runat="server" Name="" Width="5">
                    </dw:ListColumn>
                    <dw:ListColumn ID="QuestionText" EnableSorting="true" runat="server" Name="Text" Width="400">
                    </dw:ListColumn>
                    <dw:ListColumn ID="Type" EnableSorting="true" runat="server" Name="Type" Width="200">
                    </dw:ListColumn>
                    <dw:ListColumn ID="isQuestionActive" EnableSorting="true" runat="server" Name="Active">
                    </dw:ListColumn>  
                </Columns>
            </dw:List>
        </dw:StretchedContainer>
        <dw:ContextMenu ID="QuestionContextMenu" runat="server">
            <dw:ContextMenuButton ID="NewQuestion" runat="server" Divide="After" Image="AddDocument" Text="New Question" OnClientClick="listActions.newQuestion();" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="EditQuestion" runat="server" Divide="None" Image="EditDocument" Text="Edit question" OnClientClick="listActions.editQuestion();" >
            </dw:ContextMenuButton>
             <dw:ContextMenuButton ID="MoveUp" runat="server" Divide="Before" Text="Move up" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleUp.png" OnClientClick="listActions.commandHandler('questionU');" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="MoveDown" runat="server" Divide="After" Text="Move down" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleDown.png" OnClientClick="listActions.commandHandler('questionD');" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="ToggleActivity" runat="server" Divide="None" Image="Check" Text="Toggle activation" OnClientClick="listActions.commandHandler('question');" >
            </dw:ContextMenuButton>
            <dw:ContextMenuButton ID="DeleteQuestion" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete question" OnClientClick="listActions.deleteQuestion();" >
            </dw:ContextMenuButton>
        </dw:ContextMenu>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>