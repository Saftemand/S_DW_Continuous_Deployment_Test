<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SurveyAnswerOptionListControl.ascx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyAnswerOptionListControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.BackEnd" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
<script type="text/javascript" language="javascript" src="js/default.js"></script>
<script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
<script type="text/javascript" language="javascript">
//<![CDATA[
    var QuestionID = <%=GetQuestionID()%>;
    function ConfirmSurveyAnswerOptionDelete() {
        var x = $("AnswersList_stretcher").select("[itemid='"+ContextMenu.callingItemID+"']")[0].childElements()[1].innerHTML;
        if(confirm("<%=Translate.JsTranslate("Slet svar mulighed")%> \"" + x + "\" ?"))
          CommandHandler('answerDel');
    }
    function EditAnswer(answer) {
        var x = window.parent.document.getElementById('ActiveSurveyID').value;
        listActions.parentContentFrame().src = 'SurveyAnswerOptionEdit.aspx?SurveyID='+x+'&QuestionID='+QuestionID+'&OptionID=' + answer;
    }

    function CommandHandler(cmd) {
        var x = window.parent.document.getElementById('ActiveSurveyID').value;
        listActions.parentContentFrame().src = 'Shared_Handler.ashx?cmd='+cmd+'&arg='+ContextMenu.callingItemID+'&surveyId='+x+'&questionId='+QuestionID;
    }
//]]>
</script>
    <dw:List ID="AnswersList" runat="server" ContextMenuID="AnswerContextMenu" Title="" TranslateTitle="false" StretchContent="true"
            UseCountForPaging="true" HandlePagingManually="true" PageSize="25">
            <Columns>
                <dw:ListColumn ID="ListColumn0" EnableSorting="false" runat="server" Name="" Width="5">
                </dw:ListColumn>
                <dw:ListColumn ID="AnswerText" EnableSorting="false" runat="server" Name="Text" Width="400">
                </dw:ListColumn>
                <dw:ListColumn ID="isCorrect" EnableSorting="false" runat="server" Name="Correct" Width="100" HeaderAlign="Center" ItemAlign="Center">
                </dw:ListColumn>
            </Columns>
        </dw:List>
    <%--changes for new GUI starts here--%>
<%=Gui.Button(Translate.Translate("Tilføj"), "location='SurveyAnswerOptionEdit.aspx?SurveyID=" & _surveyID.ToString & "&QuestionID=" & _questionID.ToString & "'", 0)%>
    <dw:ContextMenu ID="AnswerContextMenu" runat="server">
        <dw:ContextMenuButton ID="EditAnswer" runat="server" Divide="Before" Image="EditDocument" Text="EditAnswer" OnClientClick="EditAnswer(ContextMenu.callingItemID);" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="MoveUp" runat="server" Divide="Before" Text="Move up" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleUp.png" OnClientClick="CommandHandler('answerU');" >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="MoveDown" runat="server" Divide="After" Text="Move down" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleDown.png" OnClientClick="CommandHandler('answerD');"  >
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ToggleCorrectness" runat="server" Divide="None"  Image="Check" Text="Toggle activation" OnClientClick="CommandHandler('answerC');" >
        </dw:ContextMenuButton>
       <%-- <dw:ContextMenuButton ID="SetIncorrect" runat="server" Divide="None" Text="Set incorrect" OnClientClick=""  >
        </dw:ContextMenuButton>--%>
        <dw:ContextMenuButton ID="DeleteAnswer" runat="server" Divide="Before" Image="DeleteDocument" Text="Delete answer" OnClientClick="ConfirmSurveyAnswerOptionDelete();" >
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <%--end of changes for new GUI--%>
<%
Translate.GetEditOnlineScript()
%>