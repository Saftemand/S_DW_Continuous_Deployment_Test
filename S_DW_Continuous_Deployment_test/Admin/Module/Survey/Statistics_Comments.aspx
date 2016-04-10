<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Statistics_Comments.aspx.vb" Inherits="Dynamicweb.Admin.Survey.Statistics_Comments" %>
<%@ Register TagPrefix="pc" TagName="pager" Src="PagerControl.ascx"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HEAD>
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
</HEAD>
<div style="OVERFLOW-X: hidden; OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
	<table cellpadding="0" cellspacing="0" border="0" class="clean" width="100%">
		<tr bgColor="#ece9d8" height="20">
			<td background="/Admin/images/HeaderBG.gif">
				&nbsp;<strong><%=Translate.Translate("Kommentar")%></strong>
			</td>
		</tr>
		<tr>
			<td bgColor='#ece9d8'><pc:pager id="_pager1" runat="server"></pc:pager></td>
		</tr>
		<asp:Repeater id="_comments" runat="server">
			<ItemTemplate>
				<tr>
					<td> <%# DataBinder.Eval(Container.DataItem, "Name") %></td>
				</tr>
			</ItemTemplate>
			<SeparatorTemplate>
				<tr>
					<td bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
				</tr>
			</SeparatorTemplate>
		</asp:Repeater>
		<tr>
			<td bgColor='#ece9d8'>&nbsp;<pc:pager id="_pager2" runat="server"></pc:pager></td>
		</tr>
	</table>
</div>
<%
Translate.GetEditOnlineScript()
%>
