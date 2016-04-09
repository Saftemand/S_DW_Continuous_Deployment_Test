
var listActions = {

    parentContentFrame: function () {
        return window.parent.document.getElementById("ContentFrame");
    },

    home: function () {
        listActions.parentContentFrame().src = "Survey_List.aspx";
    },

    newQuestion: function () {
        listActions.parentContentFrame().src = "SurveyQuestionEdit.aspx?surveyid=" + window.parent.document.getElementById("ActiveSurveyID").value;
    },

    newQuestionFromSurveyList: function () {
        if (ContextMenu.callingItemID != null) {
            listActions.parentContentFrame().src = "SurveyQuestionEdit.aspx?surveyid=" + ContextMenu.callingItemID;
            window.parent.document.getElementById("ActiveSurveyID").value = ContextMenu.callingItemID;
        }
        else
            listActions.parentContentFrame().src = "SurveyQuestionEdit.aspx?surveyid=" + window.parent.document.getElementById("ActiveSurveyID").value;
    },

    editQuestion: function () {
        //        var x = ContextMenu.callingID % 100000;
        //        var y = parseInt(ContextMenu.callingID / 100000);
        //        window.parent.document.getElementById("ActiveSurveyID").value = y;
        listActions.parentContentFrame().src = 'SurveyQuestionEdit.aspx?QuestionID=' + ContextMenu.callingItemID; //x
    },

    deleteQuestion: function () {
        var questionID = ContextMenu.callingItemID;
        var tree = window.parent.t;
        var active_survey = window.parent.document.getElementById("ActiveSurveyID").value;
        var parentNode = tree.getNodeByID(active_survey);
        var num = parseInt(active_survey) * 100000 + parseInt(questionID);
        var node2 = tree.getNodeByID(num);
        var confirmMessage = "Delete survey question -' " + node2.name + " '?";
        ret = confirm(confirmMessage);
        if (ret) {
            tree.removeNode(node2._ai);
            tree.ajax_loadNodes(parentNode._ai, true);
            listActions.parentContentFrame().src = "SurveyQuestionEdit.aspx?delete=1&QuestionID=" + questionID;
        }
    },

    handleQuestionClick: function (node) {
        listActions.parentContentFrame().src = "SurveyQuestionEdit.aspx?QuestionID=" + node + "";
    },

    callNewSurvey: function () {
        listActions.parentContentFrame().src = "SurveyEdit.aspx";
    },

    deleteSurvey: function () {
        var surveyId = ContextMenu.callingItemID;
        var node = window.parent.t.getNodeByID(surveyId);
        var confirmMessage = "Delete ( " + node.name + " ) survey?\n\nWARNING!\nAll questions in the survey will be deleted!";
        ret = confirm(confirmMessage);
        if (ret) {
            window.parent.document.getElementById("ActiveSurveyID").value = UnsetActiveSurveyValue;
            window.parent.t.removeNode(node._ai);
            window.parent.t.ajax_loadNodes(0, true);
            listActions.parentContentFrame().src = "SurveyEdit.aspx?delete=1&SurveyID=" + surveyId;

        }
    },

    callStatistics: function () {
        var surveyId = ContextMenu.callingItemID;
        if (surveyId == null) {
            surveyId = window.parent.document.getElementById("ActiveSurveyID").value;
        }
        if (surveyId != UnsetActiveSurveyValue) {
            listActions.parentContentFrame().src = "Statistics.aspx?surveyId=" + surveyId;
        }
        else
            return false;
    },

    editSurvey: function () {
        listActions.parentContentFrame().src = 'SurveyEdit.aspx?SurveyID=' + ContextMenu.callingItemID + '&editSurvey=true';
    },

    showParticipants: function (type) {
        listActions.parentContentFrame().src = "ReportPage.aspx?ReportType=1&AuthorizationType=" + type;
    },

    handleSurveyClick: function (node) {
        window.parent.document.getElementById("ActiveSurveyID").value = node;
        listActions.parentContentFrame().src = "SurveyQuestion_List.aspx?SurveyID=" + node + "";
    },

    commandHandler: function (cmd) {
        var id = window.parent.document.getElementById('ActiveSurveyID').value;
        listActions.parentContentFrame().src = 'Shared_Handler.ashx?cmd=' + cmd + '&arg=' + ContextMenu.callingItemID + '&surveyId=' + id;
    },

    toggleActivation: function () {
        listActions.parentContentFrame().src = 'Shared_Handler.ashx?cmd=survey&arg=' + ContextMenu.callingItemID;
    }
}
