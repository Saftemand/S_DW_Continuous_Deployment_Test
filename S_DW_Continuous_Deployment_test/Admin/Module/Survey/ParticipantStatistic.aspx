<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ParticipantStatistic.aspx.vb" Inherits="Dynamicweb.Admin.Survey.ParticipantStatistic" %>
<%@ Register TagPrefix="pc" TagName="column" Src="ColumnControl.ascx"%>
<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HEAD>
</HEAD>
<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
		<form id="Form1" method="post" runat="server">
			<table cellpadding="0" cellspacing="0" border="0" class="clean" width="100%">
				<tr bgColor="#ece9d8" height="20">
					<pc:column id="_colQuestion" runat="server" width="40%" sortindex="0" title="<%=%>"></pc:column>
					<pc:column id="_colAnswer" runat="server" sortindex="1" title="<%=%>"></pc:column>
					<pc:column id="_colCorrect" runat="server" width="10%" sortindex="2" title="<%=%>"></pc:column>
				</tr>
				<tr>
					<td colspan="3" bgColor='#ece9d8'><pc:pager id="_pager1" runat="server" PageUrl="ParticipantStatistic.aspx"></pc:pager></td>
				</tr>
				<asp:Repeater id="_list" runat="server">
					<ItemTemplate>
						<tr>
							<td width="40%" valign="top">
								<%# DataBinder.Eval(Container.DataItem, "QuestionText")%>
							</td>
							<td>
								<%# DataBinder.Eval(Container.DataItem, "AnswerText") %>
							</td>
							<td>
								<%# DataBinder.Eval(Container.DataItem, "CorrectImage") %>
							</td>
						</tr>
					</ItemTemplate>
					<AlternatingItemTemplate>
						<tr bgColor='#eeeeee'>
							<td width="40%" valign="top">
								<%# DataBinder.Eval(Container.DataItem, "QuestionText")%>
							</td>
							<td>
								<%# DataBinder.Eval(Container.DataItem, "AnswerText") %>
							</td>
							<td>
								<%# DataBinder.Eval(Container.DataItem, "CorrectImage") %>
							</td>
						</tr>
					</AlternatingItemTemplate>
				</asp:Repeater>
				<tr>
					<td colspan="3" bgColor='#ece9d8'><pc:pager id="_pager2" runat="server" PageUrl="ParticipantStatistic.aspx"></pc:pager></td>
				</tr>
			</table>
		</form>
	</div>
<%
Translate.GetEditOnlineScript()
%>
