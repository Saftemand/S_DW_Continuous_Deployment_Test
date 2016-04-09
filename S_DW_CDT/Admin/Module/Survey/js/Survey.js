//Events
var EditSelect = 1;
var DeleteSelect = 2;
var NewSurveySelect = 3;
var NewQuestionSelect = 4;
var GetParticipantsSelect = 5;
var GetStatisticsSelect = 6;
var SurveySelect = 7;
var QuestionSelect = 8;

var EntityTypeSurvey = 1;
var EntityTypeQuestion = 2;

var UnsetActiveSurveyValue = 0;

document.oncontextmenu= function(){return false}
var mevent;



function UnsetActiveSurvey()
{	
	parent.document.getElementById("StatisticsDisable").style.display = "";
	parent.document.getElementById("NewQuestionDisable").style.display = "";
	parent.document.getElementById("StatisticsEnable").style.display = "none";
	parent.document.getElementById("NewQuestionEnable").style.display = "none";	
	parent.document.getElementById("ActiveSurveyID").value = UnsetActiveSurveyValue;
}

function SetActiveSurvey(surveyID)
{
	parent.document.getElementById("ActiveSurveyID").value = surveyID;
	parent.document.getElementById("StatisticsDisable").style.display = "none";
	parent.document.getElementById("NewQuestionDisable").style.display = "none";
	parent.document.getElementById("StatisticsEnable").style.display = "";
	parent.document.getElementById("NewQuestionEnable").style.display = "";
}

function DoOnEvent(entityId,entityType,action,nodeId)
{
	//ObjContextMenu.hideNow();	
	DoOnAction(entityId,entityType,action,nodeId)
}	

function DoOnAction(entityId,entityType,action,nodeId)
{
	UnsetActiveSurvey();
	switch(action)
	{
	case GetStatisticsSelect:		
		OnGetStatisticsSelect(entityId);
		break; 
	case GetParticipantsSelect:		
		OnGetParticipantsSelect(entityId);	   
		break; 
	case EditSelect:		
		switch(entityType)
		{
			case EntityTypeSurvey: 				
				OnSurveyEditSelect(entityId);
				break;
			case EntityTypeQuestion: 				
				OnQuestionEditSelect(entityId);
		}				
		break;
	case DeleteSelect:
		switch(entityType)
		{
			case EntityTypeSurvey: 
				OnSurveyDeleteSelect(entityId,nodeId);break;
			case EntityTypeQuestion: OnQuestionDeleteSelect(entityId,nodeId);
		}		
		break;
	case SurveySelect:			
		OnSurveySelect(entityId);			
		break;
	case QuestionSelect:		
		OnQuestionSelect(entityId);		
		break;
	case NewSurveySelect:
		OnNewSurveySelect();
		break;	
	case NewQuestionSelect:
		OnNewQuestionSelect(entityId);
		break;
	}
}

function OnNewQuestionSelect(surveyId)
{
	parent.Survey_Content.location.href = "SurveyQuestionEdit.aspx?surveyid=" + surveyId;
}

function OnNewSurveySelect()
{
	parent.Survey_Content.location.href = "SurveyEdit.aspx";
}

function OnGetStatisticsSelect(surveyId)
{	
	SetActiveSurvey(surveyId);
	parent.Survey_Content.location.href = "Statistics.aspx?surveyid=" + surveyId;
}	

function OnSurveyEditSelect(surveyId)
{	
	SetActiveSurvey(surveyId);
	parent.Survey_Content.location.href = "SurveyEdit.aspx?SurveyID=" + surveyId;
}

function OnSurveyDeleteSelect(surveyId,nodeId)
{
	var entityName = document.getElementById("NodeName" + nodeId).value;
	if (confirm('Delete survey ' + entityName + '?'))
	{
		parent.Survey_Content.location.href = "SurveyEdit.aspx?delete=1&SurveyID=" + surveyId;
	}
	var nextEntityId = document.getElementById("NextEntityIdOnDelete" + nodeId).value;
	var nextEntityType = document.getElementById("NextEntityTypeOnDelete" + nodeId).value;	
}

function OnQuestionEditSelect(questId)
{
	parent.Survey_Content.location.href = "SurveyQuestionEdit.aspx?QuestionID=" + questId;
}

function OnQuestionDeleteSelect(questId,nodeId)
{
	var entityName = document.getElementById("NodeName" + nodeId).value;
	if (confirm('Delete question ' + entityName + '?'))
	{
		parent.Survey_Content.location.href = "SurveyQuestionEdit.aspx?delete=1&QuestionID=" + questId;
	}
	var nextEntityId = document.getElementById("NextEntityIdOnDelete" + nodeId).value;
	var nextEntityType = document.getElementById("NextEntityTypeOnDelete" + nodeId).value;
}


//New rewriten function
function OnQuestionSelect(node)
{
    surveyId = UnsetActiveSurveyValue
    window.Survey_Content.location.href = "SurveyQuestionEdit.aspx?QuestionID=" + node + "";
    Toolbar.setButtonIsDisabled("tbNewQuestion", true);
    Toolbar.setButtonIsDisabled("tbStatistics", true);
}

//New rewriten function
function OnSurveySelect(node)
{
//    document.getElementById("ActiveSurveyID").value = node;
//    Toolbar.setButtonIsDisabled("tbNewQuestion", false);
//    Toolbar.setButtonIsDisabled("tbStatistics", false);
    window.Survey_Content.location.href = "SurveyQuestion_List.aspx?SurveyID=" + node + "";
}

function OnGetParticipantsSelect(surveyId)
{
	SetActiveSurvey(surveyId);
	parent.Survey_Content.location.href = "Participants.aspx?surveyid=" + surveyId;
}


// Objects
//var ObjTree = new Tree();
//var ObjContextMenu = new ContextMenu();
var ActiveSurvey;