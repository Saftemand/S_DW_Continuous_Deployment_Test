
var menuActions = {

    contentFrame: function () {
        return document.getElementById("ContentFrame");
    },

    newQuestion: function () {
        var node = window.t.getNodeByID(ContextMenu.callingID);
        menuActions.contentFrame().src = "SurveyQuestionEdit.aspx?surveyid=" + node.id;
    },

    deleteQuestion: function () {
        var questionID = ContextMenu.callingID;
        var tree = window.t;
        var node = tree.getNodeByID(parseInt(questionID));
        var parentNode = tree.getNodeByID(node.pid);
        var confirmMessage = "Delete survey question -' " + node.name + " '?";
        ret = confirm(confirmMessage);
        if (ret) {
            tree.removeNode(node._ai);
            tree.ajax_loadNodes(parentNode._ai, true);
            var questionsDB_ID = questionID % 100000;
            var surveyID = parseInt(questionID / 100000);
            menuActions.contentFrame().src = "SurveyQuestionEdit.aspx?delete=1&QuestionID=" + questionsDB_ID + "&SurveyID=" + surveyID;
        }
    },

    editQuestion: function () {
        var x = ContextMenu.callingID % 100000;
        var y = parseInt(ContextMenu.callingID / 100000);
        document.getElementById("ActiveSurveyID").value = y;
        menuActions.contentFrame().src = 'SurveyQuestionEdit.aspx?QuestionID=' + x;
    },

    callNewSurvey: function () {
        menuActions.contentFrame().src = "SurveyEdit.aspx";
    },

    deleteSurvey: function () {
        var surveyId = ContextMenu.callingID;
        var node = window.t.getNodeByID(surveyId);
        var confirmMessage = "Delete ( " + node.name + " ) survey?\n\nWARNING!\nAll questions in the survey will be deleted!";
        if (confirm(confirmMessage)) {

            window.document.getElementById("ActiveSurveyID").value = UnsetActiveSurveyValue;
            window.t.removeNode(node._ai);
            window.t.ajax_loadNodes(0, true);
            menuActions.contentFrame().src = "SurveyEdit.aspx?delete=1&SurveyID=" + surveyId;
        }
    },

    callStatistics: function () {
        var surveyId = ContextMenu.callingID;
        if (surveyId != UnsetActiveSurveyValue) {
            document.getElementById("ActiveSurveyID").value = surveyId;
            menuActions.contentFrame().src = "Statistics.aspx?surveyid=" + surveyId;
        }
        else
            return false;
    },

    editSurvey: function () {
        menuActions.contentFrame().src = 'SurveyEdit.aspx?SurveyID=' + ContextMenu.callingID + '&editSurvey=true';
    },

    handleSurveyClick: function (node) {
        document.getElementById("ActiveSurveyID").value = node;
        menuActions.contentFrame().src = "SurveyQuestion_List.aspx?SurveyID=" + node + "";
    },

    handleQuestionClick: function (node) {
        // window.parent.document.getElementById("ActiveSurveyID").value = node;UnsetActiveSurveyValue
        document.getElementById("ActiveSurveyID").value = node;
        menuActions.contentFrame().src = "SurveyQuestionEdit.aspx?QuestionID=" + node + "";
    },

    listSurveys: function () {
        menuActions.contentFrame().src = "Survey_List.aspx";
    }

}
