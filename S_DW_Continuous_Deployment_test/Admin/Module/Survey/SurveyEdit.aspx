<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="pc" Namespace="Dynamicweb.Admin.Survey" Assembly="Dynamicweb.Admin"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SurveyEdit.aspx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyEdit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Survey Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true"></dw:ControlResources>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script type="text/javascript" language="javascript" src="js/default.js"></script>
		<script type="text/javascript" language="javascript" src="js/surveyList.js"></script>
		<script type="text/javascript" language="javascript"  src="js/Survey.js"></script>
		<script type="text/javascript">
			function Validate() {
				if (typeof (Page_ClientValidate) == 'function') {
					Page_ClientValidate();
			   }
			}
			function changeType(elm)
			{
				var ind = elm.selectedIndex;
				var obj = document.getElementById('tIp');
				var obj1 = document.getElementById('tCookie');
				if (ind < 2) 
				{
					obj.style.display = 'block';
					obj1.style.display = 'block';
				}
				else
				{
					obj.style.display = 'none';
					obj1.style.display = 'none';
				}
			}
			function OnChangeImmediately()
			{
				var chk = document.getElementById("chkDisplayImmediately");
				var cell = document.getElementById("cellSeparate");
				if (chk && cell)
					cell.style.display = chk.checked ? "" : "none";
			}
			function AddNode() {
				var surv = '<%=_surveyID %>';
				if(surv!='0')
				{
					window.parent.document.getElementById("AddedSurvey").value = surv;
					window.parent.document.getElementById("AddedSurveyText").value = document.getElementById("txName").value;                      
				}
				else
				window.parent.document.getElementById("AddedSurvey").value = '-1';
			}

			 function help() {
				<%=Gui.Help("Survey", "modules.survey.general")%>
			}

		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
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
				<div style="margin-left:1px;height:15px;">
					<%=GetBreadcrumb() %>
				</div>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("survey")), "Survey", "all")%>
	    		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="570">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SurveyInfo" title="Resume" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="NameLabel" runat="server" Text="Navn"></dw:translatelabel></td>
									<td><asp:TextBox ID="txName" MaxLength="255" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="NameValidator" ControlToValidate="txName" Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="DescriptionLabel" runat="server" Text="Beskrivelse"></dw:translatelabel></td>
									<td><asp:TextBox ID="txDescription" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="DescriptionValidator" ControlToValidate="txDescription" Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SurveyInfoEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SurveyPage" title="Survey tekst" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="IntroLabel" runat="server" Text="Intro"></dw:translatelabel></td>
									<td><asp:TextBox ID="txIntro" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="FinishLabel" runat="server" Text="Afsluttende tekst"></dw:translatelabel></td>
									<td><asp:TextBox ID="txFinishText" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="OutTimeLabel" runat="server" Text="Tekst for udløbet tid"></dw:translatelabel></td>
									<td><asp:TextBox ID="txOutTimeText" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SurveyPageEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SurveyDisplay" title="Vis resultat" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td colspan=3>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="DisplayImmediatelyLabel" runat="server" Text="Med det samme"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkDisplayImmediately" Runat="server" onclick="OnChangeImmediately()"></asp:CheckBox></td>
									<td id="cellSeparate" runat="server">
										<asp:CheckBox ID="chkDisplaySeparate" Runat="server"></asp:CheckBox>
										<dw:translatelabel id="DisplaySeparateLabel" runat="server" Text="På en seperat side"></dw:translatelabel>
									</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="DisplayAtCompletionLabel" runat="server" Text="Ved færdiggørelse"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkDisplayAtCompletion" Runat="server" ></asp:CheckBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan=3>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SurveyDisplayEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SurveyActive" title="Survey aktiv" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="ActiveLabel" runat="server" Text="Aktiv"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkActive" Runat="server"></asp:CheckBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="ActiveFromLabel" runat="server" Text="Aktiv fra"></dw:translatelabel></td>
									<td><pc:dateselector id="ActiveFromCtrl" runat="server"></pc:dateselector></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="ActiveToLabel" runat="server" Text="Aktiv til"></dw:translatelabel></td>
									<td><pc:dateselector id="ActiveToCtrl" runat="server"></pc:dateselector></td>
									<td><asp:CompareValidator ID="ActiveDateValidator" ControlToValidate="ActiveToCtrl" ControlToCompare="ActiveFromCtrl"
											Type="String" Operator="GreaterThanEqual" EnableClientScript="false" Runat="server"></asp:CompareValidator>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SurveyActiveEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="SurveySettings" title="Survey indstillinger" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="MaxAmountTimeLabel" runat="server" Text="Max tid (minutter)"></dw:translatelabel></td>
									<td><asp:TextBox ID="txMaxAmountTime" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="MinAmountCorrectLabel" runat="server" Text="Min. korrekt antal"></dw:translatelabel></td>
									<td><asp:TextBox ID="txMinAmountCorrect" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="ScoreLabel" runat="server" Text="Score"></dw:translatelabel></td>
									<td><asp:TextBox ID="txScore" CssClass="std" Runat="server"></asp:TextBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="AuthTypeLabel" runat="server" Text="Login"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstType" CssClass="std" Runat="server"></asp:DropDownList></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="AllowRetryLabel" runat="server" Text="Tillad nyt forsøg"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkAllowRetry" Runat="server"></asp:CheckBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="tIp" style="display:<%if lstType.SelectedIndex<2 then%>block<%else%>none<%end if%>">
									<td>&nbsp;<dw:translatelabel id="CheckIpLabel" runat="server" Text="Check IP"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkIp" Runat="server"></asp:CheckBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr id="tCookie" style="display:<%if lstType.SelectedIndex<2 then%>block<%else%>none<%end if%>">
									<td>&nbsp;<dw:translatelabel id="CheckCookieLabel" runat="server" Text="Check cookie"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkCookie" Runat="server"></asp:CheckBox></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SurveySettingsEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Validate(); if (ValidatorOnSubmit()){  AddNode(); return true; } ;"
											value="OK"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Survey_List.aspx'", 0)%></td>
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
		</body>
	</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
