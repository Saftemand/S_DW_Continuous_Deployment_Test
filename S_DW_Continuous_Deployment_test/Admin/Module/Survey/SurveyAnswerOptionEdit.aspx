<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="SurveyAnswerOptionEdit.aspx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyAnswerOptionEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="pc" Namespace="Dynamicweb.Admin.Survey" Assembly="Dynamicweb.Admin"%>
<%@ Register TagPrefix="ic" TagName="item" Src="SurveyInstruction.ascx"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Survey Edit</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
		</script>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Form1" method="post" runat="server">
    <div style="margin-left:1px;height:15px;">
                                    <%=GetBreadcrumb() %>
                                </div>
				<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("svar mulighed")), "Option", "all")%>
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
					<tr>
						<td>&nbsp;
                              
                     </td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="OptionInfo" title="Resume" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="1" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="TextLabel" runat="server" Text="Tekst"></dw:translatelabel></td>
									<td><asp:TextBox ID="txText" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator Display="Dynamic" ID="TextValidator" ControlToValidate="txText" Runat="server"/></td>
								</tr>
								<tr>
									<td>&nbsp;<dw:translatelabel id="CorrectLabel" runat="server" Text="Korrekt svar"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkCorrect" Runat="server"></asp:CheckBox></td>
									<td><asp:CustomValidator Display="Dynamic" id="CorrectAnswerValidator" OnServerValidate="CorrectAnswerValidation" runat="server"/></td>
								</tr>
							</table>
							<dw:groupboxend id="OptionInfoEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td><ic:item id="Instruction" runat="server"> </ic:item></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Validate(); if (ValidatorOnSubmit()) return true;" value="<%=Translate.Translate("ok")%>"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location='SurveyQuestionEdit.aspx?SurveyID=" & _surveyId.ToString & "&QuestionID=" & _questionId.ToString()  &"'", 0)%></td>
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
</html>
<%
Translate.GetEditOnlineScript()
%>
