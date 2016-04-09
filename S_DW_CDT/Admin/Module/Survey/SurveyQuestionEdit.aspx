<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="ac" TagName="optionlist" Src="SurveyAnswerOptionListControl.ascx"%>
<%@ Register TagPrefix="ic" TagName="item" Src="SurveyInstruction.ascx"%>
<%@ Register TagPrefix="pc" Namespace="Dynamicweb.Admin.Survey" Assembly="Dynamicweb.Admin"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="SurveyQuestionEdit.aspx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyQuestionEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Survey Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
		<link href="/Admin/Stylesheet.css" type="text/css" >
		<script type="text/javascript" language="javascript" src="js/default.js"></script>
		<script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
		<script type="text/javascript" language="javascript" src="js/surveyTree.js"></script>
		<script type="text/javascript" language="javascript" src="js/Survey.js" ></script>
		<script type="text/javascript">
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
			function changeType(elm)
			{
				var ind = elm.selectedIndex;
				var val = elm.options[ind].text;
				var obj = document.getElementById('tDef');
				var obj1 = document.getElementById('tTxt');
				var obj2 = document.getElementById('tTxtCorrect');
				if (val!="DropDown")
					obj.style.display = '';
				else
					obj.style.display = 'none';
				if (val!="DropDown" && val!="TextArea")
				{
					obj1.style.display = '';
					obj2.style.display = '';
				}
				else
				{
					obj1.style.display = 'none';
					obj2.style.display = 'none';
				}
			}
			function OnQuestionTableLoad(){
				var x = document.getElementById("QuestionEditTable");
				x.style.width = 100 + "%";
			}
			 function help() {
				<%=Gui.Help("Survey", "modules.survey.general")%>
			}

		</script>
	</head>
	<body MS_POSITIONING="GridLayout" onload="OnQuestionTableLoad();">

	<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
		<form id="Form1" method="post" runat="server">
			<dw:Toolbar ID="SurveyToolbar" runat="server" ShowEnd="false">
				<dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="listActions.home();" Image="Home" Text="Start" Divide="After">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="tbExtranetParticipants" runat="server" OnClientClick="listActions.showParticipants(2);" ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Extranet participants">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="tbEmailParticipants" runat="server" OnClientClick="listActions.showParticipants(1);"  ImagePath="/Admin/Images/Ribbon/Icons/Small/Users.png" Text="Email participants" Divide="After">
				</dw:ToolbarButton>
				<dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Hjælp">
				</dw:ToolbarButton>
			</dw:Toolbar>
			<div >
				<table width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<%=GetBreadcrumb() %>
						</td>
					</tr>
				</table>
			</div>
			<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("spørgsmål")), Translate.Translate("Spørgsmål"), "all")%>
			<table id="QuestionEditTable" border="0" cellpadding="0" cellspacing="0" class="tabTable" width="100%">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td valign="top">
						<dw:groupboxstart id="QuestionInfo" title="Info" runat="server"></dw:groupboxstart>
						<table cellspacing="0" cellpadding="1" border="0" width="100%">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="TextLabel" runat="server" Text="Tekst"></dw:translatelabel></td>
								<td><asp:TextBox ID="txText" CssClass="std" Runat="server"></asp:TextBox></td>
								<td><asp:RequiredFieldValidator ID="TextValidator" ControlToValidate="txText" Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
							</tr>
							<tr id="tDef" style="display:<%if lstType.SelectedItem.Text.ToLower<>"dropdown" then%><%else%>none<%end if%>">
								<td width="150">&nbsp;<dw:translatelabel id="DefaultLabel" runat="server" Text="Standard værdi"></dw:translatelabel></td>
								<td><asp:TextBox ID="txDefault" MaxLength="255" CssClass="std" Runat="server"></asp:TextBox></td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="TypeLabel" runat="server" Text="Type"></dw:translatelabel></td>
								<td><asp:DropDownList ID="lstType" CssClass="std" Runat="server"></asp:DropDownList></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="MediaLabel" runat="server" Text="Fil"></dw:translatelabel></td>
								<td><%=GetImageButton()%></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td width="150">&nbsp;<dw:translatelabel id="ActiveLabel" runat="server" Text="Aktiv"></dw:translatelabel></td>
								<td><asp:CheckBox ID="chkActive" Runat="server"></asp:CheckBox></td>
								<td>&nbsp;</td>
							</tr>
							<tr id="tTxt" style="display:<%if lstType.SelectedItem.Text.ToLower<>"textarea" and lstType.SelectedItem.Text.ToLower<>"dropdown" then%><%else%>none<%end if%>">
								<td width="150">&nbsp;<dw:translatelabel id="OtherLabel" runat="server" Text="Vis text felt"></dw:translatelabel></td>
								<td><asp:CheckBox ID="chkTxtEnabled" Runat="server"></asp:CheckBox></td>
								<td>&nbsp;</td>
							</tr>
							<tr id="tTxtCorrect"  style="display:<%if lstType.SelectedItem.Text.ToLower<>"textarea" and lstType.SelectedItem.Text.ToLower<>"dropdown" then%><%else%>none<%end if%>">
								<td width="150">&nbsp;<dw:translatelabel id="CorrectLabel" runat="server" Text="Er tekst korrekt"></dw:translatelabel></td>
								<td><asp:CheckBox ID="chkTxtCorrect" Runat="server"></asp:CheckBox></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<dw:groupboxend id="QuestionInfoEnd" runat="server"></dw:groupboxend>
						<ic:item id="Instruction" runat="server"> </ic:item>
                          <dw:groupboxstart id="QuestionAnswers" title="Svar" runat="server"></dw:groupboxstart>
						<ac:optionlist id="AnswerOptionList" runat="server"></ac:optionlist>
						<dw:groupboxend id="QuestionAnswersEnd" title="Spørgsmål" runat="server"></dw:groupboxend>
        				</td>
        		</tr>
				<tr>
					<td>
                  	&nbsp;
                    </td>
				</tr>
				<tr>
					<td align="right" valign="bottom">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Validate(); if (ValidatorOnSubmit()) return true;"
										value="OK"></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location='SurveyQuestion_List.aspx?SurveyID=" & _surveyId.ToString & "'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>		
		</form>
		</div>
	</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
