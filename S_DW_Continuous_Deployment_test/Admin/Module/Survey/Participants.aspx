<%@ Register TagPrefix="pc" TagName="column" Src="ColumnControl.ascx"%>
<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Participants.aspx.vb" Inherits="Dynamicweb.Admin.Survey.Participants" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HEAD>
</HEAD>
<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
	<form id="Form1" method="post" runat="server">
		<table cellpadding="0" cellspacing="0" border="0" class="clean" width="100%">
			<tr bgColor="#ece9d8" height="20">
				<pc:column id="_colName" runat="server" width="20%" sortindex="0"></pc:column>
				<pc:column id="_colEmail" runat="server" width="30%" sortindex="1"></pc:column>
				<pc:column id="_colAddress" runat="server" sortindex="2"></pc:column>
			</tr>
			<tr>
				<td colspan="3" bgColor='#ece9d8'><pc:pager id="_pager1" runat="server" PageUrl="Participants.aspx"></pc:pager></td>
			</tr>
			<asp:Repeater id="_list" runat="server">
				<ItemTemplate>
					<tr>
						<td width="20%">
							<a href="ParticipantStatistic.aspx?participantID=
								<%# DataBinder.Eval(Container.DataItem, "ParticipantID") %>&SurveyID=<%=_surveyID %>">
								<%# DataBinder.Eval(Container.DataItem, "Name") %></a>							
						</td>
						<td width="30%">
							<%# DataBinder.Eval(Container.DataItem, "Email") %>
						</td>
						<td width="50%">
							<%# DataBinder.Eval(Container.DataItem, "Address") %>
						</td>
					</tr>
				</ItemTemplate>
			</asp:Repeater>
			<tr>
				<td colspan="3" bgColor='#ece9d8'><pc:pager id="_pager2" runat="server" PageUrl="Participants.aspx"></pc:pager></td>
			</tr>
		</table>
		<%Translate.GetEditOnlineScript()%>
	</form>
</div>
